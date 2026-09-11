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

The mercenary script is renamed, not just edited. `ljd2` calls it `jyyb.lua`
after the `Yb`/`yb` prefix on its functions, an abbreviation of 佣兵; both
trees now call it `jymercenary.lua` and its eighteen functions carry a
`Mercenary_` prefix:

| ljd2 | ported | |
|---|---|---|
| `Yb` | `Mercenary_Menu` | the 佣兵 entry in `MMenu` |
| `Ybcz` | `Mercenary_Menu_AutoJoin` | 出战 |
| `Ybld_Status` | `Mercenary_Menu_Dismiss` | 解雇, was 放逐 |
| `Yb_Menu_Status` | `Mercenary_Menu_Status` | dropped from the menu |
| `Yb_Menu_Thing` | `Mercenary_Menu_Thing` | dropped from the menu |
| `Yb_SelectTeamMenu` | `Mercenary_SelectTeamMenu` | twin of `SelectTeamMenu` |
| `Yb_ShowPersonStatus` | `Mercenary_ShowPersonStatus` | twin of `ShowPersonStatus` |
| `Yb_ShowPersonStatus_sub` | `Mercenary_ShowPersonStatus_sub` | |
| `Yb_UseThing` | `Mercenary_UseThing` | twin of `UseThing` |
| `Yb_DefaultUseThing` | `Mercenary_DefaultUseThing` | twin of `DefaultUseThing` |
| `Yb_Thing` .. `Yb_Thing3` | `Mercenary_UseThing_Type1` .. `_Type3` | 类型 1, 2, 3 |
| `Yb_GetYbNum` | `Mercenary_Count` | filled slots |
| `YbPerson` | `Mercenary_ToggleWarEntry` | toggles `WAR.MercenaryJoin` |
| `ybdw` | `Mercenary_InTeam` | 队伍; 27 call sites, mostly `jywar.lua` |
| `ybjr` | `Mercenary_Join` | 加入 |
| `sjyb` | `Mercenary_GenerateRandom` | 随机佣兵 |

The names mirror `jymain.lua`'s own, so each mercenary function reads as the
twin of the party function it was copied from. Two more identifiers went with
them: `CC.YbNum` (the three mercenary slots) is now `CC.MercenaryNum`, and
`WAR.YbPerson`, a per-slot 0/1/2 flag for who joins the current battle, is now
`WAR.MercenaryJoin`. Neither is save data -- the save's own fields are the
Chinese `JY.Base.佣兵N` keys, which keep their names.

The rename itself is not marked `-- [port]` at each of its ~90 sites; the
table above is the record. The one exception is `MyOEvent.lua:9180`, whose
only difference from the pristine tree is a renamed constant -- it carries a
marker so that a script with no `[port]` marker still means a pristine script.

Renaming both trees keeps `make script-diff` line-oriented: rename only
`game/script/` and the diff degrades to a whole-file add and remove, hiding
every real edit. Re-running `ljd2` produces `jyyb.lua` and the old function
names again, and both have to be redone before the diff means anything.

## Battle effect text stayed on screen for one frame

`jyconst.lua:1792` -- new `CC.EffectTextMS`, default 40
`jywar.lua:20642` -- was an empty `if CONFIG.Operation == 0 then end` block
`jywar.lua:20934` -- was `lib.Delay(1)`

`War_ShowFight` redraws a skill's effect text (击中破绽, 葵花移形, ...) once per
frame for a fixed 20 frames (`jywar.lua:20875`). Two branches present those
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

`jymain.lua:9867`, `9873` -- the two row formats in `SaveList`
`jymain.lua:212`, `1966`, `1984` -- the matching header, three call sites

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

`jymain.lua:9862` -- strip the quotes when reading the date

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

`jyconst.lua:208` -- `CC.BattleMusicFile`, `CC.BattleMusicBase`, `CC.BattleMusicNum`
`jymain.lua:4876` -- `PlayMIDI` addresses the battle range
`jywar.lua:17214` -- pick one on entering a battle

The mod has no battle music. `WarMain` -- the single entry point every battle
in the game routes through -- never touches the music, so combat inherits
whatever the scene or world map was playing. The schema has a per-battle
`CC.WarData_S.音乐` field (`jyconst.lua:2681`) that no script ever reads, and
the only battle-specific track is the victory fanfare `PlayMIDI(100)`
(`jywar.lua:18869`, `18880`), whose `game100.mp3` does not ship.

New tracks go in `sound/battle<N>.mp3`, and the count is probed at startup
rather than hardcoded, so adding a track needs no code change:

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

- `Menu_SetMusic` (`1717`) replays `JY.CurrentMIDI` when you toggle music
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
`game11.mp3`. The `WarMain` hook itself is not covered -- there is no harness
that enters a battle, so it needs a real fight.

`battle4.mp3` and `battle5.mp3` were later dropped into `sound/` with no code
change, which is the claim above put to the test. Running `SetGlobalConst()`
from `game/`, so the count loop probes the same relative paths the engine
does, gives `CC.BattleMusicNum = 5`; `battle6.mp3` is what stops it. Each of
the five ids 9001-9005 maps back to a file that exists, and 5000 draws of
`math.random(CC.BattleMusicNum)` reach all five.

Whether the engine can decode them is a separate question, and the answer is
not in the script. `JY_TEST_MUSIC` plays a fixed `./sound/game11.mp3`, so each
track was fed to it through a directory of symlinks to `game/` with
`game11.mp3` pointed at one battle track at a time. All five load and loop,
at durations matching `afinfo` to the tenth of a second:

    battle1  38.9s    battle2  83.0s    battle3  46.9s
    battle4  86.3s    battle5  36.1s

## The 佣兵 management menu was unreachable

`jymain.lua:1360` -- a 佣兵 entry in `MMenu`
`jymercenary.lua:2` -- the "no mercenaries" check looks at every slot
`jymercenary.lua:22` -- 状态 and 物品 dropped from the menu
`jymercenary.lua:34`, `253`, `274` -- 放逐 renamed to 解雇
`jymercenary.lua:282` -- 解雇 no longer blanks a named NPC

`jymercenary.lua` opens with `Mercenary_Menu()`, a four-entry menu -- 状态,
物品, 出战, 放逐 -- and 放逐 -- now 解雇 -- (`Mercenary_Menu_Dismiss`) is a
complete dismissal: it unequips weapon, armour and training item and releases
each one's 使用人, cancels 佣兵出战 if that mercenary held it, clears the slot
and compacts 1..3.

`Mercenary_Menu` appeared exactly once in all 20 scripts: its own
`function Mercenary_Menu()` line. Nothing ever called it, so the only way to
lose a 保镖 was one of the game's three involuntary paths -- failing to pay on
their pay day (`OEvent6001:1970`), the scripted party-stripping down the well
(`OEvent9001:8583`), or a quest releasing its own (`9324`). Hanging
`Mercenary_Menu` off `MMenu` next to 离队 also brings back 出战
(`Mercenary_Menu_AutoJoin`), which was orphaned the same way.

Two things had to change before that menu was safe to expose.

**`Mercenary_Menu_Dismiss` blanked the person record** by copying template 597
over it. That is right for the three scratch slots `Mercenary_GenerateRandom`
generates random mercenaries into (594-596), and destructive for anything
else: a 保镖 hired from an event is a *named NPC* -- 647 is 镖师张海, and 417,
418, 648-655 are others -- so dismissing one would have overwritten that
character permanently in the save.

Named NPCs are now released the way the game's own code releases them, by
clearing 佛学修为. That field is the "currently engaged" flag, and the
evidence is consistent across all three sites that touch it: the hire sets
`佛学修为 = 1` alongside `儒学修为 = JY.DAY` (pay day) and `盗贼技巧 = 950`
(monthly salary) (`OEvent9001:9868`); the can't-pay dismissal clears it
before clearing the slot (`OEvent6001:1975`); and re-hiring into an occupied
slot clears the outgoing mercenary's (`OEvent9001:9838`). So a dismissed
保镖 becomes re-hireable, which is what those sites intend.

In practice only the `else` branch runs today, since
`Mercenary_GenerateRandom` is orphaned too and nothing puts anyone in 594-596.
The original path is kept for it rather than deleted.

The entry is 解雇 rather than the original 放逐 ("banish"), and the
confirmation reads 已将<name>解雇 rather than 将<name>驱逐出队伍 -- these are
hired hands, not exiles. Written Simplified in the source as everything here
is, so the s2t pass renders them 解僱 and 已將…解僱; `雇` -> `僱` is in
`src/s2t_table.h` and all three characters are in the font. (Simplified `将`
is *not* in the font -- it only ever reaches the renderer as `將` -- which is
a neat demonstration of why that pass exists.)

The menu ships with two of the original four entries, 出战 and 解雇; 状态 and
物品 are dropped. Deleting the rows outright is safe here where it was not for
打赏&赞助 -- `Mercenary_Menu` passes `#var_1_0` as the count and discards
`ShowMenu`'s return, so no index survives the removal to be renumbered.

That leaves `Mercenary_Menu_Status` and `Mercenary_Menu_Thing` unreferenced,
and with them everything below: `Mercenary_ShowPersonStatus`,
`Mercenary_ShowPersonStatus_sub`, `Mercenary_UseThing_Type1` through
`Mercenary_UseThing_Type3`, `Mercenary_UseThing`, `Mercenary_DefaultUseThing`.
They stay in the file. Nothing else reaches them, so the 资质 fix below is now
unreachable too -- kept because it is correct if 状态 is ever put back.

**`Mercenary_Menu` tested only slot 1** for emptiness. The 保镖 hire menu lets
you choose *which* slot to fill (`OEvent9001:9836-9853`), so slot 2 or 3 can
hold someone while 1 is empty, and the menu would have refused to open. It now
scans all `CC.MercenaryNum` slots. `Mercenary_SelectTeamMenu` already handled
gaps -- it builds all three rows and enables only the live ones -- so nothing
else needed changing.

Verified by lifting the new check into a stub harness and running every slot
combination: refuses only when all three are empty, opens for
`(-1, 647, -1)` and `(-1, -1, 647)` where the old one refused.

## 自动出战 was ignored when you picked your own team

`jywar.lua:7529` -- take the auto-battle mercenary without asking

`Mercenary_Menu_AutoJoin` (佣兵 -> 出战) sets `JY.Base.佣兵出战` to a
mercenary who should join every fight. Only one of the two paths through
`WarSelectTeam` honoured it.

Battles that pre-pick their participants (`WAR.Data.自动选择参战人1`) reach
the branch at `7414`, which adds `佣兵出战` and then returns early. Every
other battle falls through to the manual path, which reset all the
`WAR.MercenaryJoin` flags, asked 是否带佣兵出战, and made you pick from a
toggle menu -- so the setting did nothing exactly where it would save the most
clicking.

The manual path now checks for the auto-battle mercenary first and, finding
one, places them and skips both prompts. It resolves them by *slot*, walking
`JY.Base.佣兵1..3` for a match, which is also what makes a stale `佣兵出战`
harmless -- and stale is reachable: `Mercenary_Menu_Dismiss` clears the flag
when it dismisses that mercenary (`jymercenary.lua:276`), but the event
dismissals do not, neither the can't-pay path (`OEvent6001:1975`) nor the well
(`OEvent9001:8583`). No matching slot means no match, and you get the prompt.

Gated on `生命 > 0` as `Mercenary_SelectTeamMenu` is. Skipping the prompt
removes the only chance to decline, so a dead mercenary falls through and you
choose rather than fielding a corpse.

Verified by lifting the new block into a stub harness:

| case | result |
|---|---|
| no 佣兵出战 set | prompts, as before |
| auto in slot 1 / 2 / 3, alive | added silently at that slot's coordinates |
| auto set but 生命 == 0 | prompts |
| auto stale, in no slot | prompts |

## 佣兵 > 状态 crashed on a field that is not in the schema

`jymercenary.lua:860` -- drop the 资质 row

(This panel is no longer reachable -- 状态 was dropped from the menu above.
The fix stands for whenever it is put back.)

`Mercenary_ShowPersonStatus_sub` draws 13 stat rows, and the last one killed
the game as soon as the menu became reachable:

    script/jymain.lua:4497: attempt to index local 'var_90_0' (a nil value)

`JY.Person[i]` is an empty table whose metatable routes *every* key through
the record schema (`jymain.lua:4134`): `__index` calls
`GetDataFromStruct(..., CC.Person_S, key)` and `__newindex` calls
`SetDataFromStruct`. Nothing is ever `rawset`, so a key that `CC.Person_S`
does not define has nowhere to live -- `GetDataFromStruct` indexes the nil
schema entry and dies. `资质` is such a key.

It is not a typo, it is a field the mod uses and never declared.
`Mercenary_GenerateRandom` rolls one for a generated mercenary
(`jymercenary.lua:1516`) and scales 攻击力, 防御力 and 轻功 from it;
`MyOEvent` reads it twice (`9716`, `9973`). Every one of those would crash the
same way -- `Mercenary_GenerateRandom` is orphaned so it never runs, and the
two `MyOEvent` sites are latent. This was never reachable before because
`Mercenary_Menu` itself was not.

Probed at runtime rather than by reading jyconst: the other twelve rows all
resolve to real offsets (攻击力 106, 轻功 108, 防御力 110, 医疗能力 112,
用毒能力 114, 解毒能力 116, 抗毒能力 118, 拳掌功夫 120, 御剑能力 122,
耍刀技巧 124, 特殊兵器 126, 暗器技巧 128), and 资质 is the only key missing.

Dropping the row is the contained fix. Declaring `资质` would mean claiming a
byte offset in the 342-byte person record, which changes the save layout and
would need the offset proven unused first; and it would not be worth doing
for a stat only the orphaned random-mercenary generator ever sets.

## The HUD listed the whole party on every frame

`jymain.lua:9319` -- the 随行护卫 panel is removed
`jymain.lua:9337` -- the 宠物 panel and the 随从 row are removed

`JYZTB` draws the HUD on every frame of both map loops (`1217`, `3836`). Three
of its blocks were roster listings:

| block | where | rows |
|---|---|---|
| 随行护卫 | x=720, top right | a header plus one row per hired mercenary: 姓名, 生命/生命最大值, 善使-武功1 |
| 宠物 | x=20, left, 13 rows down | one row per 宠物 slot: 姓名, 生命/生命最大值, 毒性 |
| 随从 | x=20, below the pets | 随从:麦小八 使马车时间减少2天, when `随从1` is 625 |

The mercenary panel predates the 佣兵 entry in `MMenu`, which was unreachable
in the shipped mod (see above) and is the natural place to read the same
numbers. The two roster panels are also the only HUD elements that grow:
three mercenaries push 90px down the right edge and four pets four rows down
the left, on every frame.

Between them the three blocks account for nine of the function's twenty-two
`DrawString` calls. The row counters go with them -- `var_259_21` through
`var_259_23` for the mercenaries, `var_259_27` through `var_259_35` for the
pets and 随从 -- and nothing outside the blocks reads any of them.
`var_259_20` and `var_259_26` stay, because the rows above each cut derive
from them.

The 随从 row was display only. `MyOEvent.lua:596` is what actually takes two
days off a 马车 trip when `随从1` is 625, and that is untouched, as are the
five other sites that read or set the field.

Verified by calling `JYZTB()` under stubs with all three mercenary and all
four pet slots filled and `随从1 = 625`, against both versions of the file.
This is the only way to see the pet rows at all: no save file has a pet, all
ten have `宠物1..4 = -1`, so they cannot be photographed.

|  | HEAD | now |
|---|---|---|
| `DrawString` calls | 22 | 13 |
| 随行护卫 header | 1 | 0 |
| mercenary rows | 3 | 0 |
| pet rows | 4 | 0 |
| 麦小八 row | 1, at (20, 567) | 0 |

Also checked by rendering slot 2, which is parked on the world map with all
three mercenary slots filled, before and after, and diffing the frames. The
differences fell in exactly two bands: y 31-115 at x 800-1219, the mercenary
panel, and y 674-699, the clock, which ticks between runs regardless.
Counting text-coloured pixels (`M_Silver` and `M_SandyBrown` are both bright;
the map behind them is not) in x 828-1219, y 20-119 gives 5661 before and 33
after.

An earlier attempt to photograph the pet rows by forcing their conditions
from `> 0` to `> -2` is not in that list: `JY.Base.宠物N` is `-1`, so the rows
then read `JY.Person[-1]`, and the frame diverged across 56000 pixels rather
than gaining four rows. It measured the wrong thing and was dropped.

Deleting lines moved everything below in `jymain.lua`, so the references in
this file and in REVERSE.md that pointed past the cuts were re-read out of the
file rather than shifted arithmetically -- several were already stale, by 13
lines in the `SaveList` case and 6 in the header case, from earlier edits.

## 令狐冲 rendered as 令狐衝

`OEvent1901.lua:5699` -- one literal spells 沖 directly
(the rest is `fix_merged` in `src/text.c`, not a script edit)

Simplified 冲 merges two Traditional characters, 沖 and 衝, and a
character-level table has to pick one. `src/s2t_table.h` maps it to 衝, which
is right for 衝突, 衝動, 豪氣衝天, 怒髮衝冠 -- and wrong for 令狐沖, whom the
scripts spell 令狐冲.

The game's own data settles it: person 35 in `Ranger.grp` is Big5 令狐沖. The
data and the dialogue disagreed, and the data is right.

`fix_merged` in `src/text.c` redirects that one character where the
neighbours identify the name -- preceded by 狐, or followed by 兒 or 哥
(沖兒, 沖哥). It runs after the table pass and rewrites in place, so it stays
inside the constraint that kept phrase rules out of the table: nothing is
inserted or removed, and the character count the scripts compute pixel widths
from does not move.

Counted across every occurrence in `game/script/`, simulating table + rule:
**65 become 沖 and 81 stay 衝**, with no false positive in either direction.
Every 沖 is 令狐沖, 沖兒 or 沖哥; the 衝 side is all verbs and 中衝劍 /
關衝劍 / 少衝劍. A bare `"冲"` in `MyOEvent.lua:2924` is an entry in a pinyin
table, where either form is fine.

The one script edit is the exception the render layer cannot reach.
`OEvent1901.lua:5699` wraps the name mid-word as 令狐*冲身上, and `*` is the
line separator (`Split(text, "*")`), so 狐 and 冲 arrive in different draw
calls with no neighbour to match on. That literal spells 沖 directly; it is
unmapped by the table, so it passes through untouched. (The other wrapped
occurrence, 令*狐冲, leaves 狐冲 contiguous and the rule catches it.)

## Effect sprites left their tops behind

`src/lib.c` -- `SaveSur` takes corners, not a size
`jywar.lua:20622`, `20649` -- the caster's effect saves the screen
`jywar.lua:20945` -- the per-person restore moved out of the branch above it

Using a skill left pieces of its effect stranded in mid-air. Two separate
faults, found by tracing every `SaveSur`, `LoadSur` and effect blit through a
real fight -- forcing `WAR.AutoFight` on and feeding only arrow keys, since
Return cancels auto-battle (`17736`).

**`SaveSur(x1, y1, x2, y2)` was read as `(x, y, w, h)`.** `jymain.lua:8840`
settles the convention: a centred dialogue box of width w saves

    lib.SaveSur((CC.ScreenW - w) / 2 - 4, ...,
                (CC.ScreenW + w) / 2 + 4, ...)

which are that box's left and right edges with a 4px margin. Read as a width,
the third argument would be `(1220 + w) / 2 + 4` -- never less than half the
screen, whatever the box. Eleven of the sixteen callers pass the whole screen,
where the two readings agree, which is why this stayed hidden. The five
partial ones saved from their top-left corner to the far edge of the screen
and then restored all of it, putting stale pixels back over whatever had
changed in between.

**The caster's effect loop saved a box too small for the art.** It reached
`18 * CC.YScale` above the anchor, 162px with `CC.YScale` at 9. `eft/66`, the
pillar the 九阴神功 talent fires (`10337` sets `特效动画 = 66` beside the
九阴神功 text), reaches 181, so the top 19 rows of every frame were never
erased -- and its frames shrink, 178 down through 65, 49, 47, 2, so a later
frame could not cover what an earlier one left. Twenty of the 105 effect
archives have art outside that box; `eft/53` escapes it by 159px, `eft/101` by
228. The loop now saves the screen, which is what the engine's three other
effect loops (`19014`, `15191`, and the per-person one) already did.

The first attempt at this fixed a third fault that was not the one on screen:
the per-person loop restored only inside

    if var_122_64 then ... elseif var_122_65 then ... end

so frames with no 特效文字 window open were drawn and left behind. Each
affected person gets a slice of the twenty frames -- `var_122_53 =
math.modf(20 / n)` (`20838`) -- and the slices do not tile the range, so with
two people frame 10 belongs to neither. That restore is now unconditional. It
was a real leak, and fixing it alone did not fix the symptom, which is what
sent the trace after the caster loop.

Verified by trace on the fixed build: 46 saves, all `0,0,1220,700`, and 2051
restores, all at `0,0`. No partial save or restore is left in any effect path,
and the effects still animate -- `eft/66` drew 230 frames at x=610, six other
archives at their own positions.

## The 终极技 cut-in covered the screen with a character portrait

`jywar.lua` -- twelve sites: `2447`, `2499`, `2551`, `12474`, `12518`,
`12564`, `12599`, `12634`, `12669`, `12702`, `13443`, `18700`

When a 终极技 fires the game announces it by zooming the talent name in gold
across a blank screen. Before that it spent 600ms showing one of the nine
`DATA/dz/*.png` character portraits behind the name. The portraits are
fan art in a style that matches nothing else in the game, and the name is
legible without them, so the `lib.LoadPNG(91, ...)` call and the
`lib.Delay(600)` that followed it are gone at all twelve sites. The
surrounding `Cls()` / `ShowScreen()` stay, so the name now zooms in over
black and the announcement is 600ms shorter.

Slot 91 is registered at `jywar.lua:17308` as `CC.DzPath` with
`CC.DzNum = 9`; `lib.LoadPNG` halves the id it is given, so the `91, 8`
at the 绝世天罡 site was `DATA/dz/4.png`. Between them the twelve sites
reached indices 0 through 7 -- `DATA/dz/8.png` was already dead art --
and nothing else in the scripts touches slot 91, so the whole directory
is unreferenced now. It stays on disk; it ships with the mod.

## Debug aids for editing scenes and events

`jyconst.lua:1798` -- `CC.DebugMenu`, `CC.DebugTomb`
`jymain.lua:1405` -- 传送 in the 系统 menu when `JY_DEBUG` is set
`OEvent6001.lua:10897`, `11249` -- force the 无名古墓 event and its variant
`MyOEvent.lua:359`, `391`, `445` -- a landing spot the scene can hold

Two environment switches, both absent by default, so an ordinary launch is
byte-for-byte the game it was:

| variable | effect |
|---|---|
| `JY_DEBUG` | adds a 传送 row to the 系统 menu |
| `JY_DEBUG_TOMB=<1..6>` | the 无名古墓 event fires on the next overworld step, running variant *n* of its six |

**`JY_DEBUG` surfaces something the mod already had.** `Menu_System` ends with

    if var_22_1 == 7 then Menu_HYZB() ... end
    if var_22_1 == 8 then Teleport() ... end

and its menu table holds five entries. `ShowMenu` is called with `#var_22_0`,
so it can never return 7 or 8: `Teleport`, the mod's own teleporter, is
orphaned the same way `Mercenary_Menu` was. `ljd2` names it and its list
`My_ChuangSong_Ex` and `My_ChuangSong_List`, from 传送; both trees now call
them `Teleport` and `Teleport_List`. Its list
(`MyOEvent.lua:479`) enumerates all 137 scenes and enables every one whose
进入条件 is 0, which includes scene 65 无名古墓 -- reachable no other way,
since its 外景入口 is (-1,-1) and no world-map tile leads there. The entry is
appended rather than slotted into the gap at 6 and 7, so indices 1..5 keep
their meaning and the two dead tests stay dead.

**Where teleporting drops you.** `Teleport_List` passed `(-1, -1)`, which
leaves `My_Enter_SubScene` on the scene's own 入口. That is fine for the 126
scenes you can walk into, and useless for the rest: 11 of the 137 name a cell
that is blocked or out of bounds, scene 65 among them at (48,30), where layer
1 holds sprite 4230. Teleporting there put the player inside a wall.

`Scene_EntryXY` (`MyOEvent.lua:445`) returns the 入口 when it is passable
and otherwise the nearest cell that is -- but nearest alone is not enough.
Scene 65's nearest passable cell is (60,18), in a 33-cell pocket sealed off
from everything; standing there is no more use than standing in the wall. So
`Scene_PassableRegions` floods the passable cells into connected regions,
keeps the largest, and the entry point becomes that region's cell closest to
the named 入口. `Scene_Passable` mirrors `SceneCanPass`, which could not be
reused because it reads `JY.SubScene` while the caller has to ask before
entering. It is not called `Scene_CanPass`: a name differing from the
original by one underscore is a trap in review.

`Teleport` offers two ways in and both needed it: 列表选择 goes through
`Teleport_List`, and 输入代码 takes a scene number straight from
`InputNum` (`MyOEvent.lua:539`). The first pass fixed only the list and left
typing `65` still landing in the wall.

Across all 137 scenes: 126 keep their 入口 untouched, 11 are relocated, and
every one of the 137 now lands on a passable cell. Scene 65 goes to (32,27),
in its 178-cell chamber, 16 cells from the entry it names.

That chamber is not the one 梅超风 is in. The tomb is two sealed regions --
178 cells holding the variant 2, 3 and 5/6 spawns at (25,31), (23,30) and
(16,33), and 165 cells holding variants 1 and 4 at (25,17) and (28,15) -- with
no path between them. Teleporting is for looking at the map; the variable
below is what puts you in front of her.

**`JY_DEBUG_TOMB` covers what teleporting cannot.** The tomb's story is not
in the scene; it is inline in the `OEVENTLUA[7001]` branch, 350 lines of
`say`, `WarMain` and loot. Walking into scene 65 gets the map and an empty
room. So the branch condition gains `CC.DebugTomb or` in front of it, and
`var_134_5` -- the `Rnd(6)` that picks which of the six variants runs -- is
overridden when the variable is set.

The nine branches tested before it still get their roll, so a step is
occasionally spent on 山贼 or 狼群 instead. At 声望 114 / 气运 10 a step
reaches the tomb 99.465% of the time, 1.005 steps on average; the effect is
not worth nine more edits to suppress.

Verified by loading slot 2 on the world map and walking, once per setting:

| setting | battle loaded |
|---|---|
| unset | none -- the event did not fire |
| `JY_DEBUG_TOMB=1` | `LoadWarMap: map 65` |
| `JY_DEBUG_TOMB=2` | none |
| `JY_DEBUG_TOMB=3` | none |

`war.sta` record 441 is 名称 梅超風, 地图 65, so map 65 is the right
signature for variant 1's fight, and 442 is 古墓盜賊 on the same map. Variant
2 only fights if you agree to open the coffin and the scripted keys declined;
variant 3 has no battle at all. Unset firing nothing is the control.

`Menu_System` was checked with a stub `ShowMenu` that records what it is
handed, rather than by driving the menu: `Game_MMap` polls `GetKey` once per
frame, so `JY_KEYS` entries are eaten by frame polling before they reach a
submenu, and a first attempt to photograph the menu two ways produced
identical frames because neither run had opened it. The stub gives `n=5` with
the variable unset and `n=6` with 传送 -> `Teleport` appended when it
is set.

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
