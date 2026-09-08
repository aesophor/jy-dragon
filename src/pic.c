/* JY sprite archives (.idx + .grp), palette-indexed with per-row RLE.
 *
 * Ported from the original engine:
 *   JY_PicLoadFile     sub_405D60
 *   JY_LoadPic/cache   sub_406030
 *   record decode      sub_406370
 *   CreatePicSurface32 sub_4066C0   <- the RLE loop
 *   JY_PicGetXY        sub_406600
 *
 * Container: the .idx holds offsets 1..N; idx[0] is an implicit 0, so record i
 * spans idx[i]..idx[i+1] of the .grp.
 *
 * Record body is either a raw PNG (the engine sniffs it with IMG_isPNG), or:
 *   int16 w, h, offsetX, offsetY            -- 8-byte header
 *   per row: [byteCount], then repeating [skip][runLen][runLen palette bytes]
 *   x advances by skip then by runLen; the row ends at x >= w or when its
 *   byte budget is spent. byteCount == 0 is a fully transparent row.
 *
 * offsetX/offsetY are an anchor: unless flag bit 0 is set, the draw position
 * has them subtracted (sprites are positioned by their hotspot, which for the
 * 36x18 isometric tiles is bottom-centre).
 */
#include "engine.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MAX_PIC_SLOTS 100 /* the original rejects slot >= 100 */

typedef struct {
    SDL_Surface *surf;
    int          ox, oy;
    bool         tried;
} PicEntry;

typedef struct {
    uint32_t *offs; /* count+1 entries, offs[0] == 0 */
    int       count;
    uint8_t  *grp;
    size_t    grp_len;
    PicEntry *cache; /* count entries */
    int       fit_w, fit_h;
    bool      used;
} PicSlot;

static PicSlot  g_pslot[MAX_PIC_SLOTS];
static uint32_t g_pal32[256];
static bool     g_pal_ok;

/* The .col files are 6-bit VGA channels, so <<2 to reach 8-bit. */
bool jy_pic_set_palette(const char *path) {
    uint8_t raw[768];
    FILE   *f = fopen(path, "rb");
    if (!f) {
        jy_log("PicInit: cannot open palette %s", path);
        return false;
    }
    size_t got = fread(raw, 1, sizeof(raw), f);
    fclose(f);
    if (got != sizeof(raw)) {
        jy_log("PicInit: %s is %zu bytes, expected 768", path, got);
        return false;
    }
    for (int i = 0; i < 256; i++)
        g_pal32[i] = 0xFF000000u | ((uint32_t)(raw[i * 3] << 2) << 16) |
                     ((uint32_t)(raw[i * 3 + 1] << 2) << 8) |
                     (uint32_t)(raw[i * 3 + 2] << 2);
    g_pal_ok = true;
    return true;
}

static uint8_t *slurp(const char *path, size_t *len) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;
    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);
    uint8_t *p = (uint8_t *)malloc((size_t)n ? (size_t)n : 1);
    if (p) *len = fread(p, 1, (size_t)n, f);
    fclose(f);
    return p;
}

static void slot_free(PicSlot *s) {
    if (s->cache) {
        for (int i = 0; i < s->count; i++)
            if (s->cache[i].surf) SDL_DestroySurface(s->cache[i].surf);
        free(s->cache);
    }
    free(s->offs);
    free(s->grp);
    memset(s, 0, sizeof(*s));
}

bool jy_pic_load_file(int slot, const char *idxp, const char *grpp, int w, int h) {
    if (slot < 0 || slot >= MAX_PIC_SLOTS) return false;
    PicSlot *s = &g_pslot[slot];
    slot_free(s);

    size_t   ilen = 0;
    uint8_t *idx  = slurp(idxp, &ilen);
    if (!idx) {
        jy_log("PicLoadFile: idx not open --- %s", idxp);
        return false;
    }
    s->count = (int)(ilen / 4);
    s->offs  = (uint32_t *)calloc((size_t)s->count + 1, sizeof(uint32_t));
    for (int i = 0; i < s->count; i++)
        memcpy(&s->offs[i + 1], idx + (size_t)i * 4, 4); /* offs[0] stays 0 */
    free(idx);

    s->grp = slurp(grpp, &s->grp_len);
    if (!s->grp) {
        jy_log("PicLoadFile: grp not open --- %s", grpp);
        slot_free(s);
        return false;
    }

    s->cache = (PicEntry *)calloc((size_t)s->count, sizeof(PicEntry));
    s->fit_w = w;
    s->fit_h = h;
    s->used  = true;
    jy_log("PicLoadFile: slot %d <- %s (%d records, grp %zu B)", slot, grpp, s->count,
           s->grp_len);
    return true;
}

/* CreatePicSurface32: RLE -> ARGB8888 with a fully transparent background. */
static SDL_Surface *decode_rle(const uint8_t *d, size_t len, int w, int h) {
    SDL_Surface *surf = SDL_CreateSurface(w, h, SDL_PIXELFORMAT_ARGB8888);
    if (!surf) return NULL;
    memset(surf->pixels, 0, (size_t)surf->pitch * h);
    int       pitch = surf->pitch / 4;
    uint32_t *px    = (uint32_t *)surf->pixels;

    size_t p = 0;
    for (int y = 0; y < h && p < len; y++) {
        size_t row_start = p;
        int    count     = d[p++];
        if (!count) continue; /* transparent row */
        int x = 0;
        while (p < len) {
            x += d[p++]; /* transparent skip */
            if (p >= len) break;
            int run = d[p++]; /* opaque run */
            for (int k = 0; k < run && p < len; k++, p++) {
                int px_x = x + k;
                if (px_x >= 0 && px_x < w) px[(size_t)y * pitch + px_x] = g_pal32[d[p]];
            }
            x += run;
            if (x >= w || (int)(p - row_start) >= count) break;
        }
    }
    return surf;
}

static PicEntry *pic_entry(int slot, int index) {
    if (slot < 0 || slot >= MAX_PIC_SLOTS) return NULL;
    PicSlot *s = &g_pslot[slot];
    if (!s->used || index < 0 || index >= s->count) return NULL;

    PicEntry *e = &s->cache[index];
    if (e->tried) return e;
    e->tried = true;

    uint32_t lo = s->offs[index], hi = s->offs[index + 1];
    if (hi > s->grp_len) hi = (uint32_t)s->grp_len;
    if (hi <= lo) return e;
    const uint8_t *rec  = s->grp + lo;
    size_t         rlen = hi - lo;

    if (rlen > 8 && memcmp(rec, "\x89PNG\r\n\x1a\n", 8) == 0) {
        /* Some archives store PNGs directly; the engine sniffs for this too. */
        char tmp[] = "/tmp/jy_pic_XXXXXX";
        int  fd    = mkstemp(tmp);
        if (fd >= 0) {
            FILE *f = fdopen(fd, "wb");
            if (f) {
                fwrite(rec, 1, rlen, f);
                fclose(f);
            }
            e->surf = jy_load_png(tmp);
            remove(tmp);
        }
        if (e->surf) {
            e->ox = e->surf->w / 2;
            e->oy = e->surf->h;
        }
        return e;
    }
    if (rlen < 8 || !g_pal_ok) return e;

    int16_t w, h, ox, oy;
    memcpy(&w, rec + 0, 2);
    memcpy(&h, rec + 2, 2);
    memcpy(&ox, rec + 4, 2);
    memcpy(&oy, rec + 6, 2);
    if (w <= 0 || h <= 0 || w > 4096 || h > 4096) return e;

    e->surf = decode_rle(rec + 8, rlen - 8, w, h);
    e->ox   = ox;
    e->oy   = oy;
    return e;
}

/* PicLoadCache(slot, id, x, y, flags, alpha) -- note index == id / 2 */
void jy_pic_draw(int slot, int id, int x, int y, int flags, int alpha) {
    PicEntry *e = pic_entry(slot, id / 2);
    if (!e || !e->surf) return;
    if (!(flags & 1)) {
        x -= e->ox;
        y -= e->oy;
    }
    SDL_Rect dst = {x, y, e->surf->w, e->surf->h};
    if (alpha > 0 && alpha < 255) {
        SDL_SetSurfaceAlphaMod(e->surf, (Uint8)alpha);
        SDL_SetSurfaceBlendMode(e->surf, SDL_BLENDMODE_BLEND);
    } else {
        SDL_SetSurfaceAlphaMod(e->surf, 255);
    }
    SDL_BlitSurface(e->surf, NULL, g_e.screen, &dst);
}

/* PicGetXY(slot, id) -> w, h, offsetX, offsetY */
void jy_pic_xy(int slot, int id, int *w, int *h, int *ox, int *oy) {
    *w = *h = *ox = *oy = 0;
    PicEntry *e         = pic_entry(slot, id / 2);
    if (!e || !e->surf) return;
    *w  = e->surf->w;
    *h  = e->surf->h;
    *ox = e->ox;
    *oy = e->oy;
}
