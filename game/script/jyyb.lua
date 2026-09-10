function Yb()
	-- [port] checking slot 1 alone is not enough now that this menu is
	-- reachable: the 保镖 hire lets you choose which slot to fill, so 2 or
	-- 3 can hold someone while 1 is empty.
	local var_1_2 = false

	for iter_1_0 = 1, CC.YbNum do
		if JY.Base["佣兵" .. iter_1_0] >= 0 then
			var_1_2 = true

			break
		end
	end

	if not var_1_2 then
		QZXS("队伍里没有佣兵")

		return
	end

	local var_1_0 = {
		-- [port] 状态 and 物品 removed; see docs/PATCHES.md.
		{
			"出战",
			Ybcz,
			1
		},
		{
			"解雇",  -- [port] was 放逐/驱逐出队伍; see docs/PATCHES.md
			Ybld_Status,
			1
		}
	}
	local var_1_1 = ShowMenu(var_1_0, #var_1_0, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	return 1
end

function Yb_Menu_Status()
	DrawStrBox(CC.MainSubMenuX * 1.9, CC.MainSubMenuY, "要查阅谁的状态", C_WHITE, CC.DefaultFont)

	local var_2_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_2_1 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_2_0)

	if var_2_1 > 0 then
		Yb_ShowPersonStatus(var_2_1)

		return 1
	else
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

		return 0
	end
end

function Yb_Menu_Thing()
	local var_3_0 = {
		{
			"神兵宝甲",
			nil,
			1
		},
		{
			"武功秘笈",
			nil,
			1
		},
		{
			"灵丹妙药",
			nil,
			1
		}
	}
	local var_3_1 = ShowMenu(var_3_0, #var_3_0, 0, CC.MainSubMenuX * 1.9, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	local var_3_2 = 0

	if var_3_1 == 3 then
		local var_3_3 = "药品管理"
		local var_3_4 = "管理佣兵的药品，可选择收回或是给予。" .. "*ESC键：退出管理菜单"
		local var_3_5 = {
			"查询",
			"收回",
			"给予"
		}
		local var_3_6 = #var_3_5
		local var_3_7 = JYMsgBox(var_3_3, var_3_4, var_3_5, var_3_6, nil, 1)
		local var_3_8
		local var_3_9
		local var_3_10

		if var_3_7 == 2 then
			DrawStrBox(CC.MainSubMenuX * 5, CC.MainSubMenuY, "请选择要收回哪个佣兵的物品？", C_WHITE, CC.DefaultFont)

			local var_3_11 = CC.MainSubMenuY + CC.SingleLineHeight
			local var_3_12 = Yb_SelectTeamMenu(CC.MainSubMenuX * 3, var_3_11)

			if var_3_12 == 0 then
				return
			end

			local var_3_13 = JY.Base["佣兵" .. var_3_12]

			var_3_2 = 1

			if JY.Person[var_3_13].携带物品1 > -1 then
				instruct_2(JY.Person[var_3_13].携带物品1, -JY.Person[var_3_13].携带物品数量1)
				instruct_41(var_3_13, JY.Person[var_3_13].携带物品1, -JY.Person[var_3_13].携带物品数量1)

				var_3_2 = 2
			end

			if JY.Person[var_3_13].携带物品2 > -1 then
				instruct_2(JY.Person[var_3_13].携带物品2, -JY.Person[var_3_13].携带物品数量2)

				var_3_2 = 2
			end

			if JY.Person[var_3_13].携带物品3 > -1 then
				instruct_2(JY.Person[var_3_13].携带物品3, -JY.Person[var_3_13].携带物品数量3)

				var_3_2 = 2
			end

			if JY.Person[var_3_13].携带物品4 > -1 then
				instruct_2(JY.Person[var_3_13].携带物品4, -JY.Person[var_3_13].携带物品数量4)
				instruct_41(var_3_13, JY.Person[var_3_13].携带物品4, -JY.Person[var_3_13].携带物品数量4)

				var_3_2 = 2
			end

			if var_3_2 == 1 then
				MyTalkEx("我现在没有携带药品", JY.Person[var_3_13].头像代号, 0, 1, JY.Person[var_3_13].姓名)
			end
		elseif var_3_7 == 1 then
			DrawStrBox(CC.MainSubMenuX * 5, CC.MainSubMenuY, "请选择要查看哪个佣兵的物品？", C_WHITE, CC.DefaultFont)

			local var_3_14 = CC.MainSubMenuY + CC.SingleLineHeight
			local var_3_15 = Yb_SelectTeamMenu(CC.MainSubMenuX * 3, var_3_14)

			if var_3_15 == 0 then
				return
			end

			local var_3_16 = JY.Base["佣兵" .. var_3_15]

			var_3_2 = 1

			local var_3_17 = ""

			if JY.Person[var_3_16].携带物品1 > -1 then
				var_3_17 = JY.Thing[JY.Person[var_3_16].携带物品1].名称 .. JY.Person[var_3_16].携带物品数量1 .. "个。"
			end

			if JY.Person[var_3_16].携带物品2 > -1 then
				var_3_17 = var_3_17 .. JY.Thing[JY.Person[var_3_16].携带物品2].名称 .. JY.Person[var_3_16].携带物品数量2 .. "个。"
			end

			if JY.Person[var_3_16].携带物品3 > -1 then
				var_3_17 = var_3_17 .. JY.Thing[JY.Person[var_3_16].携带物品3].名称 .. JY.Person[var_3_16].携带物品数量3 .. "个。"
			end

			if JY.Person[var_3_16].携带物品4 > -1 then
				var_3_17 = var_3_17 .. JY.Thing[JY.Person[var_3_16].携带物品4].名称 .. JY.Person[var_3_16].携带物品数量4 .. "个。"
			end

			if var_3_17 == "" then
				MyTalkEx("我现在没有携带药品", JY.Person[var_3_16].头像代号, 0, 1, JY.Person[var_3_16].姓名)
			else
				MyTalkEx("我现在携带的有" .. var_3_17, JY.Person[var_3_16].头像代号, 0, 1, JY.Person[var_3_16].姓名)
			end
		end
	end

	if var_3_1 > 0 then
		local var_3_18 = {}
		local var_3_19 = {}

		for iter_3_0 = 0, CC.MyThingNum - 1 do
			var_3_18[iter_3_0] = -1
			var_3_19[iter_3_0] = 0
		end

		local var_3_20 = 0

		for iter_3_1 = 0, CC.MyThingNum - 1 do
			local var_3_21 = JY.Base["物品" .. iter_3_1 + 1]

			if var_3_21 >= 0 then
				if var_3_1 == 1 and JY.Thing[var_3_21].类型 == 1 then
					var_3_18[var_3_20] = var_3_21
					var_3_19[var_3_20] = JY.Base["物品数量" .. iter_3_1 + 1]
					var_3_20 = var_3_20 + 1
				elseif var_3_1 == 2 and JY.Thing[var_3_21].类型 == 2 then
					var_3_18[var_3_20] = var_3_21
					var_3_19[var_3_20] = JY.Base["物品数量" .. iter_3_1 + 1]
					var_3_20 = var_3_20 + 1
				elseif var_3_1 == 3 and JY.Thing[var_3_21].类型 == 3 then
					var_3_18[var_3_20] = var_3_21
					var_3_19[var_3_20] = JY.Base["物品数量" .. iter_3_1 + 1]
					var_3_20 = var_3_20 + 1
				end
			end
		end

		if var_3_2 < 1 then
			local var_3_22 = SelectThing(var_3_18, var_3_19)

			if var_3_22 >= 0 then
				Yb_UseThing(var_3_22)

				return 1
			end
		end
	end

	return 0
end

function Ybcz()
	DrawStrBox(CC.MainSubMenuX * 1.9, CC.MainSubMenuY, "设置佣兵出战", C_WHITE, CC.DefaultFont)

	local var_4_0 = CC.MainSubMenuY + CC.SingleLineHeight

	if JY.Base.佣兵出战 > -1 then
		QZXS("已取消" .. JY.Person[JY.Base.佣兵出战].姓名 .. "跟随出战")

		JY.Base.佣兵出战 = -1

		return 1
	end

	local var_4_1 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_4_0)

	if var_4_1 > 0 then
		JY.Base.佣兵出战 = JY.Base["佣兵" .. var_4_1]

		QZXS("已设置自动战斗时由" .. JY.Person[JY.Base.佣兵出战].姓名 .. "的跟随出战")

		return 1
	else
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

		return 0
	end
end

function Ybld_Status()
	DrawStrBox(CC.MainSubMenuX * 1.9, CC.MainSubMenuY, "要将哪个佣兵解雇?", C_WHITE, CC.DefaultFont)  -- [port] was 放逐/驱逐出队伍; see docs/PATCHES.md

	local var_5_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_5_1 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_5_0)

	if var_5_1 > 0 then
		if JY.Person[JY.Base["佣兵" .. var_5_1]].武器 >= 0 then
			JY.Thing[JY.Person[JY.Base["佣兵" .. var_5_1]].武器].使用人 = -1
			JY.Person[JY.Base["佣兵" .. var_5_1]].武器 = -1
		end

		if JY.Person[JY.Base["佣兵" .. var_5_1]].防具 >= 0 then
			JY.Thing[JY.Person[JY.Base["佣兵" .. var_5_1]].防具].使用人 = -1
			JY.Person[JY.Base["佣兵" .. var_5_1]].防具 = -1
		end

		if JY.Person[JY.Base["佣兵" .. var_5_1]].修炼物品 >= 0 then
			JY.Thing[JY.Person[JY.Base["佣兵" .. var_5_1]].修炼物品].使用人 = -1
			JY.Person[JY.Base["佣兵" .. var_5_1]].修炼物品 = -1
		end

		QZXS("已将" .. JY.Person[JY.Base["佣兵" .. var_5_1]].姓名 .. "解雇")  -- [port] was 放逐/驱逐出队伍; see docs/PATCHES.md

		if JY.Base.佣兵出战 == JY.Base["佣兵" .. var_5_1] then
			JY.Base.佣兵出战 = -1

			QZXS(JY.Person[JY.Base["佣兵" .. var_5_1]].姓名 .. "的自动出战已被取消")
		end

		-- [port] see docs/PATCHES.md. Blanking the record from template 597
		-- is only safe for the three scratch slots sjyb generates into. A
		-- 保镖 hired from an event is a named NPC, and overwriting one would
		-- destroy that character in the save. Release those the way the
		-- game's own dismissals do, by clearing the 佛学修为 "engaged" flag.
		local var_5_2 = JY.Base["佣兵" .. var_5_1]

		if var_5_2 >= 594 and var_5_2 <= 596 then
			for iter_5_0 = 1, #PSX - 8 do
				JY.Person[var_5_2][PSX[iter_5_0]] = JY.Person[597][PSX[iter_5_0]]
			end

			JY.Person[var_5_2].姓名 = JY.Person[597].姓名
		else
			JY.Person[var_5_2].佛学修为 = 0
		end

		JY.Base["佣兵" .. var_5_1] = -1

		if var_5_1 == 1 then
			JY.Base.佣兵1 = JY.Base.佣兵2
			JY.Base.佣兵2 = JY.Base.佣兵3
			JY.Base.佣兵3 = -1
		elseif var_5_1 == 2 then
			JY.Base.佣兵2 = JY.Base.佣兵3
			JY.Base.佣兵3 = -1
		elseif var_5_1 == 3 then
			JY.Base.佣兵3 = -1
		end

		return 1
	else
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

		return 0
	end
end

function Yb_DefaultUseThing(arg_6_0)
	if JY.Thing[arg_6_0].类型 == 1 then
		return Yb_Thing(arg_6_0)
	elseif JY.Thing[arg_6_0].类型 == 2 then
		return Yb_Thing2(arg_6_0)
	elseif JY.Thing[arg_6_0].类型 == 3 then
		return Yb_Thing3(arg_6_0)
	end
end

function Yb_Thing(arg_7_0)
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要配备%s?", JY.Thing[arg_7_0].名称), C_WHITE, CC.DefaultFont)

	local var_7_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_7_1 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_7_0)
	local var_7_2 = 0
	local var_7_3 = 0

	if var_7_1 > 0 then
		local var_7_4 = JY.Base["佣兵" .. var_7_1]

		if CanUseThing(arg_7_0, var_7_4) or T2SQ(var_7_4) then
			if JY.Thing[arg_7_0].装备类型 == 0 then
				if JY.Thing[arg_7_0].使用人 >= 0 then
					if JY.Person[JY.Thing[arg_7_0].使用人].姓名 == JY.SQ then
						JY.Thing[arg_7_0].加攻击力 = JY.Thing[arg_7_0].加攻击力 / 2
						JY.Thing[arg_7_0].加防御力 = JY.Thing[arg_7_0].加防御力 / 2
						JY.Thing[arg_7_0].加轻功 = JY.Thing[arg_7_0].加轻功 / 2
					end

					JY.Person[JY.Thing[arg_7_0].使用人].武器 = -1
				end

				if JY.Person[var_7_4].武器 >= 0 then
					if T2SQ(var_7_4) then
						JY.Thing[JY.Person[var_7_4].武器].加攻击力 = JY.Thing[JY.Person[var_7_4].武器].加攻击力 / 2
						JY.Thing[JY.Person[var_7_4].武器].加防御力 = JY.Thing[JY.Person[var_7_4].武器].加防御力 / 2
						JY.Thing[JY.Person[var_7_4].武器].加轻功 = JY.Thing[JY.Person[var_7_4].武器].加轻功 / 2
					end

					JY.Thing[JY.Person[var_7_4].武器].使用人 = -1
				end

				JY.Person[var_7_4].武器 = arg_7_0

				if T2SQ(var_7_4) then
					JY.Thing[arg_7_0].加攻击力 = JY.Thing[arg_7_0].加攻击力 * 2
					JY.Thing[arg_7_0].加防御力 = JY.Thing[arg_7_0].加防御力 * 2
					JY.Thing[arg_7_0].加轻功 = JY.Thing[arg_7_0].加轻功 * 2
				end
			elseif JY.Thing[arg_7_0].装备类型 == 1 then
				if JY.Thing[arg_7_0].使用人 >= 0 then
					if JY.Person[JY.Thing[arg_7_0].使用人].姓名 == JY.SQ then
						JY.Thing[arg_7_0].加攻击力 = JY.Thing[arg_7_0].加攻击力 / 2
						JY.Thing[arg_7_0].加防御力 = JY.Thing[arg_7_0].加防御力 / 2
						JY.Thing[arg_7_0].加轻功 = JY.Thing[arg_7_0].加轻功 / 2
					end

					JY.Person[JY.Thing[arg_7_0].使用人].防具 = -1
				end

				if JY.Person[var_7_4].防具 >= 0 then
					if T2SQ(var_7_4) then
						JY.Thing[JY.Person[var_7_4].防具].加攻击力 = JY.Thing[JY.Person[var_7_4].防具].加攻击力 / 2
						JY.Thing[JY.Person[var_7_4].防具].加防御力 = JY.Thing[JY.Person[var_7_4].防具].加防御力 / 2
						JY.Thing[JY.Person[var_7_4].防具].加轻功 = JY.Thing[JY.Person[var_7_4].防具].加轻功 / 2
					end

					JY.Thing[JY.Person[var_7_4].防具].使用人 = -1
				end

				JY.Person[var_7_4].防具 = arg_7_0

				if T2SQ(var_7_4) then
					JY.Thing[arg_7_0].加攻击力 = JY.Thing[arg_7_0].加攻击力 * 2
					JY.Thing[arg_7_0].加防御力 = JY.Thing[arg_7_0].加防御力 * 2
					JY.Thing[arg_7_0].加轻功 = JY.Thing[arg_7_0].加轻功 * 2
				end
			end

			JY.Thing[arg_7_0].使用人 = var_7_4
		else
			DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	return 1
end

function Yb_Thing2(arg_8_0)
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要修炼%s?", JY.Thing[arg_8_0].名称), C_WHITE, CC.DefaultFont)

	local var_8_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_8_1 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_8_0)

	if var_8_1 > 0 then
		local var_8_2 = JY.Base["佣兵" .. var_8_1]
		local var_8_3
		local var_8_4

		if JY.Thing[arg_8_0].练出武功 >= 0 then
			var_8_3 = 0
			var_8_4 = 1

			for iter_8_0 = 1, 8 do
				if JY.Person[var_8_2]["武功" .. iter_8_0] == JY.Thing[arg_8_0].练出武功 then
					var_8_3 = 1
				elseif JY.Person[var_8_2]["武功" .. iter_8_0] == 0 then
					var_8_4 = 0
				end
			end
		end

		if var_8_3 == 0 and var_8_4 == 1 then
			DrawStrBoxWaitKey("佣兵只能修炼8种武功", C_WHITE, CC.DefaultFont)

			return 0
		end

		if CC.Shemale[arg_8_0] == 1 then
			if T1LEQ(var_8_2) or T2SQ(var_8_2) or T3XXM(var_8_2) then
				say("５Ｒ欲练神功　挥刀自宫")
				say("２这太惨了吧！先看看再说....Ｈ（翻到下一页）")
				say("５Ｒ若不自宫　也可练功")
				say("１哈，原来不自宫也能练啊！Ｈ太棒了！！！")

				var_8_3 = 2
			elseif cxtd(var_8_2, 29) and GetS(86, 10, 12, 5) == 1 then
				Talk(JY.Thing[arg_8_0].名称 .. " 这玩意不适合我", 29)

				return 0
			elseif JY.Person[var_8_2].性别 == 0 and CanUseThing(arg_8_0, var_8_2) then
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

				if DrawStrBoxYesNo(-1, -1, "修炼此书必须先挥刀自宫，是否仍要修炼?", C_WHITE, CC.DefaultFont) == false then
					return 0
				else
					lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
					ShowScreen()
					lib.Delay(80)
					lib.ShowSlow(15, 1)
					Cls()
					lib.ShowSlow(100, 0)

					JY.Person[var_8_2].性别 = 2

					local var_8_5, var_8_6 = AddPersonAttrib(var_8_2, "攻击力", -15)

					DrawStrBoxWaitKey(JY.Person[var_8_2].姓名 .. var_8_6, C_ORANGE, CC.DefaultFont)

					local var_8_7, var_8_8 = AddPersonAttrib(var_8_2, "防御力", -25)

					DrawStrBoxWaitKey(JY.Person[var_8_2].姓名 .. var_8_8, C_ORANGE, CC.DefaultFont)
				end
			elseif JY.Person[var_8_2].性别 == 1 then
				DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)

				return 0
			end
		end

		if var_8_3 == 1 or CanUseThing(arg_8_0, var_8_2) or var_8_3 == 2 then
			if JY.Thing[arg_8_0].使用人 == var_8_2 then
				return 0
			end

			if JY.Person[var_8_2].修炼物品 >= 0 then
				JY.Thing[JY.Person[var_8_2].修炼物品].使用人 = -1
			end

			if JY.Thing[arg_8_0].使用人 >= 0 then
				JY.Person[JY.Thing[arg_8_0].使用人].修炼物品 = -1
				JY.Person[JY.Thing[arg_8_0].使用人].物品修炼点数 = 0
			end

			JY.Thing[arg_8_0].使用人 = var_8_2
			JY.Person[var_8_2].修炼物品 = arg_8_0
			JY.Person[var_8_2].修炼点数 = 30000
			JY.Person[var_8_2].物品修炼点数 = 30000

			War_PersonTrainBook(var_8_2)
		else
			DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	return 0
end

function Yb_Thing3(arg_9_0)
	local var_9_0 = -1

	if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("给谁分配%s?", JY.Thing[arg_9_0].名称), C_WHITE, CC.DefaultFont)

		local var_9_1 = CC.MainSubMenuY + CC.SingleLineHeight
		local var_9_2 = Yb_SelectTeamMenu(CC.MainSubMenuX, var_9_1)

		if var_9_2 > 0 then
			var_9_0 = JY.Base["佣兵" .. var_9_2]
		end

		local var_9_3 = 0

		if DrawStrBoxYesNo(-1, -1, "要把这个药品分配给" .. JY.Person[var_9_0].姓名 .. "吗？", C_WHITE, CC.DefaultFont) == true then
			if var_9_0 >= 0 then
				if (JY.Person[var_9_0].携带物品1 == arg_9_0 or JY.Person[var_9_0].携带物品数量1 == 0) and var_9_3 == 0 then
					instruct_2(arg_9_0, -1)

					JY.Person[var_9_0].携带物品1 = arg_9_0
					JY.Person[var_9_0].携带物品数量1 = JY.Person[var_9_0].携带物品数量1 + 1
					var_9_3 = 1
				end

				if (JY.Person[var_9_0].携带物品2 == arg_9_0 or JY.Person[var_9_0].携带物品数量2 == 0) and var_9_3 == 0 then
					instruct_2(arg_9_0, -1)

					JY.Person[var_9_0].携带物品2 = arg_9_0
					JY.Person[var_9_0].携带物品数量2 = JY.Person[var_9_0].携带物品数量2 + 1
					var_9_3 = 1
				end

				if (JY.Person[var_9_0].携带物品3 == arg_9_0 or JY.Person[var_9_0].携带物品数量3 == 0) and var_9_3 == 0 then
					instruct_2(arg_9_0, -1)

					JY.Person[var_9_0].携带物品3 = arg_9_0
					JY.Person[var_9_0].携带物品数量3 = JY.Person[var_9_0].携带物品数量3 + 1
					var_9_3 = 1
				end

				if (JY.Person[var_9_0].携带物品4 == arg_9_0 or JY.Person[var_9_0].携带物品数量4 == 0) and var_9_3 == 0 then
					instruct_2(arg_9_0, -1)

					JY.Person[var_9_0].携带物品4 = arg_9_0
					JY.Person[var_9_0].携带物品数量4 = JY.Person[var_9_0].携带物品数量4 + 1
					var_9_3 = 1
				end
			end

			if var_9_3 == 0 then
				QZXS("分配药品失败，佣兵物品栏已满")
			end
		else
			Cls()

			return 0
		end

		return 1
	end
end

function Yb_UseThing(arg_10_0)
	if JY.ThingUseFunction[arg_10_0] == nil then
		return Yb_DefaultUseThing(arg_10_0)
	else
		return JY.ThingUseFunction[arg_10_0](arg_10_0)
	end
end

function Yb_SelectTeamMenu(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0 = 1, CC.YbNum do
		var_11_0[iter_11_0] = {
			"",
			nil,
			0
		}

		local var_11_1 = JY.Base["佣兵" .. iter_11_0]

		if var_11_1 >= 0 and JY.Person[var_11_1].生命 > 0 then
			var_11_0[iter_11_0][1] = JY.Person[var_11_1].姓名
			var_11_0[iter_11_0][3] = 1
		end
	end

	return ShowMenu(var_11_0, CC.YbNum, 0, arg_11_0 * 1.9, arg_11_1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
end

function Yb_ShowPersonStatus(arg_12_0)
	local var_12_0 = 1
	local var_12_1 = 2
	local var_12_2 = Yb_GetYbNum()

	while true do
		Cls()

		local var_12_3 = JY.Base["佣兵" .. arg_12_0]

		Yb_ShowPersonStatus_sub(var_12_3, var_12_0)
		ShowScreen()

		local var_12_4 = WaitKey()

		lib.Delay(100)

		if var_12_4 == VK_ESCAPE then
			break
		elseif var_12_4 == VK_UP then
			arg_12_0 = arg_12_0 - 1
		elseif var_12_4 == VK_DOWN then
			arg_12_0 = arg_12_0 + 1
		elseif var_12_4 == VK_LEFT then
			var_12_0 = var_12_0 - 1
		elseif var_12_4 == VK_RIGHT then
			var_12_0 = var_12_0 + 1
		elseif var_12_4 == VK_SPACE then
			Cls()

			if TFNLJS[JY.Person[var_12_3].天赋] ~= nil then
				say(TFNLJS[JY.Person[var_12_3].天赋], JY.Person[var_12_3].头像代号, 5, JY.Person[var_12_3].姓名)
			end
		end

		arg_12_0 = limitX(arg_12_0, 1, var_12_2)
		var_12_0 = limitX(var_12_0, 1, var_12_1)
	end
end

function Yb_ShowPersonStatus_sub(arg_13_0, arg_13_1)
	local var_13_0 = CC.DefaultFont
	local var_13_1 = JY.Person[arg_13_0]
	local var_13_2 = JY.Person[0]
	local var_13_3 = 20 * var_13_0 + 15
	local var_13_4 = var_13_0 + CC.PersonStateRowPixel
	local var_13_5 = 14 * var_13_4 + 10
	local var_13_6 = (CC.ScreenW - var_13_3) / 2
	local var_13_7 = (CC.ScreenH - var_13_5) / 2
	local var_13_8 = 1
	local var_13_9
	local var_13_10
	local var_13_11

	DrawBox(var_13_6, var_13_7, var_13_6 + var_13_3, var_13_7 + var_13_5, C_WHITE)

	local var_13_12 = var_13_6 + 5
	local var_13_13 = var_13_7 + 5
	local var_13_14 = 4 * var_13_0
	local var_13_15 = var_13_1.头像代号
	local var_13_16, var_13_17 = lib.GetPNGXY(1, var_13_15 * 2)
	local var_13_18 = (var_13_3 / 2 - var_13_16) / 3
	local var_13_19 = (var_13_4 * 6 - var_13_17) / 6

	drawname(var_13_12 + var_13_4, var_13_13, "佣兵", CC.FontBIG, var_13_0)

	if arg_13_0 == JY.Base.佣兵出战 then
		drawname(var_13_12 + var_13_4 * 7, var_13_13, "出战", CC.FontBIG, var_13_0)
	end

	lib.LoadPNG(1, var_13_15 * 2, var_13_12 + var_13_18, var_13_13 + var_13_19, 1)

	local var_13_20 = 5

	DrawString(var_13_12, var_13_13 + var_13_4 * var_13_20, var_13_1.姓名, C_WHITE, var_13_0)
	DrawString(var_13_12 + 10 * var_13_0 / 2, var_13_13 + var_13_4 * var_13_20, string.format("%3d", var_13_1.等级), C_GOLD, var_13_0)
	DrawString(var_13_12 + 13 * var_13_0 / 2, var_13_13 + var_13_4 * var_13_20, "级", C_ORANGE, var_13_0)

	local var_13_21 = var_13_20 + 1

	DrawString(var_13_12, var_13_13 + var_13_4 * var_13_21, "天赋：", C_GOLD, var_13_0)

	if RWTFLB[JY.Person[arg_13_0].天赋] ~= nil then
		DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_21, RWTFLB[JY.Person[arg_13_0].天赋], C_GOLD, var_13_0)
	else
		DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_21, "无", C_GOLD, var_13_0)
	end

	local var_13_22 = var_13_21 + 1

	DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "称号：", C_GOLD, var_13_0)

	if RWWH[JY.Person[arg_13_0].天赋] ~= nil then
		DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_22, RWWH[JY.Person[arg_13_0].天赋], C_GOLD, var_13_0)
	else
		DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_22, "无", C_GOLD, var_13_0)
	end

	local function var_13_23(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		arg_14_3 = arg_14_3 or 0

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, arg_14_0, arg_14_1, var_13_0)
		DrawString(var_13_12 + var_13_14, var_13_13 + var_13_4 * var_13_22, string.format("%5d", var_13_1[arg_14_0] + arg_14_3), arg_14_2, var_13_0)

		var_13_22 = var_13_22 + 1
	end

	if arg_13_1 == 1 then
		local var_13_24

		if var_13_1.受伤程度 < 33 then
			var_13_24 = RGB(236, 200, 40)
		elseif var_13_1.受伤程度 < 66 then
			var_13_24 = RGB(244, 128, 32)
		else
			var_13_24 = RGB(232, 32, 44)
		end

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "生命", C_ORANGE, var_13_0)
		DrawString(var_13_12 + 2 * var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%5d", var_13_1.生命), var_13_24, var_13_0)
		DrawString(var_13_12 + 9 * var_13_0 / 2, var_13_13 + var_13_4 * var_13_22, "/", C_GOLD, var_13_0)

		if var_13_1.中毒程度 == 0 then
			var_13_24 = RGB(252, 148, 16)
		elseif var_13_1.中毒程度 < 50 then
			var_13_24 = RGB(120, 208, 88)
		else
			var_13_24 = RGB(56, 136, 36)
		end

		DrawString(var_13_12 + 5 * var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%5s", var_13_1.生命最大值), var_13_24, var_13_0)

		var_13_22 = var_13_22 + 1

		if var_13_1.内力性质 == 0 then
			var_13_24 = RGB(208, 152, 208)
		elseif var_13_1.内力性质 == 1 then
			var_13_24 = RGB(236, 200, 40)
		else
			var_13_24 = RGB(236, 236, 236)
		end

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "内力", C_ORANGE, var_13_0)
		DrawString(var_13_12 + 2 * var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%5d/%5d", var_13_1.内力, var_13_1.内力最大值), var_13_24, var_13_0)

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "体力", C_ORANGE, var_13_0)
		DrawString(var_13_12 + var_13_0 * 2 + 8, var_13_13 + var_13_4 * var_13_22, var_13_1.体力, C_GOLD, var_13_0)
		DrawString(var_13_12 + var_13_0 * 4 + 16, var_13_13 + var_13_4 * var_13_22, "体质", C_ORANGE, var_13_0)
		DrawString(var_13_12 + var_13_0 * 6 + 32, var_13_13 + var_13_4 * var_13_22, var_13_1.生命增长, C_GOLD, var_13_0)

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "实战", C_ORANGE, var_13_0)

		for iter_13_0 = 1, #TeamP do
			if arg_13_0 == TeamP[iter_13_0] then
				local var_13_25 = GetS(5, iter_13_0, 6, 5) - 2
				local var_13_26 = C_GOLD

				if var_13_25 > 499 then
					var_13_25 = "极"
					var_13_26 = C_RED
				end

				DrawString(var_13_12 + var_13_0 * 2 + 8, var_13_13 + var_13_4 * var_13_22, var_13_25, var_13_26, var_13_0)
			end
		end

		DrawString(var_13_12 + var_13_0 * 4 + 16, var_13_13 + var_13_4 * var_13_22, "互搏", C_ORANGE, var_13_0)

		local var_13_27
		local var_13_28 = var_13_1.左右互搏 == 1 and "◎" or "※"

		DrawString(var_13_12 + var_13_0 * 6 + 24, var_13_13 + var_13_4 * var_13_22, var_13_28, C_GOLD, var_13_0)

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "升级", C_ORANGE, var_13_0)

		local var_13_29

		if var_13_1.等级 >= 30 then
			var_13_29 = " ="
		else
			var_13_29 = 2 * (var_13_1.经验 - CC.Exp[var_13_1.等级 - 1])

			if var_13_29 < 0 then
				var_13_29 = " 0"
			elseif var_13_29 < 10 then
				var_13_29 = " " .. var_13_29
			elseif var_13_29 < 100 then
				var_13_29 = " " .. var_13_29
			elseif var_13_29 < 1000 then
				var_13_29 = " " .. var_13_29
			end
		end

		DrawString(var_13_12 + var_13_0 * 2 + 16, var_13_13 + var_13_4 * var_13_22, var_13_29, C_GOLD, var_13_0)

		local var_13_30
		local var_13_31 = CC.Level <= var_13_1.等级 and "=" or 2 * (CC.Exp[var_13_1.等级] - CC.Exp[var_13_1.等级 - 1])

		DrawString(var_13_12 + var_13_0 * 4 + 16, var_13_13 + var_13_4 * var_13_22, "/" .. var_13_31, C_GOLD, var_13_0)

		local var_13_32 = 0
		local var_13_33 = 0
		local var_13_34 = 0

		if var_13_1.武器 > -1 then
			var_13_32 = var_13_32 + JY.Thing[var_13_1.武器].加攻击力
			var_13_33 = var_13_33 + JY.Thing[var_13_1.武器].加防御力
			var_13_34 = var_13_34 + JY.Thing[var_13_1.武器].加轻功
		end

		if var_13_1.防具 > -1 then
			var_13_32 = var_13_32 + JY.Thing[var_13_1.防具].加攻击力
			var_13_33 = var_13_33 + JY.Thing[var_13_1.防具].加防御力
			var_13_34 = var_13_34 + JY.Thing[var_13_1.防具].加轻功
		end

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "左右键切换属性界面 上下键切换其他佣兵", C_RED, var_13_0)

		var_13_22 = 0
		var_13_12 = var_13_6 + var_13_3 / 2 - 24

		var_13_23("攻击力", C_WHITE, C_GOLD)
		DrawString(var_13_12 + var_13_0 * 7, var_13_13, "↑ " .. var_13_32, C_GOLD, var_13_0)
		var_13_23("防御力", C_WHITE, C_GOLD)
		DrawString(var_13_12 + var_13_0 * 7, var_13_13 + var_13_4, "↑ " .. var_13_33, C_GOLD, var_13_0)
		var_13_23("轻功", C_WHITE, C_GOLD)

		if var_13_34 > -1 then
			DrawString(var_13_12 + var_13_0 * 7, var_13_13 + var_13_4 * 2, "↑ " .. var_13_34, C_GOLD, var_13_0)
		else
			local var_13_35 = -var_13_34

			DrawString(var_13_12 + var_13_0 * 7, var_13_13 + var_13_4 * 2, "↓ " .. var_13_35, C_GOLD, var_13_0)
		end

		var_13_23("医疗能力", C_WHITE, C_GOLD)
		var_13_23("用毒能力", C_WHITE, C_GOLD)
		var_13_23("解毒能力", C_WHITE, C_GOLD)
		var_13_23("拳掌功夫", C_WHITE, C_GOLD)
		var_13_23("御剑能力", C_WHITE, C_GOLD)
		var_13_23("耍刀技巧", C_WHITE, C_GOLD)
		var_13_23("特殊兵器", C_WHITE, C_GOLD)
		var_13_23("暗器技巧", C_WHITE, C_GOLD)
		var_13_23("抗毒能力", C_WHITE, C_GOLD)
		-- [port] 资质 row removed; see docs/PATCHES.md.
	elseif arg_13_1 == 2 then
		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "武器:", C_ORANGE, var_13_0)

		if var_13_1.武器 > -1 then
			DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_22, JY.Thing[var_13_1.武器].名称, C_GOLD, var_13_0)
		end

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "防具:", C_ORANGE, var_13_0)

		if var_13_1.防具 > -1 then
			DrawString(var_13_12 + var_13_0 * 3, var_13_13 + var_13_4 * var_13_22, JY.Thing[var_13_1.防具].名称, C_GOLD, var_13_0)
		end

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "修炼物品", C_ORANGE, var_13_0)

		local var_13_36 = var_13_1.修炼物品

		if var_13_36 > 0 then
			var_13_22 = var_13_22 + 1

			DrawString(var_13_12 + var_13_0, var_13_13 + var_13_4 * var_13_22, JY.Thing[var_13_36].名称, C_GOLD, var_13_0)

			var_13_22 = var_13_22 + 1

			local var_13_37 = TrainNeedExp(arg_13_0)

			if var_13_37 < math.huge then
				DrawString(var_13_12 + var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%5d/%5d", var_13_1.修炼点数, var_13_37), C_GOLD, var_13_0)
			else
				DrawString(var_13_12 + var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%5d/===", var_13_1.修炼点数), C_GOLD, var_13_0)
			end
		else
			var_13_22 = var_13_22 + 2
		end

		var_13_22 = var_13_22 + 1

		DrawString(var_13_12, var_13_13 + var_13_4 * var_13_22, "左右键切换属性界面 上下键切换其他佣兵", C_RED, var_13_0)

		var_13_22 = 0
		var_13_12 = var_13_6 + var_13_3 / 2

		local function var_13_38(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = 0

			if arg_15_2 > 10 then
				var_15_0 = JY.Wugong[arg_15_1]["攻击力" .. 10]
			else
				var_15_0 = JY.Wugong[arg_15_1]["攻击力" .. arg_15_2]
			end

			if arg_15_1 == 85 or arg_15_1 == 87 or arg_15_1 == 88 then
				if arg_15_2 > 10 then
					var_15_0 = JY.Wugong[arg_15_1]["杀内力" .. 10]
				else
					var_15_0 = JY.Wugong[arg_15_1]["杀内力" .. arg_15_2]
				end
			end

			for iter_15_0, iter_15_1 in ipairs(CC.ExtraOffense) do
				if iter_15_1[1] == JY.Person[arg_15_0].武器 and iter_15_1[2] == arg_15_1 then
					var_15_0 = var_15_0 + iter_15_1[3]

					break
				end
			end

			return var_15_0
		end

		DrawString(var_13_12 - var_13_0, var_13_13 + var_13_4 * var_13_22, "所会功夫　　等级　威力", C_ORANGE, var_13_0)

		local var_13_39 = {
			"一",
			"二",
			"三",
			"四",
			"五",
			"六",
			"七",
			"八",
			"九",
			"十",
			"极"
		}

		if JY.Person[0].武功1 > 108 and JY.Person[0].武功等级1 < 900 then
			JY.Person[0].武功等级1 = 900
		end

		for iter_13_1 = 1, 10 do
			var_13_22 = var_13_22 + 1

			local var_13_40 = var_13_1["武功" .. iter_13_1]

			if var_13_40 > 0 then
				local var_13_41 = math.modf(var_13_1["武功等级" .. iter_13_1] / 100) + 1

				if var_13_1["武功等级" .. iter_13_1] == 999 then
					var_13_41 = 11
				end

				local var_13_42 = C_GOLD

				if var_13_40 == 43 or var_13_40 == 85 or var_13_40 > 86 and var_13_40 < 109 then
					var_13_42 = RGB(200, 36, 69)
				end

				for iter_13_2, iter_13_3 in pairs(CC.PersonWs) do
					if iter_13_3[1] ~= nil and cxtd(arg_13_0, iter_13_3[1]) and var_13_40 == iter_13_3[2] then
						var_13_42 = RGB(192, 192, 192)
					end
				end

				local var_13_43 = C_ORANGE

				if var_13_40 == 43 or var_13_40 == 85 or var_13_40 > 86 and var_13_40 < 109 then
					var_13_43 = C_RED
				end

				for iter_13_4, iter_13_5 in pairs(CC.PersonWs) do
					if iter_13_5[1] ~= nil and cxtd(arg_13_0, iter_13_5[1]) and var_13_40 == iter_13_5[2] then
						var_13_43 = C_WHITE
					end
				end

				DrawString(var_13_12 - var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%s", JY.Wugong[var_13_40].名称), var_13_42, var_13_0)

				if var_13_1["武功等级" .. iter_13_1] > 900 then
					lib.SetClip(var_13_12 - var_13_0, var_13_13 + var_13_4 * 1, var_13_12 + var_13_0 - string.len(JY.Wugong[var_13_40].名称) * var_13_0 * (var_13_1["武功等级" .. iter_13_1] - 900) / 200, var_13_13 + var_13_4 * var_13_22 + var_13_4)
					DrawString(var_13_12 - var_13_0, var_13_13 + var_13_4 * var_13_22, string.format("%s", JY.Wugong[var_13_40].名称), var_13_43, var_13_0)
					lib.SetClip(0, 0, 0, 0)
				end

				DrawString(var_13_12 + var_13_0 * 5, var_13_13 + var_13_4 * var_13_22, var_13_39[var_13_41], var_13_42, var_13_0)
				DrawString(var_13_12 + var_13_0 * 8, var_13_13 + var_13_4 * var_13_22, var_13_38(arg_13_0, var_13_40, var_13_41), var_13_42, var_13_0)

				if var_13_1["武功等级" .. iter_13_1] == 999 then
					DrawString(var_13_12 + var_13_0 * 5, var_13_13 + var_13_4 * var_13_22, var_13_39[var_13_41], var_13_43, var_13_0)
					DrawString(var_13_12 + var_13_0 * 8, var_13_13 + var_13_4 * var_13_22, var_13_38(arg_13_0, var_13_40, var_13_41), var_13_43, var_13_0)
				end
			end
		end

		var_13_22 = 11

		DrawString(var_13_12 + var_13_0, var_13_13 + var_13_4 * var_13_22, "怒气值:", C_ORANGE, var_13_0)

		if JY.Status == GAME_WMAP and WAR.LQZ[arg_13_0] ~= nil then
			DrawString(var_13_12 + var_13_0 * 5 + 20, var_13_13 + var_13_4 * var_13_22, WAR.LQZ[arg_13_0], C_GOLD, var_13_0)
		else
			DrawString(var_13_12 + var_13_0 * 5 + 20, var_13_13 + var_13_4 * var_13_22, 0, C_GOLD, var_13_0)
		end

		var_13_22 = 12

		DrawString(var_13_12 + var_13_0, var_13_13 + var_13_4 * var_13_22, "攻击带毒:", C_ORANGE, var_13_0)
		DrawString(var_13_12 + var_13_0 * 5 + 20, var_13_13 + var_13_4 * var_13_22, var_13_1.攻击带毒, C_GOLD, var_13_0)
	end
end

function YbPerson(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0[arg_16_1][4]

	if WAR.YbPerson[var_16_0] == 0 then
		WAR.YbPerson[var_16_0] = 2
	elseif WAR.YbPerson[var_16_0] == 2 then
		WAR.YbPerson[var_16_0] = 0
	end

	if WAR.YbPerson[var_16_0] > 0 then
		arg_16_0[arg_16_1][1] = "#" .. string.sub(arg_16_0[arg_16_1][1], 2)
	else
		arg_16_0[arg_16_1][1] = " " .. string.sub(arg_16_0[arg_16_1][1], 2)
	end

	return 0
end

function Yb_GetYbNum()
	local var_17_0 = CC.YbNum

	for iter_17_0 = 1, CC.YbNum do
		if JY.Base["佣兵" .. iter_17_0] < 0 then
			var_17_0 = iter_17_0 - 1

			break
		end
	end

	return var_17_0
end

function ybdw(arg_18_0)
	local var_18_0 = false

	for iter_18_0 = 1, CC.YbNum do
		if arg_18_0 == JY.Base["佣兵" .. iter_18_0] then
			var_18_0 = true

			break
		end
	end

	return var_18_0
end

function ybjr(arg_19_0)
	if JY.Person[arg_19_0] == nil then
		lib.Debug("instruct_10 error: person id not exist")

		return
	end

	local var_19_0 = 0

	for iter_19_0 = 1, CC.YbNum do
		if JY.Base["佣兵" .. iter_19_0] < 0 then
			JY.Base["佣兵" .. iter_19_0] = arg_19_0
			var_19_0 = 1

			break
		end
	end

	if var_19_0 == 0 then
		lib.Debug("instruct_10 error: 加入队伍已满")

		return
	end

	for iter_19_1 = 1, 4 do
		local var_19_1 = JY.Person[arg_19_0]["携带物品" .. iter_19_1]
		local var_19_2 = JY.Person[arg_19_0]["携带物品数量" .. iter_19_1]

		if var_19_2 < 0 then
			var_19_2 = 0
		end

		if var_19_1 >= 0 and var_19_2 > 0 then
			instruct_2(var_19_1, var_19_2)

			JY.Person[arg_19_0]["携带物品" .. iter_19_1] = -1
			JY.Person[arg_19_0]["携带物品数量" .. iter_19_1] = 0
		end
	end
end

function sjyb()
	local var_20_0 = {
		"仲孙",
		"赫连",
		"夏侯",
		"尉迟",
		"上官",
		"司马",
		"轩辕",
		"淳于",
		"申屠",
		"皇甫",
		"东方",
		"西门",
		"南宫",
		"北城",
		"独孤",
		"林",
		"魏",
		"张",
		"王",
		"李",
		"赵",
		"郭",
		"宋",
		"李",
		"曹",
		"徐",
		"杨",
		"萧",
		"钟",
		"胡",
		"陈",
		"沈",
		"白"
	}
	local var_20_1 = {
		"谦",
		"维",
		"毅",
		"晨",
		"永",
		"昌",
		"豪",
		"哲",
		"德",
		"伟",
		"言",
		"建",
		"翔",
		"浩",
		"斌",
		"东",
		"腾",
		"龙",
		"坚",
		"刚",
		"雄",
		"雷",
		"震",
		"岩",
		"霸",
		"彪",
		"风",
		"松",
		"山",
		"鸿",
		"白",
		"浪",
		"锋",
		"深",
		"河",
		"慕"
	}
	local var_20_2 = {
		"琬",
		"萱",
		"清",
		"蕊",
		"姗",
		"冰",
		"菁",
		"佳",
		"蝶",
		"莲",
		"梅",
		"姬",
		"紫",
		"丹",
		"涵",
		"婷",
		"静",
		"蕾",
		"慧",
		"菡",
		"娴",
		"凝",
		"柔",
		"惜",
		"雯",
		"玉",
		"丹",
		"倩",
		"茜",
		"凤",
		"玲",
		"灵儿",
		"红",
		"霞"
	}
	local var_20_3 = {
		10,
		11,
		12,
		14,
		18,
		22,
		23,
		26,
		42,
		43,
		52,
		70,
		84,
		94,
		95,
		96,
		100,
		115,
		131,
		139,
		151,
		152,
		177,
		178,
		179,
		180,
		229,
		232,
		234,
		266
	}
	local var_20_4 = {
		47,
		56,
		66,
		73,
		77,
		79,
		81,
		83,
		87,
		90,
		99,
		104,
		105,
		117,
		118,
		128,
		136,
		154,
		175,
		237,
		238,
		239,
		240,
		261
	}
	local var_20_5 = {
		3,
		6,
		7,
		8,
		10,
		11,
		12,
		13,
		14,
		15,
		18,
		19,
		20,
		21,
		22,
		23,
		24,
		26,
		31,
		32,
		33,
		34,
		39,
		40,
		41,
		42,
		43,
		46,
		57,
		60,
		61,
		62,
		64,
		65,
		67,
		68,
		69,
		70,
		98,
		99,
		100,
		102,
		103,
		106,
		107,
		108,
		109,
		118,
		123,
		129,
		130,
		131,
		132,
		133,
		134,
		135,
		136,
		138,
		139,
		141,
		142,
		143,
		149,
		150,
		151,
		152,
		153,
		154,
		155,
		156,
		157,
		158,
		159,
		160,
		161,
		162,
		163,
		164,
		165,
		166,
		167,
		169,
		170,
		171,
		172,
		173,
		176,
		184,
		185,
		186,
		187,
		188,
		189,
		593,
		598,
		599
	}
	local var_20_6 = {
		3,
		6,
		7,
		8,
		10,
		11,
		12,
		13,
		14,
		15,
		18,
		19,
		20,
		21,
		22,
		23,
		24,
		26,
		27,
		31,
		32,
		33,
		34,
		39,
		40,
		41,
		42,
		43,
		46,
		57,
		60,
		61,
		62,
		64,
		65,
		67,
		68,
		69,
		70,
		98,
		99,
		100,
		102,
		103,
		106,
		107,
		108,
		109,
		113,
		117,
		118,
		123,
		129,
		130,
		131,
		132,
		133,
		134,
		135,
		136,
		138,
		139,
		140,
		141,
		142,
		143,
		149,
		150,
		151,
		152,
		153,
		154,
		155,
		156,
		157,
		158,
		159,
		160,
		161,
		162,
		163,
		164,
		165,
		166,
		167,
		169,
		170,
		171,
		172,
		173,
		176,
		184,
		185,
		186,
		187,
		188,
		189,
		593,
		598,
		599
	}
	local var_20_7 = 999

	JY.Person[var_20_7] = {}

	for iter_20_0 = 1, #PSX - 8 do
		JY.Person[var_20_7][PSX[iter_20_0]] = JY.Person[597][PSX[iter_20_0]]
	end

	local var_20_8 = 0
	local var_20_9 = var_20_3

	JY.Person[var_20_7].性别 = 0

	local var_20_10 = math.random(#var_20_3)

	if math.random(2) == 1 then
		var_20_8 = 1
	end

	if var_20_8 == 1 then
		var_20_9 = var_20_4
		JY.Person[var_20_7].性别 = 1
		var_20_10 = math.random(#var_20_4)
	end

	JY.Person[var_20_7].头像代号 = JY.Person[var_20_9[var_20_10]].头像代号

	for iter_20_1 = 1, 5 do
		JY.Person[var_20_7]["出招动画帧数" .. iter_20_1] = JY.Person[var_20_9[var_20_10]]["出招动画帧数" .. iter_20_1]
		JY.Person[var_20_7]["出招动画延迟" .. iter_20_1] = JY.Person[var_20_9[var_20_10]]["出招动画延迟" .. iter_20_1]
		JY.Person[var_20_7]["出招动画延迟" .. iter_20_1] = JY.Person[var_20_9[var_20_10]]["出招动画延迟" .. iter_20_1]
	end

	JY.Person[var_20_7].资质 = 1 + math.random(98)
	JY.Person[var_20_7].等级 = 30
	JY.Person[var_20_7].经验 = CC.Exp[JY.Person[var_20_7].等级 - 1]
	JY.Person[var_20_7].生命增长 = math.random(4) + 3
	JY.Person[var_20_7].生命最大值 = (JY.Person[var_20_7].生命增长 + Rnd(2) + 2) * JY.Person[var_20_7].等级 * 4
	JY.Person[var_20_7].生命 = JY.Person[var_20_7].生命最大值
	JY.Person[var_20_7].内力最大值 = math.modf(JY.Person[var_20_7].等级 * ((16 - JY.Person[var_20_7].生命增长) * 7 + 210 / (JY.Person[var_20_7].资质 / 5 + 1)))
	JY.Person[var_20_7].内力 = JY.Person[var_20_7].内力最大值
	JY.Person[var_20_7].攻击力 = 20 + math.random(20) - math.random(8)
	JY.Person[var_20_7].防御力 = 20 + math.random(20) - math.random(8)
	JY.Person[var_20_7].轻功 = 20 + math.random(20) - math.random(7)
	JY.Person[var_20_7].内力性质 = Rnd(2)
	JY.Person[var_20_7].医疗能力 = math.random(5)
	JY.Person[var_20_7].用毒能力 = math.random(50)
	JY.Person[var_20_7].解毒能力 = math.random(50)
	JY.Person[var_20_7].暗器技巧 = math.random(100)
	JY.Person[var_20_7].拳掌功夫 = 45
	JY.Person[var_20_7].御剑能力 = 45
	JY.Person[var_20_7].耍刀技巧 = 45
	JY.Person[var_20_7].特殊兵器 = 45

	for iter_20_2 = 0, JY.Person[var_20_7].等级 - 1 do
		AddPersonAttrib(var_20_7, "攻击力", math.modf((JY.Person[var_20_7].资质 - 1) / 30) + JY.Base.游戏难度 + 1)
		AddPersonAttrib(var_20_7, "防御力", math.modf((JY.Person[var_20_7].资质 - 1) / 30) + JY.Base.游戏难度 + 1)
		AddPersonAttrib(var_20_7, "轻功", math.modf((JY.Person[var_20_7].资质 - 1) / 30) + JY.Base.游戏难度 + 1)
		AddPersonAttrib(var_20_7, "拳掌功夫", Rnd(3))
		AddPersonAttrib(var_20_7, "御剑能力", Rnd(3))
		AddPersonAttrib(var_20_7, "耍刀技巧", Rnd(3))
		AddPersonAttrib(var_20_7, "特殊兵器", Rnd(3))
	end

	AddPersonAttrib(var_20_7, "攻击力", -math.modf(JY.Person[var_20_7].攻击力 / 4))
	AddPersonAttrib(var_20_7, "防御力", -math.modf(JY.Person[var_20_7].攻击力 / 4))
	AddPersonAttrib(var_20_7, "轻功", -math.modf(JY.Person[var_20_7].轻功 / 4))

	local var_20_11 = 0

	if math.random(3) == 1 then
		JY.Person[var_20_7].天赋 = TeamP[math.random(#TeamP)]
		var_20_11 = JY.Person[var_20_7].天赋
	end

	if var_20_11 == 0 and math.random(1) == 1 then
		if CC.CircleNum > 2 then
			JY.Person[var_20_7].天赋 = var_20_6[math.random(#var_20_6)]
			var_20_11 = JY.Person[var_20_7].天赋
		else
			JY.Person[var_20_7].天赋 = var_20_5[math.random(#var_20_5)]
			var_20_11 = JY.Person[var_20_7].天赋
		end
	end

	if JY.Person[var_20_7].资质 < 50 and math.random(1) == 1 then
		JY.Person[var_20_7].左右互搏 = 1
	else
		JY.Person[var_20_7].左右互搏 = 0
	end

	for iter_20_3 = 1, 4 do
		JY.Person[var_20_7]["携带物品" .. iter_20_3] = -1
		JY.Person[var_20_7]["携带物品数量" .. iter_20_3] = 0
	end

	for iter_20_4 = 1, 20 do
		JY.Person[var_20_7]["武功" .. iter_20_4] = 0
		JY.Person[var_20_7]["武功等级" .. iter_20_4] = 0
	end

	if var_20_11 > 0 and math.random(3) == 1 then
		for iter_20_5, iter_20_6 in pairs(CC.PersonWs) do
			if iter_20_6[1] ~= nil and var_20_11 == iter_20_6[1] then
				JY.Person[var_20_7].武功1 = iter_20_6[2]
			else
				JY.Person[var_20_7].武功1 = JY.Person[var_20_11].武功1
			end
		end
	end

	if var_20_11 == 16 or var_20_11 == 28 or var_20_11 == 45 or var_20_11 == 85 then
		JY.Person[var_20_7].医疗能力 = 200
	end

	local var_20_12 = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19,
		20,
		21,
		22,
		28,
		29,
		30,
		31,
		32,
		33,
		34,
		35,
		36,
		37,
		38,
		39,
		40,
		41,
		42,
		44,
		50,
		51,
		52,
		53,
		54,
		55,
		56,
		57,
		58,
		59,
		60,
		61,
		62,
		63,
		68,
		69,
		70,
		71,
		72,
		73,
		74,
		75,
		76,
		77,
		78,
		79,
		81,
		84,
		114
	}
	local var_20_13 = {
		85,
		87,
		88,
		89,
		90,
		93,
		95,
		99,
		43,
		94,
		96,
		97,
		98,
		100,
		101,
		103,
		104
	}
	local var_20_14 = math.random(#var_20_12)
	local var_20_15 = math.random(#var_20_13)
	local var_20_16 = math.random(1)

	if var_20_16 == 5 then
		if JY.Person[var_20_7].武功1 == 0 then
			JY.Person[var_20_7].武功1 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级1 = 999
		end

		while true do
			local var_20_17 = true

			for iter_20_7 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_7] == var_20_12[var_20_14] then
					var_20_17 = false

					break
				end
			end

			if var_20_17 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功2 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级2 = math.random(999)

		while true do
			local var_20_18 = true

			for iter_20_8 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_8] == var_20_12[var_20_14] then
					var_20_18 = false

					break
				end
			end

			if var_20_18 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功3 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级3 = math.random(999)

		while true do
			local var_20_19 = true

			for iter_20_9 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_9] == var_20_12[var_20_14] then
					var_20_19 = false

					break
				end
			end

			if var_20_19 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功4 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级4 = math.random(999)
		JY.Person[var_20_7].武功5 = var_20_13[var_20_15]
		JY.Person[var_20_7].武功等级5 = math.random(999)
	elseif var_20_16 == 4 then
		if JY.Person[var_20_7].武功1 == 0 then
			JY.Person[var_20_7].武功1 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级1 = math.random(999)
		end

		while true do
			local var_20_20 = true

			for iter_20_10 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_10] == var_20_12[var_20_14] then
					var_20_20 = false

					break
				end
			end

			if var_20_20 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功2 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级2 = math.random(999)

		while true do
			local var_20_21 = true

			for iter_20_11 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_11] == var_20_12[var_20_14] then
					var_20_21 = false

					break
				end
			end

			if var_20_21 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功3 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级3 = math.random(999)

		if math.random(5) == 1 then
			JY.Person[var_20_7].武功4 = var_20_13[var_20_15]
			JY.Person[var_20_7].武功等级4 = math.random(999)
		else
			while true do
				local var_20_22 = true

				for iter_20_12 = 1, 8 do
					if JY.Person[var_20_7]["武功" .. iter_20_12] == var_20_12[var_20_14] then
						var_20_22 = false

						break
					end
				end

				if var_20_22 then
					break
				else
					var_20_14 = math.random(#var_20_12)
				end
			end

			JY.Person[var_20_7].武功4 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级4 = math.random(999)
		end
	elseif var_20_16 == 3 then
		if JY.Person[var_20_7].武功1 == 0 then
			JY.Person[var_20_7].武功1 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级1 = math.random(999)
		end

		while true do
			local var_20_23 = true

			for iter_20_13 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_13] == var_20_12[var_20_14] then
					var_20_23 = false

					break
				end
			end

			if var_20_23 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		JY.Person[var_20_7].武功2 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级2 = math.random(999)

		while true do
			local var_20_24 = true

			for iter_20_14 = 1, 8 do
				if JY.Person[var_20_7]["武功" .. iter_20_14] == var_20_12[var_20_14] then
					var_20_24 = false

					break
				end
			end

			if var_20_24 then
				break
			else
				var_20_14 = math.random(#var_20_12)
			end
		end

		if math.random(10) == 1 then
			JY.Person[var_20_7].武功3 = var_20_13[var_20_15]
			JY.Person[var_20_7].武功等级3 = math.random(999)
		else
			while true do
				local var_20_25 = true

				for iter_20_15 = 1, 8 do
					if JY.Person[var_20_7]["武功" .. iter_20_15] == var_20_12[var_20_14] then
						var_20_25 = false

						break
					end
				end

				if var_20_25 then
					break
				else
					var_20_14 = math.random(#var_20_12)
				end
			end

			JY.Person[var_20_7].武功3 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级3 = math.random(999)
		end
	elseif var_20_16 == 2 then
		if JY.Person[var_20_7].武功1 == 0 then
			JY.Person[var_20_7].武功1 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级1 = math.random(999)
		end

		if math.random(20) == 1 then
			JY.Person[var_20_7].武功2 = var_20_13[var_20_15]
			JY.Person[var_20_7].武功等级2 = math.random(999)
		else
			while true do
				local var_20_26 = true

				for iter_20_16 = 1, 8 do
					if JY.Person[var_20_7]["武功" .. iter_20_16] == var_20_12[var_20_14] then
						var_20_26 = false

						break
					end
				end

				if var_20_26 then
					break
				else
					var_20_14 = math.random(#var_20_12)
				end
			end

			JY.Person[var_20_7].武功2 = var_20_12[var_20_14]
			JY.Person[var_20_7].武功等级2 = math.random(999)
		end
	elseif math.random(1) == 1 then
		JY.Person[var_20_7].武功1 = var_20_13[var_20_15]
		JY.Person[var_20_7].武功等级1 = 999
		JY.Person[var_20_7].主功体 = var_20_13[var_20_15]
	elseif JY.Person[var_20_7].武功1 == 0 then
		JY.Person[var_20_7].武功1 = var_20_12[var_20_14]
		JY.Person[var_20_7].武功等级1 = 999
	end

	if ybdw(594) and ybdw(595) and ybdw(596) then
		QZXS("佣兵队伍已满，无法加入")
	elseif ybdw(594) == false then
		for iter_20_17 = 1, #PSX - 8 do
			JY.Person[594][PSX[iter_20_17]] = JY.Person[var_20_7][PSX[iter_20_17]]
		end

		JY.Person[594].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)]

		if math.random(2) == 1 then
			JY.Person[594].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)] .. var_20_1[math.random(#var_20_1)]
		end

		if var_20_8 == 1 then
			JY.Person[594].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)]

			if math.random(2) == 1 then
				JY.Person[594].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)] .. var_20_2[math.random(#var_20_2)]
			end
		end

		ybjr(594)
		QZXS("招募成功，佣兵【" .. JY.Person[594].姓名 .. "】加入")
	elseif ybdw(595) == false then
		for iter_20_18 = 1, #PSX - 8 do
			JY.Person[595][PSX[iter_20_18]] = JY.Person[var_20_7][PSX[iter_20_18]]
		end

		JY.Person[595].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)]

		if math.random(2) == 1 then
			JY.Person[595].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)] .. var_20_1[math.random(#var_20_1)]
		end

		if var_20_8 == 1 then
			JY.Person[595].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)]

			if math.random(2) == 1 then
				JY.Person[595].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)] .. var_20_2[math.random(#var_20_2)]
			end
		end

		ybjr(595)
		QZXS("招募成功，佣兵【" .. JY.Person[595].姓名 .. "】加入")
	elseif ybdw(596) == false then
		for iter_20_19 = 1, #PSX - 8 do
			JY.Person[596][PSX[iter_20_19]] = JY.Person[var_20_7][PSX[iter_20_19]]
		end

		JY.Person[596].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)]

		if math.random(2) == 1 then
			JY.Person[596].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_1[math.random(#var_20_1)] .. var_20_1[math.random(#var_20_1)]
		end

		if var_20_8 == 1 then
			JY.Person[596].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)]

			if math.random(2) == 1 then
				JY.Person[596].姓名 = var_20_0[math.random(#var_20_0)] .. var_20_2[math.random(#var_20_2)] .. var_20_2[math.random(#var_20_2)]
			end
		end

		ybjr(596)
		QZXS("招募成功，佣兵【" .. JY.Person[596].姓名 .. "】加入")
	end
end
