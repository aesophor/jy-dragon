#ifndef JY_ENGINE_H
#define JY_ENGINE_H

#include <SDL3/SDL.h>
#include <stdint.h>
#include <stdbool.h>

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

/* ---- global engine state ------------------------------------------------ */
typedef struct {
    SDL_Window   *window;
    SDL_Renderer *renderer;
    SDL_Texture  *tex;    /* streaming texture we present each frame     */
    SDL_Surface  *screen; /* software framebuffer, ARGB8888              */
    SDL_Rect      clip;   /* current clip rect (lib.SetClip)             */
    int           w, h;
    bool          running;
    uint32_t      start_ticks;
    int           last_key; /* pending key, or -1 for none (GetKey's sentinel) */
} Engine;

extern Engine g_e;

/* Colours arrive from Lua as 0xRRGGBB (see RGB() in jymain.lua). */
static inline uint32_t jy_rgb(uint32_t c, uint8_t a) {
    return ((uint32_t)a << 24) | (c & 0x00FFFFFFu);
}

/* ---- module registration ------------------------------------------------ */
void jy_open_lib(lua_State *L);  /* the 46-function `lib` table  */
void jy_open_byte(lua_State *L); /* the 11-function `Byte` table */

/* ---- graphics ----------------------------------------------------------- */
bool         jy_gfx_init(int w, int h, const char *title);
void         jy_gfx_shutdown(void);
void         jy_present(void); /* commit the framebuffer (ShowSurface/ShowSlow) */
void         jy_repaint(void); /* redraw the last committed frame */
SDL_Surface *jy_capture(void); /* read back what the window shows */
void         jy_fill_rect(int x1, int y1, int x2, int y2, uint32_t rgb, int alpha);
void         jy_fill_rect_raw(int x1, int y1, int x2, int y2, uint32_t rgb);
void         jy_show_slow(int ms_per_step, int mode);
void         jy_draw_rect(int x1, int y1, int x2, int y2, uint32_t rgb);
void         jy_set_clip(int x1, int y1, int x2, int y2);
void         jy_pump_events(void);
void         jy_tick(void);
void         jy_set_key_mode(int mode);
void         jy_set_scripted_keys(const char *s);
int          jy_present_count(void);
void         jy_set_deadline(double ms);

/* ---- text --------------------------------------------------------------- */
bool jy_text_init(void);
void jy_text_shutdown(void);
/* src_charset: 0 = data is Big5, 1 = data is GBK (CONFIG.CharSet) */
void jy_draw_string(int x, int y, const char *s, uint32_t rgb, int size, const char *font,
                    int src_charset);
void jy_text_set_traditional(bool on);

/* ---- images ------------------------------------------------------------- */
bool         jy_load_palette(const char *path);
SDL_Surface *jy_load_png(const char *path);
void         jy_blit_surface(SDL_Surface *s, int x, int y);
void         jy_png_register(int slot, const char *dir, int count, int fit_w, int fit_h);
SDL_Surface *jy_png_get(int slot, int id); /* id is pre-doubled; index = id/2 */

/* ---- sprite archives ---------------------------------------------------- */
bool jy_pic_set_palette(const char *path);
bool jy_pic_load_file(int slot, const char *idx, const char *grp, int w, int h);
void jy_pic_draw(int slot, int id, int x, int y, int flags, int alpha);
void jy_pic_draw_tinted(int slot, int id, int x, int y, int flags, int alpha, int tint);

/* ---- battle map --------------------------------------------------------- */
bool jy_warmap_load(const char *idx, const char *grp, int map_index, int layers, int w,
                    int h);
int  jy_get_warmap(int x, int y, int layer);
void jy_set_warmap(int x, int y, int layer, int v);
void jy_clean_warmap(int layer, int value);
void jy_draw_warmap(int mode, int camx, int camy, int a4, int a5, int anim_id, int scene,
                    int anim_slot, int ax, int ay);
void jy_warmap_set_scale(int xs, int ys);
void jy_pic_xy(int slot, int id, int *w, int *h, int *ox, int *oy);

/* ---- audio -------------------------------------------------------------- */
bool jy_audio_init(void);
void jy_audio_shutdown(void);
void jy_audio_update(void);
void jy_play_music(const char *path);
void jy_stop_music(void);
bool jy_music_active(void);

/* script.c -- UTF-8 source files, transcoded to GBK before LuaJIT sees them */
char *jy_script_read(const char *path, size_t *out_len);
int   jy_script_load(lua_State *L, const char *path);
void  jy_script_install(lua_State *L);
void  jy_play_sound(const char *path);

/* ---- world map ---------------------------------------------------------- */
bool jy_mmap_load(const char *files[5], int w, int h);
void jy_mmap_unload(void);
int  jy_get_mmap(int x, int y, int layer);
void jy_draw_mmap(int px, int py, int mypic);
void jy_mmap_set_scale(int xs, int ys);

/* ---- scene renderer ----------------------------------------------------- */
void jy_smap_set_scale(int xs, int ys);
void jy_draw_smap(int scene, int px, int py, int ox, int oy, int mypic);

/* ---- scene maps --------------------------------------------------------- */
bool jy_smap_load(const char *sfile, const char *dfile, int scenes, int w, int h,
                  int dnum, int dfields);
bool jy_smap_save(const char *sfile, const char *dfile);
int  jy_get_s(int scene, int x, int y, int layer);
void jy_set_s(int scene, int x, int y, int layer, int v);
int  jy_get_d(int scene, int index, int field);
void jy_set_d(int scene, int index, int field, int v);

/* ---- misc --------------------------------------------------------------- */
void jy_log(const char *fmt, ...);
void jy_todo(const char *fn, int nargs); /* record an unimplemented call */
void jy_todo_report(void);

#endif
