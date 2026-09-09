# jyengine internals

Layout, packaging and status. Build instructions are in the
[README](../README.md); the reverse-engineering notes are in
[REVERSE.md](REVERSE.md).

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
| `FontName` | `./font/jylegend16.ttf` | converted from the 1996 `FONT.C16` |
| `CC.SavePath` | `./save/` (via `data/../save/`) | original `save/` |

So a self-contained bundle is:

    port/
      Makefile  run.sh  src/
      build/          <- objects + jyengine (gitignored)
      game/           <- assets (committed)
        CONFIG.lua  hzmb.dat
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
    cp CONFIG.lua hzmb.dat $D/

`font/jylegend16.ttf` is not rebuilt by that recipe -- it ships committed. It
was generated once from a 1996 install's `FONT.C16`; the converter is no longer
in the tree, so keep the `.ttf`.

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
| `JY_EFFECT_TEXT_MS=n` | ms to hold each battle effect-text frame (default 40; 0 restores the script's own timing) |

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
`tools/`, the Makefile and `docs/` are yours to share. Keep the
remote private.

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

`tools/gen_s2t.py` emits `src/s2t_table.h` wrapped in `// clang-format off`
so a reformat cannot fight the generator. The **committed** table predates that
change and carries no fence, so clang-format has reflowed it -- it is still
correct, but regenerating it will produce a differently-formatted file.

The reformat was verified by comparing `strings` on the binary before and
after: all 632 literals identical, so nothing but whitespace moved.

## Layout

| file | |
|---|---|
| `src/main.c` | bootstrap, Lua state, error handling, root resolution, `JY_TEST_*` harnesses |
| `src/gfx.c` | ARGB8888 software framebuffer, primitives, clipping, events |
| `src/text.c` | FreeType glyph raster + iconv charset handling |
| `src/image.c` | libpng loader, `.col` palette |
| `src/bytebuf.c` | the 11-function `Byte` table (binary record access) |
| `src/lib.c` | the 46-function `lib` table |
| `src/script.c` | script loading; transcodes UTF-8 sources to GBK |
| `src/audio.c` | music and cached sound effects |
| `src/pic.c` | `.grp` sprite archives and the palette |
| `src/smap.c`, `render_smap.c` | scene maps: S/D arrays and the isometric renderer |
| `src/mmap.c`, `warmap.c` | world map and battle maps |
| `src/compat.lua.h` | post-load Lua shim: host-platform compensation and defensive clamps only |
| `docs/PATCHES.md` | the `-- [port]` edits in `game/script/` and why each is there |
| `docs/script-patches.diff` | generated by `make script-diff`; the authoritative list of those edits |
| `tools/to_utf8.py` | re-encodes `script/*.lua` between GBK and UTF-8 |
| `tools/gen_s2t.py` | regenerates `src/s2t_table.h` from OpenCC |
| `tools/make_app.sh` | assembles the `.app`: dylibs, rpaths, plist, signatures |

## Status

**Playable world map.** Loads a save, enters the game loop, and renders the
isometric world: terrain, water, forests, buildings, the player sprite and the
command menu. Character creation, the start menu and the pinyin name entry all
work.

Implemented: boot, CONFIG, all 20 Lua modules, title art, text (FreeType +
GBK/Big5), input with the `CONFIG.Operation` key profile, timing, clipping,
primitives, surface save/restore, the full `Byte` record accessor, scene maps
(S/D arrays), the PNG slot registry, the `.grp` sprite decoder, the isometric
scene renderer, and the world map with its five layers.

Audio works: looping music and cached sound effects.

Battle maps work: terrain, scenery, movement-range shading and unit sprites.

`SaveRecord` is verified end to end by `JY_TEST_SAVEREC` (slot 1 -> 9, reload,
then a byte-level diff): `cmp -l save/r1.grp save/r9.grp` reports **zero**
differing bytes. That last byte came from `FINALWORK2` assigning the Simplified
literal `"逍遥子"` to a record holding Traditional Big5; it survives now that
`lib.CharSet` uses the original's `hzmb.dat` table, which pairs 遥 with 遙
instead of failing on it -- see
[CharSet's conversion table](REVERSE.md#charsets-conversion-table-recovered-verified).

`JY_TEST_SWEEP` is clean across the full data surface: 4024/4024 dialogue
records, 137/137 scenes drawn through `DrawSMap`, 129/129 battle maps, 10/10
save slots, zero errors.
Decoding every record of every sprite archive also yields zero genuine failures
(the 239 "bad" scene tiles are 8-byte all-zero placeholders with `w=h=0`, which
the engine likewise draws as nothing).

The save *primitives* are verified separately by `JY_TEST_SAVE` (offset writes,
zero-filled gaps, `setstr` padding, `SaveSMap` round-trip, output file sizes).
`SaveRecord` `os.remove()`s the slot before rebuilding it in six writes, so
**save to an unused slot first**.

Note `SaveRecord` finishes by rewriting the integrity checksum:

    write_content(d_grp, 602800 + 12*slot, leijia(slot))

`leijia` reads through the text-mode shim, so the value written matches what
`hzbj` will later expect -- saves stay loadable in both this port and the
original Windows build.

Not implemented:

- `PlayMPEG`. No script references it, so it is registered only to keep the
  `lib` table complete and logs if it is ever called.

## Assets

The engine reads from the game directory, and `game/` is committed, so a fresh
clone runs as-is. Two of its subdirectories have no counterpart in an original
install: `script/` and `pic/` must exist **on disk**, because the Windows build
served them out of Enigma's virtual filesystem. They came from
`../../_re/script_source/` and `../../_re/PIC/`, which is also where to regenerate
them from.

`hzmb.dat` is the original engine's GBK/Big5 conversion table, loaded verbatim
by `lib.CharSet`; it comes from the install root, next to `Dragon.exe`.

`font/` holds the one face the game uses, named by `CONFIG.FontName`:
**`jylegend16.ttf`**, the 1996 game's own bitmap font converted to an outline
TTF -- see
[The 1996 bitmap font](REVERSE.md#the-1996-bitmap-font-recovered-verified).
It covers every character the game can reach except 226, listed there.

There is no fallback. `get_face()` logs `DrawStr: cannot open font` and returns
NULL, which means no text at all, so point `CONFIG.FontName` only at a file
that exists.
