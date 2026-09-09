/* PNG loading and the picture API.
 *
 * The original used SDL_image (IMG_Load / IMG_LoadPNG_RW); PNG is the only
 * format it ever asks for, so we talk to libpng directly.
 */
#include "engine.h"
#include <png.h>
#include <stdlib.h>
#include <string.h>

/* 256-entry RGB palette from PicInit(".col"), used by the .grp sprite formats */
static uint8_t g_palette[256][3];
static bool    g_have_palette;

bool jy_load_palette(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) {
        jy_log("PicInit: cannot open palette %s", path);
        return false;
    }
    size_t got = fread(g_palette, 1, sizeof(g_palette), f);
    fclose(f);
    g_have_palette = (got == sizeof(g_palette));
    if (!g_have_palette) jy_log("PicInit: %s is %zu bytes, expected 768", path, got);
    return g_have_palette;
}

SDL_Surface *jy_load_png(const char *path) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;

    png_structp png  = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    png_infop   info = png ? png_create_info_struct(png) : NULL;
    if (!png || !info) {
        if (png) png_destroy_read_struct(&png, info ? &info : NULL, NULL);
        fclose(f);
        return NULL;
    }
    if (setjmp(png_jmpbuf(png))) {
        png_destroy_read_struct(&png, &info, NULL);
        fclose(f);
        return NULL;
    }
    png_init_io(png, f);
    png_read_info(png, info);

    png_uint_32 w, h;
    int         depth, ctype;
    png_get_IHDR(png, info, &w, &h, &depth, &ctype, NULL, NULL, NULL);

    /* normalise everything to 8-bit RGBA */
    if (ctype == PNG_COLOR_TYPE_PALETTE) png_set_palette_to_rgb(png);
    if (ctype == PNG_COLOR_TYPE_GRAY && depth < 8) png_set_expand_gray_1_2_4_to_8(png);
    if (png_get_valid(png, info, PNG_INFO_tRNS)) png_set_tRNS_to_alpha(png);
    if (depth == 16) png_set_strip_16(png);
    if (ctype == PNG_COLOR_TYPE_GRAY || ctype == PNG_COLOR_TYPE_GRAY_ALPHA)
        png_set_gray_to_rgb(png);
    png_set_filler(png, 0xFF, PNG_FILLER_AFTER);
    png_read_update_info(png, info);

    SDL_Surface *s = SDL_CreateSurface((int)w, (int)h, SDL_PIXELFORMAT_ARGB8888);
    if (!s) {
        png_destroy_read_struct(&png, &info, NULL);
        fclose(f);
        return NULL;
    }
    png_bytep *rows = (png_bytep *)malloc(sizeof(png_bytep) * h);
    uint8_t   *tmp  = (uint8_t *)malloc((size_t)w * h * 4);
    for (png_uint_32 y = 0; y < h; y++) rows[y] = tmp + (size_t)y * w * 4;
    png_read_image(png, rows);
    png_read_end(png, NULL);

    /* RGBA8 -> ARGB8888 (native u32) */
    uint32_t *dst   = (uint32_t *)s->pixels;
    int       pitch = s->pitch / 4;
    for (png_uint_32 y = 0; y < h; y++) {
        uint8_t *src = rows[y];
        for (png_uint_32 x = 0; x < w; x++) {
            uint8_t r = src[x * 4 + 0], g = src[x * 4 + 1], b = src[x * 4 + 2],
                    a = src[x * 4 + 3];
            dst[(size_t)y * pitch + x] =
                ((uint32_t)a << 24) | ((uint32_t)r << 16) | ((uint32_t)g << 8) | b;
        }
    }
    free(rows);
    free(tmp);
    png_destroy_read_struct(&png, &info, NULL);
    fclose(f);
    return s;
}

/* Blit a surface; negative coordinates mean "centre on that axis". */
void jy_blit_surface(SDL_Surface *s, int x, int y) {
    if (!s) return;
    if (x < 0) x = (g_e.w - s->w) / 2;
    if (y < 0) y = (g_e.h - s->h) / 2;
    SDL_Rect dst = {x, y, s->w, s->h};
    SDL_BlitSurface(s, NULL, g_e.screen, &dst);
}

/* Scale a full-screen picture up to cover the window, centred, cropping
 * whatever falls outside.
 *
 * sub_407CB0 blits the art 1:1 and centres it. That covered every pixel at
 * the art's own 640x480, so the original never had to scale; in a larger
 * window the uncovered border is bare black.
 *
 * Cover, not stretch: the art is 4:3 and the window generally is not, so
 * stretching to the exact window size would widen the calligraphy by a
 * third. Uniform scale keeps its proportions and the overflow is cropped
 * evenly off two sides -- on title.png, which is black outside the centred
 * logo, the crop takes only black.
 *
 * LINEAR to match the portrait scaling in jy_png_get; the art is a rendered
 * image with soft gradients, not the pixel art the NEAREST texture filter is
 * there for.
 */
void jy_blit_surface_cover(SDL_Surface *s) {
    if (!s || s->w <= 0 || s->h <= 0) return;
    double kx = (double)g_e.w / s->w, ky = (double)g_e.h / s->h;
    double k = kx > ky ? kx : ky;
    int    w = (int)(s->w * k + 0.5), h = (int)(s->h * k + 0.5);

    SDL_Rect dst = {(g_e.w - w) / 2, (g_e.h - h) / 2, w, h};
    SDL_BlitSurfaceScaled(s, NULL, g_e.screen, &dst, SDL_SCALEMODE_LINEAR);
}

/* ------------------------------------------------------------------------ */
/* PNG slot registry (LoadPNGPath / LoadPNG / GetPNGXY)                      */
/*                                                                          */
/* LoadPNGPath(dir, slot, count, targetWidth) registers a directory under a  */
/* numeric slot; LoadPNG(slot, index, x, y, flag) draws <dir>/<index>.png.   */
/* Images are loaded lazily and cached scaled to the slot's target width.    */
/* ------------------------------------------------------------------------ */
#define MAX_SLOTS 128
typedef struct {
    char dir[384];
    int  count;
    int  fit_w, fit_h;
    bool used;
} PngSlot;
static PngSlot g_slots[MAX_SLOTS];

#define PNG_CACHE 512
typedef struct {
    int          slot, index;
    SDL_Surface *s;
    bool         tried;
} PngEntry;
static PngEntry g_cache[PNG_CACHE];
static int      g_ncache;

void jy_png_register(int slot, const char *dir, int count, int fit_w, int fit_h) {
    if (slot < 0 || slot >= MAX_SLOTS || !dir) return;
    snprintf(g_slots[slot].dir, sizeof(g_slots[slot].dir), "%s", dir);
    g_slots[slot].count = count;
    /* JY_LoadPNGPath: when only one dimension is given it is used for both. */
    if (!fit_h) fit_h = fit_w;
    g_slots[slot].fit_w = fit_w > 0 ? fit_w : 0;
    g_slots[slot].fit_h = fit_h > 0 ? fit_h : 0;
    g_slots[slot].used  = true;
    jy_log("LoadPNGPath: slot %d -> %s (count %d, fit %dx%d)", slot, dir, count,
           g_slots[slot].fit_w, g_slots[slot].fit_h);
}

/* Fit inside the slot's box, preserving aspect -- the engine takes whichever
 * of the two ratios is smaller (sub_406AB0). */
static SDL_Surface *scale_to_fit(SDL_Surface *src, int fw, int fh) {
    if (fw <= 0 || fh <= 0) return src;
    if (src->w == fw && src->h == fh) return src;
    double rx = (double)fw / src->w, ry = (double)fh / src->h;
    double r = rx < ry ? rx : ry;
    int    w = (int)(src->w * r + 0.5), h = (int)(src->h * r + 0.5);
    if (w < 1) w = 1;
    if (h < 1) h = 1;
    SDL_Surface *dst = SDL_CreateSurface(w, h, SDL_PIXELFORMAT_ARGB8888);
    if (!dst) return src;
    SDL_BlitSurfaceScaled(src, NULL, dst, NULL, SDL_SCALEMODE_LINEAR);
    SDL_DestroySurface(src);
    return dst;
}

/* NOTE: `id` is the value the scripts pass; the record index is id/2, exactly
 * as JY_LoadPNG does (sub_406AB0), and the filename uses the HALVED index. */
SDL_Surface *jy_png_get(int slot, int id) {
    if (slot < 0 || slot >= MAX_SLOTS || !g_slots[slot].used) return NULL;
    int index = id / 2;
    if (index < 0 || (g_slots[slot].count > 0 && index >= g_slots[slot].count))
        return NULL;

    for (int i = 0; i < g_ncache; i++)
        if (g_cache[i].slot == slot && g_cache[i].index == index) return g_cache[i].s;
    if (g_ncache >= PNG_CACHE) return NULL; /* cache full: stop caching */

    char path[512];
    snprintf(path, sizeof(path), "%s%d.png", g_slots[slot].dir, index);
    SDL_Surface *s = jy_load_png(path);
    if (s) s = scale_to_fit(s, g_slots[slot].fit_w, g_slots[slot].fit_h);
    else jy_log("LoadPNG: missing %s", path);

    g_cache[g_ncache++] = (PngEntry){slot, index, s, true};
    return s;
}
