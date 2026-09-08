/* Windows text-mode compatibility shim, injected after the game's scripts load
 * and before JY_Main runs.
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
    "end\n";
