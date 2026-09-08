/* Software framebuffer + 2D primitives.
 *
 * The original engine draws into an SDL 1.2 surface and blits it to the
 * display. We keep that model: an ARGB8888 SDL_Surface is the canvas, and it
 * is uploaded to a streaming texture once per present.
 */
#include "engine.h"
#include <stdlib.h>
#include <string.h>

Engine g_e;

bool jy_gfx_init(int w, int h, const char *title) {
    if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS)) {
        jy_log("SDL_Init failed: %s", SDL_GetError());
        return false;
    }
    g_e.w = w;
    g_e.h = h;

    if (!SDL_CreateWindowAndRenderer(title, w, h, SDL_WINDOW_HIGH_PIXEL_DENSITY,
                                     &g_e.window, &g_e.renderer)) {
        jy_log("SDL_CreateWindowAndRenderer failed: %s", SDL_GetError());
        return false;
    }
    /* Letterbox to the logical size so the window can be resized freely. */
    SDL_SetRenderLogicalPresentation(g_e.renderer, w, h,
                                     SDL_LOGICAL_PRESENTATION_LETTERBOX);

    g_e.screen = SDL_CreateSurface(w, h, SDL_PIXELFORMAT_ARGB8888);
    g_e.tex    = SDL_CreateTexture(g_e.renderer, SDL_PIXELFORMAT_ARGB8888,
                                   SDL_TEXTUREACCESS_STREAMING, w, h);
    if (!g_e.screen || !g_e.tex) {
        jy_log("surface/texture creation failed: %s", SDL_GetError());
        return false;
    }
    SDL_SetTextureScaleMode(g_e.tex, SDL_SCALEMODE_NEAREST);

    g_e.clip = (SDL_Rect){0, 0, w, h};
    SDL_SetSurfaceClipRect(g_e.screen, &g_e.clip);
    g_e.running     = true;
    g_e.start_ticks = SDL_GetTicks();
    g_e.last_key    = -1;
    return true;
}

void jy_gfx_shutdown(void) {
    if (g_e.tex) SDL_DestroyTexture(g_e.tex);
    if (g_e.screen) SDL_DestroySurface(g_e.screen);
    if (g_e.renderer) SDL_DestroyRenderer(g_e.renderer);
    if (g_e.window) SDL_DestroyWindow(g_e.window);
    SDL_Quit();
}

static uint64_t g_last_present;
static int      g_present_count;

int jy_present_count(void) {
    return g_present_count;
}

/* Repaint the last committed frame. The texture is only refreshed by
 * jy_present(), so this never shows a half-drawn framebuffer. */
void jy_repaint(void) {
    SDL_RenderClear(g_e.renderer);
    SDL_RenderTexture(g_e.renderer, g_e.tex, NULL, NULL);
    SDL_RenderPresent(g_e.renderer);
    g_last_present = SDL_GetTicks();
    g_present_count++;
}

/* Commit the current framebuffer. Called only from lib.ShowSurface and
 * lib.ShowSlow, mirroring the original engine: the game draws into the surface
 * over many calls and decides when a frame is complete. */
void jy_present(void) {
    SDL_UpdateTexture(g_e.tex, NULL, g_e.screen->pixels, g_e.screen->pitch);
    jy_repaint();
}

/* The game blocks in its own loops (WaitKey -> GetKey -> Delay) and only
 * commits when something is finished. macOS/Metal does not retain the last
 * presented frame, so the window needs re-painting to stay visible -- but from
 * the *texture*, not the live surface. Uploading here instead would show the
 * game mid-draw, which made dialogue boxes flash and vanish. */
void jy_tick(void) {
    jy_pump_events();
    jy_audio_update();
    uint64_t now = SDL_GetTicks();
    if (now - g_last_present >= 16) jy_repaint();
}

static int g_key_mode; /* CONFIG.Operation: 0 = Windows, 1 = android */

void jy_set_key_mode(int m) {
    g_key_mode = m;
}

/* jyconst.lua picks its VK_* arrow values from CONFIG.Operation: mode 1 uses
 * SDL2/SDL3 keycodes, mode 0 uses the old SDL 1.2 ones. Everything else
 * (Enter, Esc, letters) has the same value in both, so only arrows need this. */
static int map_key(SDL_Keycode k) {
    if (g_key_mode == 1) return (int)k;
    switch (k) {
    case SDLK_UP: return 273;
    case SDLK_DOWN: return 274;
    case SDLK_RIGHT: return 275;
    case SDLK_LEFT: return 276;
    default: return (int)k;
    }
}

/* lib.ShowSlow(msPerStep, mode) -- ported from sub_407E70.
 *
 * A fixed 33 steps (counter 32..0). Each step fills the screen black, blits a
 * snapshot of the pre-fade framebuffer over it at alpha = counter*8 (clamped
 * to 255), presents, and delays so the step lasts at least msPerStep.
 *
 *   mode == 0  counter counts UP   -> alpha 0..255   fade IN from black
 *   mode != 0  counter counts DOWN -> alpha 255..0   fade OUT to black
 *
 * So the argument is milliseconds per step, not a step count: ShowSlow(50, 0)
 * is 33 * 50ms = ~1.7s.
 */
#define FADE_STEPS 32

void jy_show_slow(int ms_per_step, int mode) {
    SDL_Surface *snap = SDL_CreateSurface(g_e.w, g_e.h, SDL_PIXELFORMAT_ARGB8888);
    if (!snap) {
        jy_present();
        return;
    }

    /* Copy the whole framebuffer: SDL_BlitSurface clips by the SOURCE clip
     * rect too, so lift it for the capture (same reason as SaveSur). */
    SDL_Rect saved = g_e.clip, full = {0, 0, g_e.w, g_e.h};
    SDL_SetSurfaceClipRect(g_e.screen, &full);
    SDL_BlitSurface(g_e.screen, NULL, snap, NULL);
    SDL_SetSurfaceClipRect(g_e.screen, &saved);

    SDL_SetSurfaceBlendMode(snap, SDL_BLENDMODE_BLEND);

    for (int i = 0; i <= FADE_STEPS; i++) {
        int counter = mode ? (FADE_STEPS - i) : i;
        int alpha   = counter * 8;
        if (alpha > 255) alpha = 255;

        uint64_t t0 = SDL_GetTicks();

        SDL_SetSurfaceClipRect(g_e.screen, &full);
        jy_fill_rect_raw(0, 0, g_e.w - 1, g_e.h - 1, 0x000000);
        SDL_SetSurfaceAlphaMod(snap, (Uint8)alpha);
        SDL_BlitSurface(snap, NULL, g_e.screen, NULL);
        SDL_SetSurfaceClipRect(g_e.screen, &saved);

        jy_present();

        uint64_t elapsed = SDL_GetTicks() - t0;
        if (ms_per_step > 0 && (uint64_t)ms_per_step > elapsed)
            SDL_Delay((Uint32)(ms_per_step - elapsed));
        jy_pump_events();
        if (!g_e.running) break; /* window closed mid-fade */
    }
    SDL_SetSurfaceAlphaMod(snap, 255);
    SDL_DestroySurface(snap);
}

/* Capture what the window shows. RenderReadPixels must run BEFORE
 * RenderPresent -- after presenting, the backbuffer is undefined and reads
 * back blank, which is what made earlier snapshots look empty. */
SDL_Surface *jy_capture(void) {
    SDL_RenderClear(g_e.renderer);
    SDL_RenderTexture(g_e.renderer, g_e.tex, NULL, NULL);
    SDL_Surface *shot = SDL_RenderReadPixels(g_e.renderer, NULL);
    SDL_RenderPresent(g_e.renderer);
    return shot;
}

void jy_pump_events(void) {
    SDL_Event ev;
    while (SDL_PollEvent(&ev)) {
        switch (ev.type) {
        case SDL_EVENT_QUIT: g_e.running = false; break;
        case SDL_EVENT_KEY_DOWN:
            /* jyconst.lua's VK_* values are SDL2/SDL3 keycodes verbatim
             * (VK_F1 = 1073741882 = SDLK_F1), so no translation is needed. */
            g_e.last_key = map_key(ev.key.key);
            break;
        case SDL_EVENT_WINDOW_EXPOSED:
        case SDL_EVENT_WINDOW_RESIZED:
            g_last_present = 0; /* force a repaint on the next tick */
            break;
        default: break;
        }
    }
}

/* Clamp a normalised rect to the current clip region. */
static bool clamp_rect(int *x1, int *y1, int *x2, int *y2) {
    if (*x1 > *x2) {
        int t = *x1;
        *x1   = *x2;
        *x2   = t;
    }
    if (*y1 > *y2) {
        int t = *y1;
        *y1   = *y2;
        *y2   = t;
    }
    int cx2 = g_e.clip.x + g_e.clip.w - 1;
    int cy2 = g_e.clip.y + g_e.clip.h - 1;
    if (*x1 < g_e.clip.x) *x1 = g_e.clip.x;
    if (*y1 < g_e.clip.y) *y1 = g_e.clip.y;
    if (*x2 > cx2) *x2 = cx2;
    if (*y2 > cy2) *y2 = cy2;
    return *x1 <= *x2 && *y1 <= *y2;
}

static inline uint32_t blend(uint32_t dst, uint32_t src, int a) {
    if (a >= 255) return src | 0xFF000000u;
    if (a <= 0) return dst;
    uint32_t rb =
        (((src & 0x00FF00FFu) * a + (dst & 0x00FF00FFu) * (255 - a)) >> 8) & 0x00FF00FFu;
    uint32_t g =
        (((src & 0x0000FF00u) * a + (dst & 0x0000FF00u) * (255 - a)) >> 8) & 0x0000FF00u;
    return 0xFF000000u | rb | g;
}

/* Unclipped opaque fill, used by the fade which is inherently full-screen. */
void jy_fill_rect_raw(int x1, int y1, int x2, int y2, uint32_t rgb) {
    if (x1 < 0) x1 = 0;
    if (y1 < 0) y1 = 0;
    if (x2 >= g_e.w) x2 = g_e.w - 1;
    if (y2 >= g_e.h) y2 = g_e.h - 1;
    uint32_t  src   = 0xFF000000u | (rgb & 0x00FFFFFFu);
    int       pitch = g_e.screen->pitch / 4;
    uint32_t *px    = (uint32_t *)g_e.screen->pixels;
    for (int y = y1; y <= y2; y++) {
        uint32_t *row = px + (size_t)y * pitch;
        for (int x = x1; x <= x2; x++) row[x] = src;
    }
}

void jy_fill_rect(int x1, int y1, int x2, int y2, uint32_t rgb, int alpha) {
    if (!clamp_rect(&x1, &y1, &x2, &y2)) return;
    uint32_t  src   = rgb & 0x00FFFFFFu;
    int       pitch = g_e.screen->pitch / 4;
    uint32_t *px    = (uint32_t *)g_e.screen->pixels;
    for (int y = y1; y <= y2; y++) {
        uint32_t *row = px + (size_t)y * pitch;
        for (int x = x1; x <= x2; x++) row[x] = blend(row[x], src, alpha);
    }
}

/* lib.DrawRect draws an outline, not a filled box (verified in IDA at
 * sub_4083A0: two horizontal spans + two vertical spans). */
void jy_draw_rect(int x1, int y1, int x2, int y2, uint32_t rgb) {
    jy_fill_rect(x1, y1, x2, y1, rgb, 255);
    jy_fill_rect(x1, y2, x2, y2, rgb, 255);
    jy_fill_rect(x1, y1, x1, y2, rgb, 255);
    jy_fill_rect(x2, y1, x2, y2, rgb, 255);
}

/* The clip must also live on the surface: fills and glyphs honour g_e.clip by
 * hand, but sprites, pictures and LoadSur go through SDL_BlitSurface, which
 * only respects the destination surface's own clip rect. The original engine
 * called SDL_SetClipRect for exactly this reason (it is in the import table),
 * so without this, blitted UI was never clipped and could survive a clipped
 * redraw. */
static void apply_clip(void) {
    SDL_SetSurfaceClipRect(g_e.screen, &g_e.clip);
}

void jy_set_clip(int x1, int y1, int x2, int y2) {
    /* The scripts call SetClip(0,0,0,0) to mean "no clipping" (21 sites). */
    if (x1 == 0 && y1 == 0 && x2 == 0 && y2 == 0) {
        g_e.clip = (SDL_Rect){0, 0, g_e.w, g_e.h};
        apply_clip();
        return;
    }
    if (x1 > x2) {
        int t = x1;
        x1    = x2;
        x2    = t;
    }
    if (y1 > y2) {
        int t = y1;
        y1    = y2;
        y2    = t;
    }
    if (x1 < 0) x1 = 0;
    if (y1 < 0) y1 = 0;
    if (x2 >= g_e.w) x2 = g_e.w - 1;
    if (y2 >= g_e.h) y2 = g_e.h - 1;
    g_e.clip = (SDL_Rect){x1, y1, x2 - x1 + 1, y2 - y1 + 1};
    apply_clip();
}
