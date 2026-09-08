/* World map (大地图) -- ported from sub_404240 (DrawMMap), sub_403F10 (the
 * building collector), sub_403CC0/sub_403D70 (GetMMap).
 *
 * Five separate 480x480 int16 layers, one file each:
 *   0 earth      ground tiles, drawn flat
 *   1 surface    decoration, drawn flat at the same position
 *   2 building   sprite id, stored only at the building's anchor cell
 *   3 buildx     x of the anchor cell this cell belongs to
 *   4 buildy     y of the anchor cell
 *
 * Indexing is row-major with x fastest: index = x + y * width.
 *
 * Buildings can span several cells, so every covered cell points at the anchor
 * via buildx/buildy. Collect unique anchors, then draw each once with the
 * sprite from the building layer at that anchor. The original temporarily
 * writes the player into the building layer so it participates in the same
 * ordering; we just add it to the list instead and sort by depth, which gives
 * the same painter order without mutating the map.
 */
#include "engine.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define MMAP_SLOT 0 /* DrawMMap draws from pic slot 0 (mmap.grp) */
#define NLAYER 5
#define R 40 /* covers 1220x700 at scale 18/9 */

static int16_t *g_layer[NLAYER];
static int      g_w, g_h;
static int      g_xscale = 18, g_yscale = 9;

void jy_mmap_set_scale(int xs, int ys) {
    if (xs > 0) g_xscale = xs;
    if (ys > 0) g_yscale = ys;
}

static int16_t *slurp16(const char *path, size_t want_bytes) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        jy_log("LoadMMap: cannot open %s", path);
        return NULL;
    }
    int16_t *p = (int16_t *)calloc(want_bytes ? want_bytes : 2, 1);
    if (p) fread(p, 1, want_bytes, f);
    fclose(f);
    return p;
}

void jy_mmap_unload(void) {
    for (int i = 0; i < NLAYER; i++) {
        free(g_layer[i]);
        g_layer[i] = NULL;
    }
    g_w = g_h = 0;
}

bool jy_mmap_load(const char *files[NLAYER], int w, int h) {
    jy_mmap_unload();
    g_w         = w;
    g_h         = h;
    size_t want = (size_t)w * h * 2;
    for (int i = 0; i < NLAYER; i++) {
        g_layer[i] = slurp16(files[i], want);
        if (!g_layer[i]) {
            jy_mmap_unload();
            return false;
        }
    }
    jy_log("LoadMMap: %dx%d x%d layers (%zu B each)", w, h, NLAYER, want);
    return true;
}

int jy_get_mmap(int x, int y, int layer) {
    if (layer < 0 || layer >= NLAYER || !g_layer[layer]) return 0;
    if (x < 0 || y < 0 || x >= g_w || y >= g_h) return 0;
    return g_layer[layer][(size_t)y * g_w + x];
}

/* deferred building/player list */
typedef struct {
    int x, y, pic;
} Anchor;

static int cmp_depth(const void *a, const void *b) {
    const Anchor *p = (const Anchor *)a, *q = (const Anchor *)b;
    int           da = p->x + p->y, db = q->x + q->y;
    if (da != db) return da - db;
    return p->x - q->x;
}

void jy_draw_mmap(int px, int py, int mypic) {
    const int cx = g_e.w / 2, cy = g_e.h / 2;

    /* Same reasoning as jy_draw_smap: this is a background redraw, so start
     * from a known state. The 480x480 world map normally covers the window, so
     * this is usually invisible -- but it costs nothing and removes a class of
     * stale-pixel bug near the map edges. */
    jy_fill_rect(g_e.clip.x, g_e.clip.y, g_e.clip.x + g_e.clip.w - 1,
                 g_e.clip.y + g_e.clip.h - 1, 0x000000, 255);

    /* pass 1: earth + surface, drawn flat */
    for (int i = -R; i <= R; i++) {
        for (int j = -R; j <= R; j++) {
            int sx = cx + g_xscale * (i - j);
            int sy = cy + g_yscale * (i + j);
            if (sx < -64 || sx > g_e.w + 64 || sy < -64 || sy > g_e.h + 64) continue;
            int mx = px + i, my = py + j;
            int e = jy_get_mmap(mx, my, 0);
            if (e > 0) jy_pic_draw(MMAP_SLOT, e, sx, sy, 0, 0);
            int s = jy_get_mmap(mx, my, 1);
            if (s > 0) jy_pic_draw(MMAP_SLOT, s, sx, sy, 0, 0);
        }
    }

    /* pass 2: collect unique building anchors over the visible range */
    static Anchor list[(2 * R + 1) * (2 * R + 1) + 1];
    int           n = 0;
    for (int i = -R; i <= R; i++) {
        for (int j = -R; j <= R; j++) {
            int mx = px + i, my = py + j;
            int bx = jy_get_mmap(mx, my, 3);
            int by = jy_get_mmap(mx, my, 4);
            if (!bx || !by) continue;
            int seen = 0;
            for (int k = 0; k < n; k++)
                if (list[k].x == bx && list[k].y == by) {
                    seen = 1;
                    break;
                }
            if (seen) continue;
            int pic = jy_get_mmap(bx, by, 2);
            if (pic > 0 && n < (int)(sizeof list / sizeof list[0]) - 1)
                list[n++] = (Anchor){bx, by, pic};
        }
    }
    /* the player rides in the same list so it sorts against the buildings */
    if (mypic > 0 && n < (int)(sizeof list / sizeof list[0]))
        list[n++] = (Anchor){px, py, 2 * mypic};

    qsort(list, (size_t)n, sizeof list[0], cmp_depth);

    for (int k = 0; k < n; k++) {
        int i = list[k].x - px, j = list[k].y - py;
        int sx = cx + g_xscale * (i - j);
        int sy = cy + g_yscale * (i + j);
        if (sx < -256 || sx > g_e.w + 256 || sy < -256 || sy > g_e.h + 256) continue;
        jy_pic_draw(MMAP_SLOT, list[k].pic, sx, sy, 0, 0);
    }
}
