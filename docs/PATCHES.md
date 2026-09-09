# Edits to the decompiled scripts

`game/script/` is `ljd2`'s output from the mod's LuaJIT bytecode, with a small
number of deliberate edits. Each one is marked `-- [port]` at the line it
changes:

    grep -rn '\[port\]' game/script/

The untouched decompilation stays in `../_re/script_source_utf8/`, so the two
trees can always be compared:

| command | what |
|---|---|
| `make script-diff` | regenerate `docs/script-patches.diff` -- run after editing a script |
| `make script-diff-check` | fail if that diff is stale |

The diff is the authoritative list; this file is the reasoning behind it. When
a change is better expressed as a wrapper than as an edit, it goes in
`src/compat.lua.h` instead -- see the bottom of this page.

## Battle effect text stayed on screen for one frame

`jyconst.lua:1782` -- new `CC.EffectTextMS`, default 40
`jywar.lua:20603` -- was an empty `if CONFIG.Operation == 0 then end` block
`jywar.lua:20897` -- was `lib.Delay(1)`

`War_ShowFight` redraws a skill's effect text (击中破绽, 葵花移形, ...) once per
frame for a fixed 20 frames (`jywar.lua:20836`). Two branches present those
frames, and only one of them is paced:

| branch | original pacing |
|---|---|
| skill has an effect animation | `lib.Delay(2 * CC.Frame)`, 60ms (`20893`) |
| skill has only text | `lib.Delay(1)` (`20897`) |

A third site, the effect-animation loop inside the attack frames, presented
with no delay at all -- its one candidate slot was an empty
`if CONFIG.Operation == 0 then end` block.

That was self-limiting on the original, where SDL 1.2 software blits plus an
uncached SDL_ttf render cost tens of milliseconds a frame. Here a frame costs
about one, so 20 of them are a flicker. The value in the script was never
wrong; the animation simply had no clock. `CC.EffectTextMS` is that clock, and
it reads `JY_EFFECT_TEXT_MS` so it can be retuned without a rebuild.

Only the unpaced branches were touched. The animated branch keeps its own
60ms, and the skill-name zoom (`20498`) is untouched.

## The title menu hung past the bottom of the artwork

`jyconst.lua:2763` -- the `3` in `StartMenuY` became `5`

The original anchors the menu to the window:

    CC.StartMenuY = CC.ScreenH - 3 * (CC.StartMenuFontSize + CC.RowPixel) - 20

which leaves the three rows 20px from the bottom. That was right at 640x480,
where the art filled every pixel; at 1220x700 the menu sat tight against the
window edge.

Two more row heights lifts it clear. The term scales with the font, so it
holds at other window sizes instead of being a magic number for this one.
Three `请稍候...` boxes share `CC.StartMenuY` and move with it, which is what
you want: same screen, same place.

The original reason for this edit was narrower and no longer applies: the
art used to be blitted 1:1 and centred, spanning only y 110..590, so the
menu block hung 90px past it onto bare black. `l_LoadPicture` now scales
full-screen art to cover the window, so there is no bare black to hang onto
-- but 20px from the bottom edge is still too tight, so the edit stays.

## Returning to the title mid-game kept the map and the music

`jymain.lua:158-161` -- `JY.Status = GAME_START` and `PlayMIDI(11)` at the top
of `StartMenu`

`JY_Main_sub` does both of these in the lines before its own `StartMenu()`
call (`122` and `127`). Quitting mid-game never goes through there: the 系统
menu's 离开游戏 calls `StartMenu()` directly (`1950`). Two things followed.

**The map stayed visible.** `StartMenu` opens with `Cls()`, which dispatches on
`JY.Status`: only the `GAME_START` branch clears to black, the others redraw
the live map. `Menu_Exit` does not touch `JY.Status`, so the title art was
drawn over the scene you left -- and `LoadPicture` does not clear either
(`sub_407CB0` is `IMG_Load`, `SDL_DisplayFormat`, centre, `SDL_UpperBlit`,
nothing else), so the uncovered border still showed it. Invisible in the
original, which ran at the art's own 640x480.

Cover-scaling the art (`l_LoadPicture`) now hides this symptom by painting
every pixel, but the edit stays: relying on the artwork to do the clearing
would break again on art with transparency, or on a window the art cannot
cover. Clearing is `Cls()`'s job and this is how you ask it to do it.

Setting the status lets the game's own `Cls()` do the clearing. Nothing
downstream reads the value this overwrites: every `StartMenu` branch that
resumes play assigns `JY.Status` itself -- `GAME_SMAP` for a new game and for a
load, `GAME_FIRSTMMAP` for a save with no scene, `JY_Main` for quit.

**The music kept playing.** Same cause, same fix. It is safe to play track 11
on every entry rather than just this one: `jy_play_music` returns without
touching the stream when the same file is requested again (`audio.c:207`,
mirroring `byte_460970` in the original), so the duplicate from line 127 is a
no-op rather than a restart.

Both run *before* the original body, so the branches that start or load a game
still set their own scene track from `Init_SMap` / `Init_MMap` and win.

## 打赏&赞助 was removed from the system menu

`jymain.lua:1385` -- the entry's third field became `0`

`ShowMenu` already has the mechanism: it copies only the entries whose third
field is `> 0` (`4917`), and returns the selected entry's **original** index out
of the fourth (`5279`), which `Menu_System`'s own `== 7` / `== 8` tests depend
on. Clearing the flag is what the same function does a few lines later to grey
out save and load in scenes 42, 82 and 13, so nothing downstream shifts.

Deleting the table entry instead would renumber everything after it and break
those tests.

## What stays in src/compat.lua.h

Three shims, none of which are things the mod gets wrong -- editing its source
to say so would misplace the blame:

1. **`read_files`** -- emulates Windows text-mode reads (CRLF collapsed, 0x1A
   as EOF), which the stored save checksums were computed under. A host
   platform difference.
2. **`LoadRecord`** -- clamps a corrupt `CC.Frame` read out of a save to the
   three speeds the settings menu offers. Defensive against bad data.
3. **`IncludeFile`** -- points `CC.FirstFile1..4` at a single `title.png`
   instead of a random pick of four. Asset configuration.
