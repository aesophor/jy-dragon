/* Bootstrap: SDL + LuaJIT, register the engine API, run the game's JY_Main. */
#include "engine.h"
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "compat.lua.h"

/* ---- logging ------------------------------------------------------------ */
static FILE *g_logf;

void jy_log(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    fputc('\n', stderr);
    if (g_logf) {
        va_start(ap, fmt);
        vfprintf(g_logf, fmt, ap);
        va_end(ap);
        fputc('\n', g_logf);
        fflush(g_logf);
    }
}

/* ---- unimplemented-call census ----------------------------------------- */
#define MAX_TODO 64
typedef struct {
    const char *name;
    int         calls;
    int         nargs;
} TodoEnt;
static TodoEnt g_todo[MAX_TODO];
static int     g_ntodo;

void jy_todo(const char *fn, int nargs) {
    for (int i = 0; i < g_ntodo; i++)
        if (g_todo[i].name == fn || strcmp(g_todo[i].name, fn) == 0) {
            g_todo[i].calls++;
            if (nargs > g_todo[i].nargs) g_todo[i].nargs = nargs;
            return;
        }
    if (g_ntodo < MAX_TODO) g_todo[g_ntodo++] = (TodoEnt){fn, 1, nargs};
}

void jy_todo_report(void) {
    if (!g_ntodo) {
        jy_log("\n== no unimplemented lib.* calls ==");
        return;
    }
    /* most-called first: that is the order worth implementing them in */
    for (int i = 0; i < g_ntodo; i++)
        for (int j = i + 1; j < g_ntodo; j++)
            if (g_todo[j].calls > g_todo[i].calls) {
                TodoEnt t = g_todo[i];
                g_todo[i] = g_todo[j];
                g_todo[j] = t;
            }
    jy_log("\n== unimplemented lib.* calls, by frequency ==");
    for (int i = 0; i < g_ntodo; i++)
        jy_log("  %-16s %6d calls   (max %d args)", g_todo[i].name, g_todo[i].calls,
               g_todo[i].nargs);
}

/* SNAP(tag): dump the software framebuffer to /tmp/erase_<tag>.bmp */
static int l_snap(lua_State *L) {
    const char *tag = lua_tostring(L, 1);
    char        path[256];
    snprintf(path, sizeof(path), "/tmp/erase_%s.bmp", tag ? tag : "x");
    if (SDL_SaveBMP(g_e.screen, path)) jy_log("snap %s", path);
    else jy_log("snap failed: %s", SDL_GetError());
    return 0;
}

/* ---- lua error reporting ------------------------------------------------ */
static int traceback(lua_State *L) {
    const char *msg = lua_tostring(L, 1);
    lua_getglobal(L, "debug");
    lua_getfield(L, -1, "traceback");
    lua_remove(L, -2);
    lua_pushstring(L, msg ? msg : "(non-string error)");
    lua_pushinteger(L, 2);
    lua_call(L, 2, 1);
    return 1;
}

static bool run_file(lua_State *L, const char *path) {
    if (luaL_loadfile(L, path)) {
        jy_log("load %s failed: %s", path, lua_tostring(L, -1));
        lua_pop(L, 1);
        return false;
    }
    lua_pushcfunction(L, traceback);
    lua_insert(L, -2);
    if (lua_pcall(L, 0, 0, -2)) {
        jy_log("run %s failed: %s", path, lua_tostring(L, -1));
        lua_pop(L, 2);
        return false;
    }
    lua_pop(L, 1);
    return true;
}

int main(int argc, char **argv) {
    /* Root resolution: an explicit argument wins; otherwise use the current
     * directory if it holds CONFIG.lua, else the bundled ./game/. */
    const char *root = (argc > 1) ? argv[1] : NULL;
    if (!root) {
        if (access("CONFIG.lua", R_OK) == 0) root = ".";
        else if (access("game/CONFIG.lua", R_OK) == 0) root = "game";
        else {
            fprintf(stderr,
                    "no game data found. Run from a directory containing CONFIG.lua,\n"
                    "or pass the game root:  %s /path/to/game\n",
                    argv[0]);
            return 1;
        }
    }
    if (chdir(root) != 0) {
        fprintf(stderr, "cannot chdir to %s\n", root);
        return 1;
    }

    g_logf = fopen("port_debug.txt", "w");
    jy_log("== jyengine: native macOS port ==");

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    /* CONFIG.lua is plain Lua and sets CurrentPath/DataPath/ScriptLuaPath. */
    if (!run_file(L, "CONFIG.lua")) return 1;

    /* Screen size comes from CONFIG; 0 means "pick for me". */
    lua_getglobal(L, "CONFIG");
    lua_getfield(L, -1, "Width");
    int w = (int)lua_tonumber(L, -1);
    lua_pop(L, 1);
    lua_getfield(L, -1, "Height");
    int h = (int)lua_tonumber(L, -1);
    lua_pop(L, 1);
    lua_getfield(L, -1, "Operation");
    int op = (int)lua_tonumber(L, -1);
    lua_pop(L, 1);
    lua_pop(L, 1);
    jy_set_key_mode(op);
    lua_getglobal(L, "CONFIG");
    lua_getfield(L, -1, "XScale");
    int xs = (int)lua_tonumber(L, -1);
    lua_pop(L, 1);
    lua_getfield(L, -1, "YScale");
    int ys = (int)lua_tonumber(L, -1);
    lua_pop(L, 1);
    lua_pop(L, 1);
    jy_smap_set_scale(xs, ys);
    jy_mmap_set_scale(xs, ys);
    jy_log("key profile: CONFIG.Operation=%d (%s arrow codes)", op,
           op == 1 ? "SDL2" : "SDL 1.2");
    if (w <= 0) w = 1220;
    if (h <= 0) h = 700;
    jy_log("screen: %dx%d", w, h);

    if (!jy_gfx_init(w, h, "JY - native port")) return 1;
    jy_text_init();
    jy_audio_init();

    /* JY_SECONDS=<n> gives automated runs a bounded lifetime. */
    const char *budget = getenv("JY_SECONDS");
    if (budget) jy_set_deadline(SDL_GetTicks() + atof(budget) * 1000.0);

    lua_pushcfunction(L, l_snap);
    lua_setglobal(L, "SNAP");

    jy_set_scripted_keys(getenv("JY_KEYS"));

    jy_open_lib(L);
    jy_open_byte(L);

    /* The real engine loads ./script/jymain.lua then calls JY_Main(). */
    if (!run_file(L, "script/jymain.lua")) {
        /* fall back to the decompiled tree if the packed one is absent */
        if (!run_file(L, "_re/script_source/jymain.lua")) goto done;
    }

    /* Windows text-mode semantics the mod's checksum depends on. */
    if (luaL_loadstring(L, JY_COMPAT_LUA) || lua_pcall(L, 0, 0, 0))
        jy_log("compat shim failed: %s", lua_tostring(L, -1));
    else jy_log("compat: read_files patched for Windows text-mode semantics");

    /* JY_TEST_ERASE reproduces the dialogue-erase sequence in isolation:
     * draw map -> draw a dialogue box over it -> redraw map. Frames A and C
     * must be identical; anything left over is the bug. */
    if (getenv("JY_TEST_ERASE")) {
        static const char *E =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "lib.PicInit(CC.PaletteFile)\n"
            "lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)\n"
            "lib.LoadSMap(CC.S_Filename[0], CC.TempS_Filename, 137, CC.SWidth,\n"
            "             CC.SHeight, CC.D_Filename[0], CC.DNum, 11)\n"
            "lib.SetClip(0, 0, 0, 0)\n"
            "lib.DrawSMap(1, 12, 12, 0, 0, 0)\n"
            "SNAP('A')\n"
            "DrawBox(2, 2, 142, 142, C_WHITE)\n"
            "DrawBox(144, 2, 784, 142, C_WHITE)\n"
            "DrawString(154, 40, 'dialogue text', C_WHITE, 28)\n"
            "SNAP('B')\n"
            "lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)\n"
            "lib.DrawSMap(1, 12, 12, 0, 0, 0)\n"
            "SNAP('C')\n";
        if (luaL_loadstring(L, E) || lua_pcall(L, 0, 0, 0))
            jy_log("erase test failed: %s", lua_tostring(L, -1));
        goto done;
    }

    /* JY_TEST_TALK=<n> renders one dialogue record and dumps its bytes, so the
     * text pipeline can be checked without navigating to an NPC in-game. */
    if (getenv("JY_TEST_TALK")) {
        static const char *T =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "local n = tonumber(os.getenv('JY_TEST_TALK'))\n"
            "local raw = ReadTalk(n, true)\n"
            "local cooked = ReadTalk(n)\n"
            "local function hex(s, k)\n"
            "  local t = {}\n"
            "  for i = 1, math.min(#s, k) do t[#t+1] = string.format('%02X', s:byte(i)) end\n"
            "  return table.concat(t, ' ')\n"
            "end\n"
            "lib.Debug('talk raw    len='..#raw..'  '..hex(raw, 24))\n"
            "lib.Debug('talk cooked len='..#cooked..'  '..hex(cooked, 24))\n"
            "lib.Debug('screen='..tostring(CC.ScreenW)..'x'..tostring(CC.ScreenH)..' font='..tostring(CC.DefaultFont)..' C_WHITE='..tostring(C_WHITE))\n"
            "lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, 0)\n"
            "local y = 60\n"
            "for line in string.gmatch(cooked..'\\n', '([^\\n]*)\\n') do\n"
            "  if #line > 0 then\n"
            "    lib.Debug('drawing line len='..#line)\n"
            "    DrawString(40, y, line, C_WHITE, 28)\n"
            "    lib.DrawStr(40, y + 60, line, 0xECECEC, 28, CC.FontName, 0, 0)\n"
            "    lib.DrawStr(40, y + 120, 'ABC123', 0xECECEC, 28, CC.FontName, 0, 0)\n"
            "    y = y + 40\n"
            "  end\n"
            "end\n"
            "lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 800 * 100, 0, 100))\n"
            "local hw, hh, hox, hoy = lib.GetPNGXY(1, 501 * 2)\n"
            "lib.Debug('head 501: '..tostring(hw)..'x'..tostring(hh)..' anchor '..tostring(hox)..','..tostring(hoy))\n"
            "lib.LoadPNG(1, 501 * 2, 700, 200, 1)\n"
            "lib.ShowSurface()\n"
            "if os.getenv('JY_TEST_STALE') then\n"
            "  lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, 0)\n"
            "  lib.Debug('surface blanked without ShowSurface')\n"
            "end\n";
        if (luaL_loadstring(L, T) || lua_pcall(L, 0, 0, 0))
            jy_log("talk test failed: %s", lua_tostring(L, -1));
        SDL_Delay(400);
        goto done;
    }

    lua_getglobal(L, "JY_Main");
    if (!lua_isfunction(L, -1)) {
        jy_log("JY_Main not found");
        lua_pop(L, 1);
        goto done;
    }
    lua_pushcfunction(L, traceback);
    lua_insert(L, -2);
    if (lua_pcall(L, 0, 0, -2)) jy_log("JY_Main error: %s", lua_tostring(L, -1));

done:
    /* JY_SNAPSHOT=<path.bmp> dumps the framebuffer so headless runs can be
     * checked without a human looking at the window. */
    {
        const char *snap = getenv("JY_SNAPSHOT");
        if (snap && g_e.screen) {
            /* JY_SNAPSHOT_RAW dumps the software framebuffer instead of the
             * renderer, to tell "not drawn" apart from "not presented". */
            if (getenv("JY_SNAPSHOT_RAW")) {
                if (SDL_SaveBMP(g_e.screen, snap))
                    jy_log("snapshot (raw surface): %s", snap);
                else jy_log("snapshot failed: %s", SDL_GetError());
            } else {
                SDL_Surface *shot = jy_capture();
                if (shot) {
                    if (SDL_SaveBMP(shot, snap))
                        jy_log("snapshot (renderer readback): %s", snap);
                    else jy_log("snapshot failed: %s", SDL_GetError());
                    SDL_DestroySurface(shot);
                } else {
                    jy_log("readback failed (%s), falling back to framebuffer",
                           SDL_GetError());
                    SDL_SaveBMP(g_e.screen, snap);
                }
            }
        }
        jy_log("frames presented: %d", jy_present_count());
    }
    jy_todo_report();
    jy_audio_shutdown();
    jy_text_shutdown();
    jy_gfx_shutdown();
    lua_close(L);
    if (g_logf) fclose(g_logf);
    return 0;
}
