/* Post-load shim, injected after the game's scripts load and before JY_Main
 * runs. This is where behaviour changes go, so script/ stays a faithful
 * decompilation.
 *
 * 1. Windows text-mode read_files semantics, which the save checksum needs.
 *
 * The mod's save-integrity checksum (leijia -> hzbj in jymain.lua) reads the
 * save file through read_files(), which uses io.input() -- TEXT mode on
 * Windows. MSVCRT therefore collapses CRLF to LF and treats 0x1A as EOF, and
 * the checksums stored in save/d<N>.grp were computed under those semantics.
 *
 * Reading the same bytes faithfully on macOS yields a different sum
 * (261878 vs the stored 59515 for slot 1), so hzbj() reports
 * "文件结构异常" and restarts the game. Emulating the Windows behaviour here
 * keeps existing saves loadable.
 *
 * Only read_files is affected: read_files1 already opens "rb", and all bulk
 * binary access goes through the engine's own Byte.loadfile.
 */
static const char *JY_COMPAT_LUA =
    "local _raw_read_files = read_files\n"
    "function read_files(path, off, len)\n"
    "  local f = io.open(path, 'rb')\n"
    "  if not f then return _raw_read_files and _raw_read_files(path, off, len) or nil end\n"
    "  f:seek('set', off or 0)\n"
    "  -- CR removal can only shrink the result, so 2n+16 raw bytes is a safe upper bound\n"
    "  local d = f:read((len or 0) * 2 + 16) or ''\n"
    "  f:close()\n"
    "  local z = string.find(d, '\\26', 1, true)   -- 0x1A ends the stream in text mode\n"
    "  if z then d = string.sub(d, 1, z - 1) end\n"
    "  d = string.gsub(d, '\\r\\n', '\\n')\n"
    "  return string.sub(d, 1, len)\n"
    "end\n"
    /* ---------------------------------------------------------------------- *
     * CC.Frame is the main loop's target milliseconds per iteration, and it
     * paces everything time-based -- NPC animation advances every 4th
     * iteration (DtoSMap), so a wrong value scales animation speed directly.
     *
     * LoadRecord reads it from DATA/CircleNum at offset 2200 + 2*slot, but the
     * mod's own layout puts slot 10's 20-byte timestamp at 2000 + 20*10 =
     * 2200, overlapping the frame bytes for slots 0..9. Slot 1 therefore reads
     * "02" out of the middle of "'2025-01-26 22:29:37" and gets 2.
     *
     * tonumber() succeeds on that garbage, so the game's own `else CC.Frame =
     * 30` fallback never triggers. The original survived because it was slow
     * enough to be compute-bound near the intended rate; this engine runs an
     * iteration in ~8ms, so the loop free-ran at ~120/s and NPC animation was
     * about 4x too fast.
     *
     * Clamp to the three speeds the settings menu actually offers
     * (原速 30 / 快速 20 / 极快 10), defaulting to the game's own default.
     * ---------------------------------------------------------------------- */
    "local _LoadRecord = LoadRecord\n"
    "function LoadRecord(n)\n"
    "  local r = _LoadRecord(n)\n"
    "  local f = CC and CC.Frame\n"
    "  if f ~= 30 and f ~= 20 and f ~= 10 then\n"
    "    CC.Frame = 30\n"
    "    lib.Debug('compat: CC.Frame was '..tostring(f)..' (corrupt CircleNum), using 30')\n"
    "  end\n"
    "  return r\n"
    "end\n"
    /* ---------------------------------------------------------------------- *
     * Title backdrop: one title.png instead of a random pick of four.
     *
     * loadpng1() rolls math.random(5) over CC.FirstFile1..4 (jymain.lua:140),
     * and MyOEvent's two leaderboard screens draw CC.FirstFile1 directly. All
     * five sites read the constants, so pointing the constants at title.png
     * covers them without touching the decompiled scripts.
     *
     * The hook goes through IncludeFile rather than SetGlobalConst: the
     * latter lives in jyconst.lua, which IncludeFile is what loads, so it
     * does not exist yet when this shim runs. Falls back to the original four
     * if title.png is absent, so a game/ without it still shows a title.
     * ---------------------------------------------------------------------- */
    "local _IncludeFile = IncludeFile\n"
    "function IncludeFile()\n"
    "  _IncludeFile()\n"
    "  local _SetGlobalConst = SetGlobalConst\n"
    "  function SetGlobalConst()\n"
    "    _SetGlobalConst()\n"
    "    local t = CONFIG.PicturePath .. 'title.png'\n"
    "    local f = io.open(t, 'rb')\n"
    "    if not f then return end\n"
    "    f:close()\n"
    "    CC.FirstFile1, CC.FirstFile2, CC.FirstFile3, CC.FirstFile4 = t, t, t, t\n"
    "  end\n"
    "end\n";
