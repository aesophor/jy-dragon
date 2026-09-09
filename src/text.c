/* Text rendering.
 *
 * The original used SDL_ttf's TTF_RenderUNICODE_* (a FreeType wrapper), fed
 * UCS-2 that the engine produced from the game's native charset. We do the
 * same thing directly: iconv to UCS-2, then FreeType to raster.
 *
 * Charsets (see _re/data_formats.md): script literals are GBK, data-file text
 * is Big5. lib.CharSet(s,0) converts Big5 data into GBK, so strings reaching
 * DrawStr are GBK when CC.SrcCharSet==0 (CONFIG.CharSet 0=简体, 1=繁体).
 */
#include "engine.h"
#include <ft2build.h>
#include FT_FREETYPE_H
#include <iconv.h>
#include "s2t_table.h"
#include <string.h>
#include <stdlib.h>

static FT_Library g_ft;
static bool       g_ft_ok;

/* one cached face per (path,size) - the game only uses a couple of sizes */
#define MAX_FACES 8
typedef struct {
    char    path[512];
    int     size;
    FT_Face face;
} FaceSlot;
static FaceSlot g_faces[MAX_FACES];
static int      g_nfaces;

bool jy_text_init(void) {
    if (FT_Init_FreeType(&g_ft)) {
        jy_log("FreeType init failed");
        return false;
    }
    g_ft_ok = true;
    return true;
}

void jy_text_shutdown(void) {
    for (int i = 0; i < g_nfaces; i++)
        if (g_faces[i].face) FT_Done_Face(g_faces[i].face);
    g_nfaces = 0;
    if (g_ft_ok) FT_Done_FreeType(g_ft);
    g_ft_ok = false;
}

static FT_Face get_face(const char *path, int size) {
    for (int i = 0; i < g_nfaces; i++)
        if (g_faces[i].size == size && strcmp(g_faces[i].path, path) == 0)
            return g_faces[i].face;
    if (g_nfaces >= MAX_FACES) return g_faces[0].face;

    FT_Face f = NULL;
    if (FT_New_Face(g_ft, path, 0, &f)) {
        jy_log("DrawStr: cannot open font %s", path);
        return NULL;
    }
    FT_Set_Pixel_Sizes(f, 0, (FT_UInt)size);
    FaceSlot *s = &g_faces[g_nfaces++];
    snprintf(s->path, sizeof(s->path), "%s", path);
    s->size = size;
    s->face = f;
    return f;
}

/* Simplified -> Traditional display conversion (CONFIG.Traditional).
 *
 * This happens here, on the UCS-2 code points, rather than in the script
 * sources -- converting those is not possible while the runtime encoding is
 * GBK. Traditional characters live in GBK's extension areas, where the trail
 * byte is often ASCII: 衆 is D0 5C, a literal backslash, and 並 is 81 4B, a
 * 'K'. Rewriting the literals makes 18 of the 21 scripts fail to parse.
 *
 * Converting at raster time also leaves table keys, save contents and every
 * byte-length calculation untouched, and it catches data-file text too. The
 * map is strictly one-to-one, so no string changes width.
 */
static bool g_trad;

void jy_text_set_traditional(bool on) {
    g_trad = on;
    if (on)
        jy_log("text: Simplified -> Traditional display conversion on "
               "(%zu character mappings)",
               (size_t)JY_S2T_COUNT);
}

static uint16_t s2t(uint16_t cp) {
    int lo = 0, hi = (int)JY_S2T_COUNT - 1;
    while (lo <= hi) {
        int mid = (lo + hi) / 2;
        if (jy_s2t[mid].s < cp) lo = mid + 1;
        else if (jy_s2t[mid].s > cp) hi = mid - 1;
        else return jy_s2t[mid].t;
    }
    return cp;
}

/* One Simplified character can stand for two Traditional ones, and a
 * character table has to pick one. 冲 is the case that shows: it merges 沖
 * and 衝, the table maps it to 衝 -- right for 衝突, 衝動, 豪氣衝天,
 * 怒髮衝冠 -- and wrong for 令狐沖, whom the scripts write 令狐冲 in about
 * fifty places.
 *
 * The game's own data settles which is correct: person 35 in Ranger.grp is
 * Big5 令狐沖. So the data and the dialogue disagree, and the data wins.
 *
 * Redirect just that character where the neighbours identify the name. This
 * stays inside the constraint that kept phrase-level rules out of the table
 * (see s2t_table.h): nothing is inserted or removed, so the character count
 * the scripts compute pixel widths from does not move.
 *
 * 令狐*冲 at OEvent1901.lua:5699 is out of reach here -- '*' is the line
 * separator, so 狐 and 冲 arrive in different draw calls. That one literal
 * spells 沖 directly instead.
 */
#define CP_HU 0x72D0   /* 狐 */
#define CP_CHNG 0x885D /* 衝, what the table produced */
#define CP_CHON 0x6C96 /* 沖, wanted for the name */
#define CP_ER 0x5152   /* 兒, as in 沖兒 */
#define CP_GE 0x54E5   /* 哥, as in 沖哥 */

static void fix_merged(uint16_t *s, int n) {
    for (int i = 0; i < n; i++) {
        if (s[i] != CP_CHNG) continue;
        bool name = (i >= 1 && s[i - 1] == CP_HU) ||
                    (i + 1 < n && (s[i + 1] == CP_ER || s[i + 1] == CP_GE));
        if (name) s[i] = CP_CHON;
    }
}

/* Convert a native-charset string to UCS-2LE. Returns count of code units. */
static int to_ucs2(const char *s, size_t slen, int src_charset, uint16_t *out,
                   int outmax) {
    const char *from = (src_charset == 0) ? "GBK" : "BIG5";
    iconv_t     cd   = iconv_open("UCS-2LE", from);
    if (cd == (iconv_t)-1) return 0;

    char  *inbuf   = (char *)s;
    size_t inleft  = slen;
    char  *outbuf  = (char *)out;
    size_t outleft = (size_t)outmax * 2;

    while (inleft && outleft) {
        if (iconv(cd, &inbuf, &inleft, &outbuf, &outleft) != (size_t)-1) break;
        /* Consume a whole character, not a single byte: GBK and Big5 lead
         * bytes are >= 0x81, and skipping one byte desynchronises the stream.
         * Mixed-charset data does occur in this game. */
        size_t step = (inleft >= 2 && (unsigned char)*inbuf >= 0x81) ? 2 : 1;
        inbuf += step;
        inleft -= step;
        if (outleft >= 2) {
            *(uint16_t *)outbuf = '?';
            outbuf += 2;
            outleft -= 2;
        }
    }
    iconv_close(cd);

    int n = (int)((uint16_t *)outbuf - out);
    if (g_trad) {
        for (int i = 0; i < n; i++) out[i] = s2t(out[i]);
        fix_merged(out, n);
    }
    return n;
}

static void blit_glyph(FT_Bitmap *bm, int px, int py, uint32_t rgb) {
    uint32_t *dst   = (uint32_t *)g_e.screen->pixels;
    int       pitch = g_e.screen->pitch / 4;
    int       cx2   = g_e.clip.x + g_e.clip.w - 1;
    int       cy2   = g_e.clip.y + g_e.clip.h - 1;

    for (unsigned r = 0; r < bm->rows; r++) {
        int y = py + (int)r;
        if (y < g_e.clip.y || y > cy2) continue;
        for (unsigned c = 0; c < bm->width; c++) {
            int x = px + (int)c;
            if (x < g_e.clip.x || x > cx2) continue;
            int a = bm->buffer[r * (unsigned)bm->pitch + c];
            if (!a) continue;
            uint32_t *p = dst + (size_t)y * pitch + x;
            uint32_t  s = rgb & 0x00FFFFFFu, d = *p;
            uint32_t rb = (((s & 0x00FF00FFu) * a + (d & 0x00FF00FFu) * (255 - a)) >> 8) &
                          0x00FF00FFu;
            uint32_t g  = (((s & 0x0000FF00u) * a + (d & 0x0000FF00u) * (255 - a)) >> 8) &
                          0x0000FF00u;
            *p          = 0xFF000000u | rb | g;
        }
    }
}

void jy_draw_string(int x, int y, const char *s, uint32_t rgb, int size, const char *font,
                    int src_charset) {
    if (!g_ft_ok || !s || !*s) return;
    if (size <= 0) size = 16;

    FT_Face face = get_face(font, size);
    if (!face) return;

    uint16_t buf[1024];
    int      n = to_ucs2(s, strlen(s), src_charset, buf, 1024);

    int pen = x;
    for (int i = 0; i < n; i++) {
        FT_Error fe = FT_Load_Char(face, buf[i], FT_LOAD_RENDER);
        if (fe) continue;
        FT_GlyphSlot g = face->glyph;
        /* y is the top of the line in the game's coordinate space */
        blit_glyph(&g->bitmap, pen + g->bitmap_left, y + size - g->bitmap_top, rgb);
        pen += (int)(g->advance.x >> 6);
    }
}
