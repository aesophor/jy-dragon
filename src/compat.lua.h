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
    "end\n"
    /* ---------------------------------------------------------------------- *
     * Lift the title menu off the bottom edge.
     *
     * jyconst.lua:2761 anchors it to the window:
     *   CC.StartMenuY = ScreenH - 3 * (StartMenuFontSize + RowPixel) - 20
     * which leaves the three rows sitting 20px from the bottom. That was right
     * at 640x480, where the art filled every pixel. The art is still 640x480
     * and LoadPicture centres it, so in a 1220x700 window it spans y 110..590
     * and the menu block (554..680) hung 90px past it onto bare black.
     *
     * Raising it by two row heights puts the block at 470..596 -- its bottom
     * edge level with the art's -- and the term scales with the font, so it
     * holds at other window sizes instead of being a magic number for this
     * one. Three "请稍候..." boxes share CC.StartMenuY and move with it, which
     * is what you want: same screen, same place.
     * ---------------------------------------------------------------------- */
    "local _IncludeFile2 = IncludeFile\n"
    "function IncludeFile()\n"
    "  _IncludeFile2()\n"
    "  local _SGC = SetGlobalConst\n"
    "  function SetGlobalConst()\n"
    "    _SGC()\n"
    "    CC.StartMenuY = CC.StartMenuY - 2 * (CC.StartMenuFontSize + CC.RowPixel)\n"
    "  end\n"
    "end\n"
    /* ---------------------------------------------------------------------- *
     * Blank the screen behind the title menu.
     *
     * StartMenu opens with Cls(), which dispatches on JY.Status: only the
     * GAME_START branch clears to black, the others REDRAW the live map
     * (jymain.lua:6365). Menu_Exit reaches StartMenu without touching
     * JY.Status (jymain.lua:1942), so returning to the title mid-game leaves
     * the scene painted underneath and loadpng1 drops the art on top of it.
     *
     * Invisible in the original, which ran at the art's own 640x480 so the
     * picture covered every pixel. LoadPicture does not clear -- sub_407CB0 is
     * IMG_Load, SDL_DisplayFormat, centre, SDL_UpperBlit, nothing else -- so
     * at 1220x700 the uncovered border shows the map you just left.
     *
     * Setting the status to match where we actually are lets the game's own
     * Cls() do the clearing. Every StartMenu branch that resumes play assigns
     * JY.Status itself (GAME_SMAP for new game and for a load, GAME_FIRSTMMAP
     * for a save with no scene, JY_Main for quit), so nothing downstream reads
     * the value this overwrites.
     * ---------------------------------------------------------------------- */
    "local _StartMenu = StartMenu\n"
    "function StartMenu()\n"
    "  JY.Status = GAME_START\n"
    "  return _StartMenu()\n"
    "end\n"
    /* ---------------------------------------------------------------------- *
     * Drop the 打赏&赞助 (tip / sponsor) entry from the 系统 menu.
     *
     * ShowMenu already has the mechanism: it copies only the entries whose
     * third field is > 0 (jymain.lua:4912) and returns the selected entry's
     * ORIGINAL index out of the fourth (5275), which Menu_System's own
     * `var_22_1 == 7` / `== 8` tests depend on. Setting the flag to 0 is what
     * the same function does two lines later to grey out save/load in scenes
     * 42, 82 and 13, so nothing downstream shifts.
     *
     * Matching on the callback rather than the label is deliberate: the mod
     * relabels index 3 to "打开音乐" when JY.EnableMusic is 0 (jymain.lua:1396,
     * left over from a menu that had music toggles), so the string is not
     * reliably there. Menu_zhanzhu has exactly one reference, so hooking
     * ShowMenu globally can only ever match this one entry.
     * ---------------------------------------------------------------------- */
    "local _ShowMenu = ShowMenu\n"
    "function ShowMenu(m, n, ...)\n"
    "  for i = 1, n do\n"
    "    local it = m[i]\n"
    "    if it and it[2] == Menu_zhanzhu then it[3] = 0 end\n"
    "  end\n"
    "  return _ShowMenu(m, n, ...)\n"
    "end\n";
