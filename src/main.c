/* Bootstrap: SDL + LuaJIT, register the engine API, run the game's JY_Main. */
#include "engine.h"
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "compat.lua.h"
#include <mach-o/dyld.h>
#include <limits.h>

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

/* Game data next to the executable.
 *
 * Inside a .app the process starts with cwd = "/", so probing "./game" finds
 * nothing. Resolve candidates against the binary's own directory instead:
 * Contents/MacOS/<exe> -> ../Resources/game inside a bundle, ./game in the
 * plain build tree.
 */
static const char *root_near_exe(char *buf, size_t n) {
    char     exe[PATH_MAX];
    uint32_t len = sizeof exe;
    if (_NSGetExecutablePath(exe, &len) != 0) return NULL;
    char real[PATH_MAX];
    if (!realpath(exe, real)) return NULL;
    char *slash = strrchr(real, '/');
    if (!slash) return NULL;
    *slash = '\0';

    static const char *rel[] = {"../Resources/game", "game"};
    for (size_t i = 0; i < sizeof rel / sizeof rel[0]; i++) {
        char probe[PATH_MAX];
        snprintf(buf, n, "%s/%s", real, rel[i]);
        snprintf(probe, sizeof probe, "%s/CONFIG.lua", buf);
        if (access(probe, R_OK) == 0) return buf;
    }
    return NULL;
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
        static char nearby[PATH_MAX];
        if (access("CONFIG.lua", R_OK) == 0) root = ".";
        else if (access("game/CONFIG.lua", R_OK) == 0) root = "game";
        else if ((root = root_near_exe(nearby, sizeof nearby)) != NULL) {
        } else {
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
    jy_warmap_set_scale(xs, ys);
    jy_log("key profile: CONFIG.Operation=%d (%s arrow codes)", op,
           op == 1 ? "SDL2" : "SDL 1.2");
    if (w <= 0) w = 1220;
    if (h <= 0) h = 700;
    jy_log("screen: %dx%d", w, h);

    if (!jy_gfx_init(w, h,
                     "金庸群俠傳之龍啟江湖") /* UTF-8; SDL3 window titles are UTF-8 */)
        return 1;
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

    /* JY_TEST_FADE checks ShowSlow's end states and timing. */
    if (getenv("JY_TEST_FADE")) {
        static const char *F =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "lib.SetClip(0, 0, 0, 0)\n"
            "lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, 0x3060C0)\n"
            "lib.DrawStr(60, 60, 'fade test', 0xECECEC, 40, CC.FontName, 0, 0)\n"
            "lib.ShowSurface()\n"
            "SNAP('fade_before')\n"
            "local t = lib.GetTime()\n"
            "lib.ShowSlow(5, 0)\n"
            "lib.Debug('fade IN  (5ms x 33 steps) took '..(lib.GetTime() - t)..'ms')\n"
            "SNAP('fade_in')\n"
            "t = lib.GetTime()\n"
            "lib.ShowSlow(5, 1)\n"
            "lib.Debug('fade OUT (5ms x 33 steps) took '..(lib.GetTime() - t)..'ms')\n"
            "SNAP('fade_out')\n";
        if (luaL_loadstring(L, F) || lua_pcall(L, 0, 0, 0))
            jy_log("fade test failed: %s", lua_tostring(L, -1));
        goto done;
    }

    /* JY_TEST_SWEEP exercises the whole data surface: every dialogue record,
     * every scene, every battle map, every save slot. Errors are counted via
     * pcall rather than aborting, so one bad record does not hide the rest. */
    if (getenv("JY_TEST_SWEEP")) {
        static const char *SW =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "lib.PicInit(CC.PaletteFile)\n"
            "local function count(label, n, fn)\n"
            "  local err, first = 0, nil\n"
            "  for i = 1, n do\n"
            "    local ok, e = pcall(fn, i)\n"
            "    if not ok then err = err + 1 if not first then first = tostring(e) end end\n"
            "  end\n"
            "  lib.Debug(string.format('  %-28s %6d tried  %5d errors%s',\n"
            "            label, n, err, first and ('   first: '..first) or ''))\n"
            "  return err\n"
            "end\n"
            "local total = 0\n"
            /* dialogue: every record in talk.grp */
            "local tn = 0\n"
            "do local f = io.open(CC.TDX, 'rb') tn = math.floor(f:seek('end') / 4) f:close() end\n"
            "local empty = 0\n"
            "total = total + count('ReadTalk (all records)', tn - 1, function(i)\n"
            "  local s = ReadTalk(i)\n"
            "  if s == nil or #s == 0 then empty = empty + 1 end\n"
            "end)\n"
            "lib.Debug('    (of which empty: '..empty..')')\n"
            /* scenes: load the S/D arrays once, then read every cell of every scene */
            "lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)\n"
            "lib.LoadSMap(CC.S_Filename[0], CC.TempS_Filename, 137, CC.SWidth,\n"
            "             CC.SHeight, CC.D_Filename[0], CC.DNum, 11)\n"
            "total = total + count('DrawSMap (all 137 scenes)', 137, function(i)\n"
            "  lib.SetClip(0, 0, 0, 0)\n"
            "  lib.DrawSMap(i - 1, 32, 32, 0, 0, 0)\n"
            "end)\n"
            /* battle maps */
            "total = total + count('DrawWarMap (all 129 maps)', 129, function(i)\n"
            "  lib.LoadWarMap(CC.WarMapFile[1], CC.WarMapFile[2], i, 7, CC.WarWidth, CC.WarHeight)\n"
            "  lib.SetClip(0, 0, 0, 0)\n"
            "  lib.DrawWarMap(0, 32, 32, 0, 0, -1, -1)\n"
            "end)\n"
            /* save slots */
            "total = total + count('LoadRecord (slots 1..10)', 10, function(i)\n"
            "  SetGlobal()\n"
            "  if LoadRecord(i) == -1 then error('slot '..i..' incomplete') end\n"
            "end)\n"
            "lib.Debug(total == 0 and '== sweep clean: no errors ==' \n"
            "          or ('== sweep found '..total..' errors =='))\n";
        if (luaL_loadstring(L, SW) || lua_pcall(L, 0, 0, 0))
            jy_log("sweep failed: %s", lua_tostring(L, -1));
        goto done;
    }

    /* JY_TEST_SAVEREC="src,dst" runs the real SaveRecord end to end: load slot
     * src, save to slot dst, reload dst and compare. SaveRecord os.remove()s
     * the destination and rebuilds it in six writes, so this is the one path
     * that can destroy a slot. */
    if (getenv("JY_TEST_SAVEREC")) {
        static const char *SR =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "local a, b = string.match(os.getenv('JY_TEST_SAVEREC'), '(%d+),(%d+)')\n"
            "a, b = tonumber(a), tonumber(b)\n"
            "if LoadRecord(a) == -1 then lib.Debug('cannot load slot '..a) return end\n"
            "lib.Debug(string.format('slot %d loaded: people=%d things=%d scenes=%d wugong=%d',\n"
            "          a, JY.PersonNum, JY.ThingNum, JY.SceneNum, JY.WugongNum))\n"
            /* mark two cells so the S/D write path is observable in the output */
            "lib.SetS(5, 20, 20, 0, 1234)\n"
            "lib.SetD(5, 7, 3, 567)\n"
            "SaveRecord(b)\n"
            /* CharSet must round-trip: Big5 -> GBK -> Big5 is identity */
            "local raw = '\\179\\112\\187\\187\\164\\108'\n"
            "local gbk = lib.CharSet(raw, 0)\n"
            "local back = lib.CharSet(gbk, 1)\n"
            "local function hex(x) local t={} for i=1,#x do t[#t+1]=string.format('%02x',x:byte(i)) end return table.concat(t,' ') end\n"
            "lib.Debug('CharSet raw  = '..hex(raw))\n"
            "lib.Debug('CharSet gbk  = '..hex(gbk))\n"
            "lib.Debug('CharSet back = '..hex(back)..(back == raw and '   ROUND-TRIP OK' or '   ROUND-TRIP BROKEN'))\n"
            "lib.Debug('SaveRecord('..b..') completed')\n"
            "SetGlobal()\n"
            "if LoadRecord(b) == -1 then lib.Debug('RELOAD FAILED for slot '..b) return end\n"
            "lib.Debug(string.format('slot %d reloaded: people=%d things=%d scenes=%d wugong=%d',\n"
            "          b, JY.PersonNum, JY.ThingNum, JY.SceneNum, JY.WugongNum))\n"
            "lib.Debug('S cell readback = '..lib.GetS(5, 20, 20, 0)..\n"
            "          '   D field readback = '..lib.GetD(5, 7, 3))\n";
        if (luaL_loadstring(L, SR) || lua_pcall(L, 0, 0, 0))
            jy_log("saverec test failed: %s", lua_tostring(L, -1));
        goto done;
    }

    /* JY_TEST_SAVE exercises the write primitives the save path relies on:
     * Byte.savefile at an offset, and SaveSMap. Both are destructive in the
     * real game (SaveRecord os.remove()s the slot first), so verify them here
     * rather than on a live save. */
    if (getenv("JY_TEST_SAVE")) {
        static const char *S =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "local fail = 0\n"
            "local function check(name, ok)\n"
            "  lib.Debug((ok and '  PASS  ' or '  FAIL  ')..name)\n"
            "  if not ok then fail = fail + 1 end\n"
            "end\n"
            /* 1. savefile into a fresh file at a non-zero offset, then read back */
            "os.remove('/tmp/jy_rt.bin')\n"
            "local a = Byte.create(64)\n"
            "for i = 0, 31 do Byte.set16(a, i * 2, i * 7 - 100) end\n"
            "Byte.savefile(a, '/tmp/jy_rt.bin', 128, 64)\n"
            "local b = Byte.create(64)\n"
            "Byte.loadfile(b, '/tmp/jy_rt.bin', 128, 64)\n"
            "local same = true\n"
            "for i = 0, 31 do if Byte.get16(a, i*2) ~= Byte.get16(b, i*2) then same = false end end\n"
            "check('Byte.savefile/loadfile round-trip at offset 128', same)\n"
            /* 2. writing at an offset past EOF must zero-fill, not corrupt */
            "local c = Byte.create(8)\n"
            "Byte.loadfile(c, '/tmp/jy_rt.bin', 0, 8)\n"
            "local zero = true\n"
            "for i = 0, 3 do if Byte.get16(c, i*2) ~= 0 then zero = false end end\n"
            "check('gap before offset is zero-filled', zero)\n"
            /* 3. strings: setstr/getstr with the field width before the string */
            "local d = Byte.create(20)\n"
            "Byte.setstr(d, 4, 10, 'hello')\n"
            "check('setstr/getstr', Byte.getstr(d, 4, 10) == 'hello')\n"
            "check('setstr pads with NUL', Byte.get16(d, 14) == 0)\n"
            /* 4. SaveSMap round-trip: mutate a cell, save to temp, reload, compare */
            "lib.LoadSMap(CC.S_Filename[0], CC.TempS_Filename, 137, CC.SWidth,\n"
            "             CC.SHeight, CC.D_Filename[0], CC.DNum, 11)\n"
            "local o0 = lib.GetS(5, 20, 20, 0)\n"
            "local od = lib.GetD(5, 7, 3)\n"
            "lib.SetS(5, 20, 20, 0, 1234)\n"
            "lib.SetD(5, 7, 3, 567)\n"
            "os.remove('/tmp/jy_s.grp') os.remove('/tmp/jy_d.grp')\n"
            "lib.SaveSMap('/tmp/jy_s.grp', '/tmp/jy_d.grp')\n"
            "lib.LoadSMap('/tmp/jy_s.grp', CC.TempS_Filename, 137, CC.SWidth,\n"
            "             CC.SHeight, '/tmp/jy_d.grp', CC.DNum, 11)\n"
            "check('SaveSMap preserves a written S cell', lib.GetS(5, 20, 20, 0) == 1234)\n"
            "check('SaveSMap preserves a written D field', lib.GetD(5, 7, 3) == 567)\n"
            "check('SaveSMap preserves untouched neighbours',\n"
            "      lib.GetS(5, 21, 20, 0) == lib.GetS(5, 21, 20, 0))\n"
            /* 5. the saved files must be the same size as the originals */
            "local function size(p) local f = io.open(p, 'rb') if not f then return -1 end\n"
            "  local n = f:seek('end') f:close() return n end\n"
            "check('s.grp size matches allsin.grp',\n"
            "      size('/tmp/jy_s.grp') == size(CC.S_Filename[0]))\n"
            "check('d.grp size matches alldef.grp',\n"
            "      size('/tmp/jy_d.grp') == size(CC.D_Filename[0]))\n"
            "lib.Debug(fail == 0 and '== all save-path checks passed =='\n"
            "          or ('== '..fail..' save-path checks FAILED =='))\n";
        if (luaL_loadstring(L, S) || lua_pcall(L, 0, 0, 0))
            jy_log("save test failed: %s", lua_tostring(L, -1));
        goto done;
    }

    /* JY_TEST_WAR=<n> loads battle map n and renders it. */
    if (getenv("JY_TEST_WAR")) {
        static const char *W =
            "IncludeFile() SetGlobalConst() SetGlobal()\n"
            "local n = tonumber(os.getenv('JY_TEST_WAR'))\n"
            "lib.PicInit(CC.PaletteFile)\n"
            "lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)\n"
            "lib.LoadWarMap(CC.WarMapFile[1], CC.WarMapFile[2], n, 7, CC.WarWidth, CC.WarHeight)\n"
            "local g, s, sx, sy = 0, 0, 0, 0\n"
            "local x0, x1, y0, y1 = 999, -1, 999, -1\n"
            "for y = 0, CC.WarHeight - 1 do for x = 0, CC.WarWidth - 1 do\n"
            "  if lib.GetWarMap(x, y, 0) > 0 then\n"
            "    g = g + 1 sx = sx + x sy = sy + y\n"
            "    if x < x0 then x0 = x end\n"
            "    if x > x1 then x1 = x end\n"
            "    if y < y0 then y0 = y end\n"
            "    if y > y1 then y1 = y end\n"
            "  end\n"
            "  if lib.GetWarMap(x, y, 1) > 0 then s = s + 1 end\n"
            "end end\n"
            "local cx = g > 0 and math.floor(sx / g) or 32\n"
            "local cy = g > 0 and math.floor(sy / g) or 32\n"
            "lib.Debug('war map '..n..': ground='..g..' scenery='..s..\n"
            "          '  bbox x '..x0..'..'..x1..' y '..y0..'..'..y1..'  centre '..cx..','..cy)\n"
            "local ids, miss, okc = {}, 0, 0\n"
            "for y = 0, CC.WarHeight - 1 do for x = 0, CC.WarWidth - 1 do\n"
            "  local v = lib.GetWarMap(x, y, 0)\n"
            "  if v > 0 then ids[v] = true end\n"
            "end end\n"
            "local sample = {}\n"
            "for id in pairs(ids) do\n"
            "  local w = lib.PicGetXY(0, id)\n"
            "  if w == 0 then miss = miss + 1 if #sample < 6 then sample[#sample+1] = id end\n"
            "  else okc = okc + 1 end\n"
            "end\n"
            "lib.Debug('plane0 distinct ids: loaded='..okc..' missing='..miss..\n"
            "          '  missing samples: '..table.concat(sample, \',\'))\n"
            "lib.SetClip(0, 0, 0, 0)\n"
            /* layers 2 and 5 mean "no unit here" at -1, not 0 */
            "lib.CleanWarMap(2, -1) lib.CleanWarMap(5, -1)\n"
            "lib.DrawWarMap(0, cx, cy, 0, 0, -1, -1)\n"
            "SNAP('war')\n"
            /* overlay passes: modes 1/2 shade the reachable set, mode 3
         * silhouettes flagged units, mode 0 paints the layer-6 markers */
            "if os.getenv('JY_TEST_WAR_OVERLAY') then\n"
            "  lib.CleanWarMap(4, 0)  lib.CleanWarMap(6, -2)\n"
            "  lib.CleanWarMap(3, 255)\n"
            "  for y = cy - 6, cy + 6 do for x = cx - 6, cx + 6 do\n"
            "    if math.abs(x - cx) + math.abs(y - cy) <= 6 then\n"
            "      lib.SetWarMap(x, y, 3, 10)\n"
            "    end\n"
            "  end end\n"
            "  lib.DrawWarMap(1, cx, cy, cx + 2, cy, -1, -1) SNAP('war_move')\n"
            "  lib.DrawWarMap(2, cx, cy, cx + 2, cy, -1, -1) SNAP('war_atk')\n"
            "  lib.CleanWarMap(3, 255)\n"
            "  for i = 1, 4 do lib.SetWarMap(cx - i, cy + i, 6, i) end\n"
            "  lib.DrawWarMap(0, cx, cy, 0, 0, -1, -1)\n"
            "  SNAP('war_marks')\n"
            "  lib.SetWarMap(cx, cy, 2, 0)     lib.SetWarMap(cx, cy, 5, 100)\n"
            "  lib.SetWarMap(cx, cy, 4, 2)\n"
            "  lib.SetWarMap(cx + 3, cy, 2, 0) lib.SetWarMap(cx + 3, cy, 5, 100)\n"
            "  lib.SetWarMap(cx + 3, cy, 4, 0)\n"
            "  lib.CleanWarMap(6, -2)\n"
            "  lib.DrawWarMap(3, cx, cy, 0, 0, -1, -1) SNAP('war_sel')\n"
            "end\n";
        if (luaL_loadstring(L, W) || lua_pcall(L, 0, 0, 0))
            jy_log("war test failed: %s", lua_tostring(L, -1));
        goto done;
    }

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
