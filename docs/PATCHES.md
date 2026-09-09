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

## Save-list dates ran past the right border

`jymain.lua:9903`, `9909` -- the two row formats in `SaveList`
`jymain.lua:212`, `1960`, `1978` -- the matching header, three call sites

The 存档时间 column's seconds sat on top of the menu's right border, 17px
outside it.

`ShowMenu` auto-sizes the box from the longest entry, in bytes:

    var_112_0 = arg_112_9 * var_112_6 / 2 + 2 * CC.MenuBorderPixel

That models one byte as half a font width, which is right for GBK -- a CJK
character is two bytes and one font width, ASCII is one byte and half. The
rows come to 79 bytes, so the box is sized for exactly the text it holds,
with `CC.MenuBorderPixel` (5px) of slack at each end. Glyph advances round up
by a fraction each, and over the ~65 glyphs in a row that eats the 5px and
spills 2px more. The stored date is 20 bytes of it (`'2023-05-28 20:58:11`,
`data/CircleNum` at `2000 + 20 * slot`), which is why that column is where it
shows.

Trimming padding alone cannot fix this: the box is measured from the same
string, so the border moves in by exactly as much as the text does. The fix
needs both halves --

- **narrow 姓名** from `%-11s` to `%-9s`, which shifts every column from 年龄
  to 存档时间 two half-widths left (the field it pads is 10 bytes, and Lua's
  width is a minimum, so a long name costs alignment on that row, never
  truncation);
- **append two spaces** to the format. They count toward `string.len`, so the
  box keeps its original width while the visible text no longer reaches it.

Net byte count is unchanged, so the border stays where it was and the text
moves off it. Measured from a snapshot of the real menu, rendered by driving
the load screen with `JY_KEYS="0,274,13"`: clear space at the right border
went from **-17px to +12px**, with the box edge fixed at x=1186.5.

The header's 姓名 field goes `%-10s` to `%-8s`, one byte narrower than the
rows' as it already was, so the labels stay over their columns.

The header is a separate box, drawn by `DrawStrBox` rather than `ShowMenu`,
and its right border sat 30px inside the rows' -- it measured 77 bytes to
their 79. `DrawStrBox` uses the identical width model, and both boxes start
at the same x (the two call sites compute it from the same expression), so
padding the last label, `存档时间`, with two more trailing spaces brings the
two borders flush. Trailing spaces on the final field move no label.

That leaves exactly 1px, which no string length can close: `DrawStrBox` ends
its box at `x + width - 1` (`4694`) and `ShowMenu` at `x + width` (`4981`).
Same width, one pixel apart by convention. Closing it would mean changing
`DrawStrBox` for every caller in the game, which is not worth one pixel.

### The 阶级 column had no title

The header had eight fields for eight columns, but the fifth was `%14s` with
`""` -- an empty slot over the 门派等级 values (长老, 内门弟子, 精英弟子).
The rows always filled it; only the title was missing. Writing `阶级` in the
Simplified source displays as 階級 like the rest: `阶` and `级` are both in
`src/s2t_table.h`.

Aligning that title and 门派 to their values meant re-cutting the header's
field widths, since alignment here is byte arithmetic -- one byte is half a
font width, a CJK character is two:

    "%-8s %-8s %-2s %6s %14s %-4s %-10s %-10s"   before
    "%-8s %-7s %-4s %-4s %8s %13s %-10s %-10s"   after

Byte offsets of each label's ink, against the row values:

| column | row values | header before | header after |
|---|---|---|---|
| 存档 | 0 | 0 | 0 |
| 姓名 | 9 | 9 | 9 |
| 年龄 | 19 | 18 | 17 |
| 门派 | 22 | 25 | **22** |
| 阶级 | 31 | -- | **31** |
| 位置 | 43..48 | 45 | 45 |
| 难度 | 50 | 50 | 50 |
| 存档时间 | 57 | 61 | 61 |

门派 came left three half-widths onto its values and 阶级 lands on its own.
The total stays 79 bytes, so the border alignment above is unaffected.

年龄 is the one column that cannot align: its label is 4 bytes and its value
column is 2 (`%-2s` on a number like 15), so the title is wider than the
data. It sits one half-width further left than before, which is the cost of
putting 门派 on its values.

### The stored date came back with a stray quote

`jymain.lua:9898` -- strip the quotes when reading the date

`SaveRecord` wraps the timestamp in single quotes on both sides before
writing it (`4337`):

    local var_73_3 = os.date("%Y-%m-%d %H:%M:%S")   -- 19 chars
    local var_73_4 = "'" .. var_73_3 .. "'"          -- 21

but `SaveList` reads back only 20 bytes (`9895`), so the closing quote is
truncated and the opening one survives into the column. Strip both on read
with a `gsub`, which fixes existing saves as well as new ones and leaves the
bytes on disk untouched, so saves stay interchangeable with the Windows
build.

The date is a byte shorter now, so the row format takes one more trailing
space to stay at 79 bytes and keep the two borders where they are (measured
unchanged at 31.0..1185.5 against 31.0..1186.5).

`instruct_15` draws a seventh, narrower variant of this header
(`jymain.lua:7089`, `"%-6s %-10s %-2s %6s %12s %-6s %-10s"`) over the same
`SaveList` rows, with its box x computed from 25 rather than 38.5 font
widths. It is mismatched independently of this and is left alone.

## Battle background music

`jyconst.lua:206` -- `CC.BattleMusicFile`, `CC.BattleMusicBase`, `CC.BattleMusicNum`
`jymain.lua:4870` -- `PlayMIDI` addresses the battle range
`jywar.lua:17192` -- pick one on entering a battle

The mod has no battle music. `WarMain` -- the single entry point every battle
in the game routes through -- never touches the music, so combat inherits
whatever the scene or world map was playing. The schema has a per-battle
`CC.WarData_S.音乐` field (`jyconst.lua:2679`) that no script ever reads, and
the only battle-specific track is the victory fanfare `PlayMIDI(100)`
(`jywar.lua:18830`, `18841`), whose `game100.mp3` does not ship.

New tracks go in `sound/battle<N>.mp3`, and the count is probed at startup
rather than hardcoded, so adding `battle4.mp3` needs no code change:

    while existFile(string.format(CC.BattleMusicFile, CC.BattleMusicNum + 1)) do
        CC.BattleMusicNum = CC.BattleMusicNum + 1
    end

`PlayMIDI` takes a track *number* and formats it into `CC.MIDIFile`
(`game%02d.mp3`), which `battle1.mp3` cannot be expressed as. Rather than
calling `lib.PlayMIDI` directly from the battle code, ids at or above
`CC.BattleMusicBase` (9001, clear of every id the scripts use -- the highest
shipped track is 2002) are mapped to the battle pattern inside `PlayMIDI`
itself. That keeps `JY.CurrentMIDI` accurate, which is what two other things
depend on:

- `Menu_SetMusic` (`1715`) replays `JY.CurrentMIDI` when you toggle music
  back on, so it resumes the battle track rather than the scene's;
- `WarMain`'s tail already restores `JY.Scene[JY.SubScene].进门音乐`, or
  `PlayMIDI(0)`, on every exit (`18895`), so nothing is needed to end it.

Where the call sits in `WarMain` matters twice over. It goes after
`WarSelectTeam` and `WarSelectEnemy`, so the track starts once the "who
fights" and "bring your 佣兵?" prompts are done rather than underneath them.
And it goes after the `JY.Restart` check (`17182`), because that path
`return false`s straight out of `WarMain` and never reaches the restore at
the end -- starting the music above it would leave a battle track playing
over the scene with nothing to stop it.

Guarded on `CC.BattleMusicNum > 0`, so a `sound/` with no battle tracks
behaves exactly as the mod always did.

Verified by probing `PlayMIDI` at startup: id 9002 resolved to
`./sound/battle2.mp3` (83.0s, looping) and 9003 to `battle3.mp3`, with
`JY.CurrentMIDI` following, while plain id 11 still resolved to
`game11.mp3`. The count probed as 3. The `WarMain` hook itself is not covered
-- there is no harness that enters a battle, so it needs a real fight.

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
