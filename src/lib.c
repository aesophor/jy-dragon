/* The `lib` table: the 46 C functions the game's Lua calls.
 *
 * Names, arity and addresses were recovered from the unpacked engine
 * (_re/engine_api.md, _re/lua_api.txt). Anything not yet implemented records
 * itself via jy_todo() so a run tells us exactly what to build next.
 */
#include "engine.h"
#include <iconv.h>
#include <string.h>
#include <stdlib.h>

/* ---- saved surfaces (SaveSur / LoadSur / FreeSur) ----------------------- */
#define MAX_SUR 256
static SDL_Surface *g_sur[MAX_SUR];

static int sur_alloc(SDL_Surface *s) {
    for (int i = 1; i < MAX_SUR; i++)
        if (!g_sur[i]) {
            g_sur[i] = s;
            return i;
        }
    SDL_DestroySurface(s);
    jy_log("SaveSur: surface table full");
    return 0;
}

/* Unwind out of the Lua game loop on window-close or a run-time budget.
 * Raising a Lua error is the only way out: the game loop never returns. */
static double g_deadline = 0;

/* JY_LOOPSTATS=1 samples JY.Mytick once a second. Mytick increments exactly
 * once per Game_Cycle iteration, and DtoSMap advances an NPC animation frame
 * every 4th tick, so this measures the real loop rate and the resulting NPC
 * animation rate rather than inferring it. */
static void loop_stats(lua_State *L) {
    static bool     on, checked;
    static uint64_t next;
    static double   prev_tick = -1;
    if (!checked) {
        checked = true;
        on      = getenv("JY_LOOPSTATS") != NULL;
    }
    if (!on) return;

    uint64_t now = SDL_GetTicks();
    if (now < next) return;
    next = now + 1000;

    lua_getglobal(L, "JY");
    if (!lua_istable(L, -1)) {
        lua_pop(L, 1);
        return;
    }
    lua_getfield(L, -1, "Mytick");
    double t = lua_tonumber(L, -1);
    lua_pop(L, 2);

    double frame = 0;
    lua_getglobal(L, "CC");
    if (lua_istable(L, -1)) {
        lua_getfield(L, -1, "Frame");
        frame = lua_tonumber(L, -1);
        lua_pop(L, 1);
    }
    lua_pop(L, 1);

    if (prev_tick >= 0) {
        double iters = t - prev_tick;
        jy_log("loop: %.0f iters/s (%.1f ms each) | CC.Frame=%.0f -> expected "
               "%.1f/s | NPC anim %.1f fps (expected %.1f)",
               iters, iters > 0 ? 1000.0 / iters : 0.0, frame,
               frame > 0 ? 1000.0 / frame : 0.0, iters / 4.0,
               frame > 0 ? 1000.0 / frame / 4.0 : 0.0);
    }
    prev_tick = t;
}

static void check_quit(lua_State *L) {
    loop_stats(L);
    jy_tick();
    if (!g_e.running) luaL_error(L, "__jy_quit__");
    if (g_deadline > 0 && (double)SDL_GetTicks() > g_deadline) {
        g_e.running = false;
        luaL_error(L, "__jy_quit__ (time budget)");
    }
}

void jy_set_deadline(double ms) {
    g_deadline = ms;
}

/* ---- small helpers ------------------------------------------------------ */
static int argi(lua_State *L, int i, int def) {
    return lua_isnoneornil(L, i) ? def : (int)lua_tonumber(L, i);
}

/* ---- implemented -------------------------------------------------------- */

static int l_Debug(lua_State *L) {
    const char *s = lua_tostring(L, 1);
    jy_log("[lua] %s", s ? s : "(nil)");
    return 0;
}

static int l_Delay(lua_State *L) {
    int ms = argi(L, 1, 0);
    /* Keep the window responsive: the game calls this in tight loops. */
    check_quit(L);
    if (ms > 0) SDL_Delay((Uint32)ms);
    return 0;
}

static int l_GetTime(lua_State *L) {
    lua_pushnumber(L, (lua_Number)(SDL_GetTicks() - g_e.start_ticks));
    return 1;
}

/* JY_KEYS="13,274,13" feeds synthetic keys, one per GetKey call, so headless
 * runs can walk menus. Real input still takes priority. */
static const char *g_scripted_keys;

void jy_set_scripted_keys(const char *s) {
    g_scripted_keys = s;
}

static int next_scripted_key(void) {
    if (!g_scripted_keys || !*g_scripted_keys) return -1;
    char *end;
    long  v = strtol(g_scripted_keys, &end, 10);
    if (end == g_scripted_keys) {
        g_scripted_keys = NULL;
        return -1;
    }
    g_scripted_keys = (*end == ',') ? end + 1 : end;
    return (int)v;
}

/* Returns -1 when no key is pending. The scripts rely on that exact sentinel:
 * WaitKey() spins until GetKey() returns something ~= -1, so returning 0 here
 * made every WaitKey fall through instantly and dialogue pages flashed past. */
static int l_GetKey(lua_State *L) {
    check_quit(L);
    int k        = g_e.last_key;
    g_e.last_key = -1; /* consume */
    if (k == -1) k = next_scripted_key();
    lua_pushnumber(L, k);
    return 1;
}

static int l_EnableKeyRepeat(lua_State *L) {
    /* SDL3 has no key-repeat toggle; repeats arrive as KEY_DOWN with .repeat */
    return 0;
}

static int l_GetScreenW(lua_State *L) {
    lua_pushnumber(L, g_e.w);
    return 1;
}
static int l_GetScreenH(lua_State *L) {
    lua_pushnumber(L, g_e.h);
    return 1;
}

static int l_SetClip(lua_State *L) {
    jy_set_clip(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, g_e.w - 1),
                argi(L, 4, g_e.h - 1));
    return 0;
}

static int l_FillColor(lua_State *L) {
    jy_fill_rect(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0),
                 (uint32_t)argi(L, 5, 0), argi(L, 6, 255));
    return 0;
}

static int l_DrawRect(lua_State *L) {
    jy_draw_rect(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0),
                 (uint32_t)argi(L, 5, 0));
    return 0;
}

/* Background(x1,y1,x2,y2,alpha[,color]) - the translucent panel behind menus */
static int l_Background(lua_State *L) {
    int      alpha = argi(L, 5, 128);
    uint32_t col   = (uint32_t)argi(L, 6, 0); /* default black */
    jy_fill_rect(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0), col, alpha);
    return 0;
}

static int l_ShowSurface(lua_State *L) {
    jy_present();
    return 0;
}

/* ShowSlow(msPerStep, mode) -- 33-step fade; mode 0 in, non-zero out */
static int l_ShowSlow(lua_State *L) {
    jy_show_slow(argi(L, 1, 0), argi(L, 2, 0));
    return 0;
}

static int l_DrawStr(lua_State *L) {
    int         x    = argi(L, 1, 0);
    int         y    = argi(L, 2, 0);
    const char *s    = lua_tostring(L, 3);
    uint32_t    col  = (uint32_t)argi(L, 4, 0xFFFFFF);
    int         size = argi(L, 5, 16);
    const char *font = lua_tostring(L, 6);
    int         scs  = argi(L, 7, 0);
    if (s && font) jy_draw_string(x, y, s, col, size, font, scs);
    return 0;
}

static int l_SaveSur(lua_State *L) {
    int x = argi(L, 1, 0), y = argi(L, 2, 0), w = argi(L, 3, 0), h = argi(L, 4, 0);
    if (w <= 0 || h <= 0) {
        lua_pushnumber(L, 0);
        return 1;
    }
    SDL_Surface *s = SDL_CreateSurface(w, h, SDL_PIXELFORMAT_ARGB8888);
    if (!s) {
        lua_pushnumber(L, 0);
        return 1;
    }
    /* Capture the asked-for region, not the clipped one: SDL_BlitSurface also
     * clips by the SOURCE surface's clip rect. */
    SDL_Rect saved = g_e.clip;
    SDL_Rect full  = {0, 0, g_e.w, g_e.h};
    SDL_SetSurfaceClipRect(g_e.screen, &full);
    SDL_Rect src = {x, y, w, h}, dst = {0, 0, w, h};
    SDL_BlitSurface(g_e.screen, &src, s, &dst);
    SDL_SetSurfaceClipRect(g_e.screen, &saved);
    lua_pushnumber(L, sur_alloc(s));
    return 1;
}

static int l_LoadSur(lua_State *L) {
    int id = argi(L, 1, 0), x = argi(L, 2, 0), y = argi(L, 3, 0);
    if (id > 0 && id < MAX_SUR && g_sur[id]) {
        SDL_Rect dst = {x, y, g_sur[id]->w, g_sur[id]->h};
        SDL_BlitSurface(g_sur[id], NULL, g_e.screen, &dst);
    }
    return 0;
}

static int l_FreeSur(lua_State *L) {
    int id = argi(L, 1, 0);
    if (id > 0 && id < MAX_SUR && g_sur[id]) {
        SDL_DestroySurface(g_sur[id]);
        g_sur[id] = NULL;
    }
    return 0;
}

/* CharSet(s, mode): 0 = Big5 -> GBK when reading a data record,
 * 1 = GBK -> Big5 when writing one back (see Get/SetDataFromStruct). */
static int l_CharSet(lua_State *L) {
    size_t      n;
    const char *s    = lua_tolstring(L, 1, &n);
    int         mode = argi(L, 2, 0);
    if (!s) {
        lua_pushvalue(L, 1);
        return 1;
    }

    iconv_t cd = (mode == 0) ? iconv_open("GBK", "BIG5") : iconv_open("BIG5", "GBK");
    if (cd == (iconv_t)-1) {
        lua_pushvalue(L, 1);
        return 1;
    }

    size_t outcap = n * 2 + 8;
    char  *out    = (char *)malloc(outcap);
    char  *ip = (char *)s, *op = out;
    size_t il = n, ol = outcap;
    while (il && ol) {
        if (iconv(cd, &ip, &il, &op, &ol) != (size_t)-1) break;
        /* Unmappable character. Both Big5 and GBK use lead bytes >= 0x81 for
         * two-byte characters, so consume the WHOLE character and emit one
         * '?' per byte -- skipping a single byte would land mid-character and
         * corrupt everything after it. hzmb.dat, the original engine's
         * conversion table, stores missing entries as the two bytes "??" for
         * exactly this reason.
         *
         * This is reachable in normal play: FINALWORK2 assigns the Simplified
         * literal "逍遥子" to a record holding Traditional Big5, and 遥 has no
         * Big5 form. */
        size_t step = (il >= 2 && (unsigned char)*ip >= 0x81) ? 2 : 1;
        ip += step;
        il -= step;
        for (size_t k = 0; k < step && ol; k++) {
            *op++ = '?';
            ol--;
        }
    }
    iconv_close(cd);
    lua_pushlstring(L, out, (size_t)(op - out));
    free(out);
    return 1;
}

static int l_FullScreen(lua_State *L) {
    static bool full = false;
    full             = !full;
    SDL_SetWindowFullscreen(g_e.window, full);
    return 0;
}

/* PicInit([paletteFile]) - loads the 256-colour palette used by .grp sprites */
static int l_PicInit(lua_State *L) {
    const char *pal = lua_tostring(L, 1);
    if (pal) jy_pic_set_palette(pal);
    return 0;
}

/* PicLoadFile(idxPath, grpPath, slot [, fitW, fitH]) */
static int l_PicLoadFile(lua_State *L) {
    const char *idx = lua_tostring(L, 1);
    const char *grp = lua_tostring(L, 2);
    if (idx && grp)
        jy_pic_load_file(argi(L, 3, 0), idx, grp, argi(L, 4, 0), argi(L, 5, 0));
    return 0;
}

/* PicLoadCache(slot, id, x, y [, flags, alpha]) */
static int l_PicLoadCache(lua_State *L) {
    jy_pic_draw(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0), argi(L, 5, 0),
                argi(L, 6, 0));
    return 0;
}

/* PicGetXY(slot, id) -> w, h, offsetX, offsetY */
static int l_PicGetXY(lua_State *L) {
    int w, h, ox, oy;
    jy_pic_xy(argi(L, 1, 0), argi(L, 2, 0), &w, &h, &ox, &oy);
    lua_pushnumber(L, w);
    lua_pushnumber(L, h);
    lua_pushnumber(L, ox);
    lua_pushnumber(L, oy);
    return 4;
}

/* LoadPicture(path, x, y) - full-screen art; negative coords mean centre */
static int l_LoadPicture(lua_State *L) {
    const char *path = lua_tostring(L, 1);
    if (!path || !*path) return 0;
    SDL_Surface *s = jy_load_png(path);
    if (!s) {
        jy_log("LoadPicture: cannot load %s", path);
        return 0;
    }
    jy_blit_surface(s, argi(L, 2, -1), argi(L, 3, -1));
    SDL_DestroySurface(s);
    return 0;
}

/* LoadPNGPath(dir, slot, count, targetWidth) */
static int l_LoadPNGPath(lua_State *L) {
    const char *dir = lua_tostring(L, 1);
    if (dir)
        jy_png_register(argi(L, 2, 0), dir, argi(L, 3, 0), argi(L, 4, 0), argi(L, 5, 0));
    return 0;
}

/* LoadPNG(slot, index, x, y [, flag]) - negative coords centre on that axis */
static int l_LoadPNG(lua_State *L) {
    SDL_Surface *s = jy_png_get(argi(L, 1, 0), argi(L, 2, 0));
    if (s) jy_blit_surface(s, argi(L, 3, 0), argi(L, 4, 0));
    return 0;
}

/* GetPNGXY(slot, id) -> w, h, offsetX, offsetY  (anchor is the centre) */
static int l_GetPNGXY(lua_State *L) {
    SDL_Surface *s = jy_png_get(argi(L, 1, 0), argi(L, 2, 0));
    int          w = s ? s->w : 0, h = s ? s->h : 0;
    lua_pushnumber(L, w);
    lua_pushnumber(L, h);
    lua_pushnumber(L, w / 2);
    lua_pushnumber(L, h / 2);
    return 4;
}

/* LoadSMap(sFile, tempSFile, sceneCount, w, h, dFile, dCount, dFields) */
static int l_LoadSMap(lua_State *L) {
    const char *sfile = lua_tostring(L, 1);
    const char *dfile = lua_tostring(L, 6);
    if (!sfile || !dfile) return 0;
    jy_smap_load(sfile, dfile, argi(L, 3, 0), argi(L, 4, 64), argi(L, 5, 64),
                 argi(L, 7, 200), argi(L, 8, 11));
    return 0;
}

/* PlayMIDI(path) -- music; despite the name this is an .mp3 (CONFIG.MP3 = 1) */
static int l_PlayMIDI(lua_State *L) {
    const char *p = lua_tostring(L, 1);
    if (p && *p) jy_play_music(p);
    else jy_stop_music();
    return 0;
}

/* PlayWAV(path) -- one-shot sound effect */
static int l_PlayWAV(lua_State *L) {
    const char *p = lua_tostring(L, 1);
    if (p && *p) jy_play_sound(p);
    return 0;
}

/* LoadWarMap(idxFile, grpFile, mapIndex, layers, w, h) */
static int l_LoadWarMap(lua_State *L) {
    const char *idx = lua_tostring(L, 1);
    const char *grp = lua_tostring(L, 2);
    if (idx && grp)
        jy_warmap_load(idx, grp, argi(L, 3, 0), argi(L, 4, 7), argi(L, 5, 64),
                       argi(L, 6, 64));
    return 0;
}

static int l_GetWarMap(lua_State *L) {
    lua_pushnumber(L, jy_get_warmap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0)));
    return 1;
}
static int l_SetWarMap(lua_State *L) {
    jy_set_warmap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0));
    return 0;
}
static int l_CleanWarMap(lua_State *L) {
    jy_clean_warmap(argi(L, 1, 0), argi(L, 2, 0));
    return 0;
}

/* DrawWarMap(mode, camX, camY, a4, a5, animId, scene [, animSlot, ax, ay]) */
static int l_DrawWarMap(lua_State *L) {
    jy_draw_warmap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0),
                   argi(L, 5, 0), argi(L, 6, -1), argi(L, 7, -1), argi(L, 8, -1),
                   argi(L, 9, -1), argi(L, 10, -1));
    return 0;
}

/* LoadMMap(earth, surface, building, buildx, buildy, w, h, playerX, playerY) */
static int l_LoadMMap(lua_State *L) {
    const char *f[5];
    for (int i = 0; i < 5; i++) {
        f[i] = lua_tostring(L, i + 1);
        if (!f[i]) return 0;
    }
    jy_mmap_load(f, argi(L, 6, 480), argi(L, 7, 480));
    return 0;
}

static int l_UnloadMMap(lua_State *L) {
    jy_mmap_unload();
    return 0;
}

static int l_GetMMap(lua_State *L) {
    lua_pushnumber(L, jy_get_mmap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0)));
    return 1;
}

/* DrawMMap(playerX, playerY, myPic) */
static int l_DrawMMap(lua_State *L) {
    jy_draw_mmap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0));
    return 0;
}

/* DrawSMap(scene, playerX, playerY, offX, offY, myPic) */
static int l_DrawSMap(lua_State *L) {
    jy_draw_smap(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0),
                 argi(L, 5, 0), argi(L, 6, 0));
    return 0;
}

/* SaveSMap(sFile, dFile) */
static int l_SaveSMap(lua_State *L) {
    const char *sfile = lua_tostring(L, 1);
    const char *dfile = lua_tostring(L, 2);
    if (sfile && dfile) jy_smap_save(sfile, dfile);
    return 0;
}

static int l_GetS(lua_State *L) {
    lua_pushnumber(L,
                   jy_get_s(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0)));
    return 1;
}
static int l_SetS(lua_State *L) {
    jy_set_s(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0), argi(L, 5, 0));
    return 0;
}
static int l_GetD(lua_State *L) {
    lua_pushnumber(L, jy_get_d(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0)));
    return 1;
}
static int l_SetD(lua_State *L) {
    jy_set_d(argi(L, 1, 0), argi(L, 2, 0), argi(L, 3, 0), argi(L, 4, 0));
    return 0;
}

/* ---- not yet implemented ------------------------------------------------ */
#define STUB(name, nret)                                                                 \
    static int l_##name(lua_State *L) {                                                  \
        jy_todo(#name, lua_gettop(L));                                                   \
        for (int i = 0; i < (nret); i++) lua_pushnumber(L, 0);                           \
        return (nret);                                                                   \
    }

STUB(PlayMPEG, 0) /* never called by the scripts */

static const luaL_Reg LIB_FUNCS[] = {/* implemented */
                                     {"Debug", l_Debug},
                                     {"Delay", l_Delay},
                                     {"GetTime", l_GetTime},
                                     {"GetKey", l_GetKey},
                                     {"EnableKeyRepeat", l_EnableKeyRepeat},
                                     {"GetScreenW", l_GetScreenW},
                                     {"GetScreenH", l_GetScreenH},
                                     {"SetClip", l_SetClip},
                                     {"FillColor", l_FillColor},
                                     {"DrawRect", l_DrawRect},
                                     {"Background", l_Background},
                                     {"ShowSurface", l_ShowSurface},
                                     {"ShowSlow", l_ShowSlow},
                                     {"DrawStr", l_DrawStr},
                                     {"SaveSur", l_SaveSur},
                                     {"LoadSur", l_LoadSur},
                                     {"FreeSur", l_FreeSur},
                                     {"CharSet", l_CharSet},
                                     {"FullScreen", l_FullScreen},
                                     /* stubs */
                                     {"PicInit", l_PicInit},
                                     {"PicLoadFile", l_PicLoadFile},
                                     {"PicLoadCache", l_PicLoadCache},
                                     {"PicGetXY", l_PicGetXY},
                                     {"LoadPicture", l_LoadPicture},
                                     {"LoadPNG", l_LoadPNG},
                                     {"LoadPNGPath", l_LoadPNGPath},
                                     {"GetPNGXY", l_GetPNGXY},
                                     {"PlayMIDI", l_PlayMIDI},
                                     {"PlayWAV", l_PlayWAV},
                                     {"PlayMPEG", l_PlayMPEG},
                                     {"LoadMMap", l_LoadMMap},
                                     {"DrawMMap", l_DrawMMap},
                                     {"GetMMap", l_GetMMap},
                                     {"UnloadMMap", l_UnloadMMap},
                                     {"LoadSMap", l_LoadSMap},
                                     {"SaveSMap", l_SaveSMap},
                                     {"DrawSMap", l_DrawSMap},
                                     {"GetS", l_GetS},
                                     {"SetS", l_SetS},
                                     {"GetD", l_GetD},
                                     {"SetD", l_SetD},
                                     {"LoadWarMap", l_LoadWarMap},
                                     {"GetWarMap", l_GetWarMap},
                                     {"SetWarMap", l_SetWarMap},
                                     {"CleanWarMap", l_CleanWarMap},
                                     {"DrawWarMap", l_DrawWarMap},
                                     {NULL, NULL}};

void jy_open_lib(lua_State *L) {
    lua_newtable(L);
    luaL_register(L, NULL, LIB_FUNCS);
    lua_setglobal(L, "lib");
}
