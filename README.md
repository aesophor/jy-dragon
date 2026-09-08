# jyengine — native macOS engine for 龙启江湖

A from-scratch reimplementation of the `Dragon.exe` engine, built against the
API recovered in `../_re/`. The game's 3.4 MB of Lua runs unmodified; only the
C layer beneath it is rewritten.

## Build & run

    make                           # -> build/jyengine
    ./run.sh                       # standalone, uses the bundled ./game
    ./build/jyengine /path/to/game # or point it at any game root
    make clean                     # removes build/ entirely

All build products go to `build/` -- objects, dependency files and the binary.
Nothing is written next to the sources.

Dependencies (all via Homebrew): `sdl3 luajit freetype libpng`.

With no argument the engine uses the current directory if it contains
`CONFIG.lua`, otherwise `./game`.

## Standalone layout

Everything is resolved relative to the working directory. The engine hardcodes
only `CONFIG.lua`, `script/jymain.lua`, and the `port_debug.txt` it writes;
every other path comes from `CONFIG.CurrentPath = "./"` in `CONFIG.lua`:

| CONFIG entry | resolves to | source |
|---|---|---|
| `DataPath` | `./data/` | original `DATA/` |
| `PicturePath` | `./pic/` | extracted `PIC/` |
| `SoundPath` | `./sound/` | original `SOUND/` |
| `ScriptPath` | `./script/` | decompiled `script_source/` |
| `FontName` | `./font/font.ttc` | original `FONT/` |
| `CC.SavePath` | `./save/` (via `data/../save/`) | original `save/` |

So a self-contained bundle is:

    port/
      Makefile  run.sh  src/
      build/          <- objects + jyengine (gitignored)
      game/           <- assets (committed)
        CONFIG.lua
        data/  font/  pic/  save/  script/  sound/

`game/` is ~297 MB and is committed, so a clone has everything it needs to
run -- see the licensing note under [.app bundle](#app-bundle) before you push
it anywhere public. Only `build/` and `game/port_debug.txt` are gitignored.
Note the directories are **lowercase** here,
matching what `CONFIG.lua` actually asks for -- the original install relied on
Windows and APFS being case-insensitive, so `DATA/` worked by luck. Lowercasing
them makes the bundle correct on case-sensitive volumes too.

`game/` ships with the repository, so this is only needed to rebuild it from
a different install, or to refresh it after patching the mod:

    cd <install>
    D=port/game; mkdir -p $D
    cp -R DATA $D/data;  cp -R SOUND $D/sound; cp -R FONT $D/font
    cp -R PIC  $D/pic;   cp -R save  $D/save;  cp -R script $D/script
    cp CONFIG.lua $D/

Environment variables, for automated runs:

| var | effect |
|---|---|
| `JY_SECONDS=n` | quit cleanly after n seconds |
| `JY_SNAPSHOT=f.bmp` | dump the renderer output on exit (readback, so it shows what the window shows) |
| `JY_KEYS=13,274,13` | feed synthetic keypresses, one per `GetKey`, to walk menus headlessly |
| `JY_SNAPSHOT_RAW=1` | dump the software framebuffer instead of the window, to tell "not drawn" from "not presented" |
| `JY_TEST_TALK=n` | render dialogue record n and dump its bytes, without navigating to an NPC |
| `JY_TEST_WAR=n` | load and render battle map n |
| `JY_TEST_ERASE=1` | draw scene, overlay dialogue boxes, redraw, diff the frames |
| `JY_TEST_SAVE=1` | round-trip the save write primitives (`Byte.savefile`, `SaveSMap`) |
| `JY_TEST_SAVEREC=a,b` | run the real `SaveRecord` end to end: load slot a, save to slot b, reload |
| `JY_TEST_SWEEP=1` | exercise the whole data surface: every dialogue record, scene, battle map and save slot |
| `JY_TEST_FADE=1` | check `ShowSlow`'s end states and timing |
| `JY_LOOPSTATS=1` | log the real main-loop rate and resulting NPC animation fps once a second |

On exit the engine prints a census of every `lib.*` function the run needed but
that isn't implemented yet, ordered by call count — that list is the to-do list.

## .app bundle

    make app          # self-contained, ~300 MB -> build/金庸群俠傳之龍啟江湖.app
    make install-app  # copies it to ~/Applications

The game data goes in `Contents/Resources/game`, so the bundle is
double-clickable with nothing beside it. Three things had to be dealt with:

**cwd is `/` on a double-click.** Probing `./game/CONFIG.lua` only works from a
terminal. `root_near_exe()` resolves candidates against the binary's own
directory via `_NSGetExecutablePath` instead -- `../Resources/game` inside a
bundle, `game` in the build tree.

**Homebrew dylibs.** Four (`SDL3`, `luajit`, `freetype`, `libpng`; `libiconv`
and the frameworks are system-provided) are copied into
`Contents/Frameworks` and rewritten to `@rpath`. `tools/make_app.sh` walks the
dependency graph rather than hardcoding that list -- freetype pulls in libpng,
and a future dependency should not need the script edited.

It also **deletes the `/opt/homebrew/lib` rpath** that pkg-config puts on the
link line. Rpaths are searched in order, so leaving it in means dyld keeps
preferring Homebrew's copies: the bundling would silently do nothing on the
machine that built it, which is the one place you would never notice.

**Saves live inside the bundle, and the bundle is not sealed.** `Byte.savefile`
opens `r+b` and patches at a byte offset, so the 30 slot files (`r/s/d%d.grp`,
75 MB) must exist and be writable. In a self-contained bundle they sit in
`Contents/Resources/game/save/`. Signing the bundle would make every save
invalidate its own signature, so only the executable and dylibs are ad-hoc
signed -- which is all arm64 requires in order to run them. That is fine for a
local build and is *not* suitable for distribution; a shippable app would seed
saves into `SDL_GetPrefPath()` on first launch instead.

`make app` re-mirrors everything except `save/`, which is copied only when
absent -- so rebuilding does not wipe your progress. Delete `save/` inside the
bundle to reset it.

Only the executable and the dylibs carry signatures, and the executable is
signed **outside** the bundle in a temp file before being moved in. Handed a
path that is the bundle's `CFBundleExecutable`, `codesign` signs the enclosing
bundle rather than the file -- writing `Contents/_CodeSignature` and sealing
Resources, which every save written into `Resources/game/save/` would then
invalidate. Staging it gets a plain Mach-O signature, the state a freshly
linked binary is already in.

The executable inside the bundle is named after the app, not `jyengine`:
`CFBundleExecutable` decides which app owns the window, but the Dock, Force
Quit and Activity Monitor all show the *process* name, which comes from the
file itself.

The icon comes from `game/AppIcon.icns`, supplied alongside the game data
rather than generated. It is committed with the rest of `game/`; the Makefile
still declares it as a target that reports a missing icon plainly, rather than
failing with make's "No rule to make target", for trees assembled by hand.

**Do not distribute the bundle -- or this repository**: `game/` is committed
here, and those assets are grgame's mod and Jinyong's IP. Only `src/`,
`tools/`, the Makefile and this README are yours to share. Keep the remote
private.

## Formatting

    make format        # clang-format -i src/*.c src/*.h
    make format-check  # fails if anything is unformatted

`.clang-format` is tuned to the style the sources were already written in, so
adopting it did not rewrite the tree wholesale. Four settings matter:

- **`ColumnLimit: 90`** -- the code was written to roughly 80 but breaks past it
  deliberately in a handful of places; 90 leaves those alone.
- **`ReflowComments: false`** -- the comment blocks are hand-wrapped prose
  documenting recovered engine behaviour. Reflowing would join their lines.
- **`BreakStringLiterals: false`** -- `compat.lua.h` and the harnesses in
  `main.c` embed Lua as one C literal per Lua line. Splitting a literal to fit
  the column limit is harmless (adjacent literals concatenate) but destroys
  that correspondence.
- **`SortIncludes: Never`** -- `engine.h` comes first on purpose.

The reformat was verified by comparing `strings` on the binary before and
after: nothing but whitespace moved.

`src/s2t_table.h` is fenced with `// clang-format off`, emitted by
`tools/gen_s2t.py` so a reformat cannot fight the generator.

## Layout

| file | |
|---|---|
| `src/main.c` | bootstrap, Lua state, error handling, TODO census, root resolution |
| `src/gfx.c` | ARGB8888 software framebuffer, primitives, clipping, events |
| `src/text.c` | FreeType glyph raster + iconv charset handling |
| `src/image.c` | libpng loader, `.col` palette |
| `src/bytebuf.c` | the 11-function `Byte` table (binary record access) |
| `src/lib.c` | the 46-function `lib` table |
| `src/script.c` | script loading; transcodes UTF-8 sources to GBK |
| `tools/to_utf8.py` | re-encodes `script/*.lua` between GBK and UTF-8 |
| `tools/gen_s2t.py` | regenerates `src/s2t_table.h` from OpenCC |
| `tools/make_app.sh` | assembles the `.app`: dylibs, rpaths, plist, signatures |

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
lexer is concerned. Converting the tree and compiling it makes **18 of the 21
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

- It also converts **data-file** text, which is Big5 and already Traditional.
  Measured against the dialogue archive, that alters 0.36% of characters
  (11 of 3071), and 4 of the 5 distinct cases are corrections of Simplified
  leakage in the data itself (`体` -> `體`, `划` -> `劃`, `涌` -> `湧`). The
  odd one out is `苧` -> `薴`.
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
bytes. All 21 shipped scripts round-trip GBK -> UTF-8 -> GBK losslessly.

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

## Status

**Playable world map.** Loads a save, enters the game loop, and renders the
isometric world: terrain, water, forests, buildings, the player sprite and the
command menu. Character creation and the start menu work. Only `PlayMIDI`
remains unimplemented on the load-save path.

Implemented: boot, CONFIG, all 19 Lua modules, title art, text (FreeType +
GBK/Big5), input with the `CONFIG.Operation` key profile, timing, clipping,
primitives, surface save/restore, the full `Byte` record accessor, scene maps
(S/D arrays), the PNG slot registry, the `.grp` sprite decoder, the isometric
scene renderer, and the world map with its five layers.

Audio works: looping music and cached sound effects.

Battle maps work: terrain, scenery, movement-range shading and unit sprites.

`SaveRecord` is verified end to end by `JY_TEST_SAVEREC` (slot 1 -> 9, reload,
then a byte-level diff of every record): exactly one field differs, and that is
`FINALWORK2` deliberately assigning the Simplified literal `"逍遥子"` to a
record holding Traditional Big5 -- 遥 has no Big5 form, so it degrades to
`逍??子`, matching the original engine (`hzmb.dat` stores unmappable entries as
the two bytes `??`).

`JY_TEST_SWEEP` is clean across the full data surface: 4024/4024 dialogue
records, 137/137 scenes, 129/129 battle maps, 10/10 save slots, zero errors.
Decoding every record of every sprite archive also yields zero genuine failures
(the 239 "bad" scene tiles are 8-byte all-zero placeholders with `w=h=0`, which
the engine likewise draws as nothing).

The save *primitives* are verified by `JY_TEST_SAVE` (offset writes, zero-filled
gaps, `setstr` padding, `SaveSMap` round-trip, output file sizes). The full
`SaveRecord` path has not been run end to end -- it `os.remove()`s the slot
before rebuilding it in six writes, so **save to an unused slot first**.

Note `SaveRecord` finishes by rewriting the integrity checksum:

    write_content(d_grp, 602800 + 12*slot, leijia(slot))

`leijia` reads through the text-mode shim, so the value written matches what
`hzbj` will later expect -- saves stay loadable in both this port and the
original Windows build.

Not yet implemented:

- `DrawSMap` is written but only exercised by save slots that start in a scene
- `PlayMPEG` is a permanent stub -- no script calls it

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
  (writing one back). Neither is a no-op.
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

## Assets

The engine reads from the game directory, and `game/` is committed, so a fresh
clone runs as-is. Two of its subdirectories have no counterpart in an original
install: `script/` and `pic/` must exist **on disk**, because the Windows build
served them out of Enigma's virtual filesystem. They came from
`../_re/script_source/` and `../_re/PIC/`, which is also where to regenerate
them from.

These assets are grgame's mod and Jinyong's IP. They are committed for
convenience on a private remote; do not redistribute them.
