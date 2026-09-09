# Reverse engineering `Dragon.exe`

How the engine in `src/` was recovered: unpacking the Windows build, getting
the Lua out of it, rebuilding its import table, and what actually works when
driving IDA through `ida-pro-mcp`.

Everything produced along the way lives in the `_re/` tree, which sits beside
`port/` rather than inside it (`../../_re/` from this file). Paths below are
written as `_re/…`; that is what they mean.

## What you are up against

`Dragon.exe` is 7.6 MB on disk, PE32, packed with **Enigma Protector**. Enigma
does two things that matter:

1. **The image is encrypted on disk** and only decrypted into memory at
   startup, so a static disassembly of the file is worthless.
2. **The game's own files are in a virtual filesystem** baked into the
   executable. Enigma hooks the file APIs process-wide, so `SCRIPT/jymain.lua`
   opens fine from inside the process and does not exist on disk at all.

Underneath, the engine is ordinary: **LuaJIT 2.1** (shipped as `lua51.dll`)
driving **SDL 1.2**, SDL_ttf, SDL_image, BASS + BASSMIDI, and smpeg. All the
game logic is Lua; the DLL boundary is where it becomes reachable.

That last point is the whole strategy. **Do not fight the packer. Attack the
one boundary it leaves in the open: `lua51.dll`.**

## 1. Unpack: proxy `lua51.dll`

Source: `_re/lua51-proxy-src/`.

Rename the real `lua51.dll` to `lua51_real.dll` and drop in a replacement that
forwards every export to it. Because the proxy runs *inside* the unpacked
process, it can see everything Enigma has already decrypted.

`gen.py` reads the export list and emits two files:

- `lua51.def` — every export, so the linker produces a DLL with a matching
  export table.
- `thunks.c` — a `void *p_<name>` slot per export, plus a naked
  `jmp *_p_<name>` stub for every export **except** the seven load entry
  points. Those seven are written by hand in `proxy.c`.

The seven hooks are the ones a chunk of Lua can possibly arrive through:

    luaL_loadbuffer   luaL_loadbufferx   luaL_loadfile   luaL_loadfilex
    luaL_loadstring   lua_load           lua_loadx

`lua_load` streams through a reader callback, so the hook wraps the reader and
accumulates what it hands back. `luaL_loadfile` gets the path, not the bytes —
so the hook `fopen`s it itself, which works precisely because Enigma's file
hooks are process-wide and hand back decrypted bytes.

`DllMain` loads `lua51_real.dll` **from the proxy's own directory** (not the
cwd, which is the game root and would find the proxy again) and fills every
slot with `GetProcAddress`.

The capture itself ran under **CrossOver/Wine on macOS**, not on Windows;
`_proxy.log`'s module list shows Wine's `ntdll.dll`/`kernel32.dll` alongside
`Y:\Code\Dragon\Dragon.exe`. Nothing in the approach depends on that, but it
does mean step 2 looks for DLLs in the bottle's `system32` as well as next to
the game.

Build with mingw (`build.sh`):

    i686-w64-mingw32-gcc -O2 -shared -o lua51.dll proxy.c thunks.c lua51.def \
        -static-libgcc -lpsapi -lkernel32 -luser32

The first `dump_chunk` also triggers, once each:

**A full memory image of the host EXE.** Copied page by page from
`GetModuleHandleA(NULL)` so one unreadable page zero-fills instead of killing
the dump. Written twice:

- `dragon_image.bin` — flat, load in IDA as a binary at `0x400000`.
- `dragon_dumped.exe` — the same bytes with each section's
  `PointerToRawData` set to its `VirtualAddress` and `SizeOfRawData` to its
  `VirtualSize`, and `FileAlignment = SectionAlignment`. **Raw offsets now
  equal RVAs**, which is what makes it directly loadable and keeps every
  address in your notes equal to the runtime VA. This is the file to open in
  IDA. (`_re/engine_re.bin` is a copy of it, and `engine_re.bin.i64` is the
  database.)

**The loaded module list** (`EnumProcessModules` + `GetModuleInformation`),
logged as `mod <base> size=<n> <path>`. This looks like a throwaway diagnostic
and is not — step 2 cannot happen without it.

**A recursive copy of the virtual filesystem**, walked with
`FindFirstFileA`/`FindNextFileA` from `.`, with `DATA`, `SOUND`, `FONT` and
`save` skipped because those exist on disk for real. Output goes to
`luadump/vfs/`, with `_vfs_manifest.txt` listing everything including what was
skipped. This is where `SCRIPT/` and `PIC/` come from — the mod's 20 Lua
modules and its title art exist nowhere else.

Result, from `_proxy.log`:

    === lua51 proxy attached, real=00E50000 ===
    [0001] loadfile   len=4139     ./config.lua
    dump: base=00400000 SizeOfImage=0x3ce000 sections=7

## 2. Rebuild the import table

Source: `_re/resolve_imports.py`. Output: `_re/imports.txt` (1384 entries).

A dumped image has a **resolved** IAT: Enigma already replaced every slot with
a live function pointer, and the original names are gone. But you logged every
module's load base in step 1, so the inverse is mechanical:

    slot value -> (module, RVA) -> export name

For each IAT slot, find the module whose `[base, base+size)` contains it, take
the difference as an RVA, and look that RVA up in that DLL's export table.
The DLLs are next to the game, or in the Wine/CrossOver bottle's
`system32`. `lua51.dll` is overridden to point at the proxy that was actually
loaded (`_re/lua51_proxy_used.dll`), since that is the module the addresses
came from.

This is what turns `MEMORY[0x7B96F910](a1, aRb)` in Hex-Rays into `fopen`, and
it is worth doing before any serious decompilation.

## 3. Find the Lua API

Source: `_re/find_api.py`. Output: `_re/lua_api.txt`, `_re/engine_api.md`.

`luaL_Reg` is `{const char *name; lua_CFunction fn;}`, terminated by
`{NULL, NULL}`. So scan the image for runs of pairs where the first word
points at a plausible ASCII identifier and the second points into an
executable section. The section table in the dump gives the executable ranges.

Five arrays match. Two of them are the engine's:

| array | entries | what |
|---|---|---|
| `0x0040a240` | 46 | the `lib` table — graphics, input, audio, maps |
| `0x0040a3b8` | 11 | the `Byte` table — binary record access |

The other three are noise, and the shape of the noise is worth recognising:

- `0x005826c8` (73 entries) is Enigma's name→thunk table for the Windows APIs
  it intercepts. **Every entry points at the same address** (`0x004b5f30`),
  which is the tell.
- `0x0057c418` and `0x0058ac10` are Borland RTL string tables — variant type
  names (`Smallint`, `Currency`, `OleStr`) and dialog captions (`Yes`, `OK`,
  `Abort`). They are `{string, pointer}` pairs that happen to match, and you
  reject them by reading the names.

A structural scan will always over-match. Budget for eyeballing the hits.

`lua_api.txt` then gives you a **named entry point for every single engine
function**. This is the most valuable artifact in `_re/`: you never have to go
looking for behaviour, because you already have its address.

## 4. Bytecode to source

The `SCRIPT/*.lua` files in the VFS start with `1B 4C 4A 02` — ESC `L` `J`,
LuaJIT 2.1 bytecode, not source. `_re/ljd2.exe` (a LuaJIT decompiler) turns
the 20 modules in `_re/script_bytecode/` into `_re/script_source/`.

The output is faithful but unnamed: locals come out as `var_11_0`,
parameters as `arg_29_1`. **Leave them.** `game/script/` is a verbatim copy of
this, and keeping it byte-identical to the decompiler's output is what makes
it trustworthy as a reference. Behaviour changes belong in
`src/compat.lua.h`, never here.

`_re/script_source_utf8/` is the same tree re-encoded for reading; the shipped
`game/script/` is UTF-8 and gets transcoded back to GBK on load by
`src/script.c`.

## 5. Data formats

`_re/data_formats.md` documents the `.idx`/`.grp` container, the fixed-record
schemas, the save layout and the battle maps, all verified against the shipped
files. `_re/data_schemas.json` is the machine-readable field table,
`_re/jydata.py` reads records with it, and `_re/decode_sprite.py` decodes the
RLE sprite format.

## 6. Working with `ida-pro-mcp`

Open `_re/engine_re.bin` (the rebuilt PE). Imagebase is `0x400000` and raw
offsets equal RVAs, so **every address in `lua_api.txt`, `imports.txt` and
this document is directly usable** — no rebasing, no file-offset arithmetic.

    idb_open(input_path="…/_re/engine_re.bin")

The session id it returns is reused for every later call, and the `.i64`
persists between sessions, so renames and types you apply survive.

What actually mattered, in rough order of value:

**Start from an address, never from a search.** `lua_api.txt` maps every Lua
callable to its VA. When a behaviour looks wrong in the port, you already know
which function implements it — go straight there. `search_text` and
`list_funcs` are for when that fails, which is rarely.

**`decompile` first, `disasm` only when the pseudocode is hiding something.**
Hex-Rays is good enough on this binary that most questions are answered by one
`decompile` call. Pass `include_addresses: false` unless you need the line
markers; it roughly halves the output.

**`MEMORY[0x7B96F910](…)` is an unresolved import, not a mystery.** Those are
absolute calls into a DLL Hex-Rays knows nothing about. Look the address up in
`imports.txt` — or, if it is missing there, find the module in `_proxy.log`'s
`mod` lines and take the RVA. `sub_401850` reads as three anonymous
`MEMORY[…]` targets until you resolve them into `fopen`/`fread`/`fclose`, at
which point it is obviously a file loader.

**`xrefs_to` on a *data* address is how you find the code that fills a
table.** The `CharSet` conversion tables were four bare `word_4xCCE0` arrays,
empty in the static image because they are loaded at runtime.
`xrefs_to(0x40CCE0)` gave the reader (`sub_4016E0`) and the writer
(`sub_401850`); one more `xrefs_to` on the writer gave `sub_4019A0`, whose
adjacent string literals (`aLoadmb` = `"LoadMB();"`, `aHzmbDat` =
`"hzmb.dat"`) named the file. That chain — reader, writer, caller, string —
took four calls and settled the format completely.

**Nearby strings name things.** The decompiler result lists a `refs` array
with the string at each referenced address. `sub_4019A0` is unreadable as
`sub_401E10(aLuaConfig)` and obvious as `debug("Lua_Config();")`. Read the
refs before you read the code.

**Make the binary prove it — with arithmetic.** Every format claim in this
project was confirmed by a count that could not be a coincidence:

- `hzmb.dat`'s loader loops `126 * 190` then `95 * 157` entries, 4 bytes each
  = **155420** bytes, exactly the file's size.
- `FONT.C16` indexes 89 Big5 leads × 157 trails = **13973** glyphs, exactly
  `size / 32`.
- `hzmb.dat`'s Big5→Unicode table maps **13973 of 13973** of those cells.

If the arithmetic does not land exactly, the interpretation is wrong. This
catches far more than staring at hex does.

**Do not trust Hex-Rays' calling conventions.** `sub_402340` decompiles as
`int __usercall sub_402340@<eax>(double a1@<st0>, int a2)`. There is no
double; that is the decompiler mis-attributing an FPU register across a call
it cannot see through. The argument order and types come from the *call sites*
and from the Lua side, not from the signature.

**Recover the exact semantics before "fixing" anything.** Three bugs in this
port were plausible-looking C that did not match the original:
`FillColor(0,0,0,0,c)` filling one pixel instead of the clip region,
`Byte.set16` raising on a string where the original silently stored 0, and
`CharSet` converting by code point where the original used a
Simplified↔Traditional table. Each looked correct in isolation, and each broke
something several layers away. The binary is the specification; the port is
never the place to guess.

**Then prove it at runtime.** Static recovery gives you the shape; only
running it confirms you read it right. The engine's `JY_*` environment hooks
exist for this — `JY_KEYS` walks menus headlessly, `JY_SNAPSHOT` dumps the
framebuffer, `JY_TEST_*` run one subsystem in isolation. A recovered claim
that has not been executed is a hypothesis.

## 7. Artifact map

| path | what |
|---|---|
| `_re/lua51-proxy-src/` | the proxy DLL: `gen.py`, `proxy.c`, `build.sh` |
| `_re/_proxy.log` | proxy output: chunk list, section table, module bases |
| `_re/_vfs_manifest.txt` | everything inside Enigma's virtual filesystem |
| `_re/dragon_image.bin` | flat memory image, load at `0x400000` |
| `_re/dragon_dumped.exe` | same bytes, raw offsets == RVAs |
| `_re/engine_re.bin` (`.i64`) | copy of the above; **the IDA database** |
| `_re/resolve_imports.py` → `imports.txt` | rebuilt import table, 1384 entries |
| `_re/find_api.py` → `lua_api.txt` | `luaL_Reg`-shaped arrays; the engine's two hold 46 + 11 |
| `_re/engine_api.md` | the API grouped by subsystem |
| `_re/ljd2.exe` | LuaJIT decompiler |
| `_re/script_bytecode/` → `script_source/` | the 20 game modules |
| `_re/PIC/` | title art, out of the VFS |
| `_re/data_formats.md`, `data_schemas.json` | container and record formats |
| `_re/jydata.py`, `decode_sprite.py` | record reader, sprite decoder |

## Recovered behaviour

Each of the following was read out of the original binary and then confirmed
by running it. They are the specification the port is written against.
### Traditional display (`CONFIG.Traditional`)

`CONFIG.Traditional = 1` renders Simplified text as Traditional. It is a
**display** conversion, applied in `text.c` to the UCS-2 code points on their
way to FreeType -- script bytes, table keys, save contents and every
byte-length calculation are untouched. `JY_TRAD=0`/`1` overrides the config
entry for A/B checks.

The obvious approach -- rewriting the literals in `script/*.lua` -- does not
work, and not for want of care. Simplified characters live in GB2312 proper,
where the trail byte is always `>= 0xA1`. Traditional characters live in GBK's
extension areas, where it is frequently **ASCII**:

| character | GBK | trail byte |
|---|---|---|
| `众` -> `衆` | `D0 5C` | `0x5C` = `\` |
| `并` -> `並` | `81 4B` | `0x4B` = `K` |
| `御` -> `禦` | `B6 52` | `0x52` = `R` |
| `发` -> `發` | `B0 6C` | `0x6C` = `l` |

A converted literal therefore contains a backslash or a quote as far as the
lexer is concerned. Converting the tree and compiling it makes **18 of the 20
scripts fail to parse** (`invalid escape sequence`, `unfinished string`,
`']' expected near '='`). Big5 has ASCII trail bytes too, so switching the
runtime encoding does not help; only a UTF-8 runtime would, and that is
blocked by the byte arithmetic described below.

The map is OpenCC's **s2tw** (Taiwan standard), 2744 one-to-one BMP pairs,
generated by `tools/gen_s2t.py` into `src/s2t_table.h` and binary-searched.
Phrase-level substitutions (`软件` -> `軟體`) are deliberately excluded because
they change the character count, and the scripts derive pixel widths from
string byte lengths -- a 1:1 map cannot move any text.

Two things to know about the result:

- It also converts **data-file** text, and that is now the main thing it does.
  `lib.CharSet(s, 0)` hands every record and dialogue string to the scripts in
  its *Simplified* form -- `hzmb.dat` pairs Big5 俠 with GBK 侠, not with GBK's
  own 俠 -- so with `CONFIG.Traditional = 0` data text renders Simplified,
  matching the mod's own literals, and with `1` both come out Traditional.
  (An earlier measurement here, 0.36% of dialogue characters altered, was taken
  when `CharSet` was a codepoint conversion that left data text Traditional. It
  no longer describes the input.)
- Character-level conversion cannot disambiguate by context, so a Traditional
  `干` or `后` in data would be mapped to `幹`/`後`. Neither appeared in the
  sampled text, but the limitation is real.

`JY_TEST_TRAD=1` draws one GBK line at two sizes and snapshots it, and reports
the byte length so the "nothing moves" claim is visible.

### Script encoding

The scripts on disk are **UTF-8** -- readable and editable in any modern
editor. `src/script.c` detects the encoding of each file and transcodes UTF-8
sources to **GBK** before LuaJIT sees them, so the bytes the interpreter runs
are byte-identical to the original GBK decompilation.

That indirection is not cosmetic. The scripts do their own byte arithmetic on
CJK text, and every bit of it assumes two bytes per wide character:

| site | what it does |
|---|---|
| `jymain.lua:6404` | `GenTalkString` steps 2 bytes per wide char to wrap talk text, and budgets each line as `2 * columns - 1` bytes |
| `jywar.lua:22000` | `string.sub(s, n*2 - 1, n*2)` slices out the n-th character |
| `jymain.lua:3624` | `string.len(s) / 2 * font` is how pixel widths are computed -- about thirty sites do this, in `/2` and `/4` variants |
| `MyOEvent.lua:9360` | `string.byte(s, -1) > 127` tests for a trailing wide char |

A CJK character is 3 bytes in UTF-8, so converting the literals without
touching that arithmetic would slice characters in half when wrapping dialogue
and leave every centred label 1.5x too wide. Transcoding at load keeps all of
it true, with nothing to re-verify.

Detection is per file, so GBK and UTF-8 scripts coexist -- a file that is valid
UTF-8 *and* uses a multi-byte sequence is transcoded, anything else is passed
through. GBK text does not survive UTF-8 validation in practice: its trail
bytes run `0x40`-`0xFE`, and those above `0xBF` cannot be UTF-8 continuation
bytes. All 20 shipped scripts round-trip GBK -> UTF-8 -> GBK losslessly.

A character with no GBK mapping is a hard error naming the file, line, byte
offset and bytes, rather than a silent substitution -- a mangled literal would
otherwise fail a comparison against Big5 data much later:

    script: ./script/__bad.lua:1 has a character GBK cannot represent
            (byte 11: F0 9F 90) -- not in GBK

`JY_SCRIPT_DUMP=<dir>` writes out exactly what was handed to LuaJIT, which is
how the byte-identity claim above is checked.

To convert an existing GBK tree (`game/` is not tracked, so a fresh setup from
the original data starts out GBK):

    tools/to_utf8.py game/script game/CONFIG.lua
    tools/to_utf8.py --to-gbk game/script      # and back

The tool refuses to write anything that does not round-trip.

Data files are unaffected: they stay **Big5**, bridged by `lib.CharSet`.

### ShowSlow (recovered, verified)

`lib.ShowSlow(msPerStep, mode)` is a fixed **33-step** fade (counter 32..0), not
a step count -- the argument is milliseconds per step, so `ShowSlow(50, 0)` runs
for ~1.7s. Each step fills the screen black, blits a snapshot of the pre-fade
framebuffer over it at `alpha = counter * 8` (clamped to 255), presents, and
delays so the step lasts at least `msPerStep`.

| mode | counter | alpha | effect |
|---|---|---|---|
| 0 | counts up | 0..255 | fade **in** from black |
| non-zero | counts down | 255..0 | fade **out** to black |

End states verified by `JY_TEST_FADE`: fade-in finishes at the original image
(44.0% mean brightness, unchanged), fade-out at pure black (0.0%).

Because each step presents, very small `msPerStep` values are bounded by the
display rather than the delay (5ms/step measured ~12ms/step). Visually
identical; only sub-frame fades run slower than the original.

### Battle map layout (recovered, verified)

Seven layers of 64x64 `int16`, indexed layer-major like the scene maps:
`buf[layer*w*h + y*w + x]`. `LoadWarMap(idx, grp, n, 7, 64, 64)` allocates all
seven but reads only **two** from `warfld.grp` -- a record is 16384 B =
64*64*2*2. The other five are runtime combat state the scripts fill via
`SetWarMap` / `CleanWarMap`:

| layer | meaning |
|---|---|
| 0 | ground/floor sprite (from file) |
| 1 | wall/scenery sprite (from file) |
| 2 | occupying team id; also selects the unit sprite slot (`team + 4`) |
| 3 | movement-range cost -- `< 128` means reachable |
| 4 | per-cell flag; mode 3 dims cells with value <= 1 |
| 5 | unit sprite id |
| 6 | marker type 1..4, drawn as a coloured overlay |

The `.idx` gives the record offset at `(n-1)*4`; `n == 0` means offset 0.
`CleanWarMap(layer, value)` fills an entire layer.

Elevation comes from the **scene** map's layer 4, not the battle map: the 7th
argument to `DrawWarMap` is a scene id, and the renderer offsets each cell by
`GetS(scene, x, y, 4)`. Battles do *not* draw the scene underneath -- the
battle map's own layer 0 is the whole floor, so empty cells are genuine void.

Planes 0 and 1 are roughly complementary: narrow walkable corridors against a
dense wall mass. On cave maps the floor tiles are near-black (mean brightness
~123/765), so large dark areas are correct, not missing tiles.

### Sprite blit flags (recovered, verified)

`PicLoadCache(slot, id, x, y, flags, alpha)` -- and the tinted form
`DrawWarMap` uses internally -- take a bitfield that `sub_408710` decodes:

| bit | meaning |
| --- | --- |
| `1` | draw at `(x,y)` verbatim instead of at the sprite's hotspot |
| `2` | enable alpha blending; **without it `alpha` is ignored** and the blit is opaque |
| `4` | flat black -- checked first, so `4` beats `8` and `0x10` |
| `8` | flat white |
| `0x10` | flat fill with the colour argument |

Bits `4`/`8`/`0x10` are only consulted when bit `2` is set, and they *replace*
the art rather than shading it: the original builds a scratch copy of the
sprite and overwrites every non-colour-key pixel. So `DrawWarMap`'s range
overlays are tile-shaped **silhouettes** -- flat black at `alpha 64` for the
movement range (`flags 6`), flat white for the attack range (`flags 10`),
doubled to `128` on the cell under the cursor -- and the layer-6 markers
(`flags 18`, `alpha 192`) are solid lozenges in one of four colours:

    1  0x05D010 green    3  0x0000F0 blue
    2  0xD52210 orange   4  0xA010A0 purple

Mode 3 blits units whose layer-4 flag is `> 1` as an **opaque** black
silhouette (`flags 6`, `alpha 255`); the rest draw normally.

Two details worth knowing:

- Alpha is clamped to 255 before the blit (`0x408726`), so scripts passing
  larger values get an opaque blit rather than wrapping.
- Passes 1 and 2 walk one **screen row** per outer step, downwards -- the
  original's inner loop holds `i+j` constant. Iterating by column instead lets
  a shallower row's tile paint over a deeper row's marker and erase it.

One data quirk that is **not** a port bug: the marker mask is record 0 of
whatever archive is in pic slot 0, and `smap.grp`'s record 0 carries hotspot
`(0,0)` where every other tile uses `(18,17)`. Battles load `wmap.grp`
(record 0 correct), but the outdoor variant at `jywar.lua:18903` loads `smap`,
where the original misplaces its markers too.

### `Byte`'s numeric arguments (recovered, verified)

Every numeric argument to the `Byte` functions goes through the **raw
`lua_tonumber`**, not `luaL_checknumber`. `sub_403300` (`set16`/`setu16`) is
the whole story:

    lua_touserdata(L, 1)     ; buffer
    lua_tonumber(L, 2)       ; offset
    lua_tonumber(L, 3)       ; value
    *(WORD *)(buf + off) = value

`sub_403490` (`setstr`) is the same, with `lua_tolstring` for the string.
`lua_tonumber` coerces a numeric string and returns **0** for anything else,
without raising.

The mod depends on that quiet zero. `CC.Person_S.天赋` is declared 16-bit
(`{10, 0, 2}` -- offset 10, type 0) but `jymain.lua:592` assigns it a talent
*name*:

    JY.Person[0].天赋 = ZJTF[JY.Base.主角职业]     -- "灵犀真拳", ...

so the original stores 0 and the UI reads the name out of `ZJTF` directly
instead (`jymain.lua:2557`). Checking the argument here raised
`bad argument #3 to 'set16' (number expected, got string)` and aborted
`NewGame` on the last line of the character-creation chain.

This port coerces the same way but **logs** it (capped at 20 messages) so the
sites stay visible instead of becoming invisible zeroes. A static sweep of
`script/` finds exactly one, the site above; `JY_TEST_SAVE=1` asserts the
three cases (numeric string, non-numeric string, `nil`).

Two deliberate deviations, both strictly narrower than a crash: `setstr`
keeps `luaL_checklstring` for the string, because the original passes
`lua_tolstring`'s `NULL` straight to `strlen`; and the offsets stay
bounds-checked, since the original would just scribble outside the buffer.

### The 1996 bitmap font (recovered, verified)

`game/font/jylegend16.ttf` is the original DOS game's typeface. It was
generated once from an untouched 金庸群俠傳 install (`FONT.C16`, `FONT3.E16`,
both dated 25 Oct 1996) plus this port's `hzmb.dat`, and ships committed --
the converter is not in the tree, so what follows is the method, not a recipe
you can re-run.

`FONT.C16` has no header. It is 13973 glyphs of 16x16 1bpp, 32 bytes each,
indexed straight off the Big5 code:

    offset = ((lead - 0xA1) * 157 + trailIndex) * 32
    trailIndex = trail - 0x40        for trail 0x40..0x7E   (63 values)
                 trail - 0xA1 + 63   for trail 0xA1..0xFE   (94 values)

89 leads x 157 trails = 13973, exactly the glyph count -- which is what
confirms the layout, the same way the byte count confirms `hzmb.dat`'s.
`FONT3.E16` is the matching 8x16 half-width ASCII face, 16 bytes per glyph,
indexed by character code. (`FONT.E16` in the same directory does not decode
under any layout tried and is unused; `FONT3.C16` is byte-identical to
`FONT.C16` apart from a handful of glyphs.)

The piece a bitmap-to-TTF conversion normally lacks is a `cmap`, and
`hzmb.dat` supplies it: its mode-2 table is Big5 -> UTF-16, and it maps
**13973 of 13973** cells -- every glyph in the font.

Each lit pixel becomes a square, greedily merged into maximal rectangles.
TrueType fills by non-zero winding, so same-direction rectangles that touch or
overlap just union; no outline extraction is needed. The em is 1024 units =
the 16px cell, baseline at the cell's bottom edge, no descent, because
`jy_draw_string` blits at `y + size - bitmap_top` and so treats the ascender
as the full pixel size.

Two things to know:

- **It is a 16px design.** `CC.DefaultFont` is `min(W, H) / 320 * 16`, which is
  35 at 1220x700, so pixels land on a 2.1875x grid and come out 2 or 3 device
  pixels wide. Sizes that are multiples of 16 are exact; nothing else is.
- **226 code points the scripts can reach have no glyph**, because Big5 has no
  cell for them. 222 of those are rare candidates inside `SeleteHanzi`'s pinyin
  table, where they show as blanks in the name-entry list; the rest are 劵, 咔,
  嘭 and 錇. U+3000 is also absent from Big5 and is added explicitly as a blank
  full-width glyph -- without it every padded string in `jyconst.lua` and
  `jywar.lua` draws a row of `.notdef` boxes.

### `CharSet`'s conversion table (recovered, verified)

`lib.CharSet` is **not** a codepoint conversion, and iconv cannot stand in for
it. `sub_402340` hands the string to `sub_4016E0`, which is a table lookup:

    v6 = table[mode][256 * lead - 0x8000 + trail]   ; (lead - 0x80) * 256 + trail
    if (!v6) { *a2 = '?'; a2[1] = '?'; }            ; unmapped -> "??"
    else *(WORD *)a2 = v6

Four tables, picked by `mode`:

| mode | direction | table |
|---|---|---|
| 0 | Big5 -> GBK | `word_41CCE0` |
| 1 | GBK -> Big5 | `word_40CCE0` |
| 2 | Big5 -> UTF-16 | `word_42CCE0` |
| 3 | GBK -> UTF-16 | `word_43CCE0` |

`sub_401850` (`LoadMB()` in `main`) fills all four from `<root>hzmb.dat`, which
has no header: two blocks of `(UTF-16 form, converted form)` `uint16` pairs,
the GBK side first (lead `0x81..0xFE`, trail `0x40..0xFE` skipping `0x7F`),
then the Big5 side (lead `0xA0..0xFE`, trail `0x40..0x7E` and `0xA1..0xFE`).
That is `126*190*4 + 95*157*4 = 155420` bytes -- exactly the file's size, which
is what confirms the layout.

What the table does that a charset converter cannot is pair a Simplified
character with its **Traditional** form: 侠 <-> 俠, 遥 <-> 遙. So GBK -> Big5 ->
GBK round-trips, and `iconv` cannot, because Big5 has no 侠 at all.

That difference is not cosmetic. Scripts write a Simplified literal into a
record and compare it back, and with iconv every such comparison lost:

    -- jymain.lua:338, new game
    JY.Person[0].姓名 = CC.NewPersonName            -- "徐小侠"
    while JY.Person[0].姓名 == CC.NewPersonName do  -- reads back "徐小??"
      JY.Person[0].姓名 = Shurufa(...)              -- the pinyin input
    end

The condition was false on the first test, so the loop body -- the entire name
entry -- never ran, and the step fell through on whatever key dismissed the
`请选择你的主角姓名` prompt. With the table it round-trips and the input runs.

`src/lib.c` keeps an iconv fallback for a `game/` without `hzmb.dat`, and says
so in the log.

### `FillColor`'s zero rect (recovered, verified)

`lib.FillColor(x1, y1, x2, y2, colour)` treats **all four coordinates zero**
as *the whole clip region*, not a one-pixel rect at the origin. `sub_408690`
tests the four for zero and, when they are, hands `SDL_FillRect` a `NULL`
rect, which SDL 1.2 resolves to the surface intersected with its clip rect;
otherwise it builds `{x1, y1, x2-x1, y2-y1}`.

Both of the scripts' screen-clearing helpers depend on that case -- they set a
clip and then clear it with the degenerate rect:

    function Cls(x1, y1, x2, y2)                 -- jymain.lua:6365
      ...
      lib.SetClip(x1, y1, x2, y2)
      if JY.Status == GAME_START then
        lib.FillColor(0, 0, 0, 0, 0)             -- clear the clip region

    function ClsN(x1, y1, x2, y2)                -- jymain.lua:9395
      lib.SetClip(x1, y1, x2, y2)
      lib.FillColor(0, 0, 0, 0, 0)
      lib.SetClip(0, 0, 0, 0)

Filling one pixel instead makes `Cls` and `ClsN` erase nothing, so everything
drawn while `JY.Status == GAME_START` accumulates. The visible symptom was the
new-game dialogue chain: `JYMsgBox` opens with `Cls()`, so difficulty ->
character type -> gender -> name prompt all piled up on top of each other and
on the title screen behind them.

`SetClip(0, 0, 0, 0)` has the same convention for the same reason
(`sub_4082B0` passes `SDL_SetClipRect` a `NULL` rect), which this port already
honoured -- 21 script sites use it to mean "no clipping".

Two smaller findings from the same disassembly, both left alone for now:
`sub_402070` reads only **five** arguments, so the 6th alpha argument this
port accepts is an extension (`jyyb.lua:438` and `jymain.lua:5946` pass 128
and get an opaque fill in the original); and both the fill and the clip rect
are built **exclusive** of `x2`/`y2`, where this port treats them as
inclusive.

### PlayMIDI's ordering (recovered, verified)

`sub_407FD0` does three things worth copying exactly:

1. **Same path in, nothing happens.** It compares the request against the
   track already playing (`byte_460970`) and returns without touching the
   stream. `PlayMIDI(JY.Scene[n].进门音乐)` runs on every scene entry, so
   without this the BGM restarts from the top each time you walk through a
   door.
2. **It stops the stream *before* opening the new file** (`sub_408130`, an
   unconditional `BASS_ChannelStop` + `BASS_StreamFree`). A request for a
   missing track therefore leaves **silence**, not the previous track.
3. On a failed open it logs and returns without recording the new path.

Point 2 is load-bearing for battle endings. `jywar.lua` does:

    PlayMIDI(100)        -- game100.mp3 does not ship
    PlayWavAtk(41)       -- the victory fanfare
    DrawStrBoxWaitKey("战斗胜利", ...)

so the fanfare is *meant* to play over nothing, and the scene music is
restored a few lines later. Decoding the new track before stopping the old one
makes the fanfare play on top of the previous BGM instead. `PlayMIDI(0)` at
`jywar.lua:18898` is the same trick -- `game00.mp3` does not exist either.

One deliberate deviation: on a failed open this port *clears* its record of
what is playing, where the original leaves the old path in place. The
original's behaviour means a later request for that same track is treated as
"already playing" and silently ignored, leaving the scene mute; clearing it
lets the retry work.

`JY_TEST_MUSIC=1` replays the whole sequence and prints the stream state at
each step.

### Audio

`PlayMIDI` gets an **.mp3** path, not a MIDI file (`CONFIG.MP3 = 1` selects
`game%02d.mp3`), so the BASSMIDI soundfont in `SOUND/` is unused and no MIDI
synthesis is needed. `PlayMPEG` is never called by any script.

Decoding goes through AudioToolbox's `ExtAudioFile`, which reads both the MP3
music and the 11 kHz 8-bit mono WAV effects with no third-party dependency and
converts them to s16 stereo 44100. Mixing is SDL3's: several `SDL_AudioStream`s
bound to one device are summed, so music gets one stream and effects share a
pool of eight voices.

Music is decoded on a worker thread -- a five-minute MP3 takes ~0.6s, which
would stall the game loop -- and handed to the main thread through a generation
counter so that rapid track changes discard superseded decodes. Effects are
decoded once and cached.

Known cost: a full track is held as raw PCM, ~55 MB for five minutes. Fine for
one track at a time, but streaming would be the better long-term shape.

Missing files are the mod's own problem, not the port's: `./sound/game501.mp3`
is requested on entering the world map and does not exist in `SOUND/`. The
Windows build logged the identical failure before any of this work started.

### Sprite format (recovered, verified)

Record = `idx[i]..idx[i+1]` of the `.grp`. The `.idx` supplies offsets 1..N and
`idx[0]` is an implicit 0. A record is either a raw PNG (the engine sniffs it
with `IMG_isPNG`) or:

```
int16 w, h, offsetX, offsetY                -- 8-byte header
per row: [byteCount], then [skip][runLen][runLen palette bytes] repeating
```

`x` advances by `skip` then by `runLen`; the row ends at `x >= w` or when its
byte budget is spent. `byteCount == 0` is a fully transparent row. The palette
is a 768-byte `.col` with **6-bit VGA channels** (`<<2` for 8-bit).

`offsetX/offsetY` are an anchor: unless flag bit 0 is set the draw position has
them subtracted. For the 36x18 isometric tiles the anchor is bottom-centre.

**Sprite ids from Lua are pre-doubled** -- `PicLoadCache` uses `id / 2` as the
record index, which is why every call site multiplies by 2.

### World map layout (recovered, verified)

Five separate 480x480 `int16` files, `index = x + y * width`:

| layer | file | meaning |
|---|---|---|
| 0 | earth.002 | ground tiles, drawn flat |
| 1 | surface.002 | decoration, same position |
| 2 | building.002 | sprite id, only at the anchor cell |
| 3 | buildx.002 | x of this cell's anchor |
| 4 | buildy.002 | y of this cell's anchor |

Buildings span cells, so each covered cell points at the anchor. Collect unique
anchors, draw each once from layer 2. The original injects the player into the
building layer temporarily so it sorts with them; we add it to the list and sort
by depth instead, same result without mutating the map.

Projection for both maps: `sx = W/2 + XScale*(i-j)`, `sy = H/2 + YScale*(i+j)`.

### Scene map layout (derived, verified)

`S` (allsin.grp / save/s<N>.grp): one record per scene, 64x64 cells x 6 int16
layers = 49152 bytes, **layer-major** -> `s[scene][layer][y*W + x]`. Layer
character differs sharply per plane (ground tiles, buildings, a -1-sentinel
event layer), which is how layer-major was confirmed over interleaved.

`D` (alldef.grp / save/d<N>.grp): one record per scene, 200 entries x 11 int16
fields = 4400 bytes -> `d[scene][index*11 + field]`. The trailing `11` argument
to `LoadSMap` is that field count.

Both files hold 137 scenes, matching the 137 `Scene_S` records in a save.

## Notes that cost time to learn

- `lib.SetClip(0, 0, 0, 0)` means **disable clipping**, not "clip to one pixel".
  21 call sites rely on it.
- `lib.DrawRect` draws an **outline**; `lib.FillColor` fills. Confirmed against
  `sub_4083A0` in the original.
- Two charsets coexist: Lua string literals are **GBK**, `.grp` data is **Big5**.
  `lib.CharSet(s, 0)` converts Big5 → GBK, so strings reaching `DrawStr` are GBK.
- `VK_*` in `jyconst.lua` are SDL2/SDL3 keycodes verbatim, so no key mapping is
  needed (`VK_F1 = 1073741882 = SDLK_F1`).
- Colours arrive as `0xRRGGBB` ints (`RGB()` in `jymain.lua`).
- **`CC.Frame` arrives corrupt and must be clamped.** It is the main loop's
  target ms per iteration and paces everything time-based -- NPC animation
  advances every 4th iteration (`DtoSMap`). `LoadRecord` reads it from
  `DATA/CircleNum` at `2200 + 2*slot`, but the mod puts slot 10's 20-byte
  timestamp at `2000 + 20*10 = 2200`, overlapping the frame bytes for slots
  0..9. Slot 1 reads `"02"` out of `'2025-01-26 22:29:37` and gets 2.
  `tonumber` succeeds on that, so the game's own `else CC.Frame = 30` fallback
  never fires. The original survived by being slow enough to be compute-bound
  near the intended rate; this engine runs an iteration in ~8ms, so the loop
  free-ran at 120/s and NPC animation was 4x too fast. `src/compat.lua.h`
  clamps it to the three speeds the settings menu offers (30/20/10).
  Measure with `JY_LOOPSTATS=1`.
- **`lib.SetClip` must set the clip on the SDL surface, not just in engine
  state.** Fills and glyphs can honour a clip by hand, but sprites, pictures
  and `LoadSur` go through `SDL_BlitSurface`, which respects only the
  destination surface's own clip rect. The original called `SDL_SetClipRect`
  for this (it is in the recovered import table). Miss it and blitted UI is
  never clipped, so it can survive a clipped redraw. Note `SaveSur` must
  temporarily lift the clip: `SDL_BlitSurface` also clips by the *source*
  surface's rect, which would otherwise truncate the captured region.
- **`lib.GetKey()` must return `-1` when no key is pending, not 0.** `WaitKey()`
  spins until `GetKey()` returns something `~= -1`, so returning 0 makes every
  wait fall through instantly. Menus survive that (their loop just ignores
  unrecognised values and re-waits) but `TalkEx` advances a dialogue page per
  call, so whole conversations flash past in one frame. Three call sites compare
  against `-1`; none compare against 0.
- `Byte.setstr(buf, off, len, str)` puts the field width **before** the string.
- `lib.CharSet(s, 0)` is Big5 -> GBK (reading a record); `(s, 1)` is the reverse
  (writing one back). Neither is a no-op, and **neither is a codepoint
  conversion**: both go through `hzmb.dat`, which pairs each Simplified
  character with its Traditional form, so the two directions are inverses.
- `CONFIG.Operation` picks the key profile: 0 (Windows) wants SDL 1.2 arrow
  codes 273-276, 1 (android) wants SDL2/SDL3 codes. Enter/Esc/letters are the
  same in both, so only arrows need translating.
- The mod's save checksum (`leijia` -> `hzbj`) depends on **Windows text-mode
  file semantics**: `read_files` uses `io.input()`, so MSVCRT collapses CRLF to
  LF and stops at 0x1A. Reading the bytes faithfully gives a different sum
  (261878 vs the stored 59515 for slot 1), and `hzbj` then reports
  "文件结构异常" and restarts the game. `src/compat.lua.h` re-creates the
  Windows behaviour so existing saves still load.
- **Presentation is commit/repaint, and the split matters.** The original engine
  presents only when the game calls `ShowSurface`/`ShowSlow`; between those
  calls the framebuffer holds half-drawn intermediate states. macOS/Metal does
  not retain the last presented frame, so the window must be re-painted while
  the game idles -- but from the **texture**, not the live surface:
    - `jy_present()` uploads the framebuffer and paints. Called only from
      `ShowSurface`/`ShowSlow`.
    - `jy_repaint()` paints the existing texture. Called from the idle tick.
  Re-uploading in the idle tick instead showed the game mid-draw, which made
  dialogue boxes appear and vanish in a blink.
- `SDL_RenderReadPixels` must run **before** `SDL_RenderPresent`; after
  presenting, the backbuffer is undefined and reads back blank. `jy_capture()`
  gets this right -- getting it wrong made snapshots look empty while the
  framebuffer was full, and cost real debugging time.