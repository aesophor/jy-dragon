function Set_Eff_Text(arg_1_0, arg_1_1, arg_1_2)
	if WAR.Person[arg_1_0][arg_1_1] ~= nil then
		WAR.Person[arg_1_0][arg_1_1] = WAR.Person[arg_1_0][arg_1_1] .. "+" .. arg_1_2
	else
		WAR.Person[arg_1_0][arg_1_1] = arg_1_2
	end
end

function War_realjl(arg_2_0, arg_2_1)
	if arg_2_0 == nil then
		arg_2_0 = WAR.CurID
	end

	CleanWarMap(3, 255)

	local var_2_0 = WAR.Person[arg_2_0].坐标X
	local var_2_1 = WAR.Person[arg_2_0].坐标Y
	local var_2_2 = {
		[0] = {}
	}

	var_2_2[0].bushu = {}
	var_2_2[0].x = {}
	var_2_2[0].y = {}

	SetWarMap(var_2_0, var_2_1, 3, 0)

	var_2_2[0].num = 1
	var_2_2[0].bushu[1] = 0
	var_2_2[0].x[1] = var_2_0
	var_2_2[0].y[1] = var_2_1

	return War_FindNextStep1(var_2_2, 0, arg_2_0, arg_2_1)
end

function unnamed(arg_3_0)
	local var_3_0 = WAR.Person[WAR.CurID].人物编号
	local var_3_1 = JY.Person[var_3_0]["武功" .. arg_3_0]
	local var_3_2 = JY.Person[var_3_0]["武功等级" .. arg_3_0]

	var_3_2 = var_3_2 == 999 and 11 or math.modf(var_3_2 / 100) + 1

	local var_3_3, var_3_4, var_3_5, var_3_6, var_3_7, var_3_8, var_3_9 = refw(var_3_1, var_3_2)
	local var_3_10 = {
		var_3_3,
		var_3_4
	}
	local var_3_11 = {
		var_3_5,
		var_3_6,
		var_3_7,
		var_3_8,
		var_3_9
	}

	if var_3_2 == 11 then
		var_3_2 = 10
	end

	local var_3_12 = JY.Wugong[var_3_1]["攻击力" .. var_3_2]
	local var_3_13 = {}
	local var_3_14 = 0

	CleanWarMap(4, -1)

	local var_3_15 = War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)

	WarDrawMap(1)
	ShowScreen()

	for iter_3_0 = 0, WAR.Person[WAR.CurID].移动步数 do
		local var_3_16 = var_3_15[iter_3_0].num

		if var_3_16 ~= nil then
			for iter_3_1 = 1, var_3_16 do
				local var_3_17 = var_3_15[iter_3_0].x[iter_3_1]
				local var_3_18 = var_3_15[iter_3_0].y[iter_3_1]

				var_3_14 = var_3_14 + 1
				var_3_13[var_3_14] = {}
				var_3_13[var_3_14].x, var_3_13[var_3_14].y = var_3_17, var_3_18
				var_3_13[var_3_14].p, var_3_13[var_3_14].ax, var_3_13[var_3_14].ay = GetAtkNum(var_3_17, var_3_18, var_3_10, var_3_11, var_3_12)
			end
		end
	end

	for iter_3_2 = 1, var_3_14 - 1 do
		for iter_3_3 = iter_3_2 + 1, var_3_14 do
			if var_3_13[iter_3_2].p < var_3_13[iter_3_3].p then
				var_3_13[iter_3_2], var_3_13[iter_3_3] = var_3_13[iter_3_3], var_3_13[iter_3_2]
			end
		end
	end

	if var_3_13[1].p > 0 then
		for iter_3_4 = 2, var_3_14 do
			if var_3_13[iter_3_4].p == 0 or var_3_13[iter_3_4].p < var_3_13[1].p / 2 then
				var_3_14 = iter_3_4 - 1

				break
			end
		end

		for iter_3_5 = 1, var_3_14 do
			var_3_13[iter_3_5].p = var_3_13[iter_3_5].p + GetMovePoint(var_3_13[iter_3_5].x, var_3_13[iter_3_5].y)
		end

		for iter_3_6 = 1, var_3_14 - 1 do
			for iter_3_7 = iter_3_6 + 1, var_3_14 do
				if var_3_13[iter_3_6].p < var_3_13[iter_3_7].p then
					var_3_13[iter_3_6], var_3_13[iter_3_7] = var_3_13[iter_3_7], var_3_13[iter_3_6]
				elseif var_3_13[iter_3_6].p == var_3_13[iter_3_7].p and math.random(2) > 1 then
					var_3_13[iter_3_6], var_3_13[iter_3_7] = var_3_13[iter_3_7], var_3_13[iter_3_6]
				end
			end
		end

		for iter_3_8 = 2, var_3_14 do
			if var_3_13[iter_3_8].p < var_3_13[1].p * 4 / 5 then
				local var_3_19 = iter_3_8 - 1

				break
			end
		end

		local var_3_20 = 1

		War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)
		War_MovePerson(var_3_13[var_3_20].x, var_3_13[var_3_20].y)
		War_Fight_Sub(WAR.CurID, arg_3_0, var_3_13[var_3_20].ax, var_3_13[var_3_20].ay)
	else
		local var_3_21, var_3_22, var_3_23 = War_realjl()

		if var_3_22 ~= nil then
			lib.Debug(string.format("pid=%d, jl=%d, nx=%d, ny=%d, cx=%d, cy=%d", var_3_0, var_3_21, var_3_22, var_3_23, WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y))
		end

		if var_3_21 == -1 then
			AutoMove()
		else
			local var_3_24 = {}
			local var_3_25 = 0
			local var_3_26 = War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)

			for iter_3_9 = 1, WAR.Person[WAR.CurID].移动步数 do
				local var_3_27 = var_3_26[iter_3_9].num

				if var_3_27 ~= nil then
					if var_3_27 == 0 then
						break
					end

					for iter_3_10 = 1, var_3_27 do
						local var_3_28 = var_3_26[iter_3_9].x[iter_3_10]
						local var_3_29 = var_3_26[iter_3_9].y[iter_3_10]

						if GetWarMap(var_3_28, var_3_29, 3) < 255 then
							var_3_25 = var_3_25 + 1
							var_3_24[var_3_25] = {}
							var_3_24[var_3_25].x = var_3_28
							var_3_24[var_3_25].y = var_3_29
							var_3_24[var_3_25].p = var_3_21 - math.abs(var_3_22 - var_3_28) - math.abs(var_3_23 - var_3_29)
						end
					end
				end
			end

			for iter_3_11 = 1, var_3_25 - 1 do
				for iter_3_12 = iter_3_11 + 1, var_3_25 do
					if var_3_24[iter_3_11].p < var_3_24[iter_3_12].p then
						var_3_24[iter_3_11], var_3_24[iter_3_12] = var_3_24[iter_3_12], var_3_24[iter_3_11]
					end
				end
			end

			for iter_3_13 = 2, var_3_25 do
				if var_3_24[iter_3_13].p < var_3_24[1].p / 2 then
					var_3_25 = iter_3_13 - 1

					break
				end
			end

			for iter_3_14 = 1, var_3_25 do
				var_3_24[iter_3_14].p = var_3_24[iter_3_14].p + GetMovePoint(var_3_24[iter_3_14].x, var_3_24[iter_3_14].y)
			end

			for iter_3_15 = 1, var_3_25 - 1 do
				for iter_3_16 = iter_3_15 + 1, var_3_25 do
					if var_3_24[iter_3_15].p < var_3_24[iter_3_16].p then
						var_3_24[iter_3_15], var_3_24[iter_3_16] = var_3_24[iter_3_16], var_3_24[iter_3_15]
					end
				end
			end

			if var_3_25 > 0 then
				War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)
				War_MovePerson(var_3_24[1].x, var_3_24[1].y)
			else
				AutoMove()
			end
		end

		War_RestMenu()
	end
end

function AutoMove()
	local var_4_0
	local var_4_1
	local var_4_2 = math.huge
	local var_4_3 = War_AutoSelectEnemy()

	War_CalMoveStep(WAR.CurID, 100, 0)

	for iter_4_0 = 0, CC.WarWidth - 1 do
		for iter_4_1 = 0, CC.WarHeight - 1 do
			if GetWarMap(iter_4_0, iter_4_1, 3) < 128 then
				local var_4_4 = math.abs(iter_4_0 - WAR.Person[var_4_3].坐标X)
				local var_4_5 = math.abs(iter_4_1 - WAR.Person[var_4_3].坐标Y)

				if var_4_2 > var_4_4 + var_4_5 then
					var_4_2 = var_4_4 + var_4_5
					var_4_0 = iter_4_0
					var_4_1 = iter_4_1
				elseif var_4_2 == var_4_4 + var_4_5 and Rnd(2) == 0 then
					var_4_0 = iter_4_0
					var_4_1 = iter_4_1
				end
			end
		end
	end

	if var_4_2 < math.huge then
		while true do
			local var_4_6 = GetWarMap(var_4_0, var_4_1, 3)

			if var_4_6 <= WAR.Person[WAR.CurID].移动步数 then
				break
			end

			if GetWarMap(var_4_0 - 1, var_4_1, 3) == var_4_6 - 1 then
				var_4_0 = var_4_0 - 1
			elseif GetWarMap(var_4_0 + 1, var_4_1, 3) == var_4_6 - 1 then
				var_4_0 = var_4_0 + 1
			elseif GetWarMap(var_4_0, var_4_1 - 1, 3) == var_4_6 - 1 then
				var_4_1 = var_4_1 - 1
			elseif GetWarMap(var_4_0, var_4_1 + 1, 3) == var_4_6 - 1 then
				var_4_1 = var_4_1 + 1
			end
		end

		War_MovePerson(var_4_0, var_4_1)
	end
end

function GetMovePoint(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0
	local var_5_1 = WAR.Person[WAR.CurID].我方
	local var_5_2 = MY_CalMoveStep(arg_5_0, arg_5_1, 9, 1)

	for iter_5_0 = 1, 9 do
		local var_5_3 = var_5_2[iter_5_0].num

		if var_5_3 ~= nil then
			if var_5_3 == 0 then
				break
			end

			for iter_5_1 = 1, var_5_3 do
				local var_5_4 = var_5_2[iter_5_0].x[iter_5_1]
				local var_5_5 = var_5_2[iter_5_0].y[iter_5_1]
				local var_5_6 = GetWarMap(var_5_4, var_5_5, 2)

				if var_5_6 ~= -1 then
					if var_5_6 == WAR.CurID then
						break
					elseif WAR.Person[var_5_6].我方 == var_5_1 then
						var_5_0 = var_5_0 + iter_5_0 * 2 - 19
					elseif WAR.Person[var_5_6].我方 ~= var_5_1 then
						if arg_5_2 ~= nil then
							var_5_0 = var_5_0 + iter_5_0 - 10
						else
							var_5_0 = var_5_0 + 19 - iter_5_0
						end
					end
				end
			end
		end
	end

	return var_5_0
end

function MY_CalMoveStep(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	CleanWarMap(3, 255)

	local var_6_0 = {}

	for iter_6_0 = 0, arg_6_2 do
		var_6_0[iter_6_0] = {}
		var_6_0[iter_6_0].bushu = {}
		var_6_0[iter_6_0].x = {}
		var_6_0[iter_6_0].y = {}
	end

	SetWarMap(arg_6_0, arg_6_1, 3, 0)

	var_6_0[0].num = 1
	var_6_0[0].bushu[1] = arg_6_2
	var_6_0[0].x[1] = arg_6_0
	var_6_0[0].y[1] = arg_6_1

	War_FindNextStep(var_6_0, 0, arg_6_3)

	return var_6_0
end

function GetAtkNum(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = arg_7_2[1]
	local var_7_3 = arg_7_2[2]

	if var_7_2 == 0 then
		local var_7_4 = MY_CalMoveStep(arg_7_0, arg_7_1, var_7_3, 1)

		for iter_7_0 = 0, var_7_3 do
			local var_7_5 = var_7_4[iter_7_0].num

			if var_7_5 ~= nil then
				if var_7_5 == 0 then
					break
				end

				for iter_7_1 = 1, var_7_5 do
					var_7_1 = var_7_1 + 1
					var_7_0[var_7_1] = {
						var_7_4[iter_7_0].x[iter_7_1],
						var_7_4[iter_7_0].y[iter_7_1]
					}
				end
			end
		end
	elseif var_7_2 == 1 then
		local var_7_6 = MY_CalMoveStep(arg_7_0, arg_7_1, var_7_3 * 2, 1)

		for iter_7_2 = 1, var_7_3 * 2 do
			for iter_7_3 = 0, iter_7_2 do
				local var_7_7 = iter_7_2 - iter_7_3

				if var_7_3 < iter_7_3 or var_7_3 < var_7_7 then
					SetWarMap(arg_7_0 + iter_7_3, arg_7_1 + var_7_7, 3, 255)
					SetWarMap(arg_7_0 + iter_7_3, arg_7_1 - var_7_7, 3, 255)
					SetWarMap(arg_7_0 - iter_7_3, arg_7_1 + var_7_7, 3, 255)
					SetWarMap(arg_7_0 - iter_7_3, arg_7_1 - var_7_7, 3, 255)
				end
			end
		end

		for iter_7_4 = 0, var_7_3 do
			local var_7_8 = var_7_6[iter_7_4].num

			if var_7_8 ~= nil then
				if var_7_8 == 0 then
					break
				end

				for iter_7_5 = 1, var_7_8 do
					if GetWarMap(var_7_6[iter_7_4].x[iter_7_5], var_7_6[iter_7_4].y[iter_7_5], 3) < 128 then
						var_7_1 = var_7_1 + 1
						var_7_0[var_7_1] = {
							var_7_6[iter_7_4].x[iter_7_5],
							var_7_6[iter_7_4].y[iter_7_5]
						}
					end
				end
			end
		end
	elseif var_7_2 == 2 then
		var_7_3 = var_7_3 or 1

		for iter_7_6 = 1, var_7_3 do
			if arg_7_0 + iter_7_6 < CC.WarWidth - 1 and GetWarMap(arg_7_0 + iter_7_6, arg_7_1, 1) > 0 and CC.WarWater[GetWarMap(arg_7_0 + iter_7_6, arg_7_1, 0)] == nil then
				break
			end

			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 + iter_7_6,
				arg_7_1
			}
		end

		for iter_7_7 = 1, var_7_3 do
			if arg_7_0 - iter_7_7 > 0 and GetWarMap(arg_7_0 - iter_7_7, arg_7_1, 1) > 0 and CC.WarWater[GetWarMap(arg_7_0 - iter_7_7, arg_7_1, 0)] == nil then
				break
			end

			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 - iter_7_7,
				arg_7_1
			}
		end

		for iter_7_8 = 1, var_7_3 do
			if arg_7_1 + iter_7_8 < CC.WarHeight - 1 and GetWarMap(arg_7_0, arg_7_1 + iter_7_8, 1) > 0 and CC.WarWater[GetWarMap(arg_7_0, arg_7_1 + iter_7_8, 0)] == nil then
				break
			end

			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0,
				arg_7_1 + iter_7_8
			}
		end

		for iter_7_9 = 1, var_7_3 do
			if arg_7_1 - iter_7_9 > 0 and GetWarMap(arg_7_0, arg_7_1 - iter_7_9, 1) > 0 and CC.WarWater[GetWarMap(arg_7_0, arg_7_1 - iter_7_9, 0)] == nil then
				break
			end

			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0,
				arg_7_1 - iter_7_9
			}
		end
	elseif var_7_2 == 3 then
		if arg_7_0 + 1 < CC.WarWidth - 1 and GetWarMap(arg_7_0 + 1, arg_7_1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 + 1, arg_7_1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 + 1,
				arg_7_1
			}
		end

		if arg_7_0 - 1 > 0 and GetWarMap(arg_7_0 - 1, arg_7_1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 - 1, arg_7_1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 - 1,
				arg_7_1
			}
		end

		if arg_7_1 + 1 < CC.WarHeight - 1 and GetWarMap(arg_7_0, arg_7_1 + 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0, arg_7_1 + 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0,
				arg_7_1 + 1
			}
		end

		if arg_7_1 - 1 > 0 and GetWarMap(arg_7_0, arg_7_1 - 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0, arg_7_1 - 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0,
				arg_7_1 - 1
			}
		end

		if arg_7_0 + 1 < CC.WarWidth - 1 and arg_7_1 + 1 < CC.WarHeight - 1 and GetWarMap(arg_7_0 + 1, arg_7_1 + 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 + 1, arg_7_1 + 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 + 1,
				arg_7_1 + 1
			}
		end

		if arg_7_0 - 1 > 0 and arg_7_1 + 1 < CC.WarHeight - 1 and GetWarMap(arg_7_0 - 1, arg_7_1 + 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 - 1, arg_7_1 + 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 - 1,
				arg_7_1 + 1
			}
		end

		if arg_7_0 + 1 < CC.WarWidth - 1 and arg_7_1 - 1 > 0 and GetWarMap(arg_7_0 + 1, arg_7_1 - 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 + 1, arg_7_1 - 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 + 1,
				arg_7_1 - 1
			}
		end

		if arg_7_0 - 1 > 0 and arg_7_1 - 1 > 0 and GetWarMap(arg_7_0 - 1, arg_7_1 - 1, 1) == 0 and CC.WarWater[GetWarMap(arg_7_0 - 1, arg_7_1 - 1, 0)] == nil then
			var_7_1 = var_7_1 + 1
			var_7_0[var_7_1] = {
				arg_7_0 - 1,
				arg_7_1 - 1
			}
		end
	end

	local var_7_9 = 0
	local var_7_10 = 0
	local var_7_11 = 0
	local var_7_12 = 0

	for iter_7_10 = 1, var_7_1 do
		local var_7_13 = GetWarMap(var_7_0[iter_7_10][1], var_7_0[iter_7_10][2], 4)

		if var_7_13 == -1 or arg_7_3[1] > 9 then
			var_7_13 = WarDrawAtt(var_7_0[iter_7_10][1], var_7_0[iter_7_10][2], arg_7_3, 2, arg_7_0, arg_7_1, arg_7_4)

			SetWarMap(var_7_0[iter_7_10][1], var_7_0[iter_7_10][2], 4, var_7_13)
		end

		if var_7_13 ~= nil and var_7_11 < var_7_13 then
			var_7_11, var_7_9, var_7_10 = var_7_13, var_7_0[iter_7_10][1], var_7_0[iter_7_10][2]
		end
	end

	return var_7_11, var_7_9, var_7_10
end

function War_FindNextStep1(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = 0
	local var_8_1 = arg_8_1 + 1

	arg_8_0[var_8_1] = {}
	arg_8_0[var_8_1].bushu = {}
	arg_8_0[var_8_1].x = {}
	arg_8_0[var_8_1].y = {}

	local function var_8_2(arg_9_0, arg_9_1)
		local var_9_0 = 0
		local var_9_1 = WAR.Person[arg_8_2].我方
		local var_9_2
		local var_9_3 = GetWarMap(arg_9_0 + 1, arg_9_1, 2)

		if arg_8_3 == nil then
			if var_9_3 ~= -1 and WAR.Person[var_9_3].我方 ~= var_9_1 then
				return -1
			end
		elseif var_9_3 == arg_8_3 then
			return -1
		end

		if var_9_3 ~= -1 and WAR.Person[var_9_3].我方 ~= var_9_1 then
			var_9_0 = var_9_0 + 1
		end

		local var_9_4 = GetWarMap(arg_9_0 - 1, arg_9_1, 2)

		if arg_8_3 == nil then
			if var_9_4 ~= -1 and WAR.Person[var_9_4].我方 ~= var_9_1 then
				return -1
			end
		elseif var_9_4 == arg_8_3 then
			return -1
		end

		if var_9_4 ~= -1 and WAR.Person[var_9_4].我方 ~= var_9_1 then
			var_9_0 = var_9_0 + 1
		end

		local var_9_5 = GetWarMap(arg_9_0, arg_9_1 + 1, 2)

		if arg_8_3 == nil then
			if var_9_5 ~= -1 and WAR.Person[var_9_5].我方 ~= var_9_1 then
				return -1
			end
		elseif var_9_5 == arg_8_3 then
			return -1
		end

		if var_9_5 ~= -1 and WAR.Person[var_9_5].我方 ~= var_9_1 then
			var_9_0 = var_9_0 + 1
		end

		local var_9_6 = GetWarMap(arg_9_0, arg_9_1 - 1, 2)

		if arg_8_3 == nil then
			if var_9_6 ~= -1 and WAR.Person[var_9_6].我方 ~= var_9_1 then
				return -1
			end
		elseif var_9_6 == arg_8_3 then
			return -1
		end

		if var_9_6 ~= -1 and WAR.Person[var_9_6].我方 ~= var_9_1 then
			var_9_0 = var_9_0 + 1
		end

		return var_9_0
	end

	for iter_8_0 = 1, arg_8_0[arg_8_1].num do
		arg_8_0[arg_8_1].bushu[iter_8_0] = arg_8_0[arg_8_1].bushu[iter_8_0] + 1

		local var_8_3 = arg_8_0[arg_8_1].x[iter_8_0]
		local var_8_4 = arg_8_0[arg_8_1].y[iter_8_0]

		if var_8_3 + 1 < CC.WarWidth - 1 and GetWarMap(var_8_3 + 1, var_8_4, 3) == 255 and War_CanMoveXY(var_8_3 + 1, var_8_4, 0) == true then
			var_8_0 = var_8_0 + 1
			arg_8_0[var_8_1].x[var_8_0] = var_8_3 + 1
			arg_8_0[var_8_1].y[var_8_0] = var_8_4

			SetWarMap(var_8_3 + 1, var_8_4, 3, var_8_1)

			local var_8_5 = var_8_2(var_8_3 + 1, var_8_4)

			if var_8_5 == -1 then
				return arg_8_0[arg_8_1].bushu[iter_8_0], var_8_3 + 1, var_8_4
			else
				arg_8_0[var_8_1].bushu[var_8_0] = arg_8_0[arg_8_1].bushu[iter_8_0] + var_8_5
			end
		end

		if var_8_3 - 1 > 0 and GetWarMap(var_8_3 - 1, var_8_4, 3) == 255 and War_CanMoveXY(var_8_3 - 1, var_8_4, 0) == true then
			var_8_0 = var_8_0 + 1
			arg_8_0[var_8_1].x[var_8_0] = var_8_3 - 1
			arg_8_0[var_8_1].y[var_8_0] = var_8_4

			SetWarMap(var_8_3 - 1, var_8_4, 3, var_8_1)

			local var_8_6 = var_8_2(var_8_3 - 1, var_8_4)

			if var_8_6 == -1 then
				return arg_8_0[arg_8_1].bushu[iter_8_0], var_8_3 - 1, var_8_4
			else
				arg_8_0[var_8_1].bushu[var_8_0] = arg_8_0[arg_8_1].bushu[iter_8_0] + var_8_6
			end
		end

		if var_8_4 + 1 < CC.WarHeight - 1 and GetWarMap(var_8_3, var_8_4 + 1, 3) == 255 and War_CanMoveXY(var_8_3, var_8_4 + 1, 0) == true then
			var_8_0 = var_8_0 + 1
			arg_8_0[var_8_1].x[var_8_0] = var_8_3
			arg_8_0[var_8_1].y[var_8_0] = var_8_4 + 1

			SetWarMap(var_8_3, var_8_4 + 1, 3, var_8_1)

			local var_8_7 = var_8_2(var_8_3, var_8_4 + 1)

			if var_8_7 == -1 then
				return arg_8_0[arg_8_1].bushu[iter_8_0], var_8_3, var_8_4 + 1
			else
				arg_8_0[var_8_1].bushu[var_8_0] = arg_8_0[arg_8_1].bushu[iter_8_0] + var_8_7
			end
		end

		if var_8_4 - 1 > 0 and GetWarMap(var_8_3, var_8_4 - 1, 3) == 255 and War_CanMoveXY(var_8_3, var_8_4 - 1, 0) == true then
			var_8_0 = var_8_0 + 1
			arg_8_0[var_8_1].x[var_8_0] = var_8_3
			arg_8_0[var_8_1].y[var_8_0] = var_8_4 - 1

			SetWarMap(var_8_3, var_8_4 - 1, 3, var_8_1)

			local var_8_8 = var_8_2(var_8_3, var_8_4 - 1)

			if var_8_8 == -1 then
				return arg_8_0[arg_8_1].bushu[iter_8_0], var_8_3, var_8_4 - 1
			else
				arg_8_0[var_8_1].bushu[var_8_0] = arg_8_0[arg_8_1].bushu[iter_8_0] + var_8_8
			end
		end
	end

	if var_8_0 == 0 then
		return -1
	end

	arg_8_0[var_8_1].num = var_8_0

	for iter_8_1 = 1, var_8_0 - 1 do
		for iter_8_2 = iter_8_1 + 1, var_8_0 do
			if arg_8_0[var_8_1].bushu[iter_8_1] > arg_8_0[var_8_1].bushu[iter_8_2] then
				arg_8_0[var_8_1].bushu[iter_8_1], arg_8_0[var_8_1].bushu[iter_8_2] = arg_8_0[var_8_1].bushu[iter_8_2], arg_8_0[var_8_1].bushu[iter_8_1]
				arg_8_0[var_8_1].x[iter_8_1], arg_8_0[var_8_1].x[iter_8_2] = arg_8_0[var_8_1].x[iter_8_2], arg_8_0[var_8_1].x[iter_8_1]
				arg_8_0[var_8_1].y[iter_8_1], arg_8_0[var_8_1].y[iter_8_2] = arg_8_0[var_8_1].y[iter_8_2], arg_8_0[var_8_1].y[iter_8_1]
			end
		end
	end

	return War_FindNextStep1(arg_8_0, var_8_1, arg_8_2, arg_8_3)
end

function War_PersonTrainDrug(arg_10_0)
	local var_10_0 = JY.Person[arg_10_0]
	local var_10_1 = var_10_0.修炼物品

	if var_10_1 < 0 then
		return
	end

	if JY.Thing[var_10_1].练出物品需经验 <= 0 then
		return
	end

	if (7 - math.modf(var_10_0.悟性 / 15)) * JY.Thing[var_10_1].练出物品需经验 > var_10_0.物品修炼点数 then
		return
	end

	local var_10_2 = 0
	local var_10_3 = -1

	for iter_10_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_10_0] == JY.Thing[var_10_1].需材料 then
			var_10_2 = 1
			var_10_3 = JY.Base["物品数量" .. iter_10_0]
		end
	end

	if var_10_2 == 1 then
		local var_10_4 = {}
		local var_10_5 = 0

		for iter_10_1 = 1, 5 do
			if JY.Thing[var_10_1]["练出物品" .. iter_10_1] >= 0 and var_10_3 >= JY.Thing[var_10_1]["需要物品数量" .. iter_10_1] then
				var_10_5 = 1
				var_10_4[iter_10_1] = 1
			else
				var_10_4[iter_10_1] = 0
			end
		end

		if var_10_5 == 1 then
			local var_10_6

			repeat
				var_10_6 = Rnd(5) + 1

				if var_10_1 == 221 and arg_10_0 == 88 and var_10_4[4] == 1 then
					var_10_6 = 4
				end

				if var_10_1 == 220 and arg_10_0 == 89 and var_10_4[4] == 1 then
					var_10_6 = 4
				end
			until var_10_4[var_10_6] == 1

			local var_10_7 = JY.Thing[var_10_1]["练出物品" .. var_10_6]

			DrawStrBoxWaitKey(string.format("%s 制造出 %s", var_10_0.姓名, JY.Thing[var_10_7].名称), C_WHITE, CC.DefaultFont)

			if has_thing(var_10_7) == true then
				instruct_32(var_10_7, 1)
			else
				instruct_32(var_10_7, 1)
			end

			instruct_32(JY.Thing[var_10_1].需材料, -JY.Thing[var_10_1]["需要物品数量" .. var_10_6])

			var_10_0.物品修炼点数 = 0
		end
	end
end

function yongquan(arg_11_0)
	if JY.Wugong[arg_11_0].武功类型 == 1 then
		return true
	else
		return false
	end
end

function yongjian(arg_12_0)
	if JY.Wugong[arg_12_0].武功类型 == 2 then
		return true
	else
		return false
	end
end

function yongdao(arg_13_0)
	if JY.Wugong[arg_13_0].武功类型 == 3 then
		return true
	else
		return false
	end
end

function yongte(arg_14_0)
	if JY.Wugong[arg_14_0].武功类型 == 4 then
		return true
	else
		return false
	end
end

function yongnei(arg_15_0)
	if JY.Wugong[arg_15_0].武功类型 == 5 then
		return true
	else
		return false
	end
end

function yongzhi(arg_16_0)
	if JY.Wugong[arg_16_0].武功类型 == 6 then
		return true
	else
		return false
	end
end

function yongan(arg_17_0)
	if JY.Wugong[arg_17_0].武功类型 == 7 then
		return true
	else
		return false
	end
end

function yongqing(arg_18_0)
	if JY.Wugong[arg_18_0].武功类型 == 10 then
		return true
	else
		return false
	end
end

function wgnumber(arg_19_0, arg_19_1)
	local var_19_0 = 0

	if arg_19_1 == 1 then
		for iter_19_0 = 1, CC.Kungfunum do
			if (JY.Person[arg_19_0]["武功" .. iter_19_0] == 123 or JY.Person[arg_19_0]["武功" .. iter_19_0] <= 26 and JY.Person[arg_19_0]["武功" .. iter_19_0] > 0 or JY.Person[arg_19_0]["武功" .. iter_19_0] >= 145 and JY.Person[arg_19_0]["武功" .. iter_19_0] <= 164) and JY.Person[arg_19_0]["武功等级" .. iter_19_0] == 999 then
				var_19_0 = var_19_0 + 1
			end
		end
	elseif arg_19_1 == 2 then
		for iter_19_1 = 1, CC.Kungfunum do
			if (JY.Person[arg_19_0]["武功" .. iter_19_1] == 124 or JY.Person[arg_19_0]["武功" .. iter_19_1] <= 49 and JY.Person[arg_19_0]["武功" .. iter_19_1] >= 27 and JY.Person[arg_19_0]["武功" .. iter_19_1] ~= 43 or JY.Person[arg_19_0]["武功" .. iter_19_1] <= 169 and JY.Person[arg_19_0]["武功" .. iter_19_1] >= 165) and JY.Person[arg_19_0]["武功等级" .. iter_19_1] == 999 then
				var_19_0 = var_19_0 + 1
			end
		end
	elseif arg_19_1 == 3 then
		for iter_19_2 = 1, CC.Kungfunum do
			if (JY.Person[arg_19_0]["武功" .. iter_19_2] == 125 or JY.Person[arg_19_0]["武功" .. iter_19_2] <= 67 and JY.Person[arg_19_0]["武功" .. iter_19_2] >= 50 or JY.Person[arg_19_0]["武功" .. iter_19_2] <= 174 and JY.Person[arg_19_0]["武功" .. iter_19_2] >= 170) and JY.Person[arg_19_0]["武功等级" .. iter_19_2] == 999 then
				var_19_0 = var_19_0 + 1
			end
		end
	elseif arg_19_1 == 4 then
		for iter_19_3 = 1, CC.Kungfunum do
			if (JY.Person[arg_19_0]["武功" .. iter_19_3] == 126 or JY.Person[arg_19_0]["武功" .. iter_19_3] <= 86 and JY.Person[arg_19_0]["武功" .. iter_19_3] >= 68 and JY.Person[arg_19_0]["武功" .. iter_19_3] ~= 85 or JY.Person[arg_19_0]["武功" .. iter_19_3] <= 180 and JY.Person[arg_19_0]["武功" .. iter_19_3] >= 175) and JY.Person[arg_19_0]["武功等级" .. iter_19_3] == 999 then
				var_19_0 = var_19_0 + 1
			end
		end
	elseif arg_19_1 == 5 then
		for iter_19_4 = 1, CC.Kungfunum do
			if (JY.Person[arg_19_0]["武功" .. iter_19_4] == 122 or JY.Person[arg_19_0]["武功" .. iter_19_4] == 43 or JY.Person[arg_19_0]["武功" .. iter_19_4] == 49 and JY.Person[arg_19_0]["武功" .. iter_19_4] ~= 86 or JY.Person[arg_19_0]["武功" .. iter_19_4] > 84 and JY.Person[arg_19_0]["武功" .. iter_19_4] < 121) and JY.Person[arg_19_0]["武功等级" .. iter_19_4] >= 900 then
				var_19_0 = var_19_0 + 1
			end
		end
	end

	return var_19_0
end

function xiaobin(arg_20_0)
	if JY.Person[arg_20_0].畅想级别 == 1 and arg_20_0 ~= 0 or JY.Person[arg_20_0].畅想级别 == 101 then
		return true
	else
		return false
	end
end

function WarPersonSort(arg_21_0)
	for iter_21_0 = 0, WAR.PersonNum - 1 do
		local var_21_0 = WAR.Person[iter_21_0].人物编号
		local var_21_1 = 0

		if JY.Person[var_21_0].武器 > -1 then
			var_21_1 = var_21_1 + JY.Thing[JY.Person[var_21_0].武器].加轻功
		end

		if JY.Person[var_21_0].防具 > -1 then
			var_21_1 = var_21_1 + JY.Thing[JY.Person[var_21_0].防具].加轻功
		end

		if JY.Person[var_21_0].坐骑 > -1 then
			var_21_1 = var_21_1 + JY.Thing[JY.Person[var_21_0].坐骑].加轻功
		end

		local var_21_2 = 0

		for iter_21_1 = 1, CC.Kungfunum do
			if JY.Person[var_21_0]["武功" .. iter_21_1] == JY.Person[var_21_0].主功体 then
				var_21_2 = JY.Person[var_21_0]["武功等级" .. iter_21_1] == 999 and 10 or JY.Person[var_21_0]["武功等级" .. iter_21_1] / 100
			end
		end

		if JY.Person[var_21_0].主功体 > 0 then
			var_21_1 = var_21_1 + JY.Wugong[JY.Person[var_21_0].主功体].增幅轻功等级 * var_21_2
		end

		if JY.Person[var_21_0].实战 >= 500 then
			var_21_1 = var_21_1 + math.modf(JY.Person[var_21_0].实战 / 20)
		end

		WAR.Person[iter_21_0].轻功 = JY.Person[var_21_0].轻功 + var_21_1

		for iter_21_2, iter_21_3 in pairs(CC.AddSpd) do
			if iter_21_3[1] == var_21_0 then
				for iter_21_4 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_21_4].人物编号 == iter_21_3[2] and WAR.Person[iter_21_4].死亡 == false then
						WAR.Person[iter_21_0].轻功 = WAR.Person[iter_21_0].轻功 + iter_21_3[3]
					end
				end
			end
		end
	end

	if arg_21_0 ~= nil then
		return
	end

	for iter_21_5 = 0, WAR.PersonNum - 2 do
		local var_21_3 = iter_21_5

		for iter_21_6 = iter_21_5, WAR.PersonNum - 1 do
			if WAR.Person[var_21_3].轻功 < WAR.Person[iter_21_6].轻功 then
				var_21_3 = iter_21_6
			end
		end

		WAR.Person[var_21_3], WAR.Person[iter_21_5] = WAR.Person[iter_21_5], WAR.Person[var_21_3]
	end
end

function War_Show_Count(arg_22_0, arg_22_1)
	local var_22_0 = WAR.Person[arg_22_0].人物编号
	local var_22_1 = WAR.Person[arg_22_0].坐标X
	local var_22_2 = WAR.Person[arg_22_0].坐标Y
	local var_22_3 = WAR.Person[arg_22_0].生命点数
	local var_22_4 = WAR.Person[arg_22_0].内力点数
	local var_22_5 = WAR.Person[arg_22_0].体力点数
	local var_22_6 = WAR.Person[arg_22_0].中毒点数
	local var_22_7 = WAR.Person[arg_22_0].解毒点数
	local var_22_8 = WAR.Person[arg_22_0].内伤点数
	local var_22_9 = {
		var_22_1,
		var_22_2
	}

	if var_22_3 ~= nil and var_22_3 ~= 0 then
		if var_22_3 > 0 then
			var_22_9[3] = "命+" .. var_22_3
		else
			var_22_9[3] = "命" .. var_22_3
		end
	end

	if var_22_4 ~= nil and var_22_4 ~= 0 then
		if var_22_4 > 0 then
			var_22_9[4] = "内+" .. var_22_4
		else
			var_22_9[4] = "内" .. var_22_4
		end
	end

	if var_22_5 ~= nil and var_22_5 ~= 0 then
		if var_22_5 > 0 then
			var_22_9[5] = "体+" .. var_22_5
		else
			var_22_9[5] = "体" .. var_22_5
		end
	end

	if var_22_6 ~= nil and var_22_6 ~= 0 then
		var_22_9[9] = "毒+" .. var_22_6
	end

	if var_22_7 ~= nil and var_22_7 ~= 0 then
		var_22_9[10] = "毒-" .. var_22_7
	end

	if var_22_8 ~= nil and var_22_8 ~= 0 and var_22_8 > 0 then
		var_22_9[11] = var_22_8
	end

	local var_22_10 = {}
	local var_22_11 = 0

	for iter_22_0 = 3, 10 do
		if var_22_9[iter_22_0] ~= nil then
			var_22_11 = var_22_11 + 1
			var_22_10[var_22_11] = iter_22_0
		end
	end

	if var_22_11 == 0 then
		return
	end

	local var_22_12 = GetS(JY.SubScene, var_22_1, var_22_2, 4)
	local var_22_13 = string.len(var_22_9[var_22_10[1]]) * CC.DefaultFont / 2 + 1
	local var_22_14 = {
		x1 = CC.ScreenW / 2 - var_22_13 / 2 - CC.XScale / 2,
		y1 = CC.YScale + CC.ScreenH / 2 - var_22_12,
		x2 = CC.XScale + CC.ScreenW / 2 + var_22_13,
		y2 = CC.YScale + CC.ScreenH / 2 + CC.DefaultFont + 1
	}
	local var_22_15 = (var_22_14.x2 - var_22_14.x1) * (var_22_14.y2 - var_22_14.y1) + CC.DefaultFont * 4
	local var_22_16 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	local var_22_17

	for iter_22_1 = 5, 18 do
		local var_22_18 = lib.GetTime()
		local var_22_19 = iter_22_1 * 2

		if var_22_17 == 1 and var_22_15 < CC.ScreenW * CC.ScreenH / 2 then
			local var_22_20 = {
				x1 = var_22_14.x1,
				y1 = var_22_14.y1 - var_22_19,
				x2 = var_22_14.x2,
				y2 = var_22_14.y2 - var_22_19
			}
			local var_22_21 = ClipRect(var_22_20)

			if var_22_21 ~= nil then
				lib.SetClip(var_22_21.x1, var_22_21.y1, var_22_21.x2, var_22_21.y2)
				WarDrawMap(0)

				if arg_22_1 ~= nil then
					DrawString(var_22_14.x1 - #arg_22_1 * CC.Fontsmall / 5, var_22_14.y1 - var_22_19 - CC.DefaultFont * 4, arg_22_1, C_WHITE, CC.Fontsmall)
				end

				for iter_22_2 = 1, var_22_11 do
					local var_22_22 = var_22_10[iter_22_2] - 1

					if var_22_10[iter_22_2] == 3 and string.sub(var_22_9[3], 1, 1) == "-" then
						var_22_22 = 1
					end

					DrawString(var_22_14.x1, var_22_14.y1 - var_22_19 - (var_22_11 - iter_22_2 + 1) * CC.DefaultFont, var_22_9[var_22_10[iter_22_2]], WAR.L_EffectColor[var_22_22], CC.DefaultFont)
				end
			end
		else
			lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
			lib.LoadSur(var_22_16, 0, 0)

			if arg_22_1 ~= nil then
				DrawString(var_22_14.x1 - #arg_22_1 * CC.Fontsmall / 5, var_22_14.y1 - var_22_19 - CC.DefaultFont * 4, arg_22_1, C_WHITE, CC.Fontsmall)
			end

			for iter_22_3 = 1, var_22_11 do
				local var_22_23 = var_22_10[iter_22_3] - 1

				if var_22_10[iter_22_3] == 3 and (string.sub(var_22_9[3], 1, 1) == "-" or string.sub(var_22_9[3], 2, 2) == "-") then
					var_22_23 = 1
				end

				DrawString(var_22_14.x1, var_22_14.y1 - var_22_19 - (var_22_11 - iter_22_3 + 1) * CC.DefaultFont, var_22_9[var_22_10[iter_22_3]], WAR.L_EffectColor[var_22_23], CC.DefaultFont)
			end
		end

		ShowScreen(1)
		lib.SetClip(0, 0, 0, 0)

		local var_22_24 = lib.GetTime()

		if var_22_24 - var_22_18 < CC.Frame then
			lib.Delay(CC.Frame - (var_22_24 - var_22_18))
		end
	end

	lib.SetClip(0, 0, 0, 0)

	WAR.Person[arg_22_0].生命点数 = nil
	WAR.Person[arg_22_0].内力点数 = nil
	WAR.Person[arg_22_0].体力点数 = nil
	WAR.Person[arg_22_0].中毒点数 = nil
	WAR.Person[arg_22_0].解毒点数 = nil
	WAR.Person[arg_22_0].内伤点数 = nil

	lib.FreeSur(var_22_16)
end

function UseThingEffect(arg_23_0, arg_23_1)
	local var_23_0 = {
		[0] = string.format("使用 %s", JY.Thing[arg_23_0].名称)
	}
	local var_23_1 = 1
	local var_23_2

	if JY.Thing[arg_23_0].加生命 > 0 then
		local var_23_3 = JY.Thing[arg_23_0].加生命 - math.modf(JY.Person[arg_23_1].受伤程度 / 2) + Rnd(10)

		if JY.Status == GAME_WMAP and instruct_16(arg_23_1) and instruct_16(16) then
			for iter_23_0 = 0, WAR.PersonNum - 1 do
				local var_23_4 = WAR.Person[iter_23_0].人物编号

				if cxtd(var_23_4, 16) and WAR.Person[iter_23_0].死亡 == false and WAR.Person[iter_23_0].我方 then
					var_23_3 = math.modf(var_23_3 * 1.5)

					break
				end
			end
		end

		if var_23_3 <= 0 then
			var_23_3 = 5 + Rnd(5)
		end

		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "受伤程度", -math.modf(var_23_3 / 4))

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end

		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "生命", var_23_3)

		if JY.Status == GAME_WMAP then
			WAR.Person[WAR.CurID].生命点数 = var_23_2
		end

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end
	end

	local function var_23_5(arg_24_0)
		if JY.Thing[arg_23_0]["加" .. arg_24_0] ~= 0 then
			var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, arg_24_0, JY.Thing[arg_23_0]["加" .. arg_24_0])

			if var_23_2 ~= 0 then
				var_23_1 = var_23_1 + 1
			end

			if JY.Status == GAME_WMAP then
				if arg_24_0 == "体力" then
					WAR.Person[WAR.CurID].体力点数 = var_23_2
				elseif arg_24_0 == "内力" then
					WAR.Person[WAR.CurID].内力点数 = var_23_2
				end
			end
		end
	end

	var_23_5("生命最大值")

	if JY.Person[arg_23_1].生命最大值 > JY.Person[arg_23_1].生命增长 * 100 then
		JY.Person[arg_23_1].生命最大值 = JY.Person[arg_23_1].生命增长 * 100 + Rnd(50)
	end

	local var_23_6 = Rnd(2)

	if arg_23_0 == 335 then
		JY.Person[arg_23_1].魅力 = JY.Person[arg_23_1].魅力 + 1

		DrawStrBoxWaitKey(string.format("%s 魅力增加 %d", JY.Person[arg_23_1].姓名, 1), C_ORANGE, CC.DefaultFont)

		if JY.Person[arg_23_1].生命最大值 < 1 then
			JY.Person[arg_23_1].生命最大值 = 1
		end

		if var_23_6 == 1 and JY.Person[arg_23_1].悟性 > 1 then
			JY.Person[arg_23_1].悟性 = JY.Person[arg_23_1].悟性 - 1

			say("精神一阵虚弱，似乎有什么东西从身上游离出去了似的。", arg_23_1, 0)
		end
	end

	if JY.Thing[arg_23_0].加中毒解毒 < 0 then
		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "中毒程度", math.modf(JY.Thing[arg_23_0].加中毒解毒))

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end

		if JY.Status == GAME_WMAP then
			if var_23_2 < 0 then
				WAR.Person[WAR.CurID].解毒点数 = -var_23_2
			elseif var_23_2 > 0 then
				WAR.Person[WAR.CurID].中毒点数 = var_23_2
			end
		end
	end

	var_23_5("体力")

	if JY.Thing[arg_23_0].改变内力性质 == 2 then
		var_23_0[var_23_1] = "内力门路改为阴阳合一"
		var_23_1 = var_23_1 + 1
	end

	var_23_5("内力")
	var_23_5("内力最大值")

	if JY.Person[arg_23_1].内力最大值 > JY.Person[arg_23_1].生命增长 * 1000 then
		JY.Person[arg_23_1].内力最大值 = JY.Person[arg_23_1].生命增长 * 1000 + Rnd(50)
	end

	var_23_5("攻击力")
	var_23_5("防御力")
	var_23_5("轻功")
	var_23_5("医疗能力")
	var_23_5("用毒能力")
	var_23_5("解毒能力")
	var_23_5("抗毒能力")
	var_23_5("拳掌功夫")
	var_23_5("御剑能力")
	var_23_5("耍刀技巧")
	var_23_5("特殊兵器")
	var_23_5("暗器技巧")
	var_23_5("武学常识")
	var_23_5("攻击带毒")

	if JY.Person[arg_23_1].中冰毒 > 0 then
		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "中冰毒", JY.Thing[arg_23_0].加冰毒解毒)

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end
	end

	if JY.Person[arg_23_1].中火毒 > 0 then
		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "中火毒", JY.Thing[arg_23_0].加火毒解毒)

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end
	end

	if JY.Person[arg_23_1].流血值 > 0 then
		var_23_2, var_23_0[var_23_1] = AddPersonAttrib(arg_23_1, "流血值", -JY.Thing[arg_23_0].止血)

		if var_23_2 ~= 0 then
			var_23_1 = var_23_1 + 1
		end
	end

	if var_23_1 > 1 then
		local var_23_7 = 0

		for iter_23_1 = 0, var_23_1 - 1 do
			if var_23_7 < #var_23_0[iter_23_1] then
				var_23_7 = #var_23_0[iter_23_1]
			end
		end

		Cls()

		if JY.Status ~= GAME_WMAP then
			local var_23_8 = var_23_7 * CC.DefaultFont / 2 + CC.MenuBorderPixel * 2
			local var_23_9 = var_23_1 * CC.DefaultFont + (var_23_1 - 1) * CC.RowPixel + 2 * CC.MenuBorderPixel
			local var_23_10 = (CC.ScreenW - var_23_8) / 2
			local var_23_11 = (CC.ScreenH - var_23_9) / 2

			DrawBox(var_23_10, var_23_11, var_23_10 + var_23_8, var_23_11 + var_23_9, C_WHITE)
			DrawString(var_23_10 + CC.MenuBorderPixel, var_23_11 + CC.MenuBorderPixel, var_23_0[0], C_WHITE, CC.DefaultFont)

			for iter_23_2 = 1, var_23_1 - 1 do
				DrawString(var_23_10 + CC.MenuBorderPixel, var_23_11 + CC.MenuBorderPixel + (CC.DefaultFont + CC.RowPixel) * iter_23_2, var_23_0[iter_23_2], C_ORANGE, CC.DefaultFont)
			end

			ShowScreen()
		else
			DrawString(CC.MainMenuX, CC.ScreenH - (var_23_1 + 2) * CC.Fontsmall, JY.Person[WAR.Person[WAR.CurID].人物编号].姓名 .. " " .. var_23_0[0], C_WHITE, CC.Fontsmall)

			for iter_23_3 = 1, var_23_1 - 1 do
				DrawString(CC.MainMenuX, CC.ScreenH + (iter_23_3 - var_23_1 - 2) * CC.Fontsmall, var_23_0[iter_23_3], C_WHITE, CC.Fontsmall)
			end

			ShowScreen()
			War_Show_Count(WAR.CurID)

			return 1
		end

		return 1
	else
		DrawStrBox(-1, -1, var_23_0[0], C_WHITE, CC.DefaultFont)
		ShowScreen()

		return 1
	end
end

function ExecDoctor(arg_25_0, arg_25_1)
	if JY.Person[arg_25_0].体力 < 50 then
		return 0
	end

	local var_25_0 = JY.Person[arg_25_0].医疗能力
	local var_25_1 = JY.Person[arg_25_1].受伤程度

	if var_25_1 > var_25_0 + 20 then
		return 0
	end

	if cxtd(arg_25_0, 28) and JY.Status == GAME_WMAP then
		var_25_0 = math.modf(JY.Person[arg_25_0].医疗能力 * (1 + WAR.PYZ / 10))
	end

	if JY.Status == GAME_WMAP then
		for iter_25_0, iter_25_1 in pairs(CC.AddDoc) do
			if iter_25_1[1] == arg_25_0 then
				for iter_25_2 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_25_2].人物编号 == iter_25_1[2] and WAR.Person[iter_25_2].死亡 == false then
						var_25_0 = var_25_0 + iter_25_1[3]
					end
				end
			end
		end
	end

	local var_25_2 = var_25_0 - var_25_0 * var_25_1 / 200
	local var_25_3 = math.modf(var_25_2) + Rnd(5)
	local var_25_4 = AddPersonAttrib(arg_25_1, "受伤程度", -math.modf(var_25_3 / 10))

	if JY.Status == GAME_WMAP then
		local var_25_5 = -1

		for iter_25_3 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_25_3].人物编号 == arg_25_1 and WAR.Person[iter_25_3].死亡 == false then
				var_25_5 = iter_25_3

				break
			end
		end

		WAR.Person[var_25_5].内伤点数 = var_25_4
	end

	return AddPersonAttrib(arg_25_1, "生命", var_25_3)
end

function baseRandom(arg_26_0)
	local var_26_0 = 0

	for iter_26_0 = 0, WAR.PersonNum - 1 do
		local var_26_1 = WAR.Person[iter_26_0].人物编号

		var_26_0 = var_26_0 + JY.Person[var_26_1].实战 + Person_qy(var_26_1)
	end

	for iter_26_1 = 0, WAR.PersonNum - 1 do
		local var_26_2 = WAR.Person[iter_26_1].人物编号

		if WAR.Person[iter_26_1].死亡 == false and WAR.Person[iter_26_1].我方 and cxtd(var_26_2, 76) and instruct_16(arg_26_0) then
			var_26_0 = var_26_0 + 10
		end
	end

	for iter_26_2 = 0, WAR.PersonNum - 1 do
		local var_26_3 = WAR.Person[iter_26_2].人物编号

		if WAR.Person[iter_26_2].死亡 == false and WAR.Person[iter_26_2].我方 and cxtd(var_26_3, 5003) then
			var_26_0 = var_26_0 + 5
		end
	end

	for iter_26_3 = 0, WAR.PersonNum - 1 do
		local var_26_4 = WAR.Person[iter_26_3].人物编号

		if WAR.Person[iter_26_3].死亡 == false and WAR.Person[iter_26_3].我方 and cxtd(var_26_4, 135) then
			var_26_0 = var_26_0 + 10
		end
	end

	local var_26_5 = var_26_0 + limitX(math.modf(JY.Person[arg_26_0].内力 / 800), 0, 12) + math.modf(JY.Person[arg_26_0].生命最大值 * 2 / (JY.Person[arg_26_0].生命 + 100))

	if instruct_16(arg_26_0) or ybdw(arg_26_0) then
		for iter_26_4 = 1, #TeamP do
			if TeamP[iter_26_4] ~= nil and TeamP[iter_26_4] == arg_26_0 then
				local var_26_6 = math.modf(JY.Person[arg_26_0].实战 / 25 + 1)

				if var_26_6 > 20 then
					var_26_6 = 20
				end

				var_26_5 = var_26_5 + var_26_6

				break
			end
		end
	end

	if cxtd(arg_26_0, 12) then
		for iter_26_5 = 1, #TeamP do
			if TeamP[iter_26_5] ~= nil and TeamP[iter_26_5] == arg_26_0 then
				local var_26_7 = math.modf(JY.Person[arg_26_0].实战 / 25 + 1)

				if var_26_7 > 20 then
					var_26_7 = 20
				end

				var_26_5 = var_26_5 + var_26_7

				break
			end
		end
	end

	if cxtd(arg_26_0, 38) then
		var_26_5 = var_26_5 + 10
	end

	for iter_26_6 = 1, CC.Kungfunum do
		if JY.Person[arg_26_0]["武功" .. iter_26_6] == 102 then
			var_26_5 = var_26_5 + (math.modf(JY.Person[arg_26_0]["武功等级" .. iter_26_6] / 100) + 1)

			break
		end
	end

	if WAR.L_NYZH[arg_26_0] ~= nil then
		var_26_5 = var_26_5 + 20
	end

	if not instruct_16(arg_26_0) then
		var_26_5 = var_26_5 + 10
	end

	if JY.Base.畅想编号 > 0 and arg_26_0 == JY.Base.队伍1 then
		var_26_5 = var_26_5 + 10
	end

	return var_26_5
end

function atkRandom(arg_27_0, arg_27_1)
	local var_27_0 = JY.Person[arg_27_1].攻击力

	for iter_27_0, iter_27_1 in pairs(CC.AddAtk) do
		if iter_27_1[1] == arg_27_1 then
			for iter_27_2 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_27_2].人物编号 == iter_27_1[2] and WAR.Person[iter_27_2].死亡 == false then
					var_27_0 = var_27_0 + iter_27_1[3]
				end
			end
		end
	end

	if JY.Person[arg_27_1].武器 >= 0 then
		var_27_0 = JY.Thing[JY.Person[arg_27_1].武器].加攻击力
	end

	if JY.Person[arg_27_1].防具 >= 0 then
		var_27_0 = JY.Thing[JY.Person[arg_27_1].防具].加攻击力
	end

	arg_27_0 = arg_27_0 + limitX(math.modf(var_27_0 / 15), 0, 40)
	arg_27_0 = arg_27_0 + baseRandom(arg_27_1)

	return arg_27_0 > math.random(110)
end

function defRandom(arg_28_0, arg_28_1)
	local var_28_0 = JY.Person[arg_28_1].防御力

	for iter_28_0, iter_28_1 in pairs(CC.AddDef) do
		if iter_28_1[1] == arg_28_1 then
			for iter_28_2 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_28_2].人物编号 == iter_28_1[2] and WAR.Person[iter_28_2].死亡 == false then
					var_28_0 = var_28_0 + iter_28_1[3]
				end
			end
		end
	end

	if JY.Person[arg_28_1].武器 >= 0 then
		var_28_0 = JY.Thing[JY.Person[arg_28_1].武器].加防御力
	end

	if JY.Person[arg_28_1].防具 >= 0 then
		var_28_0 = JY.Thing[JY.Person[arg_28_1].防具].加防御力
	end

	arg_28_0 = arg_28_0 + limitX(math.modf(var_28_0 / 15), 0, 40)
	arg_28_0 = arg_28_0 + baseRandom(arg_28_1)

	return arg_28_0 > math.random(110)
end

function spdRandom(arg_29_0, arg_29_1)
	local var_29_0 = JY.Person[arg_29_1].轻功

	for iter_29_0, iter_29_1 in pairs(CC.AddSpd) do
		if iter_29_1[1] == arg_29_1 then
			for iter_29_2 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_29_2].人物编号 == iter_29_1[2] and WAR.Person[iter_29_2].死亡 == false then
					var_29_0 = var_29_0 + iter_29_1[3]
				end
			end
		end
	end

	if JY.Person[arg_29_1].武器 >= 0 then
		var_29_0 = JY.Thing[JY.Person[arg_29_1].武器].加轻功
	end

	if JY.Person[arg_29_1].防具 >= 0 then
		var_29_0 = JY.Thing[JY.Person[arg_29_1].防具].加轻功
	end

	arg_29_0 = arg_29_0 + limitX(math.modf(var_29_0 / 15), 0, 40)
	arg_29_0 = arg_29_0 + baseRandom(arg_29_1)

	return arg_29_0 > math.random(110)
end

function atkdefRandom(arg_30_0, arg_30_1)
	local var_30_0 = JY.Person[arg_30_1].攻击力

	for iter_30_0, iter_30_1 in pairs(CC.AddAtk) do
		if iter_30_1[1] == arg_30_1 then
			for iter_30_2 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_30_2].人物编号 == iter_30_1[2] and WAR.Person[iter_30_2].死亡 == false then
					var_30_0 = var_30_0 + iter_30_1[3]
				end
			end
		end
	end

	if JY.Person[arg_30_1].武器 >= 0 then
		var_30_0 = JY.Thing[JY.Person[arg_30_1].武器].加攻击力
	end

	if JY.Person[arg_30_1].防具 >= 0 then
		var_30_0 = JY.Thing[JY.Person[arg_30_1].防具].加攻击力
	end

	local var_30_1 = limitX(math.modf(var_30_0 / 15), 0, 40)
	local var_30_2 = JY.Person[arg_30_1].防御力

	for iter_30_3, iter_30_4 in pairs(CC.AddDef) do
		if iter_30_4[1] == arg_30_1 then
			for iter_30_5 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_30_5].人物编号 == iter_30_4[2] and WAR.Person[iter_30_5].死亡 == false then
					var_30_2 = var_30_2 + iter_30_4[3]
				end
			end
		end
	end

	if JY.Person[arg_30_1].武器 >= 0 then
		var_30_2 = JY.Thing[JY.Person[arg_30_1].武器].加防御力
	end

	if JY.Person[arg_30_1].防具 >= 0 then
		var_30_2 = JY.Thing[JY.Person[arg_30_1].防具].加防御力
	end

	local var_30_3 = limitX(math.modf(var_30_2 / 15), 0, 40)

	arg_30_0 = arg_30_0 + math.modf((var_30_1 + var_30_3) / 2) + baseRandom(arg_30_1)

	return arg_30_0 > math.random(110)
end

function WarSetGlobal()
	WAR = {}
	WAR.Data = {}
	WAR.SelectPerson = {}
	WAR.YbPerson = {}
	WAR.Person = {}

	for iter_31_0 = 0, 30 do
		WAR.Person[iter_31_0] = {}
		WAR.Person[iter_31_0].人物编号 = -1
		WAR.Person[iter_31_0].我方 = true
		WAR.Person[iter_31_0].坐标X = -1
		WAR.Person[iter_31_0].坐标Y = -1
		WAR.Person[iter_31_0].死亡 = true
		WAR.Person[iter_31_0].人方向 = -1
		WAR.Person[iter_31_0].贴图 = -1
		WAR.Person[iter_31_0].贴图类型 = 0
		WAR.Person[iter_31_0].轻功 = 0
		WAR.Person[iter_31_0].移动步数 = 0
		WAR.Person[iter_31_0].经验 = 0
		WAR.Person[iter_31_0].自动选择对手 = -1
		WAR.Person[iter_31_0].Move = {}
		WAR.Person[iter_31_0].Action = {}
		WAR.Person[iter_31_0].Time = 0
		WAR.Person[iter_31_0].TimeAdd = 0
		WAR.Person[iter_31_0].SpdAdd = 0
		WAR.Person[iter_31_0].Point = 0
		WAR.Person[iter_31_0].特效动画 = -1
		WAR.Person[iter_31_0].反击武功 = -1
		WAR.Person[iter_31_0].特效文字1 = nil
		WAR.Person[iter_31_0].特效文字2 = nil
		WAR.Person[iter_31_0].特效文字3 = nil
	end

	WAR.PersonNum = 0
	WAR.ZYZ = {}
	WAR.JZY = {}
	WAR.JZY = {}
	WAR.AutoFight = 0
	WAR.CurID = -1
	WAR.SXTJ = 0
	WAR.WGWL = 0
	WAR.EVENT1 = 0
	WAR.ZYHB = 0
	WAR.ZYHBP = -1
	WAR.BJ = 0
	WAR.XK = 0
	WAR.XK2 = nil
	WAR.TD = -1
	WAR.TD1 = -1
	WAR.HTSS = 0
	WAR.YTFS = 0
	WAR.SQFJ = 0
	WAR.YT1 = 0
	WAR.YT2 = 0
	WAR.ZSF = 0
	WAR.ZSF2 = 0
	WAR.XZZ = 0
	WAR.WCY = 0
	WAR.MCF = 0
	WAR.FS = 0
	WAR.DYSZ = 0
	WAR.TFH = 0
	WAR.WQQ = 0
	WAR.DBS = 0
	WAR.ZBT = 1
	WAR.HQT = 0
	WAR.CY = 0
	WAR.LRZ = 0
	WAR.HDWZ = 0
	WAR.LMC = 0
	WAR.ZJZ = 0
	WAR.TGN = 0
	WAR.YJ = 0
	WAR.YJTQ = {}
	WAR.XMH = 0
	WAR.PYZ = 0
	WAR.YZB = 0
	WAR.YZB2 = 0
	WAR.YZB3 = 0
	WAR.GBWZ = 0
	WAR.SSQX = 0
	WAR.BSMT = 0
	WAR.XDLZ = 0
	WAR.XHLH = 0
	WAR.DJGZ = 0
	WAR.XSZJ = 0
	WAR.TYWF = 0
	WAR.XDDF = 0
	WAR.XDXX = 0
	WAR.WS = 0
	WAR.ACT = 1
	WAR.ZDDH = -1
	WAR.NO1 = -1
	WAR.TJAY = 0
	WAR.TJSQ = 0
	WAR.TJZX = {}
	WAR.TJZX_LJ = 0
	WAR.DZXY = 0
	WAR.DZXYLV = {}
	WAR.FQYY = {}
	WAR.YLSX = 0
	WAR.XTTX = 0
	WAR.Dodge = 0
	WAR.QKNY = 0
	WAR.fthurt = 0
	WAR.NYSH = {}
	WAR.LXZQ = 0
	WAR.JSYX = 0
	WAR.ASKD = 0
	WAR.QMYC = 0
	WAR.JSTG = 0
	WAR.RZWD = 0
	WAR.FLHS1 = 0
	WAR.FLHS2 = 0
	WAR.FLHS4 = 0
	WAR.FLHS5 = 0
	WAR.FLHS6 = 0
	WAR.GDZJ = 0
	WAR.NGJL = 0
	WAR.NGHT = 0
	WAR.BMXH = 0
	WAR.XTSW = 0
	WAR.HSWLB = 0
	WAR.BMXH1 = 0
	WAR.BMXH2 = 0
	WAR.ZYYD = 0
	WAR.SSFwav = 0
	WAR.LMSJwav = 0
	WAR.JGZ_DMZ = 0
	WAR.LHQ_BNZ = 0
	WAR.QQSH = {}
	WAR.QQSHS = {}
	WAR.QQSHH = {}
	WAR.QQSHQ = {}
	WAR.WPXJF = 0
	WAR.ZSSF = 0
	WAR.ZTSLYZ = 0
	WAR.ShowHead = 0
	WAR.Effect = 0
	WAR.EffectColor = {}
	WAR.EffectColor[2] = RGB(236, 200, 40)
	WAR.EffectColor[3] = RGB(112, 12, 112)
	WAR.EffectColor[4] = RGB(236, 200, 40)
	WAR.EffectColor[5] = RGB(96, 176, 64)
	WAR.EffectColor[6] = RGB(104, 192, 232)
	WAR.Delay = 0
	WAR.LifeNum = 0
	WAR.EffectXY = nil
	WAR.EffectXYNum = 0
	WAR.tmp = {}
	WAR.TJFH = {}
	WAR.CCZ = 0
	WAR.Actup = {}
	WAR.Defup = {}
	WAR.KHBX = 0
	WAR.KHCM = {}
	WAR.LQZ = {}
	WAR.FXDS = {}
	WAR.FXXS = {}
	WAR.LXZT = {}
	WAR.XTSQ = {}
	WAR.CHXS = {}
	WAR.BFZ = {}
	WAR.SZHBF = {}
	WAR.ZDSXS = 0
	WAR.ICE = {}
	WAR.HOT = {}
	WAR.HOTXS = {}
	JY.XSKG = 0
	WAR.LXSZ = {}
	WAR.FXSZ = {}
	WAR.ZSZ = {}
	WAR.ZJBF = {}
	WAR.DMLHSXJ = {}
	WAR.LXXS = {}
	WAR.JTZ = {}
	WAR.JTXS = {}
	WAR.XSZJ = {}
	WAR.SZJPYX = {}
	WAR.JLJJB = {}
	WAR.XDHFJQ = {}
	WAR.QLTY = {}
	WAR.TZ_DY = 0
	WAR.TZ_XZ = 0
	WAR.TZ_XZ_SSH = {}
	WAR.JZPZ = {}
	WAR.JZPZXS = 0
	WAR.BFX = 0
	WAR.BLX = 0

	if JY.Base.畅想编号 == 44 or JY.Base.畅想编号 == 98 or JY.Base.畅想编号 == 99 or JY.Base.畅想编号 == 100 then
		WAR.LQZ[0] = 100
	end

	WAR.LQZ[44] = 100
	WAR.LQZ[98] = 100
	WAR.LQZ[99] = 100
	WAR.LQZ[100] = 100

	if JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 and JY.Base.觉醒 == 1 then
		WAR.LQZ[0] = 50
	end

	WAR.JYFX = {}
	WAR.L_TLD = 0
	WAR.L_YTJ1 = 0
	WAR.L_YTJ2 = 0
	WAR.L_LWX = 0
	WAR.L_SSBD = 0
	WAR.FDHOT = 0
	WAR.XXYY = 0
	WAR.QDSX = 0
	WAR.BPHG = 0
	WAR.QXWX = 0
	WAR.MBDQ = 0
	WAR.SBCS = 0
	WAR.OXQP = 0
	WAR.PDJN = 0
	WAR.L_SGHT = 0
	WAR.L_SGJL = 0
	WAR.L_LXXL = 0
	WAR.B_BMJQ = 0
	WAR.YJZD = 0
	WAR.L_EffectColor = {}
	WAR.L_EffectColor[1] = RGB(255, 10, 10)
	WAR.L_EffectColor[2] = RGB(247, 212, 215)
	WAR.L_EffectColor[3] = RGB(0, 102, 153)
	WAR.L_EffectColor[4] = RGB(197, 207, 125)
	WAR.L_EffectColor[5] = RGB(255, 236, 150)
	WAR.L_EffectColor[6] = RGB(255, 236, 150)
	WAR.L_EffectColor[7] = RGB(255, 236, 150)
	WAR.L_EffectColor[8] = RGB(51, 204, 102)
	WAR.L_EffectColor[10] = RGB(220, 30, 30)
	WAR.L_EffectColor[9] = RGB(255, 10, 10)
	WAR.L_ZXSG = 0
	WAR.L_CZJT = 0
	WAR.L_NYZH = {}
	WAR.L_WNGZL = {}
	WAR.L_HQNZL = {}
	WAR.L_TXSG = {}
	WAR.L_NOT_MOVE = {}
	WAR.L_LZJF_ATK = {}
	WAR.L_LZJFCC = 0
	WAR.L_RYJF = {}
	WAR.L_RYJFCC = 0
	WAR.L_QKDNY = {}
	WAR.L_MJJF = 0
	WAR.L_WYJFA = 0
	WAR.L_NSDF = {}
	WAR.L_NSDFCC = 0
	WAR.L_DGQB_X = 1
	WAR.L_DGQB_DEF = 0
	WAR.L_DGQB_ZS = {
		"独孤一式",
		"独孤二式",
		"独孤三式",
		"独孤四式",
		"独孤五式",
		"独孤六式",
		"独孤七式",
		"独孤八式",
		"独孤九式",
		"独孤极意·无招胜有招"
	}
	WAR.L_DGQB_DEF_STR = {
		"破掌式",
		"破剑式",
		"破刀式",
		"破特式",
		"破气式",
		"破指式",
		"破暗式"
	}
	WAR.EFT = {}
	WAR.EFTNUM = 0
	WAR.JQSDXS = {}
	WAR.LRPD = 1
	WAR.LIURU = 0
	WAR.QUSHE = 0
	WAR.QQDB = 0
	WAR.DYWY = 0
	WAR.YCZHL = {}
	WAR.HUFEI = 0
	WAR.HMXC = 0
	WAR.JIUPO = 0
	WAR.SAXING = -1
	WAR.SHENDIAO = 0
	WAR.YUFENG = 3
	WAR.LINGGANG = 0
	WAR.MEIHUO = 1
	WAR.QIZHEN = {}
	WAR.NPC = {}
	WAR.NPC2 = {}
	WAR.GTMENU = 1
end

function War_WugongHurtLife(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = WAR.Person[WAR.CurID].人物编号
	local var_32_1 = WAR.Person[arg_32_0].人物编号
	local var_32_2 = 0
	local var_32_3 = JY.Wugong[arg_32_1].武功类型

	local function var_32_4()
		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
			return true
		else
			return false
		end
	end

	local var_32_5 = 0
	local var_32_6 = 0

	for iter_32_0 = 0, WAR.PersonNum - 1 do
		local var_32_7 = WAR.Person[iter_32_0].人物编号

		if WAR.Person[iter_32_0].死亡 == false and JY.Person[var_32_7].武学常识 > 10 then
			if WAR.Person[WAR.CurID].我方 == WAR.Person[iter_32_0].我方 and var_32_5 < JY.Person[var_32_7].武学常识 then
				var_32_5 = JY.Person[var_32_7].武学常识
			end

			if WAR.Person[arg_32_0].我方 == WAR.Person[iter_32_0].我方 and var_32_6 < JY.Person[var_32_7].武学常识 then
				var_32_6 = JY.Person[var_32_7].武学常识
			end
		end

		if var_32_6 < 50 then
			var_32_6 = 50
		end
	end

	while true do
		if JY.Person[var_32_0].内力 < math.modf((arg_32_2 + 1) / 2) * JY.Wugong[arg_32_1].消耗内力点数 then
			arg_32_2 = arg_32_2 - 1
		else
			break
		end
	end

	if arg_32_2 <= 0 then
		arg_32_2 = 1
	end

	local var_32_8 = JY.Person[var_32_1].主功体

	if var_32_8 > 0 and JLSD(30, 90, var_32_1) then
		WAR.NGHT = var_32_8

		local var_32_9 = PersonKFDJ(var_32_1, var_32_8)
		local var_32_10 = math.modf(var_32_9 / 100) + 1
		local var_32_11 = JY.Wugong[var_32_8]["攻击力" .. var_32_10]

		if var_32_2 < var_32_11 then
			var_32_2 = var_32_11
		end

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = JY.Wugong[var_32_8].名称 .. "护体"
		end
	end

	local var_32_12 = {}
	local var_32_13 = 0

	for iter_32_1 = 1, CC.Kungfunum do
		local var_32_14 = JY.Person[var_32_1]["武功" .. iter_32_1]

		if (var_32_14 == 95 or var_32_14 == 97 or var_32_14 == 101 or var_32_14 == 106) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and not cxtd(var_32_0, 135) then
			var_32_13 = var_32_13 + 1
			var_32_12[var_32_13] = {
				var_32_14,
				iter_32_1
			}
		end
	end

	if var_32_13 > 0 and WAR.NGHT == 0 and (defRandom(30, var_32_1) or (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 6 and JLSD(35, 75, 0) or cxtd(var_32_1, 118) and JLSD(60, 75, 0) or cxtd(var_32_1, 5012) and JLSD(30, 60, 0)) then
		local var_32_15 = math.random(var_32_13)
		local var_32_16 = var_32_12[var_32_15][1]
		local var_32_17 = math.modf(JY.Person[var_32_1]["武功等级" .. var_32_12[var_32_15][2]] / 100) + 1

		var_32_2 = JY.Wugong[var_32_16]["攻击力" .. var_32_17]

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = JY.Wugong[var_32_16].名称 .. "防护"
		end

		WAR.Person[arg_32_0].特效动画 = math.fmod(var_32_16, 10) + 85
		WAR.NGHT = var_32_16
	end

	if WAR.NGHT == 0 then
		for iter_32_2 = 1, CC.Kungfunum do
			local var_32_18 = JY.Person[var_32_1]["武功" .. iter_32_2]

			if var_32_18 > 88 and var_32_18 < 123 and var_32_18 ~= 97 and var_32_18 ~= 95 and var_32_18 ~= 101 and var_32_18 ~= 108 and var_32_18 ~= 107 and var_32_18 ~= 106 and var_32_18 ~= 105 and var_32_18 ~= 102 and var_32_18 ~= 85 and var_32_18 ~= 87 and var_32_18 ~= 121 and var_32_18 ~= 88 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (defRandom(30, var_32_1) or (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 6 and JLSD(35, 75, 0) or cxtd(var_32_1, 118) and JLSD(60, 75, 0) or cxtd(var_32_1, 5012) and JLSD(30, 60, 0)) then
				local var_32_19 = math.modf(JY.Person[var_32_1]["武功等级" .. iter_32_2] / 100) + 1
				local var_32_20 = JY.Wugong[var_32_18]["攻击力" .. var_32_19]

				if var_32_2 < var_32_20 then
					var_32_2 = var_32_20

					if WAR.Person[arg_32_0].特效文字2 == nil then
						WAR.Person[arg_32_0].特效文字2 = JY.Wugong[var_32_18].名称 .. "护体"
					end

					WAR.NGHT = var_32_18
				end
			end
		end
	end

	if WAR.NGHT == 0 and JY.Person[var_32_1].副功体 > 0 then
		var_32_2 = var_32_2 + 500
		WAR.L_SGHT = 122

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "天罡护体"
		else
			WAR.Person[arg_32_0].特效文字3 = "天罡护体"
		end

		WAR.Person[arg_32_0].特效动画 = 6
	end

	local var_32_21 = {}
	local var_32_22 = 0

	for iter_32_3 = 1, CC.Kungfunum do
		local var_32_23 = JY.Person[var_32_1]["武功" .. iter_32_3]

		if (var_32_23 == 108 or var_32_23 == 102 or var_32_23 == 105 or var_32_23 == 106 and (JY.Person[var_32_1].内力性质 == 1 or (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5)) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
			var_32_22 = var_32_22 + 1
			var_32_21[var_32_22] = {
				var_32_23,
				iter_32_3
			}
		end
	end

	if var_32_22 > 0 then
		local var_32_24 = math.random(var_32_22)
		local var_32_25 = var_32_21[var_32_24][1]
		local var_32_26 = math.modf(JY.Person[var_32_1]["武功等级" .. var_32_21[var_32_24][2]] / 100) + 1
		local var_32_27 = JY.Wugong[var_32_25]["攻击力" .. var_32_26]

		if var_32_25 == 108 and (atkdefRandom(25, var_32_1) or cxtd(var_32_1, 149)) then
			var_32_2 = var_32_2 + math.modf(var_32_27 / 2) + 500
			WAR.L_SGHT = var_32_25

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				-- Nothing
			else
				WAR.Person[arg_32_0].特效文字2 = JY.Wugong[var_32_25].名称 .. "神功护体"
			end

			WAR.Person[arg_32_0].特效动画 = 79
		end

		if var_32_25 == 106 then
			var_32_2 = var_32_2 + 500
		end

		if JY.Person[var_32_1].主功体 == 108 then
			var_32_2 = var_32_2 + 500
		end

		if PersonKF(var_32_1, 64) then
			var_32_2 = var_32_2 + 400
		end

		if WAR.XSZJ == 9 then
			var_32_2 = var_32_2 + 800
		end

		if cxtd(var_32_1, 119) then
			var_32_2 = var_32_2 + 800
		end

		local var_32_28 = 30 - JY.Person[var_32_1].悟性

		if var_32_28 < 0 then
			var_32_28 = 0
		end

		if var_32_25 == 102 and JY.Person[var_32_1].主功体 == 102 and JLSD(30, 70 + var_32_28, var_32_1) then
			WAR.L_SGHT = var_32_25

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				-- Nothing
			else
				WAR.Person[arg_32_0].特效文字2 = "太玄神功护体"
			end

			WAR.Person[arg_32_0].特效动画 = 63
		end

		if cxtd(var_32_1, 27) then
			-- Nothing
		elseif Curr_NG(var_32_1, 105) and (JLSD(30, 60, var_32_1) or cxtd(var_32_1, 36) and JLSD(40, 60, var_32_1)) then
			WAR.L_SGHT = var_32_25

			if WAR.Person[arg_32_0].特效文字1 ~= nil then
				WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "葵花移形"
			else
				WAR.Person[arg_32_0].特效文字1 = "葵花移形"
			end
		end

		if Curr_NG(var_32_1, 106) and defRandom(30, var_32_1) and JY.Person[var_32_1].内力性质 == 1 and WAR.NGHT == 0 then
			WAR.L_SGHT = var_32_25
			var_32_2 = var_32_2 + 1000

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				-- Nothing
			else
				WAR.Person[arg_32_0].特效文字2 = "九阳神功护体"
			end

			WAR.Person[arg_32_0].特效动画 = 7
		end
	end

	if WAR.Defup[var_32_1] == 1 then
		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "防御状态"
		else
			WAR.Person[arg_32_0].特效文字3 = "防御状态"
		end

		if PersonKF(var_32_1, 101) then
			var_32_2 = var_32_2 + 1000
		else
			var_32_2 = var_32_2 + 500
		end
	end

	if (var_32_1 == 0 and WAR.LIURU == 0 or var_32_1 == JY.Base.队伍1 and JY.Base.畅想编号 > 0 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and PersonKF(var_32_1, 91) and JLSD(25, 75, var_32_1) or (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and PersonKF(var_32_1, 91) and JY.Base.主角职业 == 6 and JLSD(30, 60, var_32_1) and JY.Base.觉醒 == 1 and JY.Base.主角职业 ~= 10 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		local var_32_29 = 0
		local var_32_30 = JY.Wugong[91].名称
		local var_32_31 = 0

		for iter_32_4 = 1, 400 do
			if JY.Base["物品" .. iter_32_4] > 143 and JY.Base["物品" .. iter_32_4] < 158 then
				var_32_31 = var_32_31 + 1
			end
		end

		if JY.Base.二次觉醒 ~= 1 and JLSD(10, 60, var_32_0) then
			var_32_29 = math.random(3)
		else
			var_32_29 = math.random(4)
		end

		if (JY.Base.主角职业 == 6 or var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.二次觉醒 ~= 1 then
			var_32_29 = math.random(2) + 1
		end

		if var_32_29 == 3 and var_32_31 > 8 then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[2]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_30 .. FLHSYL[2]
			end

			WAR.FLHS2 = WAR.FLHS2 + 3
		elseif var_32_29 == 2 and var_32_31 > 9 then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[4]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_30 .. FLHSYL[4]
			end

			WAR.FLHS4 = 1
		elseif (JY.Base.主角职业 == 6 or math.random(10) < 5) and JY.Base.二次觉醒 == 1 then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[5]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_30 .. FLHSYL[5]
			end

			WAR.ACT = 10
			WAR.ZYHB = 0
			WAR.FLHS5 = 1
		end
	end

	if var_32_1 == 0 and WAR.LIURU > 0 and JY.Base.畅想编号 == 0 and JY.Base.主角职业 < 10 and JY.Base.觉醒 == 1 and PersonKF(var_32_1, 91) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		local var_32_32 = JY.Wugong[91].名称

		if JLSD(10, 40, var_32_1) or JY.Base.主角职业 == 6 and JLSD(10, 30, var_32_1) then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[2]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_32 .. FLHSYL[2]
			end

			WAR.FLHS2 = WAR.FLHS2 + 3
		end

		if JLSD(10, 40, var_32_1) or JY.Base.主角职业 == 6 and JLSD(10, 30, var_32_1) then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[4]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_32 .. FLHSYL[4]
			end

			WAR.FLHS4 = 1
		end

		if JY.Base.二次觉醒 == 1 and JLSD(10, 35, var_32_1) or JY.Base.主角职业 == 6 and JLSD(10, 30, var_32_1) then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. FLHSYL[5]
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_32 .. FLHSYL[5]
			end

			WAR.ACT = 10
			WAR.ZYHB = 0
			WAR.FLHS5 = 1
		end
	end

	if cxtd(var_32_1, 140) and JLSD(10, 80, var_32_1) or PersonKF(var_32_1, 47) and JLSD(10, 20, var_32_1) then
		WAR.Person[arg_32_0].特效动画 = 83

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "九剑特技·攻敌必救"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "攻敌必救"
		end

		WAR.ACT = 10
		WAR.ZYHB = 0
		WAR.GDZJ = 1
	end

	if T4RM(var_32_1) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 85

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "血戮天威护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "血戮天威护体"
		end

		var_32_2 = var_32_2 + 800
	end

	if cxtd(var_32_1, 9) and PersonKF(var_32_1, 106) and WAR.NGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = math.fmod(106, 10) + 85

		if WAR.Person[arg_32_0].特效文字2 == nil then
			-- Nothing
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "九阳神功护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 50) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 53

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "擒龙功护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "擒龙功护体"
		end

		var_32_2 = var_32_2 + 1500
	end

	if cxtd(var_32_1, 62) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 53

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "五轮映心护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "五轮映心护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 103) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = math.fmod(98, 10) + 85

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "小无相功护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "小无相功护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 18) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "混元霹雳功护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "混元霹雳功护体"
		end

		WAR.Person[arg_32_0].特效动画 = math.fmod(106, 10) + 85
		var_32_2 = var_32_2 + 1200
	end

	if cxtd(var_32_1, 13) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = math.fmod(106, 10) + 85

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "狮王金身护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "狮王金身护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 64) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 66

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "九阴神功护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "九阴神功护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 69) and WAR.NGHT == 0 and WAR.L_SGHT == 0 and WAR.ZDDH ~= 188 then
		WAR.Person[arg_32_0].特效动画 = 67

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "九阴真气护体"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "九阴真气护体"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 57) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 95

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "奇门奥义"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "奇门奥义"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 164) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 23

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "摩天居士"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "摩天居士"
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_1, 160) and WAR.NGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 23

		if WAR.Person[arg_32_0].特效文字2 == nil then
			-- Nothing
		end

		var_32_2 = var_32_2 + 1000
	end

	if cxtd(var_32_0, 592) then
		if WAR.L_DGQB_X < 3 then
			var_32_2 = var_32_2 + 200
		elseif WAR.L_DGQB_X < 5 then
			var_32_2 = var_32_2 + 400
		elseif WAR.L_DGQB_X < 7 then
			var_32_2 = var_32_2 + 600
		elseif WAR.L_DGQB_X < 9 then
			var_32_2 = var_32_2 + 800
		else
			var_32_2 = var_32_2 + 1000
		end
	end

	if cxtd(var_32_1, 26) and WAR.NGHT == 0 and WAR.L_SGHT == 0 then
		WAR.Person[arg_32_0].特效动画 = 6

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "日月·同辉"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "日月·同辉"
		end

		var_32_2 = var_32_2 + 1200
	end

	if PersonKF(var_32_1, 85) and JLSD(40, 85, var_32_1) or T1LEQ(var_32_1) and JLSD(40, 80, var_32_1) or cxtd(var_32_1, 53) and JLSD(10, 40, var_32_1) or cxtd(var_32_1, 118) and JLSD(20, 60, var_32_1) or cxtd(var_32_1, 116) or cxtd(var_32_1, 117) and JLSD(20, 60, var_32_1) or cxtd(var_32_1, 49) or cxtd(var_32_1, 115) and JLSD(10, 40, var_32_1) then
		if WAR.Person[arg_32_0].特效动画 == -1 then
			WAR.Person[arg_32_0].特效动画 = 85
		end

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "北冥真气"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "北冥真气"
		end

		var_32_2 = var_32_2 + 800
		WAR.B_BMJQ = 1
	end

	for iter_32_5 = 1, CC.Kungfunum do
		local var_32_33 = JY.Person[var_32_1]["武功" .. iter_32_5]

		if var_32_33 == 43 and JY.Person[var_32_1].体力 > 10 and WAR.Person[arg_32_0].反击武功 == -1 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (not JLSD(30, 70, var_32_1) or cxtd(var_32_1, 51) and (JLSD(20, 80, var_32_1) or WAR.HMXC > 0) or WAR.tmp[1000 + var_32_1] == 1 and JLSD(30, 70, var_32_1) or cxtd(var_32_1, 5061) and JLSD(30, 70, var_32_1) or cxtd(var_32_1, 113)) then
			local var_32_34 = JY.Person[var_32_1]
			local var_32_35 = var_32_34.拳掌功夫 + var_32_34.御剑能力 + var_32_34.耍刀技巧 + var_32_34.特殊兵器
			local var_32_36

			if cxtd(var_32_1, 51) and WAR.HMXC > 0 then
				var_32_36 = "幻梦星辰"
				WAR.DZXYLV[var_32_1] = 3
			elseif var_32_35 >= 300 or cxtd(var_32_1, 51) or cxtd(var_32_1, 113) then
				var_32_36 = "离合参商"
				WAR.DZXYLV[var_32_1] = 3
			elseif var_32_35 >= 220 then
				var_32_36 = "斗转星移"
				WAR.DZXYLV[var_32_1] = 2
			else
				var_32_36 = "北斗移辰"
				WAR.DZXYLV[var_32_1] = 1
			end

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. var_32_36
			else
				WAR.Person[arg_32_0].特效文字2 = var_32_36
			end

			if WAR.Person[arg_32_0].特效动画 == nil then
				WAR.Person[arg_32_0].特效动画 = math.fmod(var_32_33, 10) + 85
			end

			WAR.Person[arg_32_0].反击武功 = arg_32_1

			if cxtd(var_32_1, 113) then
				JY.Person[var_32_1].体力 = JY.Person[var_32_1].体力

				break
			end

			JY.Person[var_32_1].体力 = JY.Person[var_32_1].体力 - 2

			break
		end
	end

	if PersonKF(var_32_1, 91) and var_32_1 == JY.Base.队伍1 and JY.Person[var_32_1].体力 >= 10 and JY.Person[var_32_1].内力 >= 500 and WAR.ACT == 1 and WAR.RZWD == 0 and WAR.Person[arg_32_0].反击武功 == -1 and WAR.ZYHB ~= 2 and JY.Base.主角职业 == 6 and JLSD(10, 25, var_32_1) and JY.Base.二次觉醒 == 1 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[WAR.CurID].特效动画 = -1
		WAR.Person[WAR.CurID].特效文字0 = nil
		WAR.Person[WAR.CurID].特效文字1 = nil
		WAR.Person[WAR.CurID].特效文字2 = nil
		WAR.Person[WAR.CurID].特效文字3 = nil
		WAR.Person[arg_32_0].特效动画 = -1
		WAR.Person[arg_32_0].特效文字0 = nil
		WAR.Person[arg_32_0].特效文字1 = nil
		WAR.Person[arg_32_0].特效文字2 = nil
		WAR.Person[arg_32_0].特效文字3 = nil

		for iter_32_6 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_6].人物编号 == JY.Base.队伍1 then
				local var_32_37 = WAR.CurID

				WAR.ZYHB = 0
				WAR.BMXH = 0
				WAR.CurID = iter_32_6

				WarDrawMap(0)
				Cls()
				lib.LoadPNG(91, 10, 10, 10, 1)
				ShowScreen()
				lib.Delay(600)

				for iter_32_7 = 1, 10 do
					NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_7 * 2)
					ShowScreen()

					if iter_32_7 == 10 then
						Cls()
						NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_7 * 2)
						ShowScreen()
						lib.Delay(500)
					else
						lib.Delay(1)
					end
				end

				WAR.RZWD = 1

				War_Fight_Sub(iter_32_6, 2, WAR.Person[var_32_37].坐标X, WAR.Person[var_32_37].坐标Y)
				CleanWarMap(4, 0)

				WAR.BMXH = 0
				WAR.CurID = var_32_37
			end
		end
	end

	if PersonKF(var_32_1, 91) and var_32_1 == JY.Base.畅想编号 and JY.Person[var_32_1].体力 >= 10 and JY.Person[var_32_1].内力 >= 500 and WAR.ACT == 1 and WAR.RZWD == 0 and WAR.Person[arg_32_0].反击武功 == -1 and WAR.ZYHB ~= 2 and JY.Base.主角职业 == 6 and JLSD(10, 25, var_32_1) and JY.Base.二次觉醒 == 1 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[WAR.CurID].特效动画 = -1
		WAR.Person[WAR.CurID].特效文字0 = nil
		WAR.Person[WAR.CurID].特效文字1 = nil
		WAR.Person[WAR.CurID].特效文字2 = nil
		WAR.Person[WAR.CurID].特效文字3 = nil
		WAR.Person[arg_32_0].特效动画 = -1
		WAR.Person[arg_32_0].特效文字0 = nil
		WAR.Person[arg_32_0].特效文字1 = nil
		WAR.Person[arg_32_0].特效文字2 = nil
		WAR.Person[arg_32_0].特效文字3 = nil

		for iter_32_8 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_8].人物编号 == JY.Base.畅想编号 then
				local var_32_38 = WAR.CurID

				WAR.ZYHB = 0
				WAR.BMXH = 0
				WAR.CurID = iter_32_8

				WarDrawMap(0)
				Cls()
				lib.LoadPNG(91, 10, 10, 10, 1)
				ShowScreen()
				lib.Delay(600)

				for iter_32_9 = 1, 10 do
					NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_9 * 2)
					ShowScreen()

					if iter_32_9 == 10 then
						Cls()
						NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_9 * 2)
						ShowScreen()
						lib.Delay(500)
					else
						lib.Delay(1)
					end
				end

				WAR.RZWD = 1

				War_Fight_Sub(iter_32_8, 2, WAR.Person[var_32_38].坐标X, WAR.Person[var_32_38].坐标Y)
				CleanWarMap(4, 0)

				WAR.BMXH = 0
				WAR.CurID = var_32_38
			end
		end
	end

	if PersonKF(var_32_1, 91) and var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Person[var_32_1].体力 >= 10 and JY.Person[var_32_1].内力 >= 500 and WAR.ACT == 1 and WAR.RZWD == 0 and WAR.Person[arg_32_0].反击武功 == -1 and WAR.ZYHB ~= 2 and JY.Base.主角职业 == 6 and JLSD(10, 25, var_32_1) and JY.Base.二次觉醒 == 1 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[WAR.CurID].特效动画 = -1
		WAR.Person[WAR.CurID].特效文字0 = nil
		WAR.Person[WAR.CurID].特效文字1 = nil
		WAR.Person[WAR.CurID].特效文字2 = nil
		WAR.Person[WAR.CurID].特效文字3 = nil
		WAR.Person[arg_32_0].特效动画 = -1
		WAR.Person[arg_32_0].特效文字0 = nil
		WAR.Person[arg_32_0].特效文字1 = nil
		WAR.Person[arg_32_0].特效文字2 = nil
		WAR.Person[arg_32_0].特效文字3 = nil

		for iter_32_10 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_10].人物编号 == 9999 then
				local var_32_39 = WAR.CurID

				WAR.ZYHB = 0
				WAR.BMXH = 0
				WAR.CurID = iter_32_10

				WarDrawMap(0)
				Cls()
				lib.LoadPNG(91, 10, 10, 10, 1)
				ShowScreen()
				lib.Delay(600)

				for iter_32_11 = 1, 10 do
					NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_11 * 2)
					ShowScreen()

					if iter_32_11 == 10 then
						Cls()
						NewDrawString(-1, -1, ZJTF[6] .. TFSSJ[6], C_GOLD, CC.DefaultFont + iter_32_11 * 2)
						ShowScreen()
						lib.Delay(500)
					else
						lib.Delay(1)
					end
				end

				WAR.RZWD = 1

				War_Fight_Sub(iter_32_10, 2, WAR.Person[var_32_39].坐标X, WAR.Person[var_32_39].坐标Y)
				CleanWarMap(4, 0)

				WAR.BMXH = 0
				WAR.CurID = var_32_39
			end
		end
	end

	local var_32_40

	local function var_32_41(arg_34_0)
		if arg_34_0 <= 1 then
			return 0
		end

		return math.random(arg_34_0 * 0.5, arg_34_0)
	end

	local var_32_42 = WGWL(var_32_0, arg_32_1, arg_32_2)

	local function var_32_43(arg_35_0)
		return (JY.Person[arg_35_0].内力 * 2 + JY.Person[arg_35_0].内力最大值) / 3
	end

	if inteam(var_32_1) then
		var_32_40 = 10 + (JY.Person[var_32_0].攻击力 + var_32_43(var_32_0) / 50 + var_32_42) / 5
	else
		var_32_40 = 10 + (JY.Person[var_32_0].攻击力 + var_32_43(var_32_0) / 50 + var_32_42) / 5
	end

	local var_32_44 = JY.Person[var_32_0].攻击力
	local var_32_45 = JY.Person[var_32_1].防御力

	if JY.Status == GAME_WMAP then
		for iter_32_12, iter_32_13 in pairs(CC.AddAtk) do
			if iter_32_13[1] == var_32_0 then
				for iter_32_14 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_32_14].人物编号 == iter_32_13[2] and WAR.Person[iter_32_14].死亡 == false then
						var_32_44 = var_32_44 + iter_32_13[3]
					end
				end
			end
		end

		for iter_32_15, iter_32_16 in pairs(CC.AddDef) do
			if iter_32_16[1] == var_32_1 then
				for iter_32_17 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_32_17].人物编号 == iter_32_16[2] and WAR.Person[iter_32_17].死亡 == false then
						var_32_45 = var_32_45 + iter_32_16[3]
					end
				end
			end
		end
	end

	local var_32_46 = var_32_40 + var_32_5 + JY.Person[var_32_0].实战 / 4
	local var_32_47 = var_32_44 + var_32_43(var_32_0) / 50 + var_32_5 + arg_32_3 / 20
	local var_32_48 = var_32_45 + var_32_43(var_32_1) / 40 + var_32_6 + JY.Person[var_32_1].实战 / 4
	local var_32_49 = (var_32_46 * var_32_47 / (var_32_47 + var_32_48) - var_32_48 / 5) / 2 - var_32_2 / 30 + JY.Person[var_32_0].体力 / 5 - JY.Person[var_32_1].体力 / 5 + JY.Person[var_32_1].受伤程度 / 3 - JY.Person[var_32_0].受伤程度 / 3 + JY.Person[var_32_1].中毒程度 / 2 - JY.Person[var_32_0].中毒程度 / 2
	local var_32_50

	if instruct_16(var_32_0) then
		local var_32_51 = 1
	else
		var_32_49 = var_32_49 * 1.2 + 30

		local var_32_52

		var_32_52 = GetS(0, 0, 0, 0) ~= 1 and 1.5 or 2
	end

	if arg_32_1 ~= 28 and WAR.L_LZJF_ATK[var_32_0] ~= nil then
		var_32_47 = var_32_47 + WAR.L_LZJF_ATK[var_32_0]
		WAR.L_LZJF_ATK[var_32_0] = nil
	elseif WAR.L_LZJF_ATK[var_32_0] ~= nil then
		var_32_47 = var_32_47 + WAR.L_LZJF_ATK[var_32_0]
	end

	if instruct_16(var_32_0) then
		var_32_49 = var_32_49 + (var_32_5 - var_32_6) / 2
	else
		var_32_49 = var_32_49 + (var_32_5 - var_32_6) / 2
	end

	if JY.Person[var_32_0].武器 >= 0 then
		var_32_49 = var_32_49 + var_32_41(JY.Thing[JY.Person[var_32_0].武器].加攻击力)
	end

	if JY.Person[var_32_0].防具 >= 0 then
		var_32_49 = var_32_49 + var_32_41(JY.Thing[JY.Person[var_32_0].防具].加攻击力)
	end

	if JY.Person[var_32_1].武器 >= 0 then
		var_32_49 = var_32_49 - var_32_41(JY.Thing[JY.Person[var_32_1].武器].加防御力)
	end

	if JY.Person[var_32_1].防具 >= 0 then
		var_32_49 = var_32_49 - var_32_41(JY.Thing[JY.Person[var_32_1].防具].加防御力)
	end

	for iter_32_18, iter_32_19 in ipairs(CC.ExtraOffense) do
		if iter_32_19[1] == JY.Person[var_32_0].武器 and iter_32_19[2] == arg_32_1 then
			var_32_49 = var_32_49 + iter_32_19[3] / 4
		end
	end

	if arg_32_1 == 16 and WAR.tmp[3000 + var_32_0] ~= nil and WAR.tmp[3000 + var_32_0] > 0 then
		if WAR.tmp[3000 + var_32_0] > 200 then
			WAR.tmp[3000 + var_32_0] = 200
		end

		var_32_49 = var_32_49 + WAR.tmp[3000 + var_32_0]
		WAR.tmp[3000 + var_32_0] = 0
	end

	if cxtd(var_32_0, 106) and JY.Person[var_32_0].武器 == 47 then
		var_32_49 = var_32_49 + 80
	end

	if cxtd(var_32_0, 166) and yongjian(arg_32_1) then
		var_32_49 = var_32_49 + 250 - JY.Person[0].品德
	end

	if cxtd(var_32_0, 185) and (JY.Person[var_32_0].武器 > 35 and JY.Person[var_32_0].武器 < 43 or JY.Person[var_32_0].武器 == 55 or JY.Person[var_32_0].武器 == 236) then
		var_32_49 = var_32_49 + 30
	end

	if cxtd(var_32_0, 186) and yongquan(arg_32_1) then
		var_32_49 = var_32_49 + 50
	end

	if yongquan(arg_32_1) and cxtd(var_32_0, 182) then
		var_32_49 = var_32_49 + 50
	end

	if cxtd(var_32_0, 165) then
		local var_32_53 = JY.Person[var_32_0].特殊兵器

		if var_32_53 > 200 then
			var_32_53 = 200
		end

		var_32_49 = var_32_49 + var_32_53
	end

	if cxtd(var_32_0, 167) and arg_32_1 == 23 then
		var_32_49 = var_32_49 + WAR.ZYZ[var_32_0]
	end

	if cxtd(var_32_0, 141) and arg_32_1 == 34 then
		var_32_49 = var_32_49 + 100
	end

	if yongjian(arg_32_1) and cxtd(var_32_0, 7) then
		var_32_49 = math.modf(var_32_49 * 1.15)
	end

	if yongjian(arg_32_1) and (cxtd(var_32_0, 140) or cxtd(var_32_0, 141) or cxtd(var_32_0, 142)) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if cxtd(var_32_0, 137) and yongjian(arg_32_1) then
		var_32_49 = var_32_49 + 100
	end

	if instruct_16(var_32_0) and not yongan(arg_32_1) then
		local var_32_54 = math.abs(WAR.Person[WAR.CurID].坐标X - WAR.Person[arg_32_0].坐标X) + math.abs(WAR.Person[WAR.CurID].坐标Y - WAR.Person[arg_32_0].坐标Y)

		if var_32_54 < 10 then
			var_32_49 = var_32_49 * (100 - (var_32_54 - 1) * 3) / 100
		end
	else
		var_32_49 = var_32_49 * 2 / 3
	end

	if yongquan(arg_32_1) then
		local var_32_55 = math.abs(WAR.Person[WAR.CurID].坐标X - WAR.Person[arg_32_0].坐标X) + math.abs(WAR.Person[WAR.CurID].坐标Y - WAR.Person[arg_32_0].坐标Y)

		if var_32_55 > 2 then
			var_32_49 = math.modf(var_32_49 * 0.7)
			WAR.Person[arg_32_0].特效文字0 = "劲力消退30%"
		elseif var_32_55 < 2 then
			var_32_49 = math.modf(var_32_49 * 1.15)
			WAR.Person[arg_32_0].特效文字0 = "劲力凝聚15%"
		end
	end

	if yongjian(arg_32_1) then
		local var_32_56 = math.abs(WAR.Person[WAR.CurID].坐标X - WAR.Person[arg_32_0].坐标X) + math.abs(WAR.Person[WAR.CurID].坐标Y - WAR.Person[arg_32_0].坐标Y)

		if var_32_56 > 3 then
			var_32_49 = math.modf(var_32_49 * 0.85)
			WAR.Person[arg_32_0].特效文字0 = "劲力削弱15%"
		elseif WAR.JSYX == 1 then
			var_32_49 = math.modf(var_32_49 * 0.15)
			WAR.Person[arg_32_0].特效文字0 = "劲力削弱15%"
		elseif var_32_56 < 3 then
			var_32_49 = math.modf(var_32_49 * 1.15)
			WAR.Person[arg_32_0].特效文字0 = "劲力凝聚15%"
		end
	end

	if yongdao(arg_32_1) then
		local var_32_57 = math.abs(WAR.Person[WAR.CurID].坐标X - WAR.Person[arg_32_0].坐标X) + math.abs(WAR.Person[WAR.CurID].坐标Y - WAR.Person[arg_32_0].坐标Y)

		if var_32_57 > 3 then
			var_32_49 = math.modf(var_32_49 * 0.8)
			WAR.Person[arg_32_0].特效文字0 = "劲力消退20%"
		elseif var_32_57 < 3 then
			var_32_49 = math.modf(var_32_49 * 1.2)
			WAR.Person[arg_32_0].特效文字0 = "劲力凝聚15%"
		end
	end

	if yongte(arg_32_1) then
		local var_32_58 = math.abs(WAR.Person[WAR.CurID].坐标X - WAR.Person[arg_32_0].坐标X) + math.abs(WAR.Person[WAR.CurID].坐标Y - WAR.Person[arg_32_0].坐标Y)

		if var_32_58 > 4 then
			var_32_49 = math.modf(var_32_49 * 1.2)
			WAR.Person[arg_32_0].特效文字0 = "劲力凝聚20%"
		elseif var_32_58 < 4 then
			var_32_49 = math.modf(var_32_49 * 0.8)
			WAR.Person[arg_32_0].特效文字0 = "劲力消退20%"
		else
			var_32_49 = math.modf(var_32_49 * 1.1)
			WAR.Person[arg_32_0].特效文字0 = "劲力凝聚10%"
		end
	end

	if arg_32_1 == 64 and (var_32_0 == JY.Base.队伍1 or var_32_0 == JY.Base.畅想编号 or var_32_0 == 9999 and JY.Person[var_32_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 3 then
		var_32_49 = var_32_49 + math.modf(GetS(14, 3, 1, 4) / 10 + 1)
	end

	if WAR.BJ == 1 then
		local var_32_59 = 0

		for iter_32_20 = 1, CC.Kungfunum do
			if JY.Person[var_32_1]["武功" .. iter_32_20] == 106 or JY.Person[var_32_1]["武功" .. iter_32_20] == 107 then
				var_32_59 = var_32_59 + 1
			end
		end

		if JY.Person[var_32_1].内力性质 == 2 or true or true or (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5 then
			var_32_59 = var_32_59 + 1
		end

		if var_32_59 == 3 or T3XXM(var_32_1) and JY.Base.觉醒 == 1 or cxtd(var_32_1, 114) then
			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "森罗万象"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "森罗万象"
			end
		elseif (cxtd(var_32_0, 44) or cxtd(var_32_0, 98) or cxtd(var_32_0, 99) or cxtd(var_32_0, 100) or cxtd(var_32_0, 121) or cxtd(var_32_0, 126)) and WAR.BJ == 1 then
			var_32_49 = var_32_49 * 2
		elseif T4RM(var_32_0) and WAR.BJ == 1 then
			var_32_49 = math.modf(var_32_49 * 2)
		elseif cxtd(var_32_0, 61) and arg_32_1 == 9 then
			var_32_49 = math.modf(var_32_49 * 2)
		elseif cxtd(var_32_0, 67) and arg_32_1 == 13 and WAR.BJ == 1 then
			var_32_49 = math.modf(var_32_49 * 2)
		elseif (cxtd(var_32_0, 177) or cxtd(var_32_0, 178)) and WAR.BJ == 1 then
			var_32_49 = math.modf(var_32_49 * 2)
		elseif JY.Person[var_32_0].悟性 > 50 and JY.Person[var_32_0].悟性 < 80 and WAR.BJ == 1 then
			var_32_49 = math.modf(var_32_49 * 2)
		elseif JY.Person[var_32_0].主功体 == 104 and WAR.BJ == 1 then
			var_32_49 = math.modf(var_32_49 * 1.75)
		else
			var_32_49 = math.modf(var_32_49 * 1.5)
		end
	end

	if WAR.Actup[var_32_0] ~= nil and WAR.DZXY ~= 1 then
		if PersonKF(var_32_0, 103) then
			var_32_49 = math.modf(var_32_49 * 1.5)

			if cxtd(var_32_0, 62) then
				var_32_49 = math.modf(var_32_49 * 1.6)
			end
		elseif Curr_NG(var_32_0, 95) then
			var_32_49 = math.modf(var_32_49 * 1.5)

			if cxtd(var_32_0, 60) then
				var_32_49 = math.modf(var_32_49 * 1.6)
			end
		else
			var_32_49 = math.modf(var_32_49 * 1.25)
		end
	end

	local function var_32_60(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
		WAR.Person[arg_32_0].特效动画 = arg_36_0

		if WAR.Person[arg_32_0][arg_36_1] == nil then
			WAR.Person[arg_32_0][arg_36_1] = arg_36_2
		else
			WAR.Person[arg_32_0][arg_36_1] = arg_36_2 .. "+" .. WAR.Person[arg_32_0][arg_36_1]
		end

		var_32_2 = var_32_2 + arg_36_3
		var_32_49 = math.modf(var_32_49 - arg_36_4)

		if var_32_49 < 0 then
			var_32_49 = 0
		end
	end

	if WAR.NGJL >= 0 then
		local var_32_61 = 0

		for iter_32_21 = 1, CC.Kungfunum do
			if (JY.Person[var_32_0]["武功" .. iter_32_21] <= 86 and JY.Person[var_32_0]["武功" .. iter_32_21] >= 1 or JY.Person[var_32_0]["武功" .. iter_32_21] <= 198 and JY.Person[var_32_0]["武功" .. iter_32_21] >= 144) and JY.Person[var_32_0]["武功等级" .. iter_32_21] >= 900 then
				var_32_61 = var_32_61 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 + 0.04 * var_32_61))
	end

	if WAR.L_NSDF[var_32_1] ~= nil then
		var_32_49 = var_32_49 * 2
		arg_32_3 = arg_32_3 * 2
		WAR.L_NSDF[var_32_1] = nil
	end

	if WAR.L_NSDFCC == 1 and var_32_4() then
		WAR.L_NSDF[var_32_1] = 1
	end

	if arg_32_1 == 65 and WAR.NGJL > 0 then
		var_32_49 = var_32_49 + math.modf(JY.Wugong[WAR.NGJL].攻击力10 / 10)
	end

	if (cxtd(var_32_0, 149) or cxtd(var_32_0, 169)) and WAR.NGJL > 0 then
		var_32_49 = var_32_49 + math.modf(JY.Wugong[WAR.NGJL].攻击力10 / 10)

		if WAR.L_SGJL > 0 then
			var_32_49 = var_32_49 + math.modf(JY.Wugong[WAR.NGJL].攻击力10 / 20)
		end
	end

	if T4RM(var_32_0) and WAR.NGJL > 0 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if cxtd(var_32_0, 135) and WAR.NGJL > 0 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if WAR.NGJL == 103 or WAR.NGJL == 110 or WAR.NGJL == 112 or WAR.NGJL == 114 then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if WAR.NGJL == 103 or WAR.NGJL == 110 or WAR.NGJL == 112 or WAR.NGJL == 114 then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_1, 5094) and WAR.NGHT > 0 then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if cxtd(var_32_1, 118) then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_1, 159) then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if cxtd(var_32_1, 113) then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if WAR.ZDDH == 14 and (var_32_0 == 173 or var_32_0 == 174 or var_32_0 == 175) or WAR.ZDDH == 15 then
		local var_32_62 = 0

		for iter_32_22 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_22].死亡 == false and WAR.Person[iter_32_22].我方 == WAR.Person[WAR.CurID].我方 and WAR.Person[WAR.CurID].我方 == false then
				var_32_62 = var_32_62 + 1
			end
		end

		if var_32_62 >= 3 then
			var_32_49 = math.modf(var_32_49 * 1.5)
			arg_32_3 = arg_32_3 + 1000
		end
	end

	if WAR.ZDDH == 14 and (var_32_1 == 173 or var_32_1 == 174 or var_32_1 == 175) or WAR.ZDDH == 15 then
		local var_32_63 = 0

		for iter_32_23 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_23].死亡 == false and WAR.Person[iter_32_23].我方 == WAR.Person[arg_32_0].我方 and WAR.Person[arg_32_0].我方 == false then
				var_32_63 = var_32_63 + 1
			end
		end

		if var_32_63 >= 3 then
			var_32_49 = math.modf(var_32_49 * 0.5)
			var_32_2 = var_32_2 + 1000
		end
	end

	if WAR.ZDDH == 73 or WAR.ZDDH == 279 or WAR.ZDDH == 545 then
		local var_32_64 = 0

		for iter_32_24 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_24].死亡 == false and WAR.Person[iter_32_24].我方 == WAR.Person[WAR.CurID].我方 and WAR.Person[WAR.CurID].我方 == false then
				var_32_64 = var_32_64 + 1
			end
		end

		for iter_32_25 = 1, var_32_64 do
			var_32_49 = math.modf(var_32_49 * 1.05)
			arg_32_3 = arg_32_3 + 100
		end
	end

	if WAR.ZDDH == 73 or WAR.ZDDH == 279 or WAR.ZDDH == 545 then
		local var_32_65 = 0

		for iter_32_26 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_26].死亡 == false and WAR.Person[iter_32_26].我方 == WAR.Person[arg_32_0].我方 and WAR.Person[arg_32_0].我方 == false then
				var_32_65 = var_32_65 + 1
			end
		end

		for iter_32_27 = 1, var_32_65 do
			var_32_49 = math.modf(var_32_49 * 0.95)
			var_32_2 = var_32_2 + 100
		end
	end

	if WAR.ZDDH > 498 and WAR.ZDDH < 505 or WAR.ZDDH == 277 then
		local var_32_66 = 0

		for iter_32_28 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_28].死亡 == false and WAR.Person[iter_32_28].我方 == WAR.Person[WAR.CurID].我方 and WAR.Person[WAR.CurID].我方 == false then
				var_32_66 = var_32_66 + 1
			end
		end

		for iter_32_29 = 1, var_32_66 do
			JY.Wugong[176].名称 = "大漠铁锤"
			var_32_49 = var_32_49 + 40
			arg_32_3 = arg_32_3 + 100
		end
	end

	if WAR.ZDDH > 498 and WAR.ZDDH < 505 or WAR.ZDDH == 277 then
		local var_32_67 = 0

		for iter_32_30 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_30].死亡 == false and WAR.Person[iter_32_30].我方 == WAR.Person[arg_32_0].我方 and WAR.Person[arg_32_0].我方 == false then
				var_32_67 = var_32_67 + 1
			end
		end

		for iter_32_31 = 1, var_32_67 do
			var_32_2 = var_32_2 + 500
		end
	end

	if WAR.ZDDH == 545 then
		local var_32_68 = 0

		for iter_32_32 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_32].死亡 == false and WAR.Person[iter_32_32].我方 == WAR.Person[WAR.CurID].我方 and WAR.Person[WAR.CurID].我方 == false then
				var_32_68 = var_32_68 + 1
			end
		end

		for iter_32_33 = 1, var_32_68 do
			var_32_49 = var_32_49 + 36
			arg_32_3 = arg_32_3 + 100
		end
	end

	local var_32_69 = 0
	local var_32_70 = JY.Wugong[arg_32_1].武功类型
	local var_32_71 = 1
	local var_32_72 = 1
	local var_32_73 = 0

	if cxtd(var_32_0, 140) or cxtd(var_32_0, 592) then
		var_32_70 = 2
	end

	if cxtd(var_32_1, 140) or cxtd(var_32_1, 592) then
		var_32_70 = 2
	end

	if var_32_70 == 1 or var_32_70 == 6 then
		local var_32_74 = JY.Person[var_32_0].拳掌功夫 * var_32_71
		local var_32_75 = JY.Person[var_32_1].拳掌功夫 * var_32_72

		var_32_73 = JY.Person[var_32_1].拳掌功夫 * var_32_72
		var_32_69 = var_32_74 - var_32_75
	elseif var_32_70 == 2 then
		local var_32_76 = JY.Person[var_32_0].御剑能力 * var_32_71
		local var_32_77 = JY.Person[var_32_1].御剑能力 * var_32_72

		var_32_73 = JY.Person[var_32_1].御剑能力 * var_32_72
		var_32_69 = var_32_76 - var_32_77
	elseif var_32_70 == 3 then
		local var_32_78 = JY.Person[var_32_0].耍刀技巧 * var_32_71
		local var_32_79 = JY.Person[var_32_1].耍刀技巧 * var_32_72

		var_32_73 = JY.Person[var_32_1].耍刀技巧 * var_32_72
		var_32_69 = var_32_78 - var_32_79
	elseif var_32_70 == 4 then
		local var_32_80 = JY.Person[var_32_0].特殊兵器 * var_32_71
		local var_32_81 = JY.Person[var_32_1].特殊兵器 * var_32_72

		var_32_73 = JY.Person[var_32_1].特殊兵器 * var_32_72
		var_32_69 = var_32_80 - var_32_81
	elseif var_32_70 == 7 then
		local var_32_82 = JY.Person[var_32_0].暗器技巧 * var_32_71
		local var_32_83 = JY.Person[var_32_1].暗器技巧 * var_32_72

		var_32_73 = JY.Person[var_32_1].暗器技巧 * var_32_72
		var_32_69 = var_32_82 - var_32_83
	end

	local var_32_84 = (var_32_69 + math.random(10)) / 20
	local var_32_85

	if WAR.JSTG > 0 and var_32_84 < 0 and JY.Base.二次觉醒 == 1 then
		var_32_84 = 10
		var_32_85 = "遇强则强"
	end

	if Curr_NG(var_32_0, 98) and var_32_84 < 0 then
		var_32_84 = 10
		var_32_85 = "无我无相"
	end

	if var_32_84 >= 10 then
		var_32_85 = "本系优势·伤害加深" .. math.modf(var_32_84) .. "%"
	elseif var_32_84 <= -10 then
		var_32_85 = "本系劣势·伤害减少" .. math.modf(-var_32_84) .. "%"
	end

	if not inteam(var_32_0) then
		var_32_49 = math.modf(var_32_49 - var_32_73 / 10)
	end

	var_32_49 = math.modf(var_32_49 * (1 + var_32_84 / 100))

	if var_32_84 >= 10 then
		if WAR.Person[arg_32_0].特效动画 == nil or WAR.Person[arg_32_0].特效动画 == -1 then
			WAR.Person[arg_32_0].特效动画 = 63
		end

		Set_Eff_Text(arg_32_0, "特效文字0", var_32_85)
	elseif var_32_84 <= -10 then
		if WAR.Person[arg_32_0].特效动画 == nil or WAR.Person[arg_32_0].特效动画 == -1 then
			WAR.Person[arg_32_0].特效动画 = 63
		end

		Set_Eff_Text(arg_32_0, "特效文字3", var_32_85)
	end

	if arg_32_1 == 195 then
		var_32_49 = 1
	end

	if not cxtd(var_32_1, 128) and WAR.Dodge ~= 1 and ((WAR.ACT == 1 and WAR.JZPZ[var_32_1] or 0) > 1 or PersonKF(var_32_0, 93) or var_32_0 == 20 or JY.Person[var_32_0].主功体 == 93 and JLSD(10, 50, var_32_0) or JLSD(15, 30, var_32_0) and PersonKF(var_32_0, 20) and arg_32_1 == 4 or WAR.XSZJ == 3 or cxtd(var_32_0, 150) and JLSD(10, 40, var_32_0) and WAR.ACT == 1 or cxtd(var_32_0, 27) and JLSD(10, 40, var_32_0) and WAR.ACT == 1) then
		if cxtd(var_32_0, 188) or cxtd(var_32_1, 183) then
			var_32_49 = math.modf(var_32_49 * 3)
			WAR.JZPZXS = 1
			WAR.Person[arg_32_0].特效文字1 = "击中破绽"
			WAR.Person[arg_32_0].特效动画 = 63
		else
			var_32_49 = math.modf(var_32_49 * 1.5)
			WAR.JZPZXS = 1

			if WAR.Person[arg_32_0].特效文字1 ~= nil then
				WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "击中破绽"
			else
				WAR.Person[arg_32_0].特效文字1 = "击中破绽"
			end

			WAR.Person[arg_32_0].特效动画 = 63
		end
	end

	if arg_32_1 == 47 and JLSD(10, 40, var_32_0) then
		var_32_49 = math.modf(var_32_49 * 1.5)
		WAR.JZPZXS = 1

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "击中破绽"
		else
			WAR.Person[arg_32_0].特效文字1 = "击中破绽"
		end

		WAR.Person[arg_32_0].特效动画 = 63
	end

	if PersonKF(var_32_1, 86) and PersonKF(var_32_1, 24) and PersonKF(var_32_1, 108) and JLSD(10, 50, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.7)

		var_32_60(78, "特效文字3", "物我两忘·除却四相", 800, 0)
	end

	if (WAR.HOT[var_32_0] or 0) >= 30 and (WAR.ICE[var_32_0] or 0) >= 30 then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if cxtd(var_32_0, 77) and arg_32_1 == 54 and WAR.LQZ[var_32_0] == 100 then
		var_32_49 = math.modf(var_32_49 * 1.4)
	end

	if JY.Person[var_32_0].主功体 == 107 and JY.Person[var_32_0].内力性质 == 0 and (WAR.ICE[var_32_1] or 0) > 5 then
		var_32_49 = math.modf(var_32_49 * 1.15)
	end

	if (WAR.HOT[var_32_1] or 0) > 0 then
		-- Nothing
	elseif (WAR.HOT[var_32_1] or 0) > 60 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	elseif cxtd(var_32_1, 118) then
		var_32_49 = math.modf(var_32_49 * 1)
	else
		var_32_49 = math.modf(var_32_49 * 1.15)
	end

	if cxtd(var_32_0, 126) and (WAR.HOT[var_32_0] or 0) > 0 then
		var_32_49 = math.modf(var_32_49 * (1 + WAR.HOT[var_32_0] / 200))
	end

	if cxtd(var_32_0, 151) and JY.Person[var_32_0].轻功 - 100 > JY.Person[var_32_1].轻功 then
		WAR.XSZJ = 8

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "霹雳奔雷"
		else
			WAR.Person[arg_32_0].特效文字1 = "霹雳奔雷"
		end
	end

	local var_32_86 = 0

	if not instruct_16(var_32_0) and JY.Person[var_32_0].畅想级别 > 4 and JY.Person[var_32_0].畅想级别 < 100 then
		var_32_86 = JY.Base.游戏难度 * JY.Person[var_32_0].畅想级别 / 5
	end

	local var_32_87 = 0
	local var_32_88 = (JY.Person[var_32_0].武学常识 - JY.Person[var_32_1].武学常识) / 20
	local var_32_89 = 0
	local var_32_90 = (JY.Person[var_32_0].实战 - JY.Person[var_32_1].实战) / 100
	local var_32_91 = 0
	local var_32_92 = math.modf(var_32_86 + var_32_88 + var_32_90)

	if var_32_92 < 0 then
		var_32_92 = 0
	end

	if (JY.Person[var_32_0].畅想级别 > 4 or JY.Person[var_32_1].防御力 < JY.Person[var_32_0].攻击力 - 150 or JY.Person[var_32_1].武学常识 < JY.Person[var_32_0].武学常识 or JY.Person[var_32_1].实战 < JY.Person[var_32_0].实战 or cxtd(var_32_0, 179)) and JLSD(10, 15 + var_32_92, var_32_0) or cxtd(var_32_0, 187) and JLSD(10, 70, var_32_0) or WAR.JZPZXS == 1 and cxtd(var_32_0, 178) or WAR.XSZJ == 4 or WAR.XSZJ == 8 then
		var_32_49 = math.modf(var_32_49 * 1.2)
		arg_32_3 = math.modf(arg_32_3 * 1.2)

		if cxtd(var_32_0, 178) then
			var_32_49 = math.modf(var_32_49 * 1.2)
		end

		if WAR.ZYZ[var_32_0] < 150 then
			WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + 2

			if T1LEQ(var_32_0) then
				WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + 2
			end
		end

		if WAR.ZYZ[var_32_0] > 50 then
			WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] - 2
		end

		if cxtd(var_32_0, 81) then
			WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] - 2
		end

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "攻击破招"
		else
			WAR.Person[arg_32_0].特效文字2 = "攻击破招"
		end

		WAR.Person[arg_32_0].特效动画 = 97
	end

	if cxtd(var_32_0, 169) then
		WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] - 5
	end

	if JY.Person[var_32_0].主功体 == 110 and arg_32_1 == 26 then
		WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] + 2
	end

	if arg_32_1 == 57 then
		WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] - 2
	end

	if cxtd(var_32_0, 184) and yongjian(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if arg_32_1 == 23 and (cxtd(var_32_0, 8) or cxtd(var_32_0, 167) or cxtd(var_32_0, 168)) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if (cxtd(var_32_0, 166) or cxtd(var_32_0, 8)) and arg_32_1 == 37 then
		var_32_49 = math.modf(var_32_49 * 1.5)
	end

	if WAR.XSZJ == 6 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if WAR.XSZJ == 7 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 597) and arg_32_1 == 69 then
		var_32_49 = math.modf(var_32_49 * (2 + math.random(100) / 100))
	end

	if cxtd(var_32_0, 133) and arg_32_1 == 53 then
		var_32_49 = math.modf(var_32_49 * (2 + math.random(100) / 100))
	end

	if cxtd(var_32_0, 137) and arg_32_1 == 167 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if arg_32_1 == 49 then
		local var_32_93 = JY.Person[var_32_0].内力 / 20000

		var_32_49 = var_32_49 + math.modf(var_32_49 * var_32_93)
	end

	if cxtd(var_32_0, 136) and yongjian(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if cxtd(var_32_0, 131) and WAR.L_NOT_MOVE[var_32_1] == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if JY.Person[var_32_0].主功体 == 105 and arg_32_1 == 48 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if JY.Person[var_32_0].主功体 == 106 and (WAR.HOT[var_32_1] or 0) > 0 then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if JY.Person[var_32_0].主功体 == 97 and WAR.DZXY == 1 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if arg_32_1 == 24 and JY.Person[var_32_0].主功体 == 96 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if arg_32_1 == 16 and JY.Person[var_32_0].主功体 == 99 then
		var_32_49 = math.modf(var_32_49 * 1.15)
	end

	if arg_32_1 == 22 and JY.Person[var_32_0].主功体 == 108 then
		var_32_49 = math.modf(var_32_49 * 1.25)
	end

	if arg_32_1 == 42 and JY.Person[var_32_0].主功体 == 111 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if JY.Person[var_32_0].主功体 == 104 and arg_32_1 == 83 then
		WAR.XDHFJQ = 1
	end

	if JY.Person[var_32_0].主功体 == 108 and arg_32_1 == 65 then
		WAR.XDHFJQ = 1
	end

	if JY.Person[var_32_0].主功体 == 113 and arg_32_1 == 46 then
		WAR.XDHFJQ = 1
	end

	if JY.Person[var_32_0].主功体 == 89 and arg_32_1 == 34 then
		WAR.XDHFJQ = 1
	end

	if cxtd(var_32_0, 452) and JLSD(10, 50, var_32_0) then
		var_32_49 = math.modf(var_32_49 * 1.35)

		if WAR.Person[var_32_0].特效文字2 ~= nil then
			WAR.Person[var_32_0].特效文字2 = WAR.Person[var_32_0].特效文字2 .. "+" .. "辽东鹤"
		else
			WAR.Person[var_32_0].特效文字2 = "辽东鹤"
		end
	end

	if cxtd(var_32_0, 185) and (yongjian(arg_32_1) or yongquan(arg_32_1)) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if JY.Person[var_32_0].内力性质 == 2 then
		if WAR.L_SGJL == 108 and JY.Person[var_32_0].悟性 < 80 then
			var_32_49 = math.modf(var_32_49 * 1.2)
		else
			var_32_49 = math.modf(var_32_49 * 0.8)
		end
	end

	if PersonKF(var_32_0, 104) and WAR.BJ == 1 and WAR.ZYZ[var_32_0] < 150 then
		WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + 1

		if T1LEQ(var_32_0) then
			WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + 1
		end
	end

	if cxtd(var_32_0, 136) then
		for iter_32_34 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_34].人物编号 == 55 and WAR.Person[iter_32_34].死亡 == false and WAR.Person[iter_32_34].我方 == WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 1.5)

				break
			end
		end
	end

	if (WAR.HOT[var_32_1] or 0) > 70 and (WAR.BMXH == 1 or WAR.BMXH1 == 1 or JY.Person[var_32_1].主功体 == 112) then
		WAR.HOT[var_32_1] = math.modf(WAR.HOT[var_32_1] / 2)

		if WAR.HOT[var_32_0] == nil then
			WAR.HOT[var_32_0] = WAR.HOT[var_32_1]
		else
			WAR.HOT[var_32_0] = WAR.HOT[var_32_0] + WAR.HOT[var_32_1]
		end

		if WAR.HOT[var_32_0] > 100 then
			WAR.HOT[var_32_0] = 100
		end
	end

	if (WAR.ICE[var_32_1] or 0) > 70 and (WAR.BMXH == 1 or WAR.BMXH1 == 1) then
		WAR.ICE[var_32_1] = math.modf(WAR.ICE[var_32_1] / 2)

		if WAR.ICE[var_32_0] == nil then
			WAR.ICE[var_32_0] = WAR.ICE[var_32_1]
		else
			WAR.ICE[var_32_0] = WAR.ICE[var_32_0] + WAR.ICE[var_32_1]
		end

		if WAR.ICE[var_32_0] > 100 then
			WAR.ICE[var_32_0] = 100
		end
	end

	if cxtd(var_32_1, 22) then
		if WAR.ICE[var_32_0] == nil then
			WAR.ICE[var_32_0] = 10
		else
			WAR.ICE[var_32_0] = WAR.ICE[var_32_0] + 10
		end
	end

	if cxtd(var_32_1, 440) then
		if WAR.HOT[var_32_0] == nil then
			WAR.HOT[var_32_0] = 10
		else
			WAR.HOT[var_32_0] = WAR.HOT[var_32_0] + 10
		end
	end

	if cxtd(var_32_1, 83) or cxtd(var_32_1, 190) then
		if JY.Person[var_32_0].中毒程度 == nil then
			JY.Person[var_32_0].中毒程度 = 20
		else
			JY.Person[var_32_0].中毒程度 = JY.Person[var_32_0].中毒程度 + 20
		end
	end

	if var_32_1 == 0 and JY.Base.主角职业 == 8 then
		local var_32_94 = JY.Person[var_32_1].中毒程度 / 5

		if var_32_94 > 30 then
			var_32_94 = 30
		end

		JY.Person[var_32_0].中毒程度 = JY.Person[var_32_0].中毒程度 + var_32_94
	end

	if JY.Person[var_32_0].拳掌功夫 >= 320 and yongquan(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 3) and yongjian(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if JY.Person[var_32_0].御剑能力 >= 320 and yongjian(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if JY.Person[var_32_0].耍刀技巧 >= 320 and yongdao(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if JY.Person[var_32_0].特殊兵器 >= 320 and yongte(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 119) then
		arg_32_3 = math.modf(arg_32_3 * 1.5)
	end

	if JY.Person[var_32_0].拳掌功夫 > 259 and yongquan(arg_32_1) then
		arg_32_3 = math.modf(arg_32_3 * 1.3)
	end

	local var_32_95 = JY.Wugong[arg_32_1].迟缓 * JY.Wugong[arg_32_1].武功等级

	if var_32_95 < 0 then
		var_32_95 = 0
	end

	if var_32_49 > 0 and var_32_95 > 0 then
		WAR.JTXS[var_32_1] = 1
		WAR.JTZ[var_32_1] = var_32_95
		arg_32_3 = arg_32_3 + var_32_95
	end

	if var_32_0 == 0 and JY.Base.主角职业 == 5 and yongnei(arg_32_1) then
		arg_32_3 = math.modf(arg_32_3 * 1.1)
	end

	if cxtd(var_32_0, 5046) and yongte(arg_32_1) then
		arg_32_3 = math.modf(arg_32_3 * 1.2)
	end

	if JY.Person[var_32_0].特殊兵器 > 259 and yongte(arg_32_1) then
		arg_32_3 = math.modf(arg_32_3 * 1.3)
	end

	if cxtd(var_32_0, 5048) and yongte(arg_32_1) then
		arg_32_3 = math.modf(arg_32_3 * 1.4)
	end

	if WAR.NGHT >= 0 then
		local var_32_96 = wgnumber(var_32_1, 5)

		var_32_49 = math.modf(var_32_49 * (1 - 0.02 * var_32_96))
	end

	if cxtd(var_32_1, 5032) then
		local var_32_97 = wgnumber(var_32_1, 5)

		var_32_49 = math.modf(var_32_49 * (1 - 0.03 * var_32_97))
	end

	if yongnei(arg_32_1) then
		arg_32_3 = arg_32_3 + 25 * wgnumber(var_32_0, 5)
	end

	if cxtd(var_32_0, 48) and yongnei(arg_32_1) then
		arg_32_3 = arg_32_3 + 50 * wgnumber(var_32_0, 5)
	end

	if Curr_NG(var_32_0, 102) and WAR.L_SGJL == 102 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[arg_32_0].我方 then
		WAR.L_TXSG[var_32_1] = 1
	end

	if (not cxtd(var_32_0, 15) and not cxtd(var_32_0, 32) and not cxtd(var_32_0, 65) and not cxtd(var_32_0, 98) and not cxtd(var_32_0, 113) and not cxtd(var_32_0, 138) or not JLSD(20, 80, var_32_0)) and (not cxtd(var_32_0, 613) and not cxtd(var_32_0, 614) and not cxtd(var_32_0, 615) or arg_32_1 ~= 82 or not JLSD(20, 40, var_32_0)) and WAR.JLJJB ~= 1 or WAR.Person[WAR.CurID].我方 == WAR.Person[arg_32_0].我方 or WAR.Dodge == 1 then
		-- Nothing
	else
		WAR.L_NOT_MOVE[var_32_1] = 1

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·定身"
		else
			WAR.Person[arg_32_0].特效文字2 = "定身"
		end
	end

	if cxtd(var_32_0, 613) or cxtd(var_32_0, 614) or cxtd(var_32_0, 615) and arg_32_1 == 82 then
		var_32_2 = var_32_2 + 1000
	end

	if WAR.NGJL == 96 then
		local var_32_98 = 1.1 + JY.Person[var_32_0].内力 / 10000 * (JY.Wugong[arg_32_1].消耗内力点数 / 200)

		if cxtd(var_32_0, 38) then
			var_32_98 = var_32_98 * 1.2
			arg_32_3 = math.modf(arg_32_3 * var_32_98)
			var_32_49 = math.modf(var_32_49 * var_32_98)
		else
			arg_32_3 = math.modf(arg_32_3 * var_32_98)
			var_32_49 = math.modf(var_32_49 * var_32_98)
		end
	end

	if WAR.NGHT == 95 then
		if WAR.tmp[200 + var_32_1] == nil or WAR.tmp[200 + var_32_1] == 0 then
			WAR.tmp[200 + var_32_1] = 50
		else
			WAR.tmp[200 + var_32_1] = WAR.tmp[200 + var_32_1] + 35
		end

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·蛤蟆蓄力"
		else
			WAR.Person[arg_32_0].特效文字2 = "蛤蟆蓄力"
		end

		var_32_2 = var_32_2 + 800
	elseif PersonKF(var_32_1, 95) or cxtd(var_32_1, 60) then
		if WAR.tmp[200 + var_32_1] == nil or WAR.tmp[200 + var_32_1] == 0 then
			WAR.tmp[200 + var_32_1] = 50
		else
			WAR.tmp[200 + var_32_1] = WAR.tmp[200 + var_32_1] + 35
		end

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·蛤蟆蓄力"
		else
			WAR.Person[arg_32_0].特效文字2 = "蛤蟆蓄力"
		end

		var_32_2 = var_32_2 + 800
	end

	if Curr_NG(var_32_1, 113) and JLSD(20, 80, var_32_1) then
		WAR.TJZX[var_32_1] = (WAR.TJZX[var_32_1] or 0) + 1

		if WAR.TJZX[var_32_1] > 10 then
			WAR.TJZX[var_32_1] = 10
		end

		Set_Eff_Text(arg_32_0, "特效文字3", "太极之形")
	end

	if cxtd(var_32_1, 125) then
		var_32_2 = var_32_2 + 500

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "三花聚顶"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "三花聚顶"
			WAR.Person[arg_32_0].特效动画 = 88
		end
	end

	if Curr_NG(var_32_1, 107) and WAR.L_SGJL == 107 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	elseif WAR.L_SGJL == 107 then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if arg_32_1 == 64 and JY.Person[var_32_0].耍刀技巧 >= 180 then
		WAR.Defup[var_32_0] = 1
	end

	if JY.Person[var_32_0].主功体 == 101 and PersonKF(var_32_0, 108) and JLSD(25, 55, var_32_0) then
		WAR.Defup[var_32_0] = 1
	end

	if cxtd(var_32_0, 0) and arg_32_1 == 171 and JY.Person[var_32_0].耍刀技巧 >= 180 and JLSD(25, 75, var_32_0) then
		WAR.Defup[var_32_0] = 1

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "游刃有余"
		else
			WAR.Person[arg_32_0].特效文字3 = "游刃有余"
		end
	end

	if cxtd(var_32_0, 181) and arg_32_1 == 37 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if WAR.Actup[var_32_1] ~= nil and PersonKF(var_32_1, 103) then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if Curr_NG(var_32_1, 98) then
		var_32_49 = math.modf(var_32_49 * 0.9)
		arg_32_3 = math.modf(arg_32_3 * 0.7)
	elseif PersonKF(var_32_1, 98) then
		arg_32_3 = math.modf(arg_32_3 * 0.9)
	end

	local var_32_99 = 0

	if inteam(var_32_0) then
		var_32_99 = math.modf(math.random(5) + var_32_47 / 7) + math.modf(var_32_42 / 15)
	else
		var_32_99 = math.modf(math.random(20) + var_32_47 / 6) + math.modf(var_32_42 / 13)
	end

	if not inteam(var_32_0) then
		var_32_99 = math.modf(var_32_99 * 1.2)
	end

	if var_32_49 < var_32_99 then
		var_32_49 = var_32_99
	end

	local var_32_100 = 1

	if inteam(var_32_0) then
		-- Nothing
	end

	var_32_49 = math.modf(var_32_49 * 0.7 * var_32_100)
	var_32_49 = math.modf(var_32_49 * (1 - JY.Person[var_32_1].防御力 / 3000))
	var_32_49 = math.modf(var_32_49 * (1 + (wgj_num(var_32_0) - wgj_num(var_32_1)) * 0.04))

	if WAR.Actup[var_32_1] ~= nil and (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 1 then
		local var_32_101 = 0

		for iter_32_35 = 1, CC.Kungfunum do
			if JY.Wugong[JY.Person[0]["武功" .. iter_32_35]].武功类型 == 1 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_35] == 999 then
				var_32_101 = var_32_101 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 - 0.05 * var_32_101))
		arg_32_3 = math.modf(arg_32_3 * (1 - 0.1 * var_32_101))

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "真拳气功护体"
		else
			WAR.Person[arg_32_0].特效文字2 = "真拳气功护体"
		end
	end

	if var_32_49 > 0 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].内力 > 1000 then
		if JY.Person[var_32_1].主功体 == 101 and JLSD(30, 80, var_32_1) or cxtd(var_32_1, 117) then
			var_32_49 = math.modf(2 * var_32_49 / 3)

			if WAR.B_BMJQ == 1 then
				WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) + math.modf(var_32_49 / 3)

				AddPersonAttrib(var_32_1, "内力", math.modf(var_32_49 / 3))
			else
				WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) - var_32_49

				AddPersonAttrib(var_32_1, "内力", -var_32_49)
			end

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "八荒六合.唯我独尊"
			else
				WAR.Person[arg_32_0].特效文字2 = "八荒六合.唯我独尊"
			end
		elseif WAR.NGHT == 101 or PersonKF(var_32_1, 101) and JLSD(20, 70, var_32_1) or cxtd(var_32_1, 117) then
			var_32_49 = math.modf(2 * var_32_49 / 3)
			WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) - 2 * var_32_49

			AddPersonAttrib(var_32_1, "内力", -2 * var_32_49)

			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "天长地久.不老长春"
			else
				WAR.Person[arg_32_0].特效文字2 = "天长地久.不老长春"
			end
		end
	end

	if WAR.NGHT == 106 then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_1, 102) and JLSD(40, 70, var_32_1) and JY.Person[var_32_1].内力 > 1000 then
		var_32_49 = math.modf(var_32_49 / 10)
		WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) - 10 * var_32_49

		AddPersonAttrib(var_32_1, "内力", -10 * var_32_49)

		if WAR.Person[arg_32_0].特效文字3 == nil then
			WAR.Person[arg_32_0].特效文字3 = "一枯一荣"
		else
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "一枯一荣"
			WAR.Person[arg_32_0].特效动画 = 89
		end
	end

	if cxtd(var_32_0, 592) then
		if WAR.L_DGQB_X < 8 then
			var_32_49 = math.modf(var_32_49 * (WAR.L_DGQB_X / 5))
		else
			var_32_49 = math.modf(var_32_49 * (1 + WAR.L_DGQB_X / 10))
		end
	end

	if arg_32_1 == 23 and JY.Person[var_32_1].受伤程度 > 0 then
		if cxtd(var_32_0, 8) or cxtd(var_32_0, 167) or cxtd(var_32_0, 168) or JY.Person[var_32_0].拳掌功夫 >= 180 then
			var_32_49 = var_32_49 + math.modf(JY.Person[var_32_1].受伤程度 * 2)
		else
			var_32_49 = var_32_49 + math.modf(JY.Person[var_32_1].受伤程度 * 3 / 2)
		end

		if JY.Person[var_32_0].内力 < 4000 and JLSD(0, math.modf(4000 - JY.Person[var_32_0].内力)) and not cxtd(var_32_0, 8) and JY.Person[var_32_0].拳掌功夫 < 220 then
			AddPersonAttrib(var_32_0, "受伤程度", 15)
		end
	end

	if (WAR.NGHT == 97 or JY.Person[var_32_1].主功体 == 97 and JLSD(30, 80, var_32_1)) and WAR.RZWD == 0 and not cxtd(var_32_0, 135) then
		WAR.fthurt = 0

		local var_32_102 = {}
		local var_32_103 = 1

		for iter_32_36 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_36].我方 ~= WAR.Person[arg_32_0].我方 and WAR.Person[iter_32_36].死亡 == false then
				var_32_102[var_32_103] = iter_32_36
				var_32_103 = var_32_103 + 1
			end
		end

		local var_32_104 = var_32_102[math.random(var_32_103 - 1)]
		local var_32_105 = var_32_102[math.random(var_32_103 - 1)]
		local var_32_106 = 30 - limitX(math.modf((JY.Person[var_32_1].内力 - JY.Person[WAR.Person[var_32_104].人物编号].内力) / 100), 0, 30)
		local var_32_107 = 0

		if (var_32_106 > math.random(80) or WAR.L_QKDNY[WAR.Person[var_32_104].人物编号] ~= nil or (cxtd(var_32_1, 11) or cxtd(var_32_1, 173) or cxtd(var_32_1, 174) or cxtd(var_32_1, 175)) and JLSD(20, 60, var_32_1)) and not cxtd(var_32_1, 9) then
			if WAR.Person[var_32_104].特效动画 == -1 then
				WAR.Person[var_32_104].特效动画 = 85
			end

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "借力消力"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "借力消力"
			end
		else
			if not instruct_16(var_32_1) and not ybdw(var_32_1) then
				WAR.fthurt = math.modf(var_32_49 * 0.1)
			elseif JY.Person[var_32_1].主功体 == 97 then
				WAR.fthurt = math.modf(var_32_49 * 0.2)
			elseif cxtd(var_32_1, 9) then
				WAR.fthurt = math.modf(var_32_49 * 0.3)
			elseif cxtd(var_32_1, 173) or cxtd(var_32_1, 174) or cxtd(var_32_1, 175) or cxtd(var_32_1, 15) or cxtd(var_32_1, 66) or PersonKF(var_32_1, 43) then
				WAR.fthurt = math.modf(var_32_49 * 0.3)
			else
				WAR.fthurt = math.modf(var_32_49 * 0.1)
			end

			var_32_107 = math.modf(WAR.fthurt / 2 + Rnd(3))

			SetWarMap(WAR.Person[var_32_104].坐标X, WAR.Person[var_32_104].坐标Y, 4, 2)

			WAR.L_QKDNY[WAR.Person[var_32_104].人物编号] = 1
		end

		WAR.Person[var_32_104].生命点数 = (WAR.Person[var_32_104].生命点数 or 0) - var_32_107
		JY.Person[WAR.Person[var_32_104].人物编号].生命 = JY.Person[WAR.Person[var_32_104].人物编号].生命 - var_32_107

		if JY.Person[WAR.Person[var_32_104].人物编号].生命 < 1 then
			JY.Person[WAR.Person[var_32_104].人物编号].生命 = 10
		end

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "反弹"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "反弹"
		end

		if cxtd(var_32_1, 9) and var_32_104 ~= var_32_105 then
			WAR.Person[var_32_105].生命点数 = (WAR.Person[var_32_105].生命点数 or 0) - var_32_107
			JY.Person[WAR.Person[var_32_105].人物编号].生命 = JY.Person[WAR.Person[var_32_105].人物编号].生命 - var_32_107

			if JY.Person[WAR.Person[var_32_105].人物编号].生命 < 1 then
				JY.Person[WAR.Person[var_32_105].人物编号].生命 = 1
			end

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "双"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "双"
			end

			SetWarMap(WAR.Person[var_32_105].坐标X, WAR.Person[var_32_105].坐标Y, 4, 2)
		end
	end

	if cxtd(var_32_1, 159) and JLSD(40, 80, var_32_1) then
		if WAR.FQYY[var_32_1] == nil then
			WAR.FQYY[var_32_1] = 0
		end

		WAR.FQYY[var_32_1] = WAR.FQYY[var_32_1] + 2

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "鬼影崇崇"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "鬼影崇崇"
		end

		WAR.Person[arg_32_0].特效动画 = math.fmod(105, 10) + 85
	end

	if cxtd(var_32_1, 29) and JLSD(40, 80, var_32_1) then
		if WAR.FQYY[var_32_1] == nil then
			WAR.FQYY[var_32_1] = 0
		end

		WAR.FQYY[var_32_1] = WAR.FQYY[var_32_1] + 2

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "风起云涌"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "风起云涌"
		end

		WAR.Person[arg_32_0].特效动画 = math.fmod(105, 10) + 85
	end

	if cxtd(var_32_1, 591) and JLSD(10, 50, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.75)

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "无行浪子"
		else
			WAR.Person[arg_32_0].特效文字2 = "无行浪子"
		end
	end

	if (cxtd(var_32_1, 149) or cxtd(var_32_1, 169) or cxtd(var_32_1, 170) or cxtd(var_32_1, 251) or cxtd(var_32_1, 252)) and JLSD(10, 35, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.8)

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "金钟罩"
		else
			WAR.Person[arg_32_0].特效文字2 = "金钟罩"
		end
	end

	for iter_32_37 = 1, CC.Kungfunum do
		if (JY.Person[var_32_1]["武功" .. iter_32_37] == 16 or JY.Person[var_32_1]["武功" .. iter_32_37] == 46) and JY.Person[var_32_1]["武功等级" .. iter_32_37] == 999 then
			WAR.TJAY = WAR.TJAY + 1
		end
	end

	if WAR.TJAY == 2 and (JLSD(15, 55 + math.modf(JY.Person[var_32_1].悟性 / 2.5), var_32_1) or cxtd(var_32_1, 5) and JLSD(25, 85, var_32_1) or cxtd(var_32_1, 171) and JLSD(5, 85, var_32_1) or cxtd(var_32_1, 172) and JLSD(5, 85, var_32_1) or cxtd(var_32_1, 82) and JLSD(15, 65 + math.modf(JY.Person[var_32_1].悟性 / 2.5), var_32_1)) then
		WAR.TJSQ = 1

		if WAR.Person[arg_32_0].特效文字2 ~= nil and WAR.Person[arg_32_0].特效文字2 ~= " " then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "太极奥义"
		else
			WAR.Person[arg_32_0].特效文字2 = "太极奥义--四两拨千斤"
		end

		WAR.Person[arg_32_0].特效动画 = 101

		if cxtd(var_32_1, 5) and JLSD(10, 90, var_32_1) then
			WAR.Person[arg_32_0].特效文字3 = "无根无形"
			WAR.Person[arg_32_0].特效动画 = 101
			var_32_49 = math.modf(var_32_49 * 0.5)
		end
	end

	if cxtd(var_32_0, 114) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_1, 114) then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if cxtd(var_32_1, 114) and JLSD(10, 70, var_32_1) then
		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·无形气墙"
		else
			WAR.Person[arg_32_0].特效文字2 = "无形气墙"
		end

		if var_32_49 > 100 then
			var_32_49 = var_32_49 - 100
		end
	end

	if cxtd(var_32_0, 50) then
		var_32_49 = math.modf(var_32_49 * 1.5)
	end

	if cxtd(var_32_1, 50) then
		var_32_49 = math.modf(var_32_49 * 0.9)

		local var_32_108 = JY.Person[var_32_1].生命 / JY.Person[var_32_1].生命最大值

		var_32_49 = math.modf(var_32_49 * var_32_108)

		if var_32_49 < 30 then
			var_32_49 = 30
		end
	end

	if cxtd(var_32_1, 595) and yongte(arg_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if WAR.WYY == var_32_0 then
		var_32_49 = math.modf(var_32_49 * 0.7)
		arg_32_3 = math.modf(arg_32_3 * 0.7)
	end

	if cxtd(var_32_1, 163) then
		var_32_49 = math.modf(var_32_49 * (1 - math.random(300) / 400))
	end

	if cxtd(var_32_0, 151) and JY.Person[var_32_0].生命 <= JY.Person[var_32_0].生命最大值 / 2 then
		var_32_49 = math.modf(var_32_49 * 1.5)
	end

	if cxtd(var_32_0, 118) then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if cxtd(var_32_0, 184) then
		var_32_49 = math.modf(var_32_49 * 1.15)
	end

	if cxtd(var_32_0, 41) and JY.Person[var_32_1].内力性质 == 0 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 42) and JY.Person[var_32_1].内力性质 == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 69) and arg_32_1 == 26 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if cxtd(var_32_0, 106) and arg_32_1 == 59 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if cxtd(var_32_0, 516) and arg_32_1 == 187 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if cxtd(var_32_0, 98) and arg_32_1 == 17 then
		var_32_49 = math.modf(var_32_49 * 1.5)
	end

	if cxtd(var_32_0, 65) and arg_32_1 == 17 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if cxtd(var_32_0, 95) and arg_32_1 == 36 then
		var_32_49 = math.modf(var_32_49 * 2 + 50)
	end

	local var_32_109 = math.random(679, 689)

	if cxtd(var_32_0, var_32_109) then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if WAR.HSWLB == 1 then
		var_32_49 = math.modf(var_32_49 * 1.5)
	end

	if cxtd(var_32_1, 78) then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_0, 70) then
		local var_32_110 = (JY.Person[var_32_0].生命最大值 - JY.Person[var_32_0].生命) / JY.Person[var_32_0].生命最大值

		var_32_49 = math.modf(var_32_49 * (1 + var_32_110))
	end

	if cxtd(var_32_0, 61) then
		if JY.Person[var_32_1].性别 == 1 then
			var_32_49 = math.modf(var_32_49 * 0.8)
		else
			var_32_49 = math.modf(var_32_49 * 1.2)
		end
	end

	if cxtd(var_32_1, 82) and JY.Person[var_32_0].性别 == 1 then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if cxtd(var_32_1, 591) and JY.Person[var_32_0].性别 == 1 then
		var_32_49 = math.modf(var_32_49 * 0.6)
	end

	if cxtd(var_32_0, 161) or cxtd(var_32_0, 633) and JY.Person[var_32_1].性别 == 0 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_1, 139) then
		if JY.Person[var_32_0].性别 == 0 then
			var_32_49 = math.modf(var_32_49 * 1.2)
		else
			var_32_49 = math.modf(var_32_49 * 0.8)
		end
	end

	if cxtd(var_32_0, 100) and JY.Person[var_32_1].性别 == 1 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	else
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if WAR.PDJN == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 181) and JY.Person[0].品德 < 40 then
		local var_32_111 = 40 - JY.Person[0].品德

		if var_32_111 > 30 then
			var_32_111 = 30
		end

		var_32_49 = math.modf(var_32_49 * ((100 + var_32_111) / 100))
	end

	if cxtd(var_32_1, 181) and JY.Person[0].品德 > 60 then
		local var_32_112 = JY.Person[0].品德 - 60

		if var_32_112 > 40 then
			var_32_112 = 40
		end

		var_32_49 = math.modf(var_32_49 * ((100 - var_32_112) / 100))
	end

	if (cxtd(var_32_0, 68) or cxtd(var_32_0, 123) or cxtd(var_32_0, 124) or cxtd(var_32_0, 125) or cxtd(var_32_0, 126) or cxtd(var_32_0, 127) or cxtd(var_32_0, 128)) and arg_32_1 == 39 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 189) then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if cxtd(var_32_1, 189) then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_0, 179) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_1, 179) and JY.Base.觉醒 == 0 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if WAR.LQZ[var_32_0] == 100 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if WAR.LQZ[var_32_1] == 100 and not cxtd(var_32_1, 128) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if PersonKF(var_32_1, 14) and PersonKF(var_32_1, 98) and JY.Person[var_32_0].拳掌功夫 >= 170 and JLSD(10, 50, var_32_1) or cxtd(var_32_1, 118) and JLSD(10, 70, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.75)

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "见招拆招"
		else
			WAR.Person[arg_32_0].特效文字2 = "见招拆招"
		end
	end

	if cxtd(var_32_1, 176) and JLSD(10, 50, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.75)
		arg_32_3 = math.modf(arg_32_3 / 2)

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "红颜易改爱难消"
		else
			WAR.Person[arg_32_0].特效文字3 = "红颜易改爱难消"
		end
	end

	if cxtd(var_32_1, 132) and JLSD(10, 75, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.85)
		WAR.Actup[var_32_1] = 1

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "三眼马王神"
		else
			WAR.Person[arg_32_0].特效文字2 = "三眼马王神"
		end
	end

	if cxtd(var_32_1, 134) and JLSD(10, 65, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.7)
		WAR.XSZJ = 9

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "铁布衫"
		else
			WAR.Person[arg_32_0].特效文字2 = "铁布衫"
		end
	end

	if PersonKF(var_32_1, 37) and PersonKF(var_32_1, 60) and JLSD(10, 40, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.9)
		arg_32_3 = math.modf(arg_32_3 * 0.9)

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "两仪守护"
		else
			WAR.Person[arg_32_0].特效文字2 = "两仪守护"
		end

		WAR.Person[arg_32_0].特效动画 = 21
	end

	local var_32_113 = 0

	if not instruct_16(var_32_1) and JY.Person[var_32_1].畅想级别 > 4 and JY.Person[var_32_1].畅想级别 < 100 then
		var_32_113 = JY.Base.游戏难度 * JY.Person[var_32_1].畅想级别 / 4
	end

	local var_32_114 = 0

	if JY.Person[var_32_1].防御力 - 100 > JY.Person[var_32_0].攻击力 then
		var_32_114 = 5
	end

	local var_32_115 = 0
	local var_32_116 = JY.Person[var_32_1].武学常识 / 20
	local var_32_117 = 0
	local var_32_118 = JY.Person[var_32_1].实战 / 200
	local var_32_119 = 0
	local var_32_120 = math.modf(var_32_113 + var_32_114 + var_32_116 + var_32_118)
	local var_32_121 = var_32_113 / 100

	if var_32_121 > 0.5 then
		var_32_121 = 0.5
	end

	if (JY.Person[var_32_1].畅想级别 > 4 or JY.Person[var_32_1].防御力 - 100 > JY.Person[var_32_0].攻击力 or JY.Person[var_32_1].武学常识 > JY.Person[var_32_0].武学常识 or JY.Person[var_32_1].实战 > JY.Person[var_32_0].实战 or cxtd(var_32_1, 179)) and not cxtd(var_32_1, 114) and JLSD(10, 15 + var_32_120, var_32_1) or WAR.JZPZXS == 1 and cxtd(var_32_1, 177) and var_32_49 > 0 then
		var_32_49 = math.modf(var_32_49 * (0.7 - var_32_121))

		if var_32_49 < 10 then
			var_32_49 = 10
		end

		if cxtd(var_32_1, 177) then
			var_32_49 = math.modf(var_32_49 * 0.7)
		end

		if WAR.L_ZXSG == 2 then
			var_32_49 = math.modf(var_32_49 * 1.1)
		end

		if cxtd(var_32_1, 29) and WAR.L_TBGZL == 2 then
			if WAR.Person[arg_32_0].特效文字2 ~= nil then
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·不可不戒"
			else
				WAR.Person[arg_32_0].特效文字2 = "不可不戒"
			end

			var_32_49 = math.modf(var_32_49 * 0.8)
			var_32_2 = var_32_2 + 600
		end

		if cxtd(var_32_0, 138) and JLSD(25, 95, var_32_0) then
			AddPersonAttrib(var_32_1, "中毒程度", 30)

			WAR.Person[WAR.CurID].特效文字3 = RWWH[138]
		end

		if WAR.BSMT == 1 then
			var_32_49 = math.modf(var_32_49 + 100 + math.random(50))
		end

		if WAR.DZXYLV[var_32_0] ~= nil and WAR.DZXYLV[var_32_0] > 10 then
			var_32_49 = math.modf(var_32_49 * WAR.DZXYLV[var_32_0] / 100)
			arg_32_3 = arg_32_3 + WAR.DZXYLV[var_32_0] * 10
		end

		if WAR.tmp[1000 + var_32_0] == 1 and instruct_16(var_32_0) then
			var_32_49 = math.modf(var_32_49 * 1.35)
		end

		if WAR.tmp[1000 + var_32_1] == 1 and instruct_16(var_32_1) then
			var_32_49 = math.modf(var_32_49 * 0.7)
		end

		var_32_49 = math.modf(var_32_49)

		if instruct_16(var_32_0) then
			if cxtd(var_32_0, 71) or cxtd(var_32_0, 127) then
				var_32_49 = math.modf(var_32_49 * (1 + JY.Person[var_32_0].受伤程度 * 0.003))
			else
				var_32_49 = math.modf(var_32_49 * (1 - JY.Person[var_32_0].受伤程度 * 0.003))
			end
		end

		if instruct_16(var_32_1) then
			if cxtd(var_32_1, 71) or cxtd(var_32_1, 127) then
				var_32_49 = math.modf(var_32_49 * (1 - JY.Person[var_32_0].受伤程度 * 0.003))
			else
				var_32_49 = math.modf(var_32_49 * (1 + JY.Person[var_32_0].受伤程度 * 0.003))
			end
		end

		if instruct_16(var_32_0) then
			if var_32_0 == 0 and JY.Base.主角职业 == 8 and JY.Base.二次觉醒 == 1 then
				var_32_49 = math.modf(var_32_49 * (1 + JY.Person[var_32_0].中毒程度 * 0.003))
			else
				var_32_49 = math.modf(var_32_49 * (1 - JY.Person[var_32_0].中毒程度 * 0.003))
			end
		end

		if instruct_16(var_32_1) then
			var_32_49 = math.modf(var_32_49 * (1 + JY.Person[var_32_0].中毒程度 * 0.003))
		end

		if cxtd(var_32_0, 5) and WAR.ZDDH > 220 then
			var_32_49 = math.modf(var_32_49 * 1.1)
		end

		if WAR.ZSF2 == 1 then
			var_32_49 = math.modf(var_32_49 * 1.3)
		end

		if WAR.HDWZ == 1 then
			var_32_49 = math.modf(var_32_49 + 50)
			JY.Person[var_32_1].中毒程度 = JY.Person[var_32_1].中毒程度 + 15

			if JY.Person[var_32_1].中毒程度 > 100 then
				JY.Person[var_32_1].中毒程度 = 100
			end
		end

		if WAR.LMC == 1 then
			var_32_49 = math.modf(var_32_49 + 70)
			JY.Person[var_32_1].中毒程度 = JY.Person[var_32_1].中毒程度 + 30

			if JY.Person[var_32_1].中毒程度 > 100 then
				JY.Person[var_32_1].中毒程度 = 100
			end
		end

		if (cxtd(var_32_1, 35) and GetS(10, 1, 1, 0) == 1 and JLSD(15, 85, var_32_1) or cxtd(var_32_1, 140) or arg_32_1 == 47 and JY.Person[var_32_0].御剑能力 >= 260 and JLSD(20, 70, var_32_0)) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
			if JY.Wugong[arg_32_1].武功类型 == 1 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破掌式"
			elseif JY.Wugong[arg_32_1].武功类型 == 2 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破剑式"
			elseif JY.Wugong[arg_32_1].武功类型 == 3 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破刀式"
			elseif JY.Wugong[arg_32_1].武功类型 == 4 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破棍式"
			elseif JY.Wugong[arg_32_1].武功类型 == 5 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破气式"
			elseif JY.Wugong[arg_32_1].武功类型 == 7 then
				WAR.Person[arg_32_0].特效文字3 = "秘传·破暗式"
			end

			WAR.Person[arg_32_0].特效动画 = 83
			var_32_49 = math.modf(var_32_49 * (4 + math.random(3)) / 10)
			var_32_2 = var_32_2 + 1300
		end

		if WAR.JIUPO == 1 and cxtd(var_32_1, 35) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
			var_32_49 = math.modf(var_32_49 * 0.5)
			WAR.Person[arg_32_0].特效动画 = 83

			if JY.Wugong[arg_32_1].武功类型 == 1 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破掌式"
			elseif JY.Wugong[arg_32_1].武功类型 == 2 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破剑式"
			elseif JY.Wugong[arg_32_1].武功类型 == 3 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破刀式"
			elseif JY.Wugong[arg_32_1].武功类型 == 4 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破棍式"
			elseif JY.Wugong[arg_32_1].武功类型 == 5 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破气式"
			elseif JY.Wugong[arg_32_1].武功类型 == 7 then
				WAR.Person[arg_32_0].特效文字3 = "九剑秘传·真破暗式"
			end
		end

		if cxtd(var_32_0, 136) and yongjian(arg_32_1) then
			var_32_49 = var_32_49 + math.modf(JY.Wugong[arg_32_1].攻击力10 / 10)
		end

		if cxtd(var_32_0, 129) and arg_32_1 == 39 then
			var_32_49 = math.modf(var_32_49 * 2 + 20)
		end

		if cxtd(var_32_0, 4) then
			var_32_49 = var_32_49 + 30
		end

		if cxtd(var_32_0, 160) then
			var_32_49 = var_32_49 + 50

			if JY.Person[var_32_0].武器 == 50 then
				var_32_49 = var_32_49 + 50
			end
		end

		if cxtd(var_32_0, 150) then
			var_32_49 = var_32_49 + math.modf(JY.Person[var_32_0].内力 / 50)
		end

		if cxtd(var_32_0, 598) and arg_32_1 == 63 then
			var_32_49 = var_32_49 + 25

			if JY.Person[var_32_0].武器 == 44 then
				var_32_49 = var_32_49 + 25
			end
		end

		if WAR.WPXJF == 1 then
			var_32_49 = var_32_49 + 50
		end

		if (cxtd(var_32_0, 31) or cxtd(var_32_0, 32) or cxtd(var_32_0, 33) or cxtd(var_32_0, 34)) and (arg_32_1 == 38 or arg_32_1 == 71 or arg_32_1 == 72 or arg_32_1 == 73 or arg_32_1 == 81 or arg_32_1 == 84) then
			var_32_49 = var_32_49 + 50
		end

		if WAR.NGJL == 111 and JY.Person[var_32_0].性别 == 1 then
			var_32_49 = var_32_49 + 100
		end

		if WAR.ZYZ[var_32_0] < 150 then
			WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] + 2

			if T1LEQ(var_32_1) then
				WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] + 2
			end
		end

		if WAR.ZYZ[var_32_0] > 50 then
			WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] - 2
		end

		if cxtd(var_32_1, 81) then
			WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] - 2
		end

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "攻击格挡"
		else
			WAR.Person[arg_32_0].特效文字2 = "攻击格挡"
		end

		WAR.Person[arg_32_0].特效动画 = 96
	end

	if var_32_0 == 133 then
		WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + 2
	end

	if JY.Person[var_32_0].主功体 == 96 and arg_32_1 == 1 then
		var_32_49 = var_32_49 + 50
	end

	if WAR.DMLHSXJ == 1 then
		var_32_49 = var_32_49 + 60
	end

	if PersonKF(var_32_0, 50) and yongdao(arg_32_1) then
		var_32_49 = var_32_49 + 30
	end

	if PersonKF(var_32_0, 1) and yongquan(arg_32_1) then
		var_32_49 = var_32_49 + 30
	end

	if PersonKF(var_32_0, 48) and yongjian(arg_32_1) then
		var_32_49 = var_32_49 + 30
	end

	if cxtd(var_32_0, 122) then
		var_32_49 = var_32_49 + 36
	end

	if WAR.LHQ_BNZ == 1 then
		var_32_49 = var_32_49 + 50
	end

	if WAR.JGZ_DMZ == 1 then
		var_32_49 = var_32_49 + 100
	end

	if WAR.ZTSLYZ == 1 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if cxtd(var_32_0, 138) then
		var_32_49 = var_32_49 + 50
	end

	if WAR.ZDDH == 205 and var_32_0 == 141 then
		var_32_49 = 10
	end

	if WAR.L_MJJF == 1 then
		var_32_49 = var_32_49 + 50

		if JY.Person[var_32_0].武器 == 37 then
			var_32_49 = var_32_49 + 50
		end
	end

	if cxtd(var_32_1, 13) then
		var_32_49 = math.modf(var_32_49 * 0.6)
	end

	if cxtd(var_32_0, 37) and JY.Person[37].品德 > 70 then
		local var_32_122 = math.modf((JY.Person[37].品德 - 70) / 200)

		if var_32_122 > 0.5 then
			var_32_122 = 0.5
		end

		var_32_49 = math.modf(var_32_49 * (1 + var_32_122))
	end

	if cxtd(var_32_1, 44) or cxtd(var_32_1, 94) then
		var_32_49 = math.modf(var_32_49 - (200 - JY.Person[44].品德) / 4)

		if var_32_49 < 10 then
			var_32_49 = 10
		end
	end

	if cxtd(var_32_0, 98) or cxtd(var_32_0, 99) or cxtd(var_32_0, 100) or cxtd(var_32_0, 44) then
		var_32_49 = math.modf(var_32_49 + var_32_49 * (JY.Person[var_32_1].品德 - JY.Person[var_32_0].品德) / 200)
	end

	if cxtd(var_32_0, 63) and JY.Person[var_32_0].生命 < math.modf(JY.Person[var_32_0].生命最大值 / 2) then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 39) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if cxtd(var_32_1, 40) then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if JY.Person[var_32_0].生命 == 1 and WAR.ACT == 1 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if WAR.DJGZ == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if WAR.XSZJ == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if WAR.XSZJ == 5 then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if WAR.TYWF == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if not instruct_16(var_32_1) then
		for iter_32_38 = 0, WAR.PersonNum - 1 do
			if (WAR.Person[iter_32_38].人物编号 == 87 or WAR.Person[iter_32_38].人物编号 == 0 and JY.Base.畅想编号 == 87 or WAR.Person[iter_32_38].人物编号 == 74 or WAR.Person[iter_32_38].人物编号 == 0 and JY.Base.畅想编号 == 74) and WAR.Person[iter_32_38].死亡 == false and WAR.Person[iter_32_38].我方 ~= WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 0.8)
			end
		end
	end

	if not instruct_16(var_32_1) then
		for iter_32_39 = 0, WAR.PersonNum - 1 do
			if (WAR.Person[iter_32_39].人物编号 == 15 or WAR.Person[iter_32_39].人物编号 == 0 and JY.Base.畅想编号 == 15) and WAR.Person[iter_32_39].死亡 == false and WAR.Person[iter_32_39].我方 ~= WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 0.8)
			end
		end
	end

	if cxtd(var_32_1, 15) then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if not instruct_16(var_32_1) then
		for iter_32_40 = 0, WAR.PersonNum - 1 do
			if (WAR.Person[iter_32_40].人物编号 == 587 or WAR.Person[iter_32_40].人物编号 == 0 and JY.Base.畅想编号 == 587) and WAR.Person[iter_32_40].死亡 == false and WAR.Person[iter_32_40].我方 ~= WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 0.95)
			end
		end
	end

	if cxtd(var_32_1, 587) then
		var_32_49 = math.modf(var_32_49 * 0.95)
	end

	if cxtd(var_32_1, 87) or cxtd(var_32_1, 74) then
		var_32_49 = math.modf(var_32_49 * 0.8)
	end

	if not instruct_16(var_32_1) then
		for iter_32_41 = 0, WAR.PersonNum - 1 do
			if cxtd(var_32_0, 5073) and WAR.Person[iter_32_41].死亡 == false and WAR.Person[iter_32_41].我方 ~= WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 0.9)
			end
		end
	end

	if cxtd(var_32_1, 5073) then
		var_32_49 = math.modf(var_32_49 * 0.9)
	end

	if cxtd(var_32_1, 158) and JY.Person[var_32_1].武器 == 51 then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if (cxtd(var_32_1, 184) or cxtd(var_32_1, 54)) and JLSD(40, 80, var_32_1) then
		var_32_49 = math.modf(var_32_49 / 2)
		arg_32_3 = math.modf(arg_32_3 / 2)

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "神行百变"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "神行百变"
		end

		WAR.Person[arg_32_0].特效动画 = 87
	end

	if (cxtd(var_32_1, 174) or cxtd(var_32_1, 175) or cxtd(var_32_1, 173)) and JLSD(30, 80, var_32_1) then
		var_32_49 = math.modf(var_32_49 / 2)
		WAR.XSZJ = 2

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "乾坤圣火令"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "乾坤圣火令"
		end

		WAR.Person[arg_32_0].特效动画 = 85
	end

	if WAR.MCF == 1 then
		var_32_49 = math.modf(var_32_49 * 2)
	end

	if WAR.TFH == 1 then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if WAR.WQQ == 1 then
		var_32_49 = math.modf(var_32_49 * (1 + math.random(200) / 100))
	end

	if WAR.DBS == 1 then
		var_32_49 = math.modf(var_32_49 * (1 + math.random(200) / 100))
	end

	if cxtd(var_32_0, 83) and arg_32_1 == 3 then
		var_32_49 = math.modf(var_32_49 * (1 + math.random(200) / 100))
	end

	if cxtd(var_32_0, 64) then
		var_32_49 = math.modf(var_32_49 * (1 + WAR.ZBT / 10))
	end

	if cxtd(var_32_0, 5095) then
		if WAR.tmp[var_32_0 + 10000] == nil then
			WAR.tmp[var_32_0 + 10000] = 0
		end

		local var_32_123 = WAR.tmp[var_32_0 + 10000]

		var_32_49 = math.modf(var_32_49 * (1 + var_32_123 / 20))
	end

	if WAR.LXZQ == 1 then
		var_32_49 = math.modf(var_32_49 * 1.3)
	end

	if cxtd(var_32_0, 82) then
		local var_32_124 = 0

		for iter_32_42 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_42].死亡 == false and WAR.Person[iter_32_42].我方 == WAR.Person[WAR.CurID].我方 and JY.Person[WAR.Person[iter_32_42].人物编号].性别 == 1 then
				var_32_124 = var_32_124 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 + var_32_124 / 10))
	end

	if JY.Base.主角职业 == 1 and (var_32_0 == JY.Base.队伍1 or var_32_0 == JY.Base.畅想编号 or var_32_0 == 9999 and JY.Person[var_32_0].姓名 == JY.Person[JY.Base.队伍1].姓名) then
		local var_32_125 = 0

		for iter_32_43 = 1, CC.Kungfunum do
			if JY.Wugong[JY.Person[0]["武功" .. iter_32_43]].武功类型 == 1 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_43] == 999 then
				var_32_125 = var_32_125 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 + 0.03 * var_32_125))
	end

	if JY.Base.主角职业 == 3 and (var_32_0 == JY.Base.队伍1 or var_32_0 == JY.Base.畅想编号 or GetS(87, 31, 35, 5) == 1 and JY.Person[var_32_0].姓名 == JY.Person[JY.Base.队伍1].姓名) then
		local var_32_126 = 0

		for iter_32_44 = 1, CC.Kungfunum do
			if JY.Wugong[JY.Person[0]["武功" .. iter_32_44]].武功类型 == 3 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_44] == 999 then
				var_32_126 = var_32_126 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 + 0.05 * var_32_126))
	end

	if JY.Base.主角职业 == 3 and (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or GetS(87, 31, 35, 5) == 1 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) then
		local var_32_127 = 0

		for iter_32_45 = 1, CC.Kungfunum do
			if JY.Wugong[JY.Person[0]["武功" .. iter_32_45]].武功类型 == 3 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_45] == 999 then
				var_32_127 = var_32_127 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 - 0.02 * var_32_127))

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if WAR.ZDDH == 118 and not cxtd(var_32_0, 5) or cxtd(var_32_0, 79) then
		local var_32_128 = 0

		for iter_32_46 = 1, CC.Kungfunum do
			if yongjian(arg_32_1) and JY.Person[79]["武功等级" .. iter_32_46] == 999 then
				var_32_128 = var_32_128 + 1
			end
		end

		var_32_49 = math.modf(var_32_49 * (1 + 0.1 * var_32_128))
	end

	if instruct_16(var_32_0) then
		for iter_32_47 = 0, WAR.PersonNum - 1 do
			if (WAR.Person[iter_32_47].人物编号 == 86 or WAR.Person[iter_32_47].人物编号 == 0 and JY.Base.畅想编号 == 86 or WAR.Person[iter_32_47].人物编号 == 80 or WAR.Person[iter_32_47].人物编号 == 0 and JY.Base.畅想编号 == 80) and WAR.Person[iter_32_47].死亡 == false and WAR.Person[iter_32_47].我方 == WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 1.2)
			end
		end
	end

	if cxtd(var_32_0, 86) or cxtd(var_32_0, 80) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if instruct_16(var_32_0) then
		for iter_32_48 = 0, WAR.PersonNum - 1 do
			if cxtd(var_32_0, 5073) and WAR.Person[iter_32_48].死亡 == false and WAR.Person[iter_32_48].我方 == WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 1.1)
			end
		end
	end

	if cxtd(var_32_0, 5074) or cxtd(var_32_0, 80) then
		var_32_49 = math.modf(var_32_49 * 1.2)
	end

	if instruct_16(var_32_0) then
		for iter_32_49 = 0, WAR.PersonNum - 1 do
			if cxtd(var_32_0, 587) and WAR.Person[iter_32_49].死亡 == false and WAR.Person[iter_32_49].我方 == WAR.Person[WAR.CurID].我方 then
				var_32_49 = math.modf(var_32_49 * 1.1)
			end
		end
	end

	if cxtd(var_32_0, 587) then
		var_32_49 = math.modf(var_32_49 * 1.1)
	end

	if JY.Person[var_32_1].武器 == 48 and (yongjian(arg_32_1) or yongdao(arg_32_1) or yongte(arg_32_1)) then
		var_32_49 = var_32_49 - 20

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if PersonKF(var_32_1, 47) then
		var_32_49 = var_32_49 - 20

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if cxtd(var_32_1, 136) and JY.Base.畅想编号 == 136 then
		local var_32_129 = 0

		for iter_32_50 = 1, CC.Kungfunum do
			if yongjian(arg_32_1) and JY.Person[JY.Base.队伍1]["武功" .. iter_32_50] ~= 43 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_50] == 999 then
				var_32_129 = var_32_129 + 1
			end
		end

		var_32_49 = var_32_49 - var_32_129 * 5

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if cxtd(var_32_1, 168) and var_32_49 > 150 then
		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "·不屈战意"
		else
			WAR.Person[arg_32_0].特效文字2 = "不屈战意"
		end

		var_32_49 = var_32_49 - WAR.ZYZ[var_32_1]

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if cxtd(var_32_1, 7) then
		var_32_49 = var_32_49 - JY.Person[0].品德 / 2

		if var_32_49 < 10 then
			var_32_49 = 10
		end
	end

	if cxtd(var_32_1, 23) and JLSD(20, 70, var_32_1) then
		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "·坚若磐石"
		else
			WAR.Person[arg_32_0].特效文字1 = "坚若磐石"
		end

		var_32_49 = var_32_49 - 40

		if var_32_49 < 1 then
			var_32_49 = 1
		end
	end

	if (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and WAR.FLHS4 > 0 and var_32_49 > 0 then
		var_32_49 = 30
	end

	if (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and WAR.JSTG > 0 and JY.Person[var_32_1].副功体 == 122 then
		if var_32_49 <= WAR.JSTG then
			WAR.JSTG = WAR.JSTG - var_32_49
			var_32_49 = 5 + Rnd(6)
			arg_32_3 = math.modf(arg_32_3 / 2)
		else
			var_32_49 = var_32_49 - WAR.JSTG
			WAR.JSTG = 0
		end

		if WAR.Person[arg_32_0].特效文字3 == nil then
			WAR.Person[arg_32_0].特效文字3 = "天罡护体"
		else
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "天罡护体"
		end

		WAR.Person[arg_32_0].特效动画 = 6
	end

	for iter_32_51 = 1, CC.Kungfunum do
		local var_32_130 = JY.Person[var_32_1]["武功" .. iter_32_51]

		if var_32_130 == 104 and WAR.tmp[1000 + var_32_1] ~= 1 and WAR.ZDDH ~= 171 and var_32_1 == 60 and JY.Person[var_32_1].体力 > 50 then
			WAR.Person[arg_32_0].特效动画 = math.fmod(arg_32_1, 10) + 85

			if var_32_1 == 60 then
				WAR.Person[arg_32_0].特效文字1 = "真--逆运筋脉走火入魔"
			else
				WAR.Person[arg_32_0].特效文字1 = JY.Wugong[var_32_130].名称 .. "走火入魔"
			end

			WAR.tmp[1000 + var_32_1] = 1
		end
	end

	if cxtd(var_32_1, 9) and WAR.Person[arg_32_0].特效文字1 == nil and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and var_32_49 > 10 and PersonKF(9, 106) then
		WAR.Person[arg_32_0].特效动画 = math.fmod(97, 10) + 85
		WAR.Person[arg_32_0].特效文字1 = "九阳神功反震"

		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 4, 2)

		local var_32_131 = math.modf(var_32_49 * 0.3)

		JY.Person[var_32_0].生命 = JY.Person[var_32_0].生命 - math.modf(var_32_131 / 2)
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) - math.modf(var_32_131 / 2)
	end

	if JY.Person[var_32_1].防具 == 58 and var_32_49 > 0 and var_32_4() then
		var_32_49 = var_32_49 - 20

		if var_32_49 < 1 then
			var_32_49 = 1
		end

		if JY.Wugong[arg_32_1].武功类型 == 1 then
			local var_32_132 = Rnd(3)

			if var_32_49 > 0 and var_32_132 > 0 then
				WAR.Person[arg_32_0].流血值 = AddPersonAttrib(var_32_0, "流血值", var_32_132)

				if WAR.Person[arg_32_0].流血值 > 0 then
					WAR.LXXS[var_32_0] = 1
					WAR.LXZT[var_32_0] = var_32_132
				end
			end

			Set_Eff_Text(arg_32_0, "特效文字3", "软猬尖刺")
		end
	end

	if cxtd(var_32_1, 591) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and var_32_49 > 10 then
		for iter_32_52 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_52].人物编号 == 38 and WAR.Person[iter_32_52].死亡 == false and WAR.Person[iter_32_52].我方 == WAR.Person[arg_32_0].我方 then
				var_32_49 = math.modf(var_32_49 * 0.5)
				JY.Person[38].生命 = JY.Person[38].生命 - var_32_49
				WAR.Person[arg_32_0].特效文字3 = "本是同根生"
				WAR.Person[iter_32_52].生命点数 = (WAR.Person[iter_32_52].生命点数 or 0) - var_32_49

				SetWarMap(WAR.Person[iter_32_52].坐标X, WAR.Person[iter_32_52].坐标Y, 4, 2)
			end
		end
	end

	if cxtd(var_32_1, 38) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and var_32_49 > 10 then
		for iter_32_53 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_53].人物编号 == 591 and WAR.Person[iter_32_53].死亡 == false and WAR.Person[iter_32_53].我方 == WAR.Person[arg_32_0].我方 then
				var_32_49 = math.modf(var_32_49 * 0.5)
				JY.Person[591].生命 = JY.Person[591].生命 - var_32_49
				WAR.Person[arg_32_0].特效文字3 = "本是同根生"
				WAR.Person[iter_32_53].生命点数 = (WAR.Person[iter_32_53].生命点数 or 0) - var_32_49

				SetWarMap(WAR.Person[iter_32_53].坐标X, WAR.Person[iter_32_53].坐标Y, 4, 2)
			end
		end
	end

	if cxtd(var_32_1, 27) and JLSD(30, 70, var_32_0) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[arg_32_0].特效动画 = math.fmod(97, 10) + 85

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "移花接木"
		else
			WAR.Person[arg_32_0].特效文字1 = "移花接木"
		end

		if WAR.Person[arg_32_0].特效动画 == -1 then
			WAR.Person[arg_32_0].特效动画 = math.fmod(97, 10) + 85
		end

		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 4, 2)

		local var_32_133 = math.modf(var_32_49 * math.random(6) / 10)

		JY.Person[var_32_0].生命 = JY.Person[var_32_0].生命 - var_32_133
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) - var_32_133

		if JY.Person[var_32_0].生命 < 1 then
			JY.Person[var_32_0].生命 = 10
		end
	end

	if cxtd(var_32_1, 27) and JLSD(20, 70, var_32_1) or Curr_NG(var_32_1, 105) and JLSD(30, 60, var_32_1) then
		if JLSD(10, 50, var_32_1) then
			WAR.Dodge = 1

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "真葵花移形"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "真葵花移形"
			end
		else
			var_32_49 = math.modf(2 * var_32_49 / 3)
			arg_32_3 = math.modf(2 * arg_32_3 / 3)

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "葵花移形"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "葵花移形"
			end
		end

		WAR.Person[arg_32_0].特效动画 = math.fmod(105, 10) + 85
	end

	if WAR.ACT > 1 then
		if cxtd(var_32_0, 27) or cxtd(var_32_0, 91) or cxtd(var_32_0, 96) or cxtd(var_32_0, 152) or cxtd(var_32_0, 136) or cxtd(var_32_0, 140) or cxtd(var_32_0, 99) or arg_32_1 == 168 or JY.Person[var_32_0].主功体 == 111 and JLSD(30, 60, var_32_0) then
			var_32_49 = math.modf(var_32_49 * 1)
			arg_32_3 = math.modf(arg_32_3 * 1)
		else
			var_32_49 = math.modf(var_32_49 * 0.6)
			arg_32_3 = math.modf(arg_32_3 * 0.6)
		end
	end

	if WAR.ACT > 2 then
		var_32_49 = math.modf(var_32_49 * 0.4)
		arg_32_3 = math.modf(arg_32_3 * 0.4)
	end

	if WAR.Defup[var_32_1] == 1 then
		if PersonKF(var_32_1, 101) then
			var_32_49 = math.modf(var_32_49 * 0.6)

			if cxtd(var_32_1, 5133) then
				var_32_49 = math.modf(var_32_49 * 0.5)
			end
		elseif cxtd(var_32_1, 5133) then
			var_32_49 = math.modf(var_32_49 * 0.5)
		else
			var_32_49 = math.modf(var_32_49 * 0.75)
		end
	end

	if var_32_49 > 30 and Curr_NG(var_32_1, 109) and (JLSD(70, 90, var_32_1) or cxtd(var_32_1, 114)) then
		if Rnd(3) == 1 then
			var_32_49 = 30
			arg_32_3 = 0
		else
			var_32_49 = math.modf(var_32_49 * 0.5)
			arg_32_3 = math.modf(arg_32_3 * 0.5)
		end

		WAR.Person[arg_32_0].特效文字2 = "金刚不坏"
		WAR.Person[arg_32_0].特效动画 = 88
	elseif var_32_49 > 80 and PersonKF(var_32_1, 109) and JLSD(40, 35, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.8)
		arg_32_3 = math.modf(arg_32_3 * 0.8)
		WAR.Person[arg_32_0].特效文字2 = "金刚护体"
		WAR.Person[arg_32_0].特效动画 = 88
	end

	if Person_qy(var_32_1) > 0 then
		local var_32_134 = Person_qy(var_32_0)
		local var_32_135 = Person_qy(var_32_1)
		local var_32_136 = 0

		if var_32_134 < var_32_135 then
			var_32_136 = var_32_135 - var_32_134
		end

		if var_32_136 > 0 and JLSD(10, 10 + var_32_136, var_32_1) then
			WAR.Dodge = 1
			var_32_49 = 0
			WAR.Person[arg_32_0].特效文字2 = "幸运一闪"
			WAR.Person[arg_32_0].特效动画 = 73
		end
	end

	local var_32_137 = 0

	if JY.Person[var_32_1].轻功 - 100 > JY.Person[var_32_0].轻功 then
		var_32_137 = (JY.Person[var_32_1].轻功 - JY.Person[var_32_0].轻功) / 25
	end

	local var_32_138 = 0

	if not instruct_16(var_32_1) and JY.Person[var_32_1].畅想级别 > 4 and JY.Person[var_32_1].畅想级别 < 100 then
		var_32_138 = JY.Base.游戏难度 + JY.Person[var_32_1].畅想级别
	end

	if JY.Person[var_32_1].畅想级别 > JY.Person[var_32_0].畅想级别 then
		if JY.Person[var_32_1].畅想级别 >= 100 then
			var_32_137 = var_32_137 + JY.Person[var_32_1].畅想级别 - 100 - JY.Person[var_32_0].畅想级别 + var_32_138
		else
			var_32_137 = var_32_137 + JY.Person[var_32_1].畅想级别 - JY.Person[var_32_0].畅想级别 + var_32_138
		end
	end

	local var_32_139 = 0

	if Curr_NG(var_32_1, 97) and var_32_49 > 150 then
		var_32_139 = 50
	elseif PersonKF(var_32_1, 97) and var_32_49 > 150 then
		var_32_139 = 10
	end

	if (JY.Person[var_32_1].主运轻功 > 0 or JY.Person[var_32_1].畅想级别 > 4 and JY.Person[var_32_1].畅想级别 < 100) and JLSD(10, 15 + var_32_137, var_32_1) then
		WAR.Dodge = 1
		var_32_49 = 0
		WAR.Person[arg_32_0].特效文字2 = "轻功闪避"
		WAR.Person[arg_32_0].特效动画 = 76
	elseif var_32_49 > 150 - JY.Base.游戏难度 * 10 and JLSD(10, 20 + var_32_137 * 2 + var_32_139, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.3)
		arg_32_3 = math.modf(arg_32_3 * 0.5)

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "要害闪避"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "要害闪避"
		end

		WAR.Person[arg_32_0].特效动画 = 51
	end

	if Curr_NG(var_32_1, 107) and JLSD(10, 15, var_32_1) then
		WAR.Dodge = 1
		WAR.Person[arg_32_0].特效文字2 = "螺旋九影"
		WAR.Person[arg_32_0].特效动画 = 88
	end

	if Curr_QG(var_32_1, 131) then
		local var_32_140 = 0

		if JLSD(10, 15 + var_32_140, var_32_1) then
			WAR.Dodge = 1
			WAR.Person[arg_32_0].特效文字2 = "神行百变"
			WAR.Person[arg_32_0].特效动画 = 88
		elseif JLSD(50, 55 + var_32_140, var_32_1) and var_32_49 > 0 then
			var_32_49 = math.modf(var_32_49 * 0.8)
			arg_32_3 = math.modf(arg_32_3 * 0.8)
			WAR.Person[arg_32_0].特效动画 = 51

			Set_Eff_Text(arg_32_0, "特效文字2", "神行百变减伤")
		end
	end

	if Curr_QG(var_32_1, 137) and JLSD(10, 25, var_32_1) then
		WAR.Dodge = 1
		WAR.Person[arg_32_0].特效文字2 = "凌波微步"
		WAR.Person[arg_32_0].特效动画 = 88
	end

	if Curr_QG(var_32_1, 139) and JLSD(40, 60, var_32_1) then
		var_32_49 = math.modf(var_32_49 * 0.7)
		arg_32_3 = math.modf(arg_32_3 * 0.7)
		WAR.Person[arg_32_0].特效动画 = 51

		Set_Eff_Text(arg_32_0, "特效文字2", "滑不溜丢")
	end

	if Curr_QG(var_32_1, 135) and JLSD(10, 40, var_32_1) and WAR.ACT > 1 then
		WAR.Dodge = 1

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "云际金燕闪"
		else
			WAR.Person[arg_32_0].特效文字1 = "云际金燕闪"
		end

		WAR.Person[arg_32_0].特效动画 = 88
	end

	if WAR.Dodge == 1 then
		var_32_49 = 0
		WAR.Dodge = 0
	end

	if cxtd(var_32_1, 53) and not cxtd(var_32_0, 130) then
		if WAR.TZ_DY == 1 and JLSD(10, 80, var_32_1) then
			var_32_49 = 0

			if WAR.Person[arg_32_0].特效文字2 == nil then
				WAR.Person[arg_32_0].特效文字2 = "凌波微步"
			else
				WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "凌波微步"
			end

			WAR.Person[arg_32_0].特效动画 = 88
		elseif JLSD(0, 30, var_32_1) then
			var_32_49 = 0
		end
	end

	local var_32_141 = JY.Person[var_32_0].中火毒 / 2 - JY.Person[var_32_0].畅想级别

	if var_32_141 > 50 then
		var_32_141 = 50
	elseif var_32_141 < 0 then
		var_32_141 = 0
	end

	if var_32_141 >= 10 and JLSD(0, var_32_141, var_32_0) and not cxtd(var_32_0, 13) and not cxtd(var_32_0, 130) and not cxtd(var_32_0, 126) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "头昏眼花，攻击落空"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "头昏眼花，攻击落空"
		end

		WAR.Person[arg_32_0].特效动画 = 89
	end

	local var_32_142 = Person_js(var_32_0)
	local var_32_143 = Person_js(var_32_1)

	if JY.Person[var_32_0].实战 / 200 + Person_js(var_32_0) < JY.Person[var_32_1].实战 / 200 + Person_js(var_32_1) and var_32_142 < var_32_143 and JLSD(35, 60, var_32_1) and not cxtd(var_32_0, 50) then
		var_32_49 = math.modf(var_32_49 * 0.7)

		if var_32_49 < 1 then
			var_32_49 = 1
		end

		if WAR.Person[WAR.CurID].特效文字2 == nil then
			WAR.Person[WAR.CurID].特效文字2 = "略有怯意"
		else
			WAR.Person[WAR.CurID].特效文字2 = WAR.Person[WAR.CurID].特效文字2 .. "+" .. "略有怯意"
		end
	end

	local var_32_144 = 0

	if JY.Person[var_32_1].魅力 >= 8 then
		var_32_144 = 5 + (JY.Person[var_32_1].魅力 - 8) * 5
	end

	if var_32_144 < 0 then
		var_32_144 = 0
	end

	if JY.Person[var_32_1].性别 ~= 0 and JLSD(10, 10 + var_32_144, var_32_1) and JY.Person[var_32_0].畅想级别 < 100 then
		var_32_49 = math.modf(var_32_49 * 0.3)

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "手酥脚软"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "手酥脚软"
		end

		WAR.Person[arg_32_0].特效动画 = 89
	end

	if cxtd(var_32_1, 88) and JLSD(35, 50, var_32_1) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "酒神秘踪步"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "酒神秘踪步"
		end

		WAR.Person[arg_32_0].特效动画 = 89
	end

	if cxtd(var_32_1, 104) and JLSD(65, 95, var_32_1) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "易容圣手"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "易容圣手"
		end

		WAR.Person[arg_32_0].特效动画 = 88
	end

	if cxtd(var_32_1, 600) and JLSD(65, 75, var_32_1) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "大哥，打错人了啊"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "大哥，我们是一伙的，别打我啊"
		end

		WAR.Person[arg_32_0].特效动画 = 88
	end

	if cxtd(var_32_1, 184) and JLSD(10, 30, var_32_1) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "真·神行百变"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "真·神行百变"
		end

		WAR.Person[arg_32_0].特效动画 = 89
	end

	if cxtd(var_32_1, 130) and JY.Person[var_32_1].轻功 - 150 > JY.Person[var_32_0].轻功 and JLSD(25, 60, var_32_1) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "飞天蝠影"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "飞天蝠影"
		end

		WAR.Person[arg_32_0].特效动画 = 88
	end

	if cxtd(var_32_1, 116) and JLSD(25, 95, var_32_1) or cxtd(var_32_1, 117) and JLSD(25, 55, var_32_1) or cxtd(var_32_1, 118) and JLSD(25, 55, var_32_1) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "真·凌波微步"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "真·凌波微步"
		end
	end

	if JY.Base.主角职业 == 4 and (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and not cxtd(var_32_0, 130) then
		local var_32_145 = 0

		for iter_32_54 = 1, CC.Kungfunum do
			if JY.Wugong[JY.Person[0]["武功" .. iter_32_54]].武功类型 == 4 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_54] == 999 then
				var_32_145 = var_32_145 + 1
			end
		end

		local var_32_146 = 10 + var_32_145 * 5

		if JLSD(30, 30 + var_32_146, var_32_1) then
			var_32_49 = 0
			WAR.Person[arg_32_0].特效文字3 = "天机身法"
			WAR.Person[arg_32_0].特效动画 = 88
		end
	end

	if cxtd(var_32_1, 29) and WAR.L_TBGZL == 1 and JLSD(30, 60, var_32_0) and not cxtd(var_32_0, 130) then
		var_32_49 = 0

		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "风骚惊天下"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "风骚惊天下"
		end

		WAR.Person[arg_32_0].特效动画 = 88
	end

	if JY.Person[var_32_1].内力性质 == 2 and JY.Person[var_32_1].悟性 < 80 and WAR.L_SGHT == 108 then
		var_32_49 = math.modf(var_32_49 * 0.7)

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "真·易筋洗髓"
		else
			WAR.Person[arg_32_0].特效文字1 = "真·易筋洗髓"
		end

		WAR.Person[arg_32_0].特效动画 = 11
	end

	if WAR.L_SGHT == 106 then
		var_32_49 = math.modf(var_32_49 * 0.7)
	end

	if cxtd(var_32_1, 592) then
		local var_32_147 = JY.Wugong[arg_32_1].武功类型

		if yongnei(arg_32_1) then
			var_32_147 = 5
		end

		if var_32_147 == WAR.L_DGQB_DEF then
			var_32_49 = math.modf(var_32_49 / 2)
			arg_32_3 = math.modf(arg_32_3 / 2)
			WAR.L_DGQB_X = WAR.L_DGQB_X + 1
		elseif WAR.L_DGQB_DEF == 1 and var_32_147 == 2 or WAR.L_DGQB_DEF == 2 and var_32_147 == 3 or WAR.L_DGQB_DEF == 3 and var_32_147 == 1 or WAR.L_DGQB_DEF == 4 and var_32_147 == 5 or WAR.L_DGQB_DEF == 5 and var_32_147 < 5 or WAR.L_DGQB_DEF == 6 and var_32_147 == 7 or WAR.L_DGQB_DEF == 7 and var_32_147 == 6 then
			var_32_49 = math.modf(var_32_49 * (1 - WAR.L_DGQB_X / 10))
			var_32_49 = var_32_49 < 0 and 0 or var_32_49
			WAR.L_DGQB_X = WAR.L_DGQB_X - 1
		else
			var_32_49 = math.modf(var_32_49 * (1 - WAR.L_DGQB_X / 10))
			arg_32_3 = 0
			WAR.L_DGQB_X = WAR.L_DGQB_X + 1
		end

		if var_32_147 > 0 then
			WAR.L_DGQB_DEF = var_32_147
		end

		WAR.ACT = 10

		if WAR.L_DGQB_X <= 0 then
			WAR.L_DGQB_X = 1
		end

		if WAR.Person[arg_32_0].特效文字2 ~= nil then
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. WAR.L_DGQB_DEF_STR[WAR.L_DGQB_DEF]
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.L_DGQB_DEF_STR[WAR.L_DGQB_DEF]
		end

		WAR.Person[arg_32_0].特效动画 = 96
	end

	if JY.Person[var_32_0].生命 <= 0 then
		JY.Person[var_32_0].生命 = 0
	end

	if PersonKF(var_32_0, 87) then
		var_32_49 = var_32_49 + math.modf(JY.Person[var_32_0].中毒程度 / 2) + math.modf(JY.Person[var_32_1].中毒程度 / 2)
	end

	if cxtd(var_32_0, 597) then
		var_32_49 = var_32_49 + JY.Person[var_32_1].中毒程度
	end

	if cxtd(var_32_0, 157) then
		var_32_49 = var_32_49 + JY.Person[var_32_1].中毒程度 * 2
	end

	if WAR.Person[WAR.CurID].我方 == WAR.Person[arg_32_0].我方 then
		if WAR.Person[WAR.CurID].我方 then
			if WAR.L_NYZH[var_32_0] ~= nil then
				var_32_49 = math.modf(var_32_49 * 0.7) + Rnd(3)
			else
				var_32_49 = math.modf(var_32_49 * 0.4) + Rnd(3)
			end
		else
			var_32_49 = math.modf(var_32_49 * 0.2) + Rnd(3)
		end
	end

	if WAR.L_DGQB_X >= 10 and cxtd(var_32_0, 592) then
		if JY.Person[var_32_1].生命 >= 500 then
			var_32_49 = JY.Person[var_32_1].生命 - 1
			JY.Person[var_32_1].生命 = 1
		else
			var_32_49 = JY.Person[var_32_1].生命
			JY.Person[var_32_1].生命 = 0
		end
	else
		JY.Person[var_32_1].生命 = JY.Person[var_32_1].生命 - var_32_49
	end

	arg_32_3 = arg_32_3 - var_32_2

	if arg_32_3 > 0 then
		var_32_2 = 0
	else
		var_32_2 = -arg_32_3
		arg_32_3 = 0
	end

	if arg_32_1 > 0 and JLSD(10, 90, var_32_0) then
		local var_32_148 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].敌人中毒点数 / 10 + JY.Person[var_32_0].攻击带毒 / 5)
		local var_32_149 = JY.Person[var_32_1].抗毒能力
		local var_32_150 = 100 - JY.Person[var_32_1].抗毒能力

		if var_32_150 == 0 then
			var_32_150 = 1
		end

		if JLSD(0, var_32_150, var_32_0) then
			var_32_148 = math.modf(var_32_148 * (var_32_150 / 100) + Rnd(2))
		end

		if JY.Person[var_32_0].武器 == 46 then
			var_32_148 = var_32_148 + 10
		end

		if JY.Person[var_32_0].武器 == 44 then
			var_32_148 = var_32_148 + 5
		end

		local var_32_151 = math.modf(JY.Person[var_32_0].用毒能力 / 100)

		if var_32_0 == 0 and JY.Base.主角职业 == 8 then
			var_32_148 = var_32_148 + var_32_151
		end

		if WAR.L_CZJT == 1 then
			var_32_148 = 30
			var_32_148 = var_32_148 + math.modf((WAR.tmp[200 + var_32_0] - 100) / 10)
			WAR.tmp[200 + var_32_0] = 0

			if PersonKFJ(var_32_0, 9) then
				var_32_148 = var_32_148 + math.modf(var_32_148 / 2)
			end
		end

		if var_32_148 < 0 or WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (JY.Person[var_32_1].主功体 == 108 or WAR.Dodge == 1) then
			var_32_148 = 0
		end

		if var_32_49 > 0 and var_32_148 > 0 then
			WAR.Person[arg_32_0].中毒点数 = math.modf((WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", var_32_41(var_32_148)))
		end

		local var_32_152 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].内伤 / 2 - Rnd(2))

		if var_32_152 < 0 then
			var_32_152 = 0
		end

		if instruct_16(var_32_1) then
			if cxtd(var_32_0, 80) or cxtd(var_32_0, 69) or JY.Person[var_32_0].武器 == 36 and JLSD(30, 60, var_32_0) then
				var_32_152 = var_32_152 + math.modf(var_32_49 / 25)
			else
				var_32_152 = var_32_152 + math.modf(var_32_49 / 50)
			end
		end

		if WAR.XXYY == 1 or cxtd(var_32_0, 164) or WAR.NGJL == 103 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[arg_32_0].我方 then
			var_32_152 = var_32_152 + 10
		end

		if JY.Base.主角职业 == 5 and var_32_0 == 0 and yongnei(arg_32_1) then
			var_32_152 = var_32_152 + 10
		end

		if JY.Person[var_32_1].防具 == 59 or cxtd(var_32_1, 149) then
			var_32_152 = math.modf(var_32_152 / 2)
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].主功体 == 100 then
			var_32_152 = math.modf(var_32_152 / 2)
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].主功体 == 96 then
			var_32_152 = math.modf(var_32_152 * 4 / 10)
		end

		if (cxtd(var_32_1, 157) or cxtd(var_32_1, 158) or cxtd(var_32_1, 159)) and var_32_152 > 5 then
			var_32_152 = 5
		end

		if cxtd(var_32_1, 54) or WAR.TJSQ == 1 then
			var_32_152 = 0
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Dodge == 1 then
			var_32_152 = 0
		end

		if Curr_NG(var_32_1, 108) and JLSD(0, 30, var_32_1) then
			if WAR.Person[arg_32_0].特效文字3 == nil then
				WAR.Person[arg_32_0].特效文字3 = "易筋真谛·金身不朽"
			else
				WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "金身不朽"
			end

			var_32_2 = 1
			var_32_152 = 0
		end

		if var_32_49 > 0 and var_32_152 > 0 then
			if WAR.L_SGHT == 102 then
				WAR.Person[arg_32_0].内伤点数 = (WAR.Person[arg_32_0].内伤点数 or 0) - var_32_152

				AddPersonAttrib(var_32_1, "受伤程度", -var_32_152)
			else
				WAR.Person[arg_32_0].内伤点数 = (WAR.Person[arg_32_0].内伤点数 or 0) + var_32_152

				AddPersonAttrib(var_32_1, "受伤程度", var_32_152)
			end
		end

		local var_32_153 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].流血 / 3 - Rnd(2))

		if var_32_153 < 0 then
			var_32_153 = 0
		end

		if JY.Person[var_32_1].武器 == 37 then
			var_32_49 = var_32_49 + 30

			if JLSD(40, 70, var_32_0) then
				var_32_153 = var_32_153 + 8
			end
		end

		if cxtd(var_32_0, 91) and yongjian(arg_32_1) then
			var_32_153 = var_32_153 + 10
		end

		if var_32_0 == 0 and JY.Base.主角职业 == 9 and JY.Base.觉醒 == 1 and yongan(arg_32_1) then
			var_32_153 = var_32_153 + 10
		end

		if JY.Person[var_32_1].防具 > 57 and JY.Person[var_32_1].防具 < 64 then
			var_32_153 = var_32_153 - 5
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Dodge == 1 then
			var_32_153 = 0
		end

		if var_32_49 > 0 and var_32_153 > 0 then
			WAR.Person[arg_32_0].流血值 = AddPersonAttrib(var_32_1, "流血值", var_32_153)

			if WAR.Person[arg_32_0].流血值 > 0 then
				WAR.LXXS[var_32_1] = 1
				WAR.LXZT[var_32_1] = var_32_153
			end
		end

		local var_32_154 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].火毒 / 4 + JY.Person[var_32_0].无用3 - Rnd(2))

		if JY.Person[var_32_0].内力性质 ~= 1 and var_32_0 == 0 and JY.Base.主角职业 ~= 5 and JY.Base.畅想编号 == 0 then
			var_32_154 = 0
		end

		if var_32_154 < 0 then
			var_32_154 = 0
		end

		if cxtd(var_32_0, 103) or WAR.FDHOT == 1 then
			var_32_154 = var_32_154 + 5
		end

		if JY.Person[var_32_0].武器 == 50 and JLSD(30, 40, var_32_0) then
			var_32_154 = var_32_154 + 10
		end

		if var_32_0 == 0 and JY.Base.主角职业 == 8 and JY.Base.二次觉醒 == 1 and JLSD(30, 40, var_32_0) then
			var_32_154 = var_32_154 + 10
		end

		if JY.Person[var_32_1].防具 == 62 then
			var_32_154 = var_32_154 - 2
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].主功体 == 107 or cxtd(var_32_1, 440) or WAR.Dodge == 1 then
			var_32_154 = 0
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[WAR.CurID].主功体 == 112 and JLSD(20, 90, WAR.CurID) then
			var_32_154 = 0
		end

		if var_32_49 > 0 and var_32_154 > 0 then
			WAR.Person[arg_32_0].中火毒 = AddPersonAttrib(var_32_1, "中火毒", var_32_154)

			if WAR.Person[arg_32_0].中火毒 > 0 then
				WAR.HOTXS[var_32_1] = 1
				WAR.ZSZ[var_32_1] = var_32_154
			end
		end

		local var_32_155 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].冰冻 / 4 + JY.Person[var_32_0].无用2 - Rnd(2))

		if JY.Person[var_32_0].内力性质 ~= 0 and var_32_0 == 0 and JY.Base.主角职业 ~= 5 and JY.Base.畅想编号 == 0 then
			var_32_155 = 0
		end

		if var_32_155 < 0 then
			var_32_155 = 0
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].主功体 == 106 or WAR.Dodge == 1 then
			var_32_155 = 0
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[var_32_1].主功体 == 99 then
			var_32_155 = math.modf(var_32_155 / 2)
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[WAR.CurID].主功体 == 112 and JLSD(20, 90, WAR.CurID) then
			var_32_155 = var_32_155 + 10
		end

		if WAR.L_SSBD == 1 or cxtd(var_32_0, 14) and yongquan(arg_32_1) then
			var_32_155 = var_32_155 + 5
		end

		if WAR.BPHG == 1 then
			var_32_155 = var_32_155 + 10
		end

		if var_32_0 == 0 and JY.Base.主角职业 == 8 and JY.Base.二次觉醒 == 1 and JLSD(30, 40, var_32_0) then
			var_32_155 = var_32_155 + 10
		end

		if JY.Person[var_32_0].武器 == 38 then
			var_32_155 = var_32_155 + 2
		end

		if JY.Person[var_32_0].武器 == 50 and JLSD(30, 40, var_32_0) then
			var_32_155 = var_32_155 + 10
		end

		if JY.Person[var_32_1].防具 == 63 then
			var_32_155 = var_32_155 - 2
		end

		if var_32_49 > 0 and var_32_155 > 0 then
			WAR.Person[arg_32_0].中冰毒 = AddPersonAttrib(var_32_1, "中冰毒", var_32_155)

			if WAR.Person[arg_32_0].中冰毒 > 0 then
				WAR.CHXS[var_32_1] = 1
				WAR.BFZ[var_32_1] = var_32_155
			end
		end

		local var_32_156 = math.modf(arg_32_2 * JY.Wugong[arg_32_1].封穴 / 4 - Rnd(2))

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (JY.Person[var_32_1].主功体 == 104 or JY.Person[var_32_1].畅想级别 > 100 or WAR.Dodge == 1) then
			var_32_156 = 0
		end

		if JY.Person[var_32_1].畅想级别 > 4 and JY.Person[var_32_1].畅想级别 < 100 then
			var_32_156 = var_32_156 - JY.Person[var_32_1].畅想级别
		end

		if WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (WAR.NGHT == 104 or JY.Person[var_32_1].主功体 == 97 or JY.Person[var_32_1].主功体 == 109 or JY.Person[var_32_1].防具 == 60) then
			var_32_156 = math.modf(var_32_156 / 2)
		end

		if cxtd(var_32_0, 57) then
			var_32_156 = var_32_156 + 10
		end

		if var_32_0 == 0 and JY.Base.主角职业 == 9 and JY.Base.觉醒 == 1 and yongan(arg_32_1) then
			var_32_156 = var_32_156 + 10
		end

		if var_32_0 == 0 and JY.Base.主角职业 == 1 and JY.Base.觉醒 == 2 and yongquan(arg_32_1) then
			var_32_156 = math.modf(var_32_156 * 4 / 3 + 3)
		end

		if var_32_156 < 0 then
			var_32_156 = 0
		end

		if var_32_49 > 0 and var_32_156 > 0 then
			WAR.Person[arg_32_0].中封穴 = AddPersonAttrib(var_32_1, "中封穴", var_32_156)

			if WAR.Person[arg_32_0].中封穴 > 0 then
				WAR.FXXS[var_32_1] = 1
				WAR.FXDS[var_32_1] = var_32_156
			end
		end
	end

	if not instruct_16(var_32_0) then
		local var_32_157 = {
			6,
			3,
			40,
			97,
			103,
			19,
			60,
			71,
			189,
			27
		}

		for iter_32_55 = 1, 10 do
			if var_32_0 == var_32_157[iter_32_55] and JLSD(30, 70, var_32_0) then
				WAR.BLX = 1
			end
		end
	end

	if cxtd(var_32_1, 124) and WAR.XSZJ == 11 then
		if WAR.ICE[var_32_1] == nil then
			WAR.ICE[var_32_1] = WAR.ZJBF
		else
			WAR.ICE[var_32_1] = WAR.ICE[var_32_1] + WAR.ZJBF
		end

		WAR.Person[arg_32_0].特效文字2 = "云水蕴真"
	end

	WAR.BLX = 0

	if cxtd(var_32_1, 68) and WAR.ACT == WAR.CCZ and not cxtd(var_32_0, 130) then
		var_32_49 = 0
		WAR.CCZ = 0
	end

	for iter_32_56 = 1, CC.Kungfunum do
		if JY.Person[var_32_1]["武功" .. iter_32_56] == 16 then
			if WAR.tmp[3000 + var_32_1] == nil then
				WAR.tmp[3000 + var_32_1] = 0
			end

			WAR.tmp[3000 + var_32_1] = var_32_49

			break
		end
	end

	if JY.Person[var_32_1].生命 <= 0 then
		for iter_32_57 = 1, CC.Kungfunum do
			local var_32_158 = JY.Person[var_32_1]["武功" .. iter_32_57]

			if var_32_158 == 94 and WAR.tmp[2000 + var_32_1] == nil then
				WAR.Person[arg_32_0].特效动画 = 19
				WAR.Person[arg_32_0].特效文字1 = JY.Wugong[var_32_158].名称 .. "起死回生"

				local var_32_159 = math.modf(JY.Person[var_32_1]["武功等级" .. iter_32_57] / 100) + 1

				if JY.Person[var_32_1].主功体 == 94 then
					JY.Person[var_32_1].生命 = math.modf(JY.Person[var_32_1].生命最大值 * 0.7)
				elseif cxtd(var_32_1, 37) then
					JY.Person[var_32_1].生命 = JY.Person[var_32_1].生命最大值
				else
					JY.Person[var_32_1].生命 = math.modf(JY.Person[var_32_1].生命最大值 * 0.4)
				end

				if JY.Person[var_32_1].主功体 == 94 then
					JY.Person[var_32_1].内力 = math.modf(JY.Person[var_32_1].内力最大值 * 0.7)
				elseif cxtd(var_32_1, 37) then
					JY.Person[var_32_1].内力 = JY.Person[var_32_1].内力最大值
				else
					JY.Person[var_32_1].内力 = math.modf(JY.Person[var_32_1].内力最大值 * 0.4)
				end

				if JY.Person[var_32_1].主功体 == 94 then
					JY.Person[var_32_1].体力 = math.modf(JY.Person[var_32_1].体力 + 70)
				elseif cxtd(var_32_1, 37) then
					JY.Person[var_32_1].体力 = 100
				else
					JY.Person[var_32_1].体力 = math.modf(JY.Person[var_32_1].体力 + 40)
				end

				if JY.Person[var_32_1].体力 > 100 then
					JY.Person[var_32_1].体力 = 100
				end

				JY.Person[var_32_1].中毒程度 = math.modf(JY.Person[var_32_1].中毒程度 / 2)
				JY.Person[var_32_1].受伤程度 = math.modf(JY.Person[var_32_1].受伤程度 / 2)
				JY.Person[var_32_1].中火毒 = math.modf(JY.Person[var_32_1].中火毒 / 2)
				JY.Person[var_32_1].中冰毒 = math.modf(JY.Person[var_32_1].中冰毒 / 2)
				WAR.Person[arg_32_0].Time = WAR.Person[arg_32_0].Time + 500

				if JY.Person[var_32_1].主功体 == 94 then
					WAR.Person[arg_32_0].Time = WAR.Person[arg_32_0].Time + 700
				end

				if cxtd(var_32_1, 37) then
					WAR.Person[arg_32_0].Time = 990
					WAR.DYSZ = 1
				end

				if WAR.Person[arg_32_0].Time > 990 then
					WAR.Person[arg_32_0].Time = 990
				end

				if math.random(10) ~= 8 then
					WAR.tmp[2000 + var_32_1] = 1
				end
			end
		end
	end

	if JY.Person[var_32_1].生命 <= 0 then
		if WAR.TJFH[var_32_1] == nil then
			WAR.TJFH[var_32_1] = 0
		end

		if cxtd(var_32_1, 599) and WAR.TJFH[var_32_1] < 1 then
			WAR.Person[arg_32_0].特效动画 = 19
			WAR.Person[arg_32_0].特效文字1 = "装死&复活"
			WAR.TJFH[var_32_1] = WAR.TJFH[var_32_1] + 1
			JY.Person[var_32_1].生命 = math.modf(JY.Person[var_32_1].生命最大值 * 1 / 2)
			JY.Person[var_32_1].内力 = math.modf((JY.Person[var_32_1].内力 + JY.Person[var_32_1].内力最大值) / 2)
			JY.Person[var_32_1].体力 = math.modf(JY.Person[var_32_1].体力 + 20)
			JY.Person[var_32_1].中毒程度 = 0
			JY.Person[var_32_1].受伤程度 = 0
			WAR.HOT[var_32_1] = nil
			WAR.ICE[var_32_1] = nil
			WAR.Person[arg_32_0].Time = 990
		end
	end

	if JY.Person[var_32_1].生命 <= 0 and cxtd(var_32_1, 160) and JLSD(20, 45, var_32_1) then
		WAR.Person[arg_32_0].特效动画 = 19
		WAR.Person[arg_32_0].特效文字1 = "顽强意志"
		JY.Person[var_32_1].生命 = 100
	end

	if JY.Person[var_32_1].生命 <= 0 and (cxtd(var_32_1, 129) or cxtd(var_32_1, 65)) and WAR.WCY < 1 then
		WAR.Person[arg_32_0].特效动画 = 19
		WAR.Person[arg_32_0].特效文字1 = "先天一阳 起死回生"
		WAR.WCY = WAR.WCY + 1
		JY.Person[var_32_1].生命 = JY.Person[var_32_1].生命最大值
		JY.Person[var_32_1].内力 = JY.Person[var_32_1].内力最大值
		JY.Person[var_32_1].中毒程度 = 0
		JY.Person[var_32_1].受伤程度 = 0
		WAR.HOT[var_32_1] = nil
		WAR.ICE[var_32_1] = nil
		JY.Person[var_32_1].体力 = 100
		WAR.Person[arg_32_0].Time = 980
	end

	if JY.Person[var_32_1].生命 <= 0 and WAR.XMH == 0 then
		for iter_32_58 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_58].人物编号 == 45 and WAR.Person[iter_32_58].死亡 == false and WAR.Person[iter_32_58].我方 == WAR.Person[arg_32_0].我方 then
				WAR.Person[arg_32_0].特效动画 = 89
				WAR.Person[arg_32_0].特效文字1 = "阎王敌 重生"
				JY.Person[var_32_1].生命 = JY.Person[var_32_1].生命最大值
				JY.Person[var_32_1].内力 = JY.Person[var_32_1].内力最大值
				JY.Person[var_32_1].中毒程度 = 0
				JY.Person[var_32_1].受伤程度 = 0
				JY.Person[var_32_1].体力 = 100
				WAR.FXDS[var_32_1] = nil
				WAR.LXZT[var_32_1] = nil
				WAR.HOT[var_32_1] = nil
				WAR.ICE[var_32_1] = nil
				WAR.XMH = 1
			end
		end

		if cxtd(var_32_1, 45) then
			WAR.Person[arg_32_0].特效动画 = 89
			WAR.Person[arg_32_0].特效文字1 = "阎王敌 重生"
			JY.Person[var_32_1].生命 = JY.Person[var_32_1].生命最大值
			JY.Person[var_32_1].内力 = JY.Person[var_32_1].内力最大值
			JY.Person[var_32_1].中毒程度 = 0
			JY.Person[var_32_1].受伤程度 = 0
			JY.Person[var_32_1].体力 = 100
			WAR.FXDS[var_32_1] = nil
			WAR.LXZT[var_32_1] = nil
			WAR.HOT[var_32_1] = nil
			WAR.ICE[var_32_1] = nil
			WAR.XMH = 1
		end
	end

	if cxtd(var_32_1, 553) and JY.Person[var_32_1].生命 <= 0 then
		WAR.YZB = 1
	end

	if JY.Person[var_32_1].生命 <= 0 then
		JY.Person[var_32_1].生命 = 0
		WAR.Person[arg_32_0].反击武功 = -1

		if JY.Person[var_32_1].畅想级别 < 100 then
			WAR.Person[WAR.CurID].经验 = WAR.Person[WAR.CurID].经验 + JY.Person[var_32_1].畅想级别 * 100
		elseif JY.Person[var_32_1].畅想级别 > 100 then
			WAR.Person[WAR.CurID].经验 = WAR.Person[WAR.CurID].经验 + (JY.Person[var_32_1].畅想级别 - 100) * 100
		end
	end

	if WAR.TJAY == 3 then
		arg_32_3 = arg_32_3 * 0.75

		if PersonKF(var_32_1, 113) then
			var_32_49 = math.modf(var_32_49 * 0.85)
		end

		WAR.Person[arg_32_0].特效动画 = 21

		if PersonKF(var_32_1, 113) or JLSD(40, 65, var_32_1) then
			WAR.TJAY = 4
			WAR.Person[arg_32_0].特效文字2 = "太极真义·四两拨千斤"
		else
			WAR.Person[arg_32_0].特效文字2 = "太极奥义"
		end
	end

	WAR.TJAY = 0

	local var_32_160 = JY.Person[0].性格

	if WAR.ZYZ[var_32_0] < 150 and JY.Person[0].性格 > 0 and var_32_49 > 200 - (JY.Base.游戏难度 - 1) * 20 - CC.CircleNum * 5 then
		WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + var_32_160 + 2
	end

	if cxtd(var_32_1, 114) then
		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "天地独尊"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "天地独尊"
		end

		WAR.Person[arg_32_0].特效动画 = 39
		var_32_2 = 1
	end

	if WAR.Defup[var_32_1] == 1 and JY.Person[var_32_1].主功体 == 101 then
		var_32_2 = 1
	end

	if cxtd(var_32_1, 50) and JLSD(20, 70, var_32_1) or PersonKF(var_32_1, 26) and PersonKF(var_32_1, 80) and JLSD(20, 60, var_32_1) then
		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = " 盖世无双"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "盖世无双"
		end

		WAR.Person[arg_32_0].特效动画 = 39
		var_32_2 = 1
	end

	if cxtd(var_32_1, 151) and JY.Person[var_32_1].生命 <= JY.Person[var_32_1].生命最大值 / 4 then
		if WAR.Person[arg_32_0].特效文字2 == nil then
			WAR.Person[arg_32_0].特效文字2 = "否极泰来"
		else
			WAR.Person[arg_32_0].特效文字2 = WAR.Person[arg_32_0].特效文字2 .. "+" .. "否极泰来"
		end

		WAR.Person[arg_32_0].特效动画 = 39
		var_32_2 = 1
	end

	if (PersonKF(var_32_1, 85) or T1LEQ(var_32_1) or cxtd(var_32_1, 118)) and WAR.YJZD == 1 then
		var_32_2 = 1
		WAR.YJZD = 0
	end

	if cxtd(var_32_1, 35) and WAR.JIUPO == 1 then
		var_32_2 = 1
		WAR.JIUPO = 0
	end

	if var_32_49 < 30 then
		var_32_2 = 1
	end

	if WAR.TJAY == 4 then
		var_32_2 = 1
	end

	WAR.TJAY = 0

	if cxtd(var_32_1, 37) and WAR.DYSZ == 1 then
		var_32_2 = 1
		WAR.DYSZ = 0
	end

	if (var_32_1 == JY.Base.队伍1 or var_32_1 == JY.Base.畅想编号 or var_32_1 == 9999 and JY.Person[var_32_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and WAR.FLHS4 > 0 then
		var_32_2 = 1
	end

	if WAR.ASKD == 1 then
		var_32_2 = 0
	end

	if arg_32_1 == 47 and JY.Person[var_32_0].御剑能力 >= 300 and JLSD(10, 20, var_32_0) then
		var_32_2 = 0
	end

	if var_32_2 == 0 and var_32_49 >= 20 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[arg_32_0].我方 then
		local var_32_161
		local var_32_162 = JY.Base.游戏难度 == 1 and 0.6 or JY.Base.游戏难度 == 2 and 0.8 or JY.Base.游戏难度 == 3 and 1 or JY.Base.游戏难度 == 4 and 1.1 or JY.Base.游戏难度 == 5 and 1.2 or 1.3
		local var_32_163 = 0

		if inteam(var_32_1) then
			var_32_163 = math.modf(arg_32_3 / 20 * var_32_162)
		else
			var_32_163 = math.modf(arg_32_3 / 20)
		end

		local var_32_164 = 0

		if instruct_16(var_32_1) and JY.Base.游戏难度 > 4 then
			var_32_164 = math.modf(var_32_49 * 0.1)
		end

		for iter_32_59 = 1, CC.Kungfunum do
			if JY.Person[var_32_0]["武功" .. iter_32_59] == 103 then
				var_32_164 = math.modf(var_32_49 * 3 / 10)
			end
		end

		for iter_32_60 = 1, CC.Kungfunum do
			if JY.Person[var_32_1]["武功" .. iter_32_60] == 101 then
				if JY.Person[var_32_1].主功体 == 101 then
					var_32_164 = 0
				end
			else
				var_32_164 = var_32_164 / 2
			end
		end

		local var_32_165 = var_32_163 + var_32_164

		if T3XXM(var_32_0) and JY.Base.二次觉醒 == 1 then
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - 300
		end

		if T4RM(var_32_0) then
			if JY.Base.二次觉醒 == 1 then
				WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - 800
			elseif JY.Base.觉醒 == 1 then
				WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - 400
			else
				WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - 200
			end
		end

		if WAR.TJSQ == 1 then
			if cxtd(var_32_1, 5) or cxtd(var_32_1, 171) then
				var_32_165 = 0
			elseif PersonKF(var_32_1, 100) then
				var_32_165 = var_32_165 - math.modf(var_32_165 * 0.3)
			else
				var_32_165 = var_32_165 - math.modf(var_32_165 * 0.5)
			end
		end

		if WAR.JZPZXS == 1 then
			var_32_165 = 0
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - 300
		end

		if WAR.XSZJ == 2 then
			var_32_165 = 0
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd + 200
		end

		if WAR.L_SGHT == 102 then
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd + var_32_165

			if WAR.YLSX == 1 then
				WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd + var_32_165 * 0.5
			end
		elseif WAR.YLSX == 1 then
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd + var_32_165 * 0.5
		else
			WAR.Person[arg_32_0].TimeAdd = WAR.Person[arg_32_0].TimeAdd - var_32_165
		end
	end

	WAR.TJSQ = 0
	WAR.YLSX = 0

	if cxtd(var_32_1, 59) and JY.Person[var_32_1].生命 <= 0 then
		WAR.XK = 1
		WAR.XK2 = WAR.Person[arg_32_0].我方
	end

	if cxtd(var_32_0, 60) and var_32_49 > 0 then
		WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", 30)
	end

	if WAR.TD == -2 then
		local var_32_166
		local var_32_167 = math.random(4)

		if JY.Person[var_32_1]["携带物品数量" .. var_32_167] > 0 and JY.Person[var_32_1]["携带物品" .. var_32_167] > -1 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[arg_32_0].我方 then
			WAR.TD = JY.Person[var_32_1]["携带物品" .. var_32_167]

			local var_32_168 = JY.Person[var_32_1]["携带物品数量" .. var_32_167]

			if WAR.TD == 174 and var_32_168 > 0 then
				JY.Person[var_32_1]["携带物品数量" .. var_32_167] = 0

				addthing(WAR.TD, var_32_168)
			else
				JY.Person[var_32_1]["携带物品数量" .. var_32_167] = JY.Person[var_32_1]["携带物品数量" .. var_32_167] - 1

				addthing(WAR.TD, 1)
			end
		end

		if JY.Person[var_32_1]["携带物品数量" .. var_32_167] < 1 then
			JY.Person[var_32_1]["携带物品" .. var_32_167] = -1
		end
	else
		WAR.TD = -1
	end

	if WAR.TD1 == -2 then
		local var_32_169
		local var_32_170 = math.random(4)

		if JY.Person[var_32_1]["携带物品数量" .. var_32_170] > 0 and JY.Person[var_32_1]["携带物品" .. var_32_170] > -1 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[arg_32_0].我方 then
			JY.Person[var_32_1]["携带物品数量" .. var_32_170] = JY.Person[var_32_1]["携带物品数量" .. var_32_170] - 1
			WAR.TD1 = JY.Person[var_32_1]["携带物品" .. var_32_170]
		end

		if JY.Person[var_32_1]["携带物品数量" .. var_32_170] < 1 then
			JY.Person[var_32_1]["携带物品" .. var_32_170] = -1
		end
	else
		WAR.TD1 = -1
	end

	if WAR.XDDF == 1 then
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) + AddPersonAttrib(var_32_0, "生命", math.modf(var_32_49 * 0.05))
		WAR.XDXX = WAR.XDXX + math.modf(var_32_49 * 0.05)
	end

	if PersonKF(var_32_0, 85) and PersonKF(var_32_0, 87) and PersonKF(var_32_0, 88) and JLSD(30, 50, var_32_0) then
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) + AddPersonAttrib(var_32_0, "生命", math.modf(var_32_49 * 0.1))

		if WAR.Person[arg_32_0].特效文字3 == nil then
			WAR.Person[arg_32_0].特效文字3 = "吸精夺魄"
		else
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "吸精夺魄"
			WAR.Person[arg_32_0].特效动画 = 89
		end
	end

	if cxtd(var_32_0, 14) and JLSD(30, 50, var_32_0) then
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) + AddPersonAttrib(var_32_0, "生命", math.modf(var_32_49 * 0.05))

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "血翼蝠影"
		else
			WAR.Person[arg_32_0].特效文字1 = "血翼蝠影"
		end

		WAR.Person[arg_32_0].特效动画 = 63
	end

	if cxtd(var_32_0, 68) and WAR.ACT == 2 and JLSD(30, 90, var_32_0) then
		WAR.Person[WAR.CurID].生命点数 = (WAR.Person[WAR.CurID].生命点数 or 0) + AddPersonAttrib(var_32_0, "生命", math.modf(var_32_49 * 0.01))

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "气返先天"
		else
			WAR.Person[arg_32_0].特效文字1 = "气返先天"
		end

		WAR.Person[arg_32_0].特效动画 = 63
	end

	if var_32_1 == 445 and JY.Person[var_32_1].生命 > 0 and JY.Person[445].姓名 == "二宫和也" then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 30000)
		WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) + AddPersonAttrib(var_32_1, "内力", 5000)
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", 100)
	end

	if cxtd(var_32_1, 85) and JY.Person[var_32_1].生命 > 0 then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 50)
	end

	if JY.Person[var_32_1].主功体 == 94 and JY.Person[var_32_1].生命 > 0 and JLSD(20, 80, var_32_1) then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 50)

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "生生不息"
		else
			WAR.Person[arg_32_0].特效文字3 = "生生不息"
		end
	end

	if cxtd(var_32_1, 516) and JY.Person[var_32_1].生命 > 0 then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 50)
	end

	if cxtd(var_32_1, 599) and JY.Person[var_32_1].生命 > 0 and JY.Person[var_32_1].生命 < JY.Person[var_32_1].生命最大值 / 2 then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 100)
	end

	if cxtd(var_32_1, 129) and JY.Person[var_32_1].生命 > 0 then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", 100)
	end

	if cxtd(var_32_1, 127) and JY.Person[var_32_1].生命 > 0 and JLSD(20, 35, var_32_1) then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", var_32_49)

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "化元返一"
		else
			WAR.Person[arg_32_0].特效文字3 = "化元返一"
		end
	end

	if WAR.HQT == 1 then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -10)
	end

	if PersonKF(var_32_0, 29) and JY.Person[var_32_0].内力性质 == 0 and yongjian(arg_32_1) then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -2)
	end

	if PersonKF(var_32_0, 36) and yongjian(arg_32_1) then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -2)
	end

	if PersonKF(var_32_0, 29) and JY.Person[var_32_0].内力性质 == 2 and yongjian(arg_32_1) then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -1)
	end

	if cxtd(var_32_0, 80) then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -8)
	end

	if JY.Person[var_32_0].武器 == 40 and yongjian(arg_32_1) then
		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + AddPersonAttrib(var_32_1, "体力", -5)
	end

	if WAR.CY == 1 then
		WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) + AddPersonAttrib(var_32_1, "内力", -600)
	end

	if WAR.QXWX == 1 then
		WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) + AddPersonAttrib(var_32_1, "内力", -500)
	end

	if WAR.Data.代号 == 0 and cxtd(var_32_0, 72) and var_32_1 == 3 and JY.Person[var_32_1].生命 <= 2500 and JY.Person[72].武功1 == 28 then
		WAR.TGN = 1
	end

	if cxtd(var_32_0, 4) and JY.Person[var_32_1].生命 > 0 and instruct_16(var_32_0) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and not instruct_16(var_32_1) then
		WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", 10 + math.random(10))
	end

	if cxtd(var_32_0, 5099) and JY.Person[var_32_1].生命 > 0 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and not instruct_16(var_32_1) then
		WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", 10 + math.random(5))
	end

	if cxtd(var_32_0, 38) and JY.Person[var_32_1].生命 <= 0 and WAR.SAXING ~= -1 then
		WAR.SAXING = WAR.SAXING + 1
	end

	if cxtd(var_32_0, 72) then
		for iter_32_61 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_61].人物编号 == 4 and WAR.Person[iter_32_61].死亡 == false and WAR.Person[iter_32_61].我方 == WAR.Person[WAR.CurID].我方 then
				WAR.Person[arg_32_0].中毒点数 = AddPersonAttrib(var_32_1, "中毒程度", JY.Person[var_32_1].中毒程度 + 5 + math.random(15))
			end
		end
	end

	if cxtd(var_32_0, 42) and JY.Person[var_32_1].生命 <= 0 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		AddPersonAttrib(var_32_0, "生命", 150)
	end

	if WAR.KHBX == 1 and var_32_49 > 0 and (WAR.KHCM[var_32_1] == nil or WAR.KHCM[var_32_1] == 0) then
		WAR.KHCM[var_32_1] = 1
	end

	if WAR.KHBX == 2 and var_32_49 > 0 then
		WAR.KHCM[var_32_1] = 2
	end

	if (cxtd(var_32_1, 13) or cxtd(var_32_1, 78) or cxtd(var_32_1, 130) or (cxtd(var_32_1, 5) or cxtd(var_32_1, 27) or cxtd(var_32_1, 50) or cxtd(var_32_1, 114)) and JLSD(30, 80, var_32_1)) and WAR.KHCM[var_32_1] ~= nil then
		WAR.KHCM[var_32_1] = nil
	end

	if WAR.KHCM[var_32_0] == 1 and JLSD(10, 90, var_32_0) or WAR.KHCM[var_32_0] == 2 then
		WAR.Dodge = 1
	end

	if WAR.GBWZ == 1 and math.random(10) < 6 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[arg_32_0].生命点数 = -JY.Person[var_32_1].生命
		JY.Person[var_32_1].生命 = 0
	end

	if arg_32_1 == 83 and (JLSD(30, 70, var_32_0) and JY.Person[var_32_0].特殊兵器 >= 180 or cxtd(var_32_0, 15) and JLSD(40, 70, var_32_0)) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		if xiaobin(var_32_1) then
			WAR.Person[arg_32_0].生命点数 = -JY.Person[var_32_1].生命
			JY.Person[var_32_1].生命 = 0
		else
			WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", -100)
		end

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "追魂夺命"
		else
			WAR.Person[arg_32_0].特效文字3 = "追魂夺命"
		end
	end

	if arg_32_1 == 125 and JY.Person[var_32_0].耍刀技巧 >= 100 and cxtd(var_32_0, 0) and JLSD(25, 70, var_32_0) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		if xiaobin(var_32_1) then
			WAR.Person[arg_32_0].生命点数 = -JY.Person[var_32_1].生命
			JY.Person[var_32_1].生命 = 0
		else
			WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", -100)
		end

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "刀如猛虎"
		else
			WAR.Person[arg_32_0].特效文字3 = "刀如猛虎"
		end
	end

	if cxtd(var_32_0, 594) and JLSD(20, 60, var_32_0) and JY.Base.畅想编号 == 594 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", -80)

		if WAR.Person[var_32_0].特效文字1 ~= nil then
			WAR.Person[var_32_0].特效文字1 = WAR.Person[var_32_0].特效文字1 .. "+" .. "飞蝗夺命刀"
		else
			WAR.Person[var_32_0].特效文字1 = "飞蝗夺命刀"
		end
	end

	if WAR.ZYZ[var_32_0] > 120 and WAR.ZYZ[var_32_1] < 70 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		if xiaobin(var_32_1) then
			WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", -100)
		else
			WAR.Person[arg_32_0].生命点数 = (WAR.Person[arg_32_0].生命点数 or 0) + AddPersonAttrib(var_32_1, "生命", -50)
		end

		if WAR.Person[arg_32_0].特效文字3 ~= nil then
			WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "战意压制"
		else
			WAR.Person[arg_32_0].特效文字3 = "战意压制"
		end
	end

	if not instruct_16(var_32_0) then
		local var_32_171 = {
			114,
			26,
			129,
			65,
			18,
			39,
			70,
			98,
			57,
			185
		}

		for iter_32_62 = 1, 10 do
			if var_32_0 == var_32_171[iter_32_62] and JLSD(30, 70, var_32_0) then
				WAR.BFX = 1
			end
		end
	end

	if JY.Person[var_32_1].生命 > 0 and var_32_49 > 0 and (WAR.LQZ[var_32_1] == nil or WAR.LQZ[var_32_1] < 100) and var_32_4() and WAR.DZXY ~= 1 and WAR.ASKD ~= 1 then
		local var_32_172 = math.modf(var_32_49 / 10 + 1)
		local var_32_173 = math.random(var_32_172, var_32_172 + 5)

		if WAR.Person[arg_32_0].我方 == false then
			local var_32_174 = 0

			var_32_173 = var_32_173 + (JY.Base.游戏难度 == 1 and 1 or JY.Base.游戏难度 == 2 and 2 or JY.Base.游戏难度 == 3 and 3 or JY.Base.游戏难度 == 4 and 4 or JY.Base.游戏难度 == 5 and 5 or 6)
		end

		if cxtd(var_32_1, 54) and WAR.YCZHL[var_32_1] ~= nil and WAR.YCZHL[var_32_1] > 0 then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if JY.Person[var_32_1].主功体 == 95 then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 60) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if PersonKF(var_32_1, 92) then
			if JY.Person[var_32_1].主功体 == 92 then
				var_32_173 = math.modf(var_32_173 * 1.3)
			end
		else
			var_32_173 = math.modf(var_32_173 * 1.15)
		end

		if cxtd(var_32_1, 112) then
			var_32_173 = math.modf(var_32_173 * 3)
		end

		if cxtd(var_32_1, 132) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 141) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 588) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 176) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 121) then
			var_32_173 = math.modf(var_32_173 * 2)
		end

		if cxtd(var_32_1, 133) then
			var_32_173 = math.modf(var_32_173 * 0.75)
		end

		if cxtd(var_32_0, 134) then
			var_32_173 = math.modf(var_32_173 / 2)
		end

		if WAR.QDSX == 1 then
			var_32_173 = 0
		end

		if cxtd(var_32_0, 114) then
			WAR.LQZ[var_32_1] = 0
		end

		if (WAR.QQSHQ == 1 or WAR.QQSHQ == 2) and arg_32_1 == 73 then
			var_32_173 = 0
		end

		if cxtd(var_32_0, 589) then
			var_32_173 = 0
		end

		if WAR.QQSHQ == 1 and arg_32_1 == 73 then
			if WAR.LQZ[var_32_1] == nil then
				WAR.LQZ[var_32_1] = 0
			else
				WAR.LQZ[var_32_1] = WAR.LQZ[var_32_1] - 20
			end
		end

		if WAR.QQSHQ == 2 and arg_32_1 == 73 then
			if WAR.LQZ[var_32_1] == nil then
				WAR.LQZ[var_32_1] = 0
			else
				WAR.LQZ[var_32_1] = WAR.LQZ[var_32_1] - 40
			end
		end

		if JY.Person[var_32_0].主功体 == 96 and arg_32_1 == 82 then
			if WAR.LQZ[var_32_1] == nil then
				WAR.LQZ[var_32_1] = 0
			else
				WAR.LQZ[var_32_1] = WAR.LQZ[var_32_1] - 20
			end
		end

		if cxtd(var_32_1, 153) and WAR.LQZ[var_32_0] ~= nil then
			WAR.LQZ[var_32_0] = WAR.LQZ[var_32_0] - 100

			if WAR.LQZ[var_32_0] < 0 then
				WAR.LQZ[var_32_0] = 0
			end
		end

		if (PersonKF(var_32_1, 14) and PersonKF(var_32_1, 98) or cxtd(var_32_1, 103)) and WAR.LQZ[var_32_0] ~= nil then
			WAR.LQZ[var_32_1] = WAR.LQZ[var_32_0] - 10

			if WAR.LQZ[var_32_1] == 90 then
				WAR.LQZ[var_32_0] = 0
			end

			if WAR.LQZ[var_32_0] < 0 then
				WAR.LQZ[var_32_0] = 0
			end

			if WAR.Person[arg_32_0].特效文字1 ~= nil then
				WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "无我无相"
			else
				WAR.Person[arg_32_0].特效文字1 = "无我无相"
			end
		end

		if cxtd(var_32_0, 39) or cxtd(var_32_0, 40) and arg_32_1 == 102 then
			var_32_173 = 0
		end

		if cxtd(var_32_1, 5070) then
			var_32_173 = var_32_173 + 2
		end

		if cxtd(var_32_1, 5072) then
			var_32_173 = var_32_173 + 4
		end

		if Curr_NG(var_32_0, 102) and WAR.L_SGJL == 102 then
			if WAR.LQZ[var_32_1] ~= nil then
				WAR.LQZ[var_32_1] = WAR.LQZ[var_32_1] - var_32_173
			end
		elseif WAR.LQZ[var_32_1] == nil then
			WAR.LQZ[var_32_1] = var_32_173 + 2
		else
			WAR.LQZ[var_32_1] = WAR.LQZ[var_32_1] + var_32_173 + 2
		end

		if cxtd(var_32_0, 72) then
			var_32_173 = math.modf(var_32_173 * 0.5)
		end

		if cxtd(var_32_1, 161) then
			var_32_173 = math.modf(var_32_173 * (1 + (JY.Person[var_32_1].生命最大值 - JY.Person[var_32_1].生命) / 1500))
		end

		if instruct_16(var_32_0) then
			for iter_32_63 = 0, WAR.PersonNum - 1 do
				if (WAR.Person[iter_32_63].人物编号 == 154 or WAR.Person[iter_32_63].人物编号 == 0 and JY.Base.畅想编号 == 154) and WAR.Person[iter_32_63].死亡 == false and WAR.Person[iter_32_63].我方 == WAR.Person[WAR.CurID].我方 then
					var_32_173 = math.modf(var_32_173 * 0.5)
				end
			end
		end

		if cxtd(var_32_0, 154) then
			local var_32_175 = math.modf(var_32_173 * 0.5)
		end

		if WAR.LQZ[var_32_1] ~= nil and WAR.LQZ[var_32_1] <= 0 then
			WAR.LQZ[var_32_1] = nil
		end

		if WAR.LQZ[var_32_1] ~= nil and WAR.LQZ[var_32_1] > 100 then
			WAR.LQZ[var_32_1] = 100
			WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] + 5

			if T1LEQ(var_32_1) and JY.Base.二次觉醒 == 1 then
				WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] + 10
			end

			WAR.Person[arg_32_0].特效动画 = 6

			if WAR.Person[arg_32_0].特效文字3 ~= nil then
				WAR.Person[arg_32_0].特效文字3 = WAR.Person[arg_32_0].特效文字3 .. "+" .. "怒气爆发"
			else
				WAR.Person[arg_32_0].特效文字3 = "怒气爆发"
			end
		end
	end

	if cxtd(var_32_1, 63) and JLSD(10, 50, var_32_0) and JY.Base.觉醒 == 1 then
		for iter_32_64 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_32_64].死亡 == false and WAR.Person[iter_32_64].我方 == WAR.Person[WAR.CurID].我方 then
				WAR.Person[iter_32_64].TimeAdd = WAR.Person[iter_32_64].TimeAdd - 200
			end
		end

		if WAR.Person[arg_32_0].特效动画 == nil then
			WAR.Person[arg_32_0].特效动画 = 85
		end

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "观海听涛"
		else
			WAR.Person[arg_32_0].特效文字1 = "观海听涛"
		end
	end

	if arg_32_1 == 62 and PersonKF(var_32_0, 54) and xiaobin(var_32_1) and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and var_32_1 ~= JY.Base["队伍" .. 1] and JLSD(10, 15, var_32_0) and (JY.Person[var_32_0].耍刀技巧 >= 180 or cxtd(var_32_0, 77)) then
		if JLSD(0, 80, var_32_1) then
			WAR.Person[arg_32_0].特效文字2 = "敌人混乱了"
			WAR.NPC[var_32_1] = 30
		else
			WAR.Person[arg_32_0].特效文字2 = "敌人混乱了"
			WAR.NPC2[var_32_1] = 100
			WAR.Person[arg_32_0].我方 = WAR.Person[WAR.CurID].我方
		end

		WAR.L_NYZH[var_32_1] = 1
	end

	if WAR.ASKD == 1 and var_32_4() then
		WAR.LQZ[var_32_1] = 0
	end

	if cxtd(var_32_0, 97) and var_32_1 ~= JY.Base["队伍" .. 1] and math.random(10) < 2 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[WAR.CurID].特效文字0 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "血手攻心"
		else
			WAR.Person[WAR.CurID].特效文字0 = "血手攻心"
		end

		WAR.Person[arg_32_0].我方 = WAR.Person[WAR.CurID].我方
	end

	if cxtd(var_32_0, 114) and var_32_1 ~= JY.Base["队伍" .. 1] and math.random(100) < 5 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 then
		local var_32_176 = JY.Person[var_32_1].畅想级别

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[WAR.CurID].特效文字0 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "我佛慈悲，还不速速醒悟"
		else
			WAR.Person[WAR.CurID].特效文字0 = "我佛慈悲，施主，还不速速醒悟"
		end

		if var_32_176 < 5 and JLSD(0, var_32_176 - var_32_176, var_32_1) then
			WAR.Person[arg_32_0].我方 = WAR.Person[WAR.CurID].我方
		end
	end

	if WAR.ZDDH == 205 and var_32_1 == 141 then
		WAR.Person[arg_32_0].生命点数 = -JY.Person[var_32_1].生命
		JY.Person[var_32_1].生命 = 0
	end

	if cxtd(var_32_0, 48) then
		local var_32_177 = math.modf((340 - JY.Person[var_32_1].抗毒能力 - JY.Person[var_32_1].内力 / 50) / 4)

		if var_32_177 < 0 then
			var_32_177 = 0
		end

		WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", var_32_177)
	end

	if arg_32_1 == 13 and JLSD(30, 90, var_32_0) and JY.Person[var_32_0].拳掌功夫 >= 100 then
		AddPersonAttrib(var_32_1, "受伤程度", 20)
	end

	if var_32_49 > 0 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and (not var_32_0 == 35 or not var_32_0 == 26 or not var_32_0 == 73) and WAR.BMXH1 == 1 and (JY.Person[var_32_0].内力性质 == 1 or JY.Person[var_32_0].内力性质 == 0) then
		AddPersonAttrib(var_32_0, "受伤程度", 10)
	end

	if not cxtd(var_32_0, 0) and var_32_49 > 0 and WAR.Person[arg_32_0].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.BMXH1 == 1 and (JY.Person[var_32_0].内力性质 == 1 or JY.Person[var_32_0].内力性质 == 0) then
		AddPersonAttrib(var_32_0, "受伤程度", 10)
	end

	if arg_32_1 == 23 and cxtd(var_32_0, 13) then
		AddPersonAttrib(var_32_1, "受伤程度", 20)
	end

	if WAR.XSZJ == 5 then
		AddPersonAttrib(var_32_1, "受伤程度", 10)
	end

	if WAR.XSZJ == 6 then
		AddPersonAttrib(var_32_1, "受伤程度", 20)
	end

	if JY.Person[var_32_0].内力性质 == 1 and WAR.L_SGJL == 106 then
		AddPersonAttrib(var_32_1, "受伤程度", 10)
	end

	if cxtd(var_32_0, 152) and arg_32_1 == 44 then
		AddPersonAttrib(var_32_1, "受伤程度", 20)
	end

	if arg_32_1 == 21 and JY.Person[var_32_0].内力性质 == 0 and JY.Person[var_32_0].拳掌功夫 >= 220 then
		local var_32_178 = 40

		for iter_32_65 = 1, CC.Kungfunum do
			if JY.Person[var_32_0]["武功" .. iter_32_65] == 3 or JY.Person[var_32_0]["武功" .. iter_32_65] == 5 then
				var_32_178 = var_32_178 + 15
			end
		end

		if JLSD(10, 10 + var_32_178) then
			AddPersonAttrib(var_32_1, "受伤程度", 10)

			WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", 20)
		end
	end

	if cxtd(var_32_0, 164) and JLSD(30, 80, var_32_0) then
		AddPersonAttrib(var_32_1, "受伤程度", 10)

		WAR.Person[arg_32_0].中毒点数 = (WAR.Person[arg_32_0].中毒点数 or 0) + AddPersonAttrib(var_32_1, "中毒程度", 15)

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "碧针青掌"
		else
			WAR.Person[arg_32_0].特效文字1 = "碧针青掌"
		end
	end

	if var_32_1 == -1 then
		local var_32_179
		local var_32_180

		while true do
			local var_32_181 = math.random(63)
			local var_32_182 = math.random(63)

			if not SceneCanPass(var_32_181, var_32_182) or GetWarMap(var_32_181, var_32_182, 2) < 0 then
				SetWarMap(WAR.Person[arg_32_0].坐标X, WAR.Person[arg_32_0].坐标Y, 2, -1)
				SetWarMap(WAR.Person[arg_32_0].坐标X, WAR.Person[arg_32_0].坐标Y, 5, -1)

				WAR.Person[arg_32_0].坐标X = var_32_181
				WAR.Person[arg_32_0].坐标Y = var_32_182

				SetWarMap(WAR.Person[arg_32_0].坐标X, WAR.Person[arg_32_0].坐标Y, 2, arg_32_0)
				SetWarMap(WAR.Person[arg_32_0].坐标X, WAR.Person[arg_32_0].坐标Y, 5, WAR.Person[arg_32_0].贴图)

				break
			end
		end
	end

	if JY.Person[var_32_1].生命 <= 0 and (instruct_16(var_32_0) or ybdw(var_32_0)) and var_32_4() and WAR.SZJPYX[var_32_1] == nil then
		local var_32_183 = {
			102,
			295,
			79,
			569,
			570,
			361
		}
		local var_32_184 = 0

		for iter_32_66 = 1, 6 do
			if WAR.ZDDH == var_32_183[iter_32_66] then
				AddPersonAttrib(var_32_0, "实战", -1)

				var_32_184 = 1
			end
		end

		if WAR.ZDDH == 82 and GetS(10, 0, 18, 0) == 1 then
			var_32_184 = 1
		end

		if WAR.ZDDH == 214 and GetS(10, 0, 19, 0) == 1 then
			var_32_184 = 1
		end

		if var_32_184 == 0 and inteam(var_32_0) then
			local var_32_185 = 1

			if var_32_1 < 826 and var_32_1 > 0 then
				local var_32_186 = WARSZJY[var_32_1]
			end

			WAR.SZJPYX[var_32_1] = 1
		end
	end

	if JY.Person[var_32_1].生命 <= 0 and cxtd(var_32_0, 28) then
		WAR.PYZ = WAR.PYZ + 1
	end

	if WAR.PYZ > 5 then
		WAR.PYZ = 5
	end

	if WAR.JZPZXS == 1 and WAR.ZYZ[var_32_1] > 50 then
		WAR.ZYZ[var_32_1] = WAR.ZYZ[var_32_1] - 5

		if WAR.ZYZ[var_32_1] < 50 then
			WAR.ZYZ[var_32_1] = 50
		end
	end

	local var_32_187 = 0

	if JY.Person[var_32_0].畅想级别 > 100 then
		var_32_187 = JY.Person[var_32_0].畅想级别 - 100
	else
		var_32_187 = JY.Person[var_32_0].畅想级别
	end

	if JY.Person[var_32_1].生命 <= 0 and WAR.ZYZ[var_32_0] < 150 or WAR.JZPZXS == 1 then
		WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + var_32_187

		if T1LEQ(var_32_0) and JY.Base.二次觉醒 == 1 or cxtd(var_32_0, 598) then
			WAR.ZYZ[var_32_0] = WAR.ZYZ[var_32_0] + var_32_187 + 10
		end
	end

	if (WAR.BMXH == 1 or WAR.BMXH1 == 1) and var_32_49 > 0 and var_32_4() then
		local var_32_188
		local var_32_189 = math.modf(JY.Person[var_32_1].内力 / 20 + math.random(10))

		WAR.Person[arg_32_0].内力点数 = (WAR.Person[arg_32_0].内力点数 or 0) + AddPersonAttrib(var_32_1, "内力", -var_32_189)
		WAR.Person[arg_32_0].内力最大值 = (WAR.Person[arg_32_0].内力最大值 or 0) + AddPersonAttrib(var_32_1, "内力最大值", -var_32_189 / 20)
		WAR.Person[WAR.CurID].内力点数 = (WAR.Person[WAR.CurID].内力点数 or 0) + AddPersonAttrib(var_32_0, "内力", math.modf(var_32_189 + 1))

		AddPersonAttrib(var_32_0, "内力最大值", math.modf(var_32_189 / 30 + 1))
	end

	if WAR.YTFS > 100 and T2SQ(var_32_1) and JY.Base.觉醒 == 1 then
		WAR.Person[arg_32_0].特效动画 = 6

		if WAR.Person[arg_32_0].特效文字1 ~= nil then
			WAR.Person[arg_32_0].特效文字1 = WAR.Person[arg_32_0].特效文字1 .. "+" .. "云体风身"
		else
			WAR.Person[arg_32_0].特效文字1 = "云体风身"
		end

		WAR.YTFS = -1
		WAR.YT1 = JY.Person[JY.Base.队伍1].武功2
		WAR.YT2 = JY.Person[JY.Base.队伍1].武功等级2
		JY.Person[JY.Base.队伍1].武功2 = arg_32_1
		JY.Person[JY.Base.队伍1].武功等级2 = 999
	end

	if WAR.BMXH2 == 1 and var_32_49 > 0 and var_32_4() then
		local var_32_190
		local var_32_191 = math.modf(JY.Person[var_32_1].内力 / 10 + 2)

		WAR.Person[arg_32_0].内力点数 = AddPersonAttrib(var_32_1, "内力", -var_32_191)
		WAR.Person[arg_32_0].中毒点数 = AddPersonAttrib(var_32_1, "中毒程度", 20)
	end

	if WAR.BMXH1 == 1 and not cxtd(var_32_1, 149) and var_32_49 > 0 and var_32_4() then
		local var_32_192 = Rnd(3) + 2
		local var_32_193 = Rnd(4) + 2
		local var_32_194 = 2 + Rnd(3)
		local var_32_195 = AddPersonAttrib(var_32_1, "体力", -var_32_192)
		local var_32_196 = AddPersonAttrib(var_32_0, "体力", var_32_194)

		if cxtd(var_32_0, 26) then
			var_32_195 = var_32_195 + AddPersonAttrib(var_32_1, "体力", -var_32_193)
			var_32_196 = var_32_196 + AddPersonAttrib(var_32_0, "体力", var_32_193)
		elseif not JLSD(10, 15, var_32_0) or PersonKF(var_32_0, 85) then
			-- Nothing
		else
			AddPersonAttrib(var_32_0, "受伤程度", var_32_192 * 5)
		end

		WAR.Person[arg_32_0].体力点数 = (WAR.Person[arg_32_0].体力点数 or 0) + var_32_195
		WAR.Person[WAR.CurID].体力点数 = (WAR.Person[WAR.CurID].体力点数 or 0) + var_32_196
	end

	if arg_32_1 == 64 and (var_32_0 == JY.Base.队伍1 or var_32_0 == JY.Base.畅想编号 or var_32_0 == 9999 and JY.Person[var_32_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 3 and var_32_49 > 0 then
		for iter_32_67 = 1, CC.Kungfunum do
			if JY.Person[JY.Base.队伍1]["武功" .. iter_32_67] == 64 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_32_67] == 999 then
				SetS(14, 3, 1, 4, GetS(14, 3, 1, 4) + 10)

				if GetS(14, 3, 1, 4) > 2000 then
					SetS(14, 3, 1, 4, 2000)
				end
			end
		end
	end

	if arg_32_1 == 28 and var_32_4() and var_32_49 > 0 and WAR.L_LZJFCC == 0 then
		if WAR.L_LZJF_ATK[var_32_0] ~= nil then
			WAR.L_LZJF_ATK[var_32_0] = WAR.L_LZJF_ATK[var_32_0] + 50
		else
			WAR.L_LZJF_ATK[var_32_0] = 50
		end

		if WAR.L_LZJF_ATK[var_32_0] > 300 then
			WAR.L_LZJF_ATK[var_32_0] = 300
		end

		WAR.L_LZJFCC = 1
	end

	if arg_32_1 == 36 and var_32_4() and var_32_49 > 0 and WAR.L_RYJFCC == 0 then
		if WAR.L_RYJF[var_32_0] ~= nil then
			WAR.L_RYJF[var_32_0] = WAR.L_RYJF[var_32_0] + 1
		else
			WAR.L_RYJF[var_32_0] = 1
		end

		if WAR.L_RYJF[var_32_0] > 5 then
			WAR.L_RYJF[var_32_0] = 5
		end

		WAR.L_RYJFCC = 1
	end

	if WAR.TZ_XZ == 1 and var_32_4() then
		WAR.TZ_XZ_SSH[var_32_1] = 1
	end

	WAR.NGHT = 0
	WAR.FLHS4 = 0
	WAR.L_SGHT = 0

	if WAR.Person[arg_32_0].特效文字2 == nil then
		WAR.Person[arg_32_0].特效文字2 = " "
	end

	if var_32_4() == false then
		WAR.Person[arg_32_0].特效动画 = -1
		WAR.Person[arg_32_0].特效文字0 = nil
		WAR.Person[arg_32_0].特效文字1 = nil
		WAR.Person[arg_32_0].特效文字2 = nil
		WAR.Person[arg_32_0].特效文字3 = nil
	end

	return limitX(var_32_49, 0, var_32_49)
end

function WarDrawMap(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6, arg_37_7)
	local var_37_0 = WAR.Person[WAR.CurID].坐标X
	local var_37_1 = WAR.Person[WAR.CurID].坐标Y

	arg_37_4 = arg_37_4 or JY.SubScene
	arg_37_5 = arg_37_5 or -1

	if arg_37_0 == 0 then
		lib.DrawWarMap(0, var_37_0, var_37_1, 0, 0, -1, arg_37_4)
	elseif arg_37_0 == 1 then
		if arg_37_4 == 0 or arg_37_4 == 2 or arg_37_4 == 3 or arg_37_4 == 4 or arg_37_4 == 39 then
			lib.DrawWarMap(1, var_37_0, var_37_1, arg_37_1, arg_37_2, -1, arg_37_4)
		else
			lib.DrawWarMap(2, var_37_0, var_37_1, arg_37_1, arg_37_2, -1, arg_37_4)
		end
	elseif arg_37_0 == 2 then
		lib.DrawWarMap(3, var_37_0, var_37_1, 0, 0, -1, arg_37_4)
	elseif arg_37_0 == 4 then
		lib.DrawWarMap(4, var_37_0, var_37_1, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6, arg_37_7)
	end

	if WAR.ZDSXS == 0 and CC.Base_S.血量显示 == 1 then
		My_ZCXX()
	end

	if WAR.ShowHead == 1 then
		WarShowHead()
	end

	CleanWarMap(6, -2)
end

function WarSelectEnemy()
	for iter_38_0 = 1, CC.Kungfunum do
		if WAR.Data["敌人" .. iter_38_0] > 0 then
			if WAR.Data["敌人" .. iter_38_0] == JY.Base.畅想编号 then
				if JY.Person[WAR.Data["敌人" .. iter_38_0]].生命 < JY.Person[WAR.Data["敌人" .. iter_38_0]].生命最大值 then
					JY.Person[WAR.Data["敌人" .. iter_38_0]].生命 = JY.Person[WAR.Data["敌人" .. iter_38_0]].生命最大值
				end

				if JY.Person[WAR.Data["敌人" .. iter_38_0]].内力 < JY.Person[WAR.Data["敌人" .. iter_38_0]].内力最大值 then
					JY.Person[WAR.Data["敌人" .. iter_38_0]].内力 = JY.Person[WAR.Data["敌人" .. iter_38_0]].内力最大值
				end

				if JY.Person[WAR.Data["敌人" .. iter_38_0]].体力 < CC.PersonAttribMax.体力 then
					JY.Person[WAR.Data["敌人" .. iter_38_0]].体力 = CC.PersonAttribMax.体力
				end
			end

			if WAR.ZDDH == 343 then
				if GetS(65, 11, 12, 5) == 46 then
					WAR.Data.敌人1 = 46
				elseif GetS(65, 11, 12, 5) == 60 then
					WAR.Data.敌人1 = 60
				elseif GetS(65, 11, 12, 5) == 62 then
					WAR.Data.敌人1 = 62
				elseif GetS(65, 11, 12, 5) == 98 then
					WAR.Data.敌人1 = 98
				end
			end

			if WAR.ZDDH == 344 then
				if GetS(65, 11, 12, 5) == 18 then
					WAR.Data.敌人1 = 18
				elseif GetS(65, 11, 12, 5) == 78 then
					WAR.Data.敌人1 = 78
				elseif GetS(65, 11, 12, 5) == 97 then
					WAR.Data.敌人1 = 97
				elseif GetS(65, 11, 12, 5) == 161 then
					WAR.Data.敌人1 = 161
				end
			end

			if WAR.ZDDH == 345 then
				if GetS(65, 11, 12, 5) == 4 then
					WAR.Data.敌人1 = 4
				elseif GetS(65, 11, 12, 5) == 61 then
					WAR.Data.敌人1 = 61
				elseif GetS(65, 11, 12, 5) == 99 then
					WAR.Data.敌人1 = 99
				elseif GetS(65, 11, 12, 5) == 44 then
					WAR.Data.敌人1 = 44
				elseif GetS(65, 11, 12, 5) == 100 then
					WAR.Data.敌人1 = 100
				elseif GetS(65, 11, 12, 5) == 29 then
					WAR.Data.敌人1 = 29
				elseif GetS(65, 11, 12, 5) == 157 then
					WAR.Data.敌人1 = 157
				elseif GetS(65, 11, 12, 5) == 602 then
					WAR.Data.敌人1 = 602
				elseif GetS(65, 11, 12, 5) == 628 then
					WAR.Data.敌人1 = 628
				elseif GetS(65, 11, 12, 5) == 162 then
					WAR.Data.敌人1 = 162
				end
			end

			local var_38_0 = JY.Person[551].武功4

			if WAR.ZDDH == 346 then
				WAR.Data.敌人1 = var_38_0
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 1 then
				WAR.Data.敌人1 = 329
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 2 then
				WAR.Data.敌人1 = 328
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 3 then
				WAR.Data.敌人1 = 327
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 4 then
				WAR.Data.敌人1 = 329
			end

			local var_38_1 = {
				177,
				178,
				179,
				180,
				181,
				182,
				183,
				191,
				201,
				221,
				261,
				281,
				291,
				340,
				350,
				399,
				400,
				452,
				453,
				454,
				497,
				508
			}
			local var_38_2 = var_38_1[math.random(#var_38_1)]

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 5 then
				WAR.Data.敌人1 = var_38_2
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 6 then
				WAR.Data.敌人1 = 605
			end

			if WAR.ZDDH == 295 and GetS(43, 38, 28, 5) == 11 then
				WAR.Data.敌人1 = 191
			end

			if WAR.ZDDH == 334 or WAR.ZDDH == 337 or WAR.ZDDH == 339 or WAR.ZDDH == 340 or WAR.ZDDH == 341 then
				if GetS(101, 38, 28, 5) == 41 then
					WAR.Data.地图 = 41
				elseif GetS(101, 38, 28, 5) == 101 then
					WAR.Data.地图 = 101
				elseif GetS(101, 38, 28, 5) == 129 then
					WAR.Data.地图 = 129
				end
			end

			if WAR.ZDDH == 226 and GetS(86, 1, 9, 5) == 1 then
				if GetS(86, 2, 1, 5) == 3 then
					WAR.Data.敌人1 = 5
				elseif GetS(86, 2, 2, 5) == 3 then
					WAR.Data.敌人1 = 27
				elseif GetS(86, 2, 3, 5) == 3 then
					WAR.Data.敌人1 = 114
				elseif GetS(86, 2, 4, 5) == 3 then
					WAR.Data.敌人1 = 50
				elseif GetS(86, 2, 5, 5) == 3 then
					WAR.Data.敌人1 = 114
					WAR.Data.敌人2 = 50
				elseif GetS(86, 2, 6, 5) == 3 then
					WAR.Data.敌人1 = 27
					WAR.Data.敌人2 = 114
				elseif GetS(86, 2, 7, 5) == 3 then
					WAR.Data.敌人1 = 5
					WAR.Data.敌人2 = 27
					WAR.Data.敌人3 = 114
				elseif GetS(86, 2, 8, 5) == 3 then
					WAR.Data.敌人1 = 5
					WAR.Data.敌人2 = 50
					WAR.Data.敌人3 = 114
				elseif GetS(86, 2, 9, 5) == 3 then
					WAR.Data.敌人1 = 5
					WAR.Data.敌人2 = 50
					WAR.Data.敌人3 = 27
				elseif GetS(86, 2, 10, 5) == 3 then
					WAR.Data.敌人1 = 50
					WAR.Data.敌人2 = 27
					WAR.Data.敌人3 = 114
					WAR.Data.敌人4 = 5
				end

				WAR.Data.敌方X1 = 45
				WAR.Data.敌方Y1 = 36
				WAR.Data.敌方X2 = 45
				WAR.Data.敌方Y2 = 28
				WAR.Data.敌方X3 = 52
				WAR.Data.敌方Y3 = 28
				WAR.Data.敌方X4 = 52
				WAR.Data.敌方Y4 = 36
			end

			if WAR.ZDDH == 211 and JY.Person[13].性别 == 1 then
				WAR.Data.敌人1 = 13
			end

			if WAR.ZDDH == 137 and JY.Person[50].性别 == 1 then
				WAR.Data.敌人1 = 50
			end

			if WAR.ZDDH == 226 and GetS(86, 20, 20, 5) == 3 then
				WAR.Data.敌人1 = 60
				WAR.Data.敌人2 = 103

				SetS(86, 20, 20, 5, 0)
			end

			if WAR.ZDDH == 79 then
				if GetS(86, 11, 12, 5) == 1 then
					WAR.Data.敌人1 = 62
				elseif GetS(28, 12, 18, 5) == 1 then
					local var_38_3 = {
						405,
						406,
						407,
						408
					}
					local var_38_4 = var_38_3[math.random(#var_38_3)]

					WAR.Data.敌人1 = var_38_4
				elseif GetS(28, 12, 18, 5) == 2 then
					WAR.Data.敌人1 = 252
				elseif GetS(28, 12, 18, 5) == 3 then
					local var_38_5 = {
						263,
						264,
						265
					}
					local var_38_6 = math.random(3)

					WAR.Data.敌人1 = var_38_5[var_38_6]
				elseif GetS(35, 15, 30, 5) == 2 then
					WAR.Data.敌人1 = 262
				elseif GetS(86, 15, 2, 5) > 0 then
					if GetS(86, 15, 2, 5) == 2 then
						local var_38_7 = {
							3,
							150,
							149,
							62,
							65,
							103,
							69,
							60,
							67,
							18,
							164,
							64
						}
						local var_38_8 = math.random(12)

						WAR.Data.敌人1 = var_38_7[var_38_8]
					elseif GetS(86, 15, 2, 5) == 3 then
						local var_38_9 = {
							102,
							129,
							112,
							140,
							129,
							64,
							26,
							60,
							57,
							19
						}
						local var_38_10 = math.random(10)

						WAR.Data.敌人1 = var_38_9[var_38_10]
					elseif GetS(86, 15, 2, 5) == 4 then
						local var_38_11 = {
							5,
							27,
							50,
							114,
							113,
							116
						}
						local var_38_12 = math.random(6)

						WAR.Data.敌人1 = var_38_11[var_38_12]
					end

					WAR.Data.敌方X1 = 45
					WAR.Data.敌方Y1 = 15
				end
			end

			if WAR.ZDDH == 185 then
				WAR.Data.敌人14 = 65
				WAR.Data.敌方X14 = 44
				WAR.Data.敌方Y14 = 22
				WAR.Data.敌人15 = 55
				WAR.Data.敌人16 = 56
				WAR.Data.敌方X15 = 44
				WAR.Data.敌方Y15 = 23
				WAR.Data.敌方X16 = 44
				WAR.Data.敌方Y16 = 24
			end

			if WAR.ZDDH == 92 and GetS(87, 31, 33, 5) == 1 then
				for iter_38_1 = 2, 5 do
					WAR.Data["敌人" .. iter_38_1] = -1
				end
			end

			if WAR.ZDDH == 91 and GetS(87, 31, 34, 5) == 1 then
				WAR.Data.敌人1 = 138

				for iter_38_2 = 2, 12 do
					WAR.Data["敌人" .. iter_38_2] = -1
				end
			end

			if WAR.ZDDH == 20 and GetS(87, 31, 35, 5) == 1 then
				WAR.Data.敌人1 = 9999
			end

			if WAR.ZDDH == 20 and GetS(87, 31, 35, 5) == 2 then
				WAR.Data.敌人1 = 92
			end

			if WAR.ZDDH == 1 and GetS(33, 15, 2, 5) == 1 then
				local var_38_13 = {
					508,
					509,
					510,
					517,
					531,
					532,
					540,
					541,
					685,
					693
				}
				local var_38_14 = math.random(10)

				WAR.Data.敌人1 = var_38_13[var_38_14]
			end

			if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 1 then
				WAR.Data.敌方X16 = 40
				WAR.Data.敌方Y16 = 40
				WAR.Data.敌方X17 = 40
				WAR.Data.敌方Y17 = 38
				WAR.Data.敌方X18 = 40
				WAR.Data.敌方Y18 = 42
			end

			if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 2 then
				for iter_38_3 = 1, 9 do
					WAR.Data["敌方X" .. iter_38_3] = 22
					WAR.Data["敌方Y" .. iter_38_3] = 32 + iter_38_3
				end

				for iter_38_4 = 10, 18 do
					WAR.Data["敌方X" .. iter_38_4] = 27
					WAR.Data["敌方Y" .. iter_38_4] = 32 + (iter_38_4 - 9)
				end
			end

			if JY.Base.游戏难度 > 2 and JY.Person[WAR.Data["敌人" .. iter_38_0]].武功等级1 ~= 999 and math.random(1) then
				JY.Person[WAR.Data["敌人" .. iter_38_0]].武功等级1 = 999
			end

			WAR.Person[WAR.PersonNum].人物编号 = WAR.Data["敌人" .. iter_38_0]
			WAR.Person[WAR.PersonNum].我方 = false
			WAR.Person[WAR.PersonNum].坐标X = WAR.Data["敌方X" .. iter_38_0]
			WAR.Person[WAR.PersonNum].坐标Y = WAR.Data["敌方Y" .. iter_38_0]
			WAR.Person[WAR.PersonNum].死亡 = false
			WAR.Person[WAR.PersonNum].人方向 = 1
			WAR.PersonNum = WAR.PersonNum + 1
		end
	end
end

function WarSelectTeam()
	WAR.PersonNum = 0

	if WAR.ZDDH == 79 then
		if GetS(86, 11, 12, 5) == 1 then
			WAR.Data.自动选择参战人1 = 0
			WAR.Data.我方X1 = 22
			WAR.Data.我方Y1 = 38
			WAR.Data.自动选择参战人2 = 59
			WAR.Data.我方X2 = 23
			WAR.Data.我方Y2 = 38
		elseif GetS(86, 15, 2, 5) > 0 then
			WAR.Data.自动选择参战人1 = GetS(86, 15, 1, 5)
		end
	end

	if WAR.ZDDH == 241 and JY.Base.畅想编号 == 29 then
		WAR.Data.自动选择参战人1 = 0
	end

	if WAR.ZDDH == 242 and JY.Base.畅想编号 == 29 then
		WAR.Data.自动选择参战人1 = 0
	end

	if WAR.ZDDH == 243 and JY.Base.畅想编号 == 29 then
		WAR.Data.自动选择参战人1 = 0
	end

	if WAR.ZDDH == 205 and JY.Base.畅想编号 == 35 then
		WAR.Data.自动选择参战人1 = 0
	end

	if WAR.ZDDH == 51 and JY.Base.畅想编号 == 36 then
		WAR.Data.自动选择参战人1 = 0
	end

	if WAR.ZDDH == 92 and GetS(87, 31, 33, 5) == 1 then
		WAR.Data.自动选择参战人1 = 0
		WAR.Data.我方X1 = 43
		WAR.Data.我方Y1 = 25
	end

	if WAR.ZDDH == 91 and GetS(87, 31, 34, 5) == 1 then
		WAR.Data.自动选择参战人1 = 0
		WAR.Data.我方X1 = 21
		WAR.Data.我方Y1 = 28
	end

	if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 2 then
		for iter_39_0 = 1, 6 do
			WAR.Data["我方X" .. iter_39_0] = 25

			if iter_39_0 < 4 then
				WAR.Data["我方Y" .. iter_39_0] = 38 - iter_39_0
			else
				WAR.Data["我方Y" .. iter_39_0] = 38 + (iter_39_0 - 4)
			end
		end
	end

	if WAR.ZDDH == 226 and GetS(86, 1, 9, 5) == 1 then
		for iter_39_1 = 1, 6 do
			WAR.Data["我方X" .. iter_39_1] = 48

			if iter_39_1 < 4 then
				WAR.Data["我方Y" .. iter_39_1] = 34 - iter_39_1
			else
				WAR.Data["我方Y" .. iter_39_1] = 34 + (iter_39_1 - 4)
			end
		end
	end

	if WAR.ZDDH == 79 and GetS(86, 15, 2, 5) > 0 then
		WAR.Data.我方X1 = 51
		WAR.Data.我方Y1 = 15
	end

	local var_39_0 = 0

	for iter_39_2 = 1, 6 do
		local var_39_1 = WAR.Data["自动选择参战人" .. iter_39_2]

		if var_39_1 >= 0 then
			WAR.Person[WAR.PersonNum].人物编号 = var_39_1
			WAR.Person[WAR.PersonNum].我方 = true
			WAR.Person[WAR.PersonNum].坐标X = WAR.Data["我方X" .. iter_39_2]
			WAR.Person[WAR.PersonNum].坐标Y = WAR.Data["我方Y" .. iter_39_2]
			WAR.Person[WAR.PersonNum].死亡 = false
			WAR.Person[WAR.PersonNum].人方向 = 2
			WAR.PersonNum = WAR.PersonNum + 1

			if WAR.Data.自动选择参战人1 == 0 then
				var_39_0 = 1
			end
		end
	end

	if var_39_0 == 1 and (JY.Base.佣兵1 > -1 or JY.Base.佣兵2 > -1 or JY.Base.佣兵3 > -1) and JY.Base.佣兵出战 > -1 then
		WAR.Person[WAR.PersonNum].人物编号 = JY.Base.佣兵出战
		WAR.Person[WAR.PersonNum].我方 = true
		WAR.Person[WAR.PersonNum].坐标X = WAR.Data.我方X1 + 1
		WAR.Person[WAR.PersonNum].坐标Y = WAR.Data.我方Y1
		WAR.Person[WAR.PersonNum].死亡 = false
		WAR.Person[WAR.PersonNum].人方向 = 2
		WAR.PersonNum = WAR.PersonNum + 1
	end

	if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 2 then
		WAR.PersonNum = 0
	end

	if WAR.PersonNum > 0 and WAR.ZDDH ~= 235 then
		return
	end

	for iter_39_3 = 1, CC.TeamNum do
		WAR.SelectPerson[iter_39_3] = 0

		local var_39_2 = JY.Base["队伍" .. iter_39_3]

		if var_39_2 >= 0 then
			for iter_39_4 = 1, 6 do
				if WAR.Data["手动选择参战人" .. iter_39_4] == var_39_2 then
					WAR.SelectPerson[iter_39_3] = 1
				end
			end
		end
	end

	local var_39_3 = {}

	for iter_39_5 = 1, CC.TeamNum do
		var_39_3[iter_39_5] = {
			"",
			WarSelectMenu,
			0
		}

		local var_39_4 = JY.Base["队伍" .. iter_39_5]

		if var_39_4 >= 0 then
			var_39_3[iter_39_5][3] = 1

			local var_39_5 = JY.Person[var_39_4].姓名

			if WAR.SelectPerson[iter_39_5] == 1 then
				var_39_3[iter_39_5][1] = "*" .. var_39_5
			else
				var_39_3[iter_39_5][1] = " " .. var_39_5
			end
		end
	end

	var_39_3[CC.TeamNum + 1] = {
		" 全部出战",
		nil,
		1
	}
	var_39_3[CC.TeamNum + 2] = {
		" 结束",
		nil,
		1
	}

	repeat
		Cls()

		local var_39_6 = (CC.ScreenW - 7 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2

		DrawStrBox(var_39_6, 10, "请选择参战人物", C_WHITE, CC.DefaultFont)

		if ShowMenu(var_39_3, CC.TeamNum + 2, 0, var_39_6, 10 + CC.SingleLineHeight, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE) == CC.TeamNum + 1 then
			for iter_39_6 = 1, CC.TeamNum do
				if JY.Base["队伍" .. iter_39_6] >= 0 then
					WAR.SelectPerson[iter_39_6] = 1
				end
			end
		end

		Cls()

		for iter_39_7 = 1, 6 do
			if WAR.SelectPerson[iter_39_7] > 0 then
				WAR.Person[WAR.PersonNum].人物编号 = JY.Base["队伍" .. iter_39_7]
				WAR.Person[WAR.PersonNum].我方 = true
				WAR.Person[WAR.PersonNum].坐标X = WAR.Data["我方X" .. iter_39_7]
				WAR.Person[WAR.PersonNum].坐标Y = WAR.Data["我方Y" .. iter_39_7]
				WAR.Person[WAR.PersonNum].死亡 = false
				WAR.Person[WAR.PersonNum].人方向 = 2
				WAR.PersonNum = WAR.PersonNum + 1
			end
		end

		local var_39_7 = 0

		for iter_39_8 = 7, CC.TeamNum do
			if WAR.SelectPerson[iter_39_8] > 0 then
				var_39_7 = 1

				break
			end
		end

		if WAR.PersonNum > 0 or var_39_7 == 1 then
			break
		end
	until WAR.PersonNum > 0

	for iter_39_9 = 1, CC.YbNum do
		WAR.YbPerson[iter_39_9] = 0
	end

	if (JY.Base.佣兵1 > -1 or JY.Base.佣兵2 > -1 or JY.Base.佣兵3 > -1) and DrawStrBoxYesNo(-1, -1, "是否带佣兵出战？", C_WHITE, CC.DefaultFont) == true then
		local var_39_8 = {}

		for iter_39_10 = 1, CC.YbNum do
			var_39_8[iter_39_10] = {
				"",
				YbPerson,
				0
			}

			local var_39_9 = JY.Base["佣兵" .. iter_39_10]

			if var_39_9 >= 0 then
				var_39_8[iter_39_10][3] = 1

				local var_39_10 = JY.Person[var_39_9].姓名

				if WAR.YbPerson[iter_39_10] == 1 then
					var_39_8[iter_39_10][1] = "#" .. var_39_10
					WAR.YbPerson[iter_39_10] = 1
				else
					var_39_8[iter_39_10][1] = " " .. var_39_10
					WAR.YbPerson[iter_39_10] = 0
				end
			end
		end

		var_39_8[CC.YbNum + 1] = {
			" 结束",
			nil,
			1
		}

		repeat
			Cls()

			local var_39_11 = (CC.ScreenW - 7 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2

			DrawStrBox(var_39_11, 10, "请选择参战人物", C_WHITE, CC.DefaultFont)

			local var_39_12 = ShowMenu(var_39_8, CC.YbNum + 1, 0, var_39_11, 10 + CC.SingleLineHeight, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

			Cls()

			for iter_39_11 = 1, 3 do
				if WAR.YbPerson[iter_39_11] > 0 then
					WAR.Person[WAR.PersonNum].人物编号 = JY.Base["佣兵" .. iter_39_11]
					WAR.Person[WAR.PersonNum].我方 = true
					WAR.Person[WAR.PersonNum].坐标X = WAR.Data["我方X" .. iter_39_11] + 1
					WAR.Person[WAR.PersonNum].坐标Y = WAR.Data["我方Y" .. iter_39_11]
					WAR.Person[WAR.PersonNum].死亡 = false
					WAR.Person[WAR.PersonNum].人方向 = 2
					WAR.PersonNum = WAR.PersonNum + 1
				end
			end
		until WAR.PersonNum > 0
	end
end

function WarCalPersonPic(arg_40_0)
	return 5106 + JY.Person[WAR.Person[arg_40_0].人物编号].头像代号 * 8 + WAR.Person[arg_40_0].人方向 * 2
end

function WarSelectMenu(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0[arg_41_1][4]

	if WAR.SelectPerson[var_41_0] == 0 then
		WAR.SelectPerson[var_41_0] = 2
	elseif WAR.SelectPerson[var_41_0] == 2 then
		WAR.SelectPerson[var_41_0] = 0
	end

	if WAR.SelectPerson[var_41_0] > 0 then
		arg_41_0[arg_41_1][1] = "*" .. string.sub(arg_41_0[arg_41_1][1], 2)
	else
		arg_41_0[arg_41_1][1] = " " .. string.sub(arg_41_0[arg_41_1][1], 2)
	end

	return 0
end

function War_isEnd()
	for iter_42_0 = 0, WAR.PersonNum - 1 do
		if JY.Person[WAR.Person[iter_42_0].人物编号].生命 <= 0 then
			WAR.Person[iter_42_0].死亡 = true
		end
	end

	WarSetPerson()
	Cls()
	ShowScreen()

	local var_42_0 = 0
	local var_42_1 = 0

	for iter_42_1 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_42_1].死亡 == false then
			if WAR.Person[iter_42_1].我方 == true then
				var_42_0 = 1
			else
				var_42_1 = 1
			end
		end
	end

	if var_42_1 == 0 then
		return 1
	end

	if var_42_0 == 0 then
		return 2
	end

	return 0
end

function WarShowHead(arg_43_0)
	arg_43_0 = arg_43_0 or WAR.CurID

	if arg_43_0 < 0 then
		return
	end

	local var_43_0 = WAR.Person[arg_43_0].人物编号
	local var_43_1 = JY.Person[var_43_0]
	local var_43_2 = CC.DefaultFont
	local var_43_3 = CC.Fontsmall * 10 + 2 * CC.MenuBorderPixel
	local var_43_4 = (CC.Fontsmall + CC.RowPixel) * 12 + 5 * CC.MenuBorderPixel
	local var_43_5
	local var_43_6
	local var_43_7 = 1

	if WAR.Person[arg_43_0].我方 == true then
		var_43_5 = CC.ScreenW - var_43_3 - 10
		var_43_6 = CC.ScreenH - var_43_4 - CC.ScreenH / 6

		DrawBox(var_43_5, var_43_6, var_43_5 + var_43_3, var_43_6 + var_43_4 + CC.ScreenH / 6, C_WHITE)
	else
		var_43_5 = 10
		var_43_6 = 10

		DrawBox(var_43_5, var_43_6, var_43_5 + var_43_3, var_43_6 + var_43_4 + 30, C_WHITE)
	end

	if Curr_NG(var_43_0, 171) then
		local var_43_8 = WAR.TJZX[var_43_0] or 0

		if WAR.Person[arg_43_0].我方 == true then
			DrawString(var_43_5 - size * 6 - CC.RowPixel, CC.ScreenH - size - CC.RowPixel, "太极之形：" .. var_43_8, C_WHITE, size)
		else
			DrawString(var_43_5 + var_43_3 + CC.RowPixel, CC.RowPixel, "太极之形：" .. var_43_8, C_WHITE, size)
		end
	end

	local var_43_9, var_43_10 = lib.GetPNGXY(1, var_43_1.头像代号)
	local var_43_11 = (var_43_3 - var_43_9) / 2
	local var_43_12 = (CC.ScreenH / 5 - var_43_10) / 2

	if JY.Base.畅想编号 == 0 then
		if var_43_0 == 0 or var_43_0 == 9999 and JY.Person[9999].姓名 == JY.Person[0].姓名 then
			if JY.Base.主角职业 < 10 then
				if JY.Person[0].性别 == 0 then
					lib.LoadPNG(1, (280 + JY.Base.主角职业) * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
				else
					lib.LoadPNG(1, (501 + JY.Base.主角职业) * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
				end
			else
				lib.LoadPNG(1, (289 + JY.Base.特殊主角) * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
			end
		elseif var_43_0 == 445 and WAR.ZDDH == 226 then
			lib.LoadPNG(1, 516, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
		else
			lib.LoadPNG(1, var_43_1.头像代号 * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
		end
	elseif var_43_0 == 0 then
		if JY.Base.主角职业 < 10 then
			lib.LoadPNG(1, var_43_1.头像代号 * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
		else
			lib.LoadPNG(1, var_43_1.头像代号 * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
		end
	elseif var_43_0 == 445 and WAR.ZDDH == 226 then
		lib.LoadPNG(1, 516, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
	else
		lib.LoadPNG(1, var_43_1.头像代号 * 2, var_43_5 + 5 + var_43_11, var_43_6 + 5 + var_43_12, 1)
	end

	local var_43_13 = var_43_5 + CC.RowPixel
	local var_43_14 = var_43_6 + CC.RowPixel + CC.ScreenH / 6 + var_43_2
	local var_43_15

	if var_43_1.受伤程度 < var_43_1.中毒程度 then
		if var_43_1.中毒程度 == 0 then
			var_43_15 = RGB(252, 148, 16)
		elseif var_43_1.中毒程度 < 50 then
			var_43_15 = RGB(120, 208, 88)
		else
			var_43_15 = RGB(56, 136, 36)
		end
	elseif var_43_1.受伤程度 < 33 then
		var_43_15 = RGB(236, 200, 40)
	elseif var_43_1.受伤程度 < 66 then
		var_43_15 = RGB(244, 128, 32)
	else
		var_43_15 = RGB(232, 32, 44)
	end

	MyDrawString(var_43_13, var_43_13 + var_43_3, var_43_14 + CC.RowPixel, var_43_1.姓名, var_43_15, CC.DefaultFont)

	local var_43_16 = var_43_14 + CC.DefaultFont + CC.RowPixel

	DrawString(var_43_13 + 3, var_43_16 + CC.RowPixel, "命:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3, var_43_16 + CC.RowPixel + CC.Fontsmall, "内:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3, var_43_16 + 2 * (CC.RowPixel + CC.Fontsmall), "体:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3, var_43_16 + 3 * (CC.RowPixel + CC.Fontsmall), "怒气:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3, var_43_16 + 4 * (CC.RowPixel + CC.Fontsmall), "中毒:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3, var_43_16 + 5 * (CC.RowPixel + CC.Fontsmall), "内伤:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3 + 5 * CC.Fontsmall, var_43_16 + 4 * (CC.RowPixel + CC.Fontsmall), "灼烧:", C_ORANGE, CC.Fontsmall)

	local var_43_17 = var_43_1.生命 .. "/" .. var_43_1.生命最大值
	local var_43_18 = var_43_1.内力 .. "/" .. var_43_1.内力最大值
	local var_43_19 = var_43_1.体力 .. "/100"
	local var_43_20 = WAR.LQZ[var_43_0] or 0
	local var_43_21 = var_43_1.中毒程度
	local var_43_22 = var_43_1.受伤程度
	local var_43_23 = var_43_1.中封穴
	local var_43_24 = var_43_1.流血值
	local var_43_25 = var_43_1.中冰毒
	local var_43_26 = var_43_1.中火毒

	if var_43_1.受伤程度 < 33 then
		var_43_15 = RGB(236, 200, 40)
	elseif var_43_1.受伤程度 < 66 then
		var_43_15 = RGB(244, 128, 32)
	else
		var_43_15 = RGB(232, 32, 44)
	end

	DrawString(var_43_13 + 3 + 2 * CC.Fontsmall, var_43_16 + CC.RowPixel, var_43_17, var_43_15, CC.Fontsmall)

	if var_43_1.内力性质 == 0 then
		var_43_15 = RGB(208, 152, 208)
	elseif var_43_1.内力性质 == 1 then
		var_43_15 = RGB(236, 200, 40)
	else
		var_43_15 = RGB(236, 236, 236)
	end

	if JY.Base.主角职业 == 5 and var_43_0 == 0 then
		var_43_15 = RGB(216, 20, 24)
	end

	local var_43_27

	if math.modf(WAR.ZYZ[var_43_0]) < 70 then
		var_43_27 = RGB(236, 200, 40)
	elseif math.modf(WAR.ZYZ[var_43_0]) > 130 then
		var_43_27 = RGB(254, 250, 24)
	else
		var_43_27 = RGB(247, 128, 32)
	end

	DrawString(var_43_13 + 13 + 7 * CC.Fontsmall, var_43_16 + 4 * (CC.RowPixel + CC.Fontsmall), var_43_26, C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3 + 2 * CC.Fontsmall, var_43_16 + CC.RowPixel + CC.Fontsmall, var_43_18, var_43_15, CC.Fontsmall)
	DrawString(var_43_13 + 3 + 2 * CC.Fontsmall, var_43_16 + 2 * (CC.RowPixel + CC.Fontsmall), var_43_19, C_GOLD, CC.Fontsmall)
	DrawString(var_43_13 + 3 + 3 * CC.Fontsmall, var_43_16 + 3 * (CC.RowPixel + CC.Fontsmall), var_43_20, RGB(244, 128, 32), CC.Fontsmall)
	DrawString(var_43_13 + 3 + 3 * CC.Fontsmall, var_43_16 + 4 * (CC.RowPixel + CC.Fontsmall), var_43_21, RGB(120, 208, 88), CC.Fontsmall)
	DrawString(var_43_13 + 3 + 3 * CC.Fontsmall, var_43_16 + 5 * (CC.RowPixel + CC.Fontsmall), var_43_22, M_DarkSlateGray, CC.Fontsmall)

	local var_43_28 = var_43_16 + 5 * (CC.RowPixel + CC.Fontsmall)
	local var_43_29 = 3
	local var_43_30 = 0
	local var_43_31 = var_43_29 + CC.Fontsmall * 5

	DrawString(var_43_13 + var_43_31, var_43_28, "流血:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + var_43_31 + CC.Fontsmall * 2 + 10, var_43_28, var_43_24, M_DarkRed, CC.Fontsmall)

	local var_43_32 = 3
	local var_43_33 = CC.RowPixel + CC.Fontsmall

	DrawString(var_43_13 + var_43_32, var_43_28 + var_43_33, "封穴:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + 3 + 3 * CC.Fontsmall, var_43_28 + var_43_33, var_43_23, C_GOLD, CC.Fontsmall)

	local var_43_34 = var_43_32 + CC.Fontsmall * 5

	DrawString(var_43_13 + var_43_34, var_43_28 + var_43_33, "冰封:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + var_43_34 + CC.Fontsmall * 5 / 2, var_43_28 + var_43_33, var_43_25, M_RoyalBlue, CC.Fontsmall)
	DrawString(var_43_13 + CC.Fontsmall - 25, var_43_28 + var_43_33 + 28, "主功体：", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + CC.Fontsmall * 8 / 2, var_43_28 + var_43_33 + 28, JY.Wugong[var_43_1.主功体].名称, RGB(250, 6, 6), CC.Fontsmall)
	DrawString(var_43_13 + var_43_34, var_43_28 - CC.Fontsmall * 2 - 13, "战意:", C_ORANGE, CC.Fontsmall)
	DrawString(var_43_13 + var_43_34 + CC.Fontsmall * 5 / 2, var_43_28 - CC.Fontsmall * 2 - 13, math.modf(WAR.ZYZ[var_43_0]), var_43_27, CC.Fontsmall)

	local var_43_35 = var_43_28 + var_43_33
	local var_43_36 = 3
	local var_43_37 = CC.RowPixel + CC.Fontsmall

	if WAR.Person[arg_43_0].我方 then
		DrawString(var_43_13 + CC.Fontsmall - 25, var_43_35 + var_43_37 + 20, "副功体：", C_ORANGE, CC.Fontsmall)
		DrawString(var_43_13 + CC.Fontsmall * 8 / 2, var_43_35 + var_43_37 + 20, JY.Wugong[var_43_1.副功体].名称, RGB(250, 6, 6), CC.Fontsmall)
		DrawString(var_43_13 + CC.Fontsmall - 25, var_43_35 + var_43_37 + 42, "轻功：", C_ORANGE, CC.Fontsmall)
		DrawString(var_43_13 + CC.Fontsmall * 8 / 2, var_43_35 + var_43_37 + 42, JY.Wugong[var_43_1.主运轻功].名称, RGB(250, 6, 6), CC.Fontsmall)

		local var_43_38 = 0

		for iter_43_0, iter_43_1 in pairs(CC.AddAtk) do
			if iter_43_1[1] == var_43_0 then
				for iter_43_2 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_43_2].人物编号 == iter_43_1[2] and WAR.Person[iter_43_2].死亡 == false then
						var_43_38 = var_43_38 + iter_43_1[3]
					end
				end
			end
		end

		local var_43_39 = 0

		for iter_43_3, iter_43_4 in pairs(CC.AddDef) do
			if iter_43_4[1] == var_43_0 then
				for iter_43_5 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_43_5].人物编号 == iter_43_4[2] and WAR.Person[iter_43_5].死亡 == false then
						var_43_39 = var_43_39 + iter_43_4[3]
					end
				end
			end
		end

		local var_43_40 = 0

		for iter_43_6, iter_43_7 in pairs(CC.AddSpd) do
			if iter_43_7[1] == var_43_0 then
				for iter_43_8 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_43_8].人物编号 == iter_43_7[2] and WAR.Person[iter_43_8].死亡 == false then
						var_43_40 = var_43_40 + iter_43_7[3]
					end
				end
			end
		end

		local var_43_41 = C_ORANGE
		local var_43_42 = var_43_41
		local var_43_43 = var_43_41
		local var_43_44 = var_43_41

		if var_43_38 > 0 then
			var_43_42 = RGB(204, 255, 102)
		end

		if var_43_39 > 0 then
			var_43_43 = RGB(204, 255, 102)
		end

		if var_43_40 > 0 then
			var_43_44 = RGB(204, 255, 102)
		end

		DrawString(var_43_13 + 3, var_43_35 + var_43_37 + 70, "攻:+" .. var_43_38, var_43_42, CC.Fontsmall)
		DrawString(var_43_13 + CC.Fontsmall * 7 / 2, var_43_35 + var_43_37 + 67, "防:+" .. var_43_39, var_43_43, CC.Fontsmall)
		DrawString(var_43_13 + CC.Fontsmall * 13 / 2, var_43_35 + var_43_37 + 67, "轻:+" .. var_43_40, var_43_44, CC.Fontsmall)
	end

	if WAR.Person[arg_43_0].我方 == false then
		local var_43_45 = var_43_35 + 2 * (CC.RowPixel + CC.Fontsmall)

		DrawBox(var_43_13 - 5, var_43_45, var_43_13 + var_43_3 - 5, var_43_45 + CC.DefaultFont * 6, C_WHITE)

		local var_43_46 = 1

		for iter_43_9 = 1, 4 do
			local var_43_47 = var_43_1["携带物品" .. iter_43_9]
			local var_43_48 = var_43_1["携带物品数量" .. iter_43_9]

			if var_43_47 >= 0 then
				local var_43_49 = JY.Thing[var_43_47].名称

				DrawString(var_43_13, var_43_45 + var_43_46 * (CC.DefaultFont + CC.RowPixel), var_43_49 .. var_43_48, C_ORANGE, CC.DefaultFont)

				var_43_46 = var_43_46 + 1
			end
		end
	end
end

function War_AutoSelectWugong()
	local var_44_0 = WAR.Person[WAR.CurID].人物编号
	local var_44_1 = {}
	local var_44_2 = 20

	for iter_44_0 = 1, CC.Kungfunum do
		local var_44_3 = JY.Person[var_44_0]["武功" .. iter_44_0]

		if var_44_3 > 0 then
			if JY.Wugong[var_44_3].伤害类型 == 0 then
				if JY.Wugong[var_44_3].消耗内力点数 <= JY.Person[var_44_0].内力 then
					local var_44_4 = math.modf(JY.Person[var_44_0]["武功等级" .. iter_44_0] / 100) + 1

					var_44_1[iter_44_0] = (JY.Person[var_44_0].攻击力 * 3 + JY.Wugong[var_44_3]["攻击力" .. var_44_4]) / 2
				else
					var_44_1[iter_44_0] = 0
				end

				if JY.Wugong[var_44_3].武功类型 == 10 then
					var_44_1[iter_44_0] = 0
				end

				if var_44_3 == 43 and var_44_0 ~= 51 then
					var_44_1[iter_44_0] = 0
				end

				if var_44_3 == 67 and var_44_0 == 3 and WAR.ZDDH == 280 then
					var_44_1[iter_44_0] = 0
				end
			else
				var_44_1[iter_44_0] = 0
			end
		else
			var_44_2 = iter_44_0 - 1

			break
		end
	end

	if var_44_2 == 0 then
		return -1
	end

	local var_44_5 = 0

	for iter_44_1 = 1, var_44_2 do
		if var_44_5 < var_44_1[iter_44_1] then
			var_44_5 = var_44_1[iter_44_1]
		end
	end

	local var_44_6 = 0
	local var_44_7 = 0

	for iter_44_2 = 0, var_44_2 - 1 do
		if WAR.Person[iter_44_2].死亡 == false then
			if WAR.Person[iter_44_2].我方 == WAR.Person[WAR.CurID].我方 then
				var_44_6 = var_44_6 + 1
			else
				var_44_7 = var_44_7 + 1
			end
		end
	end

	local var_44_8 = 0
	local var_44_9 = var_44_6 < var_44_7 and 2 or 1

	for iter_44_3 = 1, var_44_2 do
		local var_44_10 = JY.Person[var_44_0]["武功" .. iter_44_3]

		if not (var_44_1[iter_44_3] > 0) or var_44_1[iter_44_3] < var_44_5 * 3 / 4 then
			-- Nothing
		else
			local var_44_11 = math.modf(JY.Person[var_44_0]["武功等级" .. iter_44_3] / 100) + 1

			var_44_1[iter_44_3] = var_44_1[iter_44_3] + JY.Wugong[var_44_10]["移动范围" .. var_44_11] * var_44_9 * 10

			if JY.Wugong[var_44_10]["杀伤范围" .. var_44_11] > 0 then
				var_44_1[iter_44_3] = var_44_1[iter_44_3] + JY.Wugong[var_44_10]["杀伤范围" .. var_44_11] * var_44_9 * 10
			end
		end
	end

	local var_44_12 = {}
	local var_44_13 = 0

	for iter_44_4 = 1, var_44_2 do
		var_44_12[iter_44_4] = var_44_13
		var_44_13 = var_44_13 + var_44_1[iter_44_4]
	end

	var_44_12[var_44_2 + 1] = var_44_13

	if var_44_13 == 0 then
		return -1
	end

	local var_44_14 = Rnd(var_44_13)
	local var_44_15 = 0

	for iter_44_5 = 1, var_44_2 do
		if var_44_14 >= var_44_12[iter_44_5] and var_44_14 < var_44_12[iter_44_5 + 1] then
			var_44_15 = iter_44_5
		end
	end

	return var_44_15
end

function War_FightMenu(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = WAR.Person[WAR.CurID].人物编号
	local var_45_1 = 0
	local var_45_2 = {}
	local var_45_3 = {}
	local var_45_4 = 0

	for iter_45_0 = 1, CC.Kungfunum do
		local var_45_5 = JY.Person[var_45_0]["武功" .. iter_45_0]
		local var_45_6 = WGWL(var_45_0, var_45_5, 10)

		if var_45_5 == 195 then
			var_45_6 = 999
		end

		if var_45_5 > 0 then
			if JY.WGLVXS == 1 then
				var_45_2[iter_45_0] = {
					JY.Wugong[var_45_5].名称 .. "+" .. JY.Person[var_45_0]["武功等级" .. iter_45_0],
					nil,
					1,
					var_45_6,
					iter_45_0
				}
			else
				var_45_2[iter_45_0] = {
					JY.Wugong[var_45_5].名称,
					nil,
					1,
					var_45_6,
					iter_45_0
				}
			end

			if JY.Person[var_45_0].内力 < JY.Wugong[var_45_5].消耗内力点数 then
				var_45_2[iter_45_0][3] = 0
			end

			if JY.Wugong[var_45_5].武功类型 == 10 then
				var_45_2[iter_45_0][3] = 0
			end

			var_45_1 = var_45_1 + 1
			var_45_4 = var_45_4 + 1
			var_45_3[var_45_4] = iter_45_0
		end
	end

	if var_45_1 == 0 then
		return 0
	end

	local var_45_7
	local var_45_8 = var_45_1

	if var_45_8 > CC.Kungfunum then
		var_45_8 = CC.Kungfunum
	end

	if var_45_8 > 0 then
		for iter_45_1 = 1, var_45_8 - 1 do
			for iter_45_2 = iter_45_1 + 1, var_45_8 do
				if var_45_2[iter_45_1][4] < var_45_2[iter_45_2][4] or var_45_2[iter_45_1][4] == var_45_2[iter_45_2][4] and var_45_2[iter_45_1][5] > var_45_2[iter_45_2][5] then
					var_45_2[iter_45_1], var_45_2[iter_45_2] = var_45_2[iter_45_2], var_45_2[iter_45_1]
				end
			end
		end
	end

	if var_45_4 == 0 then
		return 0
	end

	if arg_45_2 == nil then
		local var_45_9 = ShowMenu(var_45_2, var_45_1, var_45_8, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.FontSmall3, C_ORANGE, C_WHITE)

		if var_45_9 == 0 then
			return 0
		end

		WAR.ShowHead = 0

		local var_45_10 = War_Fight_Sub(WAR.CurID, var_45_2[var_45_9][5])

		WAR.ShowHead = 1

		Cls()

		return var_45_10
	elseif arg_45_2 <= var_45_4 then
		WAR.ShowHead = 0

		local var_45_11 = War_Fight_Sub(WAR.CurID, var_45_2[var_45_3[arg_45_2]][5])

		WAR.ShowHead = 1

		Cls()

		return var_45_11
	else
		return 0
	end

	if tmp == 195 then
		wgwl = 20
	end
end

function War_Think()
	WAR.ZDSXS = 0

	local var_46_0 = WAR.Person[WAR.CurID].人物编号
	local var_46_1 = -1

	if JY.Person[var_46_0].体力 < 10 then
		local var_46_2 = War_ThinkDrug(4)

		if var_46_2 >= 0 then
			return var_46_2
		end

		return 0
	end

	if JY.Person[var_46_0].生命 < 20 or JY.Person[var_46_0].受伤程度 > 50 then
		local var_46_3 = War_ThinkDrug(2)

		if var_46_3 >= 0 then
			return var_46_3
		end
	end

	local var_46_4 = -1

	if JY.Person[var_46_0].生命 < JY.Person[var_46_0].生命最大值 / 5 then
		var_46_4 = 90
	elseif JY.Person[var_46_0].生命 < JY.Person[var_46_0].生命最大值 / 4 then
		var_46_4 = 70
	elseif JY.Person[var_46_0].生命 < JY.Person[var_46_0].生命最大值 / 3 then
		var_46_4 = 50
	elseif JY.Person[var_46_0].生命 < JY.Person[var_46_0].生命最大值 / 2 then
		var_46_4 = 25
	end

	if var_46_4 > Rnd(100) and WAR.LQZ[var_46_0] ~= nil and WAR.LQZ[var_46_0] ~= 100 then
		local var_46_5 = War_ThinkDrug(2)

		if var_46_5 >= 0 then
			return var_46_5
		else
			local var_46_6 = War_ThinkDoctor()

			if var_46_6 >= 0 then
				return var_46_6
			end
		end
	end

	local var_46_7 = -1

	if JY.Person[var_46_0].内力 < JY.Person[var_46_0].内力最大值 / 6 then
		var_46_7 = 100
	elseif JY.Person[var_46_0].内力 < JY.Person[var_46_0].内力最大值 / 5 then
		var_46_7 = 75
	elseif JY.Person[var_46_0].内力 < JY.Person[var_46_0].内力最大值 / 4 then
		var_46_7 = 50
	end

	if JY.Person[var_46_0].生命 == JY.Person[var_46_0].生命最大值 then
		var_46_7 = var_46_7 - 50
	end

	if var_46_7 > Rnd(100) then
		local var_46_8 = War_ThinkDrug(3)

		if var_46_8 >= 0 then
			return var_46_8
		end
	end

	local var_46_9 = -1

	if CC.PersonAttribMax.中毒程度 * 3 / 4 < JY.Person[var_46_0].中毒程度 then
		var_46_9 = 60
	elseif CC.PersonAttribMax.中毒程度 / 2 < JY.Person[var_46_0].中毒程度 then
		var_46_9 = 30
	end

	if var_46_9 > Rnd(100) and JY.Person[var_46_0].生命 < JY.Person[var_46_0].生命最大值 / 2 then
		local var_46_10 = War_ThinkDrug(6)

		if var_46_10 >= 0 then
			return var_46_10
		end
	end

	return War_GetMinNeiLi(var_46_0) <= JY.Person[var_46_0].内力 and 1 or 0
end

function War_AutoFight()
	local var_47_0 = War_AutoSelectWugong()
	local var_47_1 = WAR.Person[WAR.CurID].人物编号

	if inteam(var_47_1) and JY.Person[var_47_1].喜使武功 ~= 0 then
		for iter_47_0 = 1, CC.Kungfunum do
			if JY.Person[var_47_1]["武功" .. iter_47_0] == JY.Person[var_47_1].喜使武功 then
				var_47_0 = iter_47_0

				break
			end
		end

		if var_47_0 == nil then
			var_47_0 = War_AutoSelectWugong()
		end
	else
		var_47_0 = War_AutoSelectWugong()
	end

	if var_47_0 <= 0 then
		War_AutoEscape()
		War_RestMenu()

		return
	end

	unnamed(var_47_0)
end

function War_Auto()
	local var_48_0 = WAR.Person[WAR.CurID].人物编号

	WAR.ShowHead = 1

	WarDrawMap(0)
	ShowScreen()
	lib.Delay(CC.WarAutoDelay)

	WAR.ShowHead = 0

	if CC.AutoWarShowHead == 1 then
		WAR.ShowHead = 1
	end

	local var_48_1 = War_Think()

	if instruct_16(var_48_0) or WAR.ZDDH == 238 then
		var_48_1 = JY.Person[var_48_0].内力 > 50 and JY.Person[var_48_0].体力 > 10 and 1 or 0
	end

	if var_48_1 == 1 and instruct_16(var_48_0) and JLSD(30, 50, var_48_0) and WAR.L_NYZH[var_48_0] ~= nil then
		var_48_1 = 7
	end

	if (var_48_1 == 1 or JY.Person[var_48_0].战斗控制 == 1) and instruct_16(var_48_0) and JLSD(10, 100, var_48_0) and JY.Person[var_48_0].战斗模式 ~= 1 then
		var_48_1 = (JY.Person[var_48_0].内力 < 200 or JY.Person[var_48_0].体力 < 50) and 7 or 8
	end

	if var_48_1 == 0 then
		War_AutoEscape()
		War_RestMenu()
	elseif var_48_1 == 1 then
		War_AutoFight()
	elseif var_48_1 == 2 then
		War_AutoEscape()
		War_AutoEatDrug(2)
	elseif var_48_1 == 3 then
		War_AutoEscape()
		War_AutoEatDrug(3)
	elseif var_48_1 == 4 then
		War_AutoEscape()
		War_AutoEatDrug(4)
	elseif var_48_1 == 5 then
		War_AutoEscape()
		War_AutoDoctor()
	elseif var_48_1 == 6 then
		War_AutoEscape()
		War_AutoEatDrug(6)
	elseif var_48_1 == 7 then
		CurIDTXDH(WAR.CurID, 89, 1, "休息一下")
		War_RestMenu()
	elseif var_48_1 == 8 then
		War_DefupMenu()
	end

	return 0
end

function War_AddPersonLVUP(arg_49_0)
	local var_49_0 = JY.Person[arg_49_0].等级

	if var_49_0 >= CC.Level then
		return false
	end

	if JY.Person[arg_49_0].经验 < CC.Exp[var_49_0 + 1] - CC.Exp[var_49_0] then
		return false
	end

	while CC.Exp[var_49_0 + 1] - CC.Exp[var_49_0] <= JY.Person[arg_49_0].经验 do
		var_49_0 = var_49_0 + 1
		JY.Person[arg_49_0].经验 = JY.Person[arg_49_0].经验 - (CC.Exp[var_49_0] - CC.Exp[var_49_0 - 1])

		if var_49_0 >= CC.Level then
			break
		end
	end

	DrawStrBoxWaitKey(string.format("%s 升级了", JY.Person[arg_49_0].姓名), C_WHITE, CC.DefaultFont)

	local var_49_1 = var_49_0 - JY.Person[arg_49_0].等级

	JY.Person[arg_49_0].等级 = JY.Person[arg_49_0].等级 + var_49_1

	if JY.Person[arg_49_0].等级 == 29 then
		AddPersonAttrib(arg_49_0, "生命增长", 1)

		if arg_49_0 == 0 then
			AddPersonAttrib(550, "生命增长", 1)
		end
	end

	if JY.Person[0].生命增长 > 18 then
		JY.Person[0].生命增长 = 18
	end

	AddPersonAttrib(arg_49_0, "生命最大值", JY.Person[arg_49_0].生命增长 * var_49_1)

	if JY.Person[arg_49_0].生命最大值 > JY.Person[arg_49_0].生命增长 * 100 then
		JY.Person[arg_49_0].生命最大值 = JY.Person[arg_49_0].生命增长 * 100 + Rnd(50)
	end

	JY.Person[arg_49_0].生命 = JY.Person[arg_49_0].生命最大值
	JY.Person[arg_49_0].体力 = CC.PersonAttribMax.体力
	JY.Person[arg_49_0].受伤程度 = 0
	JY.Person[arg_49_0].中毒程度 = 0

	local var_49_2 = (function ()
		local var_50_0
		local var_50_1

		if CC.Debug then
			var_50_1 = math.random(1)
		else
			var_50_1 = math.random(1)
		end

		return JY.Person[arg_49_0].悟性 / (var_50_1 + 4)
	end)()

	if JY.Person[arg_49_0].内力 > 0 then
		AddPersonAttrib(arg_49_0, "内力最大值", math.modf(var_49_1 * JY.Person[arg_49_0].生命增长 * 5 + 210 / (var_49_2 + 1)))

		if JY.Person[arg_49_0].内力最大值 > JY.Person[arg_49_0].生命增长 * 1000 then
			JY.Person[arg_49_0].内力最大值 = JY.Person[arg_49_0].生命增长 * 1000 + Rnd(50)
		end
	end

	if arg_49_0 == JY.Base.队伍1 and JY.Base.主角职业 == 5 then
		AddPersonAttrib(arg_49_0, "内力最大值", 50 * var_49_1)
	end

	JY.Person[arg_49_0].内力 = JY.Person[arg_49_0].内力最大值

	for iter_49_0 = 1, var_49_1 / 3 do
		local var_49_3 = math.modf(JY.Person[arg_49_0].生命增长 / 3)

		if not cxtd(arg_49_0, 35) or GetD(82, 1, 0) ~= 1 or JY.Base.畅想编号 == 35 then
			-- Nothing
		else
			var_49_3 = 0
		end

		if (cxtd(arg_49_0, 55) or cxtd(arg_49_0, 30)) and JY.Person[arg_49_0].等级 > 20 then
			var_49_3 = math.modf(JY.Person[55].生命增长 / 2)
		end

		if T1LEQ(arg_49_0) then
			var_49_3 = var_49_3 + 3
		end

		if cxtd(arg_49_0, 92) then
			var_49_3 = var_49_3 + math.random(2)
		end

		if ybdw(arg_49_0) then
			var_49_3 = math.modf(var_49_3 - var_49_3 / 3)
		end

		local var_49_4 = 11 - JY.Base.游戏难度

		if var_49_4 < 0 then
			var_49_4 = 0
		end

		local var_49_5 = var_49_3 + var_49_4

		AddPersonAttrib(arg_49_0, "攻击力", var_49_5)
		AddPersonAttrib(arg_49_0, "防御力", math.modf(var_49_5 / 3))
		AddPersonAttrib(arg_49_0, "轻功", math.modf(var_49_5 / 10))

		if cxtd(arg_49_0, 75) then
			if JY.Person[arg_49_0].拳掌功夫 >= 0 then
				AddPersonAttrib(arg_49_0, "拳掌功夫", math.random(3))
			end

			if JY.Person[arg_49_0].御剑能力 >= 0 then
				AddPersonAttrib(arg_49_0, "御剑能力", 7 + math.random(0, 1))
			end

			if JY.Person[arg_49_0].耍刀技巧 >= 0 then
				AddPersonAttrib(arg_49_0, "耍刀技巧", 7 + math.random(0, 1))
			end

			if JY.Person[arg_49_0].特殊兵器 >= 0 then
				AddPersonAttrib(arg_49_0, "特殊兵器", 7 + math.random(0, 1))
			end
		end
	end

	local var_49_6 = 1

	if has_thing(321) and arg_49_0 == 0 then
		var_49_6 = var_49_6 + 2
	end

	if has_thing(320) and arg_49_0 > 0 then
		var_49_6 = var_49_6 + 2
	end

	if ybdw(arg_49_0) then
		var_49_6 = 0
	end

	if JY.Base.游戏难度 > 3 then
		var_49_6 = var_49_6 + 1
	end

	if JY.Base.游戏难度 > 4 then
		var_49_6 = var_49_6 + 2
	end

	local var_49_7 = var_49_6 * var_49_1

	if ybdw(arg_49_0) then
		local var_49_8 = math.random(var_49_7 + 1) - 1
		local var_49_9 = limitX(math.random(var_49_7 + 1 - var_49_8) - 1, 0, var_49_7)
		local var_49_10 = limitX(math.random(var_49_7 + 1 - var_49_8 - var_49_9) - 1, 0, var_49_7)

		AddPersonAttrib(arg_49_0, "攻击力", var_49_8)
		AddPersonAttrib(arg_49_0, "防御力", var_49_9)
		AddPersonAttrib(arg_49_0, "轻功", var_49_10)
	else
		local var_49_11 = JY.Person[arg_49_0].攻击力
		local var_49_12 = JY.Person[arg_49_0].防御力
		local var_49_13 = JY.Person[arg_49_0].轻功
		local var_49_14 = var_49_7

		repeat
			Cls()

			local var_49_15 = JY.Person[arg_49_0].姓名 .. " 升级随机点分配"
			local var_49_16 = string.format("剩余的额外随机升级点数：%d 点*攻击：%d*防御：%d*轻功：%d", var_49_14, var_49_11, var_49_12, var_49_13)
			local var_49_17 = {
				"加攻",
				"加防",
				"加轻",
				"重置",
				"确定"
			}
			local var_49_18 = #var_49_17
			local var_49_19 = JYMsgBox(var_49_15, var_49_16, var_49_17, var_49_18)

			Cls()

			if var_49_14 == 0 and var_49_19 < 4 then
				DrawStrBoxWaitKey("对不起，已经没有可分配点数。请选择“确定”或“重置”", C_WHITE, CC.DefaultFont)
			elseif var_49_19 == 1 then
				local var_49_20 = InputNum("请输入分配的攻击力点数", 1, var_49_14, 1)

				if var_49_20 ~= nil then
					var_49_11 = var_49_11 + var_49_20
					var_49_14 = var_49_14 - var_49_20
				end
			elseif var_49_19 == 2 then
				local var_49_21 = InputNum("请输入分配的防御力点数", 1, var_49_14, 1)

				if var_49_21 ~= nil then
					var_49_12 = var_49_12 + var_49_21
					var_49_14 = var_49_14 - var_49_21
				end
			elseif var_49_19 == 3 then
				local var_49_22 = InputNum("请输入分配的轻功点数", 1, var_49_14, 1)

				if var_49_22 ~= nil then
					var_49_13 = var_49_13 + var_49_22
					var_49_14 = var_49_14 - var_49_22
				end
			elseif var_49_19 == 4 then
				var_49_11 = JY.Person[arg_49_0].攻击力
				var_49_12 = JY.Person[arg_49_0].防御力
				var_49_13 = JY.Person[arg_49_0].轻功
				var_49_14 = var_49_7
			elseif var_49_19 == 5 then
				if var_49_14 > 0 then
					DrawStrBoxWaitKey("对不起，" .. JY.Person[arg_49_0].姓名 .. "还有剩余的点数没加!", C_WHITE, CC.DefaultFont)
				else
					JY.Person[arg_49_0].攻击力 = var_49_11
					JY.Person[arg_49_0].防御力 = var_49_12
					JY.Person[arg_49_0].轻功 = var_49_13
					var_49_7 = 0
				end
			end
		until var_49_7 == 0
	end

	return true
end

function War_EndPersonData(arg_51_0, arg_51_1)
	for iter_51_0 = 0, WAR.PersonNum - 1 do
		local var_51_0 = WAR.Person[iter_51_0].人物编号

		if not instruct_16(var_51_0) or ybdw(var_51_0) then
			JY.Person[var_51_0].生命 = JY.Person[var_51_0].生命最大值
			JY.Person[var_51_0].内力 = JY.Person[var_51_0].内力最大值
			JY.Person[var_51_0].体力 = CC.PersonAttribMax.体力
			JY.Person[var_51_0].受伤程度 = 0
			JY.Person[var_51_0].中毒程度 = 0
			JY.Person[var_51_0].中火毒 = 0
			JY.Person[var_51_0].中冰毒 = 0
			JY.Person[var_51_0].中封穴 = 0
			JY.Person[var_51_0].流血值 = 0
		end
	end

	for iter_51_1 = 0, WAR.PersonNum - 1 do
		local var_51_1 = WAR.Person[iter_51_1].人物编号

		if isteam(var_51_1) then
			if JY.Person[var_51_1].生命 < JY.Person[var_51_1].生命最大值 / 10 * 9 then
				JY.Person[var_51_1].生命 = math.ceil(JY.Person[var_51_1].生命 + JY.Person[var_51_1].生命最大值 / 10)
			end

			if JY.Person[var_51_1].内力 < JY.Person[var_51_1].内力最大值 / 10 * 9 then
				JY.Person[var_51_1].内力 = math.ceil(JY.Person[var_51_1].内力 + JY.Person[var_51_1].内力最大值 / 10)
			end

			if JY.Person[var_51_1].体力 < 90 then
				JY.Person[var_51_1].体力 = JY.Person[var_51_1].体力 + 10
			end

			if JY.Person[var_51_1].受伤程度 < 100 then
				JY.Person[var_51_1].受伤程度 = JY.Person[var_51_1].受伤程度 - 10
			end

			if JY.Person[var_51_1].受伤程度 < 0 then
				JY.Person[var_51_1].受伤程度 = 0
			end

			if JY.Person[var_51_1].流血值 < 100 then
				JY.Person[var_51_1].流血值 = JY.Person[var_51_1].流血值 - 10
			end

			if JY.Person[var_51_1].流血值 < 0 then
				JY.Person[var_51_1].流血值 = 0
			end

			JY.Person[var_51_1].中封穴 = 0
		end
	end

	if WAR.ZDDH == 82 then
		SetS(10, 0, 18, 0, 1)
	end

	if WAR.ZDDH == 217 and arg_51_1 == 1 then
		SetS(10, 0, 16, 0, 1)
	end

	if WAR.ZDDH == 44 then
		instruct_3(55, 6, 1, 0, 0, 0, 0, -2, -2, -2, 0, -2, -2)
		instruct_3(55, 7, 1, 0, 0, 0, 0, -2, -2, -2, 0, -2, -2)
	end

	if WAR.ZDDH == 45 then
		instruct_3(55, 9, 1, 0, 0, 0, 0, -2, -2, -2, 0, -2, -2)
	end

	if WAR.ZDDH == 46 then
		instruct_3(55, 13, 0, 0, 0, 0, 0, -2, -2, -2, 0, -2, -2)
	end

	if arg_51_1 == 2 then
		return
	end

	local var_51_2 = 0

	for iter_51_2 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_51_2].我方 == true and JY.Person[WAR.Person[iter_51_2].人物编号].生命 > 0 then
			var_51_2 = var_51_2 + 1
		end
	end

	local var_51_3 = false

	if arg_51_1 == 1 then
		for iter_51_3 = 0, WAR.PersonNum - 1 do
			local var_51_4 = WAR.Person[iter_51_3].人物编号

			if inteam(var_51_4) then
				AddPersonAttrib(var_51_4, "实战", 1)

				if JY.Person[var_51_4].实战 > 1000 then
					JY.Person[var_51_4].实战 = 1000
				end
			end
		end

		if inteam(27) and JY.Person[27].实战 > 0 then
			say("我不欠你人情了，以后不要来打扰我。", 27, 0)

			JY.Person[27].好感度 = JY.Person[27].好感度 - 1

			instruct_21(27)
			addevent(70, 118, 1, 2219, 1, 8278)
		end

		for iter_51_4 = 0, WAR.PersonNum - 1 do
			local var_51_5 = WAR.Person[iter_51_4].人物编号

			if WAR.Person[iter_51_4].我方 == true and (instruct_16(var_51_5) or ybdw(var_51_5)) and JY.Person[var_51_5].生命 > 0 then
				if var_51_5 == 0 then
					local var_51_6 = true
				end

				for iter_51_5 = 1, CC.Kungfunum do
					if JY.Person[var_51_5]["武功" .. iter_51_5] == 98 then
						WAR.Person[iter_51_4].经验 = WAR.Person[iter_51_4].经验 + math.modf(WAR.Data.经验 * 1.5 / var_51_2)
					end
				end

				WAR.Person[iter_51_4].经验 = WAR.Person[iter_51_4].经验 + math.modf(WAR.Data.经验 / var_51_2)
			end
		end
	end

	for iter_51_6 = 0, WAR.PersonNum - 1 do
		local var_51_7 = WAR.Person[iter_51_6].人物编号

		AddPersonAttrib(var_51_7, "物品修炼点数", math.modf(WAR.Person[iter_51_6].经验 * 8 / 10))
		AddPersonAttrib(var_51_7, "修炼点数", math.modf(WAR.Person[iter_51_6].经验 * 8 / 10))

		if JY.Person[var_51_7].修炼点数 < 0 then
			JY.Person[var_51_7].修炼点数 = 0
		end

		War_PersonTrainBook(var_51_7)
		War_PersonTrainDrug(var_51_7)
	end

	for iter_51_7 = 0, WAR.PersonNum - 1 do
		local var_51_8 = WAR.Person[iter_51_7].人物编号

		if WAR.Person[iter_51_7].我方 == true and (instruct_16(var_51_8) or ybdw(var_51_8)) then
			AddPersonAttrib(var_51_8, "经验", math.modf(WAR.Person[iter_51_7].经验))
			DrawStrBoxWaitKey(string.format("%s 获得经验点数 %d", JY.Person[var_51_8].姓名, WAR.Person[iter_51_7].经验), C_WHITE, CC.DefaultFont)
			War_AddPersonLVUP(var_51_8)
		else
			AddPersonAttrib(var_51_8, "经验", WAR.Person[iter_51_7].经验)
		end
	end

	if WAR.ZDDH == 48 then
		SetS(57, 52, 29, 1, 0)
		SetS(57, 52, 30, 1, 0)
	elseif WAR.ZDDH == 175 then
		instruct_3(32, 12, 1, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
	elseif WAR.ZDDH == 82 then
		SetS(10, 0, 18, 0, 1)
	elseif WAR.ZDDH == 214 then
		SetS(10, 0, 19, 0, 1)
	end

	if WAR.ZDDH == 217 and arg_51_1 == 1 then
		SetS(65, 1, 1, 5, 517)
	end
end

function LJLV(arg_52_0)
	local var_52_0 = math.modf(JY.Person[arg_52_0].轻功 / 100)
	local var_52_1 = math.modf(JY.Person[arg_52_0].实战 / 100)
	local var_52_2 = math.modf(JY.Person[arg_52_0].武学常识 / 50)
	local var_52_3 = 0

	if JY.Status == GAME_WMAP and WAR.ZYZ[arg_52_0] ~= nil then
		var_52_3 = math.modf((WAR.ZYZ[arg_52_0] - 100) / 5)
	end

	local var_52_4 = 0
	local var_52_5 = var_52_0 + var_52_1 + var_52_2 + var_52_3
	local var_52_6 = var_52_5 + JY.Person[arg_52_0].连击率

	if T1LEQ(arg_52_0) then
		var_52_6 = var_52_6 + 20
	end

	if PersonKF(arg_52_0, 7) then
		var_52_6 = var_52_6 + 3
	end

	if PersonKF(arg_52_0, 34) then
		var_52_6 = var_52_6 + 3
	end

	if cxtd(arg_52_0, 626) then
		var_52_6 = var_52_6 + math.modf(JY.Person[arg_52_0].生命最大值 - JY.Person[arg_52_0].生命) / 50
	end

	if cxtd(arg_52_0, 626) then
		local var_52_7 = var_52_5 + math.modf(JY.Person[626].受伤程度 / 5)
	end

	if cxtd(arg_52_0, 178) and JY.Person[arg_52_0].受伤程度 > 30 then
		var_52_6 = var_52_6 + (JY.Person[arg_52_0].受伤程度 - 30)
	end

	if cxtd(arg_52_0, 179) and JY.Person[arg_52_0].受伤程度 > 40 then
		var_52_6 = var_52_6 + math.modf((JY.Person[arg_52_0].受伤程度 - 40) / 2)
	end

	if cxtd(arg_52_0, 598) and JY.Person[0].品德 < 50 then
		var_52_6 = var_52_6 + (50 - JY.Person[0].品德)
	end

	if PersonKF(arg_52_0, 16) then
		var_52_6 = var_52_6 + 4
	end

	if cxtd(arg_52_0, 12) then
		for iter_52_0 = 1, #TeamP do
			if TeamP[iter_52_0] == arg_52_0 then
				local var_52_8 = math.modf(JY.Person[arg_52_0].实战 / 25 + 1)

				if var_52_8 > 20 then
					var_52_8 = 20
				end

				var_52_6 = var_52_6 + var_52_8

				break
			end
		end
	end

	return math.modf(var_52_6)
end

function BJlV(arg_53_0)
	local var_53_0 = math.modf(JY.Person[arg_53_0].实战 / 100)
	local var_53_1 = math.modf(JY.Person[arg_53_0].生命增长 - 6)
	local var_53_2 = math.modf(JY.Person[arg_53_0].体力 / 50)
	local var_53_3 = math.modf(JY.Person[arg_53_0].武学常识 / 50)
	local var_53_4 = 0

	if JY.Status == GAME_WMAP and WAR.ZYZ[arg_53_0] ~= nil then
		var_53_4 = math.modf((WAR.ZYZ[arg_53_0] - 100) / 10)
	end

	local var_53_5 = 0
	local var_53_6 = var_53_0 + var_53_1 + var_53_2 + var_53_3 + var_53_4 + JY.Person[arg_53_0].暴击率

	if var_53_6 < 0 then
		var_53_6 = 0
	end

	if cxtd(arg_53_0, 177) and JY.Person[arg_53_0].受伤程度 > 30 then
		var_53_6 = var_53_6 + (JY.Person[arg_53_0].受伤程度 - 30)
	end

	if cxtd(arg_53_0, 598) and JY.Person[0].品德 < 50 then
		var_53_6 = var_53_6 + (50 - JY.Person[0].品德)
	end

	if cxtd(arg_53_0, 179) and JY.Person[arg_53_0].受伤程度 > 40 then
		var_53_6 = var_53_6 + math.modf((JY.Person[arg_53_0].受伤程度 - 40) / 2)
	end

	if cxtd(arg_53_0, 626) then
		var_53_6 = var_53_6 + math.modf(JY.Person[arg_53_0].生命最大值 - JY.Person[arg_53_0].生命) / 50
	end

	if cxtd(arg_53_0, 626) then
		var_53_6 = var_53_6 + math.modf(JY.Person[626].受伤程度 / 5)
	end

	if cxtd(arg_53_0, 12) then
		for iter_53_0 = 1, #TeamP do
			if TeamP[iter_53_0] == arg_53_0 then
				local var_53_7 = math.modf(JY.Person[arg_53_0].实战 / 25 + 1)

				if var_53_7 > 20 then
					var_53_7 = 20
				end

				var_53_6 = var_53_6 + var_53_7

				break
			end
		end
	end

	return math.modf(var_53_6)
end

function War_Fight_Sub(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = WAR.Person[arg_54_0].人物编号
	local var_54_1 = 0

	if arg_54_1 < 100 then
		var_54_1 = JY.Person[var_54_0]["武功" .. arg_54_1]
	else
		var_54_1 = arg_54_1 - 100
		arg_54_1 = 1

		for iter_54_0 = 1, CC.Kungfunum do
			if JY.Person[var_54_0]["武功" .. iter_54_0] == 43 then
				arg_54_1 = iter_54_0

				break
			end
		end

		if (function ()
			if cxtd(var_54_0, 51) and instruct_16(51) and WAR.HMXC == 0 and WAR.AutoFight == 0 then
				return true
			elseif cxtd(var_54_0, 113) and instruct_16(113) and WAR.AutoFight == 0 then
				return true
			else
				return false
			end
		end)() == false or cxtd(var_54_0, 51) and WAR.HMXC > 0 then
			arg_54_2 = WAR.Person[WAR.CurID].坐标X - arg_54_2
			arg_54_3 = WAR.Person[WAR.CurID].坐标Y - arg_54_3

			WarDrawMap(0)
		end

		local var_54_2

		if WAR.DZXYLV[var_54_0] == 130 then
			if cxtd(var_54_0, 51) and WAR.HMXC > 0 then
				var_54_2 = string.format("%s发动幻梦星辰反击", JY.Person[var_54_0].姓名)
			else
				var_54_2 = string.format("%s发动离合参商反击", JY.Person[var_54_0].姓名)
			end
		elseif WAR.DZXYLV[var_54_0] == 100 then
			var_54_2 = string.format("%s发动斗转星移反击", JY.Person[var_54_0].姓名)
		elseif WAR.DZXYLV[var_54_0] == 80 then
			var_54_2 = string.format("%s发动北斗移辰反击", JY.Person[var_54_0].姓名)
		end

		for iter_54_1 = 1, 10 do
			DrawStrBox(-1, 24, var_54_2, C_ORANGE, 20 + iter_54_1)
			ShowScreen()

			if iter_54_1 == 10 then
				lib.Delay(40)
			else
				lib.Delay(1)
			end
		end
	end

	WAR.WGWL = JY.Wugong[var_54_1].攻击力10

	local var_54_3 = JY.Wugong[var_54_1].攻击范围
	local var_54_4 = JY.Wugong[var_54_1].武功类型
	local var_54_5 = JY.Person[var_54_0]["武功等级" .. arg_54_1]

	var_54_5 = var_54_5 == 999 and 11 or math.modf(var_54_5 / 100) + 1
	WAR.ShowHead = 0

	local var_54_6, var_54_7, var_54_8, var_54_9, var_54_10, var_54_11, var_54_12 = refw(var_54_1, var_54_5)
	local var_54_13 = {
		var_54_6,
		var_54_7
	}
	local var_54_14 = {
		var_54_8,
		var_54_9,
		var_54_10,
		var_54_11,
		var_54_12
	}

	if WAR.SQFJ == 1 then
		-- Nothing
	else
		arg_54_2, arg_54_3 = War_FightSelectType(var_54_13, var_54_14, arg_54_2, arg_54_3)
	end

	if arg_54_2 == nil then
		WAR.L_ZXSG = 0

		return 0
	end

	if var_54_1 == 98 then
		local var_54_15 = 0

		while var_54_15 < 800 or var_54_15 > 1300 do
			var_54_1 = math.random(JY.WugongNum - 1)
			var_54_15 = JY.Wugong[var_54_1].攻击力10
		end
	end

	local function var_54_16(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
		arg_56_3 = arg_56_3 or 0

		if arg_56_2 < arg_56_1 then
			arg_56_1, arg_56_2 = arg_56_2, arg_56_1
		end

		if arg_56_3 == 0 and arg_56_1 < arg_56_0 and arg_56_0 < arg_56_2 then
			return true
		elseif arg_56_3 == 1 and arg_56_1 <= arg_56_0 and arg_56_0 <= arg_56_2 then
			return true
		else
			return false
		end
	end

	if (cxtd(var_54_0, 68) or cxtd(var_54_0, 123) or cxtd(var_54_0, 124) or cxtd(var_54_0, 125) or cxtd(var_54_0, 126) or cxtd(var_54_0, 127) or cxtd(var_54_0, 128)) and JLSD(35, 70, var_54_0) then
		WAR.XSZJ = 10

		if WAR.Person[arg_54_0].特效文字2 == nil then
			WAR.Person[arg_54_0].特效文字2 = "七星汇聚"
		else
			WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "七星汇聚"
		end
	end

	local var_54_17 = -1
	local var_54_18 = WAR.Person[WAR.CurID].坐标X
	local var_54_19 = WAR.Person[WAR.CurID].坐标Y

	for iter_54_2 = 0, WAR.PersonNum - 1 do
		if WAR.Person[WAR.CurID].我方 == WAR.Person[iter_54_2].我方 and iter_54_2 ~= WAR.CurID and WAR.Person[iter_54_2].死亡 == false and WAR.SQFJ ~= 1 then
			local var_54_20 = WAR.Person[iter_54_2].坐标X
			local var_54_21 = WAR.Person[iter_54_2].坐标Y
			local var_54_22 = WAR.Person[iter_54_2].人物编号

			for iter_54_3 = 1, 20 do
				if JY.Person[var_54_22]["武功" .. iter_54_3] == var_54_1 and math.abs(var_54_20 - var_54_18) + math.abs(var_54_21 - var_54_19) < 9 then
					local var_54_23 = 0
					local var_54_24 = 0

					if math.abs(var_54_20 - var_54_18) <= 1 then
						var_54_23 = 1
					end

					if math.abs(var_54_21 - var_54_19) <= 1 then
						var_54_24 = 1
					end

					if var_54_18 == var_54_20 then
						var_54_24 = 1
					end

					if var_54_19 == var_54_21 then
						var_54_23 = 1
					end

					if var_54_16(arg_54_2, var_54_18, var_54_20, var_54_23) and var_54_16(arg_54_3, var_54_19, var_54_21, var_54_24) then
						var_54_17 = iter_54_2
						WAR.Person[iter_54_2].人方向 = 3 - War_Direct(var_54_18, var_54_19, arg_54_2, arg_54_3)

						break
					end
				end
			end

			if var_54_17 >= 0 then
				break
			end
		end
	end

	local var_54_25 = 1

	if JY.Person[var_54_0].左右互搏 == 1 and WAR.ZYHB == 0 then
		local var_54_26 = 75 - JY.Person[var_54_0].悟性

		if var_54_26 < 0 then
			var_54_26 = 0
		end

		if cxtd(var_54_0, 64) or JY.Person[var_54_0].悟性 == 1 then
			var_54_26 = 100
		end

		if cxtd(var_54_0, 59) then
			var_54_26 = 70
		end

		if cxtd(var_54_0, 55) then
			var_54_26 = 80
		end

		if T2SQ(var_54_0) then
			var_54_26 = 40
		end

		if T2SQ(var_54_0) and JY.Base.二次觉醒 == 1 then
			var_54_26 = 70
		end

		if PersonKF(var_54_0, 102) then
			var_54_26 = var_54_26 + 10
		end

		if cxtd(var_54_0, 5129) then
			var_54_26 = var_54_26 + 20
		end

		if var_54_26 > 100 then
			var_54_26 = 100
		end

		if JLSD(0, var_54_26, var_54_0) and WAR.DZXY == 0 and WAR.SQFJ ~= 1 then
			WAR.ZYHB = 1

			if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and WAR.RZWD == 1 then
				WAR.ZYHB = 0
			end

			if WAR.ZYHB == 1 then
				if WAR.Person[WAR.CurID].特效文字0 ~= nil then
					WAR.Person[WAR.CurID].特效文字0 = WAR.Person[WAR.CurID].特效文字0 .. "·左右互搏"
				else
					WAR.Person[WAR.CurID].特效文字0 = "左右互搏"
				end
			end
		end
	end

	local var_54_27 = LJLV(var_54_0) + JY.Wugong[var_54_1].连击率

	if WAR.Person[arg_54_0].我方 then
		-- Nothing
	else
		var_54_27 = var_54_27 + 10
	end

	if JY.Person[var_54_0].武器 == 42 and yongjian(var_54_1) then
		var_54_27 = var_54_27 + 10
	end

	if WAR.L_NYZH[var_54_0] ~= nil then
		var_54_27 = var_54_27 + 10
	end

	if Curr_QG(var_54_0, 141) then
		var_54_27 = var_54_27 + 10
	end

	if WAR.QQSH[var_54_0] == 1 then
		var_54_27 = var_54_27 + 10
	end

	if WAR.L_RYJF[var_54_0] ~= nil then
		var_54_27 = var_54_27 + 3 * WAR.L_RYJF[var_54_0]
	end

	if var_54_27 > 100 then
		var_54_27 = 100
	end

	if var_54_27 < 10 then
		var_54_27 = 10
	end

	if JLSD(0, var_54_27, var_54_0) then
		var_54_25 = 2
	end

	if instruct_16(var_54_0) and JLSD(50, 55, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 3) and var_54_1 == 44 and var_54_25 < 2 and JLSD(10, 60, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 54) and (yongquan(var_54_1) or yongjian(var_54_1)) and var_54_25 < 2 and JLSD(30, 70, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 632) and (yongte(var_54_1) or yongjian(var_54_1)) and var_54_25 < 2 and JLSD(30, 50, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 154) and var_54_1 == 54 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 53) then
		for iter_54_4 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_54_4].人物编号 == 76 and WAR.Person[iter_54_4].死亡 == false and WAR.Person[iter_54_4].我方 == WAR.Person[WAR.CurID].我方 then
				var_54_25 = 2

				break
			end
		end
	end

	if cxtd(var_54_0, 89) then
		for iter_54_5 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_54_5].人物编号 == 88 and WAR.Person[iter_54_5].死亡 == false and WAR.Person[iter_54_5].我方 == WAR.Person[WAR.CurID].我方 then
				var_54_25 = 2

				break
			end
		end
	end

	if cxtd(var_54_0, 57) and var_54_1 == 12 then
		var_54_25 = 3
	end

	if cxtd(var_54_0, 7) and yongjian(var_54_1) and JLSD(30, 50, var_54_0) then
		var_54_25 = 3
	end

	if cxtd(var_54_0, 36) and var_54_1 == 48 and var_54_25 < 2 and JLSD(30, 70, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 140) and var_54_1 == 47 then
		var_54_25 = 2

		if JLSD(30, 70, var_54_0) then
			var_54_25 = 3
		end
	end

	if cxtd(var_54_0, 0) and var_54_1 == 42 and GetS(86, 11, 11, 5) == 1 then
		for iter_54_6 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_54_6].人物编号 == 59 and WAR.Person[iter_54_6].死亡 == false and WAR.Person[iter_54_6].我方 == WAR.Person[WAR.CurID].我方 then
				if JLSD(25, 60, var_54_0) then
					var_54_25 = 3

					break
				end

				var_54_25 = 2

				break
			end
		end
	end

	if cxtd(var_54_0, 181) and var_54_1 == 37 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 185) and yongquan(var_54_1) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 171) and var_54_1 == 16 then
		var_54_25 = 2
	end

	if var_54_1 == 23 and cxtd(var_54_0, 168) then
		var_54_25 = 2
	end

	if var_54_1 == 23 and cxtd(var_54_0, 8) and JLSD(20, 40, var_54_0) then
		var_54_25 = 3
	end

	if cxtd(var_54_0, 153) and var_54_1 == 16 then
		var_54_25 = 2
	end

	if WAR.XSZJ == 10 then
		var_54_25 = 2
	end

	if Curr_NG(var_54_0, 111) and WAR.ACT == 1 then
		local var_54_28 = 0
		local var_54_29 = 0
		local var_54_30 = PersonKFDJ(var_54_0, 111) / 50

		if var_54_0 == 0 then
			var_54_28 = 5
		end

		if WAR.LQZ[var_54_0] == 100 or JLSD(0, var_54_30 + var_54_28, var_54_0) then
			var_54_25 = var_54_25 + 1
			WAR.Person[arg_54_0].特效文字3 = "玉女神行"
		end
	end

	if JY.Person[var_54_0].主功体 == 89 and var_54_1 == 34 then
		if JY.Person[var_54_0].御剑能力 >= 180 and JLSD(20, 60, var_54_0) then
			WAR.DMLHSXJ = 1
			var_54_25 = 3
		else
			var_54_25 = 2
		end
	end

	if JY.Person[var_54_0].主功体 == 98 and var_54_1 == 190 then
		var_54_25 = JLSD(20, 70, var_54_0) and 3 or 2
	end

	if JY.Person[var_54_0].主功体 == 107 and var_54_1 == 11 then
		var_54_25 = JLSD(15, 50, var_54_0) and 3 or 2
	end

	if JY.Person[var_54_0].主功体 == 104 and WAR.LQZ[var_54_0] == 100 and JY.Person[var_54_0].生命 < JY.Person[var_54_0].生命最大值 / 5 then
		var_54_25 = 3
	end

	if JY.Person[var_54_0].主功体 == 100 and var_54_1 == 39 then
		var_54_25 = JLSD(20, 30, var_54_0) and 3 or 2
	end

	if JY.Person[var_54_0].主功体 == 95 and var_54_1 == 83 then
		var_54_25 = JLSD(20, 35, var_54_0) and 3 or 2
	end

	if JY.Person[var_54_0].主功体 == 101 and var_54_1 == 14 then
		var_54_25 = 2
	end

	if JY.Person[var_54_0].主功体 == 113 and var_54_1 == 16 then
		var_54_25 = 2
	end

	if JY.Person[var_54_0].主功体 == 102 and var_54_1 == 35 then
		var_54_25 = 2
	end

	if JY.Person[var_54_0].主功体 == 102 and var_54_1 == 61 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 599) and var_54_1 == 168 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 108) and var_54_1 == 60 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 67) and var_54_1 == 13 and var_54_25 < 2 and JLSD(10, 80, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 166) and var_54_1 == 37 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 109) and var_54_1 == 34 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 72) and var_54_1 == 28 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 43) and var_54_1 == 35 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 12) and var_54_1 == 4 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 29) and var_54_1 == 55 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 592) then
		var_54_25 = WAR.L_DGQB_X < 6 and math.random(10) < 8 and 3 or WAR.L_DGQB_X < 8 and 2 or 1
	end

	if cxtd(var_54_0, 91) and WAR.QQDB == 1 then
		for iter_54_7 = 1, 10 do
			DrawStrBox(-1, 24, "大暴青青 逆我者亡", C_ORANGE, 20 + iter_54_7)
			ShowScreen()
			lib.Delay(80)
		end

		var_54_25 = 2
	end

	if var_54_0 < 200 and (cxtd(var_54_0, 6) or cxtd(var_54_0, 67) or cxtd(var_54_0, 71) or cxtd(var_54_0, 18) or cxtd(var_54_0, 189) or cxtd(var_54_0, 152)) and var_54_25 ~= 2 and math.random(10) < 8 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 50) then
		if WAR.ZDDH == 83 and WAR.FS == 0 then
			say("１（唉，这些年轻人闯荡江湖也不容易，也罢，此战就以Ｒ太祖长拳Ｗ来陪你们玩玩吧！）", 50, 0)

			WAR.FS = 1
		end

		JY.Wugong[13].名称 = "太祖长拳"

		if JLSD(40, 70, var_54_0) then
			var_54_25 = 2
		end
	end

	if cxtd(var_54_0, 77) and WAR.LQZ[var_54_0] == 100 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 170) and WAR.LQZ[var_54_0] == 100 and var_54_1 == 20 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 133) and WAR.LQZ[var_54_0] == 100 then
		var_54_25 = 3

		if WAR.Person[arg_54_0].特效文字1 ~= nil then
			WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "一鸣惊人"
		else
			WAR.Person[arg_54_0].特效文字1 = "一鸣惊人"
		end
	end

	if cxtd(var_54_0, 627) and yongquan(var_54_1) and JLSD(30, 80, var_54_0) then
		var_54_25 = 2

		if WAR.Person[arg_54_0].特效文字3 ~= nil then
			WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "银掌"
		else
			WAR.Person[arg_54_0].特效文字3 = "银掌"
		end
	end

	if cxtd(var_54_0, 149) and JY.Base.觉醒 == 1 and yongquan(var_54_1) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 149) and JY.Base.觉醒 == 1 and yongquan(var_54_1) and JLSD(30, 45, var_54_0) then
		var_54_25 = 3

		if WAR.Person[arg_54_0].特效文字3 ~= nil then
			WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "千手如来掌"
		else
			WAR.Person[arg_54_0].特效文字3 = "千手如来掌"
		end
	end

	if cxtd(var_54_0, 172) and var_54_1 == 36 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 172) and var_54_1 == 36 and var_54_25 < 3 and JLSD(20, 70, var_54_0) then
		var_54_25 = 3

		if WAR.Person[arg_54_0].特效文字3 ~= nil then
			WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "百鸟朝凤"
		else
			WAR.Person[arg_54_0].特效文字3 = "百鸟朝凤"
		end
	end

	if cxtd(var_54_0, 27) and JY.Person[var_54_0]["武功" .. arg_54_1] == 105 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 35) and GetS(10, 1, 1, 0) == 1 and JLSD(15, 85, var_54_0) then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 59) and JY.Person[var_54_0]["武功" .. arg_54_1] == 42 then
		var_54_25 = 2
	end

	if PersonKF(var_54_0, 60) and var_54_1 == 37 then
		var_54_25 = 2
		WAR.Person[arg_54_0].特效文字3 = "正反两仪阵·阴"
	end

	if cxtd(var_54_0, 60) and WAR.tmp[1060] == 1 and (WAR.ZDDH == 176 or WAR.ZDDH == 133) then
		var_54_25 = 2
	end

	if WAR.ZDDH == 10 and cxtd(var_54_0, 18) and JLSD(30, 70, var_54_0) then
		var_54_25 = 1
	end

	local var_54_31 = {
		7,
		2,
		1,
		27,
		34,
		29,
		55,
		57,
		70,
		76
	}

	for iter_54_8 = 1, 8 do
		if JY.Person[var_54_0]["武功" .. arg_54_1] == var_54_31[iter_54_8] and JLSD(25, 75, var_54_0) then
			var_54_25 = 2

			break
		end
	end

	if WAR.ZDDH == 54 and var_54_0 == 26 then
		var_54_25 = 1
	end

	if cxtd(var_54_0, 112) and JLSD(50, 75, var_54_0) then
		var_54_25 = 3
	end

	if cxtd(var_54_0, 94) and var_54_1 == 52 then
		var_54_25 = 2
	end

	if cxtd(var_54_0, 94) and var_54_1 == 52 and JLSD(45, 75, var_54_0) then
		var_54_25 = 3
	end

	if JY.Person[var_54_0].武器 == 236 and JY.Person[var_54_0]["武功" .. arg_54_1] == 46 then
		var_54_25 = 2
	end

	if JY.Person[var_54_0].武器 == 236 and JY.Person[var_54_0]["武功" .. arg_54_1] == 46 and JY.Person[var_54_0].御剑能力 >= 220 and JLSD(50, 75, var_54_0) then
		var_54_25 = 3
	end

	if var_54_25 > 1 then
		WAR.CCZ = var_54_25
	else
		WAR.CCZ = 0
	end

	if cxtd(var_54_0, 142) and JY.Base.觉醒 == 1 and WAR.LQZ[var_54_0] == 100 then
		if WAR.Person[arg_54_0].特效文字2 == nil then
			WAR.Person[arg_54_0].特效文字2 = "狂风快剑"
		else
			WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "狂风快剑"
		end

		var_54_25 = 4
	end

	if cxtd(var_54_0, 141) and var_54_1 == 34 then
		var_54_25 = 3
	end

	if JY.Person[var_54_0]["武功" .. arg_54_1] == 26 and (JLSD(45, 55, var_54_0) or WAR.LQZ[var_54_0] == 100) then
		var_54_25 = 3
		WAR.FS = 1

		for iter_54_9 = 1, 10 do
			DrawStrBox(-1, 24, "降龙三叠浪", C_ORANGE, 20 + iter_54_9)
			ShowScreen()
			lib.Delay(1)
		end
	end

	if JY.Person[var_54_0].内力 < math.modf(JY.Person[var_54_0].内力最大值 / 3) then
		JY.Person[var_54_0].内力 = math.modf(JY.Person[var_54_0].内力最大值 / 3)
	end

	if JY.Person[var_54_0]["武功" .. arg_54_1] == 26 and JLSD(30, 80, var_54_0) and JY.Person[var_54_0].拳掌功夫 >= 220 and WAR.LQZ[var_54_0] == 100 then
		var_54_25 = 3
	end

	if cxtd(var_54_0, 58) and JY.Person[var_54_0]["武功" .. arg_54_1] == 25 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and (GetS(86, 11, 11, 5) == 2 or JY.Person[var_54_0].拳掌功夫 >= 220) then
		local var_54_32 = 10

		if JY.Person[58].受伤程度 > 50 then
			var_54_32 = var_54_32 + (JY.Person[58].受伤程度 - 50)
		end

		if JY.Person[58].生命 < JY.Person[58].生命最大值 / 2 then
			var_54_32 = var_54_32 + math.ceil((JY.Person[58].生命最大值 / 2 - JY.Person[58].生命) / 10)
		end

		if var_54_32 > 100 then
			var_54_32 = 100
		end

		local var_54_33 = JY.Wugong[var_54_1]["3连击率"]

		if JLSD(0, var_54_33, var_54_0) then
			var_54_25 = 3
		end

		if JLSD(0, var_54_32, var_54_0) then
			var_54_25 = 3
		end
	end

	if WAR.Person[arg_54_0].我方 then
		for iter_54_10, iter_54_11 in pairs(CC.PersonWs) do
			if iter_54_11[1] ~= nil and cxtd(var_54_0, iter_54_11[1]) and JY.Person[var_54_0]["武功" .. arg_54_1] == iter_54_11[2] and JLSD(30, 65, var_54_0) and var_54_25 == 1 then
				var_54_25 = 2
			end
		end
	end

	if var_54_1 == 49 and JLSD(20, 40, var_54_0) and JY.Person[var_54_0].内力 > 5000 then
		local var_54_34 = wgnumber(var_54_0, 5) / 3

		if cxtd(var_54_0, 52) then
			var_54_34 = var_54_34 + math.random(2)
		end

		var_54_25 = var_54_25 + var_54_34
		WAR.Person[arg_54_0].特效文字0 = "急若闪电·迅猛绝伦"
	end

	if WAR.ZYZ[var_54_0] > 129 and JLSD(50, 75, var_54_0) then
		var_54_25 = var_54_25 + 1
	end

	if WAR.ZYZ[var_54_0] < 71 then
		var_54_25 = 1
	end

	if var_54_1 == 30 or var_54_1 == 31 or var_54_1 == 32 or var_54_1 == 33 or var_54_1 == 34 then
		local var_54_35 = 0

		for iter_54_12 = 1, arg_54_1 do
			if (JY.Person[var_54_0]["武功" .. iter_54_12] == 30 or JY.Person[var_54_0]["武功" .. iter_54_12] == 31 or JY.Person[var_54_0]["武功" .. iter_54_12] == 32 or JY.Person[var_54_0]["武功" .. iter_54_12] == 33 or JY.Person[var_54_0]["武功" .. iter_54_12] == 34) and JY.Person[var_54_0]["武功等级" .. iter_54_12] == 999 then
				var_54_35 = var_54_35 + 1
			end
		end

		if var_54_1 == 196 then
			WAR.L_WYJFA = math.random(30, 34)
		end

		if var_54_35 == 5 then
			if JLSD(20, 90, var_54_0) then
				WAR.L_WYJFA = var_54_1
			else
				WAR.L_WYJFA = -1
			end
		end
	end

	if cxtd(var_54_0, 19) and var_54_1 == 34 then
		WAR.L_WYJFA = 34
	end

	if cxtd(var_54_0, 20) and var_54_1 == 32 then
		WAR.L_WYJFA = 32
	end

	if cxtd(var_54_0, 21) and var_54_1 == 30 then
		WAR.L_WYJFA = 30
	end

	if cxtd(var_54_0, 22) and var_54_1 == 33 then
		WAR.L_WYJFA = 33
	end

	if cxtd(var_54_0, 23) and var_54_1 == 31 then
		WAR.L_WYJFA = 31
	end

	if WAR.L_WYJFA == 34 and var_54_25 < 2 then
		var_54_25 = 2
	end

	WAR.ACT = 1
	WAR.FLHS6 = 0

	if WAR.SQFJ == 1 or WAR.RZWD == 1 then
		var_54_25 = 1
	end

	if WAR.DZXY == 1 then
		var_54_25 = cxtd(var_54_0, 113) and 2 or 1
	end

	while var_54_25 >= WAR.ACT do
		if WAR.WS == 1 then
			WAR.WS = 0
		end

		if WAR.BJ == 1 then
			WAR.BJ = 0
		end

		if WAR.SZHBF[var_54_0] == 1 then
			WAR.SZHBF[var_54_0] = 0
		end

		if WAR.XHLH == 2 then
			WAR.XHLH = 0
		end

		if WAR.JLJJB == 1 then
			WAR.JLJJB = 0
		end

		if WAR.XSZJ == 1 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 2 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 3 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 4 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 5 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 6 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 7 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 8 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 9 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 10 then
			WAR.XSZJ = 0
		end

		if WAR.XSZJ == 11 then
			WAR.XSZJ = 0
		end

		if WAR.DJGZ == 1 then
			WAR.DJGZ = 0
		end

		if WAR.TYWF == 1 then
			WAR.TYWF = 0
		end

		if WAR.MCF == 1 then
			WAR.MCF = 0
		end

		if WAR.HQT == 1 then
			WAR.HQT = 0
		end

		if WAR.CY == 1 then
			WAR.CY = 0
		end

		if WAR.TFH == 1 then
			WAR.TFH = 0
		end

		if WAR.WQQ == 1 then
			WAR.WQQ = 0
		end

		if WAR.DBS == 1 then
			WAR.DBS = 0
		end

		if WAR.HDWZ == 1 then
			WAR.HDWZ = 0
		end

		if WAR.LMC == 1 then
			WAR.LMC = 0
		end

		WAR.NGJL2 = WAR.NGJL
		WAR.XDDF = 0
		WAR.NGJL = 0
		WAR.KHBX = 0
		WAR.GBWZ = 0
		WAR.BSMT = 0
		WAR.LXZQ = 0
		WAR.QMYC = 0
		WAR.ASKD = 0
		WAR.JSYX = 0
		WAR.XTSW = 0
		WAR.HSWLB = 0
		WAR.BMXH = 0
		WAR.BMXH1 = 0
		WAR.BMXH2 = 0
		WAR.TD = -1
		WAR.ZDPZ = 0
		WAR.TD1 = -1
		WAR.TZ_XZ = 0
		WAR.ZSF2 = 0
		WAR.JGZ_DMZ = 0
		WAR.LHQ_BNZ = 0
		WAR.ZTSLYZ = 0
		WAR.ZSSF = 0
		WAR.WPXJF = 0

		CleanWarMap(4, 0)

		WAR.L_CZJT = 0
		WAR.L_TLD = 0
		WAR.L_SSBD = 0
		WAR.FDHOT = 0
		WAR.XXYY = 0
		WAR.QDSX = 0
		WAR.BPHG = 0
		WAR.QXWX = 0
		WAR.MBDQ = 0
		WAR.SBCS = 0
		WAR.OXQP = 0
		WAR.PDJN = 0
		WAR.L_SGJL = 0
		WAR.L_LXXL = 0
		WAR.L_LZJFCC = 0
		WAR.L_RYJFCC = 0
		WAR.L_QKDNY = {}
		WAR.L_MJJF = 0
		WAR.L_NSDFCC = 0

		WarDrawAtt(arg_54_2, arg_54_3, var_54_14, 3)

		if var_54_17 >= 0 then
			local var_54_36 = WAR.CurID

			WAR.CurID = var_54_17

			WarDrawAtt(WAR.Person[var_54_17].坐标X + var_54_18 - arg_54_2, WAR.Person[var_54_17].坐标Y + var_54_19 - arg_54_3, var_54_14, 3)

			WAR.CurID = var_54_36
		end

		if WAR.SQFJ == 1 then
			CleanWarMap(4, 0)

			for iter_54_13 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_13].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_13].死亡 == false then
					SetWarMap(WAR.Person[iter_54_13].坐标X, WAR.Person[iter_54_13].坐标Y, 4, 1)
				end
			end
		end

		if WAR.ACT > 1 then
			local var_54_37 = "连击"

			if cxtd(var_54_0, 27) then
				var_54_37 = "风云再起"
			end

			if WAR.TJZX_LJ == 1 then
				var_54_37 = "太极之形.圆转不断"
				WAR.TJZX_LJ = 0
			end

			if WAR.Person[WAR.CurID].特效文字0 ~= nil then
				WAR.Person[WAR.CurID].特效文字0 = WAR.Person[WAR.CurID].特效文字0 .. "+" .. var_54_37
			else
				WAR.Person[WAR.CurID].特效文字0 = var_54_37
			end
		end

		local var_54_38 = BJlV(var_54_0) + JY.Wugong[var_54_1].暴击率

		if WAR.Person[arg_54_0].我方 then
			-- Nothing
		else
			var_54_38 = var_54_38 + 10
		end

		if JY.Person[var_54_0].生命最大值 > 3000 and JY.Person[var_54_0].生命最大值 < 5000 then
			var_54_38 = var_54_38 + 50
		end

		if JY.Person[var_54_0].武器 == 47 and yongdao(var_54_1) and JLSD(35, 45, var_54_0) then
			var_54_38 = var_54_38 + 10
		end

		if instruct_16(var_54_0) then
			for iter_54_14 = 0, WAR.PersonNum - 1 do
				if cxtd(var_54_0, 94) and WAR.Person[iter_54_14].死亡 == false and WAR.Person[iter_54_14].我方 == WAR.Person[WAR.CurID].我方 then
					var_54_38 = var_54_38 + 20
				end
			end
		end

		if var_54_38 > 100 then
			var_54_38 = 100
		end

		if var_54_38 < 10 then
			var_54_38 = 10
		end

		if JLSD(0, var_54_38, var_54_0) then
			WAR.BJ = 1
		end

		if instruct_16(var_54_0) and JLSD(50, 55, var_54_0) then
			WAR.BJ = 1
		end

		if var_54_0 < 200 and JLSD(50, 60, var_54_0) then
			WAR.BJ = 1
		end

		if (cxtd(var_54_0, 97) or cxtd(var_54_0, 67) or cxtd(var_54_0, 71) or cxtd(var_54_0, 26) or cxtd(var_54_0, 184) or cxtd(var_54_0, 189)) and WAR.BJ ~= 1 and math.random(10) < 8 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 593) and WAR.BJ ~= 1 and math.random(10) < 6 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 50) or cxtd(var_54_0, 6) or cxtd(var_54_0, 112) then
			WAR.BJ = 1
		end

		local var_54_39 = math.modf((JY.Person[var_54_0].生命最大值 - JY.Person[var_54_0].生命) / JY.Person[var_54_0].生命最大值 / 10)

		if JY.Person[var_54_0].悟性 > 50 and JY.Person[var_54_0].悟性 < 80 and JLSD(10, 10 + var_54_39, var_54_0) then
			WAR.BJ = 1
			WAR.Person[arg_54_0].特效文字1 = "匹夫一怒，血溅五步"
		end

		if cxtd(var_54_0, 58) and JY.Person[var_54_0].生命 < JY.Person[var_54_0].生命最大值 / 4 and JLSD(10, 80, var_54_0) then
			WAR.BJ = 1
		elseif cxtd(var_54_0, 58) and JY.Person[var_54_0].生命 < JY.Person[var_54_0].生命最大值 / 2 and JLSD(25, 75, var_54_0) then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 627) and JLSD(40, 90, var_54_0) and yongquan(var_54_1) then
			WAR.BJ = 1

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "金掌"
			else
				WAR.Person[arg_54_0].特效文字2 = "金掌"
			end
		end

		if cxtd(var_54_0, 186) and yongquan(var_54_1) then
			WAR.BJ = 1

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "神拳无敌"
			else
				WAR.Person[arg_54_0].特效文字2 = "神拳无敌"
			end
		end

		if cxtd(var_54_0, 185) and yongjian(var_54_1) then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 7) and var_54_1 == 37 then
			WAR.BJ = 1
		end

		if WAR.XSZJ == 8 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].主功体 == 90 and var_54_1 == 40 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].主功体 == 106 and var_54_1 == 66 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].主功体 == 96 and var_54_1 == 86 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].主功体 == 100 and var_54_1 == 17 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].主功体 == 103 and var_54_1 == 181 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 91) and var_54_1 == 40 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 81) and var_54_1 == 17 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 101) and var_54_1 == 81 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 165) and var_54_1 == 81 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 599) and var_54_1 == 168 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 107) and var_54_1 == 60 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 588) and var_54_1 == 59 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 186) and yongquan(var_54_1) and WAR.BJ ~= 1 and math.random(10) < 6 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 171) and var_54_1 == 46 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 170) and var_54_1 == 20 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 68) and var_54_1 == 39 then
			WAR.BJ = 1
		end

		if var_54_1 == 23 and cxtd(var_54_0, 167) then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 3) and var_54_1 == 44 and JY.Person[var_54_0].生命 < JY.Person[var_54_0].生命最大值 / 4 and JLSD(15, 95, var_54_0) then
			WAR.BJ = 1
		end

		if (cxtd(var_54_0, 89) or cxtd(var_54_0, 35)) and var_54_25 > 1 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 48) then
			for iter_54_15 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_15].人物编号 == 47 and WAR.Person[iter_54_15].死亡 == false and WAR.Person[iter_54_15].我方 == WAR.Person[WAR.CurID].我方 then
					WAR.BJ = 1

					break
				end
			end
		end

		if cxtd(var_54_0, 88) then
			for iter_54_16 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_16].人物编号 == 89 and WAR.Person[iter_54_16].死亡 == false and WAR.Person[iter_54_16].我方 == WAR.Person[WAR.CurID].我方 then
					WAR.BJ = 1

					break
				end
			end
		end

		if cxtd(var_54_0, 77) and JY.Person[var_54_0]["武功" .. arg_54_1] == 62 then
			WAR.BJ = 1
		end

		if cxtd(var_54_0, 60) and WAR.tmp[1060] == 1 then
			WAR.BJ = 1
		end

		local var_54_40 = {
			11,
			13,
			28,
			33,
			58,
			50,
			59,
			68,
			72,
			75
		}

		for iter_54_17 = 1, 8 do
			if JY.Person[var_54_0]["武功" .. arg_54_1] == var_54_40[iter_54_17] and JLSD(20, 75, var_54_0) then
				WAR.BJ = 1

				break
			end
		end

		if WAR.LQZ[var_54_0] == 100 and WAR.DZXY ~= 1 and WAR.SQFJ ~= 1 then
			WAR.BJ = 1
		end

		if JY.Person[var_54_0].武器 == 36 then
			if var_54_1 == 45 then
				WAR.BJ = 1
			elseif yongjian(var_54_1) and JLSD(35, 50, var_54_0) then
				WAR.BJ = 1
			end
		end

		if JY.Person[var_54_0].武器 == 43 and yongdao(var_54_1) and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 then
			if JLSD(35, 50, var_54_0) then
				WAR.BJ = 1
			end

			if WAR.BJ == 1 and JLSD(25, 75, var_54_0) then
				WAR.L_TLD = 1
			end
		end

		if WAR.L_NYZH[var_54_0] ~= nil and JLSD(55, 85, var_54_0) then
			WAR.BJ = 1
		end

		if WAR.L_WYJFA == 33 then
			WAR.BJ = 1
		end

		local var_54_41 = 0

		if WAR.BJ == 1 then
			WAR.Person[arg_54_0].特效动画 = 89

			if cxtd(var_54_0, 50) then
				local var_54_42
				local var_54_43 = math.random(3)

				if var_54_43 == 1 then
					WAR.Person[arg_54_0].特效文字1 = "教单于折箭 六军辟易 奋英雄怒"
				elseif var_54_43 == 2 then
					WAR.Person[arg_54_0].特效文字1 = "虽万千人吾往矣"
				elseif var_54_43 == 3 then
					WAR.Person[arg_54_0].特效文字1 = "胡汉恩仇 须倾英雄泪"
				end
			elseif cxtd(var_54_0, 27) then
				WAR.Person[arg_54_0].特效文字1 = "日出东方 唯我不败"
			elseif T4RM(var_54_0) then
				WAR.Person[arg_54_0].特效文字1 = "杀胡令"
			else
				WAR.Person[arg_54_0].特效文字1 = "暴击加力"
			end

			if WAR.Person[WAR.CurID].特效文字0 ~= nil then
				WAR.Person[WAR.CurID].特效文字0 = WAR.Person[WAR.CurID].特效文字0 .. "+" .. "暴击"
			else
				WAR.Person[WAR.CurID].特效文字0 = "暴击"
			end
		end

		if WAR.DZXY == 0 and WAR.SQFJ ~= 1 then
			for iter_54_18 = 1, CC.Kungfunum do
				local var_54_44 = JY.Person[var_54_0]["武功" .. iter_54_18]

				if var_54_44 == 95 then
					if WAR.tmp[200 + var_54_0] == nil then
						WAR.tmp[200 + var_54_0] = 0
					elseif WAR.tmp[200 + var_54_0] > 100 then
						var_54_41 = WAR.tmp[200 + var_54_0] * 10 + 1500

						if PersonKFJ(var_54_0, 9) then
							var_54_41 = var_54_41 + var_54_41 / 2
							WAR.Person[arg_54_0].特效文字2 = JY.Wugong[var_54_44].名称 .. "·神蟾震九天"
						else
							WAR.Person[arg_54_0].特效文字2 = JY.Wugong[var_54_44].名称 .. "·蟾震九天"
						end

						WAR.Person[arg_54_0].特效动画 = math.fmod(var_54_44, 10) + 85
						WAR.L_CZJT = 1

						break
					end
				end
			end
		end

		local var_54_45 = JY.Person[var_54_0].主功体

		if var_54_45 > 0 and JLSD(30, 90, var_54_0) then
			WAR.NGJL = var_54_45

			local var_54_46 = PersonKFDJ(var_54_0, var_54_45)
			local var_54_47 = math.modf(var_54_46 / 100) + 1

			var_54_41 = var_54_41 + JY.Wugong[var_54_45]["攻击力" .. var_54_47]

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效动画 = var_54_45
			else
				WAR.Person[arg_54_0].特效文字2 = JY.Wugong[var_54_45].名称 .. "加力"
			end
		end

		local var_54_48 = {}
		local var_54_49 = 0

		for iter_54_19 = 1, CC.Kungfunum do
			local var_54_50 = JY.Person[var_54_0]["武功" .. iter_54_19]

			if var_54_50 == 85 or var_54_50 == 87 or var_54_50 == 88 or var_54_50 == 109 then
				WAR.NGJL = 0
			end

			if var_54_50 == 96 or var_54_50 == 98 or var_54_50 == 103 then
				var_54_49 = var_54_49 + 1
				var_54_48[var_54_49] = {
					var_54_50,
					iter_54_19
				}
			end
		end

		if var_54_49 > 0 and (atkRandom(30, var_54_0) or (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 6 and JLSD(15, 55, var_54_0) or cxtd(var_54_0, 54) and JLSD(15, 30, var_54_0) or T4RM(var_54_0) and JLSD(30, 60, var_54_0)) then
			local var_54_51 = math.random(var_54_49)
			local var_54_52 = var_54_48[var_54_51][1]
			local var_54_53 = math.modf(JY.Person[var_54_0]["武功等级" .. var_54_48[var_54_51][2]] / 100) + 1

			var_54_41 = var_54_41 + JY.Wugong[var_54_52]["攻击力" .. var_54_53]

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				-- Nothing
			else
				WAR.Person[arg_54_0].特效文字2 = JY.Wugong[var_54_52].名称 .. "加力"
			end

			WAR.Person[arg_54_0].特效动画 = math.fmod(var_54_52, 10) + 85
			WAR.NGJL = var_54_52
		end

		if (WAR.XHLH == 1 or JY.Person[var_54_0].主功体 == 96 or cxtd(var_54_0, 38)) and WAR.NGJL == 0 then
			WAR.NGJL = 96

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "罗汉伏魔"
			else
				WAR.Person[arg_54_0].特效文字2 = "罗汉伏魔"
			end
		end

		if (JY.Person[var_54_0].主功体 == 103 or cxtd(var_54_0, 160)) and WAR.NGJL == 0 then
			WAR.NGJL = 103

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				-- Nothing
			end
		end

		if JY.Person[var_54_0].主功体 == 98 and WAR.NGJL == 0 then
			WAR.NGJL = 98

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "小无相功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = "小无相功加力"
			end
		end

		if WAR.NGJL < 0 then
			for iter_54_20 = 1, CC.Kungfunum do
				local var_54_54 = JY.Person[var_54_0]["武功" .. iter_54_20]

				if var_54_54 < 0 then
					break
				end

				if var_54_54 > 88 and var_54_54 < 109 and var_54_54 ~= 108 and var_54_54 ~= 107 and var_54_54 ~= 106 and var_54_54 ~= 105 and var_54_54 ~= 102 and (atkRandom(30, var_54_0) or (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 6 and JLSD(15, 55, var_54_0) or cxtd(var_54_0, 54) and JLSD(15, 30, var_54_0) or cxtd(var_54_0, 135) and JLSD(30, 60, var_54_0)) then
					local var_54_55 = math.modf(JY.Person[var_54_0]["武功等级" .. iter_54_20] / 100) + 1
					local var_54_56 = JY.Wugong[var_54_54]["攻击力" .. var_54_55]

					if var_54_41 < var_54_56 then
						var_54_41 = var_54_56

						if WAR.Person[arg_54_0].特效文字2 ~= nil then
							-- Nothing
						else
							WAR.Person[arg_54_0].特效动画 = math.fmod(var_54_54, 10) + 85
							WAR.Person[arg_54_0].特效文字2 = JY.Wugong[var_54_54].名称 .. "加力"
						end

						WAR.NGJL = var_54_54
					end
				end
			end
		end

		local var_54_57 = 0
		local var_54_58 = {}

		for iter_54_21 = 1, CC.Kungfunum do
			local var_54_59 = JY.Person[var_54_0]["武功" .. iter_54_21]

			if var_54_59 < 0 then
				break
			end

			if var_54_59 == 108 or var_54_59 == 107 and (JY.Person[var_54_0].内力性质 == 0 or (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5) or var_54_59 == 105 or var_54_59 == 102 then
				var_54_57 = var_54_57 + 1
				var_54_58[var_54_57] = {
					var_54_59,
					iter_54_21
				}
			end
		end

		if var_54_57 > 0 then
			local var_54_60 = math.random(var_54_57)
			local var_54_61 = var_54_58[var_54_60][1]
			local var_54_62 = math.modf(JY.Person[var_54_0]["武功等级" .. var_54_58[var_54_60][2]] / 100) + 1
			local var_54_63 = JY.Wugong[var_54_61]["攻击力" .. var_54_62]

			if var_54_61 == 108 and (atkdefRandom(20, var_54_0) or cxtd(var_54_0, 149)) then
				WAR.L_SGJL = var_54_61

				if cxtd(var_54_0, 149) then
					var_54_41 = var_54_41 + math.modf(var_54_63 / 2) + 500
				else
					var_54_41 = var_54_41 + 500
				end

				if WAR.Person[arg_54_0].特效文字1 ~= nil then
					-- Nothing
				else
					WAR.Person[arg_54_0].特效文字1 = "易筋经神功"
				end

				WAR.Person[arg_54_0].特效动画 = 79
			end

			if var_54_61 == 106 and atkdefRandom(20, var_54_0) then
				WAR.L_SGJL = var_54_61
				var_54_41 = var_54_41 + math.modf(var_54_63 / 2) + 500

				if WAR.Person[arg_54_0].特效文字1 ~= nil then
					-- Nothing
				else
					WAR.Person[arg_54_0].特效文字1 = "九阳神功"
				end

				WAR.Person[arg_54_0].特效动画 = 79
			end

			if WAR.NGJL < 0 and JY.Person[eid].副功体 > 0 then
				var_54_41 = var_54_41 + 300
				WAR.L_SGJL = 122

				if WAR.Person[enemyid].特效文字1 ~= nil then
					WAR.Person[enemyid].特效文字1 = WAR.Person[enemyid].特效文字1 .. "+" .. "天罡加力"
				else
					WAR.Person[enemyid].特效文字1 = "天罡加力"
				end

				WAR.Person[enemyid].特效动画 = 66
			end

			if var_54_61 == 107 and atkRandom(25, var_54_0) then
				WAR.L_SGJL = var_54_61
				var_54_41 = var_54_41 + 500

				if WAR.Person[arg_54_0].特效文字1 ~= nil then
					WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "九阴神功"
				else
					WAR.Person[arg_54_0].特效文字1 = "九阴神功"
				end

				WAR.Person[arg_54_0].特效动画 = 66
			end

			if var_54_61 == 105 and (JLSD(30, 60, var_54_0) or cxtd(var_54_0, 36) and JLSD(40, 60, var_54_0)) then
				WAR.L_SGJL = var_54_61

				if WAR.Person[arg_54_0].特效文字1 ~= nil then
					WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "葵花神功"
				else
					WAR.Person[arg_54_0].特效文字1 = "葵花神功"
				end

				WAR.Person[arg_54_0].特效动画 = 44
			end

			if Curr_NG(var_54_0, 102) and var_54_61 == 102 and (JLSD(30, 60, var_54_0) or cxtd(var_54_0, 38) and JLSD(40, 60, var_54_0)) then
				WAR.L_SGJL = var_54_61

				if WAR.Person[arg_54_0].特效文字1 ~= nil then
					WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "太玄神功"
				else
					WAR.Person[arg_54_0].特效文字1 = "太玄神功"
				end

				WAR.Person[arg_54_0].特效动画 = 63
			end
		end

		if var_54_1 == 92 then
			if WAR.Person[arg_54_0].特效动画 == -1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(92, 10) + 85
			end

			local var_54_64 = 0

			for iter_54_22 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_22].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_22].死亡 == false then
					var_54_64 = 1

					if cxtd(var_54_0, 13) then
						WAR.Person[iter_54_22].TimeAdd = WAR.Person[iter_54_22].TimeAdd - 200
					else
						WAR.Person[iter_54_22].TimeAdd = WAR.Person[iter_54_22].TimeAdd - 100
					end
				end
			end

			if var_54_64 == 1 then
				if WAR.Person[arg_54_0].特效文字2 == nil then
					WAR.Person[arg_54_0].特效文字2 = "战吼"
				else
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "战吼"
				end
			end
		end

		if PersonKF(var_54_0, 105) and WAR.Person[arg_54_0].特效文字2 == nil and math.random(10) < 6 then
			WAR.Person[arg_54_0].特效动画 = math.fmod(105, 10) + 85

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "葵花神功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "葵花神功加力"
			end

			WAR.NGJL = 105
			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 27) and JLSD(10, 30, var_54_0) and var_54_25 < 3 then
			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "风云变幻"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "风云变幻"
			end

			var_54_25 = var_54_25 + 1
		end

		if cxtd(var_54_0, 154) and JLSD(10, 40, var_54_0) and var_54_25 < 3 then
			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "刀影重重"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "刀影重重"
			end

			var_54_25 = var_54_25 + 1
		end

		if (var_54_0 == 0 and WAR.LIURU == 0 or var_54_0 == JY.Base.队伍1 and JY.Base.畅想编号 > 0 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and PersonKF(var_54_0, 91) and (JLSD(25, 75, 0) or JY.Base.主角职业 == 6 and JLSD(30, 60, 0)) and JY.Base.觉醒 == 1 then
			local var_54_65 = 0
			local var_54_66 = JY.Wugong[91].名称

			if JY.Base.二次觉醒 ~= 1 and JLSD(10, 60, var_54_0) then
				var_54_65 = math.random(3)
			else
				var_54_65 = math.random(4)
			end

			if JY.Base.主角职业 == 6 and JY.Base.二次觉醒 ~= 1 then
				var_54_65 = math.random(2) + 1
			end

			if JY.Base.主角职业 == 6 and JY.Base.二次觉醒 == 1 and JLSD(25, 75, var_54_0) then
				var_54_65 = math.random(2) + 1
			end

			if JY.Base.主角职业 == 6 and JY.Base.二次觉醒 == 1 and (var_54_65 == 1 or var_54_65 == 4) and WAR.FLHS6 > 2 then
				var_54_65 = math.random(2) + 1
			end

			if var_54_65 == 3 then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[1]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_66 .. FLHSYL[1]
				end

				WAR.FLHS1 = 1

				for iter_54_23 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_54_23].死亡 == false and WAR.Person[iter_54_23].我方 == WAR.Person[WAR.CurID].我方 then
						WAR.Person[iter_54_23].Time = WAR.Person[iter_54_23].Time + 100
					end

					if WAR.Person[iter_54_23].Time > 980 then
						WAR.Person[iter_54_23].Time = 980
					end
				end
			elseif var_54_65 == 2 then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[3]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_66 .. FLHSYL[3]
				end

				var_54_41 = var_54_41 + 3000
			elseif (JY.Base.主角职业 == 6 or math.random(10) < 6) and JY.Base.二次觉醒 == 1 and WAR.FLHS6 < 3 then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[6]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_66 .. FLHSYL[6]
				end

				var_54_25 = var_54_25 + 1
				WAR.FLHS6 = WAR.FLHS6 + 1
			end
		end

		if var_54_0 == 0 and WAR.LIURU > 0 and JY.Base.畅想编号 == 0 and JY.Base.主角职业 < 10 and JY.Base.觉醒 == 1 and PersonKF(var_54_0, 91) then
			local var_54_67 = JY.Wugong[91].名称

			if WAR.FLHS1 == 0 and (JLSD(10, 40, var_54_0) or JY.Base.主角职业 == 6 and JLSD(10, 25, var_54_0)) then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[1]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_67 .. FLHSYL[1]
				end

				WAR.FLHS1 = 1

				for iter_54_24 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_54_24].死亡 == false and WAR.Person[iter_54_24].我方 == WAR.Person[WAR.CurID].我方 then
						WAR.Person[iter_54_24].Time = WAR.Person[iter_54_24].Time + 100
					end

					if WAR.Person[iter_54_24].Time > 980 then
						WAR.Person[iter_54_24].Time = 980
					end
				end
			end

			if JLSD(10, 40, var_54_0) or WAR.FLHS1 == 1 and (JLSD(10, 25, var_54_0) or JY.Base.主角职业 == 6 and JLSD(10, 25, var_54_0)) then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[3]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_67 .. FLHSYL[3]
				end

				var_54_41 = var_54_41 + 3000
			end

			if JY.Base.二次觉醒 == 1 and WAR.FLHS6 < 2 and (JLSD(10, 35, var_54_0) or WAR.FLHS1 == 1 and JLSD(10, 20, var_54_0) or JY.Base.主角职业 == 6 and JLSD(10, 30, var_54_0)) then
				WAR.Person[arg_54_0].特效动画 = 6

				if WAR.Person[arg_54_0].特效文字2 ~= nil then
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. FLHSYL[6]
				else
					WAR.Person[arg_54_0].特效文字2 = var_54_67 .. FLHSYL[6]
				end

				var_54_25 = var_54_25 + 1
				WAR.FLHS6 = WAR.FLHS6 + 1
			end
		end

		if var_54_1 == 85 or (PersonKF(var_54_0, 85) or T1LEQ(var_54_0)) and (JLSD(40, 90, var_54_0) or cxtd(var_54_0, 53) and JLSD(10, 40, var_54_0)) or cxtd(var_54_0, 118) and JLSD(20, 80, var_54_0) or cxtd(var_54_0, 117) and JLSD(20, 80, var_54_0) or cxtd(var_54_0, 116) or cxtd(var_54_0, 115) and JLSD(20, 60, var_54_0) then
			if WAR.Person[arg_54_0].特效动画 == -1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(85, 10) + 85
			end

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "北冥神功"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "北冥神功"
			end

			WAR.BMXH = 1

			for iter_54_25 = 1, arg_54_1 do
				if JY.Person[var_54_0]["武功" .. iter_54_25] == 85 then
					JY.Person[var_54_0]["武功等级" .. iter_54_25] = JY.Person[var_54_0]["武功等级" .. iter_54_25] + 10
				end

				if JY.Person[var_54_0]["武功等级" .. iter_54_25] > 999 then
					JY.Person[var_54_0]["武功等级" .. iter_54_25] = 999
				end
			end
		end

		if var_54_1 == 88 or PersonKF(var_54_0, 88) and (JLSD(40, 90, var_54_0) or cxtd(var_54_0, 53) and JLSD(10, 40, var_54_0)) or cxtd(var_54_0, 26) then
			if WAR.Person[arg_54_0].特效动画 == -1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(88, 10) + 85
			end

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "吸星大法"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "吸星大法"
			end

			WAR.BMXH1 = 1

			for iter_54_26 = 1, arg_54_1 do
				if JY.Person[var_54_0]["武功" .. iter_54_26] < 0 then
					break
				end

				if JY.Person[var_54_0]["武功" .. iter_54_26] == 88 then
					JY.Person[var_54_0]["武功等级" .. iter_54_26] = JY.Person[var_54_0]["武功等级" .. iter_54_26] + 10

					if JY.Person[var_54_0]["武功等级" .. iter_54_26] > 999 then
						JY.Person[var_54_0]["武功等级" .. iter_54_26] = 999
					end

					break
				end
			end
		end

		if PersonKF(var_54_0, 87) and (JLSD(40, 90, var_54_0) or cxtd(var_54_0, 53) and JLSD(10, 40, var_54_0)) or cxtd(var_54_0, 46) or cxtd(var_54_0, 47) then
			if WAR.Person[arg_54_0].特效动画 == -1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(87, 10) + 85
			end

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "化功大法"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "化功大法"
			end

			WAR.BMXH2 = 1

			for iter_54_27 = 1, arg_54_1 do
				if JY.Person[var_54_0]["武功" .. iter_54_27] < 0 then
					break
				end

				if JY.Person[var_54_0]["武功" .. iter_54_27] == 87 then
					JY.Person[var_54_0]["武功等级" .. iter_54_27] = JY.Person[var_54_0]["武功等级" .. iter_54_27] + 10

					if JY.Person[var_54_0]["武功等级" .. iter_54_27] > 999 then
						JY.Person[var_54_0]["武功等级" .. iter_54_27] = 999
					end

					break
				end
			end
		end

		if T4RM(var_54_0) then
			if WAR.Person[arg_54_0].特效动画 == -1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(92, 10) + 85
			end

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "杀胡令"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "杀胡令"
			end
		end

		if PersonKF(var_54_0, 82) and var_54_1 == 86 and PersonKF(var_54_0, 96) then
			WAR.XHLH = 1
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 86 and WAR.XHLH == 1 then
			for iter_54_28 = 1, CC.Kungfunum do
				if JY.Person[var_54_0]["武功" .. iter_54_28] == 86 then
					if WAR.Person[arg_54_0].特效文字1 ~= nil then
						WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "佛怒 血海罗汉"
					else
						WAR.Person[arg_54_0].特效文字1 = "佛怒 血海罗汉"
					end

					WAR.Person[arg_54_0].特效动画 = 6
					WAR.XHLH = 2
					var_54_41 = var_54_41 + 1500
				end
			end
		end

		if cxtd(var_54_0, 50) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = 53

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "擒龙功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "擒龙功加力"
			end

			var_54_41 = var_54_41 + 1500
		end

		if cxtd(var_54_0, 113) then
			WAR.Person[arg_54_0].特效动画 = 53

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "参合指加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "参合指加力"
			end

			var_54_41 = var_54_41 + 1200
		end

		if cxtd(var_54_0, 103) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = math.fmod(98, 10) + 85

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "小无相功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "小无相功加力"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 64) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = 66

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "九阴神功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "九阴神功加力"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 69) and WAR.NGJL == 0 and WAR.L_SGJL == 0 and WAR.ZDDH ~= 188 then
			WAR.Person[arg_54_0].特效动画 = 67

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "九阴运气"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "九阴运气"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 57) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = 95

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "奇门奥义"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "奇门奥义"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 164) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = 23

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "控鹤功"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "控鹤功"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 592) then
			if WAR.L_DGQB_X < 3 then
				WAR.Person[arg_54_0].特效动画 = 24
				WAR.Person[arg_54_0].特效文字2 = "利剑"
				var_54_41 = var_54_41 + 1200
			elseif WAR.L_DGQB_X < 5 then
				WAR.Person[arg_54_0].特效动画 = 48
				WAR.Person[arg_54_0].特效文字2 = "软剑"
				var_54_41 = var_54_41 + 1400
			elseif WAR.L_DGQB_X < 7 then
				WAR.Person[arg_54_0].特效动画 = 10
				WAR.Person[arg_54_0].特效文字2 = "重剑"
				var_54_41 = var_54_41 + 1600
			elseif WAR.L_DGQB_X < 9 then
				WAR.Person[arg_54_0].特效动画 = 46
				WAR.Person[arg_54_0].特效文字2 = "木剑"
				var_54_41 = var_54_41 + 1800
			else
				WAR.Person[arg_54_0].特效文字2 = "无剑"
				var_54_41 = var_54_41 + 2000
			end
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5 and (JY.Person[var_54_0]["武功" .. arg_54_1] > 88 and JY.Person[var_54_0]["武功" .. arg_54_1] < 109 or JY.Person[var_54_0]["武功" .. arg_54_1] > 88 and JY.Person[var_54_0]["武功" .. arg_54_1] == 43) then
			if JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and JLSD(25, 75, var_54_0) then
				WAR.Person[arg_54_0].特效文字3 = "天罡真气·" .. JY.Wugong[JY.Person[var_54_0]["武功" .. arg_54_1]].名称
				var_54_41 = var_54_41 + JY.Wugong[JY.Person[var_54_0]["武功" .. arg_54_1]].攻击力10
			end

			if JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 then
				-- Nothing
			end
		end

		if (WAR.QQSH == 1 or cxtd(var_54_0, 115)) and var_54_1 == 73 then
			WAR.QQSHQ = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·琴音悦耳"
			else
				WAR.Person[arg_54_0].特效文字3 = "琴棋书画·琴音悦耳"

				if JLSD(0, 50, var_54_0) or cxtd(var_54_0, 33) then
					WAR.QQSHQ = 2
					WAR.Person[arg_54_0].特效文字3 = nil

					if WAR.Person[arg_54_0].特效文字3 ~= nil then
						WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·菩提清心"
					else
						WAR.Person[arg_54_0].特效文字3 = "琴棋书画·菩提清心"
					end
				end
			end
		end

		if (WAR.QQSH == 1 or cxtd(var_54_0, 115)) and var_54_1 == 72 then
			var_54_41 = var_54_41 + 1500

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·棋高一着"
			else
				WAR.Person[arg_54_0].特效文字3 = "琴棋书画·棋高一着"

				if JLSD(0, 50, var_54_0) or cxtd(var_54_0, 33) then
					var_54_41 = var_54_41 + 2500
					WAR.Person[arg_54_0].特效文字3 = nil

					if WAR.Person[arg_54_0].特效文字3 ~= nil then
						WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·星罗棋布"
					else
						WAR.Person[arg_54_0].特效文字3 = "琴棋书画·星罗棋布"
					end
				end
			end
		end

		if (WAR.QQSH == 1 or cxtd(var_54_0, 115)) and var_54_1 == 84 then
			WAR.QQSHH = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·画地为牢"
			else
				WAR.Person[arg_54_0].特效文字3 = "琴棋书画·画地为牢"

				if JLSD(0, 50, var_54_0) or cxtd(var_54_0, 33) then
					WAR.QQSHH = 2
					WAR.Person[arg_54_0].特效文字3 = nil

					if WAR.Person[arg_54_0].特效文字3 ~= nil then
						WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·江山如画"
					else
						WAR.Person[arg_54_0].特效文字3 = "琴棋书画·江山如画"
					end
				end
			end
		end

		if (WAR.QQSH == 1 or cxtd(var_54_0, 115)) and var_54_1 == 81 then
			WAR.QQSHS = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·秉笔直书"
			else
				WAR.Person[arg_54_0].特效文字3 = "琴棋书画·秉笔直书"

				if JLSD(0, 50, var_54_0) or cxtd(var_54_0, 33) then
					WAR.QQSHS = 2
					WAR.Person[arg_54_0].特效文字3 = nil

					if WAR.Person[arg_54_0].特效文字3 ~= nil then
						WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "琴棋书画·指点江山"
					else
						WAR.Person[arg_54_0].特效文字3 = "琴棋书画·指点江山"
					end
				end
			end
		end

		if cxtd(var_54_0, 9) and PersonKF(var_54_0, 106) and PersonKF(var_54_0, 97) and WAR.L_SGJL == 0 then
			if math.random(2) == 1 then
				WAR.Person[arg_54_0].特效动画 = math.fmod(97, 10) + 85

				if WAR.Person[arg_54_0].特效文字2 == nil then
					WAR.Person[arg_54_0].特效文字2 = "乾坤大挪移加力"
				else
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "乾坤大挪移加力"
				end

				var_54_41 = var_54_41 + 850
			else
				WAR.Person[arg_54_0].特效动画 = math.fmod(106, 10) + 85

				if WAR.Person[arg_54_0].特效文字2 == nil then
					WAR.Person[arg_54_0].特效文字2 = "九阳神功加力"
				else
					WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "九阳神功加力"
				end

				var_54_41 = var_54_41 + 1200
			end
		end

		if cxtd(var_54_0, 26) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "魔帝·吸星"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "魔帝·吸星"
			end

			var_54_41 = var_54_41 + 1500
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 26 then
			if cxtd(var_54_0, 50) or cxtd(var_54_0, 55) and math.random(10) < 5 or (cxtd(var_54_0, 69) or (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 1 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999) and JLSD(20, 70, var_54_0) or JLSD(30, 70, var_54_0) and (JY.Person[var_54_0].拳掌功夫 >= 200 or cxtd(var_54_0, 627) and JY.Person[var_54_0].拳掌功夫 >= 150) then
				WAR.Person[arg_54_0].特效文字3 = XL18JY[math.random(8)]
				var_54_41 = var_54_41 + 2500
				WAR.WS = 1

				for iter_54_29 = 1, var_54_5 / 2 + 1 do
					for iter_54_30 = 1, var_54_5 / 2 + 1 do
						SetWarMap(arg_54_2 + iter_54_29 - 1, arg_54_3 + iter_54_30 - 1, 4, 1)
						SetWarMap(arg_54_2 - iter_54_29 + 1, arg_54_3 + iter_54_30 - 1, 4, 1)
						SetWarMap(arg_54_2 + iter_54_29 - 1, arg_54_3 - iter_54_30 + 1, 4, 1)
						SetWarMap(arg_54_2 - iter_54_29 + 1, arg_54_3 - iter_54_30 + 1, 4, 1)
					end
				end
			elseif myrandom(15 + var_54_5, var_54_0) or cxtd(var_54_0, 5062) and JLSD(30, 70, var_54_0) then
				WAR.Person[arg_54_0].特效文字3 = XL18[math.random(6)]
				var_54_41 = var_54_41 + 2000

				for iter_54_31 = 1, (1 + var_54_5) / 2 do
					for iter_54_32 = 1, (1 + var_54_5) / 2 do
						SetWarMap(WAR.Person[WAR.CurID].坐标X + iter_54_31 * 2 - 1, WAR.Person[WAR.CurID].坐标Y + iter_54_32 * 2 - 1, 4, 1)
						SetWarMap(WAR.Person[WAR.CurID].坐标X - iter_54_31 * 2 + 1, WAR.Person[WAR.CurID].坐标Y + iter_54_32 * 2 - 1, 4, 1)
						SetWarMap(WAR.Person[WAR.CurID].坐标X + iter_54_31 * 2 - 1, WAR.Person[WAR.CurID].坐标Y - iter_54_32 * 2 + 1, 4, 1)
						SetWarMap(WAR.Person[WAR.CurID].坐标X - iter_54_31 * 2 + 1, WAR.Person[WAR.CurID].坐标Y - iter_54_32 * 2 + 1, 4, 1)
					end
				end
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 49 then
			if PersonKF(var_54_0, 17) and (JLSD(10, 70, var_54_0) or cxtd(var_54_0, 5059) and math.random(10) < 5 or cxtd(var_54_0, 53) or cxtd(var_54_0, 102)) then
				WAR.Person[arg_54_0].特效文字3 = LMSJ[math.random(6)]
				var_54_41 = var_54_41 + 2000

				if cxtd(var_54_0, 53) then
					WAR.LMSJwav = 1
					WAR.WS = 1
				end
			elseif myrandom(var_54_5, var_54_0) or cxtd(var_54_0, 5059) and JLSD(20, 60, var_54_0) or (cxtd(var_54_0, 53) or cxtd(var_54_0, 102)) and math.random(10) < 6 then
				WAR.Person[arg_54_0].特效文字3 = LMSJ[math.random(6)]
				var_54_41 = var_54_41 + 2000

				if cxtd(var_54_0, 53) then
					WAR.LMSJwav = 1
				end
			end
		end

		if WAR.ZDDH == 279 and not instruct_16(var_54_0) and (var_54_0 == 659 or var_54_0 == 660 or var_54_0 == 661 or var_54_0 == 662 or var_54_0 == 663) then
			for iter_54_33 = 659, 667 do
				local var_54_68 = Rnd(10)

				if var_54_68 == 10 then
					WAR.JGZ_DMZ = 1
				elseif var_54_68 < 7 then
					WAR.LHQ_BNZ = 1
				end
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 1 and PersonKF(var_54_0, 108) then
			if instruct_16(var_54_0) and WAR.L_SGJL == 108 then
				WAR.LHQ_BNZ = 1
			elseif not instruct_16(var_54_0) then
				WAR.LHQ_BNZ = 1
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 22 and PersonKF(var_54_0, 108) then
			if instruct_16(var_54_0) and WAR.L_SGJL == 108 then
				WAR.JGZ_DMZ = 1
			elseif not instruct_16(var_54_0) then
				WAR.JGZ_DMZ = 1
			end
		end

		if cxtd(var_54_0, 70) and JY.Person[var_54_0]["武功" .. arg_54_1] == 22 then
			WAR.JGZ_DMZ = 1
			var_54_41 = var_54_41 + 1200
		end

		if cxtd(var_54_0, 116) and JY.Person[var_54_0]["武功" .. arg_54_1] == 8 then
			WAR.ZTSLYZ = 1
			var_54_41 = var_54_41 + 2000
		end

		if var_54_0 > 480 and var_54_0 < 490 then
			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "易筋经加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "易筋经加力"
			end

			var_54_41 = var_54_41 + 1200
			WAR.JGZ_DMZ = 1
		end

		if cxtd(var_54_0, 24) and JLSD(10, 80, var_54_0) then
			WAR.WPXJF = 1
			var_54_41 = var_54_41 + 800
		end

		if cxtd(var_54_0, 38) and var_54_1 == 102 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and JLSD(25, 75, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = XKXSJ[math.random(4)]
			var_54_41 = var_54_41 + 2000
		end

		if cxtd(var_54_0, 37) and var_54_1 == 94 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and JLSD(25, 75, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = "神照经·无影神拳"
			var_54_41 = var_54_41 + 2000
		end

		if cxtd(var_54_0, 0) and var_54_1 == 125 and JY.Person[var_54_0].耍刀技巧 >= 180 and JY.Base.觉醒 == 1 and JLSD(20, 50, var_54_0) and WAR.ACT == 1 then
			WAR.QLTY = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "战意高亢"
			else
				WAR.Person[arg_54_0].特效文字3 = "战意高亢"
			end

			WAR.Person[arg_54_0].特效动画 = 6
		end

		if cxtd(var_54_0, 50) then
			for iter_54_34 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_34].人物编号 == 104 and WAR.Person[iter_54_34].死亡 == false and WAR.Person[iter_54_34].我方 == WAR.Person[WAR.CurID].我方 then
					WAR.QLTY = 1

					if WAR.Person[arg_54_0].特效文字3 ~= nil then
						WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "战意高亢"
					else
						WAR.Person[arg_54_0].特效文字3 = "战意高亢"
					end

					WAR.Person[arg_54_0].特效动画 = 6

					break
				end
			end
		end

		if cxtd(var_54_0, 155) and JLSD(15, 90, var_54_0) then
			WAR.XSZJ = 6

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "黑沙掌"
			else
				WAR.Person[arg_54_0].特效文字2 = "黑沙掌"
			end
		end

		if cxtd(var_54_0, 156) and JLSD(15, 90, var_54_0) then
			WAR.XSZJ = 7

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "飞爪勾魂"
			else
				WAR.Person[arg_54_0].特效文字2 = "飞爪勾魂"
			end
		end

		if cxtd(var_54_0, 165) and JLSD(45, 65, var_54_0) then
			WAR.XSZJ = 3

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "惊天一笔"
			else
				WAR.Person[arg_54_0].特效文字2 = "惊天一笔"
			end
		end

		if cxtd(var_54_0, 169) and JLSD(30, 65, var_54_0) then
			WAR.XSZJ = 4

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "金刚一指禅"
			else
				WAR.Person[arg_54_0].特效文字2 = "金刚一指禅"
			end
		end

		if cxtd(var_54_0, 170) and JLSD(30, 65, var_54_0) then
			WAR.XSZJ = 5

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "少林九阳功"
			else
				WAR.Person[arg_54_0].特效文字2 = "少林九阳功"
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 44 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and (math.random(10) < 6 or cxtd(var_54_0, 1) and JLSD(5, 85, var_54_0)) then
			for iter_54_35 = 1, CC.Kungfunum do
				if JY.Person[var_54_0]["武功" .. iter_54_35] == 67 and JY.Person[var_54_0]["武功等级" .. iter_54_35] == 999 then
					if WAR.Person[arg_54_0].特效文字1 ~= nil then
						WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "胡刀苗剑 归真合一"
					else
						WAR.Person[arg_54_0].特效文字1 = "胡刀苗剑 归真合一"
					end

					WAR.Person[arg_54_0].特效动画 = 6
					WAR.DJGZ = 1
					var_54_41 = var_54_41 + 2000
				end
			end
		end

		if cxtd(var_54_0, 176) and JLSD(10, 50, var_54_0) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "鸟啼花怨恨难平"
			else
				WAR.Person[arg_54_0].特效文字1 = "鸟啼花怨恨难平"
			end

			WAR.Person[arg_54_0].特效动画 = 6
			WAR.XSZJ = 1
			var_54_41 = var_54_41 + 2000
		end

		if var_54_17 >= 0 and (var_54_1 == 62 or var_54_1 == 42) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "天衣无缝"
			else
				WAR.Person[arg_54_0].特效文字1 = "天衣无缝"
			end

			WAR.Person[arg_54_0].特效动画 = 6
			WAR.TYWF = 1
			var_54_41 = var_54_41 + 2000
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 67 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and math.random(10) < 6 or cxtd(var_54_0, 3) and JLSD(35, 95, var_54_0) then
			for iter_54_36 = 1, CC.Kungfunum do
				if JY.Person[var_54_0]["武功" .. iter_54_36] == 44 and JY.Person[var_54_0]["武功等级" .. iter_54_36] == 999 then
					if WAR.Person[arg_54_0].特效文字1 ~= nil then
						WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "胡刀苗剑 归真合一"
					else
						WAR.Person[arg_54_0].特效文字1 = "胡刀苗剑 归真合一"
					end

					WAR.Person[arg_54_0].特效动画 = 6
					WAR.DJGZ = 1
					var_54_41 = var_54_41 + 2000
				end
			end
		end

		local var_54_69 = JY.Person[var_54_0].盗贼技巧

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 195 and JLSD(0, var_54_69, var_54_0) then
			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "飞龙探云手"
			else
				WAR.Person[arg_54_0].特效文字2 = "飞龙探云手"
			end

			WAR.TD = -2

			instruct_56(-1)
		end

		if cxtd(var_54_0, 131) and JLSD(15, 45, var_54_0) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "分筋错骨手"
			else
				WAR.Person[arg_54_0].特效文字1 = "分筋错骨手"
			end

			WAR.JLJJB = 1
		end

		if cxtd(var_54_0, 131) and JLSD(15, 85, var_54_0) then
			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "妙手空空"
			else
				WAR.Person[arg_54_0].特效文字2 = "妙手空空"
			end

			WAR.TD = -2
		end

		if cxtd(var_54_0, 57) and WAR.ACT == 1 and JLSD(15, 25, var_54_0) or PersonKF(var_54_0, 12) and PersonKF(var_54_0, 18) and PersonKF(var_54_0, 38) and WAR.ACT == 1 and not cxtd(var_54_0, 57) and JLSD(15, 75, var_54_0) then
			for iter_54_37 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_37].死亡 == false and WAR.Person[iter_54_37].我方 ~= WAR.Person[WAR.CurID].我方 then
					if JY.Person[WAR.Person[iter_54_37].人物编号].内力 > 1000 then
						JY.Person[WAR.Person[iter_54_37].人物编号].内力 = JY.Person[WAR.Person[iter_54_37].人物编号].内力 - 800
						WAR.Person[iter_54_37].内力点数 = (WAR.Person[iter_54_37].内力点数 or 0) - 800
					else
						WAR.Person[iter_54_37].内力点数 = (WAR.Person[iter_54_37].内力点数 or 0) - JY.Person[WAR.Person[iter_54_37].人物编号].内力
						JY.Person[WAR.Person[iter_54_37].人物编号].内力 = 0
						JY.Person[WAR.Person[iter_54_37].人物编号].生命 = JY.Person[WAR.Person[iter_54_37].人物编号].生命 - 100
						WAR.Person[iter_54_37].生命点数 = (WAR.Person[iter_54_37].生命点数 or 0) - 100
					end
				end
			end

			WAR.Person[arg_54_0].特效文字3 = "落英缤纷"
			WAR.Person[arg_54_0].特效动画 = 39
		end

		for iter_54_38, iter_54_39 in pairs(CC.PersonWs) do
			if iter_54_39[1] ~= nil and cxtd(var_54_0, iter_54_39[1]) and JY.Person[var_54_0]["武功" .. arg_54_1] == iter_54_39[2] then
				WAR.WS = 1
			end
		end

		if PersonKFD(var_54_0, JY.Person[var_54_0]["武功" .. arg_54_1], 999) then
			WAR.WS = 1
		end

		if ybdw(var_54_0) then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 113) and WAR.DZXY == 1 then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 173) then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 60) then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 27) then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 135) then
			WAR.WS = 1
		end

		if (cxtd(var_54_0, 50) or cxtd(var_54_0, 55) or cxtd(var_54_0, 69)) and JY.Person[var_54_0]["武功" .. arg_54_1] == 26 then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 35) and GetS(10, 1, 1, 0) == 1 and JY.Person[var_54_0]["武功" .. arg_54_1] == 47 then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 62) then
			var_54_41 = var_54_41 + 2000
		end

		if WAR.JZPZXS == 1 then
			WAR.JZPZXS = nil
		end

		if JY.Person[var_54_0].生命 == 1 and WAR.ACT == 1 then
			var_54_41 = var_54_41 + 500

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "舍命一博"
			else
				WAR.Person[arg_54_0].特效文字1 = "舍命一博"
			end
		end

		if cxtd(var_54_0, 84) or JY.Person[var_54_0].武器 == 39 and JLSD(20, 80, var_54_0) and yongjian(var_54_1) then
			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 78) and JY.Person[var_54_0]["武功" .. arg_54_1] == 11 then
			WAR.MCF = 1
			WAR.Person[arg_54_0].特效文字3 = "铁尸之怨念"
		end

		if cxtd(var_54_0, 52) and JY.Person[var_54_0]["武功" .. arg_54_1] == 70 then
			WAR.Person[arg_54_0].特效文字3 = "中平神枪"
			var_54_41 = var_54_41 + 1500
		end

		if cxtd(var_54_0, 25) or cxtd(var_54_0, 83) then
			WAR.TFH = 1
		end

		if cxtd(var_54_0, 91) and JY.Person[var_54_0]["武功" .. arg_54_1] == 28 then
			WAR.WQQ = 1
		end

		if cxtd(var_54_0, 162) and JLSD(30, 45, var_54_0) then
			WAR.DBS = 1
		end

		if cxtd(var_54_0, 74) and JY.Person[var_54_0]["武功" .. arg_54_1] == 29 then
			WAR.HQT = 1
		end

		if cxtd(var_54_0, 63) and JY.Person[var_54_0]["武功" .. arg_54_1] == 38 then
			WAR.CY = 1
		end

		if PersonKF(var_54_0, 35) and var_54_1 == 61 then
			WAR.FDHOT = 1
			WAR.Person[arg_54_0].特效文字3 = "金日火乌·灼烧"
		end

		if cxtd(var_54_0, 589) and JLSD(20, 90, var_54_0) or PersonKF(var_54_0, 61) and var_54_1 == 35 then
			WAR.L_SSBD = 1
			WAR.Person[arg_54_0].特效文字3 = "雪谷冰山·冻结"
		end

		if JY.Person[var_54_0].内力性质 == 2 and JY.Person[var_54_0].悟性 < 80 and WAR.L_SGJL == 108 then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "真·易筋洗髓"
			else
				WAR.Person[arg_54_0].特效文字1 = "真·易筋洗髓"
			end
		end

		if cxtd(var_54_0, 162) then
			WAR.Person[arg_54_0].特效文字1 = "一日不过三·我三三三"
		end

		if cxtd(var_54_0, 163) and JLSD(20, 80, var_54_0) then
			WAR.JLJJB = 1
			WAR.Person[arg_54_0].特效文字2 = "一日不过四·你死死死死死"
		end

		if yongjian(var_54_1) and cxtd(var_54_0, 96) then
			WAR.L_SSBD = 1
			WAR.Person[arg_54_0].特效文字3 = "水月剑"
		end

		if PersonKF(var_54_0, 107) and JY.Person[var_54_0].内力性质 == 0 or JY.Person[var_54_0].主功体 == 107 and JLSD(20, 50, var_54_0) and JY.Person[var_54_0].内力性质 == 0 or JY.Person[var_54_0].主功体 == 107 and (var_54_1 == 19 or var_54_1 == 21) and JY.Person[var_54_0].内力性质 == 0 or JY.Person[var_54_0].副功体 > 0 and var_54_1 == 107 and JLSD(20, 50, var_54_0) then
			WAR.L_SSBD = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "至阴寒气"
			else
				WAR.Person[arg_54_0].特效文字3 = "至阴寒气"
			end
		end

		if PersonKF(var_54_0, 106) and JY.Person[var_54_0].内力性质 == 1 or JY.Person[var_54_0].主功体 == 106 and JLSD(50, 80, var_54_0) and JY.Person[var_54_0].内力性质 == 1 or JY.Person[var_54_0].主功体 == 106 and (var_54_1 == 17 or var_54_1 == 26 or var_54_1 == 65 or var_54_1 == 66) and JY.Person[var_54_0].内力性质 == 1 or JY.Person[var_54_0].副功体 > 0 and var_54_1 == 106 and JLSD(50, 80, var_54_0) then
			WAR.FDHOT = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "至阳真气"
			else
				WAR.Person[arg_54_0].特效文字3 = "至阳真气"
			end
		end

		if cxtd(var_54_0, 132) and WAR.BJ == 1 then
			WAR.FDHOT = 1

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "性如烈火"
			else
				WAR.Person[arg_54_0].特效文字2 = "性如烈火"
			end
		end

		if cxtd(var_54_0, 20) and JLSD(20, 80, var_54_0) then
			WAR.XXYY = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "潇湘夜雨"
			else
				WAR.Person[arg_54_0].特效文字1 = "潇湘夜雨"
			end
		end

		if cxtd(var_54_0, 21) and JLSD(20, 70, var_54_0) then
			WAR.QDSX = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "气定神闲"
			else
				WAR.Person[arg_54_0].特效文字1 = "气定神闲"
			end
		end

		if cxtd(var_54_0, 120) and JLSD(20, 70, var_54_0) then
			WAR.QDSX = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "开山劈林"
			else
				WAR.Person[arg_54_0].特效文字1 = "开山劈林"
			end
		end

		if cxtd(var_54_0, 22) and JLSD(20, 80, var_54_0) then
			WAR.BPHG = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "冰魄寒光"
			else
				WAR.Person[arg_54_0].特效文字1 = "冰魄寒光"
			end
		end

		if PersonKF(arg_54_0, 72) and PersonKF(arg_54_0, 73) and PersonKF(arg_54_0, 81) and PersonKF(arg_54_0, 84) then
			WAR.QQSH = 1
		end

		if cxtd(var_54_0, 31) and JLSD(20, 80, var_54_0) then
			WAR.MBDQ = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "妙笔丹青"
			else
				WAR.Person[arg_54_0].特效文字1 = "妙笔丹青"
			end
		end

		if cxtd(var_54_0, 32) or cxtd(var_54_0, 101) and JLSD(20, 80, var_54_0) then
			WAR.SBCS = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "三杯草圣"
			else
				WAR.Person[arg_54_0].特效文字1 = "三杯草圣"
			end
		end

		if cxtd(var_54_0, 33) and JLSD(20, 80, var_54_0) then
			WAR.OXQP = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "呕血楸枰"
			else
				WAR.Person[arg_54_0].特效文字1 = "呕血楸枰"
			end
		end

		if cxtd(var_54_0, 34) and JLSD(20, 80, var_54_0) then
			WAR.QXWX = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "七弦无形剑气"
			else
				WAR.Person[arg_54_0].特效文字1 = "七弦无形剑气"
			end
		end

		if cxtd(var_54_0, 75) and JLSD(20, 90, var_54_0) then
			WAR.PDJN = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "忧国忧民"
			else
				WAR.Person[arg_54_0].特效文字1 = "忧国忧民"
			end
		end

		if var_54_1 == 20 and JY.Person[var_54_0].内力性质 == 1 and WAR.LQZ[var_54_0] ~= nil and WAR.LQZ[var_54_0] >= 100 then
			for iter_54_40 = 1, 2 do
				for iter_54_41 = 1, 2 do
					SetWarMap(arg_54_2 + iter_54_40 - 1, arg_54_3 + iter_54_41 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_40 + 1, arg_54_3 + iter_54_41 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_40 - 1, arg_54_3 - iter_54_41 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_40 + 1, arg_54_3 - iter_54_41 + 1, 4, 1)
				end
			end
		end

		if var_54_1 == 4 and JY.Person[var_54_0].内力性质 == 0 and WAR.LQZ[var_54_0] ~= nil and WAR.LQZ[var_54_0] >= 100 then
			for iter_54_42 = 1, 2 do
				for iter_54_43 = 1, 2 do
					SetWarMap(arg_54_2 + iter_54_42 - 1, arg_54_3 + iter_54_43 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_42 + 1, arg_54_3 + iter_54_43 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_42 - 1, arg_54_3 - iter_54_43 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_42 + 1, arg_54_3 - iter_54_43 + 1, 4, 1)
				end
			end
		end

		if PersonKF(var_54_0, 92) then
			for iter_54_44 = 0, WAR.PersonNum - 1 do
				local var_54_70 = WAR.ZYZ[var_54_0]
				local var_54_71 = JY.Person[var_54_0].内力

				if WAR.Person[iter_54_44].死亡 == false and WAR.Person[iter_54_44].我方 ~= WAR.Person[WAR.CurID].我方 and JY.Person[WAR.Person[iter_54_44].人物编号].内力 < math.modf(var_54_71 - 2000) and not cxtd(var_54_0, 149) then
					if JY.Person[var_54_0].主功体 == 92 and JLSD(20, 90, var_54_0) then
						WAR.Person[iter_54_44].TimeAdd = WAR.Person[iter_54_44].TimeAdd - (var_54_70 + 100)
					elseif JLSD(20, 70, var_54_0) then
						WAR.Person[iter_54_44].TimeAdd = WAR.Person[iter_54_44].TimeAdd - (50 + var_54_70 / 2)
					end

					if WAR.Person[arg_54_0].特效动画 == nil then
						WAR.Person[arg_54_0].特效动画 = 89
					end

					if WAR.Person[arg_54_0].特效文字2 ~= nil then
						-- Nothing
					else
						WAR.Person[arg_54_0].特效文字2 = "狮子吼"
					end
				end
			end
		end

		if PersonKF(var_54_0, 92) and JLSD(10, 90, var_54_0) and cxtd(var_54_0, 149) then
			local var_54_72 = WAR.ZYZ[var_54_0] + JY.Person[0].品德
			local var_54_73 = JY.Person[var_54_0].内力

			for iter_54_45 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_45].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_45].死亡 == false and JY.Person[WAR.Person[iter_54_45].人物编号].内力 < math.modf(var_54_73 - 1000) then
					if JY.Person[var_54_0].主功体 == 92 then
						WAR.Person[iter_54_45].TimeAdd = WAR.Person[iter_54_45].TimeAdd - (var_54_72 + 300)
						JY.Person[WAR.Person[iter_54_45].人物编号].生命 = JY.Person[WAR.Person[iter_54_45].人物编号].生命 - 100
					else
						WAR.Person[iter_54_45].TimeAdd = WAR.Person[iter_54_45].TimeAdd - (200 + var_54_72 / 2)
						JY.Person[WAR.Person[iter_54_45].人物编号].生命 = JY.Person[WAR.Person[iter_54_45].人物编号].生命 - 100
					end
				end
			end

			if WAR.Person[arg_54_0].特效动画 == nil then
				WAR.Person[arg_54_0].特效动画 = 89
			end

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "金刚禅·狮子吼"
			else
				WAR.Person[arg_54_0].特效文字2 = "金刚禅·狮子吼"
			end
		end

		if Curr_NG(var_54_0, 92) and JLSD(30, 70, var_54_0) then
			for iter_54_46 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_46].死亡 == false and WAR.Person[iter_54_46].我方 ~= WAR.Person[WAR.CurID].我方 then
					if PersonKF(var_54_0, 103) or cxtd(var_54_0, 13) then
						JY.Person[WAR.Person[iter_54_46].人物编号].生命 = JY.Person[WAR.Person[iter_54_46].人物编号].生命 - 50
						JY.Person[WAR.Person[iter_54_46].人物编号].受伤程度 = JY.Person[WAR.Person[iter_54_46].人物编号].受伤程度 + 10
					else
						JY.Person[WAR.Person[iter_54_46].人物编号].受伤程度 = JY.Person[WAR.Person[iter_54_46].人物编号].受伤程度 + 10
					end
				end
			end

			if WAR.Person[arg_54_0].特效动画 == nil then
				WAR.Person[arg_54_0].特效动画 = 89
			end

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "虎啸龙呤"
			else
				WAR.Person[arg_54_0].特效文字2 = "虎啸龙呤"
			end
		end

		if cxtd(var_54_0, 58) and WAR.XK ~= 2 then
			for iter_54_47 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_47].死亡 == false and WAR.Person[iter_54_47].我方 ~= WAR.Person[WAR.CurID].我方 then
					WAR.Person[iter_54_47].TimeAdd = WAR.Person[iter_54_47].TimeAdd - 100
				end
			end

			if WAR.Person[arg_54_0].特效动画 == nil then
				WAR.Person[arg_54_0].特效动画 = 89
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "西狂之怒啸"
			else
				WAR.Person[arg_54_0].特效文字1 = "西狂之怒啸"
			end
		end

		if cxtd(var_54_0, 5109) and JLSD(10, 50, var_54_0) then
			for iter_54_48 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_48].死亡 == false and WAR.Person[iter_54_48].我方 ~= WAR.Person[WAR.CurID].我方 then
					WAR.Person[iter_54_48].TimeAdd = WAR.Person[iter_54_48].TimeAdd - 200
				end
			end

			if WAR.Person[arg_54_0].特效动画 == nil then
				WAR.Person[arg_54_0].特效动画 = 89
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "碧海潮生"
			else
				WAR.Person[arg_54_0].特效文字1 = "碧海潮生"
			end
		end

		if cxtd(var_54_0, 596) and JLSD(10, 40, var_54_0) then
			for iter_54_49 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_49].死亡 == false and WAR.Person[iter_54_49].我方 ~= WAR.Person[WAR.CurID].我方 then
					WAR.Person[iter_54_49].TimeAdd = WAR.Person[iter_54_49].TimeAdd - 200
				end
			end

			if WAR.Person[arg_54_0].特效动画 == nil then
				WAR.Person[arg_54_0].特效动画 = 5
			end

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "紫金刀"
			else
				WAR.Person[arg_54_0].特效文字2 = "紫金刀"
			end
		end

		if WAR.XK == 2 and cxtd(var_54_0, 58) and WAR.Person[WAR.CurID].我方 == WAR.XK2 then
			for iter_54_50 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_50].死亡 == false and WAR.Person[iter_54_50].我方 ~= WAR.Person[WAR.CurID].我方 then
					WAR.Person[iter_54_50].TimeAdd = WAR.Person[iter_54_50].TimeAdd - math.modf(JY.Person[WAR.Person[WAR.CurID].人物编号].内力 / 5)

					if WAR.Person[iter_54_50].Time < -450 then
						WAR.Person[iter_54_50].Time = -450
					end

					JY.Person[WAR.Person[iter_54_50].人物编号].内力 = JY.Person[WAR.Person[iter_54_50].人物编号].内力 - math.modf(JY.Person[WAR.Person[WAR.CurID].人物编号].内力 / 5)

					if JY.Person[WAR.Person[iter_54_50].人物编号].内力 < 0 then
						JY.Person[WAR.Person[iter_54_50].人物编号].内力 = 0
					end

					JY.Person[WAR.Person[iter_54_50].人物编号].生命 = JY.Person[WAR.Person[iter_54_50].人物编号].生命 - math.modf(JY.Person[WAR.Person[WAR.CurID].人物编号].内力 / 25)
				end

				if JY.Person[WAR.Person[iter_54_50].人物编号].生命 < 0 then
					JY.Person[WAR.Person[iter_54_50].人物编号].生命 = 0
				end
			end

			if instruct_16(var_54_0) then
				JY.Person[var_54_0].内力 = 0
				JY.Person[var_54_0].内力最大值 = JY.Person[var_54_0].内力最大值 - 100
				JY.Person[300].声望 = JY.Person[300].声望 + 1
			else
				AddPersonAttrib(var_54_0, "内力", -1000)
			end

			if JY.Person[var_54_0].内力最大值 < 500 then
				JY.Person[var_54_0].内力最大值 = 500
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "西狂之震怒·雷霆狂啸"
			else
				WAR.Person[arg_54_0].特效文字1 = "西狂之震怒·雷霆狂啸"
			end

			WAR.Person[arg_54_0].特效动画 = 6
			WAR.XK = 3
		end

		if cxtd(var_54_0, 73) and JY.Person[var_54_0]["武功" .. arg_54_1] == 73 then
			if math.random(10) < 7 then
				WAR.Person[arg_54_0].特效文字3 = "七弦无琴剑气"
				WAR.Person[arg_54_0].特效动画 = 89

				for iter_54_51 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_54_51].死亡 == false and WAR.Person[iter_54_51].我方 ~= WAR.Person[WAR.CurID].我方 then
						JY.Person[WAR.Person[iter_54_51].人物编号].生命 = JY.Person[WAR.Person[iter_54_51].人物编号].生命 - 80
					end
				end
			elseif math.random(10) < 7 then
				for iter_54_52 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_54_52].人物编号 == 35 and WAR.Person[iter_54_52].死亡 == false and WAR.Person[iter_54_52].我方 == WAR.Person[WAR.CurID].我方 then
						JY.Person[WAR.Person[iter_54_52].人物编号].体力 = 100
						JY.Person[WAR.Person[WAR.CurID].人物编号].体力 = 100
						JY.Person[WAR.Person[iter_54_52].人物编号].受伤程度 = 0
						JY.Person[WAR.Person[WAR.CurID].人物编号].受伤程度 = 0
						WAR.Person[arg_54_0].特效文字3 = "剑胆琴心 笑傲江湖"
						WAR.Person[arg_54_0].特效动画 = 89
					end
				end
			end
		end

		if cxtd(var_54_0, 5) and math.random(10) < 7 then
			WAR.ZSF = 1
			WAR.Person[arg_54_0].特效文字1 = "万法自然"
		end

		if cxtd(var_54_0, 49) and math.random(10) < 7 then
			WAR.XZZ = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "福泽加护"
			else
				WAR.Person[arg_54_0].特效文字1 = "福泽加护"
			end
		end

		if cxtd(var_54_0, 27) and math.random(10) < 7 then
			WAR.Person[arg_54_0].特效文字3 = "葵花点穴手"
			var_54_41 = var_54_41 + 1200
		end

		if cxtd(var_54_0, 2) then
			for iter_54_53 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_53].死亡 == false and WAR.Person[iter_54_53].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_53].人物编号].中毒程度 = JY.Person[WAR.Person[iter_54_53].人物编号].中毒程度 + 20
				end

				if JY.Person[WAR.Person[iter_54_53].人物编号].中毒程度 > 100 then
					JY.Person[WAR.Person[iter_54_53].人物编号].中毒程度 = 100
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "七心海棠"
			else
				WAR.Person[arg_54_0].特效文字1 = "七心海棠"
			end

			WAR.Person[arg_54_0].特效动画 = 64
		end

		if cxtd(var_54_0, 5105) and JLSD(30, 70, var_54_0) then
			for iter_54_54 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_54].死亡 == false and WAR.Person[iter_54_54].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_54].人物编号].中毒程度 = JY.Person[WAR.Person[iter_54_54].人物编号].中毒程度 + 5 + math.random(30)
				end

				if JY.Person[WAR.Person[iter_54_54].人物编号].中毒程度 > 100 then
					JY.Person[WAR.Person[iter_54_54].人物编号].中毒程度 = 100
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "七步断肠散"
			else
				WAR.Person[arg_54_0].特效文字1 = "七步断肠散"
			end

			WAR.Person[arg_54_0].特效动画 = 64
		end

		if cxtd(var_54_0, 2) and JLSD(30, 70, var_54_0) then
			for iter_54_55 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_55].死亡 == false and WAR.Person[iter_54_55].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_55].人物编号].内力 = JY.Person[WAR.Person[iter_54_55].人物编号].内力 - 100 - math.random(500)
				end

				if JY.Person[WAR.Person[iter_54_55].人物编号].内力 < 0 then
					JY.Person[WAR.Person[iter_54_55].人物编号].内力 = 0
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "悲酥清风"
			else
				WAR.Person[arg_54_0].特效文字1 = "悲酥清风"
			end

			WAR.Person[arg_54_0].特效动画 = 64
		end

		if cxtd(var_54_0, 5107) and JLSD(30, 70, var_54_0) or cxtd(var_54_0, 46) and JLSD(20, 80, var_54_0) then
			for iter_54_56 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_56].死亡 == false and WAR.Person[iter_54_56].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_56].人物编号].生命 = JY.Person[WAR.Person[iter_54_56].人物编号].生命 - 30 - math.random(70)
				end

				if JY.Person[WAR.Person[iter_54_56].人物编号].生命 < 0 then
					JY.Person[WAR.Person[iter_54_56].人物编号].生命 = 0
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "三笑逍遥散"
			else
				WAR.Person[arg_54_0].特效文字1 = "三笑逍遥散"
			end

			WAR.Person[arg_54_0].特效动画 = 64
		end

		if var_54_1 == 66 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and cxtd(var_54_0, 103) or JLSD(30, 70, var_54_0) and JY.Person[var_54_0].耍刀技巧 >= 180 and JY.Person[var_54_0]["武功" .. arg_54_1] == 66 then
			for iter_54_57 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_57].死亡 == false and WAR.Person[iter_54_57].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_57].人物编号].受伤程度 = JY.Person[WAR.Person[iter_54_57].人物编号].受伤程度 + 30
				end

				if JY.Person[WAR.Person[iter_54_57].人物编号].受伤程度 > 100 then
					JY.Person[WAR.Person[iter_54_57].人物编号].受伤程度 = 100
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "大轮密宗·火焰刀"
			else
				WAR.Person[arg_54_0].特效文字1 = "大轮密宗·火焰刀"
			end

			WAR.Person[arg_54_0].特效动画 = 58
			var_54_41 = var_54_41 + 1000
		end

		if var_54_1 == 59 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and cxtd(var_54_0, 106) then
			for iter_54_58 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_58].死亡 == false and WAR.Person[iter_54_58].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_58].人物编号].受伤程度 = JY.Person[WAR.Person[iter_54_58].人物编号].受伤程度 + 15
				end

				if JY.Person[WAR.Person[iter_54_58].人物编号].受伤程度 > 100 then
					JY.Person[WAR.Person[iter_54_58].人物编号].受伤程度 = 100
				end
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "断金刀"
			else
				WAR.Person[arg_54_0].特效文字1 = "断金刀"
			end

			WAR.Person[arg_54_0].特效动画 = 58
			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 18) and WAR.NGJL == 0 and WAR.L_SGJL == 0 then
			if WAR.Person[arg_54_0].特效文字2 == nil then
				WAR.Person[arg_54_0].特效文字2 = "混元霹雳功加力"
			else
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "混元霹雳功加力"
			end

			WAR.Person[arg_54_0].特效动画 = 6
			var_54_41 = var_54_41 + 2000

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = "魔相·幻阴"
			else
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. "魔相·幻阴"
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 63 and (JY.Person[var_54_0].武器 == 44 or cxtd(var_54_0, 97)) then
			WAR.XDDF = 1
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 16 then
			if WAR.tmp[3000 + var_54_0] == nil then
				WAR.tmp[3000 + var_54_0] = 0
			elseif WAR.tmp[3000 + var_54_0] > 0 then
				WAR.Person[arg_54_0].特效文字3 = "太极拳借力打力"
				var_54_41 = var_54_41 + WAR.tmp[3000 + var_54_0] * 5
			end
		end

		for iter_54_59, iter_54_60 in pairs(CC.KfName) do
			if iter_54_60[1] == var_54_1 and (myrandom(var_54_5, var_54_0) or cxtd(var_54_0, 118) or WAR.NGJL == 98 or WAR.LQZ[var_54_0] == 100 or PersonKF(var_54_0, 98) and JLSD(10, 50, var_54_0) or cxtd(var_54_0, 185) or JY.Person[var_54_0].主功体 == 98) then
				if WAR.Person[arg_54_0].特效文字3 ~= nil then
					WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "+" .. iter_54_60[2]
				else
					WAR.Person[arg_54_0].特效文字3 = iter_54_60[2]
				end

				if cxtd(var_54_0, 5104) then
					var_54_41 = var_54_41 + iter_54_60[3] * 2
				elseif cxtd(var_54_0, 117) then
					var_54_41 = var_54_41 + iter_54_60[3] * 2
				else
					var_54_41 = var_54_41 + iter_54_60[3]
				end

				if var_54_1 == 41 then
					if iter_54_60[2] == "灭" then
						WAR.L_MJJF = 1

						break
					end

					WAR.L_MJJF = 2
				end

				break
			end
		end

		if var_54_1 == 53 and (JLSD(20, 60) or PersonKF(68, var_54_0) and JLSD(20, 50) or cxtd(var_54_0, 133)) then
			WAR.L_NSDFCC = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "·单刀破枪"
			else
				WAR.Person[arg_54_0].特效文字3 = "单刀破枪"
			end
		end

		if WAR.L_WYJFA > 0 then
			CleanWarMap(4, 0)

			local var_54_74 = 6
			local var_54_75 = 1800

			if PersonKF(var_54_0, 89) then
				var_54_74 = 8
				var_54_75 = var_54_75 + 500
			end

			for iter_54_61 = 1, var_54_74 do
				for iter_54_62 = 1, var_54_74 do
					SetWarMap(arg_54_2 + iter_54_61 - 1, arg_54_3 + iter_54_62 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_61 + 1, arg_54_3 + iter_54_62 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_61 - 1, arg_54_3 - iter_54_62 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_61 + 1, arg_54_3 - iter_54_62 + 1, 4, 1)
				end
			end

			var_54_41 = var_54_41 + var_54_75

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "·五岳剑法"
			else
				WAR.Person[arg_54_0].特效文字3 = "五岳剑法"
			end

			WAR.WS = 1
		end

		if var_54_1 == 172 then
			var_54_41 = var_54_41 + JY.Person[var_54_0].实战
		end

		if (var_54_1 == 68 or var_54_1 == 175) and (JY.Person[var_54_0].坐骑 == 230 or JY.Person[var_54_0].坐骑 == 225 or JY.Person[var_54_0].坐骑 == 226) then
			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 5) and WAR.Person[arg_54_0].特效文字3 ~= nil and JLSD(35, 50, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = "化朽为奇" .. "+" .. WAR.Person[arg_54_0].特效文字3
			var_54_41 = var_54_41 + 2000
			WAR.ZSF2 = 1
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 3 and var_54_1 == 64 and JLSD(20, 80, var_54_0) then
			local var_54_76 = math.modf(GetS(14, 3, 1, 4) / 100)

			var_54_41 = var_54_41 + var_54_76 * 100
			WAR.Person[arg_54_0].特效文字3 = "刀" .. SZB[var_54_76]
		end

		if (JY.Person[var_54_0]["武功" .. arg_54_1] == 8 or JY.Person[var_54_0]["武功" .. arg_54_1] == 14) and (cxtd(var_54_0, 49) or JY.Person[var_54_0].拳掌功夫 >= 180) and PersonKF(var_54_0, 101) and (JLSD(20, 80, var_54_0) or WAR.NGJL == 98) then
			WAR.Person[arg_54_0].特效文字3 = "灵鹫宫绝学·生死符"
			var_54_41 = var_54_41 + 1700
			WAR.SSFwav = 1
			WAR.TZ_XZ = 1
		end

		if PersonKF(var_54_0, 18) and yongquan(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if PersonKF(var_54_0, 24) and yongquan(var_54_1) then
			var_54_41 = var_54_41 + 300
		end

		if PersonKF(var_54_0, 25) and yongquan(var_54_1) then
			var_54_41 = var_54_41 + 400
		end

		if PersonKF(var_54_0, 26) and yongquan(var_54_1) then
			var_54_41 = var_54_41 + 500
		end

		if PersonKF(var_54_0, 49) and yongjian(var_54_1) then
			var_54_41 = var_54_41 + 500
		end

		if PersonKF(var_54_0, 45) and yongjian(var_54_1) then
			var_54_41 = var_54_41 + 500
		end

		if PersonKF(var_54_0, 51) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 100
		end

		if PersonKF(var_54_0, 53) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 100
		end

		if PersonKF(var_54_0, 63) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 250
		end

		if PersonKF(var_54_0, 59) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 150
		end

		if PersonKF(var_54_0, 54) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 150
		end

		if PersonKF(var_54_0, 60) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if PersonKF(var_54_0, 62) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 300
		end

		if PersonKF(var_54_0, 67) and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 400
		end

		if PersonKF(var_54_0, 66) and JY.Person[var_54_0].内力性质 == 1 and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if PersonKF(var_54_0, 66) and JY.Person[var_54_0].内力性质 == 2 and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 400
		end

		if PersonKF(var_54_0, 61) and JY.Person[var_54_0].内力性质 == 1 and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if PersonKF(var_54_0, 61) and JY.Person[var_54_0].内力性质 == 2 and yongdao(var_54_1) then
			var_54_41 = var_54_41 + 300
		end

		if PersonKF(var_54_0, 70) and yongte(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if PersonKF(var_54_0, 72) and yongte(var_54_1) then
			var_54_41 = var_54_41 + 300
		end

		if PersonKF(var_54_0, 84) and yongte(var_54_1) then
			var_54_41 = var_54_41 + 300
		end

		if PersonKF(var_54_0, 80) and yongte(var_54_1) then
			var_54_41 = var_54_41 + 400
		end

		if cxtd(var_54_0, 57) and JLSD(20, 80, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = "碧海潮生"
			var_54_41 = var_54_41 + 1000
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 64 and JLSD(20, 80, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = "变幻莫测"
			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 117) then
			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "·生死符"
			else
				WAR.Person[arg_54_0].特效文字3 = "灵鹫宫绝学·生死符"
			end

			var_54_41 = var_54_41 + 1500
			WAR.ZSSF = 1
		end

		if cxtd(var_54_0, 590) and yongte(var_54_1) and JLSD(30, 80, var_54_0) then
			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "·星月争辉"
			else
				WAR.Person[arg_54_0].特效文字3 = "心秀天铃·星月争辉"
			end

			var_54_41 = var_54_41 + 1000
			WAR.SSFwav = 1
		end

		if yongquan(var_54_1) and cxtd(var_54_0, 182) and JLSD(30, 80, var_54_0) then
			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "·开山掌"
			else
				WAR.Person[arg_54_0].特效文字2 = "五丁开山掌"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 187) and JLSD(20, 80, var_54_0) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "·除恶务尽"
			else
				WAR.Person[arg_54_0].特效文字1 = "除恶务尽"
			end

			var_54_41 = var_54_41 + 1000
		end

		if (cxtd(var_54_0, 77) or cxtd(var_54_0, 154)) and var_54_1 == 54 and WAR.LQZ[var_54_0] == 100 then
			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "·天下无双"
			else
				WAR.Person[arg_54_0].特效文字2 = "韩王青刀·天下无双"
				WAR.WS = 1
				var_54_41 = var_54_41 + 2500
				WAR.SSFwav = 1
			end
		end

		if WAR.L_MJJF == 2 then
			var_54_41 = var_54_41 + 400

			if JY.Person[var_54_0].武器 == 37 then
				var_54_41 = var_54_41 + 400
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 80 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and (JLSD(30, 70, var_54_0) and JY.Person[var_54_0].特殊兵器 >= 180 or JY.Person[var_54_0]["武功" .. arg_54_1] == 80 and (JY.Base.主角职业 == 4 or cxtd(var_54_0, 56) or cxtd(var_54_0, 69) or cxtd(var_54_0, 626)) and JLSD(20, 80, var_54_0)) then
			WAR.Person[arg_54_0].特效文字3 = "打狗棒法绝学--天下无狗"
			WAR.Person[arg_54_0].特效动画 = 89

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				var_54_41 = var_54_41 - 800
			end

			var_54_41 = var_54_41 + 1500
			WAR.WS = 1

			for iter_54_63 = 1, 6 do
				for iter_54_64 = 1, 6 do
					SetWarMap(arg_54_2 + iter_54_63 - 1, arg_54_3 + iter_54_64 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_63 + 1, arg_54_3 + iter_54_64 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_63 - 1, arg_54_3 - iter_54_64 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_63 + 1, arg_54_3 - iter_54_64 + 1, 4, 1)
				end
			end
		end

		if cxtd(var_54_0, 58) and var_54_25 == 3 and GetS(86, 11, 11, 5) == 2 then
			WAR.Person[arg_54_0].特效动画 = 6
			WAR.WS = 1

			for iter_54_65 = 1, 5 do
				for iter_54_66 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_65 - 1, arg_54_3 + iter_54_66 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_65 + 1, arg_54_3 + iter_54_66 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_65 - 1, arg_54_3 - iter_54_66 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_65 + 1, arg_54_3 - iter_54_66 + 1, 4, 1)
				end

				local var_54_77 = {
					"黯然极意·六神不安",
					"黯然极意·倒行逆施",
					"黯然极意·行尸走肉"
				}

				WAR.Person[arg_54_0].特效文字3 = var_54_77[WAR.ACT]
			end
		end

		if var_54_1 == 67 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and cxtd(var_54_0, 1) and JLSD(20, 70, var_54_0) or JLSD(30, 70, var_54_0) and JY.Person[var_54_0].耍刀技巧 >= 180 and JY.Person[var_54_0]["武功" .. arg_54_1] == 67 then
			local var_54_78 = {
				"极意·伏虎式",
				"极意·拜佛听经",
				"极意·穿手藏刀",
				"极意·沙鸥掠波",
				"极意·参拜北斗",
				"极意·闭门铁扇刀",
				"极意·缠身摘心刀",
				"极意·进步连环刀",
				"极意·八方藏刀式"
			}

			WAR.Person[arg_54_0].特效文字3 = var_54_78[math.random(9)]
			WAR.Person[arg_54_0].特效动画 = 6
			var_54_41 = var_54_41 + 1800
			WAR.WS = 1

			for iter_54_67 = 1, 5 do
				for iter_54_68 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_67 - 1, arg_54_3 + iter_54_68 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_67 + 1, arg_54_3 + iter_54_68 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_67 - 1, arg_54_3 - iter_54_68 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_67 + 1, arg_54_3 - iter_54_68 + 1, 4, 1)
				end
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 45 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and (JLSD(20, 70, var_54_0) and JY.Person[var_54_0].御剑能力 >= 180 or cxtd(var_54_0, 58) and math.random(10) < 7) then
			WAR.Person[arg_54_0].特效文字3 = "重剑真传·浪如山涌剑如虹"
			WAR.Person[arg_54_0].特效动画 = 84
			var_54_41 = var_54_41 + 1800
			WAR.WS = 1
			WAR.XTSW = 1
			WAR.XTSQ = 1

			for iter_54_69 = 1, 5 do
				for iter_54_70 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_69 - 1, arg_54_3 + iter_54_70 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_69 + 1, arg_54_3 + iter_54_70 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_69 - 1, arg_54_3 - iter_54_70 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_69 + 1, arg_54_3 - iter_54_70 + 1, 4, 1)
				end
			end
		end

		if var_54_1 == 175 and JY.Person[var_54_0].特殊兵器 >= 150 and JLSD(20, 70, var_54_0) then
			WAR.Person[arg_54_0].特效文字3 = "春雨绵绵"
			WAR.Person[arg_54_0].特效动画 = 84
			var_54_41 = var_54_41 + 1800
			WAR.WS = 1
			WAR.XTSW = 1
			WAR.XTSQ = 1

			for iter_54_71 = 1, 5 do
				for iter_54_72 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_71 - 1, arg_54_3 + iter_54_72 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_71 + 1, arg_54_3 + iter_54_72 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_71 - 1, arg_54_3 - iter_54_72 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_71 + 1, arg_54_3 - iter_54_72 + 1, 4, 1)
				end
			end
		end

		if var_54_1 == 45 and WAR.XTSQ == 1 then
			for iter_54_73 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_73].死亡 == false and WAR.Person[iter_54_73].我方 ~= WAR.Person[WAR.CurID].我方 then
					WAR.Person[iter_54_73].TimeAdd = WAR.Person[iter_54_73].TimeAdd - 100
				end

				WAR.XTSQ = nil
			end
		end

		if (JLSD(10, 60, var_54_0) and PersonKF(var_54_0, 4) or cxtd(var_54_0, 170)) and var_54_1 == 20 then
			WAR.Person[arg_54_0].特效文字3 = "鹰龙相击"
			WAR.Person[arg_54_0].特效动画 = 84
			var_54_41 = var_54_41 + 1800
			WAR.WS = 1
			WAR.XTSW = 1

			for iter_54_74 = 1, 5 do
				for iter_54_75 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_74 - 1, arg_54_3 + iter_54_75 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_74 + 1, arg_54_3 + iter_54_75 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_74 - 1, arg_54_3 - iter_54_75 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_74 + 1, arg_54_3 - iter_54_75 + 1, 4, 1)
				end
			end
		end

		if JY.Person[var_54_0]["武功" .. arg_54_1] == 21 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 and JLSD(30, 70, var_54_0) and (JY.Person[var_54_0].拳掌功夫 >= 180 or cxtd(var_54_0, 46)) then
			WAR.Person[arg_54_0].特效文字3 = "玄冥极意"
			WAR.Person[arg_54_0].特效动画 = 68
			var_54_41 = var_54_41 + 2000
			WAR.WS = 1
			WAR.XTSW = 1

			for iter_54_76 = 1, 5 do
				for iter_54_77 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_76 - 1, arg_54_3 + iter_54_77 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_76 + 1, arg_54_3 + iter_54_77 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_76 - 1, arg_54_3 - iter_54_77 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_76 + 1, arg_54_3 - iter_54_77 + 1, 4, 1)
				end
			end
		end

		if (cxtd(var_54_0, 158) or JY.Person[var_54_0].武器 == 51) and JY.Person[var_54_0]["武功" .. arg_54_1] == 78 and JY.Person[var_54_0]["武功等级" .. arg_54_1] == 999 then
			WAR.Person[arg_54_0].特效文字3 = "金龙翻腾"
			WAR.Person[arg_54_0].特效动画 = 84
			var_54_41 = var_54_41 + 1300
			WAR.WS = 1
			WAR.HSWLB = 1

			for iter_54_78 = 1, 5 do
				for iter_54_79 = 1, 5 do
					SetWarMap(arg_54_2 + iter_54_78 - 1, arg_54_3 + iter_54_79 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_78 + 1, arg_54_3 + iter_54_79 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_78 - 1, arg_54_3 - iter_54_79 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_78 + 1, arg_54_3 - iter_54_79 + 1, 4, 1)
				end
			end
		end

		if cxtd(var_54_0, 84) and WAR.Person[arg_54_0].特效文字1 == nil and math.random(10) < 7 then
			WAR.HDWZ = 1
			WAR.Person[arg_54_0].特效文字1 = "暗箭·扇中钉"
			WAR.Person[arg_54_0].特效动画 = 89
		end

		if cxtd(var_54_0, 85) and WAR.Person[arg_54_0].特效文字1 == nil and math.random(10) < 4 then
			WAR.HDWZ = 1
			WAR.Person[arg_54_0].特效文字1 = "阴谋小人"
			WAR.Person[arg_54_0].特效动画 = 89
		end

		if cxtd(var_54_0, 157) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "·腐尸毒"
			else
				WAR.Person[arg_54_0].特效文字1 = "腐尸毒"
			end

			WAR.Person[arg_54_0].特效动画 = 89
		end

		if cxtd(var_54_0, 161) and JLSD(10, 90, var_54_0) then
			WAR.LMC = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "·冰魄银针"
			else
				WAR.Person[arg_54_0].特效文字1 = "五毒秘技·冰魄银针"
			end

			WAR.Person[arg_54_0].特效动画 = 89
		end

		if cxtd(var_54_0, 122) then
			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字1 .. "哀牢卅六剑"
			else
				WAR.Person[arg_54_0].特效文字2 = "哀牢卅六剑"
			end

			WAR.Person[arg_54_0].特效动画 = 89
		end

		if cxtd(var_54_0, 130) and JLSD(10, 70, var_54_0) then
			WAR.LMC = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "·铁蒺飞袭"
			else
				WAR.Person[arg_54_0].特效文字1 = "铁蒺飞袭"
			end

			WAR.Person[arg_54_0].特效动画 = 89
		end

		if T2SQ(var_54_0) and JY.Base.觉醒 == 1 and JLSD(25, 75, 0) and WAR.SQFJ ~= 1 and WAR.DZXY ~= 1 then
			Cls()
			DHZFXS("火凤燎原")

			WAR.Person[arg_54_0].特效动画 = 65
			WAR.WS = 1

			for iter_54_80 = 1, 10 do
				for iter_54_81 = 1, 10 do
					SetWarMap(arg_54_2 + iter_54_80 - 1, arg_54_3 + iter_54_81 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_80 + 1, arg_54_3 + iter_54_81 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_80 - 1, arg_54_3 - iter_54_81 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_80 + 1, arg_54_3 - iter_54_81 + 1, 4, 1)
				end
			end
		end

		if WAR.RZWD == 1 and var_54_1 == 91 and (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[9999].姓名 == JY.Person[JY.Base.队伍1].姓名) then
			WAR.WS = 1
		end

		if cxtd(var_54_0, 553) and WAR.YZB2 > 0 then
			if WAR.YZB2 > 2 then
				WAR.Person[arg_54_0].特效文字3 = "炎枪素浅鸣·无双乱舞皆传"
			elseif WAR.YZB2 > 1 then
				WAR.Person[arg_54_0].特效文字3 = "炎枪素浅鸣·真无双乱舞"
			elseif WAR.YZB2 > 0 then
				WAR.Person[arg_54_0].特效文字3 = "炎枪素浅鸣·无双乱舞"
			end

			WAR.Person[arg_54_0].特效动画 = 6
			var_54_41 = var_54_41 + 200 + WAR.YZB2 * 600
			WAR.WS = 1

			for iter_54_82 = 1, 4 + WAR.YZB2 * 2 do
				for iter_54_83 = 1, 4 + WAR.YZB2 * 2 do
					SetWarMap(arg_54_2 + iter_54_82 - 1, arg_54_3 + iter_54_83 - 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_82 + 1, arg_54_3 + iter_54_83 - 1, 4, 1)
					SetWarMap(arg_54_2 + iter_54_82 - 1, arg_54_3 - iter_54_83 + 1, 4, 1)
					SetWarMap(arg_54_2 - iter_54_82 + 1, arg_54_3 - iter_54_83 + 1, 4, 1)
				end
			end
		end

		if cxtd(var_54_0, 516) and WAR.KHCM[var_54_0] ~= 1 then
			WAR.Person[arg_54_0].特效文字3 = "二天一流秘奥义·万物一空"
			WAR.Person[arg_54_0].特效动画 = 6
			WAR.GBWZ = 1
			WAR.WS = 1
			var_54_41 = var_54_41 + 1500
		end

		if WAR.Data.代号 == 130 then
			for iter_54_84 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_84].人物编号 == 541 and WAR.Person[iter_54_84].死亡 == false and WAR.Person[iter_54_84].我方 == WAR.Person[WAR.CurID].我方 then
					WAR.BSMT = 1
					WAR.WS = 1
					var_54_41 = var_54_41 + 1500
					WAR.Person[arg_54_0].特效文字1 = "毗沙门天之加护"
					WAR.Person[arg_54_0].特效动画 = 6
				end
			end
		end

		if cxtd(var_54_0, 29) and WAR.L_TBGZL == 1 and JLSD(30, 90, var_54_0) then
			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "淫荡动世人"
			else
				WAR.Person[arg_54_0].特效文字1 = "淫荡动世人"
			end

			var_54_41 = var_54_41 + 1000
		end

		if cxtd(var_54_0, 27) and JLSD(30, 90, var_54_0) or Curr_NG(var_54_0, 105) and JLSD(30, 90, var_54_0) and var_54_1 == 48 or var_54_1 == 105 and WAR.L_SGJL == 105 and JLSD(30, 45, var_54_0) then
			WAR.KHBX = 2
			WAR.Person[arg_54_0].特效文字3 = "真辟邪剑法·葵花刺目"
			WAR.Person[arg_54_0].特效动画 = 6
		elseif (yongjian(var_54_1) or yongan(var_54_1)) and WAR.L_SGJL == 105 and JLSD(30, 35, var_54_0) then
			WAR.KHBX = 1

			if WAR.Person[arg_54_0].特效文字3 ~= nil then
				WAR.Person[arg_54_0].特效文字3 = WAR.Person[arg_54_0].特效文字3 .. "·葵花刺目"
			else
				WAR.Person[arg_54_0].特效文字3 = "葵花刺目"
			end

			WAR.Person[arg_54_0].特效动画 = 6
		end

		if cxtd(var_54_0, 600) and JLSD(10, 35, var_54_0) then
			WAR.KHBX = 1

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "石灰包"
			else
				WAR.Person[arg_54_0].特效文字1 = "石灰神功"
			end

			WAR.Person[arg_54_0].特效动画 = 1
		end

		if WAR.KHCM[var_54_0] == 1 or WAR.KHCM[var_54_0] == 2 then
			WAR.Person[arg_54_0].特效动画 = 89
			WAR.Person[arg_54_0].特效文字2 = "状态·盲目攻击"
		end

		if WAR.WYY == var_54_0 and not instruct_16(var_54_0) then
			WAR.Person[arg_54_0].特效动画 = 89
			WAR.Person[arg_54_0].特效文字2 = "状态·被点破"
		end

		if cxtd(var_54_0, 51) and WAR.HMXC > 0 and WAR.DZXY == 1 and WAR.DZXY ~= 0 then
			CleanWarMap(4, 0)

			for iter_54_85 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_85].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_85].死亡 == false then
					SetWarMap(WAR.Person[iter_54_85].坐标X, WAR.Person[iter_54_85].坐标Y, 4, 1)
				end
			end

			WAR.WS = 1
			WAR.HMXC = WAR.HMXC - 1
		end

		local var_54_79 = JY.Wugong[var_54_1].武功类型
		local var_54_80 = math.modf(JY.Person[JY.Base.队伍1].悟性 / 5)

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 2 and JY.Person[var_54_0].御剑能力 >= 300 and var_54_79 == 2 and var_54_1 ~= 49 and var_54_1 ~= 43 and JLSD(30, 50 + var_54_80, var_54_0) and JY.Base.二次觉醒 == 1 then
			CleanWarMap(4, 0)

			for iter_54_86 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_86].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_86].死亡 == false then
					SetWarMap(WAR.Person[iter_54_86].坐标X, WAR.Person[iter_54_86].坐标Y, 4, 1)
				end
			end

			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[2]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[2] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			var_54_41 = var_54_41 + 1500
			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 2, 10, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_87 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[2] .. TFSSJ[2], C_GOLD, CC.DefaultFont + iter_54_87 * 2)
				ShowScreen()

				if iter_54_87 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[2] .. TFSSJ[2], C_GOLD, CC.DefaultFont + iter_54_87 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			WAR.JSYX = 1
		end

		local var_54_81 = JY.Wugong[var_54_1].武功类型

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 9 and JY.Person[var_54_0].暗器技巧 >= 200 and var_54_81 == 7 and JLSD(30, 50) and JY.Base.二次觉醒 == 1 then
			CleanWarMap(4, 0)

			for iter_54_88 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_88].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_54_88].死亡 == false then
					SetWarMap(WAR.Person[iter_54_88].坐标X, WAR.Person[iter_54_88].坐标Y, 4, 1)
				end
			end

			WAR.Person[arg_54_0].特效动画 = 2

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[9]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[9] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 2, 10, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_89 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[9] .. TFSSJ[9], C_GOLD, CC.DefaultFont + iter_54_89 * 2)
				ShowScreen()

				if iter_54_89 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[9] .. TFSSJ[9], C_GOLD, CC.DefaultFont + iter_54_89 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			JY.Wugong[var_54_1]["武功动画&音效"] = 50
		end

		local var_54_82 = math.modf(JY.Person[var_54_0].用毒能力 / 10)

		if var_54_0 == 0 and JY.Base.主角职业 == 8 and JY.Base.觉醒 == 1 then
			for iter_54_90 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_54_90].死亡 == false and WAR.Person[iter_54_90].我方 ~= WAR.Person[WAR.CurID].我方 then
					JY.Person[WAR.Person[iter_54_90].人物编号].中毒程度 = JY.Person[WAR.Person[iter_54_90].人物编号].中毒程度 + var_54_82
				end

				if JY.Person[WAR.Person[iter_54_90].人物编号].中毒程度 > 200 then
					JY.Person[WAR.Person[iter_54_90].人物编号].中毒程度 = 200
				end
			end

			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[8]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[8] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 5, 10, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_91 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[8] .. TFSSJ[8], C_GOLD, CC.DefaultFont + iter_54_91 * 2)
				ShowScreen()

				if iter_54_91 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[8] .. TFSSJ[8], C_GOLD, CC.DefaultFont + iter_54_91 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			WAR.JSYX = 1
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 1 and JY.Person[var_54_0].拳掌功夫 >= 120 and JLSD(30, 50 + var_54_80, var_54_0) and (var_54_79 == 1 or var_54_1 == 49) and JY.Base.二次觉醒 == 1 then
			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[1]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[1] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			var_54_41 = var_54_41 + 1200
			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 0, 10, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_92 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[1] .. TFSSJ[1], C_GOLD, CC.DefaultFont + iter_54_92 * 2)
				ShowScreen()

				if iter_54_92 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[1] .. TFSSJ[1], C_GOLD, CC.DefaultFont + iter_54_92 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			WAR.LXZQ = 1
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 4 and JY.Person[var_54_0].特殊兵器 >= 120 and JLSD(25, 55 + var_54_80, var_54_0) and var_54_79 == 4 and JY.Base.二次觉醒 == 1 then
			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[4]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[4] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			var_54_41 = var_54_41 + 1000
			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 6, 100, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_93 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[4] .. TFSSJ[4], C_GOLD, CC.DefaultFont + iter_54_93 * 2)
				ShowScreen()

				if iter_54_93 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[4] .. TFSSJ[4], C_GOLD, CC.DefaultFont + iter_54_93 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			WAR.QMYC = 1
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 3 and JY.Person[var_54_0].耍刀技巧 >= 120 and JLSD(30, 55 + var_54_80, var_54_0) and var_54_79 == 3 and JY.Base.二次觉醒 == 1 then
			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字3 == nil then
				WAR.Person[arg_54_0].特效文字3 = ZJTF[3]
			else
				WAR.Person[arg_54_0].特效文字3 = ZJTF[3] .. "+" .. WAR.Person[arg_54_0].特效文字3
			end

			var_54_41 = var_54_41 + 2000
			WAR.WS = 1

			Cls()
			lib.LoadPNG(91, 4, 10, 10, 1)
			ShowScreen()
			lib.Delay(600)

			for iter_54_94 = 1, 10 do
				NewDrawString(-1, -1, ZJTF[3] .. TFSSJ[3], C_GOLD, CC.DefaultFont + iter_54_94 * 2)
				ShowScreen()

				if iter_54_94 == 10 then
					Cls()
					NewDrawString(-1, -1, ZJTF[3] .. TFSSJ[3], C_GOLD, CC.DefaultFont + iter_54_94 * 2)
					ShowScreen()
					lib.Delay(500)
				else
					lib.Delay(1)
				end
			end

			WAR.ASKD = 1
		end

		if (var_54_0 == JY.Base.队伍1 or var_54_0 == JY.Base.畅想编号 or var_54_0 == 9999 and JY.Person[var_54_0].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5 and WAR.JSTG < 150 and WAR.DZXY ~= 1 and JLSD(25, 55 + var_54_80, var_54_0) then
			local var_54_83 = 0

			for iter_54_95 = 1, CC.Kungfunum do
				if yongnei(var_54_1) and JY.Person[var_54_0]["武功等级" .. iter_54_95] == 999 then
					var_54_83 = var_54_83 + 1
				end
			end

			if var_54_83 > 0 then
				Cls()
				lib.LoadPNG(91, 8, 10, 10, 1)
				ShowScreen()
				lib.Delay(600)

				for iter_54_96 = 1, 10 do
					NewDrawString(-1, -1, ZJTF[5] .. TFSSJ[5], C_GOLD, CC.DefaultFont + iter_54_96 * 2)
					ShowScreen()

					if iter_54_96 == 10 then
						Cls()
						NewDrawString(-1, -1, ZJTF[5] .. TFSSJ[5], C_GOLD, CC.DefaultFont + iter_54_96 * 2)
						ShowScreen()
						lib.Delay(500)
					else
						lib.Delay(1)
					end
				end

				WAR.JSTG = 150
			end
		end

		if WAR.LQZ[var_54_0] == 100 and WAR.DZXY ~= 1 and WAR.SQFJ ~= 1 then
			WAR.Person[arg_54_0].特效动画 = 6

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "会心之一击"
			else
				WAR.Person[arg_54_0].特效文字1 = "会心之一击"
			end

			var_54_41 = var_54_41 + 1500
		end

		if WAR.Actup[var_54_0] ~= nil or JY.Person[var_54_0].主功体 == 95 or PersonKF(var_54_0, 103) and JLSD(25, 55, var_54_0) then
			local var_54_84 = "+蓄力攻击"

			if PersonKF(var_54_0, 103) then
				var_54_41 = var_54_41 + 1200
				var_54_84 = JY.Wugong[103].名称 .. "+" .. "蓄力攻击"
			elseif JY.Person[var_54_0].主功体 == 95 then
				var_54_41 = var_54_41 + 1200
				var_54_84 = JY.Wugong[95].名称 .. "+" .. "蓄力攻击"
			else
				var_54_41 = var_54_41 + 800
			end

			if WAR.Person[arg_54_0].特效文字1 ~= nil then
				WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. var_54_84
			else
				WAR.Person[arg_54_0].特效文字1 = "蓄力攻击"
			end
		end

		if WAR.L_SGJL == 107 and var_54_1 == 11 then
			var_54_41 = var_54_41 + 1000
		end

		if JY.Person[var_54_0].内力性质 == 2 and JY.Person[var_54_0].悟性 < 80 and WAR.L_SGJL == 108 then
			if JY.Person[var_54_0].悟性 < 50 then
				var_54_41 = var_54_41 + 800
			else
				var_54_41 = var_54_41 + 500
			end
		end

		if cxtd(var_54_0, 136) and JY.Base.畅想编号 == 136 then
			local var_54_85 = 0

			for iter_54_97 = 1, CC.Kungfunum do
				if yongjian(var_54_1) and JY.Person[JY.Base.队伍1]["武功等级" .. iter_54_97] == 999 then
					var_54_85 = var_54_85 + 1
				end

				var_54_41 = var_54_41 + var_54_85 * 150
			end
		end

		if WAR.XSZJ == 10 then
			var_54_41 = var_54_41 + 700
		end

		if cxtd(var_54_0, 121) then
			var_54_41 = var_54_41 + 700
		end

		if PersonKF(var_54_0, 28) and yongjian(var_54_1) then
			var_54_41 = var_54_41 + 200
		end

		if JY.Person[var_54_0].主功体 == 110 and yongjian(var_54_1) and JLSD(20, 80, var_54_0) then
			var_54_41 = var_54_41 + 500
		end

		if JY.Person[var_54_0].主功体 == 95 and var_54_1 == 9 then
			var_54_41 = var_54_41 + 500
		end

		if JY.Person[var_54_0].主功体 == 98 and var_54_1 == 8 then
			var_54_41 = var_54_41 + 400
		end

		if JY.Person[var_54_0].主功体 == 89 and yongjian(var_54_1) and JLSD(20, 80, var_54_0) then
			var_54_41 = var_54_41 + 1000

			if WAR.Person[arg_54_0].特效文字2 ~= nil then
				WAR.Person[arg_54_0].特效文字2 = WAR.Person[arg_54_0].特效文字2 .. "+" .. "紫霞剑气"
			else
				WAR.Person[arg_54_0].特效文字2 = "紫霞剑气"
			end
		end

		if WAR.L_SGJL == 108 and cxtd(var_54_0, 70) then
			WAR.Person[arg_54_0].特效文字1 = "袈裟伏魔"
			var_54_41 = var_54_41 + 1200
		end

		if cxtd(var_54_0, 24) and var_54_1 == 27 then
			var_54_41 = var_54_41 + 800
		end

		if cxtd(var_54_0, 138) then
			var_54_41 = var_54_41 + 800
		end

		if cxtd(var_54_0, 593) then
			var_54_41 = var_54_41 + 800
		end

		if cxtd(var_54_0, 185) and (JY.Person[var_54_0].武器 > 35 and JY.Person[var_54_0].武器 < 43 or JY.Person[var_54_0].武器 == 55 or JY.Person[var_54_0].武器 == 236) then
			var_54_41 = var_54_41 + 400
		end

		if cxtd(var_54_0, 136) and yongjian(var_54_1) then
			var_54_41 = var_54_41 + math.modf(JY.Wugong[var_54_1].攻击力10 / 2)
		end

		if cxtd(var_54_0, 79) and var_54_1 == 34 then
			var_54_41 = var_54_41 + 800
		end

		if cxtd(var_54_0, 150) then
			var_54_41 = var_54_41 + 600
		end

		if WAR.L_TLD == 1 then
			var_54_41 = var_54_41 + JY.Wugong[var_54_1].攻击力10
			WAR.Person[WAR.CurID].特效文字3 = JY.Thing[43].名称 .. "+" .. "暴击"
		end

		if cxtd(var_54_0, 591) and WAR.Person[arg_54_0].我方 then
			for iter_54_98 = 0, CC.WarWidth - 1 do
				for iter_54_99 = 0, CC.WarHeight - 1 do
					if GetWarMap(iter_54_98, iter_54_99, 4) > 0 then
						local var_54_86 = GetWarMap(iter_54_98, iter_54_99, 2)

						if var_54_86 >= 0 and WAR.Person[var_54_86].人物编号 == 38 then
							WAR.WS = 1

							if WAR.Person[arg_54_0].特效文字1 ~= nil then
								WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "相煎何太急"

								break
							end

							WAR.Person[arg_54_0].特效文字1 = "相煎何太急"

							break
						end
					end
				end
			end
		end

		if cxtd(var_54_0, 38) and WAR.Person[arg_54_0].我方 then
			for iter_54_100 = 0, CC.WarWidth - 1 do
				for iter_54_101 = 0, CC.WarHeight - 1 do
					if GetWarMap(iter_54_100, iter_54_101, 4) > 0 then
						local var_54_87 = GetWarMap(iter_54_100, iter_54_101, 2)

						if var_54_87 >= 0 and WAR.Person[var_54_87].人物编号 == 591 then
							WAR.WS = 1

							if WAR.Person[arg_54_0].特效文字1 ~= nil then
								WAR.Person[arg_54_0].特效文字1 = WAR.Person[arg_54_0].特效文字1 .. "+" .. "相煎何太急"

								break
							end

							WAR.Person[arg_54_0].特效文字1 = "相煎何太急"

							break
						end
					end
				end
			end
		end

		if var_54_1 == 73 then
			WAR.WS = 1

			for iter_54_102 = 0, CC.WarWidth - 1 do
				for iter_54_103 = 0, CC.WarHeight - 1 do
					if GetWarMap(iter_54_102, iter_54_103, 4) > 0 then
						local var_54_88 = GetWarMap(iter_54_102, iter_54_103, 2)

						if var_54_88 >= 0 and WAR.Person[arg_54_0].我方 == WAR.Person[var_54_88].我方 and var_54_88 ~= WAR.CurID then
							local var_54_89 = WAR.Person[var_54_88].人物编号

							WAR.Person[var_54_88].体力点数 = (WAR.Person[var_54_88].体力点数 or 0) + AddPersonAttrib(var_54_89, "体力", 10)

							AddPersonAttrib(var_54_89, "受伤程度", -10)
							SetWarMap(iter_54_102, iter_54_103, 4, 2)
						end
					end
				end
			end
		end

		if T4RM(var_54_0) and WAR.Person[arg_54_0].我方 then
			for iter_54_104 = 0, CC.WarWidth - 1 do
				for iter_54_105 = 0, CC.WarHeight - 1 do
					if GetWarMap(iter_54_104, iter_54_105, 4) > 0 then
						local var_54_90 = GetWarMap(iter_54_104, iter_54_105, 2)

						if var_54_90 >= 0 and WAR.Person[var_54_90].人物编号 == 9999 then
							WAR.WS = 1

							break
						end
					end
				end
			end
		end

		if var_54_0 == 9999 and WAR.Person[arg_54_0].我方 then
			for iter_54_106 = 0, CC.WarWidth - 1 do
				for iter_54_107 = 0, CC.WarHeight - 1 do
					if GetWarMap(iter_54_106, iter_54_107, 4) > 0 then
						local var_54_91 = GetWarMap(iter_54_106, iter_54_107, 2)

						if var_54_91 >= 0 and WAR.Person[var_54_91].人物编号 == 0 then
							WAR.WS = 1

							break
						end
					end
				end
			end
		end

		if WAR.Person[arg_54_0].特效文字1 ~= nil and WAR.Person[arg_54_0].特效动画 == -1 then
			WAR.Person[arg_54_0].特效动画 = 88
		end

		for iter_54_108 = 0, CC.WarWidth - 1 do
			for iter_54_109 = 0, CC.WarHeight - 1 do
				if GetWarMap(iter_54_108, iter_54_109, 4) > 0 then
					local var_54_92 = GetWarMap(iter_54_108, iter_54_109, 2)

					if var_54_92 >= 0 and var_54_92 ~= WAR.CurID and (WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_54_92].我方 or WAR.tmp[1000 + var_54_0] ~= nil or var_54_17 < 0 and WAR.WS == 0) then
						if JY.Wugong[var_54_1].伤害类型 == 1 and (var_54_3 == 0 or var_54_3 == 3) then
							if var_54_5 == 11 then
								var_54_5 = 10
							end

							SetWarMap(iter_54_108, iter_54_109, 4, 3)

							WAR.Effect = 3
						else
							WAR.Person[var_54_92].生命点数 = (WAR.Person[var_54_92].生命点数 or 0) - War_WugongHurtLife(var_54_92, var_54_1, var_54_5, var_54_41)
							WAR.Effect = 2

							SetWarMap(iter_54_108, iter_54_109, 4, 2)
						end
					end
				end
			end
		end

		local var_54_93 = JY.Wugong[var_54_1]["武功动画&音效"]

		if WAR.LXZQ == 1 then
			var_54_93 = 71
		elseif WAR.JSYX == 1 then
			var_54_93 = 84
		elseif WAR.ASKD == 1 then
			var_54_93 = 65
		elseif WAR.QMYC == 1 then
			var_54_93 = 21
		end

		local var_54_94 = JY.Wugong[var_54_1].武功类型

		if var_54_94 > 4 then
			var_54_94 = math.random(4)
		end

		War_ShowFight(var_54_0, var_54_1, var_54_94, var_54_5, arg_54_2, arg_54_3, var_54_93, var_54_17)
		War_Show_Count(WAR.CurID)

		WAR.Person[WAR.CurID].经验 = WAR.Person[WAR.CurID].经验 + 2

		local var_54_95 = 0
		local var_54_96

		var_54_96 = WAR.Person[arg_54_0].我方 and 4 or 40

		if JY.WGLVXS == 1 then
			local var_54_97 = 100
		end

		local var_54_98 = JY.Person[var_54_0].修炼物品
		local var_54_99 = 0

		if var_54_98 > 0 then
			var_54_99 = JY.Thing[var_54_98].练出武功
		end

		if instruct_16(var_54_0) and (WAR.Effect == 2 or WAR.Effect == 3) or ybdw(var_54_0) then
			if JY.Person[var_54_0]["武功等级" .. arg_54_1] < 900 then
				if JY.Person[var_54_0]["武功" .. arg_54_1] == var_54_99 then
					if JY.Wugong[var_54_99].武功等级 >= 10 then
						JY.Person[var_54_0].修炼点数 = JY.Person[var_54_0].修炼点数 + math.modf(TrainNeedExp(var_54_0) / 20) + 1
					elseif JY.Wugong[var_54_99].武功等级 >= 7 then
						JY.Person[var_54_0].修炼点数 = JY.Person[var_54_0].修炼点数 + math.modf(TrainNeedExp(var_54_0) / 15) + 1
					elseif JY.Wugong[var_54_99].武功等级 >= 5 then
						JY.Person[var_54_0].修炼点数 = JY.Person[var_54_0].修炼点数 + math.modf(TrainNeedExp(var_54_0) / 13) + 1
					else
						JY.Person[var_54_0].修炼点数 = JY.Person[var_54_0].修炼点数 + math.modf(TrainNeedExp(var_54_0) / 10) + 1
					end

					if JY.Person[var_54_0].修炼点数 > TrainNeedExp(var_54_0) - 1 then
						JY.Person[var_54_0].修炼点数 = TrainNeedExp(var_54_0) - 1
					end
				else
					JY.Person[var_54_0]["武功等级" .. arg_54_1] = JY.Person[var_54_0]["武功等级" .. arg_54_1] + 3 + Rnd(2)
				end
			elseif JY.Person[var_54_0]["武功等级" .. arg_54_1] < 999 then
				JY.Person[var_54_0]["武功等级" .. arg_54_1] = JY.Person[var_54_0]["武功等级" .. arg_54_1] + 5

				if JY.Person[var_54_0]["武功等级" .. arg_54_1] >= 999 then
					JY.Person[var_54_0]["武功等级" .. arg_54_1] = 999
					WAR.WS = 1

					PlayWavAtk(42)
					DrawStrBox(-1, -1, JY.Person[var_54_0].姓名 .. "修炼" .. JY.Wugong[JY.Person[var_54_0]["武功" .. arg_54_1]].名称 .. "到登峰造极", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(1000)
					Cls()
					ShowScreen()

					local var_54_100 = JY.Person[var_54_0]["武功" .. arg_54_1]

					if yongquan(var_54_1) then
						AddPersonAttrib(var_54_0, "拳掌功夫", 1)
					elseif yongjian(var_54_1) then
						AddPersonAttrib(var_54_0, "御剑能力", 1)
					elseif yongdao(var_54_1) then
						AddPersonAttrib(var_54_0, "耍刀技巧", 1)
					elseif yongte(var_54_1) then
						AddPersonAttrib(var_54_0, "特殊兵器", 1)
					elseif yongan(var_54_1) then
						AddPersonAttrib(var_54_0, "暗器技巧", 1)
					end

					local var_54_101 = JY.Wugong[var_54_100].武功等级

					AddPersonAttrib(var_54_0, "武学常识", var_54_101)

					if cxtd(var_54_0, 154) and yongdao(var_54_1) then
						JY.Person[var_54_0].攻击力 = JY.Person[var_54_0].攻击力 + 20
						JY.Person[var_54_0].防御力 = JY.Person[var_54_0].防御力 + 20
						JY.Person[var_54_0].轻功 = JY.Person[var_54_0].轻功 + 20
					end

					if JY.Base.主角职业 == 5 and JY.Person[var_54_0]["武功" .. arg_54_1] == 122 then
						say("咦？基础内功练到极处似乎另有奇妙！", 0, 1)
						say("似乎我走路睡觉时基础内功都能自动运行！那我岂不是时刻都有内力护体，不错，不错！", 0, 1)

						JY.Person[var_54_0].副功体 = 122
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 26 then
						AddPersonAttrib(var_54_0, "生命增长", 1)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 1)
						end
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 90 then
						AddPersonAttrib(var_54_0, "生命增长", 1)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 1)
						end
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 103 then
						AddPersonAttrib(var_54_0, "生命增长", 1)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 1)
						end
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 107 then
						AddPersonAttrib(var_54_0, "生命增长", 1)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 1)
						end
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 108 then
						AddPersonAttrib(var_54_0, "生命增长", 2)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 2)
						end
					end

					if JY.Person[var_54_0]["武功" .. arg_54_1] == 111 and JY.Person[var_54_0].性别 ~= 0 then
						AddPersonAttrib(var_54_0, "生命增长", 1)

						if var_54_0 == 0 then
							AddPersonAttrib(550, "生命增长", 1)
						end
					end

					if JY.Person[0].生命增长 > 18 then
						JY.Person[0].生命增长 = 18
					end

					if cxtd(var_54_0, 38) and JY.Person[var_54_0]["武功" .. arg_54_1] == 102 then
						say("１控制这蝌蚪一样的气流在体内游走越发随心所欲了！真有趣！", 38, 0)
						DrawStrBoxWaitKey("石破天轻功上升50点", C_ORANGE, CC.DefaultFont)
						ShowScreen()

						JY.Person[var_54_0].轻功 = JY.Person[var_54_0].轻功 + 50
					end

					if cxtd(var_54_0, 37) and JY.Person[var_54_0]["武功" .. arg_54_1] == 94 then
						say("神照经当真奇妙，四肢百骸感觉劲力充盈。丁大哥，我一定不会让你失望的~~~", 37, 0)
						DrawStrBoxWaitKey("狄云领悟神照经的真髓，轻功加三十", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						AddPersonAttrib(var_54_0, "轻功", 30)
						SetS(86, 8, 10, 5, 2)
					end

					if cxtd(var_54_0, 9) and JY.Person[var_54_0]["武功" .. arg_54_1] == 93 then
						say("圣火令果然奇妙", 9, 0)
						DrawStrBoxWaitKey("张无忌学会圣火神功，轻功加四十", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						AddPersonAttrib(var_54_0, "轻功", 40)
					end

					if cxtd(var_54_0, 1) and var_54_1 == 67 then
						say("刀法真是越练越精妙。", 1, 0)
						DrawStrBoxWaitKey("胡斐实力提升了", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						AddPersonAttrib(var_54_0, "耍刀技巧", 10)
						AddPersonAttrib(var_54_0, "攻击力", 10)
						AddPersonAttrib(var_54_0, "防御力", 10)
						AddPersonAttrib(var_54_0, "轻功", 10)
					end
				end
			end

			if var_54_5 < math.modf(JY.Person[var_54_0]["武功等级" .. arg_54_1] / 100) + 1 then
				var_54_5 = math.modf(JY.Person[var_54_0]["武功等级" .. arg_54_1] / 100) + 1

				DrawStrBox(-1, -1, string.format("%s 升为 %d 级", JY.Wugong[JY.Person[var_54_0]["武功" .. arg_54_1]].名称, var_54_5), C_ORANGE, CC.DefaultFont)
				ShowScreen()
				lib.Delay(500)
				Cls()
				ShowScreen()
			end
		end

		if WAR.Person[WAR.CurID].我方 then
			local var_54_102

			if JY.Person[var_54_0]["武功" .. arg_54_1] == 43 then
				var_54_102 = math.modf((var_54_5 + 3) / 2) * JY.Wugong[var_54_1].消耗内力点数

				if var_54_102 > 400 then
					var_54_102 = 400
				end

				if JY.Person[var_54_0].主功体 == 103 then
					var_54_102 = var_54_102 + math.modf(var_54_102 * 0.2)
				end

				if Curr_NG(var_54_0, 106) and JY.Person[var_54_0].内力性质 == 1 then
					var_54_102 = var_54_102 - math.modf(var_54_102 / 2)
				end

				if cxtd(var_54_0, 51) then
					var_54_102 = math.modf(var_54_102 / 2)
				end

				if cxtd(var_54_0, 113) or PersonKF(var_54_0, 98) then
					var_54_102 = math.modf(var_54_102 / 5)
				end
			else
				var_54_102 = math.modf((var_54_5 + 3) / 2) * JY.Wugong[var_54_1].消耗内力点数
			end

			for iter_54_110 = 1, CC.Kungfunum do
				if JY.Person[var_54_0]["武功" .. iter_54_110] == 99 then
					if JY.Person[var_54_0].主功体 == 99 then
						var_54_102 = var_54_102 - math.modf(var_54_102 * 0.6)
					else
						var_54_102 = var_54_102 - math.modf(var_54_102 * 0.3)

						break
					end
				end
			end

			for iter_54_111, iter_54_112 in pairs(CC.PersonWs) do
				if iter_54_112[1] ~= nil and cxtd(var_54_0, iter_54_112[1]) and JY.Person[var_54_0]["武功" .. arg_54_1] == iter_54_112[2] then
					for iter_54_113 = 1, 20 do
						var_54_102 = var_54_102 - math.modf(var_54_102 * (JY.Person[var_54_0]["武功等级" .. iter_54_113] / 100 * 0.05))

						break
					end
				end
			end

			if cxtd(var_54_0, 55) then
				for iter_54_114 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_54_114].人物编号 == 136 and WAR.Person[iter_54_114].死亡 == false and WAR.Person[iter_54_114].我方 == WAR.Person[WAR.CurID].我方 then
						var_54_102 = var_54_102 - math.modf(var_54_102 / 2)

						break
					end
				end
			end

			if cxtd(var_54_0, 188) then
				var_54_102 = var_54_102 - math.modf(var_54_102 / 4)
			end

			if PersonKF(var_54_0, 17) and var_54_1 == 49 then
				var_54_102 = var_54_102 - math.modf(var_54_102 / 2)
			end

			if PersonKF(var_54_0, 106) and PersonKF(var_54_0, 107) then
				var_54_102 = var_54_102 - math.modf(var_54_102 / 4)
			end

			if cxtd(var_54_0, 13) then
				var_54_102 = math.modf(var_54_102 / 2)
			end

			AddPersonAttrib(var_54_0, "内力", -var_54_102)
		elseif GetS(0, 0, 0, 0) ~= 1 then
			AddPersonAttrib(var_54_0, "内力", -math.modf((var_54_5 + 1) / 3) * JY.Wugong[var_54_1].消耗内力点数)
		else
			AddPersonAttrib(var_54_0, "内力", -math.modf((var_54_5 + 1) / 6) * JY.Wugong[var_54_1].消耗内力点数)
		end

		if JY.Person[var_54_0].内力 < 0 then
			JY.Person[var_54_0].内力 = 0
		end

		if JY.Person[var_54_0].生命 <= 0 then
			break
		end

		DrawTimeBar2()

		if cxtd(var_54_0, 592) then
			if WAR.L_DGQB_X >= 10 then
				WAR.L_DGQB_X = 1
			else
				WAR.L_DGQB_X = WAR.L_DGQB_X + 1
			end
		end

		if WAR.L_RYJF[var_54_0] ~= nil then
			WAR.L_RYJF[var_54_0] = 36
		end

		if WAR.L_WYJFA ~= 0 then
			if JLSD(20, 90, var_54_0) then
				WAR.L_WYJFA = var_54_1
			else
				WAR.L_WYJFA = 0
			end
		end

		WAR.ACT = WAR.ACT + 1

		local var_54_103 = 0
		local var_54_104 = 0

		for iter_54_115 = 0, CC.WarWidth - 1 do
			for iter_54_116 = 0, CC.WarHeight - 1 do
				if GetWarMap(iter_54_115, iter_54_116, 4) > 0 then
					local var_54_105 = GetWarMap(iter_54_115, iter_54_116, 2)

					if var_54_105 >= 0 and WAR.Person[arg_54_0].我方 ~= WAR.Person[var_54_105].我方 then
						var_54_104 = var_54_104 + 1

						if JY.Person[WAR.Person[var_54_105].人物编号].生命 > 0 then
							var_54_103 = 1
						end
					end
				end
			end
		end

		if var_54_103 == 0 and var_54_104 > 0 then
			break
		end

		if Curr_NG(var_54_0, 113) and WAR.TJZX[var_54_0] ~= nil and WAR.TJZX[var_54_0] >= 5 then
			var_54_25 = var_54_25 + 1
			WAR.TJZX[var_54_0] = WAR.TJZX[var_54_0] - 5
			WAR.TJZX_LJ = 1
		end
	end

	WAR.L_WYJFA = 0

	local var_54_106 = 0

	if WAR.WGWL >= 1100 then
		var_54_106 = 7 + math.random(2)
	elseif WAR.WGWL >= 900 then
		var_54_106 = 5 + math.random(2)
	elseif WAR.WGWL >= 600 then
		var_54_106 = 3 + math.random(2)
	else
		var_54_106 = 1 + math.random(2)
	end

	if not instruct_16(var_54_0) then
		var_54_106 = var_54_106 - 3
	end

	if cxtd(var_54_0, 5092) then
		var_54_106 = var_54_106 - 4
	end

	if cxtd(var_54_0, 10) then
		var_54_106 = math.modf(var_54_106 / 2)
	end

	if var_54_106 <= 0 then
		var_54_106 = 0
	end

	if cxtd(var_54_0, 89) then
		-- Nothing
	elseif WAR.Person[WAR.CurID].我方 then
		AddPersonAttrib(var_54_0, "体力", -var_54_106)

		if WAR.L_TXSG[var_54_0] ~= nil then
			AddPersonAttrib(var_54_0, "体力", -var_54_106)

			WAR.L_TXSG[var_54_0] = nil
		end
	else
		AddPersonAttrib(var_54_0, "体力", -math.modf(var_54_106 / 2))

		if WAR.L_TXSG[var_54_0] ~= nil then
			AddPersonAttrib(var_54_0, "体力", -var_54_106)

			WAR.L_TXSG[var_54_0] = nil
		end
	end

	local var_54_107 = {}
	local var_54_108 = 0

	for iter_54_117 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_54_117].反击武功 ~= -1 and WAR.Person[iter_54_117].反击武功 ~= 9999 then
			var_54_108 = var_54_108 + 1
			var_54_107[var_54_108] = {
				iter_54_117,
				WAR.Person[iter_54_117].反击武功,
				arg_54_2 - WAR.Person[WAR.CurID].坐标X,
				arg_54_3 - WAR.Person[WAR.CurID].坐标Y
			}
			WAR.Person[iter_54_117].反击武功 = 9999
		end
	end

	for iter_54_118 = 1, var_54_108 do
		local var_54_109 = WAR.CurID

		WAR.CurID = var_54_107[iter_54_118][1]
		WAR.DZXY = 1

		if WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] == 1 then
			WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] = 80
		elseif WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] == 2 then
			WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] = 100
		elseif WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] == 3 then
			WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] = 130
		end

		if (WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 51 and instruct_16(51) or WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 0 and JY.Base.畅想编号 == 51) and WAR.HMXC > 0 then
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100, var_54_107[iter_54_118][3], var_54_107[1][4])
		elseif WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 51 and instruct_16(51) and WAR.AutoFight == 0 then
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100)
		elseif WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 0 and JY.Base.畅想编号 == 51 and WAR.AutoFight == 0 then
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100)
		elseif WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 113 and instruct_16(113) and WAR.AutoFight == 0 then
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100)
		elseif WAR.Person[var_54_107[iter_54_118][1]].人物编号 == 0 and JY.Base.畅想编号 == 113 and WAR.AutoFight == 0 then
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100)
		else
			War_Fight_Sub(var_54_107[iter_54_118][1], var_54_107[iter_54_118][2] + 100, var_54_107[iter_54_118][3], var_54_107[1][4])
		end

		WAR.Person[WAR.CurID].反击武功 = -1
		WAR.DZXYLV[WAR.Person[WAR.CurID].人物编号] = nil
		WAR.CurID = var_54_109
		WAR.DZXY = 0
	end

	if WAR.YTFS == -1 then
		for iter_54_119 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_54_119].人物编号 == JY.Base.队伍1 and T2SQ(WAR.Person[iter_54_119].人物编号) then
				local var_54_110 = WAR.CurID

				WAR.CurID = iter_54_119
				WAR.SQFJ = 1
				WAR.YTFS = 0

				WarDrawMap(0)
				CurIDTXDH(iter_54_119, 81, 0)
				CurIDTXDH(iter_54_119, 79, 0)
				Cls()
				lib.LoadPNG(91, 14, 10, 10, 1)
				ShowScreen()
				lib.Delay(600)

				for iter_54_120 = 12, 24 do
					NewDrawString(-1, -1, "云体风身反攻", C_GOLD, 25 + iter_54_120)
					ShowScreen()

					if iter_54_120 == 24 then
						Cls()
						NewDrawString(-1, -1, "云体风身反攻", C_GOLD, 25 + iter_54_120)
						ShowScreen()
						lib.Delay(500)
					else
						lib.Delay(1)
					end
				end

				War_Fight_Sub(iter_54_119, 2, WAR.Person[iter_54_119].坐标X, WAR.Person[iter_54_119].坐标Y)

				WAR.SQFJ = 0

				for iter_54_121 = 1, arg_54_1 do
					if JY.Person[JY.Base.队伍1]["武功" .. iter_54_121] == JY.Person[JY.Base.队伍1].武功2 and iter_54_121 ~= 2 then
						JY.Person[JY.Base.队伍1].武功2 = WAR.YT1
						JY.Person[JY.Base.队伍1].武功等级2 = WAR.YT2
					end
				end

				WAR.CurID = var_54_110
			end
		end
	end

	return 1
end

function War_SelectMove()
	local var_57_0 = WAR.Person[WAR.CurID].坐标X
	local var_57_1 = WAR.Person[WAR.CurID].坐标Y
	local var_57_2 = var_57_0
	local var_57_3 = var_57_1

	while true do
		local var_57_4 = var_57_2
		local var_57_5 = var_57_3

		WarDrawMap(1, var_57_2, var_57_3)
		WarShowHead(GetWarMap(var_57_2, var_57_3, 2))
		ShowScreen()

		local var_57_6 = WaitKey(1)

		if var_57_6 == VK_UP then
			var_57_5 = var_57_3 - 1
		elseif var_57_6 == VK_DOWN then
			var_57_5 = var_57_3 + 1
		elseif var_57_6 == VK_LEFT then
			var_57_4 = var_57_2 - 1
		elseif var_57_6 == VK_RIGHT then
			var_57_4 = var_57_2 + 1
		elseif var_57_6 == VK_SPACE or var_57_6 == VK_RETURN then
			return var_57_2, var_57_3
		elseif var_57_6 == VK_ESCAPE then
			return nil
		elseif var_57_6 > 999999 then
			local var_57_7
			local var_57_8
			local var_57_9

			if var_57_6 > 1999999 then
				var_57_7 = 1
				var_57_6 = var_57_6 - 2000000
			else
				var_57_7 = 0
				var_57_6 = var_57_6 - 1000000
			end

			local var_57_10 = math.modf(var_57_6 / 1000)
			local var_57_11 = math.fmod(var_57_6, 1000)
			local var_57_12 = var_57_10 - CC.ScreenW / 2
			local var_57_13 = var_57_11 - CC.ScreenH / 2
			local var_57_14 = var_57_12 / CC.XScale
			local var_57_15 = var_57_13 / CC.YScale
			local var_57_16, var_57_17 = (var_57_14 + var_57_15) / 2, (var_57_15 - var_57_14) / 2

			if var_57_16 > 0 then
				var_57_16 = var_57_16 + 0.99
			else
				var_57_16 = var_57_16 - 0.01
			end

			if var_57_17 > 0 then
				var_57_17 = var_57_17 + 0.99
			else
				var_57_16 = var_57_16 - 0.01
			end

			local var_57_18 = math.modf(var_57_16)
			local var_57_19 = math.modf(var_57_17)

			for iter_57_0 = 0, 10 do
				if var_57_18 + iter_57_0 <= 63 and var_57_19 + iter_57_0 > 63 then
					break
				end

				local var_57_20 = GetS(JY.SubScene, var_57_0 + var_57_18 + iter_57_0, var_57_1 + var_57_19 + iter_57_0, 4)

				if math.abs(var_57_20 - CC.YScale * iter_57_0 * 2) < 5 then
					var_57_18 = var_57_18 + iter_57_0
					var_57_19 = var_57_19 + iter_57_0
				end
			end

			var_57_4, var_57_5 = var_57_18 + var_57_0, var_57_19 + var_57_1

			if var_57_7 == 1 then
				return var_57_2, var_57_3
			end
		end

		if GetWarMap(var_57_4, var_57_5, 3) < 128 then
			var_57_2 = var_57_4
			var_57_3 = var_57_5
		end
	end
end

function War_GetMinNeiLi(arg_58_0)
	local var_58_0 = math.huge

	for iter_58_0 = 1, CC.Kungfunum do
		local var_58_1 = JY.Person[arg_58_0]["武功" .. iter_58_0]

		if var_58_1 > 0 and var_58_0 > JY.Wugong[var_58_1].消耗内力点数 then
			var_58_0 = JY.Wugong[var_58_1].消耗内力点数
		end
	end

	return var_58_0
end

function War_Manual()
	local var_59_0
	local var_59_1 = WAR.Person[WAR.CurID].人物编号
	local var_59_2 = WAR.Person[WAR.CurID].坐标X
	local var_59_3 = WAR.Person[WAR.CurID].坐标Y
	local var_59_4 = WAR.Person[WAR.CurID].移动步数
	local var_59_5 = WAR.Person[WAR.CurID].贴图

	while true do
		WAR.ShowHead = 1
		var_59_0 = War_Manual_Sub()

		if CC.MoveDist == nil then
			CC.MoveDist = 0
		end

		if var_59_0 == 1 or var_59_0 == -1 then
			WAR.Person[WAR.CurID].移动步数 = WAR.Person[WAR.CurID].移动步数 - CC.MoveDist
		elseif var_59_0 == 0 then
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, -1)
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, -1)

			WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, WAR.Person[WAR.CurID].移动步数 = var_59_2, var_59_3, var_59_4

			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, WAR.CurID)
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, var_59_5)
		elseif var_59_0 == -13 then
			-- Nothing
		elseif var_59_0 == -11 and (cxtd(var_59_1, 1) or cxtd(var_59_1, 37) or cxtd(var_59_1, 38) or cxtd(var_59_1, 55) or cxtd(var_59_1, 91)) then
			-- Nothing
		else
			break
		end
	end

	WAR.ShowHead = 0

	WarDrawMap(0)

	return var_59_0
end

function War_Manual_Sub()
	local var_60_0 = WAR.Person[WAR.CurID].人物编号
	local var_60_1 = {
		{
			"移动",
			War_MoveMenu,
			1
		},
		{
			"攻击",
			War_FightMenu,
			1
		},
		{
			"防御",
			War_DefupMenu,
			1
		},
		{
			"蓄力",
			War_ActupMenu,
			1
		},
		{
			"等待",
			War_WaitMenu,
			1
		},
		{
			"休息",
			War_RestMenu,
			1
		},
		{
			"用毒",
			War_PoisonMenu,
			1
		},
		{
			"解毒",
			War_DecPoisonMenu,
			1
		},
		{
			"医疗",
			War_DoctorMenu,
			1
		},
		{
			"状态",
			War_StatusMenu,
			1
		},
		{
			"特技",
			War_TgrtsMenu,
			1
		},
		{
			"物品",
			War_ThingMenu,
			1
		},
		{
			"运功",
			War_YunGongMenu,
			1
		},
		{
			"撤退",
			War_Retreat,
			1
		},
		{
			"自动",
			War_AutoMenu,
			1
		}
	}

	if WAR.ZYHB == 2 then
		var_60_1[1][3] = 0
		var_60_1[5][3] = 0
		var_60_1[6][3] = 0
		var_60_1[8][3] = 0
		var_60_1[9][3] = 0
		var_60_1[11][3] = 0
		var_60_1[12][3] = 0
		var_60_1[13][3] = 0
	end

	if JY.Person[var_60_0].体力 <= 5 or WAR.Person[WAR.CurID].移动步数 <= 0 then
		var_60_1[1][3] = 0
	end

	if JY.Person[var_60_0].轻功 < 999 then
		var_60_1[14][3] = 0
	end

	if War_GetMinNeiLi(var_60_0) > JY.Person[var_60_0].内力 or JY.Person[var_60_0].体力 < 10 then
		var_60_1[2][3] = 0
	end

	if JY.Person[var_60_0].体力 < 10 or JY.Person[var_60_0].用毒能力 < 20 then
		var_60_1[7][3] = 0
	end

	if JY.Person[var_60_0].体力 < 10 or JY.Person[var_60_0].解毒能力 < 20 then
		var_60_1[8][3] = 0
	end

	if JY.Person[var_60_0].体力 < 50 or JY.Person[var_60_0].医疗能力 < 20 then
		var_60_1[9][3] = 0
	end

	if GRTS[var_60_0] ~= nil then
		var_60_1[11][1] = GRTS[var_60_0]
	else
		var_60_1[11][3] = 0
	end

	if var_60_0 == 0 then
		if JY.Base.畅想编号 > 0 and GRTS[JY.Base.畅想编号] ~= nil and JY.Person[0].驱虫术 == 0 then
			var_60_1[11][1] = GRTS[JY.Base.畅想编号]
		elseif JY.Person[0].驱虫术 >= 20 and WAR.QUSHE == 0 then
			var_60_1[11][3] = 1
		else
			var_60_1[11][3] = 0
		end
	end

	if WAR.tmp[1000 + var_60_0] == 1 then
		for iter_60_0 = 3, 13 do
			var_60_1[iter_60_0][3] = 0
		end

		var_60_1[10][3] = 1
	end

	if WAR.ZDDH == 238 then
		var_60_1[6][3] = 0
	end

	if WAR.GTMENU == 0 then
		WAR.GTMENU = 1
	end

	lib.GetKey()
	Cls()
	DrawTimeBar_sub()

	return ShowMenu(var_60_1, #var_60_1, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
end

function War_YunGongMenu()
	local var_61_0 = WAR.Person[WAR.CurID].人物编号
	local var_61_1 = {
		{
			"运行内功",
			SelectNeiGongMenu,
			1
		},
		{
			"停运内功",
			nil,
			1
		},
		{
			"运行轻功",
			SelectQingGongMenu,
			1
		},
		{
			"停运轻功",
			nil,
			1
		}
	}
	local var_61_2 = ShowMenu(var_61_1, #var_61_1, 0, CC.MainSubMenuX + 15, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_61_2 == 2 then
		DrawStrBoxWaitKey(JY.Person[var_61_0].姓名 .. "停止了运行主内功", C_RED, CC.DefaultFont, nil, LimeGreen)

		local var_61_3 = 0

		for iter_61_0 = 1, CC.Kungfunum do
			if JY.Person[var_61_0]["武功" .. iter_61_0] == JY.Person[var_61_0].主功体 then
				var_61_3 = JY.Person[var_61_0]["武功等级" .. iter_61_0] == 999 and 10 or JY.Person[var_61_0]["武功等级" .. iter_61_0] / 100
			end
		end

		JY.Person[var_61_0].攻击力 = JY.Person[var_61_0].攻击力 - JY.Wugong[JY.Person[var_61_0].主功体].增幅攻击等级 * var_61_3
		JY.Person[var_61_0].防御力 = JY.Person[var_61_0].防御力 - JY.Wugong[JY.Person[var_61_0].主功体].增幅防御等级 * var_61_3
		JY.Person[var_61_0].轻功 = JY.Person[var_61_0].轻功 - JY.Wugong[JY.Person[var_61_0].主功体].增幅轻功等级 * var_61_3
		JY.Person[var_61_0].主功体 = 0

		return 20
	elseif var_61_2 == 20 then
		return 20
	elseif var_61_2 == 4 then
		DrawStrBoxWaitKey(JY.Person[var_61_0].姓名 .. "停止了运行主轻功", M_DeepSkyBlue, CC.DefaultFont, nil, LimeGreen)

		local var_61_4 = 0

		for iter_61_1 = 1, CC.Kungfunum do
			if JY.Person[var_61_0]["武功" .. iter_61_1] == JY.Person[var_61_0].主运轻功 then
				local var_61_5

				var_61_5 = JY.Person[var_61_0]["武功等级" .. iter_61_1] == 999 and 10 or JY.Person[var_61_0]["武功等级" .. iter_61_1] / 100
			end
		end

		JY.Person[var_61_0].主运轻功 = 0

		return 20
	elseif var_61_2 == 10 then
		return 10
	end
end

function SelectNeiGongMenu()
	local var_62_0 = WAR.Person[WAR.CurID].人物编号
	local var_62_1 = WAR.Person[WAR.CurID].坐标X
	local var_62_2 = WAR.Person[WAR.CurID].坐标Y
	local var_62_3 = {}

	for iter_62_0 = 1, CC.Kungfunum do
		var_62_3[iter_62_0] = {
			JY.Wugong[JY.Person[var_62_0]["武功" .. iter_62_0]].名称,
			nil,
			0
		}

		if JY.Wugong[JY.Person[var_62_0]["武功" .. iter_62_0]].武功类型 == 5 then
			var_62_3[iter_62_0][3] = 1
		end

		if var_62_0 == 0 and JY.Base.主角职业 == 5 and (JY.Person[var_62_0]["武功" .. iter_62_0] == 106 or JY.Person[var_62_0]["武功" .. iter_62_0] == 107 or JY.Person[var_62_0]["武功" .. iter_62_0] == 108) then
			var_62_3[iter_62_0][3] = 0
		end
	end

	local var_62_4 = ShowMenu(var_62_3, #var_62_3, 0, CC.MainSubMenuX + 21 + 4 * (CC.Fontsmall + CC.RowPixel), CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_62_4 ~= nil and var_62_4 > 0 then
		if JY.Person[var_62_0].主功体 > 0 then
			say("你已经运行内功了", 0, 2)

			return
		else
			CleanWarMap(4, 0)
			SetWarMap(var_62_1, var_62_2, 4, 1)
			War_ShowFight(var_62_0, 0, 0, 0, 0, 0, 9)
			AddPersonAttrib(var_62_0, "内力", -200)
			AddPersonAttrib(var_62_0, "体力", -5)

			JY.Person[var_62_0].主功体 = JY.Person[var_62_0]["武功" .. var_62_4]

			local var_62_5 = 0

			for iter_62_1 = 1, CC.Kungfunum do
				if JY.Person[var_62_0]["武功" .. iter_62_1] == JY.Person[var_62_0].主功体 then
					var_62_5 = JY.Person[var_62_0]["武功等级" .. iter_62_1] == 999 and 10 or JY.Person[var_62_0]["武功等级" .. iter_62_1] / 100
				end
			end

			JY.Person[var_62_0].攻击力 = JY.Person[var_62_0].攻击力 + JY.Wugong[JY.Person[var_62_0].主功体].增幅攻击等级 * var_62_5
			JY.Person[var_62_0].防御力 = JY.Person[var_62_0].防御力 + JY.Wugong[JY.Person[var_62_0].主功体].增幅防御等级 * var_62_5
			JY.Person[var_62_0].轻功 = JY.Person[var_62_0].轻功 + JY.Wugong[JY.Person[var_62_0].主功体].增幅轻功等级 * var_62_5

			return 20
		end
	end
end

function SelectQingGongMenu()
	local var_63_0 = WAR.Person[WAR.CurID].人物编号
	local var_63_1 = WAR.Person[WAR.CurID].坐标X
	local var_63_2 = WAR.Person[WAR.CurID].坐标Y
	local var_63_3 = {}

	for iter_63_0 = 1, CC.Kungfunum do
		var_63_3[iter_63_0] = {
			JY.Wugong[JY.Person[var_63_0]["武功" .. iter_63_0]].名称,
			nil,
			0
		}

		if JY.Wugong[JY.Person[var_63_0]["武功" .. iter_63_0]].武功类型 == 10 then
			var_63_3[iter_63_0][3] = 1
		end
	end

	local var_63_4 = ShowMenu(var_63_3, #var_63_3, 0, CC.MainSubMenuX + 21 + 4 * (CC.Fontsmall + CC.RowPixel), CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_63_4 ~= nil and var_63_4 > 0 then
		if JY.Person[var_63_0].主运轻功 > 0 then
			say("你已经运行轻功了", 0, 2)

			return
		else
			CleanWarMap(4, 0)
			SetWarMap(var_63_1, var_63_2, 4, 1)
			War_ShowFight(var_63_0, 0, 0, 0, 0, 0, 104)
			AddPersonAttrib(var_63_0, "体力", -10)

			WAR.YQG = 1
			JY.Person[var_63_0].主运轻功 = JY.Person[var_63_0]["武功" .. var_63_4]

			local var_63_5 = 0

			for iter_63_1 = 1, CC.Kungfunum do
				if JY.Person[var_63_0]["武功" .. iter_63_1] == JY.Person[var_63_0].主运轻功 then
					local var_63_6

					var_63_6 = JY.Person[var_63_0]["武功等级" .. iter_63_1] == 999 and 10 or JY.Person[var_63_0]["武功等级" .. iter_63_1] / 100
				end
			end

			return 10
		end
	end
end

function War_Retreat()
	for iter_64_0 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_64_0].我方 == true then
			WAR.Person[iter_64_0].死亡 = true
		end
	end

	return 1
end

function War_TgrtsMenu()
	local var_65_0 = WAR.Person[WAR.CurID].人物编号
	local var_65_1 = {
		{
			"特技",
			War_TgrtsMenu_01,
			1
		},
		{
			"驱虫",
			War_quchong,
			1
		}
	}

	if var_65_0 == 0 then
		if JY.Base.畅想编号 > 0 and GRTS[JY.Base.畅想编号] ~= nil then
			var_65_1[1][1] = GRTS[var_65_0]
		else
			var_65_1[1][3] = 0
		end
	else
		if GRTS[var_65_0] ~= nil then
			var_65_1[1][1] = GRTS[var_65_0]
		else
			var_65_1[1][3] = 0
		end

		var_65_1[2][3] = 0
	end

	if cxtd(var_65_0, 37) and (JY.Person[var_65_0].内力 <= 2000 or WAR.DYWY == 1) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 51) and (JY.Person[var_65_0].内力 <= 500 or JY.Person[var_65_0].体力 <= 5 or WAR.HMXC > 0) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 54) and WAR.YCZHL[var_65_0] ~= nil and WAR.YCZHL[var_65_0] > 0 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 81) then
		local var_65_2 = 0

		for iter_65_0 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_65_0].死亡 == false and WAR.Person[iter_65_0].我方 == false then
				var_65_2 = var_65_2 + 1
			end
		end

		if var_65_2 < 2 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 <= 30 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 35) and (JY.Person[var_65_0].体力 <= 20 or JY.Person[var_65_0].内力 <= 500 or WAR.JIUPO > 0) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 38) and (JY.Person[var_65_0].体力 <= 15 or WAR.SAXING ~= -1) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 1) and (JY.Person[var_65_0].体力 <= 10 or WAR.HUFEI == 1) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 4) and JY.Person[var_65_0].体力 <= 10 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 55) and WAR.LINGGANG == 1 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 56) and JY.Person[var_65_0].体力 <= 20 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 58) and WAR.SHENDIAO == 1 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 59) and (JY.Person[var_65_0].体力 <= 15 or WAR.YUFENG == 0) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 2) or cxtd(var_65_0, 25) or cxtd(var_65_0, 47) then
		local var_65_3 = 0

		for iter_65_1 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_65_1].我方 == false and WAR.Person[iter_65_1].死亡 == false and RealJL(WAR.CurID, iter_65_1, 8) then
				var_65_3 = 1

				break
			end
		end

		if var_65_3 == 0 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 <= 10 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 63) and (JY.Person[var_65_0].体力 <= 20 or JY.Person[var_65_0].内力 <= 500) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 92) then
		local var_65_4 = 0

		for iter_65_2 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_65_2].人物编号 ~= 92 and WAR.Person[iter_65_2].死亡 == false and WAR.Person[iter_65_2].我方 then
				var_65_4 = 1

				break
			end
		end

		if JY.Person[var_65_0].内力 <= 1000 or var_65_4 == 0 or WAR.LQZ[var_65_0] == nil or WAR.LQZ[var_65_0] < 100 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 91) and (JY.Person[var_65_0].体力 <= 20 or WAR.QQDB == 1) then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 49) then
		local var_65_5 = 0

		for iter_65_3 = 0, WAR.PersonNum - 1 do
			local var_65_6 = WAR.Person[iter_65_3].人物编号

			if WAR.TZ_XZ_SSH[var_65_6] == 1 and WAR.Person[iter_65_3].死亡 == false then
				var_65_5 = 1
			end
		end

		if var_65_5 == 0 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 < 20 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 88) then
		local var_65_7 = 0

		for iter_65_4 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_65_4].我方 == true and WAR.Person[iter_65_4].死亡 == false and RealJL(WAR.CurID, iter_65_4, 5) and iter_65_4 ~= WAR.CurID then
				var_65_7 = 1
			end
		end

		if var_65_7 == 0 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 < 10 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 89) then
		local var_65_8 = WAR.Person[WAR.CurID].坐标X
		local var_65_9 = WAR.Person[WAR.CurID].坐标Y
		local var_65_10 = {
			{
				WAR.Person[WAR.CurID].坐标X,
				WAR.Person[WAR.CurID].坐标Y + 1
			},
			{
				WAR.Person[WAR.CurID].坐标X,
				WAR.Person[WAR.CurID].坐标Y - 1
			},
			{
				WAR.Person[WAR.CurID].坐标X + 1,
				WAR.Person[WAR.CurID].坐标Y
			},
			{
				WAR.Person[WAR.CurID].坐标X - 1,
				WAR.Person[WAR.CurID].坐标Y
			}
		}
		local var_65_11 = 0

		for iter_65_5 = 1, 4 do
			if GetWarMap(var_65_10[iter_65_5][1], var_65_10[iter_65_5][2], 2) >= 0 then
				local var_65_12 = GetWarMap(var_65_10[iter_65_5][1], var_65_10[iter_65_5][2], 2)

				if instruct_16(WAR.Person[var_65_12].人物编号) then
					var_65_11 = 1
				end
			end
		end

		if var_65_11 == 0 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 < 25 then
			var_65_1[1][3] = 0
		end
	end

	if cxtd(var_65_0, 9) then
		local var_65_13 = 0

		for iter_65_6 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_65_6].我方 == true and WAR.Person[iter_65_6].死亡 == false and RealJL(WAR.CurID, iter_65_6, 8) and iter_65_6 ~= WAR.CurID then
				var_65_13 = 1
			end
		end

		if var_65_13 == 0 then
			var_65_1[1][3] = 0
		end

		if JY.Person[var_65_0].体力 < 10 then
			var_65_1[1][3] = 0
		end
	end

	if var_65_0 == 9 and JY.Person[var_65_0].体力 < 20 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 74) and JY.Person[var_65_0].体力 <= 10 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 28) and JY.Person[var_65_0].体力 < 50 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 590) and WAR.L_LWX == 1 then
		var_65_1[1][3] = 0
	end

	if cxtd(var_65_0, 29) and (GetS(86, 10, 12, 5) ~= 1 and GetS(86, 10, 12, 5) ~= 2 or JY.Person[var_65_0].内力 < 500 or JY.Person[var_65_0].体力 < 50) then
		var_65_1[1][3] = 0
	end

	if var_65_0 == 0 then
		if WAR.QUSHE == 0 and JY.Person[0].驱虫术 >= 20 then
			var_65_1[2][3] = 1
		else
			var_65_1[2][3] = 0
		end
	end

	local var_65_14 = ShowMenu(var_65_1, #var_65_1, 0, CC.MainSubMenuX + 15, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_65_14 == 1 then
		return 1
	elseif var_65_14 == 2 then
		return 1
	end
end

function War_quchong()
	local var_66_0 = WAR.Person[WAR.CurID].人物编号

	Cls()

	WAR.ShowHead = 0

	WarDrawMap(0)

	if WAR.Person[WAR.CurID].人物编号 == 0 then
		if JY.Base.畅想编号 == 0 then
			if JY.Base.主角职业 < 10 then
				if JY.Person[0].性别 == 0 then
					local var_66_1 = 280 + JY.Base.主角职业
				else
					local var_66_2 = 501 + JY.Base.主角职业
				end
			else
				local var_66_3 = 289 + JY.Base.特殊主角
			end
		else
			local var_66_4 = JY.Person[JY.Base.畅想编号].头像代号
		end
	end

	if JYMsgBox("特色指令：" .. GRTS[999], GRTSSAY[999], {
		"确定",
		"取消"
	}, 2, var_66_0) == 2 then
		return 0
	end

	if JY.Base.宠物1 < 0 and JY.Base.宠物2 < 0 and JY.Base.宠物3 < 0 and JY.Base.宠物4 < 0 then
		say("可惜你还没有蛇儿可以驱使~~~", 0, 2)

		return
	end

	if WAR.QUSHE == 0 then
		local var_66_5, var_66_6 = WE_xy(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y)
		local var_66_7 = JY.Base.宠物1

		if var_66_7 > 0 then
			NewWARPersonZJ(var_66_7, true, var_66_5 - 2, var_66_6 - 2, false, 2)

			WAR.ZYZ[var_66_7] = 100

			local var_66_8
			local var_66_9 = WAR.CurID

			WAR.CurID = WAR.PersonNum - 1

			say("嘶~~~嘶~~~嘶~~~", 0, 2)

			WAR.CurID = var_66_9
		end

		local var_66_10 = JY.Base.宠物2

		if var_66_10 > 0 then
			NewWARPersonZJ(var_66_10, true, var_66_5 - 2, var_66_6 + 2, false, 2)

			WAR.ZYZ[var_66_10] = 100

			local var_66_11
			local var_66_12 = WAR.CurID

			WAR.CurID = WAR.PersonNum - 1

			say("嘶~~~嘶~~~嘶~~~", 0, 2)

			WAR.CurID = var_66_12
		end

		local var_66_13 = JY.Base.宠物3

		if var_66_13 > 0 then
			NewWARPersonZJ(var_66_13, true, var_66_5 + 2, var_66_6 - 2, false, 2)

			WAR.ZYZ[var_66_13] = 100

			local var_66_14
			local var_66_15 = WAR.CurID

			WAR.CurID = WAR.PersonNum - 1

			say("嘶~~~嘶~~~嘶~~~", 0, 2)

			WAR.CurID = var_66_15
		end

		local var_66_16 = JY.Base.宠物4

		if var_66_16 > 0 then
			NewWARPersonZJ(var_66_16, true, var_66_5 + 2, var_66_6 + 2, false, 2)

			WAR.ZYZ[var_66_16] = 100

			local var_66_17
			local var_66_18 = WAR.CurID

			WAR.CurID = WAR.PersonNum - 1

			say("嘶~~~嘶~~~嘶~~~", 0, 2)

			WAR.CurID = var_66_18
		end

		if var_66_7 == 0 and var_66_10 == 0 and var_66_13 == 0 and var_66_16 == 0 then
			DrawString(-1, -1, string.format("你还没有宠物"), color, size)
		end

		WAR.QUSHE = 1

		return 1
	end
end

function War_TgrtsMenu_01()
	local var_67_0 = WAR.Person[WAR.CurID].人物编号

	Cls()

	WAR.ShowHead = 0

	WarDrawMap(0)

	local var_67_1 = WAR.Person[WAR.CurID].人物编号

	if var_67_1 == 0 then
		if JY.Base.畅想编号 == 0 then
			if JY.Base.主角职业 < 10 then
				if JY.Person[0].性别 == 0 then
					var_67_1 = 280 + JY.Base.主角职业
				else
					var_67_1 = 501 + JY.Base.主角职业
				end
			else
				var_67_1 = 289 + JY.Base.特殊主角
			end
		else
			var_67_1 = JY.Person[JY.Base.畅想编号].头像代号
		end
	end

	if JYMsgBox("特色指令：" .. GRTS[var_67_0], GRTSSAY[var_67_0], {
		"确定",
		"取消"
	}, 2, var_67_1) == 2 then
		return 0
	end

	local function var_67_2()
		local var_68_0 = WAR.Person[WAR.CurID].坐标X
		local var_68_1 = WAR.Person[WAR.CurID].坐标Y
		local var_68_2 = var_68_0
		local var_68_3 = var_68_1

		while true do
			local var_68_4 = var_68_2
			local var_68_5 = var_68_3

			WarDrawMap(1, var_68_2, var_68_3)
			WarShowHead(GetWarMap(var_68_2, var_68_3, 2))
			ShowScreen()

			local var_68_6 = WaitKey(1)

			if var_68_6 == VK_UP then
				var_68_5 = var_68_3 - 1
			elseif var_68_6 == VK_DOWN then
				var_68_5 = var_68_3 + 1
			elseif var_68_6 == VK_LEFT then
				var_68_4 = var_68_2 - 1
			elseif var_68_6 == VK_RIGHT then
				var_68_4 = var_68_2 + 1
			elseif var_68_6 == VK_SPACE or var_68_6 == VK_RETURN then
				return var_68_2, var_68_3
			elseif var_68_6 == VK_ESCAPE then
				return nil, nil
			elseif var_68_6 > 999999 then
				local var_68_7
				local var_68_8
				local var_68_9

				if var_68_6 > 1999999 then
					var_68_7 = 1
					var_68_6 = var_68_6 - 2000000
				else
					var_68_7 = 0
					var_68_6 = var_68_6 - 1000000
				end

				local var_68_10 = math.modf(var_68_6 / 1000)
				local var_68_11 = math.fmod(var_68_6, 1000)
				local var_68_12 = var_68_10 - CC.ScreenW / 2
				local var_68_13 = var_68_11 - CC.ScreenH / 2
				local var_68_14 = var_68_12 / CC.XScale
				local var_68_15 = var_68_13 / CC.YScale
				local var_68_16, var_68_17 = (var_68_14 + var_68_15) / 2, (var_68_15 - var_68_14) / 2

				if var_68_16 > 0 then
					var_68_16 = var_68_16 + 0.99
				else
					var_68_16 = var_68_16 - 0.01
				end

				if var_68_17 > 0 then
					var_68_17 = var_68_17 + 0.99
				else
					var_68_16 = var_68_16 - 0.01
				end

				local var_68_18 = math.modf(var_68_16)
				local var_68_19 = math.modf(var_68_17)

				for iter_68_0 = 0, 10 do
					if var_68_18 + iter_68_0 <= 63 and var_68_19 + iter_68_0 > 63 then
						break
					end

					local var_68_20 = GetS(JY.SubScene, var_68_0 + var_68_18 + iter_68_0, var_68_1 + var_68_19 + iter_68_0, 4)

					if CONFIG.Zoom == 1 then
						var_68_20 = var_68_20 * 2
					end

					if math.abs(var_68_20 - CC.YScale * iter_68_0 * 2) < 5 then
						var_68_18 = var_68_18 + iter_68_0
						var_68_19 = var_68_19 + iter_68_0
					end
				end

				var_68_4, var_68_5 = var_68_18 + var_68_0, var_68_19 + var_68_1

				if var_68_7 == 1 then
					return var_68_2, var_68_3
				end
			end

			if GetWarMap(var_68_4, var_68_5, 3) < 128 then
				var_68_2 = var_68_4
				var_68_3 = var_68_5
			end
		end
	end

	if cxtd(var_67_0, 92) then
		if JY.Person[var_67_0].内力 > 700 and WAR.LQZ[var_67_0] ~= nil and WAR.LQZ[var_67_0] >= 100 then
			Cls()
			CurIDTXDH(WAR.CurID, 80, 0, "但为君故·沉吟至今")
			lib.Delay(10)

			for iter_67_0 = 0, WAR.PersonNum - 1 do
				local var_67_3 = WAR.Person[iter_67_0].人物编号

				if WAR.Person[iter_67_0].死亡 == false and WAR.Person[iter_67_0].我方 and var_67_3 ~= 92 then
					WAR.LQZ[var_67_3] = 100
				end
			end

			WAR.LQZ[var_67_0] = 0

			AddPersonAttrib(var_67_0, "内力", -700)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 91) then
		if JY.Person[var_67_0].体力 > 20 then
			Cls()
			CurIDTXDH(WAR.CurID, 103, 0, "大暴青青·逆我者亡")
			lib.Delay(80)
			AddPersonAttrib(var_67_0, "体力", -15)

			WAR.QQDB = 1
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 37) then
		if JY.Person[var_67_0].内力 >= 2000 then
			Cls()
			CurIDTXDH(WAR.CurID, 104, 0, "极意·神照无影")
			lib.Delay(10)

			WAR.DYWY = 1
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 54) then
		Cls()
		CurIDTXDH(WAR.CurID, 63, 0, "虎乱无双")
		lib.Delay(10)

		WAR.YCZHL[var_67_0] = 100
	end

	if cxtd(var_67_0, 1) then
		if JY.Person[var_67_0].体力 > 10 then
			Cls()
			CurIDTXDH(WAR.CurID, 104, 0, "踏雪无痕·神行飞天")
			lib.Delay(10)
			AddPersonAttrib(var_67_0, "体力", -5)

			WAR.HUFEI = 1
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 4) then
		if JY.Person[var_67_0].体力 >= 10 then
			War_CalMoveStep(WAR.CurID, 8, 1)

			local var_67_4
			local var_67_5
			local var_67_6 = -1
			local var_67_7 = -1

			while true do
				local var_67_8, var_67_9 = var_67_2()

				if var_67_8 == nil then
					return 0
				end

				if var_67_8 ~= nil then
					if lib.GetWarMap(var_67_8, var_67_9, 2) < 0 and lib.GetWarMap(var_67_8, var_67_9, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_8, var_67_9, 2) == nil or GetWarMap(var_67_8, var_67_9, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_10 = GetWarMap(var_67_8, var_67_9, 2)

						var_67_7 = WAR.Person[var_67_10].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_10].我方 then
							QZXS("不能选择我方人物")
						elseif WAR.YJTQ[var_67_7] == 1 or var_67_7 == 592 or WAR.ZDDH == 224 or WAR.ZDDH == 17 or WAR.ZDDH == 67 or WAR.ZDDH == 226 or WAR.ZDDH == 220 or WAR.ZDDH == 219 or WAR.ZDDH == 79 or WAR.ZDDH == 82 or WAR.ZDDH == 212 or WAR.ZDDH == 213 or WAR.ZDDH == 214 or WAR.ZDDH == 215 or WAR.ZDDH == 216 or WAR.ZDDH == 217 then
							QZXS("此人已经身无分文！")
						else
							break
						end
					end
				end
			end

			WAR.YJTQ[var_67_7] = 1
			WAR.YJ = WAR.YJ + math.random(15) + 15

			QZXS("偷窃到" .. WAR.YJ .. "两银子")
			instruct_32(174, WAR.YJ)

			WAR.YJ = 0

			AddPersonAttrib(var_67_0, "体力", -10)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 55) then
		if WAR.LINGGANG == 0 then
			WAR.LINGGANG = 1

			local var_67_11 = JYMsgBox("灵罡指令", "要转换成哪种内力？", {
				"阴性",
				"阳性",
				"调和"
			}, 3, 55)

			if var_67_11 == 1 then
				JY.Person[var_67_0].内力性质 = 0

				Cls()
				CurIDTXDH(WAR.CurID, 90, 0, JY.Person[var_67_0].姓名 .. "转换为阴性内力")
			elseif var_67_11 == 2 then
				JY.Person[var_67_0].内力性质 = 1

				Cls()
				CurIDTXDH(WAR.CurID, 90, 0, JY.Person[var_67_0].姓名 .. "转换为阳性内力")
			else
				JY.Person[var_67_0].内力性质 = 2

				Cls()
				CurIDTXDH(WAR.CurID, 90, 0, JY.Person[var_67_0].姓名 .. "转换为调和内力")
			end
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 56) then
		if JY.Person[var_67_0].体力 >= 20 then
			War_CalMoveStep(WAR.CurID, 8, 1)

			local var_67_12
			local var_67_13
			local var_67_14 = -1
			local var_67_15 = -1

			while true do
				local var_67_16, var_67_17 = var_67_2()

				if var_67_16 == nil then
					return 0
				end

				if var_67_16 ~= nil then
					if lib.GetWarMap(var_67_16, var_67_17, 2) < 0 and lib.GetWarMap(var_67_16, var_67_17, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_16, var_67_17, 2) == nil or GetWarMap(var_67_16, var_67_17, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_18 = GetWarMap(var_67_16, var_67_17, 2)

						var_67_15 = WAR.Person[var_67_18].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_18].我方 then
							QZXS("不能选择我方人物")
						elseif WAR.QIZHEN[var_67_15] == 1 then
							QZXS("此人已经在阵内！")
						else
							break
						end
					end
				end
			end

			WAR.QIZHEN[var_67_15] = 1
			WAR.L_NOT_MOVE[var_67_15] = 1

			QZXS(JY.Person[var_67_15].姓名 .. "被奇门八阵所困！")
			AddPersonAttrib(var_67_0, "体力", -15)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 76) then
		if JY.Person[var_67_0].体力 >= 20 then
			War_CalMoveStep(WAR.CurID, 6, 1)

			local var_67_19
			local var_67_20
			local var_67_21 = -1
			local var_67_22 = -1

			while true do
				local var_67_23, var_67_24 = var_67_2()

				if var_67_23 == nil then
					return 0
				end

				if var_67_23 ~= nil then
					if lib.GetWarMap(var_67_23, var_67_24, 2) < 0 and lib.GetWarMap(var_67_23, var_67_24, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_23, var_67_24, 2) == nil or GetWarMap(var_67_23, var_67_24, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_25 = GetWarMap(var_67_23, var_67_24, 2)

						var_67_22 = WAR.Person[var_67_25].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_25].我方 then
							QZXS("不能选择我方人物")
						else
							break
						end
					end
				end
			end

			WAR.WYY = var_67_22

			QZXS(JY.Person[var_67_22].姓名 .. "被王语嫣点破")
			AddPersonAttrib(var_67_0, "体力", -5)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 81) then
		if JY.Person[var_67_0].体力 >= 20 then
			War_CalMoveStep(WAR.CurID, 6, 1)

			local var_67_26
			local var_67_27
			local var_67_28 = -1
			local var_67_29 = -1

			while true do
				local var_67_30, var_67_31 = var_67_2()

				if var_67_30 == nil then
					return 0
				end

				if var_67_30 ~= nil then
					if lib.GetWarMap(var_67_30, var_67_31, 2) < 0 and lib.GetWarMap(var_67_30, var_67_31, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_30, var_67_31, 2) == nil or GetWarMap(var_67_30, var_67_31, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						var_67_28 = GetWarMap(var_67_30, var_67_31, 2)
						var_67_29 = WAR.Person[var_67_28].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_28].我方 then
							QZXS("不能选择我方人物")
						else
							break
						end
					end
				end
			end

			if JLSD(10, 20, var_67_0) or WAR.MEIHUO > 0 then
				WAR.Person[var_67_28].我方 = WAR.Person[WAR.CurID].我方
				WAR.NPC[var_67_29] = 100

				if not xiaobin(var_67_29) then
					WAR.NPC[var_67_29] = 50
				end

				QZXS(JY.Person[var_67_29].姓名 .. "被魅惑！")

				WAR.MEIHUO = 0
			else
				QZXS(JY.Person[var_67_29].姓名 .. "魅惑失败！")
			end

			AddPersonAttrib(var_67_0, "体力", -20)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 35) then
		if JY.Person[var_67_0].体力 > 15 then
			Cls()
			CurIDTXDH(WAR.CurID, 63, 0, "九剑秘传·破尽天下")
			lib.Delay(10)
			AddPersonAttrib(var_67_0, "体力", -15)
			AddPersonAttrib(var_67_0, "内力", -500)

			WAR.JIUPO = 1
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 38) then
		if JY.Person[var_67_0].体力 > 15 then
			Cls()
			CurIDTXDH(WAR.CurID, 104, 0, "银鞍照白马·飒沓如流星")
			lib.Delay(10)
			AddPersonAttrib(var_67_0, "体力", -10)

			WAR.SAXING = 0
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 51) then
		if JY.Person[var_67_0].体力 > 5 and JY.Person[var_67_0].内力 > 500 then
			Cls()
			CurIDTXDH(WAR.CurID, 63, 0, "斗转星移·幻梦星辰")
			lib.Delay(10)
			AddPersonAttrib(var_67_0, "体力", -5)
			AddPersonAttrib(var_67_0, "内力", -500)

			WAR.HMXC = 3
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 58) then
		if JY.Person[var_67_0].体力 >= 15 and WAR.SHENDIAO == 0 then
			AddPersonAttrib(var_67_0, "体力", -10)

			WAR.SHENDIAO = 1

			local var_67_32, var_67_33 = WE_xy(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y - 1)

			instruct_35(93, 1, 103, 999)
			NewWARPersonZJ(93, true, var_67_32, var_67_33, false, 2)

			WAR.NPC[93] = 1000

			local var_67_34
			local var_67_35 = WAR.CurID

			WAR.CurID = WAR.PersonNum - 1

			Cls()
			CurIDTXDH(WAR.CurID, 90, 0, "召唤雕兄助战")

			WAR.CurID = var_67_35
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 59) then
		if JY.Person[var_67_0].体力 >= 15 and WAR.YUFENG > 0 then
			AddPersonAttrib(var_67_0, "体力", -10)

			WAR.YUFENG = WAR.YUFENG - 1

			CleanWarMap(4, 0)

			for iter_67_1 = 0, WAR.PersonNum - 1 do
				local var_67_36 = WAR.Person[iter_67_1].人物编号

				if WAR.Person[iter_67_1].死亡 == false and WAR.Person[iter_67_1].我方 == false then
					SetWarMap(WAR.Person[iter_67_1].坐标X, WAR.Person[iter_67_1].坐标Y, 4, 6)

					JY.Person[var_67_36].生命 = JY.Person[var_67_36].生命 - 200

					if JY.Person[var_67_36].生命 <= 0 then
						JY.Person[var_67_36].生命 = 1

						AddPersonAttrib(var_67_36, "中毒程度", 20)
					end
				end
			end

			local var_67_37 = WAR.Person[WAR.CurID].坐标X
			local var_67_38 = WAR.Person[WAR.CurID].坐标Y

			War_ShowFight(var_67_0, 0, 0, 0, var_67_37, var_67_38, 34)
			QZXS("敌全体损血200点")
			CleanWarMap(4, 0)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 63) then
		if JY.Person[var_67_0].体力 >= 20 and JY.Person[var_67_0].内力 >= 500 then
			Cls()
			CurIDTXDH(WAR.CurID, 39, 0, "桃花秘传·碧海潮生曲")
			lib.Delay(10)

			JY.Person[var_67_0].体力 = JY.Person[var_67_0].体力 - 10
			JY.Person[var_67_0].内力 = JY.Person[var_67_0].内力 - 350

			for iter_67_2 = 0, WAR.PersonNum - 1 do
				local var_67_39 = WAR.Person[iter_67_2].人物编号

				if WAR.Person[iter_67_2].死亡 == false and WAR.Person[iter_67_2].我方 then
					AddPersonAttrib(var_67_39, "受伤程度", -35)
				end
			end
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 72) then
		if JY.Person[var_67_0].体力 >= 20 then
			War_CalMoveStep(WAR.CurID, 5, 1)

			local var_67_40
			local var_67_41
			local var_67_42 = -1
			local var_67_43 = -1

			while true do
				local var_67_44, var_67_45 = var_67_2()

				if var_67_44 == nil then
					return 0
				end

				if var_67_44 ~= nil then
					if lib.GetWarMap(var_67_44, var_67_45, 2) < 0 and lib.GetWarMap(var_67_44, var_67_45, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_44, var_67_45, 2) == nil or GetWarMap(var_67_44, var_67_45, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_46 = GetWarMap(var_67_44, var_67_45, 2)

						var_67_43 = WAR.Person[var_67_46].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_46].我方 then
							QZXS("不能选择我方人物")
						else
							break
						end
					end
				end
			end

			if WAR.LQZ[var_67_43] ~= nil then
				WAR.LQZ[var_67_43] = WAR.LQZ[var_67_43] - 30

				if WAR.LQZ[var_67_43] <= 0 then
					WAR.LQZ[var_67_43] = nil
				end
			end

			QZXS(JY.Person[var_67_43].姓名 .. "的怒气值降低30点")
			AddPersonAttrib(var_67_0, "体力", -5)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 90) then
		if JY.Person[var_67_0].体力 >= 10 then
			War_CalMoveStep(WAR.CurID, 5, 1)

			local var_67_47
			local var_67_48
			local var_67_49 = -1
			local var_67_50 = -1

			while true do
				var_67_47, var_67_48 = War_SelectMove()

				if var_67_47 == nil then
					return 0
				end

				if var_67_47 ~= nil then
					if lib.GetWarMap(var_67_47, var_67_48, 2) < 0 and lib.GetWarMap(var_67_47, var_67_48, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_47, var_67_48, 2) == nil or GetWarMap(var_67_47, var_67_48, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_51 = GetWarMap(var_67_47, var_67_48, 2)

						var_67_50 = WAR.Person[var_67_51].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_51].我方 then
							QZXS("不能选择我方人物")
						else
							break
						end
					end
				end
			end

			for iter_67_3 = 0, 63 do
				for iter_67_4 = 0, 63 do
					SetWarMap(iter_67_3, iter_67_4, 4, -1)
				end
			end

			SetWarMap(var_67_47, var_67_48, 4, 6)
			AddPersonAttrib(var_67_50, "中毒程度", 30)
			War_ShowFight(var_67_0, 0, 0, 0, var_67_47, var_67_48, 37)

			local var_67_52 = -1
			local var_67_53 = 0
			local var_67_54 = 0

			for iter_67_5 = 1, 4 do
				if JY.Person[var_67_50]["携带物品数量" .. iter_67_5] > 0 and JY.Person[var_67_50]["携带物品" .. iter_67_5] > -1 then
					var_67_54 = 1

					break
				end
			end

			if var_67_54 == 0 then
				QZXS(JY.Person[var_67_50].姓名 .. "身上没有物品")
			else
				local var_67_55

				while var_67_52 == -1 do
					var_67_55 = math.random(4)

					if JY.Person[var_67_50]["携带物品数量" .. var_67_55] > 0 and JY.Person[var_67_50]["携带物品" .. var_67_55] > -1 then
						var_67_53 = math.random(JY.Person[var_67_50]["携带物品数量" .. var_67_55])
						var_67_52 = JY.Person[var_67_50]["携带物品" .. var_67_55]
					end
				end

				if var_67_53 == JY.Person[var_67_50]["携带物品数量" .. var_67_55] then
					JY.Person[var_67_50]["携带物品数量" .. var_67_55] = 0
					JY.Person[var_67_50]["携带物品" .. var_67_55] = -1
				else
					JY.Person[var_67_50]["携带物品数量" .. var_67_55] = JY.Person[var_67_50]["携带物品数量" .. var_67_55] - var_67_53
				end

				instruct_32(var_67_52, var_67_53)
				QZXS("窃取" .. JY.Thing[var_67_52].名称 .. tostring(var_67_53) .. "件")
			end

			SetWarMap(var_67_47, var_67_48, 4, -1)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 2) or cxtd(var_67_0, 25) or cxtd(var_67_0, 47) then
		if JY.Person[var_67_0].体力 >= 10 then
			War_CalMoveStep(WAR.CurID, 8, 1)

			local var_67_56
			local var_67_57
			local var_67_58 = -1
			local var_67_59 = -1

			while true do
				var_67_56, var_67_57 = War_SelectMove()

				if var_67_56 == nil then
					return 0
				end

				if var_67_56 ~= nil then
					if lib.GetWarMap(var_67_56, var_67_57, 2) < 0 and lib.GetWarMap(var_67_56, var_67_57, 5) < 0 then
						QZXS("此处无人，请重新选择")
					elseif GetWarMap(var_67_56, var_67_57, 2) == nil or GetWarMap(var_67_56, var_67_57, 2) < 0 then
						QZXS("此处无人，请重新选择")
					else
						local var_67_60 = GetWarMap(var_67_56, var_67_57, 2)

						var_67_59 = WAR.Person[var_67_60].人物编号

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_60].我方 then
							QZXS("不能选择我方人物")
						else
							break
						end
					end
				end
			end

			for iter_67_6 = 0, 63 do
				for iter_67_7 = 0, 63 do
					SetWarMap(iter_67_6, iter_67_7, 4, -1)
				end
			end

			SetWarMap(var_67_56, var_67_57, 4, 6)

			local var_67_61 = JY.Person[var_67_59].中毒程度
			local var_67_62 = math.modf(var_67_61 * 2)
			local var_67_63 = math.modf(var_67_61 * 3)
			local var_67_64 = math.random(var_67_62, var_67_63) + math.random(10)

			JY.Person[var_67_59].生命 = JY.Person[var_67_59].生命 - var_67_64

			War_ShowFight(var_67_0, 0, 0, 0, var_67_56, var_67_57, 54)
			QZXS(JY.Person[var_67_59].姓名 .. "毒发，损失生命" .. tostring(var_67_64) .. "点")
			SetWarMap(var_67_56, var_67_57, 4, -1)
			AddPersonAttrib(var_67_0, "体力", -20)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, 30)

			return 0
		end
	end

	if cxtd(var_67_0, 53) then
		if JY.Person[var_67_0].体力 > 20 then
			WAR.TZ_DY = 1

			PlayWavE(16)
			Cls()
			CurIDTXDH(WAR.CurID, 71, 0, "休迅飞凫 飘忽若神")

			JY.Person[var_67_0].体力 = JY.Person[var_67_0].体力 - 10
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 49) then
		if JY.Person[var_67_0].体力 > 20 and JY.Person[var_67_0].内力 > 1000 then
			JY.Person[var_67_0].体力 = JY.Person[var_67_0].体力 - 5
			JY.Person[var_67_0].内力 = JY.Person[var_67_0].内力 - 500

			local var_67_65 = {}
			local var_67_66 = 1

			for iter_67_8 = 0, WAR.PersonNum - 1 do
				local var_67_67 = WAR.Person[iter_67_8].人物编号

				if WAR.TZ_XZ_SSH[var_67_67] == 1 and WAR.Person[iter_67_8].死亡 == false then
					if WAR.FXDS[var_67_67] == nil then
						WAR.FXDS[var_67_67] = 25
					else
						WAR.FXDS[var_67_67] = WAR.FXDS[var_67_67] + 25
					end

					if WAR.FXDS[var_67_67] > 50 then
						WAR.FXDS[var_67_67] = 50
					end

					WAR.TZ_XZ_SSH[var_67_67] = nil

					if WAR.Person[iter_67_8].Time > 995 then
						WAR.Person[iter_67_8].Time = 995
					end

					var_67_65[var_67_66] = {}
					var_67_65[var_67_66][1] = iter_67_8
					var_67_65[var_67_66][2] = var_67_67
					var_67_66 = var_67_66 + 1
				end
			end

			local var_67_68 = {}

			for iter_67_9 = 1, var_67_66 - 1 do
				var_67_68[iter_67_9] = {}
				var_67_68[iter_67_9][1] = JY.Person[var_67_65[iter_67_9][2]].姓名
				var_67_68[iter_67_9][2] = nil
				var_67_68[iter_67_9][3] = 1
			end

			DrawStrBox(CC.MainMenuX, CC.MainMenuY, "催符：", C_GOLD, CC.DefaultFont)
			ShowMenu(var_67_68, var_67_66 - 1, 10, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)
			Cls()
			PlayWavAtk(32)
			Cls()
			CurIDTXDH(WAR.CurID, 72, 0, "符掌生死 德折群雄")
			PlayWavE(8)

			local var_67_69 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

			for iter_67_10 = 114, 129 do
				for iter_67_11 = 1, var_67_66 - 1 do
					local var_67_70 = WAR.Person[WAR.CurID].坐标X
					local var_67_71 = WAR.Person[WAR.CurID].坐标Y
					local var_67_72 = WAR.Person[var_67_65[iter_67_11][1]].坐标X - var_67_70
					local var_67_73 = WAR.Person[var_67_65[iter_67_11][1]].坐标Y - var_67_71
					local var_67_74 = CC.XScale * (var_67_72 - var_67_73) + CC.ScreenW / 2
					local var_67_75 = CC.YScale * (var_67_72 + var_67_73) + CC.ScreenH / 2 - GetS(JY.SubScene, var_67_72 + var_67_70, var_67_73 + var_67_71, 4)

					lib.PicLoadCache(3, iter_67_10 * 2, var_67_74, var_67_75, 2, 192)

					if iter_67_10 > 124 then
						DrawString(var_67_74 - 10, var_67_75 - 15, "封穴", C_GOLD, CC.DefaultFont)
					end
				end

				lib.ShowSurface(0)
				lib.LoadSur(var_67_69, 0, 0)
				lib.Delay(30)
			end

			lib.FreeSur(var_67_69)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 89) then
		if JY.Person[var_67_0].体力 > 25 and JY.Person[var_67_0].内力 > 300 then
			local var_67_76 = WAR.Person[WAR.CurID].坐标X
			local var_67_77 = WAR.Person[WAR.CurID].坐标Y
			local var_67_78 = {
				{
					WAR.Person[WAR.CurID].坐标X,
					WAR.Person[WAR.CurID].坐标Y + 1
				},
				{
					WAR.Person[WAR.CurID].坐标X,
					WAR.Person[WAR.CurID].坐标Y - 1
				},
				{
					WAR.Person[WAR.CurID].坐标X + 1,
					WAR.Person[WAR.CurID].坐标Y
				},
				{
					WAR.Person[WAR.CurID].坐标X - 1,
					WAR.Person[WAR.CurID].坐标Y
				}
			}
			local var_67_79 = {}
			local var_67_80 = 1

			for iter_67_12 = 1, 4 do
				if GetWarMap(var_67_78[iter_67_12][1], var_67_78[iter_67_12][2], 2) >= 0 then
					local var_67_81 = GetWarMap(var_67_78[iter_67_12][1], var_67_78[iter_67_12][2], 2)

					if instruct_16(WAR.Person[var_67_81].人物编号) then
						var_67_79[var_67_80] = WAR.Person[var_67_81].人物编号
						var_67_80 = var_67_80 + 1
					end
				end
			end

			local var_67_82 = {}

			for iter_67_13 = 1, var_67_80 - 1 do
				var_67_82[iter_67_13] = {}
				var_67_82[iter_67_13][1] = JY.Person[var_67_79[iter_67_13]].姓名 .. "+" .. JY.Person[var_67_79[iter_67_13]].体力
				var_67_82[iter_67_13][2] = nil
				var_67_82[iter_67_13][3] = 1
			end

			DrawStrBox(CC.MainMenuX, CC.MainMenuY, "气补：", C_GOLD, CC.DefaultFont)

			local var_67_83 = ShowMenu(var_67_82, var_67_80 - 1, 10, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)

			Cls()
			AddPersonAttrib(var_67_79[var_67_83], "体力", 50)
			AddPersonAttrib(var_67_0, "体力", -25)
			AddPersonAttrib(var_67_0, "内力", -300)
			PlayWavE(28)
			lib.Delay(10)
			Cls()
			CurIDTXDH(WAR.CurID, 86, 0, "化气补元")

			local var_67_84 = WAR.CurID

			for iter_67_14 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_14].人物编号 == var_67_79[var_67_83] then
					WAR.CurID = iter_67_14
				end
			end

			WarDrawMap(0)
			PlayWavE(36)
			lib.Delay(100)
			Cls()
			CurIDTXDH(WAR.CurID, 86, 0, "恢复体力50点")

			WAR.CurID = var_67_84

			WarDrawMap(0)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 9) then
		if JY.Person[var_67_0].体力 > 10 and JY.Person[var_67_0].内力 > 500 then
			local var_67_85 = {}
			local var_67_86 = 1

			for iter_67_15 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_15].我方 == true and WAR.Person[iter_67_15].死亡 == false and RealJL(WAR.CurID, iter_67_15, 8) and iter_67_15 ~= WAR.CurID then
					var_67_85[var_67_86] = {}
					var_67_85[var_67_86][1] = JY.Person[WAR.Person[iter_67_15].人物编号].姓名
					var_67_85[var_67_86][2] = nil
					var_67_85[var_67_86][3] = 1
					var_67_85[var_67_86][4] = iter_67_15
					var_67_86 = var_67_86 + 1
				end
			end

			DrawStrBox(CC.MainMenuX, CC.MainMenuY, "挪移：", C_GOLD, CC.DefaultFont)

			local var_67_87 = ShowMenu(var_67_85, var_67_86 - 1, 10, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)

			Cls()

			local var_67_88 = WAR.Person[var_67_85[var_67_87][4]].人物编号

			QZXS("请选择要将" .. JY.Person[var_67_88].姓名 .. "挪移到什么位置？")
			War_CalMoveStep(WAR.CurID, 8, 1)

			local var_67_89
			local var_67_90

			while true do
				var_67_89, var_67_90 = War_SelectMove()

				if var_67_89 ~= nil then
					if lib.GetWarMap(var_67_89, var_67_90, 2) > 0 or lib.GetWarMap(var_67_89, var_67_90, 5) > 0 then
						QZXS("此处有人！请重新选择")
					elseif CC.SceneWater[lib.GetWarMap(var_67_89, var_67_90, 0)] ~= nil then
						QZXS("水面，不可进入！请重新选择")
					else
						break
					end
				end
			end

			PlayWavE(5)
			Cls()
			CurIDTXDH(WAR.CurID, 88, 0, "九阳明尊 挪移乾坤")

			local var_67_91 = WAR.CurID

			WAR.CurID = var_67_85[var_67_87][4]

			WarDrawMap(0)
			CurIDTXDH(WAR.CurID, 88, 0)
			lib.SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, -1)
			lib.SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, -1)
			WarDrawMap(0)
			CurIDTXDH(WAR.CurID, 88, 0)

			WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y = var_67_89, var_67_90

			WarDrawMap(0)
			CurIDTXDH(WAR.CurID, 88, 0)
			lib.SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, WAR.Person[WAR.CurID].贴图)
			lib.SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, WAR.CurID)
			WarDrawMap(0)
			CurIDTXDH(WAR.CurID, 88, 0)

			WAR.CurID = var_67_91

			AddPersonAttrib(var_67_0, "体力", -10)
			AddPersonAttrib(var_67_0, "内力", -500)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 88) then
		if JY.Person[var_67_0].体力 > 10 and JY.Person[var_67_0].内力 > 700 then
			local var_67_92 = {}
			local var_67_93 = 1

			for iter_67_16 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_16].我方 == true and WAR.Person[iter_67_16].死亡 == false and RealJL(WAR.CurID, iter_67_16, 5) and iter_67_16 ~= WAR.CurID then
					var_67_92[var_67_93] = {}
					var_67_92[var_67_93][1] = JY.Person[WAR.Person[iter_67_16].人物编号].姓名
					var_67_92[var_67_93][2] = nil
					var_67_92[var_67_93][3] = 1
					var_67_92[var_67_93][4] = iter_67_16
					var_67_93 = var_67_93 + 1
				end
			end

			DrawStrBox(CC.MainMenuX, CC.MainMenuY, "传功：", C_GOLD, 30)

			local var_67_94 = ShowMenu(var_67_92, var_67_93 - 1, 10, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)

			Cls()

			local var_67_95 = WAR.Person[var_67_92[var_67_94][4]].人物编号

			PlayWavE(28)
			lib.Delay(10)
			Cls()
			CurIDTXDH(WAR.CurID, 87, 0, "酒神戏红尘")

			local var_67_96 = WAR.CurID

			WAR.CurID = var_67_92[var_67_94][4]

			WarDrawMap(0)
			PlayWavE(36)
			lib.Delay(100)
			Cls()
			CurIDTXDH(WAR.CurID, 87, 0, "集气上升500")

			WAR.CurID = var_67_96

			WarDrawMap(0)

			WAR.Person[var_67_92[var_67_94][4]].Time = WAR.Person[var_67_92[var_67_94][4]].Time + 500

			if WAR.Person[var_67_92[var_67_94][4]].Time > 999 then
				WAR.Person[var_67_92[var_67_94][4]].Time = 999
			end

			AddPersonAttrib(var_67_0, "体力", -10)
			AddPersonAttrib(var_67_0, "内力", -1000)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 74) then
		if JY.Person[var_67_0].体力 > 10 and JY.Person[var_67_0].内力 > 150 then
			Cls()
			CurIDTXDH(WAR.CurID, 92, 0, GRTS[74])

			for iter_67_17 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_17].我方 == true and WAR.Person[iter_67_17].死亡 == false and iter_67_17 ~= WAR.CurID then
					WAR.Person[iter_67_17].Time = WAR.Person[iter_67_17].Time + 300

					if WAR.Person[iter_67_17].Time > 999 then
						WAR.Person[iter_67_17].Time = 999
					end
				end
			end

			AddPersonAttrib(var_67_0, "体力", -10)
			AddPersonAttrib(var_67_0, "内力", -150)
			lib.Delay(100)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 28) then
		if JY.Person[var_67_0].体力 >= 50 and JY.Person[var_67_0].内力 > 250 then
			CleanWarMap(4, 0)
			AddPersonAttrib(var_67_0, "体力", -10)
			AddPersonAttrib(var_67_0, "内力", -250)

			for iter_67_18 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_18].我方 == true and WAR.Person[iter_67_18].死亡 == false then
					local var_67_97 = WAR.Person[iter_67_18].人物编号
					local var_67_98 = JY.Person[var_67_0].医疗能力 / 4 + JY.Person[var_67_0].医疗能力 * WAR.PYZ / 16 + math.random(30)

					if var_67_98 > JY.Person[var_67_0].医疗能力 / 2 then
						var_67_98 = JY.Person[var_67_0].医疗能力 / 2 + math.random(30) + 30
					end

					local var_67_99 = math.modf(var_67_98)

					WAR.Person[iter_67_18].内伤点数 = (WAR.Person[iter_67_18].内伤点数 or 0) + AddPersonAttrib(var_67_97, "受伤程度", -math.modf(var_67_99 / 5))
					WAR.Person[iter_67_18].生命点数 = (WAR.Person[iter_67_18].生命点数 or 0) + AddPersonAttrib(var_67_97, "生命", var_67_99)

					SetWarMap(WAR.Person[iter_67_18].坐标X, WAR.Person[iter_67_18].坐标Y, 4, 4)
				end
			end

			WAR.Person[WAR.CurID].特效文字2 = GRTS[28]

			War_ShowFight(var_67_0, 0, 0, 0, WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 0)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 77) then
		if JY.Person[var_67_0].生命 > 500 and JY.Person[var_67_0].受伤程度 < 50 then
			local var_67_100

			for iter_67_19 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_19].人物编号 == 0 and WAR.Person[iter_67_19].死亡 == false then
					var_67_100 = iter_67_19

					break
				end
			end

			if var_67_100 ~= nil then
				Cls()
				CurIDTXDH(WAR.CurID, 89, 0, "我心本慧·侠女柔情")
				say("１ｎ哥哥，９请。。。。。。２加油！", 77, 0)

				JY.Person[var_67_0].生命 = 1
				JY.Person[var_67_0].受伤程度 = 100
				WAR.Person[WAR.CurID].Time = -500
				JY.Person[0].生命 = JY.Person[0].生命最大值
				JY.Person[0].受伤程度 = 0
				WAR.Person[var_67_100].Time = 999
				WAR.FXDS[0] = nil
				WAR.LQZ[0] = 100
			else
				DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

				return 0
			end
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 590) then
		if WAR.L_LWX == 0 then
			CurIDTXDH(WAR.CurID, 33, 0, GRTS[590])
			lib.Delay(100)

			for iter_67_20 = 0, WAR.PersonNum - 1 do
				if WAR.Person[iter_67_20].我方 == true and WAR.Person[iter_67_20].死亡 == false and iter_67_20 ~= WAR.CurID then
					local var_67_101 = WAR.Person[iter_67_20].人物编号

					AddPersonAttrib(var_67_101, "生命", math.modf(JY.Person[var_67_0].生命 / 2))
					AddPersonAttrib(var_67_101, "内力", math.modf(JY.Person[var_67_0].内力 / 2))
					AddPersonAttrib(var_67_101, "体力", math.modf(JY.Person[var_67_0].体力 / 2))

					JY.Person[var_67_101].受伤程度 = 0
					WAR.FXDS[var_67_101] = nil
					WAR.LXZT[var_67_101] = nil
				end
			end

			JY.Person[var_67_0].生命 = 1
			JY.Person[var_67_0].内力 = 1
			JY.Person[var_67_0].体力 = 1
			JY.Person[var_67_0].受伤程度 = 100
			WAR.FXDS[var_67_0] = 50
			WAR.LXZT[var_67_0] = 100
			WAR.L_LWX = 1
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 17) then
		if JY.Person[var_67_0].体力 >= 30 and JY.Person[var_67_0].内力 >= 300 then
			CleanWarMap(4, 0)
			AddPersonAttrib(var_67_0, "体力", -15)
			AddPersonAttrib(var_67_0, "内力", -300)

			local var_67_102 = WAR.Person[WAR.CurID].坐标X
			local var_67_103 = WAR.Person[WAR.CurID].坐标Y

			for iter_67_21 = var_67_102 - 5, var_67_102 + 5 do
				for iter_67_22 = var_67_103 - 5, var_67_103 + 5 do
					SetWarMap(iter_67_21, iter_67_22, 4, 1)

					if GetWarMap(iter_67_21, iter_67_22, 2) ~= nil and GetWarMap(iter_67_21, iter_67_22, 2) > -1 then
						local var_67_104 = GetWarMap(iter_67_21, iter_67_22, 2)

						if WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_67_104].我方 then
							WAR.L_WNGZL[WAR.Person[var_67_104].人物编号] = 50

							SetWarMap(iter_67_21, iter_67_22, 4, 4)
						end
					end
				end
			end

			War_ShowFight(var_67_0, 0, 0, 0, var_67_102, var_67_103, 30)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 16) then
		if JY.Person[var_67_0].体力 >= 30 and JY.Person[var_67_0].内力 >= 300 then
			CleanWarMap(4, 0)
			AddPersonAttrib(var_67_0, "体力", -15)
			AddPersonAttrib(var_67_0, "内力", -300)

			local var_67_105 = WAR.Person[WAR.CurID].坐标X
			local var_67_106 = WAR.Person[WAR.CurID].坐标Y

			for iter_67_23 = var_67_105 - 4, var_67_105 + 4 do
				for iter_67_24 = var_67_106 - 4, var_67_106 + 4 do
					SetWarMap(iter_67_23, iter_67_24, 4, 1)

					if GetWarMap(iter_67_23, iter_67_24, 2) ~= nil and GetWarMap(iter_67_23, iter_67_24, 2) > -1 then
						local var_67_107 = GetWarMap(iter_67_23, iter_67_24, 2)

						if WAR.Person[WAR.CurID].我方 == WAR.Person[var_67_107].我方 then
							WAR.L_HQNZL[WAR.Person[var_67_107].人物编号] = 20

							SetWarMap(iter_67_23, iter_67_24, 4, 4)
						end
					end
				end
			end

			War_ShowFight(var_67_0, 0, 0, 0, var_67_105, var_67_106, 0)
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	if cxtd(var_67_0, 29) then
		if JY.Person[var_67_0].体力 >= 50 and JY.Person[var_67_0].内力 >= 500 then
			AddPersonAttrib(var_67_0, "内力", -500)

			if GetS(86, 10, 12, 5) == 1 then
				AddPersonAttrib(var_67_0, "体力", -12)

				WAR.L_TBGZL = 1
			elseif GetS(86, 10, 12, 5) == 2 then
				AddPersonAttrib(var_67_0, "体力", -10)

				WAR.L_TBGZL = 2
			end

			War_FightMenu()
		else
			DrawStrBoxWaitKey("未满足发动条件", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	return 1
end

function War_ActupMenu()
	local var_69_0 = WAR.CurID
	local var_69_1 = WAR.Person[var_69_0].人物编号
	local var_69_2 = WAR.Person[var_69_0].坐标X
	local var_69_3 = WAR.Person[var_69_0].坐标Y

	if PersonKF(var_69_1, 95) then
		WAR.Actup[var_69_1] = 2
		WAR.Defup[var_69_1] = 1
		WAR.tmp[200 + var_69_1] = 101

		Cls()
		CurIDTXDH(WAR.CurID, 87, 0, "蛤蟆蓄力成功")

		return 1
	elseif (var_69_1 == JY.Base.队伍1 or var_69_1 == JY.Base.畅想编号 or var_69_1 == 9999 and JY.Person[var_69_1].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 1 then
		WAR.Actup[var_69_1] = 2
	elseif PersonKF(var_69_1, 103) or PersonKF(var_69_1, 101) then
		WAR.Actup[var_69_1] = 2
		WAR.Defup[var_69_1] = 1
	elseif JLSD(15, 85, var_69_1) then
		WAR.Actup[var_69_1] = 2
	end

	if WAR.Actup[var_69_1] ~= 2 then
		Cls()
		DrawStrBox(-1, -1, "蓄力失败", C_GOLD, CC.DefaultFont)
		ShowScreen()
		lib.Delay(500)
	else
		Cls()
		CurIDTXDH(WAR.CurID, 85, 0, "蓄力成功")
		lib.Delay(500)
	end

	return 1
end

function War_DefupMenu()
	local var_70_0 = WAR.CurID
	local var_70_1 = WAR.Person[var_70_0].人物编号
	local var_70_2 = WAR.Person[var_70_0].坐标X
	local var_70_3 = WAR.Person[var_70_0].坐标Y

	WAR.Defup[var_70_1] = 1

	Cls()

	local var_70_4 = GetS(JY.SubScene, var_70_2, var_70_3, 4)

	if PersonKF(var_70_1, 102) then
		WAR.Actup[var_70_1] = 2

		CurIDTXDH(WAR.CurID, 86, 1)
		DrawStrBox(-1, -1, "防御开始·太玄蓄力", C_RED, CC.DefaultFont, C_GOLD)
		ShowScreen()
		lib.Delay(400)

		return 1
	end

	CurIDTXDH(WAR.CurID, 86, 1)
	DrawStrBox(-1, -1, "防御开始", LimeGreen, CC.DefaultFont, C_GOLD)
	ShowScreen()
	lib.Delay(400)

	return 1
end

function War_WaitMenu()
	local var_71_0 = WAR.CurID
	local var_71_1 = WAR.Person[var_71_0].人物编号

	WAR.JZPZ[var_71_1] = 1
	WAR.Person[WAR.CurID].Time = WAR.Person[WAR.CurID].Time + 600

	Cls()
	CurIDTXDH(WAR.CurID, 87, 0, "待机而动")

	return 1
end

function GetJiqi()
	local var_72_0 = 0
	local var_72_1 = 0

	local function var_72_2(arg_73_0)
		if arg_73_0 > 600 then
			return 20 + (arg_73_0 - 600) / 50
		elseif arg_73_0 > 450 then
			return 15 + (arg_73_0 - 450) / 50
		elseif arg_73_0 > 300 then
			return 8 + (arg_73_0 - 300) / 100
		elseif arg_73_0 > 100 then
			return 5 + (arg_73_0 - 100) / 50
		else
			return arg_73_0 / 50
		end
	end

	local function var_72_3(arg_74_0, arg_74_1)
		local var_74_0 = (arg_74_0 * 2 + arg_74_1) / 3

		if var_74_0 > 5600 then
			return 8 + math.min((var_74_0 - 5600) / 1200, 3)
		elseif var_74_0 > 3600 then
			return 6 + (var_74_0 - 3600) / 1000
		elseif var_74_0 > 2000 then
			return 4 + (var_74_0 - 2000) / 800
		elseif var_74_0 > 800 then
			return 2 + (var_74_0 - 800) / 600
		else
			return var_74_0 / 400
		end
	end

	for iter_72_0 = 0, WAR.PersonNum - 1 do
		if not WAR.Person[iter_72_0].死亡 then
			local var_72_4 = WAR.Person[iter_72_0].人物编号
			local var_72_5 = 0

			for iter_72_1 = 1, CC.Kungfunum do
				if JY.Person[var_72_4]["武功" .. iter_72_1] == JY.Person[var_72_4].主功体 then
					var_72_5 = JY.Person[var_72_4]["武功等级" .. iter_72_1] == 999 and 10 or JY.Person[var_72_4]["武功等级" .. iter_72_1] / 100
				end
			end

			local var_72_6 = 0

			if JY.Person[var_72_4].主功体 > 0 then
				var_72_6 = JY.Wugong[JY.Person[var_72_4].主功体].增幅轻功等级 * var_72_5
			end

			WAR.Person[iter_72_0].TimeAdd = math.modf(var_72_2(WAR.Person[iter_72_0].轻功 + var_72_6) + var_72_3(JY.Person[var_72_4].内力, JY.Person[var_72_4].内力最大值) - JY.Person[var_72_4].中毒程度 / 10 - JY.Person[var_72_4].中冰毒 / 5 - JY.Person[var_72_4].受伤程度 / 25 + JY.Person[var_72_4].体力 / 30)

			local var_72_7 = JY.Person[var_72_4].主功体

			if var_72_7 > 0 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + JY.Wugong[var_72_7].增加集气速度
			end

			local var_72_8 = JY.Person[var_72_4].主运轻功

			if var_72_8 > 0 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + JY.Wugong[var_72_8].增加集气速度
			end

			if WAR.LQZ[var_72_4] ~= nil and WAR.LQZ[var_72_4] >= 100 then
				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * (WAR.LQZ[var_72_4] * 0.05))
			end

			if WAR.ZYZ[var_72_4] > 100 then
				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * (WAR.ZYZ[var_72_4] * 0.01))
			end

			local var_72_9 = JY.Person[var_72_4].实战

			if var_72_9 >= 500 then
				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd + var_72_9 / 200)
			end

			if JY.Base.主角职业 == 2 and var_72_4 == 0 then
				local var_72_10 = 0

				for iter_72_2 = 1, CC.Kungfunum do
					if JY.Wugong[JY.Person[var_72_4]["武功" .. iter_72_2]].武功类型 == 2 and JY.Person[JY.Base.队伍1]["武功等级" .. iter_72_2] == 999 then
						var_72_10 = var_72_10 + 1
					end
				end

				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * (1 + 0.05 * var_72_10))
			end

			if var_72_4 == 0 and JY.Base.主角职业 == 8 and JY.Base.二次觉醒 == 1 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + math.modf(JY.Person[var_72_4].中毒程度 / 5)
			end

			if T4RM(var_72_4) and JY.Person[JY.Base.队伍1].悟性 < 50 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if T4RM(var_72_4) then
				local var_72_11 = 0
				local var_72_12 = math.modf(1 + (JY.Person[var_72_4].生命最大值 - JY.Person[var_72_4].生命) / 30)

				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + var_72_12
			end

			for iter_72_3 = 1, 20 do
				if JY.Person[var_72_4]["武功" .. iter_72_3] == 48 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.2)
				end
			end

			if Curr_NG(var_72_4, 105) then
				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.3)
			end

			if PersonKF(var_72_4, 102) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 2
			end

			if PersonKF(var_72_4, 93) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 2
			end

			if cxtd(var_72_4, 189) then
				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.1)
			end

			if cxtd(var_72_4, 71) then
				local var_72_13 = 0

				for iter_72_4 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_4].死亡 == false and WAR.Person[iter_72_4].我方 == WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 1
					end
				end

				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd)
			end

			if PersonKF(var_72_4, 68) and JY.Person[var_72_4].特殊兵器 >= 180 and cxtd(var_72_4, 0) and JY.Base.觉醒 == 1 then
				local var_72_14 = 0

				for iter_72_5 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_5].死亡 == false and WAR.Person[iter_72_5].我方 == WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 1
					end
				end

				WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd)
			end

			if cxtd(var_72_4, 37) and WAR.DYWY == 1 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 27) or cxtd(var_72_4, 1) or cxtd(var_72_4, 57) or cxtd(var_72_4, 97) or cxtd(var_72_4, 516) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 5001) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 113) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 116) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 20
			end

			if cxtd(var_72_4, 78) and PersonKF(var_72_4, 107) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 164) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 67) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 5002) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 587) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10

				for iter_72_6 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_6].死亡 == true and WAR.Person[iter_72_6].我方 == WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd - 2
					end
				end
			end

			if cxtd(var_72_4, 29) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 20

				for iter_72_7 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_7].死亡 == false and WAR.Person[iter_72_7].我方 == WAR.Person[iter_72_0].我方 then
						if GetS(86, 10, 12, 5) ~= 0 then
							WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd - 2
						else
							WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd - 4
						end
					end
				end

				if WAR.L_TBGZL == 2 then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
				end
			end

			if cxtd(var_72_4, 55) then
				local var_72_15 = 0

				for iter_72_8 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_8].死亡 == true and WAR.Person[iter_72_8].我方 == WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 3
					end
				end
			end

			if WAR.ZDDH == 14 and (var_72_4 == 173 or var_72_4 == 174 or var_72_4 == 175) then
				local var_72_16 = 0

				for iter_72_9 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_9].死亡 == false and WAR.Person[iter_72_9].我方 == WAR.Person[iter_72_0].我方 then
						var_72_16 = var_72_16 + 1
					end
				end

				if var_72_16 == 3 then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
				end
			end

			if (WAR.ZDDH == 15 or WAR.ZDDH == 545) and WAR.Person[iter_72_0].我方 == false then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if WAR.ZDDH == 73 and WAR.Person[iter_72_0].我方 == false then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if var_72_4 == JY.Base.队伍1 and WAR.LRZ == 1 then
				for iter_72_10 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_10].人物编号 == 92 and WAR.Person[iter_72_10].死亡 == false then
						WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5

						break
					end
				end
			end

			if cxtd(var_72_4, 50) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if (cxtd(var_72_4, 173) or cxtd(var_72_4, 174) or cxtd(var_72_4, 66) or cxtd(var_72_4, 175)) and PersonKF(var_72_4, 93) and PersonKF(var_72_4, 97) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 140) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 142) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 155) or cxtd(var_72_4, 156) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 592) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10 + WAR.L_DGQB_X * 2
			end

			if WAR.FLHS2 > 20 then
				WAR.FLHS2 = 20
			end

			if var_72_4 == JY.Base.队伍1 or var_72_4 == JY.Base.畅想编号 or var_72_4 == 9999 and JY.Person[var_72_4].姓名 == JY.Person[JY.Base.队伍1].姓名 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.FLHS2
			end

			if Curr_NG(var_72_4, 113) and WAR.TJZX[var_72_4] ~= nil then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.TJZX[var_72_4]
			end

			if cxtd(var_72_4, 5113) then
				if WAR.FQYY[var_72_4] == nil then
					WAR.FQYY[var_72_4] = 0
				end

				if WAR.FQYY[var_72_4] > 15 then
					WAR.FQYY[var_72_4] = 15
				end

				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.FQYY[var_72_4]
			end

			if cxtd(var_72_4, 452) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 18) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if cxtd(var_72_4, 97) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.XDLZ
			end

			if cxtd(var_72_4, 129) or cxtd(var_72_4, 65) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.WCY * 5
			end

			if cxtd(var_72_4, 553) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.YZB2 * 4
			end

			if cxtd(var_72_4, 28) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + WAR.PYZ * 3
			end

			if cxtd(var_72_4, 58) and JY.Person[0].受伤程度 > 10 and GetS(86, 11, 11, 5) == 2 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + math.floor(JY.Person[0].受伤程度) / 5
			end

			if cxtd(var_72_4, 58) and JY.Person[58].受伤程度 > 10 and GetS(86, 11, 11, 5) == 2 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + math.floor(JY.Person[58].受伤程度) / 5
			end

			if cxtd(var_72_4, 59) and GetS(86, 11, 11, 5) == 1 then
				for iter_72_11 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_11].人物编号 == JY.Base.队伍1 and WAR.Person[iter_72_11].死亡 == false and WAR.Person[iter_72_11].我方 == WAR.Person[WAR.CurID].我方 then
						for iter_72_12 = 1, #TeamP do
							if TeamP[iter_72_12] == var_72_4 then
								local var_72_17 = (JY.Person[var_72_4].实战 + JY.Person[0].实战 - 4) / 2000

								WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + math.floor(var_72_17 * 20)
								WAR.Person[iter_72_11].TimeAdd = WAR.Person[iter_72_11].TimeAdd + math.floor(var_72_17 * 20)

								break
							end
						end

						break
					end
				end
			end

			if cxtd(var_72_4, 82) then
				local var_72_18 = 0

				for iter_72_13 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_13].死亡 == false and WAR.Person[iter_72_13].我方 == WAR.Person[WAR.CurID].我方 and JY.Person[WAR.Person[iter_72_13].人物编号].性别 == 1 then
						var_72_18 = var_72_18 + 1
					end
				end

				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 3 * var_72_18
			end

			if cxtd(var_72_4, 590) or cxtd(var_72_4, 92) or cxtd(var_72_4, 595) or cxtd(var_72_4, 184) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if (PersonKF(var_72_4, 87) or cxtd(var_72_4, 17)) and JY.Person[var_72_4].中毒程度 > 0 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + math.modf(JY.Person[var_72_4].中毒程度 / 20)
			end

			if cxtd(var_72_4, 157) or cxtd(var_72_4, 158) or cxtd(var_72_4, 159) or cxtd(var_72_4, 152) or cxtd(var_72_4, 137) or cxtd(var_72_4, 130) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 11) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
			end

			if cxtd(var_72_4, 14) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
			end

			if (instruct_16(var_72_4) or ybdw(var_72_4)) and JY.Person[var_72_4].防具 == 230 then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5

				if cxtd(var_72_4, 590) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
				end

				if cxtd(var_72_4, 132) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 10
				end

				if cxtd(var_72_4, 594) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
				end
			end

			if (instruct_16(var_72_4) or ybdw(var_72_4)) and (JY.Person[var_72_4].防具 == 353 or JY.Person[var_72_4].防具 == 354) then
				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 3

				if cxtd(var_72_4, 590) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 3
				end

				if cxtd(var_72_4, 132) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 6
				end

				if cxtd(var_72_4, 594) then
					WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 3
				end
			end

			if cxtd(var_72_4, 596) and JY.Person[0].耍刀技巧 > 100 then
				local var_72_19 = 10 + math.modf((JY.Person[0].耍刀技巧 - 100) / 20)

				WAR.Person[iter_72_0].TimeAdd = WAR.Person[iter_72_0].TimeAdd + var_72_19
			end

			if cxtd(var_72_4, 589) then
				for iter_72_14 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_14].死亡 == false and WAR.Person[iter_72_14].我方 ~= WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_14].TimeAdd = WAR.Person[iter_72_14].TimeAdd - 5
					end
				end
			end

			if cxtd(var_72_4, 188) then
				for iter_72_15 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_15].死亡 == false and WAR.Person[iter_72_15].我方 ~= WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_15].TimeAdd = WAR.Person[iter_72_15].TimeAdd - 5
					end
				end
			end

			if not inteam(var_72_4) and not ybdw(var_72_4) then
				if JY.Base.游戏难度 == 1 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 0.8)
				elseif JY.Base.游戏难度 == 2 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 0.9)
				elseif JY.Base.游戏难度 == 3 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1)
				elseif JY.Base.游戏难度 == 4 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.1)
				elseif JY.Base.游戏难度 == 5 then
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.1)
				else
					WAR.Person[iter_72_0].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 1.2)
				end
			end

			if cxtd(var_72_4, 626) then
				for iter_72_16 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_16].死亡 == false and WAR.Person[iter_72_16].我方 == WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_16].TimeAdd = WAR.Person[iter_72_0].TimeAdd + 5
					end
				end
			end

			if cxtd(var_72_4, 5076) then
				for iter_72_17 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_72_17].死亡 == false and WAR.Person[iter_72_17].我方 ~= WAR.Person[iter_72_0].我方 then
						WAR.Person[iter_72_17].TimeAdd = math.modf(WAR.Person[iter_72_0].TimeAdd * 0.9)
					end
				end
			end

			if (var_72_4 == 445 or var_72_4 == 446) and WAR.ZDDH == 226 then
				WAR.Person[iter_72_0].TimeAdd = 0
			end

			if JY.ZJSL == 1 and not instruct_16(var_72_4) and WAR.Person[iter_72_0].我方 == false then
				WAR.Person[iter_72_0].TimeAdd = 0
			end

			if WAR.Person[iter_72_0].TimeAdd < 5 then
				WAR.Person[iter_72_0].TimeAdd = 5
			end

			if WAR.Person[iter_72_0].TimeAdd > 100 then
				WAR.Person[iter_72_0].TimeAdd = 100
			end

			var_72_0 = var_72_0 + 1
			var_72_1 = var_72_1 + WAR.Person[iter_72_0].TimeAdd
		end
	end

	WAR.LifeNum = var_72_0

	return math.modf(var_72_1 / var_72_0 + var_72_0 - 2)
end

function War_KfMove(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0[1] or 0
	local var_75_1 = arg_75_0[2] or 0
	local var_75_2 = WAR.Person[WAR.CurID].坐标X
	local var_75_3 = WAR.Person[WAR.CurID].坐标Y
	local var_75_4 = var_75_2
	local var_75_5 = var_75_3

	if var_75_0 ~= nil then
		if var_75_0 == 0 then
			War_CalMoveStep(WAR.CurID, var_75_1, 1)
		elseif var_75_0 == 1 then
			War_CalMoveStep(WAR.CurID, var_75_1 * 2, 1)

			for iter_75_0 = 1, var_75_1 * 2 do
				for iter_75_1 = 0, iter_75_0 do
					local var_75_6 = iter_75_0 - iter_75_1

					if var_75_1 < iter_75_1 or var_75_1 < var_75_6 then
						SetWarMap(var_75_2 + iter_75_1, var_75_3 + var_75_6, 3, 255)
						SetWarMap(var_75_2 + iter_75_1, var_75_3 - var_75_6, 3, 255)
						SetWarMap(var_75_2 - iter_75_1, var_75_3 + var_75_6, 3, 255)
						SetWarMap(var_75_2 - iter_75_1, var_75_3 - var_75_6, 3, 255)
					end
				end
			end
		elseif var_75_0 == 2 then
			War_CalMoveStep(WAR.CurID, var_75_1, 1)

			for iter_75_2 = 1, var_75_1 - 1 do
				for iter_75_3 = 1, var_75_1 - 1 do
					SetWarMap(var_75_2 + iter_75_2, var_75_3 + iter_75_3, 3, 255)
					SetWarMap(var_75_2 - iter_75_2, var_75_3 + iter_75_3, 3, 255)
					SetWarMap(var_75_2 + iter_75_2, var_75_3 - iter_75_3, 3, 255)
					SetWarMap(var_75_2 - iter_75_2, var_75_3 - iter_75_3, 3, 255)
				end
			end
		elseif var_75_0 == 3 then
			War_CalMoveStep(WAR.CurID, 2, 1)
			SetWarMap(var_75_2 + 2, var_75_3, 3, 255)
			SetWarMap(var_75_2 - 2, var_75_3, 3, 255)
			SetWarMap(var_75_2, var_75_3 + 2, 3, 255)
			SetWarMap(var_75_2, var_75_3 - 2, 3, 255)
		else
			War_CalMoveStep(WAR.CurID, 0, 1)
		end
	end

	while true do
		local var_75_7 = var_75_4
		local var_75_8 = var_75_5

		WarDrawMap(1, var_75_4, var_75_5)
		WarDrawAtt(var_75_4, var_75_5, arg_75_1, 1)
		WarShowHead(GetWarMap(var_75_4, var_75_5, 2))
		ShowScreen()

		local var_75_9 = WaitKey(1)

		if var_75_9 == VK_UP then
			var_75_8 = var_75_5 - 1
		elseif var_75_9 == VK_DOWN then
			var_75_8 = var_75_5 + 1
		elseif var_75_9 == VK_LEFT then
			var_75_7 = var_75_4 - 1
		elseif var_75_9 == VK_RIGHT then
			var_75_7 = var_75_4 + 1
		elseif (var_75_9 == VK_SPACE or var_75_9 == VK_RETURN) and (var_75_0 < 2 or var_75_4 ~= var_75_2 or var_75_5 ~= var_75_3) then
			return var_75_4, var_75_5
		elseif var_75_9 == VK_ESCAPE then
			return nil
		elseif var_75_9 > 999999 then
			local var_75_10
			local var_75_11
			local var_75_12

			if var_75_9 > 1999999 then
				var_75_10 = 1
				var_75_9 = var_75_9 - 2000000
			else
				var_75_10 = 0
				var_75_9 = var_75_9 - 1000000
			end

			local var_75_13 = math.modf(var_75_9 / 1000)
			local var_75_14 = math.fmod(var_75_9, 1000)
			local var_75_15 = var_75_13 - CC.ScreenW / 2
			local var_75_16 = var_75_14 - CC.ScreenH / 2
			local var_75_17 = var_75_15 / CC.XScale
			local var_75_18 = var_75_16 / CC.YScale
			local var_75_19, var_75_20 = (var_75_17 + var_75_18) / 2, (var_75_18 - var_75_17) / 2

			if var_75_19 > 0 then
				var_75_19 = var_75_19 + 0.99
			else
				var_75_19 = var_75_19 - 0.01
			end

			if var_75_20 > 0 then
				var_75_20 = var_75_20 + 0.99
			else
				var_75_19 = var_75_19 - 0.01
			end

			local var_75_21 = math.modf(var_75_19)
			local var_75_22 = math.modf(var_75_20)

			for iter_75_4 = 1, CC.Kungfunum do
				if var_75_21 + iter_75_4 > 63 or var_75_22 + iter_75_4 > 63 then
					return
				end

				local var_75_23 = GetS(JY.SubScene, var_75_21 + iter_75_4, var_75_22 + iter_75_4, 4)

				if math.abs(var_75_23 - CC.YScale * iter_75_4 * 2) < 8 then
					var_75_21 = var_75_21 + iter_75_4
					var_75_22 = var_75_22 + iter_75_4
				end
			end

			var_75_7, var_75_8 = var_75_21 + var_75_2, var_75_22 + var_75_3

			if var_75_10 == 1 and (var_75_0 < 2 or var_75_4 ~= var_75_2 or var_75_5 ~= var_75_3) then
				return var_75_4, var_75_5
			end
		end

		if var_75_7 >= 0 and var_75_7 < CC.WarWidth and var_75_8 >= 0 and var_75_8 < CC.WarHeight and GetWarMap(var_75_7, var_75_8, 3) ~= nil and GetWarMap(var_75_7, var_75_8, 3) < 128 then
			var_75_4 = var_75_7
			var_75_5 = var_75_8
		end
	end
end

function WarDrawAtt(arg_76_0, arg_76_1, arg_76_2, arg_76_3, arg_76_4, arg_76_5, arg_76_6)
	local var_76_0
	local var_76_1

	if arg_76_4 == nil or arg_76_5 == nil then
		var_76_0 = WAR.Person[WAR.CurID].坐标X
		var_76_1 = WAR.Person[WAR.CurID].坐标Y
	else
		var_76_0, var_76_1 = arg_76_4, arg_76_5
	end

	local var_76_2 = arg_76_2[1]
	local var_76_3 = arg_76_2[2]
	local var_76_4 = arg_76_2[3]
	local var_76_5 = arg_76_2[4]
	local var_76_6 = arg_76_2[5]
	local var_76_7 = {}
	local var_76_8 = 0

	if var_76_2 == 0 then
		var_76_8 = 1
		var_76_7[1] = {
			arg_76_0,
			arg_76_1
		}
	elseif var_76_2 == 1 then
		var_76_3 = var_76_3 or 0
		var_76_4 = var_76_4 or 0
		var_76_8 = var_76_8 + 1
		var_76_7[var_76_8] = {
			arg_76_0,
			arg_76_1
		}

		for iter_76_0 = 1, var_76_3 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_0,
				arg_76_1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_0,
				arg_76_1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0,
				arg_76_1 + iter_76_0
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0,
				arg_76_1 - iter_76_0
			}
			var_76_8 = var_76_8 + 4
		end

		for iter_76_1 = 1, var_76_4 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_1,
				arg_76_1 + iter_76_1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_1,
				arg_76_1 - iter_76_1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0 - iter_76_1,
				arg_76_1 + iter_76_1
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0 + iter_76_1,
				arg_76_1 - iter_76_1
			}
			var_76_8 = var_76_8 + 4
		end
	elseif var_76_2 == 2 then
		for iter_76_2 = arg_76_0 - var_76_3, arg_76_0 + var_76_3 do
			for iter_76_3 = arg_76_1 - var_76_3, arg_76_1 + var_76_3 do
				if var_76_3 < math.abs(iter_76_2 - arg_76_0) + math.abs(iter_76_3 - arg_76_1) then
					-- Nothing
				else
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						iter_76_2,
						iter_76_3
					}
				end
			end
		end
	elseif var_76_2 == 3 then
		var_76_4 = var_76_4 or var_76_3

		if math.abs(arg_76_0 - var_76_0) > math.abs(arg_76_1 - var_76_1) then
			var_76_3, var_76_4 = var_76_4, var_76_3
		end

		for iter_76_4 = arg_76_0 - var_76_3, arg_76_0 + var_76_3 do
			for iter_76_5 = arg_76_1 - var_76_4, arg_76_1 + var_76_4 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_4,
					iter_76_5
				}
			end
		end
	elseif var_76_2 == 5 then
		var_76_3 = var_76_3 or 0
		var_76_4 = var_76_4 or 0
		var_76_8 = var_76_8 + 1
		var_76_7[var_76_8] = {
			arg_76_0,
			arg_76_1
		}

		for iter_76_6 = 1, var_76_3 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_6,
				arg_76_1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_6,
				arg_76_1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0,
				arg_76_1 + iter_76_6
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0,
				arg_76_1 - iter_76_6
			}
			var_76_8 = var_76_8 + 4
		end

		if var_76_4 > 0 then
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + 1,
				arg_76_1 + 1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 + 1,
				arg_76_1 - 1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0 - 1,
				arg_76_1 + 1
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0 - 1,
				arg_76_1 - 1
			}
			var_76_8 = var_76_8 + 4
		end

		for iter_76_7 = 2, var_76_4 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_7,
				arg_76_1 + 1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_7,
				arg_76_1 - 1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0 - iter_76_7,
				arg_76_1 + 1
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0 + iter_76_7,
				arg_76_1 - 1
			}
			var_76_7[var_76_8 + 5] = {
				arg_76_0 + 1,
				arg_76_1 + iter_76_7
			}
			var_76_7[var_76_8 + 6] = {
				arg_76_0 - 1,
				arg_76_1 - iter_76_7
			}
			var_76_7[var_76_8 + 7] = {
				arg_76_0 - 1,
				arg_76_1 + iter_76_7
			}
			var_76_7[var_76_8 + 8] = {
				arg_76_0 + 1,
				arg_76_1 - iter_76_7
			}
			var_76_8 = var_76_8 + 8
		end
	elseif var_76_2 == 6 then
		var_76_4 = var_76_4 or var_76_3
		var_76_7[1] = {
			arg_76_0 + 1,
			arg_76_1
		}
		var_76_7[2] = {
			arg_76_0 - 1,
			arg_76_1
		}
		var_76_7[3] = {
			arg_76_0,
			arg_76_1 + 1
		}
		var_76_7[4] = {
			arg_76_0,
			arg_76_1 - 1
		}
		var_76_8 = var_76_8 + 4

		if var_76_3 > 0 or var_76_4 > 0 then
			var_76_7[5] = {
				arg_76_0 + 1,
				arg_76_1 + 1
			}
			var_76_7[6] = {
				arg_76_0 + 1,
				arg_76_1 - 1
			}
			var_76_7[7] = {
				arg_76_0 - 1,
				arg_76_1 + 1
			}
			var_76_7[8] = {
				arg_76_0 - 1,
				arg_76_1 - 1
			}
			var_76_8 = var_76_8 + 4

			for iter_76_8 = 2, var_76_3 do
				var_76_7[var_76_8 + 1] = {
					arg_76_0 + iter_76_8,
					arg_76_1 + 1
				}
				var_76_7[var_76_8 + 2] = {
					arg_76_0 - iter_76_8,
					arg_76_1 + 1
				}
				var_76_7[var_76_8 + 3] = {
					arg_76_0 + iter_76_8,
					arg_76_1 - 1
				}
				var_76_7[var_76_8 + 4] = {
					arg_76_0 - iter_76_8,
					arg_76_1 - 1
				}
				var_76_8 = var_76_8 + 4
			end

			for iter_76_9 = 2, var_76_4 do
				var_76_7[var_76_8 + 1] = {
					arg_76_0 + 1,
					arg_76_1 + iter_76_9
				}
				var_76_7[var_76_8 + 2] = {
					arg_76_0 + 1,
					arg_76_1 - iter_76_9
				}
				var_76_7[var_76_8 + 3] = {
					arg_76_0 - 1,
					arg_76_1 + iter_76_9
				}
				var_76_7[var_76_8 + 4] = {
					arg_76_0 - 1,
					arg_76_1 - iter_76_9
				}
				var_76_8 = var_76_8 + 4
			end
		end
	elseif var_76_2 == 7 then
		var_76_4 = var_76_4 or var_76_3

		if var_76_3 == 0 then
			for iter_76_10 = arg_76_1 - var_76_4, arg_76_1 + var_76_4 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					arg_76_0,
					iter_76_10
				}
			end
		elseif var_76_4 == 0 then
			for iter_76_11 = arg_76_0 - var_76_3, arg_76_0 + var_76_3 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_11,
					arg_76_1
				}
			end
		else
			for iter_76_12 = arg_76_0 - var_76_3, arg_76_0 + var_76_3 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_12,
					arg_76_1
				}
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_12,
					arg_76_1 + var_76_4
				}
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_12,
					arg_76_1 - var_76_4
				}
			end

			for iter_76_13 = 1, var_76_4 - 1 do
				var_76_7[var_76_8 + 1] = {
					arg_76_0,
					arg_76_1 + iter_76_13
				}
				var_76_7[var_76_8 + 2] = {
					arg_76_0,
					arg_76_1 - iter_76_13
				}
				var_76_7[var_76_8 + 3] = {
					arg_76_0 - var_76_3,
					arg_76_1 + iter_76_13
				}
				var_76_7[var_76_8 + 4] = {
					arg_76_0 - var_76_3,
					arg_76_1 - iter_76_13
				}
				var_76_7[var_76_8 + 5] = {
					arg_76_0 + var_76_3,
					arg_76_1 + iter_76_13
				}
				var_76_7[var_76_8 + 6] = {
					arg_76_0 + var_76_3,
					arg_76_1 - iter_76_13
				}
				var_76_8 = var_76_8 + 6
			end
		end
	elseif var_76_2 == 8 then
		var_76_7[1] = {
			arg_76_0,
			arg_76_1
		}
		var_76_8 = 1

		for iter_76_14 = 1, var_76_3 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_14,
				arg_76_1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_14,
				arg_76_1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0,
				arg_76_1 + iter_76_14
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0,
				arg_76_1 - iter_76_14
			}
			var_76_7[var_76_8 + 5] = {
				arg_76_0 + iter_76_14,
				arg_76_1 + var_76_3
			}
			var_76_7[var_76_8 + 6] = {
				arg_76_0 - iter_76_14,
				arg_76_1 - var_76_3
			}
			var_76_7[var_76_8 + 7] = {
				arg_76_0 + var_76_3,
				arg_76_1 - iter_76_14
			}
			var_76_7[var_76_8 + 8] = {
				arg_76_0 - var_76_3,
				arg_76_1 + iter_76_14
			}
			var_76_8 = var_76_8 + 8
		end
	elseif var_76_2 == 9 then
		var_76_7[1] = {
			arg_76_0,
			arg_76_1
		}
		var_76_8 = 1

		for iter_76_15 = 1, var_76_3 do
			var_76_7[var_76_8 + 1] = {
				arg_76_0 + iter_76_15,
				arg_76_1
			}
			var_76_7[var_76_8 + 2] = {
				arg_76_0 - iter_76_15,
				arg_76_1
			}
			var_76_7[var_76_8 + 3] = {
				arg_76_0,
				arg_76_1 + iter_76_15
			}
			var_76_7[var_76_8 + 4] = {
				arg_76_0,
				arg_76_1 - iter_76_15
			}
			var_76_7[var_76_8 + 5] = {
				arg_76_0 - iter_76_15,
				arg_76_1 + var_76_3
			}
			var_76_7[var_76_8 + 6] = {
				arg_76_0 + iter_76_15,
				arg_76_1 - var_76_3
			}
			var_76_7[var_76_8 + 7] = {
				arg_76_0 + var_76_3,
				arg_76_1 + iter_76_15
			}
			var_76_7[var_76_8 + 8] = {
				arg_76_0 - var_76_3,
				arg_76_1 - iter_76_15
			}
			var_76_8 = var_76_8 + 8
		end
	elseif arg_76_0 == var_76_0 and arg_76_1 == var_76_1 then
		return 0
	elseif var_76_2 == 10 then
		var_76_4 = var_76_4 or 0
		var_76_5 = var_76_5 or 0
		var_76_6 = var_76_6 or 0

		local var_76_9 = arg_76_0 - var_76_0
		local var_76_10 = arg_76_1 - var_76_1

		if var_76_9 > 0 then
			var_76_9 = 1
		elseif var_76_9 < 0 then
			var_76_9 = -1
		end

		if var_76_10 > 0 then
			var_76_10 = 1
		elseif var_76_10 < 0 then
			var_76_10 = -1
		end

		local var_76_11 = -var_76_10
		local var_76_12 = var_76_9
		local var_76_13 = var_76_10
		local var_76_14 = -var_76_9
		local var_76_15 = -(var_76_11 + var_76_9) / 2
		local var_76_16 = -(var_76_13 + var_76_9) / 2
		local var_76_17 = -(var_76_12 + var_76_10) / 2
		local var_76_18 = -(var_76_14 + var_76_10) / 2

		if var_76_15 > 0 then
			var_76_15 = 1
		elseif var_76_15 < 0 then
			var_76_15 = -1
		end

		if var_76_16 > 0 then
			var_76_16 = 1
		elseif var_76_16 < 0 then
			var_76_16 = -1
		end

		if var_76_17 > 0 then
			var_76_17 = 1
		elseif var_76_17 < 0 then
			var_76_17 = -1
		end

		if var_76_18 > 0 then
			var_76_18 = 1
		elseif var_76_18 < 0 then
			var_76_18 = -1
		end

		for iter_76_16 = 0, var_76_3 - 1 do
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + iter_76_16 * var_76_9,
				arg_76_1 + iter_76_16 * var_76_10
			}
		end

		for iter_76_17 = 0, var_76_4 - 1 do
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + var_76_15 + iter_76_17 * var_76_9,
				arg_76_1 + var_76_17 + iter_76_17 * var_76_10
			}
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + var_76_16 + iter_76_17 * var_76_9,
				arg_76_1 + var_76_18 + iter_76_17 * var_76_10
			}
		end

		for iter_76_18 = 0, var_76_5 - 1 do
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + 2 * var_76_15 + iter_76_18 * var_76_9,
				arg_76_1 + 2 * var_76_17 + iter_76_18 * var_76_10
			}
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + 2 * var_76_16 + iter_76_18 * var_76_9,
				arg_76_1 + 2 * var_76_18 + iter_76_18 * var_76_10
			}
		end

		for iter_76_19 = 0, var_76_6 - 1 do
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + 3 * var_76_15 + iter_76_19 * var_76_9,
				arg_76_1 + 3 * var_76_17 + iter_76_19 * var_76_10
			}
			var_76_8 = var_76_8 + 1
			var_76_7[var_76_8] = {
				arg_76_0 + 3 * var_76_16 + iter_76_19 * var_76_9,
				arg_76_1 + 3 * var_76_18 + iter_76_19 * var_76_10
			}
		end
	elseif var_76_2 == 11 then
		local var_76_19 = arg_76_0 - var_76_0
		local var_76_20 = arg_76_1 - var_76_1

		if var_76_19 > 1 then
			var_76_19 = 1
		elseif var_76_19 < -1 then
			var_76_19 = -1
		end

		if var_76_20 > 1 then
			var_76_20 = 1
		elseif var_76_20 < -1 then
			var_76_20 = -1
		end

		local var_76_21 = -var_76_20
		local var_76_22 = var_76_19
		local var_76_23 = var_76_20
		local var_76_24 = -var_76_19

		if var_76_19 ~= 0 and var_76_20 ~= 0 then
			var_76_21 = -(var_76_21 + var_76_19) / 2
			var_76_23 = -(var_76_23 + var_76_19) / 2
			var_76_22 = -(var_76_22 + var_76_20) / 2
			var_76_24 = -(var_76_24 + var_76_20) / 2
			var_76_3 = math.modf(var_76_3 * 0.7071)

			for iter_76_20 = 0, var_76_3 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					arg_76_0 + iter_76_20 * var_76_19,
					arg_76_1 + iter_76_20 * var_76_20
				}

				for iter_76_21 = 1, 2 * iter_76_20 + 1 do
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_20 * var_76_19 + iter_76_21 * var_76_21,
						arg_76_1 + iter_76_20 * var_76_20 + iter_76_21 * var_76_22
					}
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_20 * var_76_19 + iter_76_21 * var_76_23,
						arg_76_1 + iter_76_20 * var_76_20 + iter_76_21 * var_76_24
					}
				end
			end
		else
			for iter_76_22 = 0, var_76_3 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					arg_76_0 + iter_76_22 * var_76_19,
					arg_76_1 + iter_76_22 * var_76_20
				}

				for iter_76_23 = 1, var_76_3 - iter_76_22 do
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_22 * var_76_19 + iter_76_23 * var_76_21,
						arg_76_1 + iter_76_22 * var_76_20 + iter_76_23 * var_76_22
					}
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_22 * var_76_19 + iter_76_23 * var_76_23,
						arg_76_1 + iter_76_22 * var_76_20 + iter_76_23 * var_76_24
					}
				end
			end
		end
	elseif var_76_2 == 12 then
		local var_76_25 = arg_76_0 - var_76_0
		local var_76_26 = arg_76_1 - var_76_1

		if var_76_25 > 1 then
			var_76_25 = 1
		elseif var_76_25 < -1 then
			var_76_25 = -1
		end

		if var_76_26 > 1 then
			var_76_26 = 1
		elseif var_76_26 < -1 then
			var_76_26 = -1
		end

		local var_76_27 = -var_76_26
		local var_76_28 = var_76_25
		local var_76_29 = var_76_26
		local var_76_30 = -var_76_25

		if var_76_25 ~= 0 and var_76_26 ~= 0 then
			var_76_27 = (var_76_27 + var_76_25) / 2
			var_76_29 = (var_76_29 + var_76_25) / 2
			var_76_28 = (var_76_28 + var_76_26) / 2
			var_76_30 = (var_76_30 + var_76_26) / 2
			var_76_3 = math.modf(var_76_3 * 1.41421)

			for iter_76_24 = 0, var_76_3 do
				if iter_76_24 <= var_76_3 / 2 then
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_24 * var_76_25,
						arg_76_1 + iter_76_24 * var_76_26
					}
				end

				for iter_76_25 = 1, var_76_3 - iter_76_24 * 2 do
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_24 * var_76_25 + iter_76_25 * var_76_27,
						arg_76_1 + iter_76_24 * var_76_26 + iter_76_25 * var_76_28
					}
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_24 * var_76_25 + iter_76_25 * var_76_29,
						arg_76_1 + iter_76_24 * var_76_26 + iter_76_25 * var_76_30
					}
				end
			end
		else
			for iter_76_26 = 0, var_76_3 do
				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					arg_76_0 + iter_76_26 * var_76_25,
					arg_76_1 + iter_76_26 * var_76_26
				}

				for iter_76_27 = 1, iter_76_26 do
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_26 * var_76_25 + iter_76_27 * var_76_27,
						arg_76_1 + iter_76_26 * var_76_26 + iter_76_27 * var_76_28
					}
					var_76_8 = var_76_8 + 1
					var_76_7[var_76_8] = {
						arg_76_0 + iter_76_26 * var_76_25 + iter_76_27 * var_76_29,
						arg_76_1 + iter_76_26 * var_76_26 + iter_76_27 * var_76_30
					}
				end
			end
		end
	elseif var_76_2 == 13 then
		local var_76_31 = arg_76_0 - var_76_0
		local var_76_32 = arg_76_1 - var_76_1

		if var_76_31 > 1 then
			var_76_31 = 1
		elseif var_76_31 < -1 then
			var_76_31 = -1
		end

		if var_76_32 > 1 then
			var_76_32 = 1
		elseif var_76_32 < -1 then
			var_76_32 = -1
		end

		local var_76_33 = arg_76_0 + var_76_31 * var_76_3
		local var_76_34 = arg_76_1 + var_76_32 * var_76_3

		for iter_76_28 = var_76_33 - var_76_3, var_76_33 + var_76_3 do
			for iter_76_29 = var_76_34 - var_76_3, var_76_34 + var_76_3 do
				if var_76_3 < math.abs(iter_76_28 - var_76_33) + math.abs(iter_76_29 - var_76_34) then
					break
				end

				var_76_8 = var_76_8 + 1
				var_76_7[var_76_8] = {
					iter_76_28,
					iter_76_29
				}
			end
		end
	else
		return 0
	end

	if arg_76_3 == 1 then
		local function var_76_35(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
			local var_77_0 = arg_77_0 - arg_77_2
			local var_77_1 = arg_77_1 - arg_77_3
			local var_77_2 = lib.GetS(JY.SubScene, arg_77_0, arg_77_1, 4)

			return CC.ScreenW / 2 + CC.XScale * (var_77_0 - var_77_1), CC.ScreenH / 2 + CC.YScale * (var_77_0 + var_77_1) - var_77_2
		end

		for iter_76_30 = 1, var_76_8 do
			if var_76_7[iter_76_30][1] >= 0 and var_76_7[iter_76_30][1] < CC.WarWidth and var_76_7[iter_76_30][2] >= 0 and var_76_7[iter_76_30][2] < CC.WarHeight then
				local var_76_36, var_76_37 = var_76_35(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], var_76_0, var_76_1)

				if GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2) ~= nil and GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2) >= 0 and GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2) ~= WAR.CurID then
					if not instruct_16(WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号) and ybdw(WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号) == false and WAR.Person[WAR.CurID].我方 then
						local var_76_38 = WAR.Person[WAR.CurID].坐标X
						local var_76_39 = WAR.Person[WAR.CurID].坐标Y
						local var_76_40 = var_76_7[iter_76_30][1] - var_76_38
						local var_76_41 = var_76_7[iter_76_30][2] - var_76_39
						local var_76_42 = CC.Fontbig
						local var_76_43 = CC.XScale * (var_76_40 - var_76_41) + CC.ScreenW / 2
						local var_76_44 = CC.YScale * (var_76_40 + var_76_41) + CC.ScreenH / 2 - GetS(JY.SubScene, var_76_40 + var_76_38, var_76_41 + var_76_39, 4) - CC.ScreenH / 4

						if var_76_44 < 1 then
							var_76_44 = 1
						end

						local var_76_45 = RGB(245, 251, 5)
						local var_76_46 = JY.Person[WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号].生命
						local var_76_47 = JY.Person[WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号].生命最大值
						local var_76_48 = JY.Person[WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号].受伤程度
						local var_76_49 = JY.Person[WAR.Person[GetWarMap(var_76_7[iter_76_30][1], var_76_7[iter_76_30][2], 2)].人物编号].中毒程度
						local var_76_50 = var_76_43 - #string.format("%d/%d", var_76_46, var_76_47) * var_76_42 / 4

						if var_76_48 < 33 then
							var_76_45 = RGB(236, 200, 40)
						elseif var_76_48 < 66 then
							var_76_45 = RGB(244, 128, 32)
						else
							var_76_45 = RGB(232, 32, 44)
						end

						DrawString(var_76_50, var_76_44, string.format("%d", var_76_46), var_76_45, var_76_42)
						DrawString(var_76_50 + #string.format("%d", var_76_46) * var_76_42 / 2, var_76_44, "/", C_GOLD, var_76_42)

						if var_76_49 == 0 then
							var_76_45 = RGB(252, 148, 16)
						elseif var_76_49 < 50 then
							var_76_45 = RGB(120, 208, 88)
						else
							var_76_45 = RGB(56, 136, 36)
						end

						DrawString(var_76_50 + #string.format("%d", var_76_46) * var_76_42 / 2 + var_76_42 / 2, var_76_44, string.format("%d", var_76_47), var_76_45, var_76_42)
					end

					lib.PicLoadCache(0, 0, var_76_36, var_76_37, 2, 200)
				else
					lib.PicLoadCache(0, 0, var_76_36, var_76_37, 2, 112)
				end
			end
		end
	elseif arg_76_3 == 2 then
		local var_76_51 = WAR.Person[WAR.CurID].我方
		local var_76_52 = 0

		for iter_76_31 = 1, var_76_8 do
			if var_76_7[iter_76_31][1] >= 0 and var_76_7[iter_76_31][1] < CC.WarWidth and var_76_7[iter_76_31][2] >= 0 and var_76_7[iter_76_31][2] < CC.WarHeight then
				local var_76_53 = GetWarMap(var_76_7[iter_76_31][1], var_76_7[iter_76_31][2], 2)

				if var_76_53 ~= -1 and var_76_53 ~= WAR.CurID then
					local var_76_54
					local var_76_55
					local var_76_56
					local var_76_57 = var_76_51 ~= WAR.Person[var_76_53].我方 and 2 or GetS(0, 0, 0, 0) == 1 and -0.5 or 0
					local var_76_58 = JY.Person[WAR.Person[var_76_53].人物编号].生命
					local var_76_59 = var_76_58 < arg_76_6 / 6 and 2 or var_76_58 < arg_76_6 / 3 and 1 or 0
					local var_76_60 = JY.Person[WAR.Person[var_76_53].人物编号].内力最大值 / 500

					var_76_52 = var_76_52 + var_76_57 * math.modf(var_76_59 * var_76_60 + 5)
				end
			end
		end

		return var_76_52
	elseif arg_76_3 == 3 then
		for iter_76_32 = 1, var_76_8 do
			if var_76_7[iter_76_32][1] >= 0 and var_76_7[iter_76_32][1] < CC.WarWidth and var_76_7[iter_76_32][2] >= 0 and var_76_7[iter_76_32][2] < CC.WarHeight then
				SetWarMap(var_76_7[iter_76_32][1], var_76_7[iter_76_32][2], 4, 1)
			end
		end
	end
end

function WarMain(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	WarLoad(arg_78_0)

	local var_78_0 = Rnd(2)

	if arg_78_3 == 1 then
		local var_78_1 = JY.Base.人X1
		local var_78_2 = JY.Base.人Y1

		for iter_78_0 = 1, 6 do
			if var_78_0 == 1 then
				WAR.Data["我方X" .. iter_78_0] = var_78_1 + 2
				WAR.Data["我方Y" .. iter_78_0] = var_78_2
				WAR.Person[WAR.PersonNum].人方向 = 1
			else
				WAR.Data["我方X" .. iter_78_0] = var_78_1 - 2
				WAR.Data["我方Y" .. iter_78_0] = var_78_2
				WAR.Person[WAR.PersonNum].人方向 = 2
			end
		end
	end

	if arg_78_3 == 1 then
		local var_78_3 = JY.Base.人X1
		local var_78_4 = JY.Base.人Y1

		for iter_78_1 = 1, 20 do
			if var_78_0 == 1 then
				WAR.Data["敌方X" .. iter_78_1] = var_78_3 + 3
				WAR.Data["敌方Y" .. iter_78_1] = var_78_4
				WAR.Person[WAR.PersonNum].人方向 = 1
			else
				WAR.Data["敌方X" .. iter_78_1] = var_78_3 - 3
				WAR.Data["敌方Y" .. iter_78_1] = var_78_4
				WAR.Person[WAR.PersonNum].人方向 = 2
			end
		end
	end

	WarSelectTeam()
	WarSelectEnemy()

	if JY.Restart == 1 then
		return false
	end

	CleanMemory()
	lib.PicInit()
	lib.ShowSlow(20, 1)
	WarLoadMap(WAR.Data.地图)

	if arg_78_2 ~= 1 then
		JY.SubScene = WAR.Data.地图
	end

	for iter_78_2 = 0, CC.WarWidth - 1 do
		for iter_78_3 = 0, CC.WarHeight - 1 do
			lib.SetWarMap(iter_78_2, iter_78_3, 0, lib.GetS(JY.SubScene, iter_78_2, iter_78_3, 0))
			lib.SetWarMap(iter_78_2, iter_78_3, 1, lib.GetS(JY.SubScene, iter_78_2, iter_78_3, 1))
		end
	end

	local var_78_5 = {
		15,
		50,
		62,
		81,
		102,
		105,
		126,
		131
	}
	local var_78_6 = Rnd(8)

	if JY.SubScene < 0 then
		JY.SubScene = var_78_5[var_78_6]
	end

	if WAR.ZDDH == 42 then
		SetS(2, 24, 31, 1, 0)
		SetS(2, 30, 34, 1, 0)
		SetS(2, 27, 27, 1, 0)
	end

	if WAR.ZDDH == 238 then
		for iter_78_4 = 24, 34 do
			for iter_78_5 = 24, 34 do
				lib.SetWarMap(iter_78_4, iter_78_5, 0, 1030)
			end
		end

		for iter_78_6 = 23, 35 do
			lib.SetWarMap(23, iter_78_6, 1, 1174)
			lib.SetWarMap(35, iter_78_6, 1, 1174)
		end

		for iter_78_7 = 24, 35 do
			lib.SetWarMap(iter_78_7, 35, 1, 1174)
			lib.SetWarMap(iter_78_7, 23, 1, 1174)
		end

		lib.SetWarMap(23, 23, 0, 1174)
		lib.SetWarMap(35, 35, 0, 1174)
		lib.SetWarMap(23, 35, 0, 1174)
		lib.SetWarMap(35, 23, 0, 1174)
		lib.SetWarMap(23, 23, 1, 2960)
		lib.SetWarMap(35, 35, 1, 2960)
		lib.SetWarMap(23, 35, 1, 2960)
		lib.SetWarMap(35, 23, 1, 2960)
	end

	if WAR.ZDDH == 54 then
		lib.SetWarMap(11, 36, 1, 2)
	end

	JY.Status = GAME_WMAP

	lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 800 * 100, 0, 100))
	lib.LoadPNGPath(CC.HeadPath, 99, CC.HeadNum, 26.923076923)
	lib.LoadPNGPath(CC.DzPath, 91, CC.DzNum, limitX(CC.ScreenW / 800 * 200, 0, CC.ScreenW))
	lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 0)
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)

	local var_78_7 = 0
	local var_78_8

	WarPersonSort()
	CleanWarMap(2, -1)
	CleanWarMap(6, -2)

	for iter_78_8 = 0, WAR.PersonNum - 1 do
		if iter_78_8 == 0 then
			WAR.Person[iter_78_8].坐标X, WAR.Person[iter_78_8].坐标Y = WE_xy(WAR.Person[iter_78_8].坐标X, WAR.Person[iter_78_8].坐标Y)
		else
			WAR.Person[iter_78_8].坐标X, WAR.Person[iter_78_8].坐标Y = WE_xy(WAR.Person[iter_78_8].坐标X, WAR.Person[iter_78_8].坐标Y, iter_78_8)
		end

		SetWarMap(WAR.Person[iter_78_8].坐标X, WAR.Person[iter_78_8].坐标Y, 2, iter_78_8)

		local var_78_9 = WAR.Person[iter_78_8].人物编号

		lib.PicLoadFile(string.format(CC.FightPicFile[1], JY.Person[var_78_9].头像代号), string.format(CC.FightPicFile[2], JY.Person[var_78_9].头像代号), 4 + iter_78_8)
	end

	local function var_78_10(arg_79_0)
		if arg_79_0 > 150 then
			return 5 + (arg_79_0 - 150) / 100
		elseif arg_79_0 > 70 then
			return 3 + (arg_79_0 - 70) / 40
		elseif arg_79_0 > 30 then
			return 1 + (arg_79_0 - 30) / 20
		else
			return arg_79_0 / 10
		end
	end

	local function var_78_11(arg_80_0, arg_80_1)
		local var_80_0 = (arg_80_0 * 2 + arg_80_1) / 3

		if var_80_0 > 4000 then
			return 8 + (var_80_0 - 4000) / 1000
		elseif var_80_0 > 2400 then
			return 6 + (var_80_0 - 2400) / 800
		elseif var_80_0 > 1200 then
			return 4 + (var_80_0 - 1200) / 600
		elseif var_80_0 > 400 then
			return 2 + (var_80_0 - 400) / 400
		else
			return var_80_0 / 200
		end
	end

	local function var_78_12(arg_81_0, arg_81_1)
		return math.modf(1.5 * (arg_81_0 / arg_81_1 + arg_81_1 - 3))
	end

	for iter_78_9 = 0, WAR.PersonNum - 1 do
		WAR.Person[iter_78_9].贴图 = WarCalPersonPic(iter_78_9)
	end

	WarSetPerson()

	WAR.CurID = 0

	WarDrawMap(0)
	lib.ShowSlow(50, 0)

	for iter_78_10 = 0, WAR.PersonNum - 1 do
		local var_78_13 = WAR.Person[iter_78_10].人物编号

		WAR.Person[iter_78_10].Time = 800 - iter_78_10 * 1000 / WAR.PersonNum

		if cxtd(var_78_13, 79) then
			local var_78_14 = 0

			for iter_78_11 = 1, CC.Kungfunum do
				if JY.Wugong[JY.Person[79]["武功" .. iter_78_11]].武功类型 == 2 and JY.Person[var_78_13]["武功等级" .. iter_78_11] == 999 then
					var_78_14 = var_78_14 + 1
				end
			end

			WAR.Person[iter_78_10].Time = WAR.Person[iter_78_10].Time + var_78_14 * 50
		end

		if WAR.Person[iter_78_10].Time > 990 then
			WAR.Person[iter_78_10].Time = 990
		end

		if cxtd(var_78_13, 592) then
			WAR.Person[iter_78_10].Time = 999
		end

		if cxtd(var_78_13, 97) then
			WAR.Person[iter_78_10].Time = 900
		end

		if JY.Person[WAR.Person[iter_78_10].人物编号].性别 ~= 2 or WAR.Person[iter_78_10].人物编号 == 0 and GetS(86, 15, 15, 5) == 1 or cxtd(var_78_13, 19) or cxtd(var_78_13, 27) or cxtd(var_78_13, 189) then
			-- Nothing
		else
			WAR.Person[iter_78_10].Time = -200
		end

		if cxtd(var_78_13, 36) then
			WAR.Person[iter_78_10].Time = 700
		end

		if cxtd(var_78_13, 132) and JY.Person[var_78_13].防具 == 230 then
			WAR.Person[iter_78_10].Time = 990
		end

		if cxtd(var_78_13, 14) then
			WAR.Person[iter_78_10].Time = WAR.Person[iter_78_10].Time + 200
		end

		local var_78_15 = WAR.Person[iter_78_10].人物编号

		if JY.Person[var_78_15].性别 == 5 then
			WAR.Person[iter_78_10].Time = 990
		end

		if cxtd(var_78_13, 5006) then
			WAR.Person[iter_78_10].Time = WAR.Person[iter_78_10].Time + 400
		end

		if var_78_13 == 445 and WAR.ZDDH == 226 then
			WAR.Person[iter_78_10].Time = 500
		end

		local var_78_16 = WAR.Person[iter_78_10].人物编号

		if PersonKF(var_78_16, 93) then
			if JY.Person[var_78_16].主功体 == 93 then
				WAR.Person[iter_78_10].Time = WAR.Person[iter_78_10].Time + 300 + math.random(100)
			else
				WAR.Person[iter_78_10].Time = WAR.Person[iter_78_10].Time + 150 + math.random(50)
			end
		end

		if WAR.Person[iter_78_10].Time > 990 then
			WAR.Person[iter_78_10].Time = 990
		end

		if cxtd(var_78_13, 35) then
			WAR.Person[iter_78_10].Time = 998
		end

		if WAR.ZDDH == 95 then
			JY.Person[87].姓名 = "苏荃"
		end

		if WAR.ZDDH == 458 or WAR.ZDDH == 463 then
			JY.Person[169].姓名 = "玄悲"
		end

		if WAR.ZDDH == 278 then
			JY.Wugong[114].名称 = "莽牛劲"

			for iter_78_12 = 659, 676 do
				JY.Person[iter_78_12].姓名 = "燕云十八骑"
				JY.Person[iter_78_12].生命增长 = 11

				instruct_48(iter_78_12, 300)

				JY.Person[iter_78_12].内力 = 3000
				JY.Person[iter_78_12].内力最大值 = 3000
				JY.Person[iter_78_12].攻击力 = 300
				JY.Person[iter_78_12].轻功 = 300
				JY.Person[iter_78_12].防御力 = 300
				JY.Person[iter_78_12].实战 = 800
				JY.Person[iter_78_12].武功1 = 172
				JY.Person[iter_78_12].武功等级1 = 900
			end
		end

		if WAR.ZDDH == 279 then
			for iter_78_13 = 659, 678 do
				JY.Person[iter_78_13].主功体 = 108
				JY.Person[iter_78_13].姓名 = "少林罗汉营"
				JY.Person[iter_78_13].生命增长 = 89

				instruct_48(iter_78_13, 8000)

				JY.Person[iter_78_13].内力 = 9000
				JY.Person[iter_78_13].内力最大值 = 9000
				JY.Person[iter_78_13].攻击力 = 300
				JY.Person[iter_78_13].轻功 = 300
				JY.Person[iter_78_13].防御力 = 300
				JY.Person[iter_78_13].武功1 = 22
				JY.Person[iter_78_13].武功等级1 = 999
			end
		end

		if WAR.ZDDH == 545 then
			JY.Wugong[114].名称 = "五行轮转"

			for iter_78_14 = 659, 678 do
				JY.Person[iter_78_14].姓名 = "五行众&营"
				JY.Person[iter_78_14].生命增长 = 86

				instruct_48(iter_78_14, 8000)

				JY.Person[iter_78_14].内力 = 8000
				JY.Person[iter_78_14].内力最大值 = 8000

				if iter_78_14 >= 659 and iter_78_14 <= 662 then
					JY.Person[iter_78_14].武功1 = 165
					JY.Person[iter_78_14].武功等级1 = 800
				elseif iter_78_14 >= 663 and iter_78_14 <= 666 then
					JY.Person[iter_78_14].武功1 = 146
					JY.Person[iter_78_14].武功等级1 = 800
				elseif iter_78_14 >= 667 and iter_78_14 <= 670 then
					JY.Person[iter_78_14].武功1 = 5
					JY.Person[iter_78_14].武功等级1 = 999
				elseif iter_78_14 >= 671 and iter_78_14 <= 674 then
					JY.Person[iter_78_14].武功1 = 65
					JY.Person[iter_78_14].武功等级1 = 800
				elseif iter_78_14 >= 675 and iter_78_14 <= 678 then
					JY.Person[iter_78_14].武功1 = 74
					JY.Person[iter_78_14].武功等级1 = 800
				end
			end

			JY.Wugong[165].名称 = "五行金行"
			JY.Wugong[165].流血 = 10
			JY.Wugong[165].迟缓 = 0
			JY.Wugong[165].冰冻 = 0
			JY.Wugong[165].火毒 = 0
			JY.Wugong[165].封穴 = 0
			JY.Wugong[146].名称 = "五行木行"
			JY.Wugong[146].流血 = 0
			JY.Wugong[146].迟缓 = 10
			JY.Wugong[146].冰冻 = 0
			JY.Wugong[146].火毒 = 0
			JY.Wugong[146].封穴 = 0
			JY.Wugong[146].内伤 = 0
			JY.Wugong[5].名称 = "五行水行"
			JY.Wugong[5].流血 = 0
			JY.Wugong[5].迟缓 = 0
			JY.Wugong[5].冰冻 = 10
			JY.Wugong[5].火毒 = 0
			JY.Wugong[5].封穴 = 0
			JY.Wugong[65].名称 = "五行火行"
			JY.Wugong[65].流血 = 0
			JY.Wugong[65].迟缓 = 0
			JY.Wugong[65].冰冻 = 0
			JY.Wugong[65].火毒 = 10
			JY.Wugong[65].封穴 = 0
			JY.Wugong[74].名称 = "五行土行"
			JY.Wugong[74].流血 = 0
			JY.Wugong[74].迟缓 = 0
			JY.Wugong[74].冰冻 = 0
			JY.Wugong[74].火毒 = 0
			JY.Wugong[74].封穴 = 10
		end
	end

	for iter_78_15 = 0, WAR.PersonNum - 1 do
		for iter_78_16 = 1, 4 do
			if JY.Person[WAR.Person[iter_78_15].人物编号]["携带物品数量" .. iter_78_16] == nil or JY.Person[WAR.Person[iter_78_15].人物编号]["携带物品数量" .. iter_78_16] < 1 then
				JY.Person[WAR.Person[iter_78_15].人物编号]["携带物品" .. iter_78_16] = -1
				JY.Person[WAR.Person[iter_78_15].人物编号]["携带物品数量" .. iter_78_16] = 0
			end
		end
	end

	if WAR.ZDDH == 14 then
		say("妙风使！", 173, 0)
		say("流云使！", 174, 1)
		say("辉月使！圣火三绝阵！", 175, 5)

		for iter_78_17 = 1, 40 do
			NewDrawString(-1, -1, "圣火三绝阵", C_GOLD, CC.DefaultFont + iter_78_17 * 2)
			ShowScreen()

			if iter_78_17 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	if WAR.ZDDH == 15 then
		for iter_78_18 = 1, 40 do
			NewDrawString(-1, -1, "光明圣火阵", C_GOLD, CC.DefaultFont + iter_78_18 * 2)
			ShowScreen()

			if iter_78_18 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	if WAR.ZDDH == 545 then
		for iter_78_19 = 1, 40 do
			NewDrawString(-1, -1, "大光明五行阵", C_GOLD, CC.DefaultFont + iter_78_19 * 2)
			ShowScreen()

			if iter_78_19 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	for iter_78_20 = 0, WAR.PersonNum - 1 do
		local var_78_17 = WAR.Person[iter_78_20].人物编号

		if cxtd(var_78_17, 92) and WAR.Person[iter_78_20].我方 == true then
			WAR.LRZ = 1
		end
	end

	if WAR.ZDDH == 10 then
		for iter_78_21 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_78_21].我方 == true then
				WAR.Person[iter_78_21].Time = 0
			end
		end
	end

	if WAR.ZDDH == 238 then
		for iter_78_22 = 1, 40 do
			NewDrawString(-1, -1, "华山论剑", C_GOLD, CC.DefaultFont + iter_78_22 * 2)
			ShowScreen()

			if iter_78_22 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	if WAR.ZDDH == 73 then
		for iter_78_23 = 1, 40 do
			NewDrawString(-1, -1, "天罡北斗阵", C_GOLD, CC.DefaultFont + iter_78_23 * 2)
			ShowScreen()

			if iter_78_23 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	if WAR.ZDDH == 458 or WAR.ZDDH == 462 or WAR.ZDDH == 463 then
		for iter_78_24 = 1, 40 do
			NewDrawString(-1, -1, "金刚伏魔阵", C_GOLD, CC.DefaultFont + iter_78_24 * 2)
			ShowScreen()

			if iter_78_24 == 40 then
				lib.Delay(1500)
			else
				lib.Delay(1)
			end
		end
	end

	for iter_78_25 = 0, WAR.PersonNum - 1 do
		if instruct_16(WAR.Person[iter_78_25].人物编号) and PersonKF(WAR.Person[iter_78_25].人物编号, 104) and PersonKF(WAR.Person[iter_78_25].人物编号, 107) == false then
			WAR.L_NYZH[WAR.Person[iter_78_25].人物编号] = 1
		end
	end

	for iter_78_26 = 0, WAR.PersonNum - 1 do
		local var_78_18 = WAR.Person[iter_78_26].人物编号

		if not instruct_16(var_78_18) and not ybdw(var_78_18) then
			if JY.Base.游戏难度 == 1 then
				WAR.ZYZ[var_78_18] = 100
			elseif JY.Base.游戏难度 == 2 then
				WAR.ZYZ[var_78_18] = 105
			elseif JY.Base.游戏难度 == 3 then
				WAR.ZYZ[var_78_18] = 110
			elseif JY.Base.游戏难度 == 4 then
				WAR.ZYZ[var_78_18] = 115
			else
				WAR.ZYZ[var_78_18] = 120
			end
		end

		if instruct_16(var_78_18) or ybdw(var_78_18) then
			WAR.ZYZ[var_78_18] = 100
		end

		if JY.Base.畅想编号 == 112 then
			WAR.ZYZ[0] = 120
		end

		WAR.ZYZ[93] = 100

		if JY.Base.畅想编号 == 133 then
			WAR.ZYZ[0] = 110
		end

		WAR.ZYZ[592] = 80
		WAR.ZYZ[26] = 100
	end

	if JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 and JY.Base.觉醒 == 1 then
		WAR.ZYZ[0] = 120
	end

	local var_78_19 = 0

	buzhen()

	WAR.Delay = GetJiqi()

	local var_78_20, var_78_21 = lib.GetTime()

	while true do
		WarDrawMap(0)

		WAR.ShowHead = 0

		DrawTimeBar()
		lib.GetKey()
		ShowScreen()

		if WAR.ZYHB == 1 then
			WAR.ZYHB = 2
		end

		local var_78_22 = false

		for iter_78_27 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_78_27].死亡 == false and WAR.Person[iter_78_27].Time > 1000 then
				WarDrawMap(0)
				ShowScreen()

				local var_78_23 = lib.GetKey()

				if WAR.AutoFight == 1 and (var_78_23 == VK_SPACE or var_78_23 == VK_RETURN) then
					WAR.AutoFight = 0
				end

				local var_78_24 = true
				local var_78_25 = WAR.Person[iter_78_27].人物编号

				if WAR.ZYHB == 2 then
					WAR.Person[iter_78_27].移动步数 = 0
				elseif WAR.L_NOT_MOVE[WAR.Person[iter_78_27].人物编号] ~= nil and WAR.L_NOT_MOVE[WAR.Person[iter_78_27].人物编号] == 1 then
					WAR.Person[iter_78_27].移动步数 = 0
					WAR.L_NOT_MOVE[WAR.Person[iter_78_27].人物编号] = nil
				else
					local var_78_26 = WAR.Person[iter_78_27].轻功
					local var_78_27 = 0

					if JY.Person[iter_78_27].主运轻功 > 0 then
						for iter_78_28 = 1, CC.Kungfunum do
							if JY.Person[iter_78_27]["武功" .. iter_78_28] == JY.Person[iter_78_27].主运轻功 then
								local var_78_28

								var_78_28 = JY.Person[iter_78_27]["武功等级" .. iter_78_28] == 999 and 10 or JY.Person[iter_78_27]["武功等级" .. iter_78_28] / 100
							end
						end
					end

					WAR.Person[iter_78_27].移动步数 = math.modf(var_78_10(var_78_26) - JY.Person[var_78_25].中毒程度 / 50 - JY.Person[var_78_25].中冰毒 / 50 - JY.Person[var_78_25].受伤程度 / 60 + JY.Person[var_78_25].体力 / 70 - 1)

					if WAR.Person[iter_78_27].移动步数 < 1 then
						WAR.Person[iter_78_27].移动步数 = 1
					end

					if WAR.Person[iter_78_27].我方 == false then
						if JY.Base.游戏难度 > 1 then
							WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 1
						end

						if JY.Base.游戏难度 > 2 then
							WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 1
						end
					end

					for iter_78_29 = 0, WAR.PersonNum - 1 do
						local var_78_29 = WAR.Person[iter_78_29].人物编号

						if cxtd(var_78_29, 66) and WAR.Person[iter_78_29].死亡 == false and WAR.Person[iter_78_29].我方 ~= WAR.Person[iter_78_27].我方 then
							WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 - 4
						end

						if cxtd(var_78_29, 15) and WAR.Person[iter_78_29].死亡 == false and WAR.Person[iter_78_29].我方 ~= WAR.Person[iter_78_27].我方 then
							WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 - 4
						end
					end

					if WAR.Person[iter_78_27].移动步数 < 1 then
						WAR.Person[iter_78_27].移动步数 = 1
					end

					if cxtd(var_78_25, 35) or cxtd(var_78_25, 6) or cxtd(var_78_25, 97) then
						WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 3
					end

					if cxtd(var_78_25, 67) then
						WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 2
					end

					if cxtd(var_78_25, 5) and WAR.Person[iter_78_27].移动步数 < 8 then
						WAR.Person[iter_78_27].移动步数 = 8
					end

					if cxtd(var_78_25, 5117) then
						WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 2
					end

					if cxtd(var_78_25, 5118) and WAR.Person[iter_78_27].移动步数 < 5 then
						WAR.Person[iter_78_27].移动步数 = 5
					end

					if Curr_QG(var_78_25, 135) or Curr_QG(var_78_25, 140) then
						WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 1
					elseif Curr_QG(var_78_25, 132) or Curr_QG(var_78_25, 136) or Curr_QG(var_78_25, 137) or Curr_QG(var_78_25, 138) then
						WAR.Person[iter_78_27].移动步数 = WAR.Person[iter_78_27].移动步数 + 2
					end
				end

				if WAR.Person[iter_78_27].移动步数 > 10 then
					WAR.Person[iter_78_27].移动步数 = 10
				end

				WAR.ShowHead = 0

				WarDrawMap(0)

				WAR.Effect = 0
				WAR.CurID = iter_78_27
				WAR.Person[iter_78_27].TimeAdd = 0

				local var_78_30
				local var_78_31 = WAR.Person[WAR.CurID].人物编号

				WAR.Defup[var_78_31] = nil

				if cxtd(var_78_31, 53) then
					WAR.TZ_DY = 0
				end

				if cxtd(var_78_31, 29) then
					WAR.L_TBGZL = 0
				end

				if cxtd(var_78_31, 1) then
					WAR.HUFEI = 0
				end

				if cxtd(var_78_31, 35) then
					WAR.JIUPO = 0
				end

				if cxtd(var_78_31, 91) then
					WAR.QQDB = 0
				end

				if cxtd(var_78_31, 55) then
					WAR.LINGGANG = 0
				end

				if cxtd(var_78_31, 76) then
					WAR.WYY = -1
				end

				if Curr_NG(var_78_31, 100) and math.random(10) < 7 then
					WarDrawMap(0)
					CurIDTXDH(WAR.CurID, 19, 1, "先天调息", C_ORANGE)

					WAR.XTTX = 1

					War_RestMenu()

					WAR.XTTX = 0
				end

				WAR.RZWD = 0

				if (instruct_16(var_78_31) or WAR.NPC[var_78_31] ~= nil) and WAR.Person[iter_78_27].我方 then
					if WAR.L_NYZH[var_78_31] ~= nil and math.random(10) < 3 then
						local var_78_32 = War_Auto()
					elseif WAR.AutoFight == 0 and JY.Person[var_78_31].战斗控制 ~= 1 then
						local var_78_33 = War_Manual()
					else
						local var_78_34 = War_Auto()
					end
				else
					local var_78_35 = War_Auto()
				end

				if WAR.ZYHB == 1 then
					for iter_78_30 = 0, WAR.PersonNum - 1 do
						WAR.Person[iter_78_30].Time = WAR.Person[iter_78_30].Time - 15

						if WAR.Person[iter_78_30].Time > 990 then
							WAR.Person[iter_78_30].Time = 990
						end
					end

					WAR.Person[iter_78_27].Time = 1005
					WAR.ZYYD = WAR.Person[iter_78_27].移动步数
					WAR.ZYHBP = iter_78_27

					if WAR.XDXX > 0 then
						DrawStrBox(-1, -1, "血刀攻击吸取生命" .. WAR.XDXX, C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(500)
						Cls()
						ShowScreen()

						WAR.XDXX = 0
					end

					WAR.QKNY = 0

					if JY.Person[129].生命 <= 0 and WAR.WCY < 1 then
						JY.Person[129].生命 = 1
					end

					if JY.Person[65].生命 <= 0 and WAR.WCY < 1 then
						JY.Person[65].生命 = 1
					end

					if WAR.ZDDH == 128 then
						for iter_78_31 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_31].人物编号 == 553 and JY.Person[553].生命 <= 0 then
								WAR.YZB = 1
								WAR.FXDS[553] = nil
								WAR.LXZT[553] = nil
							end
						end

						if WAR.YZB == 1 then
							if WAR.YZB2 < 3 then
								WAR.YZB = 0
								WAR.YZB2 = WAR.YZB2 + 1

								say("１Ｒ负けいくざ　だが　オレうちなるとうしが　それをこばむ　これはぶもんのいちか　真田幸村　いざ　まいる", 553, 0)

								JY.Person[553].生命最大值 = JY.Person[553].生命最大值 + 100
								JY.Person[553].内力最大值 = JY.Person[553].内力最大值 + 1000
								JY.Person[553].生命 = JY.Person[553].生命最大值
								JY.Person[553].内力 = JY.Person[553].内力最大值
								JY.Person[553].中毒程度 = 0
								JY.Person[553].受伤程度 = 0
								JY.Person[553].体力 = 100
								JY.Person[553].攻击力 = JY.Person[553].攻击力 + 100
								JY.Person[553].防御力 = JY.Person[553].防御力 + 100
								JY.Person[553].轻功 = JY.Person[553].轻功 + 80
								JY.Person[553].武功1 = 66
								JY.Person[553].武功等级1 = 999

								for iter_78_32 = 0, WAR.PersonNum - 1 do
									if WAR.Person[iter_78_32].人物编号 == 553 then
										WAR.Person[iter_78_32].Time = 980
									end
								end
							elseif WAR.YZB3 == 0 then
								say("６Ｒもはや　これまでか..........", 553, 0)
								say("２（真田幸村－－－－，Ｈ真是让人钦佩的勇士啊！！！）")
								say("２（真田兄，一六一五年大阪城再会吧！Ｈ那时我的名字是......）")

								WAR.YZB3 = 1
							end
						end
					end
				else
					if WAR.ZYHB == 2 then
						WAR.ZYHB = 0
					end

					WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time - 1000

					if WAR.Person[iter_78_27].Time < -500 then
						WAR.Person[iter_78_27].Time = -500
					end

					if WAR.XDXX > 0 then
						WAR.Person[WAR.CurID].生命点数 = WAR.XDXX

						War_Show_Count(WAR.CurID, "血刀吸血")

						WAR.XDXX = 0
					end

					if JY.Person[var_78_31].流血值 >= 10 then
						local var_78_36 = math.modf(JY.Person[var_78_31].流血值 / 3) + Rnd(3)

						WAR.Person[WAR.CurID].生命点数 = AddPersonAttrib(var_78_31, "生命", -var_78_36)

						if JY.Person[var_78_31].生命 < 1 then
							JY.Person[var_78_31].生命 = 1
						end

						War_Show_Count(WAR.CurID, "回合失血")
						ShowScreen()
						lib.Delay(400)
						Cls()
						ShowScreen()
					end

					local var_78_37 = JY.Wugong[JY.Person[var_78_31].主功体].武功等级
					local var_78_38 = math.modf(JY.Person[var_78_31].抗毒能力 / 10)

					if JY.Person[var_78_31].中毒程度 >= 100 and JY.Person[var_78_31].中毒程度 <= 200 and JY.Person[var_78_31].内力 > 0 then
						if JY.Person[var_78_31].畅想级别 > 4 and JY.Person[var_78_31].畅想级别 < 100 then
							AddPersonAttrib(var_78_31, "中毒程度", -var_78_38)
						end

						if JY.Person[var_78_31].中毒程度 < 0 then
							JY.Person[var_78_31].中毒程度 = 0
						end

						AddPersonAttrib(var_78_31, "内力", -(var_78_37 + var_78_38) * 10)

						if JY.Person[var_78_31].内力 < 0 then
							JY.Person[var_78_31].内力 = 0
						end
					elseif JY.Person[var_78_31].中毒程度 > 0 and JY.Person[var_78_31].中毒程度 < 100 and JY.Person[var_78_31].内力 > 0 then
						if JY.Person[var_78_31].畅想级别 > 4 and JY.Person[var_78_31].畅想级别 < 100 then
							AddPersonAttrib(var_78_31, "中毒程度", -JY.Person[var_78_31].畅想级别 * 2 - var_78_38)
						elseif JY.Person[var_78_31].主功体 > 0 then
							AddPersonAttrib(var_78_31, "中毒程度", -var_78_37 - var_78_38)
						end

						if JY.Person[var_78_31].中毒程度 < 0 then
							JY.Person[var_78_31].中毒程度 = 0
						end

						AddPersonAttrib(var_78_31, "内力", -(var_78_37 + var_78_38) * 10)

						if JY.Person[var_78_31].内力 < 0 then
							JY.Person[var_78_31].内力 = 0
						end
					end

					if JY.Person[var_78_31].中毒程度 > 60 then
						local var_78_39 = Rnd(JY.Person[var_78_31].中毒程度 / 50)
						local var_78_40 = math.modf(var_78_39)

						WAR.Person[WAR.CurID].生命点数 = AddPersonAttrib(var_78_31, "生命", -var_78_40)

						if JY.Person[var_78_31].生命 < 1 then
							JY.Person[var_78_31].生命 = 1
						end

						War_Show_Count(WAR.CurID, "回合失血")
						ShowScreen()
						lib.Delay(400)
						Cls()
						ShowScreen()
					end

					for iter_78_33 = 1, CC.Kungfunum do
						if JY.Person[var_78_31]["武功" .. iter_78_33] == 96 and JY.Person[var_78_31].生命 > 0 and JY.Person[var_78_31].生命最大值 > JY.Person[var_78_31].生命 then
							local var_78_41

							if JY.Person[var_78_31].主功体 == 96 then
								var_78_41 = math.modf((JY.Person[var_78_31].生命最大值 - JY.Person[var_78_31].生命) * 0.1)
							else
								var_78_41 = math.modf((JY.Person[var_78_31].生命最大值 - JY.Person[var_78_31].生命) * 0.05)
							end

							if var_78_41 > 50 then
								var_78_41 = 50
							end

							AddPersonAttrib(var_78_31, "生命", var_78_41)
							DrawStrBox(-1, -1, "罗汉伏魔功恢复生命" .. var_78_41, C_ORANGE, CC.DefaultFont)
							ShowScreen()
							lib.Delay(400)
							Cls()
							ShowScreen()
						end
					end

					for iter_78_34 = 1, CC.Kungfunum do
						if JY.Person[var_78_31]["武功" .. iter_78_34] == 89 and JY.Person[var_78_31].内力最大值 > JY.Person[var_78_31].内力 then
							local var_78_42

							if cxtd(var_78_31, 19) or JY.Person[var_78_31].主功体 == 89 then
								var_78_42 = math.modf((JY.Person[var_78_31].内力最大值 - JY.Person[var_78_31].内力) * 0.3)
							else
								var_78_42 = math.modf((JY.Person[var_78_31].内力最大值 - JY.Person[var_78_31].内力) * 0.1)
							end

							JY.Person[var_78_31].内力 = JY.Person[var_78_31].内力 + var_78_42

							if var_78_42 > 0 then
								DrawStrBox(-1, -1, "紫霞神功恢复内力" .. var_78_42, C_ORANGE, CC.DefaultFont)
								ShowScreen()
								lib.Delay(75)
								Cls()
								ShowScreen()
							end
						end
					end

					if cxtd(var_78_31, 27) and JY.Person[var_78_31].生命 > 0 then
						local var_78_43
						local var_78_44 = 50

						JY.Person[var_78_31].生命 = JY.Person[var_78_31].生命 + var_78_44

						if JY.Person[var_78_31].生命 > JY.Person[var_78_31].生命最大值 then
							JY.Person[var_78_31].生命 = JY.Person[var_78_31].生命最大值
						end

						DrawStrBox(-1, -1, "天人化生，回复生命值" .. var_78_44, C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(400)
						Cls()
						ShowScreen()
					end

					if cxtd(var_78_31, 190) or cxtd(var_78_31, 440) or cxtd(var_78_31, 426) or cxtd(var_78_31, 427) or cxtd(var_78_31, 428) or cxtd(var_78_31, 429) or cxtd(var_78_31, 769) or cxtd(var_78_31, 770) or cxtd(var_78_31, 771) or cxtd(var_78_31, 772) and JY.Person[var_78_31].生命 > 0 then
						local var_78_45
						local var_78_46 = 50

						JY.Person[var_78_31].生命 = JY.Person[var_78_31].生命 + var_78_46

						if JY.Person[var_78_31].生命 > JY.Person[var_78_31].生命最大值 then
							JY.Person[var_78_31].生命 = JY.Person[var_78_31].生命最大值
						end

						ShowScreen()
						lib.Delay(400)
						Cls()
						ShowScreen()
					end

					if cxtd(var_78_31, 88) then
						local var_78_47
						local var_78_48 = math.modf((JY.Person[var_78_31].内力最大值 - JY.Person[var_78_31].内力) * ((10 + math.random(20)) / 100))

						JY.Person[var_78_31].内力 = JY.Person[var_78_31].内力 + var_78_48

						DrawStrBox(-1, -1, "额外恢复内力" .. var_78_48, C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(400)
						Cls()
						ShowScreen()
					end

					if PersonKF(var_78_25, 90) then
						local var_78_49
						local var_78_50
						local var_78_51 = 0
						local var_78_52 = 6
						local var_78_53 = 5 + math.modf(JY.Person[var_78_31].受伤程度 / 10)

						WAR.Person[WAR.CurID].体力点数 = AddPersonAttrib(var_78_31, "体力", var_78_52)

						AddPersonAttrib(var_78_31, "受伤程度", -var_78_53)
						War_Show_Count(WAR.CurID, "混元功回复体力")
					end

					if JY.Person[var_78_25].主功体 == 90 then
						local var_78_54
						local var_78_55 = 300

						JY.Person[var_78_31].内力 = JY.Person[var_78_31].内力 + var_78_55

						AddPersonAttrib(var_78_31, "体力", 5)
						AddPersonAttrib(var_78_31, "受伤程度", -math.modf(JY.Person[var_78_31].受伤程度 / 5))
					end

					if JY.Person[var_78_25].主功体 == 99 then
						AddPersonAttrib(var_78_31, "受伤程度", -10)
					end

					if PersonKF(var_78_25, 95) and JY.Person[var_78_31].流血值 > 0 then
						AddPersonAttrib(var_78_31, "流血值", -15)

						if JY.Person[var_78_25].主功体 == 95 then
							AddPersonAttrib(var_78_31, "流血值", -15)

							if JY.Person[var_78_31].流血值 < 0 then
								JY.Person[var_78_31].流血值 = 0
							end
						end
					end

					local var_78_56 = 0

					if not instruct_16(var_78_31) and JY.Person[var_78_31].畅想级别 > 4 and JY.Person[var_78_31].畅想级别 < 100 then
						var_78_56 = JY.Person[var_78_31].畅想级别
					end

					if (WAR.JZPZ[var_78_25] or 0) == 0 then
						if WAR.JZPZ[var_78_25] == nil then
							WAR.JZPZ[var_78_25] = 8 + var_78_56
						else
							WAR.JZPZ[var_78_25] = WAR.JZPZ[var_78_25] + 8 + var_78_56
						end
					end

					if PersonKF(var_78_31, 104) and WAR.BJ == 1 and WAR.ZYZ[var_78_25] < 150 then
						WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] + 1

						if T1LEQ(var_78_31) then
							WAR.ZYZ[var_78_31] = WAR.ZYZ[var_78_31] + 1
						end
					end

					if WAR.ZYZ[var_78_25] < 150 and not cxtd(var_78_25, 65) then
						for iter_78_35 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_35].人物编号 == 65 and WAR.Person[iter_78_35].死亡 == false and WAR.Person[iter_78_35].我方 == WAR.Person[WAR.CurID].我方 then
								WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] + 2
							end
						end
					end

					if WAR.ZYZ[var_78_25] > 50 and not cxtd(var_78_25, 68) and not instruct_16(var_78_25) and not ybdw(var_78_25) then
						for iter_78_36 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_36].人物编号 == 68 and WAR.Person[iter_78_36].死亡 == false then
								WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] - 10
							end
						end
					end

					if WAR.ZYZ[var_78_25] > 50 then
						if cxtd(var_78_25, 186) or cxtd(var_78_25, 38) or JY.Person[var_78_25].武器 == 39 then
							WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25]
						else
							WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] - 1
						end
					end

					if cxtd(var_78_25, 38) then
						WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] + 1
					end

					if WAR.QLTY == 1 then
						WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] + 5

						if T1LEQ(var_78_31) and JY.Base.二次觉醒 == 1 then
							WAR.ZYZ[var_78_31] = WAR.ZYZ[var_78_31] + 10
						end
					end

					if cxtd(var_78_25, 0) and JY.Person[var_78_25].特殊兵器 >= 180 and JY.Base.觉醒 == 1 and PersonKF(var_78_25, 68) and WAR.ZYZ[var_78_25] < 150 then
						WAR.ZYZ[var_78_25] = WAR.ZYZ[var_78_25] + 2
					end

					if PersonKF(var_78_25, 47) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if cxtd(var_78_25, 152) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 150
					end

					if cxtd(var_78_25, 590) then
						local var_78_57 = 0

						for iter_78_37 = 1, CC.Kungfunum do
							if JY.Person[var_78_25]["武功" .. iter_78_37] >= 1 and JY.Person[var_78_25]["武功" .. iter_78_37] < 115 then
								var_78_57 = var_78_57 + 1

								if var_78_57 > 10 then
									var_78_57 = 10
								end
							end

							WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + var_78_57 * 25
						end
					end

					if WAR.XDHFJQ == 1 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 150
					end

					if JY.Person[var_78_25].主功体 == 102 and WAR.XDHFJQ == 3 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 300
					end

					if (JY.Person[var_78_25].主功体 == 107 or JY.Person[var_78_25].主功体 == 108) and WAR.XDHFJQ == 2 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if PersonKF(var_78_25, 55) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 50
					end

					if PersonKF(var_78_25, 98) and (cxtd(var_78_25, 115) or cxtd(var_78_25, 117) or cxtd(var_78_25, 118) or cxtd(var_78_25, 49)) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 100
					end

					if cxtd(var_78_25, 132) and JY.Person[var_78_25].防具 == 230 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if cxtd(var_78_25, 183) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if cxtd(var_78_25, 5007) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 50
					end

					if cxtd(var_78_25, 142) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if cxtd(var_78_25, 137) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if cxtd(var_78_25, 5008) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 100
					end

					if cxtd(var_78_25, 107) or cxtd(var_78_25, 108) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 100
					end

					if cxtd(var_78_25, 5009) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 150
					end

					if cxtd(var_78_25, 5010) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if WAR.XZZ == 1 then
						WAR.XZZ = 0
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 200
					end

					if WAR.ZSF == 1 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 400
						WAR.ZSF = 0
					end

					if cxtd(var_78_25, 38) and WAR.SAXING > 0 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + math.modf(WAR.SAXING * 200)
						WAR.SAXING = -1
					end

					if cxtd(var_78_25, 81) and WAR.ZJZ == 0 and math.random(25) == 13 then
						instruct_2(209, 1)

						WAR.ZJZ = 1
					end

					if cxtd(var_78_25, 5096) and math.random(10) == 5 then
						local var_78_58 = 20 + math.random(20)

						instruct_2(174, var_78_58)
					end

					if WAR.YQG == 1 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 100
						WAR.YQG = 0
					end

					if JY.Person[129].生命 <= 0 and WAR.WCY < 1 then
						JY.Person[129].生命 = 1
					end

					if JY.Person[65].生命 <= 0 and WAR.WCY < 1 then
						JY.Person[65].生命 = 1
					end

					if WAR.ZDDH == 128 then
						for iter_78_38 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_38].人物编号 == 553 and JY.Person[553].生命 <= 0 then
								WAR.YZB = 1
								WAR.FXDS[553] = nil
								WAR.LXZT[553] = nil
							end
						end
					end

					if WAR.YZB == 1 then
						if WAR.YZB2 < 3 then
							WAR.YZB = 0
							WAR.YZB2 = WAR.YZB2 + 1

							say("１Ｒ负けいくざ　だが　オレうちなるとうしが　それをこばむ　これはぶもんのいちか　真田幸村　いざ　まいる", 553)

							JY.Person[553].生命最大值 = JY.Person[553].生命最大值 + 100
							JY.Person[553].内力最大值 = JY.Person[553].内力最大值 + 1000
							JY.Person[553].生命 = JY.Person[553].生命最大值
							JY.Person[553].内力 = JY.Person[553].内力最大值
							JY.Person[553].中毒程度 = 0
							JY.Person[553].受伤程度 = 0
							JY.Person[553].体力 = 100
							JY.Person[553].攻击力 = JY.Person[553].攻击力 + 100
							JY.Person[553].防御力 = JY.Person[553].防御力 + 100
							JY.Person[553].轻功 = JY.Person[553].轻功 + 80
							JY.Person[553].武功1 = 66
							JY.Person[553].武功等级1 = 999

							for iter_78_39 = 0, WAR.PersonNum - 1 do
								if WAR.Person[iter_78_39].人物编号 == 553 then
									WAR.Person[iter_78_39].Time = 990
								end
							end
						else
							say("６Ｒもはや　これまでか..........", 553)
							say("２（真田幸村－－－－，Ｈ真是让人钦佩的勇士啊！！！）")
							say("２（真田兄，一六一五年大阪城再会吧！Ｈ那时我的名字是......）")
						end
					end

					if WAR.FLHS1 == 1 then
						if var_78_25 == JY.Base.队伍1 or var_78_25 == JY.Base.畅想编号 or var_78_25 == 9999 and JY.Person[var_78_25].姓名 == JY.Person[JY.Base.队伍1].姓名 then
							WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 500
						end

						WAR.FLHS1 = 0
					end

					if cxtd(var_78_25, 58) and JY.Person[var_78_25].生命 < JY.Person[var_78_25].生命最大值 / 2 and GetS(86, 11, 11, 5) == 2 then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + math.floor(JY.Person[var_78_25].生命最大值 / 2 - JY.Person[58].生命)
					end

					if Curr_QG(iter_78_27, 132) then
						WAR.Person[iter_78_27].Time = WAR.Person[iter_78_27].Time + 100

						DrawStrBox(-1, -1, "梯云纵回复集气100", C_ORANGE, CC.DefaultFont)
					end

					if cxtd(var_78_25, 97) then
						WAR.XDLZ = WAR.XDLZ + 5
					end

					if WAR.YJ > 0 then
						instruct_2(174, WAR.YJ)

						WAR.YJ = 0
					end

					WAR.ZDSXS = 1

					if WAR.KHCM[var_78_31] == 1 or WAR.KHCM[var_78_31] == 2 then
						WAR.KHCM[var_78_31] = 0

						Cls()
						DrawStrBox(-1, -1, "盲目状态恢复", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(500)
					end

					if WAR.Actup[var_78_25] ~= nil then
						WAR.Actup[var_78_25] = WAR.Actup[var_78_25] - 1
					end

					if WAR.Actup[var_78_25] == 0 then
						WAR.Actup[var_78_25] = nil
					end

					if cxtd(var_78_25, 64) then
						WAR.ZBT = WAR.ZBT + 1
					end

					if cxtd(var_78_25, 5095) then
						if WAR.tmp[var_78_25 + 10000] == nil then
							WAR.tmp[var_78_25 + 10000] = 0
						end

						WAR.tmp[var_78_25 + 10000] = WAR.tmp[var_78_25 + 10000] + 1
					end

					if WAR.TGN == 1 then
						say("１哈哈哈－－－，苗人凤，你终于死于我手了！今日方解多年之恨！", 72, 0)

						if JY.Base.畅想编号 == 72 then
							JY.Person[JY.Base.队伍1].攻击力 = JY.Person[JY.Base.队伍1].攻击力 + 80
							JY.Person[JY.Base.队伍1].防御力 = JY.Person[JY.Base.队伍1].防御力 + 80
							JY.Person[JY.Base.队伍1].轻功 = JY.Person[JY.Base.队伍1].轻功 + 50

							instruct_35(0, 0, 44, 50)
							instruct_2(136, 1)

							JY.Person[72].攻击力 = JY.Person[72].攻击力 + 80
							JY.Person[72].防御力 = JY.Person[72].防御力 + 80
							JY.Person[72].轻功 = JY.Person[72].轻功 + 50

							instruct_35(72, 0, 44, 50)
							instruct_2(136, 1)
						else
							JY.Person[72].攻击力 = JY.Person[72].攻击力 + 80
							JY.Person[72].防御力 = JY.Person[72].防御力 + 80
							JY.Person[72].轻功 = JY.Person[72].轻功 + 50

							instruct_35(72, 0, 44, 50)
							instruct_2(136, 1)
						end

						DrawStrBox(-1, -1, "田归农攻防轻能力上升并学会苗家剑法", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(1000)

						WAR.TGN = 0
					end

					WAR.QKNY = 0

					if WAR.LQZ[var_78_25] == 100 then
						WAR.LQZ[var_78_25] = 0
					end

					if WAR.XK == 1 then
						for iter_78_40 = 0, WAR.PersonNum - 1 do
							local var_78_59 = WAR.Person[iter_78_40].人物编号

							if cxtd(var_78_59, 58) and JY.Person[WAR.Person[iter_78_40].人物编号].生命 > 0 and WAR.Person[iter_78_40].我方 ~= WAR.Person[WAR.CurID].我方 then
								WAR.Person[iter_78_40].Time = 980

								say("１Ｒ龙儿－－－－－－！Ｈ５啊－－－－４－－－－３－－－－２－－－－１－－－－－－－－！！！", 58, 0)

								WAR.XK = 2
							end
						end
					end

					if WAR.JIUPO == 1 then
						local var_78_60 = WAR.CurID

						for iter_78_41 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_41].人物编号 == 35 and JY.Person[35].生命 > 0 or WAR.Person[iter_78_41].人物编号 == JY.Base.队伍1 and JY.Person[JY.Base.队伍1].生命 > 0 then
								WAR.Person[iter_78_41].Time = 400
								WAR.CurID = iter_78_41
							end
						end

						WAR.CurID = var_78_60
					end

					if WAR.FLHS5 == 1 then
						local var_78_61 = WAR.CurID

						for iter_78_42 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_42].人物编号 == JY.Base.队伍1 and JY.Person[JY.Base.队伍1].生命 > 0 then
								WAR.FLHS5 = 0
								WAR.CurID = iter_78_42
							end
						end

						WAR.FLHS5 = 0
						WAR.CurID = var_78_61
					end

					if WAR.GDZJ == 1 then
						local var_78_62 = WAR.CurID

						for iter_78_43 = 0, WAR.PersonNum - 1 do
							if (WAR.Person[iter_78_43].人物编号 == 140 or WAR.Person[iter_78_43].人物编号 == 0 and JY.Base.畅想编号 == 140) and JY.Person[140].生命 > 0 or WAR.Person[iter_78_43].人物编号 == JY.Base.队伍1 and JY.Person[JY.Base.队伍1].生命 > 0 then
								WAR.Person[iter_78_43].Time = WAR.Person[iter_78_43].Time + 200
								WAR.GDZJ = 0
								WAR.CurID = iter_78_43
							end
						end

						WAR.GDZJ = 0
						WAR.CurID = var_78_62
					end

					if (WAR.Person[iter_78_27].移动步数 > 0 or WAR.ZYYD > 0) and WAR.Person[iter_78_27].我方 == true and instruct_16(WAR.Person[iter_78_27].人物编号) and WAR.AutoFight == 0 and WAR.tmp[1000 + var_78_25] ~= 1 and JY.Person[WAR.Person[iter_78_27].人物编号].生命 > 0 and (PersonKF(WAR.Person[iter_78_27].人物编号, 93) or Curr_QG(iter_78_27, 137)) then
						if WAR.ZYYD > 0 then
							WAR.Person[iter_78_27].移动步数 = WAR.ZYYD

							War_CalMoveStep(iter_78_27, WAR.ZYYD, 0)

							WAR.ZYYD = 0
						else
							War_CalMoveStep(iter_78_27, WAR.Person[iter_78_27].移动步数, 0)
						end

						local var_78_63
						local var_78_64

						while true do
							local var_78_65, var_78_66 = War_SelectMove()

							if var_78_65 ~= nil then
								WAR.ShowHead = 0

								War_MovePerson(var_78_65, var_78_66)

								break
							end
						end
					end

					if WAR.ZDDH == 530 or WAR.ZDDH == 532 or WAR.ZDDH == 533 then
						for iter_78_44 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_44].人物编号 == 114 and JY.Person[114].生命 <= 0 then
								for iter_78_45 = 0, WAR.PersonNum - 1 do
									if inteam(iter_78_45) then
										WAR.Person[iter_78_45].我方 = true
									end
								end
							end
						end
					end

					if WAR.ZDDH == 176 and JY.Person[0].品德 > 80 and WAR.EVENT1 == 0 and WAR.SXTJ > 300 then
						for iter_78_46 = 32, 40 do
							if GetWarMap(iter_78_46, 32, 2) < 0 then
								NewWARPersonZJ(69, true, iter_78_46, 33, false, 1)

								WAR.EVENT1 = 1

								local var_78_67
								local var_78_68 = WAR.CurID

								WAR.CurID = WAR.PersonNum - 1

								say("１老叫化也来凑个热闹！", 69, 0)

								WAR.CurID = var_78_68

								break
							end
						end
					end

					if WAR.ZDDH == 299 and WAR.EVENT1 == 0 then
						for iter_78_47 = 9, 11 do
							if GetWarMap(iter_78_47, 48, 2) < 0 then
								NewWARPersonZJ(54, true, iter_78_47, 48, false, 1)

								WAR.EVENT1 = 1

								local var_78_69
								local var_78_70 = WAR.CurID

								WAR.CurID = WAR.PersonNum - 1

								say("小心，里面有两个西夏一品堂的高手！", 54, 0)

								WAR.ZYZ[54] = 110
								WAR.CurID = var_78_70

								break
							end
						end
					end

					if WAR.ZDDH == 54 and WAR.EVENT1 == 0 then
						for iter_78_48 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_48].人物编号 == 73 and WAR.Person[iter_78_48].我方 == true and JY.Person[WAR.Person[iter_78_48].人物编号].生命 <= 0 then
								for iter_78_49 = 31, 42 do
									if GetWarMap(iter_78_49, 27, 2) < 0 then
										NewWARPersonZJ(26, true, iter_78_49, 27, false, 2)

										WAR.Person[WAR.PersonNum - 1].Time = 900
										WAR.EVENT1 = 1

										local var_78_71
										local var_78_72 = WAR.CurID

										WAR.CurID = WAR.PersonNum - 1

										say("１盈盈，你先退下！为父来会会你东方阿姨，哈哈哈----", 26, 0)

										WAR.CurID = var_78_72

										break
									end
								end
							end
						end
					end

					if WAR.ZDDH == 54 and lib.GetWarMap(11, 36, 1) == 2 and instruct_16(WAR.Person[iter_78_27].人物编号) and WAR.Person[iter_78_27].坐标X == 12 and WAR.Person[iter_78_27].坐标Y == 36 then
						lib.SetWarMap(11, 36, 1, 5420)
						WarDrawMap(0)
						say("AA")
						say("OHMYGO", 27, 0)
						lib.SetWarMap(11, 36, 1, 0)
					end

					if WAR.Person[iter_78_27].Time > 500 then
						WAR.Person[iter_78_27].Time = 500
					end

					local var_78_73 = math.modf(JY.Person[JY.Base.队伍1].悟性 / 5)

					if (var_78_25 == JY.Base.队伍1 or var_78_25 == JY.Base.畅想编号 or var_78_25 == 9999 and JY.Person[var_78_25].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 7 then
						if JY.Person[JY.Base.队伍1].体力 > 50 then
							if WAR.HTSS == 0 and JY.Base.二次觉醒 == 1 and JLSD(25, 50 + var_78_73, 0) then
								CurIDTXDH(WAR.CurID, 91, 0)
								Cls()
								lib.LoadPNG(91, 12, 10, 10, 1)
								ShowScreen()
								lib.Delay(600)

								for iter_78_50 = 12, 24 do
									NewDrawString(-1, -1, ZJTF[7] .. TFSSJ[7], C_GOLD, 25 + iter_78_50)
									ShowScreen()

									if iter_78_50 == 24 then
										Cls()
										NewDrawString(-1, -1, ZJTF[7] .. TFSSJ[7], C_GOLD, 25 + iter_78_50)
										ShowScreen()
										lib.Delay(500)
									else
										lib.Delay(1)
									end
								end

								for iter_78_51 = 0, WAR.PersonNum - 1 do
									WAR.Person[iter_78_51].Time = WAR.Person[iter_78_51].Time - 10

									if WAR.Person[iter_78_51].Time > 995 then
										WAR.Person[iter_78_51].Time = 995
									end
								end

								WAR.Person[WAR.CurID].Time = 1005

								if JLSD(45, 50, 0) then
									WAR.HTSS = 0
								else
									WAR.HTSS = 1
								end
							end
						else
							WAR.HTSS = 0
						end
					end

					if JY.ZJSL == 1 then
						for iter_78_52 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_52].我方 == false then
								-- Nothing
							end
						end
					end

					if WAR.ZDDH == 10 and WAR.SXTJ > 100 then
						for iter_78_53 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_53].我方 == false then
								WAR.Person[iter_78_53].死亡 = true
							end
						end

						say("（嗯，没功夫跟这小子纠缠了）哈哈哈，小子，算你走运！老夫还有要事待办，这次就放你一马！", 18, 0)
					end

					if WAR.ZDDH == 134 and WAR.SXTJ > 20 and GetS(87, 31, 32, 5) == 1 then
						for iter_78_54 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_54].我方 == false then
								WAR.Person[iter_78_54].死亡 = true
							end
						end

						TalkEx("恭喜少侠挺过20时序，成功过关。", 269, 0)
					end

					if WAR.ZDDH == 133 and WAR.SXTJ > 20 and GetS(87, 31, 31, 5) == 1 then
						for iter_78_55 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_55].我方 == false then
								WAR.Person[iter_78_55].死亡 = true
							end
						end

						TalkEx("恭喜少侠挺过20时序，成功过关。", 269, 0)
					end

					if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 1 and WAR.SXTJ > 800 then
						for iter_78_56 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_56].我方 == false then
								WAR.Person[iter_78_56].死亡 = true
							end
						end

						Talk("呼呼~~终于闯过去了~~~少林十八铜人阵果然名不虚传~~", 0)
					end

					if WAR.ZDDH == 217 and GetS(86, 1, 2, 5) == 2 and WAR.SXTJ > 500 then
						Talk("呼呼~~好可惜，差一点就成功了。少林十八铜人阵果然名不虚传", 0)

						for iter_78_57 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_57].我方 then
								WAR.Person[iter_78_57].死亡 = true
							end
						end
					end

					if WAR.ZDDH == 238 then
						local var_78_74 = 0

						WAR.NO1 = 114

						for iter_78_58 = 0, WAR.PersonNum - 1 do
							if WAR.Person[iter_78_58].死亡 == false and JY.Person[WAR.Person[iter_78_58].人物编号].生命 > 0 then
								var_78_74 = var_78_74 + 1

								if WAR.NO1 >= WAR.Person[iter_78_58].人物编号 then
									WAR.NO1 = WAR.Person[iter_78_58].人物编号
								end
							end
						end

						if var_78_74 > 1 then
							local var_78_75 = 0
							local var_78_76 = 0

							while true do
								if var_78_75 >= 1 and var_78_76 >= 1 then
									break
								else
									var_78_75 = 0
									var_78_76 = 0
								end

								for iter_78_59 = 0, WAR.PersonNum - 1 do
									if WAR.Person[iter_78_59].死亡 == false and JY.Person[WAR.Person[iter_78_59].人物编号].生命 > 0 then
										if WAR.Person[iter_78_59].人物编号 == 0 then
											WAR.Person[iter_78_59].我方 = true
											var_78_75 = var_78_75 + 1
										elseif math.random(2) == 1 then
											WAR.Person[iter_78_59].我方 = true
											var_78_75 = var_78_75 + 1
										else
											WAR.Person[iter_78_59].我方 = false
											var_78_76 = var_78_76 + 1
										end
									end
								end
							end
						end
					end
				end
			end

			var_78_19 = War_isEnd()

			if var_78_19 > 0 then
				break
			end

			CleanMemory()
		end

		if var_78_19 > 0 then
			break
		end

		WarPersonSort(1)

		WAR.Delay = GetJiqi()

		local var_78_77 = lib.GetTime()

		collectgarbage("step", 0)
	end

	local var_78_78

	WAR.ShowHead = 0

	for iter_78_60 = 0, WAR.PersonNum - 1 do
		if WAR.tmp[4000 + iter_78_60] ~= nil then
			local var_78_79 = WAR.tmp[4000 + iter_78_60]

			JY.Person[var_78_79[1]].生命最大值 = JY.Person[var_78_79[1]].生命最大值 - var_78_79[2]
			JY.Person[var_78_79[1]].内力最大值 = JY.Person[var_78_79[1]].内力最大值 - var_78_79[3]
		end
	end

	if WAR.ZDDH == 238 then
		PlayMIDI(100)
		PlayWavAtk(41)
		DrawStrBoxWaitKey("论剑结束", C_WHITE, CC.DefaultFont)
		DrawStrBoxWaitKey("武功天下第一者：" .. JY.Person[WAR.NO1].姓名, C_RED, CC.DefaultFont)

		if WAR.NO1 == 0 then
			var_78_78 = true
		else
			var_78_78 = false
		end
	elseif var_78_19 == 1 then
		PlayMIDI(100)
		PlayWavAtk(41)
		DrawStrBoxWaitKey("战斗胜利", C_WHITE, CC.DefaultFont)

		if WAR.ZDDH == 211 then
			DrawStrBoxWaitKey("特殊奖励：令狐冲防御力和轻功各提升十点", C_GOLD, CC.DefaultFont)
			AddPersonAttrib(35, "防御力", 10)
			AddPersonAttrib(35, "轻功", 10)
		end

		if WAR.ZDDH > 498 and WAR.ZDDH < 505 or WAR.ZDDH == 277 or WAR.ZDDH == 278 then
			JY.Wugong[176].名称 = "童家流星錘"
		end

		if WAR.ZDDH == 278 then
			JY.Wugong[114].名称 = "归元功"
		end

		if WAR.ZDDH == 545 then
			JY.Wugong[114].名称 = "归元功"
			JY.Wugong[165].名称 = "奪命三仙劍"
			JY.Wugong[165].流血 = 5
			JY.Wugong[146].名称 = "摧心掌"
			JY.Wugong[146].迟缓 = 2
			JY.Wugong[146].内伤 = 5
			JY.Wugong[5].名称 = "寒冰綿掌"
			JY.Wugong[5].冰冻 = 5
			JY.Wugong[65].名称 = "燃木刀法"
			JY.Wugong[65].流血 = 5
			JY.Wugong[65].火毒 = 2
			JY.Wugong[74].名称 = "鶴蛇八打"
			JY.Wugong[74].封穴 = 7
		end

		if JY.Base.畅想编号 == 139 or instruct_16(139) then
			DrawStrBoxWaitKey("郑少爷：打得不错，赏你百两银子", C_GOLD, CC.DefaultFont)
			instruct_32(174, 1000)
		end

		if JY.Base.畅想编号 == 153 then
			DrawStrBoxWaitKey("获得毒蒺藜十颗", C_GOLD, CC.DefaultFont)
			instruct_32(32, 10)
		end

		var_78_78 = true
	elseif var_78_19 == 2 then
		DrawStrBoxWaitKey("战斗失败", C_WHITE, CC.DefaultFont)

		var_78_78 = false
	end

	War_EndPersonData(arg_78_1, var_78_19)
	lib.ShowSlow(50, 1)

	if JY.Scene[JY.SubScene].进门音乐 >= 0 then
		PlayMIDI(JY.Scene[JY.SubScene].进门音乐)
	else
		PlayMIDI(0)
	end

	CleanMemory()
	lib.PicInit()
	lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)
	lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 6, 50, 130))
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)

	JY.Status = GAME_SMAP

	return var_78_78
end

function buzhen()
	if not instruct_16(56) then
		return
	end

	if WAR.ZDDH == 238 then
		return
	end

	say("喂，要布置阵型吗？", 56, 0)

	if not DrawStrBoxYesNo(-1, -1, "要布置阵型吗", C_WHITE, CC.DefaultFont) then
		return
	end

	for iter_82_0 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_82_0].我方 then
			WAR.CurID = iter_82_0
			WAR.ShowHead = 1

			War_CalMoveStep(WAR.CurID, math.modf(JY.Person[56].等级 / 3 - 4), 0)

			local var_82_0
			local var_82_1

			while true do
				local var_82_2, var_82_3 = War_SelectMove()

				if var_82_2 ~= nil then
					WAR.ShowHead = 0

					War_MovePerson(var_82_2, var_82_3)

					break
				end
			end
		end
	end
end

function CurIDTXDH(arg_83_0, arg_83_1, arg_83_2, arg_83_3)
	local var_83_0 = WAR.Person[arg_83_0].坐标X
	local var_83_1 = WAR.Person[arg_83_0].坐标Y
	local var_83_2 = GetS(JY.SubScene, var_83_0, var_83_1, 4)

	if WAR.EFT[arg_83_1] == nil then
		lib.PicLoadFile(string.format(CC.EffectFile[1], arg_83_1), string.format(CC.EffectFile[2], arg_83_1), 70 + WAR.EFTNUM)

		WAR.EFT[arg_83_1] = 70 + WAR.EFTNUM
		WAR.EFTNUM = WAR.EFTNUM + 1

		if WAR.EFTNUM > 20 then
			WAR.EFTNUM = 0
		end
	end

	local var_83_3 = 0
	local var_83_4 = CC.Effect[arg_83_1]

	if arg_83_2 > 0 then
		var_83_3, var_83_4 = var_83_4, var_83_3
	end

	local var_83_5 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

	for iter_83_0 = var_83_3, var_83_4 do
		lib.PicLoadCache(WAR.EFT[arg_83_1], iter_83_0 * 2, CC.ScreenW / 2, CC.ScreenH / 2 - var_83_2, 2, 192)

		if arg_83_3 ~= nil then
			NewDrawString(-1, -1, arg_83_3, C_GOLD, CC.DefaultFont)
		end

		ShowScreen()
		lib.Delay(CC.Frame)
		lib.LoadSur(var_83_5, 0, 0)
	end

	lib.FreeSur(var_83_5)
	Cls()
end

function DHZFXS(arg_84_0)
	for iter_84_0 = 1, CC.Kungfunum do
		NewDrawString(-1, -1, arg_84_0, C_GOLD, CC.DefaultFont + iter_84_0)
		ShowScreen()

		if iter_84_0 == 20 then
			lib.Delay(CC.Frame)
		else
			lib.Delay(1)
			Cls()
		end
	end
end

function WE_xy(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_2 ~= nil then
		War_CalMoveStep(arg_85_2, 128, 0)
	else
		CleanWarMap(3, 0)
	end

	if GetWarMap(arg_85_0, arg_85_1, 3) ~= 255 and War_CanMoveXY(arg_85_0, arg_85_1, 0) then
		return arg_85_0, arg_85_1
	else
		for iter_85_0 = 1, 136 do
			for iter_85_1 = 1, iter_85_0 do
				local var_85_0 = iter_85_0 - iter_85_1

				if arg_85_0 + iter_85_1 < 63 and arg_85_1 + var_85_0 < 63 and GetWarMap(arg_85_0 + iter_85_1, arg_85_1 + var_85_0, 3) ~= 255 and War_CanMoveXY(arg_85_0 + iter_85_1, arg_85_1 + var_85_0, 0) then
					return arg_85_0 + iter_85_1, arg_85_1 + var_85_0
				end

				if arg_85_0 + var_85_0 < 63 and arg_85_1 - iter_85_1 > 0 and GetWarMap(arg_85_0 + var_85_0, arg_85_1 - iter_85_1, 3) ~= 255 and War_CanMoveXY(arg_85_0 + var_85_0, arg_85_1 - iter_85_1, 0) then
					return arg_85_0 + var_85_0, arg_85_1 - iter_85_1
				end

				if arg_85_0 - iter_85_1 > 0 and arg_85_1 - var_85_0 > 0 and GetWarMap(arg_85_0 - iter_85_1, arg_85_1 - var_85_0, 3) ~= 255 and War_CanMoveXY(arg_85_0 - iter_85_1, arg_85_1 - var_85_0, 0) then
					return arg_85_0 - iter_85_1, arg_85_1 - var_85_0
				end

				if arg_85_0 - var_85_0 > 0 and arg_85_1 + iter_85_1 < 63 and GetWarMap(arg_85_0 - var_85_0, arg_85_1 + iter_85_1, 3) ~= 255 and War_CanMoveXY(arg_85_0 - var_85_0, arg_85_1 + iter_85_1, 0) then
					return arg_85_0 - var_85_0, arg_85_1 + iter_85_1
				end
			end
		end
	end

	for iter_85_2 = 1, 136 do
		for iter_85_3 = 1, iter_85_2 do
			local var_85_1 = iter_85_2 - iter_85_3

			if arg_85_0 + iter_85_3 < 63 and arg_85_1 + var_85_1 < 63 and War_CanMoveXY(arg_85_0 + iter_85_3, arg_85_1 + var_85_1, 0) then
				return arg_85_0 + iter_85_3, arg_85_1 + var_85_1
			end

			if arg_85_0 + var_85_1 < 63 and arg_85_1 - iter_85_3 > 0 and War_CanMoveXY(arg_85_0 + var_85_1, arg_85_1 - iter_85_3, 0) then
				return arg_85_0 + var_85_1, arg_85_1 - iter_85_3
			end

			if arg_85_0 - iter_85_3 > 0 and arg_85_1 - var_85_1 > 0 and War_CanMoveXY(arg_85_0 - iter_85_3, arg_85_1 - var_85_1, 0) then
				return arg_85_0 - iter_85_3, arg_85_1 - var_85_1
			end

			if arg_85_0 - var_85_1 > 0 and arg_85_1 + iter_85_3 < 63 and War_CanMoveXY(arg_85_0 - var_85_1, arg_85_1 + iter_85_3, 0) then
				return arg_85_0 - var_85_1, arg_85_1 + iter_85_3
			end
		end
	end

	return arg_85_0, arg_85_1
end

function War_AnqiHurt(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0

	if JY.Person[arg_86_1].受伤程度 == 0 then
		var_86_0 = JY.Thing[arg_86_2].加生命 / 3 - Rnd(5)
	elseif JY.Person[arg_86_1].受伤程度 <= 33 then
		var_86_0 = JY.Thing[arg_86_2].加生命 / 2 - Rnd(8)
	elseif JY.Person[arg_86_1].受伤程度 <= 66 then
		var_86_0 = math.modf(JY.Thing[arg_86_2].加生命 * 2 / 3) - Rnd(12)
	else
		var_86_0 = JY.Thing[arg_86_2].加生命 - Rnd(16)
	end

	local var_86_1 = math.modf(var_86_0 - JY.Person[arg_86_0].暗器技巧 * 2)
	local var_86_2 = math.modf(var_86_1 - JY.Person[arg_86_0].内力 / 50)

	if cxtd(arg_86_0, 153) then
		var_86_2 = var_86_2 * 2
	end

	AddPersonAttrib(arg_86_1, "受伤程度", math.modf(-var_86_2 / 6))

	local var_86_3 = AddPersonAttrib(arg_86_1, "生命", math.modf(var_86_2 / 2))

	if (arg_86_1 == 129 or arg_86_1 == 65 or arg_86_1 == 153) and JY.Person[arg_86_1].生命 <= 0 then
		JY.Person[arg_86_1].生命 = 1
	end

	if arg_86_1 == 553 and JY.Person[arg_86_1].生命 <= 0 then
		WAR.YZB = 1
	end

	if JY.Thing[arg_86_2].加中毒解毒 > 0 then
		local var_86_4 = math.modf(JY.Thing[arg_86_2].加中毒解毒 + JY.Person[arg_86_0].暗器技巧 / 4) - JY.Person[arg_86_1].抗毒能力
		local var_86_5 = limitX(var_86_4, 0, CC.PersonAttribMax.用毒能力)

		AddPersonAttrib(arg_86_1, "中毒程度", var_86_5)
	end

	return var_86_3
end

function War_AutoCalMaxEnemy(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
	local var_87_0 = JY.Wugong[arg_87_2].攻击范围
	local var_87_1 = JY.Wugong[arg_87_2]["移动范围" .. arg_87_3]
	local var_87_2 = JY.Wugong[arg_87_2]["杀伤范围" .. arg_87_3]
	local var_87_3 = 0
	local var_87_4
	local var_87_5

	if var_87_0 == 0 or var_87_0 == 3 then
		local var_87_6 = War_CalMoveStep(WAR.CurID, var_87_1, 1)

		for iter_87_0 = 1, var_87_1 do
			local var_87_7 = var_87_6[iter_87_0].num

			if var_87_7 == 0 then
				break
			end

			for iter_87_1 = 1, var_87_7 do
				local var_87_8 = var_87_6[iter_87_0].x[iter_87_1]
				local var_87_9 = var_87_6[iter_87_0].y[iter_87_1]
				local var_87_10 = 0

				for iter_87_2 = 0, WAR.PersonNum - 1 do
					if iter_87_2 ~= WAR.CurID and WAR.Person[iter_87_2].死亡 == false and WAR.Person[iter_87_2].我方 ~= WAR.Person[WAR.CurID].我方 then
						local var_87_11 = math.abs(WAR.Person[iter_87_2].坐标X - var_87_8)
						local var_87_12 = math.abs(WAR.Person[iter_87_2].坐标Y - var_87_9)
					end

					if arg_87_0 <= var_87_2 and arg_87_1 <= var_87_2 then
						var_87_10 = var_87_10 + 1
					end
				end

				if var_87_3 < var_87_10 then
					var_87_3 = var_87_10
					var_87_4 = var_87_8
					var_87_5 = var_87_9
				end
			end
		end
	elseif var_87_0 == 1 then
		for iter_87_3 = 0, 3 do
			local var_87_13 = 0

			for iter_87_4 = 1, var_87_1 do
				local var_87_14 = arg_87_0 + CC.DirectX[iter_87_3 + 1] * iter_87_4
				local var_87_15 = arg_87_1 + CC.DirectY[iter_87_3 + 1] * iter_87_4

				if var_87_14 >= 0 and var_87_14 < CC.WarWidth and var_87_15 >= 0 and var_87_15 < CC.WarHeight then
					local var_87_16 = GetWarMap(var_87_14, var_87_15, 2)
				end

				if id >= 0 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[id].我方 then
					var_87_13 = var_87_13 + 1
				end
			end

			if var_87_3 < var_87_13 then
				var_87_3 = var_87_13
				var_87_4 = arg_87_0 + CC.DirectX[iter_87_3 + 1]
				var_87_5 = arg_87_1 + CC.DirectY[iter_87_3 + 1]
			end
		end
	elseif var_87_0 == 2 then
		local var_87_17 = 0

		for iter_87_5 = 0, 3 do
			for iter_87_6 = 1, var_87_1 do
				local var_87_18 = arg_87_0 + CC.DirectX[iter_87_5 + 1] * iter_87_6
				local var_87_19 = arg_87_1 + CC.DirectY[iter_87_5 + 1] * iter_87_6

				if var_87_18 >= 0 and var_87_18 < CC.WarWidth and var_87_19 >= 0 and var_87_19 < CC.WarHeight then
					local var_87_20 = GetWarMap(var_87_18, var_87_19, 2)
				end

				if id >= 0 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[id].我方 then
					var_87_17 = var_87_17 + 1
				end
			end
		end
	end

	if enemynum > 0 then
		var_87_3 = enemynum
		var_87_4 = arg_87_0
		var_87_5 = arg_87_1
	end

	return var_87_3, var_87_4, var_87_5
end

function War_AutoCalMaxEnemyMap(arg_88_0, arg_88_1)
	local var_88_0 = JY.Wugong[arg_88_0].攻击范围
	local var_88_1 = JY.Wugong[arg_88_0]["移动范围" .. arg_88_1]
	local var_88_2 = JY.Wugong[arg_88_0]["杀伤范围" .. arg_88_1]
	local var_88_3 = WAR.Person[WAR.CurID].坐标X
	local var_88_4 = WAR.Person[WAR.CurID].坐标Y

	CleanWarMap(4, 0)

	if var_88_0 == 0 or var_88_0 == 3 then
		for iter_88_0 = 0, WAR.PersonNum - 1 do
			if iter_88_0 ~= WAR.CurID and WAR.Person[iter_88_0].死亡 == false and WAR.Person[iter_88_0].我方 ~= WAR.Person[WAR.CurID].我方 then
				local var_88_5 = WAR.Person[iter_88_0].坐标X
				local var_88_6 = WAR.Person[iter_88_0].坐标Y
				local var_88_7 = War_CalMoveStep(iter_88_0, var_88_1, 1)

				for iter_88_1 = 1, var_88_1 do
					local var_88_8 = var_88_7[iter_88_1].num

					if var_88_8 == 0 then
						-- Nothing
					else
						for iter_88_2 = 1, var_88_8 do
							SetWarMap(var_88_7[iter_88_1].x[iter_88_2], var_88_7[iter_88_1].y[iter_88_2], 4, 1)
						end
					end
				end
			end
		end
	elseif var_88_0 == 1 or var_88_0 == 2 then
		for iter_88_3 = 0, WAR.PersonNum - 1 do
			if iter_88_3 ~= WAR.CurID and WAR.Person[iter_88_3].死亡 == false and WAR.Person[iter_88_3].我方 ~= WAR.Person[WAR.CurID].我方 then
				local var_88_9 = WAR.Person[iter_88_3].坐标X
				local var_88_10 = WAR.Person[iter_88_3].坐标Y

				for iter_88_4 = 0, 3 do
					for iter_88_5 = 1, var_88_1 do
						local var_88_11 = var_88_9 + CC.DirectX[iter_88_4 + 1] * iter_88_5
						local var_88_12 = var_88_10 + CC.DirectY[iter_88_4 + 1] * iter_88_5

						if var_88_11 >= 0 and var_88_11 < CC.WarWidth and var_88_12 >= 0 and var_88_12 < CC.WarHeight then
							local var_88_13 = GetWarMap(var_88_11, var_88_12, 4)

							SetWarMap(var_88_11, var_88_12, 4, var_88_13 + 1)
						end
					end
				end
			end
		end
	end
end

function War_AutoDoctor()
	local var_89_0 = WAR.Person[WAR.CurID].坐标X
	local var_89_1 = WAR.Person[WAR.CurID].坐标Y

	War_ExecuteMenu_Sub(var_89_0, var_89_1, 3, -1)
end

function War_AutoEatDrug(arg_90_0)
	local var_90_0 = WAR.Person[WAR.CurID].人物编号
	local var_90_1 = JY.Person[var_90_0].生命
	local var_90_2 = JY.Person[var_90_0].生命最大值
	local var_90_3
	local var_90_4 = math.huge
	local var_90_5
	local var_90_6
	local var_90_7

	if arg_90_0 == 2 then
		var_90_5 = JY.Person[var_90_0].生命最大值 - JY.Person[var_90_0].生命
		var_90_7 = "加生命"
	elseif arg_90_0 == 3 then
		var_90_5 = JY.Person[var_90_0].内力最大值 - JY.Person[var_90_0].内力
		var_90_7 = "加内力"
	elseif arg_90_0 == 4 then
		var_90_5 = CC.PersonAttribMax.体力 - JY.Person[var_90_0].体力
		var_90_7 = "加体力"
	elseif arg_90_0 == 6 then
		local var_90_8 = CC.PersonAttribMax.中毒程度

		var_90_5 = JY.Person[var_90_0].中毒程度
		var_90_7 = "加中毒解毒"
	else
		return
	end

	local function var_90_9(arg_91_0)
		if arg_90_0 == 6 then
			return -JY.Thing[arg_91_0][var_90_7] / 2
		else
			return JY.Thing[arg_91_0][var_90_7]
		end
	end

	if instruct_16(var_90_0) then
		local var_90_10 = 0

		for iter_90_0 = 1, CC.MyThingNum do
			local var_90_11 = JY.Base["物品" .. iter_90_0]

			if var_90_11 >= 0 then
				local var_90_12 = var_90_9(var_90_11)

				if JY.Thing[var_90_11].类型 == 3 and var_90_12 > 0 then
					local var_90_13 = var_90_5 - var_90_12

					if var_90_13 < 0 then
						var_90_10 = 1
					elseif var_90_13 < var_90_4 then
						var_90_4 = var_90_13
						var_90_3 = var_90_11
					end
				end
			end
		end

		if var_90_10 == 1 then
			var_90_4 = math.huge

			for iter_90_1 = 1, CC.MyThingNum do
				local var_90_14 = JY.Base["物品" .. iter_90_1]

				if var_90_14 >= 0 then
					local var_90_15 = var_90_9(var_90_14)

					if JY.Thing[var_90_14].类型 == 3 and var_90_15 > 0 then
						local var_90_16 = var_90_15 - var_90_5

						if var_90_16 >= 0 and var_90_16 < var_90_4 then
							var_90_4 = var_90_16
							var_90_3 = var_90_14
						end
					end
				end
			end
		end

		if UseThingEffect(var_90_3, var_90_0) == 1 then
			instruct_32(var_90_3, -1)
		end
	else
		local var_90_17 = 0

		for iter_90_2 = 1, 4 do
			local var_90_18 = JY.Person[var_90_0]["携带物品" .. iter_90_2]
			local var_90_19 = JY.Person[var_90_0]["携带物品数量" .. iter_90_2]

			if var_90_18 >= 0 and var_90_19 > 0 then
				local var_90_20 = var_90_9(var_90_18)

				if JY.Thing[var_90_18].类型 == 3 and var_90_20 > 0 then
					local var_90_21 = var_90_5 - var_90_20

					if var_90_21 < 0 then
						var_90_17 = 1
					elseif var_90_21 < var_90_4 then
						var_90_4 = var_90_21
						var_90_3 = var_90_18
					end
				end
			end
		end

		if var_90_17 == 1 then
			local var_90_22 = math.huge

			for iter_90_3 = 1, 4 do
				local var_90_23 = JY.Person[var_90_0]["携带物品" .. iter_90_3]
				local var_90_24 = JY.Person[var_90_0]["携带物品数量" .. iter_90_3]

				if var_90_23 >= 0 and var_90_24 > 0 then
					local var_90_25 = var_90_9(var_90_23)

					if JY.Thing[var_90_23].类型 == 3 and var_90_25 > 0 then
						local var_90_26 = var_90_25 - var_90_5

						if var_90_26 >= 0 and var_90_26 < var_90_22 then
							var_90_22 = var_90_26
							var_90_3 = var_90_23
						end
					end
				end
			end
		end
	end

	if UseThingEffect(var_90_3, var_90_0) == 1 then
		instruct_41(var_90_0, var_90_3, -1)
	end

	lib.Delay(500)
end

function War_AutoEscape()
	local var_92_0 = WAR.Person[WAR.CurID].人物编号

	if JY.Person[var_92_0].体力 <= 5 then
		return
	end

	local var_92_1
	local var_92_2

	War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)
	WarDrawMap(1)
	ShowScreen()

	local var_92_3 = {}
	local var_92_4 = 0

	for iter_92_0 = 0, CC.WarWidth - 1 do
		for iter_92_1 = 0, CC.WarHeight - 1 do
			if GetWarMap(iter_92_0, iter_92_1, 3) < 128 then
				local var_92_5 = math.huge

				for iter_92_2 = 0, WAR.PersonNum - 1 do
					if WAR.Person[WAR.CurID].我方 ~= WAR.Person[iter_92_2].我方 and WAR.Person[iter_92_2].死亡 == false then
						local var_92_6 = math.abs(iter_92_0 - WAR.Person[iter_92_2].坐标X)
						local var_92_7 = math.abs(iter_92_1 - WAR.Person[iter_92_2].坐标Y)

						if var_92_5 > var_92_6 + var_92_7 then
							var_92_5 = var_92_6 + var_92_7
						end
					end
				end

				var_92_4 = var_92_4 + 1
				var_92_3[var_92_4] = {}
				var_92_3[var_92_4].x = iter_92_0
				var_92_3[var_92_4].y = iter_92_1
				var_92_3[var_92_4].p = var_92_5
			end
		end
	end

	for iter_92_3 = 1, var_92_4 - 1 do
		for iter_92_4 = iter_92_3, var_92_4 do
			if var_92_3[iter_92_3].p < var_92_3[iter_92_4].p then
				var_92_3[iter_92_3], var_92_3[iter_92_4] = var_92_3[iter_92_4], var_92_3[iter_92_3]
			end
		end
	end

	for iter_92_5 = 2, var_92_4 do
		if var_92_3[iter_92_5].p < var_92_3[1].p / 2 then
			var_92_4 = iter_92_5 - 1

			break
		end
	end

	for iter_92_6 = 1, var_92_4 do
		var_92_3[iter_92_6].p = var_92_3[iter_92_6].p * 5 + GetMovePoint(var_92_3[iter_92_6].x, var_92_3[iter_92_6].y, 1)
	end

	for iter_92_7 = 1, var_92_4 - 1 do
		for iter_92_8 = iter_92_7, var_92_4 do
			if var_92_3[iter_92_7].p < var_92_3[iter_92_8].p then
				var_92_3[iter_92_7], var_92_3[iter_92_8] = var_92_3[iter_92_8], var_92_3[iter_92_7]
			end
		end
	end

	local var_92_8 = var_92_3[1].x
	local var_92_9 = var_92_3[1].y

	War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)
	War_MovePerson(var_92_8, var_92_9)
end

function War_AutoExecuteFight(arg_93_0)
	local var_93_0 = WAR.Person[WAR.CurID].人物编号
	local var_93_1 = WAR.Person[WAR.CurID].坐标X
	local var_93_2 = WAR.Person[WAR.CurID].坐标Y
	local var_93_3 = JY.Person[var_93_0]["武功" .. arg_93_0]
	local var_93_4 = math.modf(JY.Person[var_93_0]["武功等级" .. arg_93_0] / 100) + 1
	local var_93_5, var_93_6, var_93_7 = War_AutoCalMaxEnemy(var_93_1, var_93_2, var_93_3, var_93_4)

	if var_93_6 ~= nil then
		War_Fight_Sub(WAR.CurID, arg_93_0, var_93_6, var_93_7)

		WAR.Person[WAR.CurID].Action = {
			"atk",
			var_93_6 - WAR.Person[WAR.CurID].坐标X,
			var_93_7 - WAR.Person[WAR.CurID].坐标Y
		}
	end
end

function War_AutoMenu()
	WAR.AutoFight = 1
	WAR.ShowHead = 0

	Cls()
	War_Auto()

	return 1
end

function War_CalMoveStep(arg_95_0, arg_95_1, arg_95_2)
	CleanWarMap(3, 255)

	local var_95_0 = WAR.Person[arg_95_0].坐标X
	local var_95_1 = WAR.Person[arg_95_0].坐标Y
	local var_95_2 = {}

	for iter_95_0 = 0, arg_95_1 do
		var_95_2[iter_95_0] = {}
		var_95_2[iter_95_0].bushu = {}
		var_95_2[iter_95_0].x = {}
		var_95_2[iter_95_0].y = {}
	end

	SetWarMap(var_95_0, var_95_1, 3, 0)

	var_95_2[0].num = 1
	var_95_2[0].bushu[1] = arg_95_1
	var_95_2[0].x[1] = var_95_0
	var_95_2[0].y[1] = var_95_1

	War_FindNextStep(var_95_2, 0, arg_95_2, arg_95_0)

	return var_95_2
end

function War_CanMoveXY(arg_96_0, arg_96_1, arg_96_2)
	if GetWarMap(arg_96_0, arg_96_1, 1) > 0 then
		return false
	end

	if arg_96_2 == 0 then
		if CC.WarWater[GetWarMap(arg_96_0, arg_96_1, 0)] ~= nil then
			return false
		end

		if GetWarMap(arg_96_0, arg_96_1, 2) >= 0 then
			return false
		end
	end

	if arg_96_2 == 1 and WAR.HUFEI == 1 then
		if CC.WarWater[GetWarMap(arg_96_0, arg_96_1, 0)] ~= nil then
			return false
		end

		if GetWarMap(arg_96_0, arg_96_1, 2) >= 0 then
			return false
		end
	end

	return true
end

function War_DecPoisonMenu()
	WAR.ShowHead = 0

	local var_97_0 = War_ExecuteMenu(2)

	WAR.ShowHead = 1

	Cls()

	return var_97_0
end

function War_Direct(arg_98_0, arg_98_1, arg_98_2, arg_98_3)
	local var_98_0 = arg_98_2 - arg_98_0
	local var_98_1 = arg_98_3 - arg_98_1

	if var_98_0 == 0 and var_98_1 == 0 then
		return WAR.Person[WAR.CurID].人方向
	end

	if math.abs(var_98_0) < math.abs(var_98_1) then
		if var_98_1 > 0 then
			return 3
		else
			return 0
		end
	elseif var_98_0 > 0 then
		return 1
	else
		return 2
	end
end

function War_DoctorMenu()
	WAR.ShowHead = 0

	local var_99_0 = War_ExecuteMenu(3)

	WAR.ShowHead = 1

	Cls()

	return var_99_0
end

function War_ExecuteMenu(arg_100_0, arg_100_1)
	local var_100_0 = WAR.Person[WAR.CurID].人物编号
	local var_100_1

	if arg_100_0 == 1 then
		var_100_1 = math.modf(JY.Person[var_100_0].用毒能力 / 20)
	elseif arg_100_0 == 2 then
		var_100_1 = math.modf(JY.Person[var_100_0].解毒能力 / 40)
	elseif arg_100_0 == 3 then
		var_100_1 = math.modf(JY.Person[var_100_0].医疗能力 / 40)
	elseif arg_100_0 == 4 then
		var_100_1 = math.modf(JY.Person[var_100_0].暗器技巧 / 15) + 1
	end

	War_CalMoveStep(WAR.CurID, var_100_1, 1)

	local var_100_2, var_100_3 = War_SelectMove()

	if var_100_2 == nil then
		lib.GetKey()
		Cls()

		return 0
	else
		return War_ExecuteMenu_Sub(var_100_2, var_100_3, arg_100_0, arg_100_1)
	end
end

function War_FightSelectType(arg_101_0, arg_101_1, arg_101_2, arg_101_3)
	local var_101_0 = WAR.Person[WAR.CurID].坐标X
	local var_101_1 = WAR.Person[WAR.CurID].坐标Y

	if arg_101_2 == nil and arg_101_3 == nil then
		arg_101_2, arg_101_3 = War_KfMove(arg_101_0, arg_101_1)

		if arg_101_2 == nil then
			lib.GetKey()
			Cls()

			return
		end
	else
		WarDrawAtt(arg_101_2, arg_101_3, arg_101_1, 1)
		ShowScreen()
		lib.Delay(200)
	end

	if not War_Direct(var_101_0, var_101_1, arg_101_2, arg_101_3) then
		WAR.Person[WAR.CurID].人方向 = WAR.Person[WAR.CurID].人方向
	else
		WAR.Person[WAR.CurID].人方向 = War_Direct(var_101_0, var_101_1, arg_101_2, arg_101_3)
	end

	SetWarMap(arg_101_2, arg_101_3, 4, 1)

	WAR.EffectXY = {}

	return arg_101_2, arg_101_3
end

function War_FindNextStep(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
	local var_102_0 = 0
	local var_102_1 = arg_102_1 + 1

	local function var_102_2(arg_103_0, arg_103_1)
		if arg_102_2 ~= 0 or arg_102_3 == nil then
			return 0
		end

		local var_103_0 = 0
		local var_103_1 = WAR.Person[arg_102_3].我方
		local var_103_2
		local var_103_3 = GetWarMap(arg_103_0 + 1, arg_103_1, 2)

		if var_103_3 ~= -1 and WAR.Person[var_103_3].我方 ~= var_103_1 then
			var_103_0 = 9999
		end

		local var_103_4 = GetWarMap(arg_103_0 - 1, arg_103_1, 2)

		if var_103_4 ~= -1 and WAR.Person[var_103_4].我方 ~= var_103_1 then
			var_103_0 = 999
		end

		local var_103_5 = GetWarMap(arg_103_0, arg_103_1 + 1, 2)

		if var_103_5 ~= -1 and WAR.Person[var_103_5].我方 ~= var_103_1 then
			var_103_0 = 999
		end

		local var_103_6 = GetWarMap(arg_103_0, arg_103_1 - 1, 2)

		if var_103_6 ~= -1 and WAR.Person[var_103_6].我方 ~= var_103_1 then
			var_103_0 = 999
		end

		return var_103_0
	end

	for iter_102_0 = 1, arg_102_0[arg_102_1].num do
		if arg_102_0[arg_102_1].bushu[iter_102_0] > 0 then
			arg_102_0[arg_102_1].bushu[iter_102_0] = arg_102_0[arg_102_1].bushu[iter_102_0] - 1

			local var_102_3 = arg_102_0[arg_102_1].x[iter_102_0]
			local var_102_4 = arg_102_0[arg_102_1].y[iter_102_0]

			if var_102_3 + 1 < CC.WarWidth - 1 and GetWarMap(var_102_3 + 1, var_102_4, 3) == 255 and War_CanMoveXY(var_102_3 + 1, var_102_4, arg_102_2) == true then
				var_102_0 = var_102_0 + 1
				arg_102_0[var_102_1].x[var_102_0] = var_102_3 + 1
				arg_102_0[var_102_1].y[var_102_0] = var_102_4

				SetWarMap(var_102_3 + 1, var_102_4, 3, var_102_1)

				arg_102_0[var_102_1].bushu[var_102_0] = arg_102_0[arg_102_1].bushu[iter_102_0] - var_102_2(var_102_3 + 1, var_102_4)
			end

			if var_102_3 - 1 > 0 and GetWarMap(var_102_3 - 1, var_102_4, 3) == 255 and War_CanMoveXY(var_102_3 - 1, var_102_4, arg_102_2) == true then
				var_102_0 = var_102_0 + 1
				arg_102_0[var_102_1].x[var_102_0] = var_102_3 - 1
				arg_102_0[var_102_1].y[var_102_0] = var_102_4

				SetWarMap(var_102_3 - 1, var_102_4, 3, var_102_1)

				arg_102_0[var_102_1].bushu[var_102_0] = arg_102_0[arg_102_1].bushu[iter_102_0] - var_102_2(var_102_3 - 1, var_102_4)
			end

			if var_102_4 + 1 < CC.WarHeight - 1 and GetWarMap(var_102_3, var_102_4 + 1, 3) == 255 and War_CanMoveXY(var_102_3, var_102_4 + 1, arg_102_2) == true then
				var_102_0 = var_102_0 + 1
				arg_102_0[var_102_1].x[var_102_0] = var_102_3
				arg_102_0[var_102_1].y[var_102_0] = var_102_4 + 1

				SetWarMap(var_102_3, var_102_4 + 1, 3, var_102_1)

				arg_102_0[var_102_1].bushu[var_102_0] = arg_102_0[arg_102_1].bushu[iter_102_0] - var_102_2(var_102_3, var_102_4 + 1)
			end

			if var_102_4 - 1 > 0 and GetWarMap(var_102_3, var_102_4 - 1, 3) == 255 and War_CanMoveXY(var_102_3, var_102_4 - 1, arg_102_2) == true then
				var_102_0 = var_102_0 + 1
				arg_102_0[var_102_1].x[var_102_0] = var_102_3
				arg_102_0[var_102_1].y[var_102_0] = var_102_4 - 1

				SetWarMap(var_102_3, var_102_4 - 1, 3, var_102_1)

				arg_102_0[var_102_1].bushu[var_102_0] = arg_102_0[arg_102_1].bushu[iter_102_0] - var_102_2(var_102_3, var_102_4 - 1)
			end
		end
	end

	if var_102_0 == 0 then
		return
	end

	arg_102_0[var_102_1].num = var_102_0

	War_FindNextStep(arg_102_0, var_102_1, arg_102_2, arg_102_3)
end

function War_GetCanFightEnemyXY()
	local var_104_0
	local var_104_1
	local var_104_2
	local var_104_3, var_104_4, var_104_5 = War_realjl(WAR.CurID)
	local var_104_6 = var_104_5
	local var_104_7 = var_104_4

	if var_104_3 == -1 then
		return
	end

	return var_104_7, var_104_6
end

function War_MoveMenu()
	if WAR.Person[WAR.CurID].人物编号 ~= -1 then
		WAR.ShowHead = 0

		if WAR.Person[WAR.CurID].移动步数 <= 0 then
			return 0
		end

		War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)

		CC.MoveDist = 0

		local var_105_0
		local var_105_1, var_105_2 = War_SelectMove()

		if var_105_1 ~= nil then
			War_MovePerson(var_105_1, var_105_2, 1)

			local var_105_3 = 1

			CC.MoveDist = math.abs(var_105_1 - WAR.Person[WAR.CurID].坐标X) + math.abs(var_105_2 - WAR.Person[WAR.CurID].坐标Y)

			Cls()
			lib.GetKey()

			return var_105_3
		end

		if Curr_QG(WAR.CurID, 132) or Curr_QG(WAR.CurID, 137) then
			War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 1)
		elseif WAR.Person[WAR.CurID].人物编号 == 1 and WAR.HUFEI == 1 then
			War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 1)
		elseif WAR.Person[WAR.CurID].人物编号 == 0 and JY.Base.畅想编号 == 1 and WAR.HUFEI == 1 then
			War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 1)
		else
			War_CalMoveStep(WAR.CurID, WAR.Person[WAR.CurID].移动步数, 0)
		end

		local var_105_4
		local var_105_5, var_105_6 = War_SelectMove()

		if var_105_5 ~= nil then
			War_MovePerson(var_105_5, var_105_6, 1)

			var_105_4 = 1
		else
			var_105_4 = 0
			WAR.ShowHead = 1

			Cls()
		end

		lib.GetKey()

		return var_105_4
	else
		local var_105_7 = {}
		local var_105_8 = 1

		for iter_105_0 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_105_0].我方 ~= WAR.Person[WAR.CurID].我方 and WAR.Person[iter_105_0].死亡 == false then
				var_105_7[var_105_8] = iter_105_0
				var_105_8 = var_105_8 + 1
			end
		end

		local var_105_9 = var_105_7[math.random(var_105_8 - 1)]
		local var_105_10 = WAR.Person[var_105_9].坐标X
		local var_105_11 = WAR.Person[var_105_9].坐标Y
		local var_105_12 = {
			var_105_10 + 1,
			var_105_10 - 1,
			var_105_10
		}
		local var_105_13 = {
			var_105_11 + 1,
			var_105_11 - 1,
			var_105_11
		}
		local var_105_14 = var_105_12[math.random(3)]
		local var_105_15 = var_105_13[math.random(3)]

		if not SceneCanPass(var_105_14, var_105_15) or GetWarMap(var_105_14, var_105_15, 2) < 0 then
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, -1)
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, -1)

			WAR.Person[WAR.CurID].坐标X = var_105_14
			WAR.Person[WAR.CurID].坐标Y = var_105_15

			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, WAR.CurID)
			SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, WAR.Person[WAR.CurID].贴图)
		end
	end

	return 1
end

function War_MovePerson(arg_106_0, arg_106_1, arg_106_2)
	local var_106_0 = arg_106_0
	local var_106_1 = arg_106_1

	arg_106_2 = arg_106_2 or 0

	local var_106_2 = GetWarMap(arg_106_0, arg_106_1, 3)
	local var_106_3 = {}

	for iter_106_0 = var_106_2, 1, -1 do
		var_106_3[iter_106_0] = {}
		var_106_3[iter_106_0].x = arg_106_0
		var_106_3[iter_106_0].y = arg_106_1

		if GetWarMap(arg_106_0 - 1, arg_106_1, 3) == iter_106_0 - 1 then
			arg_106_0 = arg_106_0 - 1
			var_106_3[iter_106_0].direct = 1
		elseif GetWarMap(arg_106_0 + 1, arg_106_1, 3) == iter_106_0 - 1 then
			arg_106_0 = arg_106_0 + 1
			var_106_3[iter_106_0].direct = 2
		elseif GetWarMap(arg_106_0, arg_106_1 - 1, 3) == iter_106_0 - 1 then
			arg_106_1 = arg_106_1 - 1
			var_106_3[iter_106_0].direct = 3
		elseif GetWarMap(arg_106_0, arg_106_1 + 1, 3) == iter_106_0 - 1 then
			arg_106_1 = arg_106_1 + 1
			var_106_3[iter_106_0].direct = 0
		end
	end

	var_106_3.num = var_106_2
	var_106_3.now = 0
	WAR.Person[WAR.CurID].Move = var_106_3

	if var_106_2 > WAR.Person[WAR.CurID].移动步数 then
		var_106_2 = WAR.Person[WAR.CurID].移动步数
		WAR.Person[WAR.CurID].移动步数 = 0
	else
		WAR.Person[WAR.CurID].移动步数 = WAR.Person[WAR.CurID].移动步数 - var_106_2
	end

	for iter_106_1 = 1, var_106_2 do
		local var_106_4 = lib.GetTime()

		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, -1)
		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, -1)

		WAR.Person[WAR.CurID].坐标X = var_106_3[iter_106_1].x
		WAR.Person[WAR.CurID].坐标Y = var_106_3[iter_106_1].y
		WAR.Person[WAR.CurID].人方向 = var_106_3[iter_106_1].direct
		WAR.Person[WAR.CurID].贴图 = WarCalPersonPic(WAR.CurID)

		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 2, WAR.CurID)
		SetWarMap(WAR.Person[WAR.CurID].坐标X, WAR.Person[WAR.CurID].坐标Y, 5, WAR.Person[WAR.CurID].贴图)
		WarDrawMap(0)
		ShowScreen()

		local var_106_5 = lib.GetTime()

		if iter_106_1 < var_106_2 and var_106_5 - var_106_4 < 2 * CC.Frame then
			lib.Delay(2 * CC.Frame - (var_106_5 - var_106_4))
		end
	end
end

function War_PoisonMenu()
	WAR.ShowHead = 0

	local var_107_0 = War_ExecuteMenu(1)

	WAR.ShowHead = 1

	Cls()

	return var_107_0
end

function War_RestMenu()
	if WAR.CurID and WAR.CurID >= 0 then
		local var_108_0 = WAR.Person[WAR.CurID].人物编号

		if WAR.tmp[1000 + var_108_0] == 1 then
			return 1
		end

		local var_108_1 = math.modf(JY.Person[var_108_0].体力 / 100 - JY.Person[var_108_0].受伤程度 / 50 - JY.Person[var_108_0].中毒程度 / 50) - JY.Person[var_108_0].中冰毒 / 50 + 2

		if WAR.Person[WAR.CurID].移动步数 > 0 then
			var_108_1 = var_108_1 + 2
		end

		if JY.Person[var_108_0].中毒程度 < 100 or JY.Person[var_108_0].受伤程度 < 100 or JY.Person[var_108_0].中冰毒 < 100 then
			if instruct_16(var_108_0) then
				var_108_1 = var_108_1 + math.random(3)
			else
				var_108_1 = var_108_1 + 6
			end

			local var_108_2 = var_108_1 / 120
			local var_108_3 = 3 + Rnd(3)

			AddPersonAttrib(var_108_0, "体力", var_108_3)

			if JY.Person[var_108_0].体力 > 0 then
				local var_108_4 = 3 + math.modf(JY.Person[var_108_0].生命最大值 * var_108_2)

				AddPersonAttrib(var_108_0, "生命", var_108_4)

				local var_108_5 = 3 + math.modf(JY.Person[var_108_0].内力最大值 * var_108_2)

				AddPersonAttrib(var_108_0, "内力", var_108_5)
			end
		end

		if not instruct_16(var_108_0) then
			if math.modf(JY.Person[var_108_0].生命最大值 / 2) < JY.Person[var_108_0].生命 then
				return War_ActupMenu()
			else
				return War_DefupMenu()
			end
		else
			return 1
		end
	end
end

function War_StatusMenu()
	WAR.ShowHead = 0

	Menu_Status()

	WAR.ShowHead = 1

	Cls()
end

function War_ThingMenu()
	WAR.ShowHead = 0

	local var_110_0 = {}
	local var_110_1 = {}

	for iter_110_0 = 0, CC.MyThingNum - 1 do
		var_110_0[iter_110_0] = -1
		var_110_1[iter_110_0] = 0
	end

	local var_110_2 = 0

	for iter_110_1 = 0, CC.MyThingNum - 1 do
		local var_110_3 = JY.Base["物品" .. iter_110_1 + 1]

		if var_110_3 >= 0 and (JY.Thing[var_110_3].类型 == 3 or JY.Thing[var_110_3].类型 == 4) then
			var_110_0[var_110_2] = var_110_3
			var_110_1[var_110_2] = JY.Base["物品数量" .. iter_110_1 + 1]
			var_110_2 = var_110_2 + 1
		end
	end

	local var_110_4 = SelectThing(var_110_0, var_110_1)

	Cls()

	local var_110_5 = 0

	if var_110_4 >= 0 and UseThing(var_110_4) == 1 then
		var_110_5 = 1
	end

	WAR.ShowHead = 1

	Cls()

	return var_110_5
end

function War_UseThing(arg_111_0)
	return
end

function War_ThinkDoctor()
	local var_112_0 = WAR.Person[WAR.CurID].人物编号

	if JY.Person[var_112_0].体力 < 30 or JY.Person[var_112_0].医疗能力 < 50 then
		return -1
	end

	if JY.Person[var_112_0].医疗能力 + 20 < JY.Person[var_112_0].受伤程度 then
		return -1
	end

	local var_112_1 = -1
	local var_112_2 = JY.Person[var_112_0].生命最大值 - JY.Person[var_112_0].生命

	if (JY.Person[var_112_0].医疗能力 < var_112_2 / 4 and 30 or JY.Person[var_112_0].医疗能力 < var_112_2 / 3 and 50 or JY.Person[var_112_0].医疗能力 < var_112_2 / 2 and 70 or 90) > Rnd(100) then
		return 5
	end

	return -1
end

function War_ThinkDrug(arg_113_0)
	local var_113_0 = WAR.Person[WAR.CurID].人物编号
	local var_113_1
	local var_113_2 = -1

	if arg_113_0 == 2 then
		var_113_1 = "加生命"
	elseif arg_113_0 == 3 then
		var_113_1 = "加内力"
	elseif arg_113_0 == 4 then
		var_113_1 = "加体力"
	elseif arg_113_0 == 6 then
		var_113_1 = "加中毒解毒"
	else
		return var_113_2
	end

	local function var_113_3(arg_114_0)
		if arg_113_0 == 6 then
			return -JY.Thing[arg_114_0][var_113_1]
		else
			return JY.Thing[arg_114_0][var_113_1]
		end
	end

	if instruct_16(var_113_0) then
		for iter_113_0 = 1, CC.MyThingNum do
			local var_113_4 = JY.Base["物品" .. iter_113_0]

			if var_113_4 >= 0 and JY.Thing[var_113_4].类型 == 3 and var_113_3(var_113_4) > 0 then
				var_113_2 = arg_113_0

				break
			end
		end
	else
		for iter_113_1 = 1, 4 do
			local var_113_5 = JY.Person[var_113_0]["携带物品" .. iter_113_1]

			if var_113_5 >= 0 and JY.Thing[var_113_5].类型 == 3 and var_113_3(var_113_5) > 0 then
				var_113_2 = arg_113_0

				break
			end
		end
	end

	return var_113_2
end

function War_UseAnqi(arg_115_0)
	return War_ExecuteMenu(4, arg_115_0)
end

function WarLoad(arg_116_0)
	WarSetGlobal()

	local var_116_0 = Byte.create(CC.WarDataSize)

	Byte.loadfile(var_116_0, CC.WarFile, arg_116_0 * CC.WarDataSize, CC.WarDataSize)
	LoadData(WAR.Data, CC.WarData_S, var_116_0)

	WAR.ZDDH = arg_116_0

	if WAR.ZDDH == 545 then
		for iter_116_0 = 659, 678 do
			JY.Person[iter_116_0].头像代号 = 194
		end
	end

	if WAR.ZDDH == 278 then
		for iter_116_1 = 659, 678 do
			JY.Person[iter_116_1].头像代号 = 245
		end
	end

	if WAR.ZDDH == 279 then
		for iter_116_2 = 659, 678 do
			JY.Person[iter_116_2].头像代号 = 210
		end
	end
end

function WarLoadMap(arg_117_0)
	lib.Debug(string.format("load war map %d", arg_117_0))
	lib.LoadWarMap(CC.WarMapFile[1], CC.WarMapFile[2], arg_117_0, 7, CC.WarWidth, CC.WarHeight)
end

function GetWarMap(arg_118_0, arg_118_1, arg_118_2)
	if arg_118_0 > 63 or arg_118_0 < 0 or arg_118_1 > 63 or arg_118_1 < 0 then
		return
	end

	return lib.GetWarMap(arg_118_0, arg_118_1, arg_118_2)
end

function SetWarMap(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	if arg_119_0 > 63 or arg_119_0 < 0 or arg_119_1 > 63 or arg_119_1 < 0 then
		return
	end

	lib.SetWarMap(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
end

function CleanWarMap(arg_120_0, arg_120_1)
	lib.CleanWarMap(arg_120_0, arg_120_1)
end

function WarSetPerson()
	CleanWarMap(2, -1)
	CleanWarMap(5, -1)

	for iter_121_0 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_121_0].死亡 == false then
			SetWarMap(WAR.Person[iter_121_0].坐标X, WAR.Person[iter_121_0].坐标Y, 2, iter_121_0)
			SetWarMap(WAR.Person[iter_121_0].坐标X, WAR.Person[iter_121_0].坐标Y, 5, WAR.Person[iter_121_0].贴图)
		end
	end
end

function War_ShowFight(arg_122_0, arg_122_1, arg_122_2, arg_122_3, arg_122_4, arg_122_5, arg_122_6, arg_122_7)
	arg_122_7 = arg_122_7 or -1

	local var_122_0 = WAR.Person[WAR.CurID].坐标X
	local var_122_1 = WAR.Person[WAR.CurID].坐标Y

	if cxtd(arg_122_0, 592) then
		-- Nothing
	elseif arg_122_1 == 47 then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 108 and cxtd(arg_122_0, 114) then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 55 then
		arg_122_6 = 81
	end

	if arg_122_1 == 25 then
		arg_122_6 = 7
	end

	if arg_122_1 == 106 then
		arg_122_6 = 103
	end

	if arg_122_1 == 22 then
		arg_122_6 = 94
	end

	if arg_122_1 == 112 then
		arg_122_6 = 95
	end

	if arg_122_1 == 44 then
		arg_122_6 = 96
	end

	if arg_122_1 == 5 then
		arg_122_6 = 97
	end

	if arg_122_1 == 40 then
		arg_122_6 = 82
	end

	if arg_122_1 == 38 then
		arg_122_6 = 83
	end

	if arg_122_1 == 35 then
		arg_122_6 = 80
	end

	if arg_122_1 == 72 then
		arg_122_6 = 100
	end

	if arg_122_1 == 11 then
		arg_122_6 = 99
	end

	if arg_122_1 == 21 then
		arg_122_6 = 98
	end

	if arg_122_1 == 123 and JY.Person[arg_122_0].拳掌功夫 >= 100 and cxtd(arg_122_0, 0) then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 124 and JY.Person[arg_122_0].御剑能力 >= 100 and cxtd(arg_122_0, 0) then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 125 and JY.Person[arg_122_0].耍刀技巧 >= 100 and cxtd(arg_122_0, 0) then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 126 and JY.Person[arg_122_0].特殊兵器 >= 100 and cxtd(arg_122_0, 0) then
		arg_122_6 = math.random(104)
	end

	if arg_122_1 == 43 and (cxtd(arg_122_0, 51) or cxtd(arg_122_0, 113)) then
		arg_122_6 = math.random(104)
	end

	if cxtd(arg_122_0, 592) then
		arg_122_6 = WAR.L_DGQB_X < 3 and 24 or WAR.L_DGQB_X < 5 and 48 or WAR.L_DGQB_X < 7 and 10 or WAR.L_DGQB_X < 9 and 46 or WAR.L_DGQB_X < 10 and 62 or 84
	end

	local var_122_2 = -1
	local var_122_3 = -1

	if arg_122_6 == 110 then
		var_122_2, var_122_3 = arg_122_4, arg_122_5
	end

	if WAR.EFT[arg_122_6] == nil then
		lib.PicLoadFile(string.format(CC.EffectFile[1], arg_122_6), string.format(CC.EffectFile[2], arg_122_6), 70 + WAR.EFTNUM)

		WAR.EFT[arg_122_6] = 70 + WAR.EFTNUM
		WAR.EFTNUM = WAR.EFTNUM + 1

		if WAR.EFTNUM > 20 then
			WAR.EFTNUM = 0
		end
	end

	if WAR.Person[WAR.CurID].特效动画 ~= -1 then
		local var_122_4 = WAR.Person[WAR.CurID].特效动画

		if WAR.EFT[var_122_4] == nil then
			lib.PicLoadFile(string.format(CC.EffectFile[1], var_122_4), string.format(CC.EffectFile[2], var_122_4), 70 + WAR.EFTNUM)

			WAR.EFT[var_122_4] = 70 + WAR.EFTNUM
			WAR.EFTNUM = WAR.EFTNUM + 1

			if WAR.EFTNUM > 20 then
				WAR.EFTNUM = 0
			end
		end
	end

	if arg_122_1 == 49 or arg_122_1 == 92 then
		arg_122_2 = 1
	end

	local var_122_5
	local var_122_6
	local var_122_7
	local var_122_8

	if arg_122_7 >= 0 then
		var_122_5 = WAR.Person[arg_122_7].人物编号
		var_122_6 = arg_122_2
		var_122_7 = 0
		var_122_8 = 0
	end

	local var_122_9
	local var_122_10
	local var_122_11

	if arg_122_2 >= 0 then
		var_122_9 = JY.Person[arg_122_0]["出招动画延迟" .. arg_122_2 + 1]
		var_122_10 = JY.Person[arg_122_0]["出招动画帧数" .. arg_122_2 + 1]
		var_122_11 = JY.Person[arg_122_0]["武功音效延迟" .. arg_122_2 + 1]
	else
		var_122_9 = 0
		var_122_10 = -1
		var_122_11 = -1
	end

	if var_122_9 == 0 or var_122_10 == 0 then
		for iter_122_0 = 1, 5 do
			if JY.Person[arg_122_0]["出招动画帧数" .. iter_122_0] ~= 0 then
				var_122_9 = JY.Person[arg_122_0]["出招动画延迟" .. iter_122_0]
				var_122_10 = JY.Person[arg_122_0]["出招动画帧数" .. iter_122_0]
				var_122_11 = JY.Person[arg_122_0]["武功音效延迟" .. iter_122_0]
				arg_122_2 = iter_122_0 - 1
			end
		end
	end

	if arg_122_7 >= 0 then
		if JY.Person[var_122_5]["出招动画帧数" .. var_122_6 + 1] == 0 then
			for iter_122_1 = 1, 5 do
				if JY.Person[var_122_5]["出招动画帧数" .. iter_122_1] ~= 0 then
					var_122_6 = iter_122_1 - 1
					var_122_8 = JY.Person[var_122_5]["出招动画帧数" .. iter_122_1]
				end
			end
		else
			var_122_8 = JY.Person[var_122_5]["出招动画帧数" .. var_122_6 + 1]
		end
	end

	local var_122_12 = var_122_9 + CC.Effect[arg_122_6]
	local var_122_13 = 0

	if arg_122_2 >= 0 then
		for iter_122_2 = 0, arg_122_2 - 1 do
			var_122_13 = var_122_13 + 4 * JY.Person[arg_122_0]["出招动画帧数" .. iter_122_2 + 1]
		end
	end

	if arg_122_7 >= 0 and var_122_6 >= 0 then
		for iter_122_3 = 0, var_122_6 - 1 do
			var_122_7 = var_122_7 + 4 * JY.Person[var_122_5]["出招动画帧数" .. iter_122_3 + 1]
		end
	end

	local var_122_14
	local var_122_15 = 0

	WAR.Person[WAR.CurID].贴图类型 = 0
	WAR.Person[WAR.CurID].贴图 = WarCalPersonPic(WAR.CurID)

	if arg_122_7 >= 0 then
		WAR.Person[arg_122_7].贴图类型 = 0
		WAR.Person[arg_122_7].贴图 = WarCalPersonPic(arg_122_7)
	end

	local var_122_16 = WAR.Person[WAR.CurID].贴图 / 2
	local var_122_17 = 0
	local var_122_18 = -1
	local var_122_19 = JY.Wugong[arg_122_1].名称
	local var_122_20 = CC.FontBig
	local var_122_21 = CC.ScreenW / 2 - var_122_20 * string.len(var_122_19) / 4
	local var_122_22 = GetS(JY.SubScene, var_122_0, var_122_1, 4)

	if arg_122_1 ~= 0 then
		if WAR.LHQ_BNZ == 1 then
			var_122_19 = "般若掌"
		end

		if WAR.JGZ_DMZ == 1 then
			var_122_19 = "达摩掌"
		end

		if WAR.WPXJF == 1 then
			var_122_19 = "伪·辟邪剑法"
		end

		if WAR.ZTSLYZ == 1 then
			var_122_19 = "真·天山六阳掌"
		end

		if cxtd(arg_122_0, 118) and arg_122_1 == 14 then
			var_122_19 = "白虹掌力"
		end

		if arg_122_1 == 123 and JY.Person[arg_122_0].拳掌功夫 >= 100 then
			var_122_19 = "霹雳掌"

			if JY.Person[arg_122_0].拳掌功夫 >= 180 then
				var_122_19 = "电光霹雳掌"
			end
		end

		if arg_122_1 == 124 and JY.Person[arg_122_0].御剑能力 >= 100 then
			var_122_19 = "悟真剑法"

			if JY.Person[arg_122_0].御剑能力 >= 180 then
				var_122_19 = "青玉寒光剑"
			end
		end

		if arg_122_1 == 125 and JY.Person[arg_122_0].耍刀技巧 >= 100 then
			var_122_19 = "斩首刀法"

			if JY.Person[arg_122_0].耍刀技巧 >= 180 then
				var_122_19 = "麒麟吞月刀"
			end
		end
	end

	if arg_122_1 == 126 and JY.Person[arg_122_0].特殊兵器 >= 100 then
		var_122_19 = "暴雨梨花枪"

		if JY.Person[arg_122_0].特殊兵器 >= 180 then
			var_122_19 = "百战狂澜枪"
		end
	end

	if WAR.DMLHSXJ == 1 then
		var_122_19 = "夺命连环三仙剑"
	end

	if cxtd(arg_122_0, 141) and arg_122_1 == 34 then
		var_122_19 = "夺命连环三仙剑"
	end

	if arg_122_7 >= 0 then
		var_122_19 = "双人合击·" .. var_122_19
	end

	if arg_122_7 >= 0 and (arg_122_1 == 42 or arg_122_1 == 62) then
		var_122_19 = "天衣无缝·" .. var_122_19
		WAR.TYWF = 1
	end

	if arg_122_1 > 0 then
		for iter_122_4 = 5, 10 do
			if WAR.Person[WAR.CurID].特效文字0 ~= nil then
				local var_122_23, var_122_24 = Split(WAR.Person[WAR.CurID].特效文字0, "+")
				local var_122_25 = string.len(WAR.Person[WAR.CurID].特效文字0)
				local var_122_26 = RGB(255, 40, 10)
				local var_122_27 = 0

				for iter_122_5 = 1, var_122_23 do
					if var_122_24[iter_122_5] == "连击" then
						var_122_26 = M_DeepSkyBlue
					elseif var_122_24[iter_122_5] == "左右互搏" then
						var_122_26 = M_DarkOrange
					else
						var_122_26 = RGB(255, 40, 10)
					end

					if iter_122_5 > 1 then
						var_122_24[iter_122_5] = "+" .. var_122_24[iter_122_5]
					end

					KungfuString(var_122_24[iter_122_5], CC.ScreenW / 2 - (var_122_23 - 1) * var_122_25 * (CC.DefaultFont + iter_122_4 / 2) / 8 + var_122_27, CC.ScreenH / 4 - var_122_22, var_122_26, CC.DefaultFont + iter_122_4 / 2, CC.FontName, 0)

					var_122_27 = var_122_27 + string.len(var_122_24[iter_122_5]) * (CC.DefaultFont + iter_122_4 / 2) / 4 + (CC.DefaultFont + iter_122_4 / 2) * 3 / 2
				end
			end

			KungfuString(var_122_19, CC.ScreenW / 2 - #var_122_19 / 2, CC.ScreenH / 3 - var_122_22, C_GOLD, CC.FontBig + iter_122_4, CC.FontName, 0)
			ShowScreen()
			lib.Delay(2)

			if iter_122_4 == 10 then
				lib.Delay(3 * CC.Frame)
			end

			Cls()
		end
	end

	for iter_122_6 = 0, var_122_12 - 1 do
		local var_122_28 = lib.GetTime()
		local var_122_29

		if var_122_10 > 0 then
			WAR.Person[WAR.CurID].贴图类型 = 1
			var_122_29 = 4 + WAR.CurID

			if iter_122_6 < var_122_10 then
				WAR.Person[WAR.CurID].贴图 = (var_122_13 + WAR.Person[WAR.CurID].人方向 * var_122_10 + iter_122_6) * 2
			end
		else
			WAR.Person[WAR.CurID].贴图类型 = 0
			WAR.Person[WAR.CurID].贴图 = WarCalPersonPic(WAR.CurID)
			var_122_29 = 0
		end

		if arg_122_7 >= 0 then
			if var_122_8 > 0 then
				WAR.Person[arg_122_7].贴图类型 = 1

				if iter_122_6 < var_122_8 and iter_122_6 < var_122_12 - 1 then
					WAR.Person[arg_122_7].贴图 = (var_122_7 + WAR.Person[arg_122_7].人方向 * var_122_8 + iter_122_6) * 2
				else
					WAR.Person[arg_122_7].贴图 = WarCalPersonPic(arg_122_7)
				end
			else
				WAR.Person[arg_122_7].贴图类型 = 0
				WAR.Person[arg_122_7].贴图 = WarCalPersonPic(arg_122_7)
			end

			SetWarMap(WAR.Person[arg_122_7].坐标X, WAR.Person[arg_122_7].坐标Y, 5, WAR.Person[arg_122_7].贴图)
		end

		if iter_122_6 == var_122_11 then
			PlayWavAtk(JY.Wugong[arg_122_1].出招音效)
		end

		if iter_122_6 == var_122_9 then
			PlayWavE(arg_122_6)
		end

		if iter_122_6 == 1 and WAR.SSFwav == 1 then
			WAR.SSFwav = 0
		end

		if iter_122_6 == 1 and WAR.LMSJwav == 1 then
			PlayWavAtk(31)

			WAR.LMSJwav = 0
		end

		local var_122_30 = WAR.Person[WAR.CurID].贴图 / 2

		if var_122_14 == 1 then
			local var_122_31 = ClipRect(Cal_PicClip(0, 0, var_122_16, var_122_17, 0, 0, var_122_30, var_122_29))

			if var_122_31 ~= nil then
				lib.SetClip(var_122_31.x1, var_122_31.y1, var_122_31.x2, var_122_31.y2)
			end
		else
			lib.SetClip(0, 0, 0, 0)
		end

		var_122_16 = var_122_30
		var_122_17 = var_122_29

		if iter_122_6 < var_122_9 then
			WarDrawMap(4, var_122_30 * 2, var_122_29, -1)

			if iter_122_6 == 1 and WAR.Person[WAR.CurID].特效动画 ~= -1 then
				local var_122_32 = WAR.Person[WAR.CurID].特效动画
				local var_122_33 = 0
				local var_122_34 = lib.SaveSur(CC.ScreenW / 2 - 5 * CC.XScale, CC.ScreenH / 2 - var_122_22 - 18 * CC.YScale, CC.ScreenW / 2 + 5 * CC.XScale, CC.ScreenH / 2 - var_122_22 + 5 * CC.YScale)

				for iter_122_7 = 1, CC.Effect[var_122_32] do
					lib.PicLoadCache(WAR.EFT[var_122_32], (var_122_33 + iter_122_7) * 2, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, 2, 192)

					if WAR.Person[WAR.CurID].特效文字1 ~= nil then
						KungfuString(WAR.Person[WAR.CurID].特效文字1, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_RED, CC.Fontsmall, CC.FontName, 3)
					end

					if WAR.Person[WAR.CurID].特效文字2 ~= nil then
						KungfuString(WAR.Person[WAR.CurID].特效文字2, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_GOLD, CC.Fontsmall, CC.FontName, 2)
					end

					if WAR.Person[WAR.CurID].特效文字3 ~= nil then
						KungfuString(WAR.Person[WAR.CurID].特效文字3, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_WHITE, CC.Fontsmall, CC.FontName, 1)
					end

					ShowScreen()

					-- [port] this loop had no pacing at all, so the text flashed past.
					lib.Delay(CC.EffectTextMS)

					lib.LoadSur(var_122_34, CC.ScreenW / 2 - 5 * CC.XScale, CC.ScreenH / 2 - var_122_22 - 18 * CC.YScale)
				end

				lib.FreeSur(var_122_34)

				WAR.Person[WAR.CurID].特效动画 = -1
			elseif WAR.Person[WAR.CurID].特效文字1 ~= nil or WAR.Person[WAR.CurID].特效文字2 ~= nil or WAR.Person[WAR.CurID].特效文字3 ~= nil then
				KungfuString(WAR.Person[WAR.CurID].特效文字1, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_RED, CC.Fontsmall, CC.FontName, 3)
				KungfuString(WAR.Person[WAR.CurID].特效文字2, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_GOLD, CC.Fontsmall, CC.FontName, 2)
				KungfuString(WAR.Person[WAR.CurID].特效文字3, CC.ScreenW / 2, CC.ScreenH / 2 - var_122_22, C_WHITE, CC.Fontsmall, CC.FontName, 1)
				lib.Delay(40)
			end
		else
			var_122_15 = var_122_15 + 1

			if var_122_14 == 1 then
				local var_122_35 = {}
				local var_122_36 = Cal_PicClip(WAR.EffectXY[1][1] - var_122_0, WAR.EffectXY[1][2] - var_122_1, var_122_18, 3, WAR.EffectXY[1][1] - var_122_0, WAR.EffectXY[1][2] - var_122_1, var_122_15, 3)
				local var_122_37 = {}
				local var_122_38 = Cal_PicClip(WAR.EffectXY[2][1] - var_122_0, WAR.EffectXY[2][2] - var_122_1, var_122_18, 3, WAR.EffectXY[2][1] - var_122_0, WAR.EffectXY[2][2] - var_122_1, var_122_15, 3)
				local var_122_39 = ClipRect(MergeRect(var_122_36, var_122_38))

				if var_122_39 ~= nil then
					if (var_122_39.x2 - var_122_39.x1) * (var_122_39.y2 - var_122_39.y1) < CC.ScreenW * CC.ScreenH / 2 then
						WarDrawMap(4, var_122_30 * 2, var_122_29, var_122_15 * 2, nil, WAR.EFT[arg_122_6], var_122_2, var_122_3)
						lib.SetClip(var_122_39.x1, var_122_39.y1, var_122_39.x2, var_122_39.y2)
						WarDrawMap(4, var_122_30 * 2, var_122_29, var_122_15 * 2, nil, WAR.EFT[arg_122_6], var_122_2, var_122_3)
					else
						lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
						WarDrawMap(4, var_122_30 * 2, var_122_29, var_122_15 * 2, nil, WAR.EFT[arg_122_6], var_122_2, var_122_3)
					end
				else
					WarDrawMap(4, var_122_30 * 2, var_122_29, var_122_15 * 2, nil, WAR.EFT[arg_122_6], var_122_2, var_122_3)
				end
			else
				lib.SetClip(0, 0, 0, 0)
				WarDrawMap(4, var_122_30 * 2, var_122_29, var_122_15 * 2, nil, WAR.EFT[arg_122_6], var_122_2, var_122_3)
			end

			var_122_18 = var_122_15

			local var_122_40 = lib.GetTime()

			if CC.Frame - (var_122_40 - var_122_28) > 0 then
				lib.Delay(CC.Frame - (var_122_40 - var_122_28))
			end
		end

		ShowScreen(var_122_14)
		lib.SetClip(0, 0, 0, 0)

		local var_122_41 = lib.GetTime()

		if var_122_41 - var_122_28 < 1 * CC.Frame then
			lib.Delay(1 * CC.Frame - (var_122_41 - var_122_28))
		end

		lib.GetKey()
	end

	lib.SetClip(0, 0, 0, 0)

	WAR.Person[WAR.CurID].贴图类型 = 0
	WAR.Person[WAR.CurID].贴图 = WarCalPersonPic(WAR.CurID)

	WarSetPerson()
	WarDrawMap(0)
	ShowScreen()
	lib.Delay(2 * CC.Frame)
	WarDrawMap(2)
	ShowScreen()
	lib.Delay(2 * CC.Frame)
	WarDrawMap(0)
	ShowScreen()

	local var_122_42 = {}
	local var_122_43 = 0
	local var_122_44 = 12

	for iter_122_8 = 0, WAR.PersonNum - 1 do
		local var_122_45 = WAR.Person[iter_122_8].坐标X
		local var_122_46 = WAR.Person[iter_122_8].坐标Y

		if WAR.Person[iter_122_8].死亡 == false and GetWarMap(var_122_45, var_122_46, 4) > 1 then
			SetWarMap(var_122_45, var_122_46, 4, 1)

			local var_122_47 = WAR.Person[iter_122_8].生命点数
			local var_122_48 = WAR.Person[iter_122_8].内力点数
			local var_122_49 = WAR.Person[iter_122_8].体力点数
			local var_122_50 = WAR.Person[iter_122_8].中毒点数
			local var_122_51 = WAR.Person[iter_122_8].解毒点数
			local var_122_52 = WAR.Person[iter_122_8].内伤点数

			var_122_42[var_122_43] = {
				var_122_45,
				var_122_46
			}

			if var_122_47 ~= nil then
				if var_122_47 == 0 then
					var_122_42[var_122_43][3] = "Miss"
				elseif var_122_47 > 0 then
					var_122_42[var_122_43][3] = "命+" .. var_122_47
				else
					var_122_42[var_122_43][3] = "命" .. var_122_47
				end
			end

			if var_122_48 ~= nil then
				if var_122_48 > 0 then
					var_122_42[var_122_43][4] = "内+" .. var_122_48
				elseif var_122_48 == 0 then
					var_122_42[var_122_43][4] = nil
				else
					var_122_42[var_122_43][4] = "内" .. var_122_48
				end
			end

			if var_122_49 ~= nil then
				if var_122_49 > 0 then
					var_122_42[var_122_43][5] = "体+" .. var_122_49
				elseif var_122_49 == 0 then
					var_122_42[var_122_43][5] = nil
				else
					var_122_42[var_122_43][5] = "体" .. var_122_49
				end
			end

			if WAR.FXXS[WAR.Person[iter_122_8].人物编号] == 1 then
				var_122_42[var_122_43][6] = "封穴+" .. WAR.FXDS[WAR.Person[iter_122_8].人物编号]
				WAR.FXXS[WAR.Person[iter_122_8].人物编号] = 0
			end

			if WAR.LXXS[WAR.Person[iter_122_8].人物编号] == 1 then
				var_122_42[var_122_43][7] = "流血+" .. WAR.LXZT[WAR.Person[iter_122_8].人物编号]
				WAR.LXXS[WAR.Person[iter_122_8].人物编号] = 0
			end

			if WAR.JTXS[WAR.Person[iter_122_8].人物编号] == 1 then
				if WAR.JTZ[WAR.Person[iter_122_8].人物编号] > 70 then
					var_122_42[var_122_43][5] = "击退"
				else
					var_122_42[var_122_43][5] = "迟缓"
				end

				WAR.JTXS[WAR.Person[iter_122_8].人物编号] = 0
			end

			if WAR.HOTXS[WAR.Person[iter_122_8].人物编号] == 1 then
				var_122_42[var_122_43][10] = "灼烧+" .. WAR.ZSZ[WAR.Person[iter_122_8].人物编号]
				WAR.HOTXS[WAR.Person[iter_122_8].人物编号] = 0
			end

			if WAR.CHXS[WAR.Person[iter_122_8].人物编号] == 1 then
				var_122_42[var_122_43][8] = "冰封+" .. WAR.BFZ[WAR.Person[iter_122_8].人物编号]
				WAR.CHXS[WAR.Person[iter_122_8].人物编号] = 0
			end

			if var_122_50 ~= nil then
				if var_122_50 == 0 then
					var_122_42[var_122_43][9] = nil
				else
					var_122_42[var_122_43][9] = "中毒+" .. var_122_50
				end
			end

			if var_122_52 ~= nil then
				if var_122_52 == 0 then
					var_122_42[var_122_43][11] = nil
				elseif var_122_52 > 0 then
					var_122_42[var_122_43][11] = "内伤+" .. var_122_52
				end
			end

			var_122_43 = var_122_43 + 1
		end
	end

	local var_122_53 = 0
	local var_122_54 = {}

	for iter_122_9 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_122_9].特效动画 ~= -1 then
			var_122_53 = var_122_53 + 1
			var_122_54[iter_122_9] = var_122_53
		end
	end

	if var_122_53 ~= 0 then
		var_122_53 = math.modf(20 / var_122_53)
	end

	local var_122_55 = 0
	local var_122_56 = CC.ScreenW
	local var_122_57 = 0
	local var_122_58 = CC.ScreenH

	if var_122_2 < 0 and var_122_3 < 0 then
		for iter_122_10 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_122_10].死亡 == false then
				local var_122_59 = WAR.Person[iter_122_10].坐标X - arg_122_4
				local var_122_60 = WAR.Person[iter_122_10].坐标Y - arg_122_5
				local var_122_61 = CC.XScale * (var_122_59 - var_122_60) + CC.ScreenW / 2
				local var_122_62 = CC.YScale * (var_122_59 + var_122_60) + CC.ScreenH / 2 - var_122_22

				if var_122_61 > 0 and var_122_61 < var_122_55 then
					var_122_55 = var_122_61
				end

				if var_122_61 > 0 and var_122_56 < var_122_61 and var_122_61 <= CC.ScreenW then
					var_122_56 = var_122_61
				end

				if var_122_62 > 0 and var_122_62 < var_122_57 then
					var_122_57 = var_122_62
				end

				if var_122_62 > 0 and var_122_58 < var_122_62 and var_122_62 <= CC.ScreenH then
					var_122_58 = var_122_62
				end
			end
		end
	else
		var_122_55 = 0
		var_122_56 = CC.ScreenW
		var_122_57 = 0
		var_122_58 = CC.ScreenH
	end

	local var_122_63 = lib.SaveSur(var_122_55, var_122_57, var_122_56, var_122_58)

	for iter_122_11 = 1, 20 do
		local var_122_64 = false
		local var_122_65 = false

		for iter_122_12 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_122_12].死亡 == false then
				local var_122_66 = WAR.Person[iter_122_12].特效动画

				if var_122_66 ~= -1 and iter_122_11 < CC.Effect[var_122_66] then
					if WAR.EFT[var_122_66] == nil then
						lib.PicLoadFile(string.format(CC.EffectFile[1], var_122_66), string.format(CC.EffectFile[2], var_122_66), 70 + WAR.EFTNUM)

						WAR.EFT[var_122_66] = 70 + WAR.EFTNUM
						WAR.EFTNUM = WAR.EFTNUM + 1

						if WAR.EFTNUM > 20 then
							WAR.EFTNUM = 0
						end
					end

					local var_122_67 = WAR.Person[iter_122_12].坐标X - var_122_0
					local var_122_68 = WAR.Person[iter_122_12].坐标Y - var_122_1
					local var_122_69 = CC.XScale * (var_122_67 - var_122_68) + CC.ScreenW / 2
					local var_122_70 = CC.YScale * (var_122_67 + var_122_68) + CC.ScreenH / 2 - GetS(JY.SubScene, var_122_67 + var_122_0, var_122_68 + var_122_1, 4)
					local var_122_71 = iter_122_11

					if var_122_71 <= CC.Effect[var_122_66] then
						lib.PicLoadCache(WAR.EFT[var_122_66], var_122_71 * 2, var_122_69, var_122_70, 2, 192)
					end

					if iter_122_11 < var_122_54[iter_122_12] * var_122_53 and iter_122_11 > (var_122_54[iter_122_12] - 1) * var_122_53 then
						KungfuString(WAR.Person[iter_122_12].特效文字1, var_122_69, var_122_70, C_WHITE, CC.Fontsmall, CC.FontName, 1)
						KungfuString(WAR.Person[iter_122_12].特效文字2, var_122_69, var_122_70, C_GOLD, CC.Fontsmall, CC.FontName, 2)
						KungfuString(WAR.Person[iter_122_12].特效文字3, var_122_69, var_122_70, C_RED, CC.Fontsmall, CC.FontName, 3)
						KungfuString(WAR.Person[iter_122_12].特效文字0, var_122_69, var_122_70, C_WHITE, CC.Fontsmall, CC.FontName, 4)

						var_122_64 = true
					end
				elseif iter_122_12 ~= WAR.CurID and var_122_66 == -1 and (WAR.Person[iter_122_12].特效文字1 ~= nil and WAR.Person[iter_122_12].特效文字1 ~= " " or WAR.Person[iter_122_12].特效文字2 ~= nil and WAR.Person[iter_122_12].特效文字2 ~= " " or WAR.Person[iter_122_12].特效文字3 ~= nil and WAR.Person[iter_122_12].特效文字3 ~= " ") then
					local var_122_72 = WAR.Person[iter_122_12].坐标X - var_122_0
					local var_122_73 = WAR.Person[iter_122_12].坐标Y - var_122_1
					local var_122_74 = CC.XScale * (var_122_72 - var_122_73) + CC.ScreenW / 2
					local var_122_75 = CC.YScale * (var_122_72 + var_122_73) + CC.ScreenH / 2 - GetS(JY.SubScene, var_122_72 + var_122_0, var_122_73 + var_122_1, 4)

					KungfuString(WAR.Person[iter_122_12].特效文字1, var_122_74, var_122_75, C_WHITE, CC.Fontsmall, CC.FontName, 1)
					KungfuString(WAR.Person[iter_122_12].特效文字2, var_122_74, var_122_75, C_GOLD, CC.Fontsmall, CC.FontName, 2)
					KungfuString(WAR.Person[iter_122_12].特效文字3, var_122_74, var_122_75, C_RED, CC.Fontsmall, CC.FontName, 3)
					KungfuString(WAR.Person[iter_122_12].特效文字0, var_122_74, var_122_75, C_WHITE, CC.Fontsmall, CC.FontName, 4)

					var_122_65 = true
				end
			end
		end

		if var_122_64 then
			lib.ShowSurface(0)
			lib.LoadSur(var_122_63, var_122_55, var_122_57)
			lib.Delay(2 * CC.Frame)
		elseif var_122_65 then
			lib.ShowSurface(0)
			lib.LoadSur(var_122_63, var_122_55, var_122_57)
			lib.Delay(CC.EffectTextMS)  -- [port] was 1; the branch above uses 2 * CC.Frame
		end
	end

	lib.FreeSur(var_122_63)

	if var_122_43 > 0 then
		local var_122_76 = {}

		for iter_122_13 = 0, var_122_43 - 1 do
			local var_122_77 = var_122_42[iter_122_13][1] - var_122_0
			local var_122_78 = var_122_42[iter_122_13][2] - var_122_1
			local var_122_79 = GetS(JY.SubScene, var_122_42[iter_122_13][1], var_122_42[iter_122_13][2], 4)
			local var_122_80 = 4

			for iter_122_14 = 3, var_122_44 do
				if var_122_42[iter_122_13][iter_122_14] ~= nil then
					var_122_80 = string.len(var_122_42[iter_122_13][iter_122_14])

					break
				end
			end

			local var_122_81 = var_122_80 * CC.DefaultFont / 2 + 1

			var_122_76[iter_122_13] = {
				x1 = CC.XScale * (var_122_77 - var_122_78) + CC.ScreenW / 2,
				y1 = CC.YScale * (var_122_77 + var_122_78) + CC.ScreenH / 2 - var_122_79,
				x2 = CC.XScale * (var_122_77 - var_122_78) + CC.ScreenW / 2 + var_122_81,
				y2 = CC.YScale * (var_122_77 + var_122_78) + CC.ScreenH / 2 + CC.DefaultFont + 1
			}
		end

		local var_122_82 = var_122_76[0]

		for iter_122_15 = 1, var_122_43 - 1 do
			var_122_82 = MergeRect(var_122_82, var_122_76[iter_122_15])
		end

		local var_122_83 = (var_122_82.x2 - var_122_82.x1) * (var_122_82.y2 - var_122_82.y1)
		local var_122_84 = lib.SaveSur(var_122_55, var_122_57, var_122_56, var_122_58)

		for iter_122_16 = 3, var_122_44 - 1 do
			local var_122_85 = false

			for iter_122_17 = 5, 15 do
				local var_122_86 = lib.GetTime()
				local var_122_87 = iter_122_17 * 2 + CC.DefaultFont + CC.RowPixel

				if var_122_14 == 1 and var_122_83 < CC.ScreenW * CC.ScreenH / 2 then
					local var_122_88 = {
						x1 = var_122_82.x1,
						y1 = var_122_82.y1 - var_122_87,
						x2 = var_122_82.x2,
						y2 = var_122_82.y2 - var_122_87
					}
					local var_122_89 = ClipRect(var_122_88)

					if var_122_89 ~= nil then
						lib.SetClip(var_122_89.x1, var_122_89.y1, var_122_89.x2, var_122_89.y2)
						WarDrawMap(0)

						for iter_122_18 = 0, var_122_43 - 1 do
							if var_122_42[iter_122_18][iter_122_16] ~= nil then
								local var_122_90 = iter_122_16 - 1

								if iter_122_16 == 3 and string.sub(var_122_42[iter_122_18][iter_122_16], 1, 1) == "-" then
									local var_122_91 = 250
									local var_122_92 = 250
									local var_122_93 = 30

									if var_122_42[iter_122_18][10] ~= nil and var_122_42[iter_122_18][10] > 0 then
										var_122_92 = var_122_92 - var_122_42[iter_122_18][10]
									end

									DrawString(var_122_76[iter_122_18].x1 - string.len(var_122_42[iter_122_18][iter_122_16]) * CC.DefaultFont / 4, var_122_76[iter_122_18].y1 - var_122_87, var_122_42[iter_122_18][iter_122_16], RGB(var_122_91, var_122_92, var_122_93), CC.DefaultFont)
								else
									DrawString(var_122_76[iter_122_18].x1 - string.len(var_122_42[iter_122_18][iter_122_16]) * CC.DefaultFont / 4, var_122_76[iter_122_18].y1 - var_122_87, var_122_42[iter_122_18][iter_122_16], WAR.L_EffectColor[var_122_90], CC.DefaultFont)
								end

								var_122_85 = true
							end
						end
					end
				else
					lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
					lib.LoadSur(var_122_84, var_122_55, var_122_57)

					for iter_122_19 = 0, var_122_43 - 1 do
						if var_122_42[iter_122_19][iter_122_16] ~= nil then
							local var_122_94 = iter_122_16 - 1

							if iter_122_16 == 3 and string.sub(var_122_42[iter_122_19][iter_122_16], 1, 1) == "-" then
								local var_122_95 = 250
								local var_122_96 = 250
								local var_122_97 = 30

								if var_122_42[iter_122_19][10] ~= nil then
									var_122_96 = var_122_96 - var_122_42[iter_122_19][10]
								end

								DrawString(var_122_76[iter_122_19].x1 - string.len(var_122_42[iter_122_19][iter_122_16]) * CC.DefaultFont / 4, var_122_76[iter_122_19].y1 - var_122_87, var_122_42[iter_122_19][iter_122_16], RGB(var_122_95, var_122_96, var_122_97), CC.DefaultFont)
							else
								DrawString(var_122_76[iter_122_19].x1 - string.len(var_122_42[iter_122_19][iter_122_16]) * CC.DefaultFont / 4, var_122_76[iter_122_19].y1 - var_122_87, var_122_42[iter_122_19][iter_122_16], WAR.L_EffectColor[var_122_94], CC.DefaultFont)
							end

							var_122_85 = true
						end
					end
				end

				if var_122_85 then
					ShowScreen(1)
					lib.SetClip(0, 0, 0, 0)

					local var_122_98 = lib.GetTime()

					if var_122_98 - var_122_86 < CC.Frame then
						lib.Delay(CC.Frame - (var_122_98 - var_122_86))
					end
				end
			end
		end

		lib.FreeSur(var_122_84)
	end

	for iter_122_20 = 0, var_122_43 - 1 do
		local var_122_99 = GetWarMap(var_122_42[iter_122_20][1], var_122_42[iter_122_20][2], 2)

		WAR.Person[var_122_99].生命点数 = nil
		WAR.Person[var_122_99].内力点数 = nil
		WAR.Person[var_122_99].体力点数 = nil
		WAR.Person[var_122_99].中毒点数 = nil
		WAR.Person[var_122_99].解毒点数 = nil
		WAR.Person[var_122_99].内伤点数 = nil
	end

	for iter_122_21 = 0, WAR.PersonNum - 1 do
		WAR.Person[iter_122_21].特效动画 = -1
		WAR.Person[iter_122_21].特效文字0 = nil
		WAR.Person[iter_122_21].特效文字1 = nil
		WAR.Person[iter_122_21].特效文字2 = nil
		WAR.Person[iter_122_21].特效文字3 = nil
	end

	lib.SetClip(0, 0, 0, 0)
	WarDrawMap(0)
	ShowScreen()
end

function War_PoisonHurt(arg_123_0, arg_123_1)
	local var_123_0 = JY.Person[arg_123_0].用毒能力 / 4

	if JY.Status == GAME_WMAP then
		for iter_123_0, iter_123_1 in pairs(CC.AddPoi) do
			if iter_123_1[1] == arg_123_0 then
				for iter_123_2 = 0, WAR.PersonNum - 1 do
					if WAR.Person[iter_123_2].人物编号 == iter_123_1[2] and WAR.Person[iter_123_2].死亡 == false then
						var_123_0 = var_123_0 + iter_123_1[3] / 4
					end
				end
			end
		end
	end

	local var_123_1 = JY.Person[arg_123_1].抗毒能力
	local var_123_2 = 100 - JY.Person[arg_123_1].抗毒能力

	if var_123_2 == 0 then
		var_123_2 = 1
	end

	if JLSD(0, var_123_2, arg_123_1) then
		var_123_0 = math.modf(var_123_0 * (var_123_2 / 100) - Rnd(2))
	else
		var_123_0 = 0
	end

	if JY.Person[arg_123_1].主功体 == 108 then
		var_123_0 = 0
	end

	if WAR.Dodge == 1 or var_123_0 < 0 then
		var_123_0 = 0
	end

	if var_123_0 < 0 then
		var_123_0 = 0
	end

	return AddPersonAttrib(arg_123_1, "中毒程度", var_123_0)
end

function War_ExecuteMenu_Sub(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	local var_124_0 = WAR.Person[WAR.CurID].人物编号
	local var_124_1 = WAR.Person[WAR.CurID].坐标X
	local var_124_2 = WAR.Person[WAR.CurID].坐标Y

	CleanWarMap(4, 0)

	WAR.Person[WAR.CurID].人方向 = War_Direct(var_124_1, var_124_2, arg_124_0, arg_124_1)

	SetWarMap(arg_124_0, arg_124_1, 4, 1)

	local var_124_3 = GetWarMap(arg_124_0, arg_124_1, 2)

	if var_124_3 >= 0 then
		if arg_124_2 == 1 and WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_124_3].我方 then
			WAR.Person[var_124_3].中毒点数 = War_PoisonHurt(var_124_0, WAR.Person[var_124_3].人物编号)

			if WAR.Dodge == 1 then
				WAR.Person[var_124_3].中毒点数 = 0
			end

			SetWarMap(arg_124_0, arg_124_1, 4, 5)

			WAR.Effect = 5
		elseif arg_124_2 == 2 and WAR.Person[WAR.CurID].我方 == WAR.Person[var_124_3].我方 then
			WAR.Person[var_124_3].解毒点数 = ExecDecPoison(var_124_0, WAR.Person[var_124_3].人物编号)

			SetWarMap(arg_124_0, arg_124_1, 4, 6)

			WAR.Effect = 6
		elseif arg_124_2 == 3 then
			if (WAR.Person[WAR.CurID].人物编号 == JY.Base.队伍1 or WAR.Person[WAR.CurID].人物编号 == JY.Base.畅想编号 or WAR.Person[WAR.CurID].人物编号 == 9999 and WAR.Person[WAR.CurID].人物编号.姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 7 then
				-- Nothing
			elseif WAR.Person[WAR.CurID].我方 == WAR.Person[var_124_3].我方 then
				WAR.Person[var_124_3].生命点数 = ExecDoctor(var_124_0, WAR.Person[var_124_3].人物编号)

				SetWarMap(arg_124_0, arg_124_1, 4, 4)

				WAR.Effect = 4
			end
		elseif arg_124_2 ~= 4 or WAR.Person[WAR.CurID].人物编号 == 0 and JY.Base.畅想编号 == 153 or WAR.Person[WAR.CurID].人物编号 == 153 then
			-- Nothing
		elseif WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_124_3].我方 then
			WAR.Person[var_124_3].生命点数 = War_AnqiHurt(var_124_0, WAR.Person[var_124_3].人物编号, arg_124_3)

			SetWarMap(arg_124_0, arg_124_1, 4, 2)

			WAR.Effect = 2
		end
	end

	if arg_124_2 == 3 and WAR.Person[WAR.CurID].人物编号 == 0 and JY.Base.主角职业 == 7 then
		for iter_124_0 = arg_124_0 - 4, arg_124_0 + 4 do
			for iter_124_1 = arg_124_1 - 4, arg_124_1 + 4 do
				SetWarMap(iter_124_0, iter_124_1, 4, 1)

				if GetWarMap(iter_124_0, iter_124_1, 2) ~= nil and GetWarMap(iter_124_0, iter_124_1, 2) > -1 then
					local var_124_4 = GetWarMap(iter_124_0, iter_124_1, 2)

					if WAR.Person[WAR.CurID].我方 == WAR.Person[var_124_4].我方 then
						WAR.Person[var_124_4].生命点数 = ExecDoctor(var_124_0, WAR.Person[var_124_4].人物编号)

						SetWarMap(iter_124_0, iter_124_1, 4, 4)

						WAR.Effect = 4
					end

					if WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_124_4].我方 then
						WAR.Person[var_124_4].中毒点数 = War_PoisonHurt(var_124_0, WAR.Person[var_124_4].人物编号)

						if WAR.Dodge == 1 then
							WAR.Person[var_124_3].中毒点数 = 0
						end

						SetWarMap(iter_124_0, iter_124_1, 4, 5)

						WAR.Effect = 4
					end
				end
			end
		end
	end

	if arg_124_2 == 1 and var_124_0 == 0 and JY.Base.主角职业 == 8 then
		for iter_124_2 = arg_124_0 - 3, arg_124_0 + 3 do
			for iter_124_3 = arg_124_1 - 3, arg_124_1 + 3 do
				SetWarMap(iter_124_2, iter_124_3, 4, 1)

				if GetWarMap(iter_124_2, iter_124_3, 2) ~= nil and GetWarMap(iter_124_2, iter_124_3, 2) > -1 then
					local var_124_5 = GetWarMap(iter_124_2, iter_124_3, 2)

					if WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_124_5].我方 or var_124_5 == WAR.CurID then
						WAR.Person[var_124_5].中毒点数 = War_PoisonHurt(var_124_0, WAR.Person[var_124_5].人物编号)

						SetWarMap(iter_124_2, iter_124_3, 4, 5)

						WAR.Effect = 5
					end
				end
			end
		end
	end

	if arg_124_2 == 4 and (WAR.Person[WAR.CurID].人物编号 == 0 and JY.Base.畅想编号 == 153 or WAR.Person[WAR.CurID].人物编号 == 153) then
		for iter_124_4 = arg_124_0 - 3, arg_124_0 + 3 do
			for iter_124_5 = arg_124_1 - 3, arg_124_1 + 3 do
				SetWarMap(iter_124_4, iter_124_5, 4, 1)

				if GetWarMap(iter_124_4, iter_124_5, 2) ~= nil and GetWarMap(iter_124_4, iter_124_5, 2) > -1 then
					local var_124_6 = GetWarMap(iter_124_4, iter_124_5, 2)

					if WAR.Person[WAR.CurID].我方 ~= WAR.Person[var_124_6].我方 then
						WAR.Person[var_124_6].生命点数 = War_AnqiHurt(var_124_0, WAR.Person[var_124_6].人物编号, arg_124_3)

						SetWarMap(iter_124_4, iter_124_5, 4, 2)

						WAR.Effect = 2
					end
				end
			end
		end
	end

	WAR.EffectXY = {}
	WAR.EffectXY[1] = {
		arg_124_0,
		arg_124_1
	}
	WAR.EffectXY[2] = {
		arg_124_0,
		arg_124_1
	}

	if arg_124_2 == 1 then
		War_ShowFight(var_124_0, 0, 0, 0, arg_124_0, arg_124_1, 30)
	elseif arg_124_2 == 2 then
		War_ShowFight(var_124_0, 0, 0, 0, arg_124_0, arg_124_1, 36)
	elseif arg_124_2 == 3 then
		War_ShowFight(var_124_0, 0, 0, 0, arg_124_0, arg_124_1, 0)
	elseif arg_124_2 == 4 and var_124_3 >= 0 then
		War_ShowFight(var_124_0, 0, -1, 0, arg_124_0, arg_124_1, JY.Thing[arg_124_3].暗器动画编号)
	end

	for iter_124_6 = 0, WAR.PersonNum - 1 do
		WAR.Person[iter_124_6].点数 = 0
	end

	if arg_124_2 == 4 then
		if var_124_3 >= 0 then
			instruct_32(arg_124_3, -1)

			return 1
		else
			return 0
		end
	else
		WAR.Person[WAR.CurID].经验 = WAR.Person[WAR.CurID].经验 + 1

		AddPersonAttrib(var_124_0, "体力", -2)
	end

	if instruct_16(var_124_0) then
		AddPersonAttrib(var_124_0, "体力", -4)
	end

	return 1
end

function DrawTimeBar2()
	local var_125_0 = CC.ScreenW * 5 / 8
	local var_125_1 = CC.ScreenW * 7 / 8
	local var_125_2 = CC.ScreenH / 10
	local var_125_3 = false

	DrawBox_1(var_125_0 - 3, var_125_2, var_125_1 + 3, var_125_2 + 3, C_ORANGE)
	DrawBox_1(var_125_0 - (var_125_1 - var_125_0) / 2, var_125_2, var_125_0 - 3, var_125_2 + 3, C_RED)
	DrawString(var_125_1 + 10, var_125_2 - 23, "时序", C_WHITE, CC.FontSmall)

	local var_125_4 = lib.SaveSur(var_125_0 - (10 + (var_125_1 - var_125_0) / 2), 0, var_125_1 + 10 + 20 + 30, var_125_2 * 2 + 18 + 50)

	while true do
		local var_125_5 = false

		for iter_125_0 = 0, WAR.PersonNum - 1 do
			local var_125_6 = WAR.Person[iter_125_0].人物编号

			if WAR.Person[iter_125_0].死亡 == false and JY.Person[WAR.Person[iter_125_0].人物编号].生命 > 0 then
				if WAR.Person[iter_125_0].TimeAdd < 0 then
					var_125_5 = true
					WAR.Person[iter_125_0].TimeAdd = WAR.Person[iter_125_0].TimeAdd + 20

					if WAR.Person[iter_125_0].TimeAdd > 0 then
						WAR.Person[iter_125_0].TimeAdd = 0
					end

					if WAR.Person[iter_125_0].Time > -500 then
						WAR.Person[iter_125_0].Time = WAR.Person[iter_125_0].Time - 20
					elseif JY.Person[var_125_6].主功体 == 100 then
						JY.Person[var_125_6].受伤程度 = 0
					elseif JY.Person[var_125_6].受伤程度 < 100 then
						if instruct_16(var_125_6) then
							AddPersonAttrib(var_125_6, "受伤程度", Rnd(4) + 2)
						else
							AddPersonAttrib(var_125_6, "受伤程度", Rnd(3) + 1)
						end
					end
				elseif WAR.Person[iter_125_0].TimeAdd > 0 then
					var_125_5 = true
					WAR.Person[iter_125_0].TimeAdd = WAR.Person[iter_125_0].TimeAdd - 20
					WAR.Person[iter_125_0].Time = WAR.Person[iter_125_0].Time + 20

					if WAR.Person[iter_125_0].Time > 995 then
						WAR.Person[iter_125_0].Time = 995
					end
				end
			end
		end

		if var_125_5 then
			lib.LoadSur(var_125_4, var_125_0 - (10 + (var_125_1 - var_125_0) / 2), 0)
			DrawTimeBar_sub(var_125_0, var_125_1, var_125_2, 1)
			ShowScreen()
			lib.Delay(8)
		else
			break
		end
	end

	lib.Delay(2 * CC.Frame)
	lib.FreeSur(var_125_4)
end

function DrawTimeBar()
	local var_126_0 = CC.ScreenW * 5 / 8
	local var_126_1 = CC.ScreenW * 7 / 8
	local var_126_2 = CC.ScreenH / 10
	local var_126_3 = true

	DrawBox_1(var_126_0 - 3, var_126_2, var_126_1 + 3, var_126_2 + 3, C_ORANGE)
	DrawBox_1(var_126_0 - (var_126_1 - var_126_0) / 2, var_126_2, var_126_0 - 3, var_126_2 + 3, C_RED)
	DrawString(var_126_1 + 10, var_126_2 - 23, "时序", C_WHITE, CC.FontSmall)
	lib.SetClip(var_126_0 - (var_126_1 - var_126_0) / 2, 0, CC.ScreenW, CC.ScreenH / 4)

	local var_126_4 = lib.SaveSur(var_126_0 - (var_126_1 - var_126_0) / 2, 0, CC.ScreenW, CC.ScreenH / 4)

	while var_126_3 do
		for iter_126_0 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_126_0].死亡 == false then
				lib.SetClip(var_126_0 - (var_126_1 - var_126_0) / 2, 0, CC.ScreenW, CC.ScreenH / 4)

				local var_126_5 = WAR.Person[iter_126_0].人物编号

				if JY.Person[var_126_5].中封穴 == 0 then
					if PersonKF(var_126_5, 104) == false then
						WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + WAR.Person[iter_126_0].TimeAdd

						if WAR.LQZ[var_126_5] == 100 then
							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + WAR.Person[iter_126_0].TimeAdd
						elseif (WAR.HOT[var_126_5] or 0) > 30 then
							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time - WAR.Person[iter_126_0].TimeAdd

							local var_126_6 = 0
							local var_126_7 = math.random(WAR.Person[iter_126_0].TimeAdd) + 1

							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + var_126_7

							if WAR.L_NYZH[WAR.Person[iter_126_0].人物编号] == 1 then
								var_126_7 = math.random(math.floor(WAR.Person[iter_126_0].TimeAdd / 3), WAR.Person[iter_126_0].TimeAdd * 2)
								WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + var_126_7
							end

							if math.random(10) == 8 or math.random(10) == 8 then
								if var_126_5 == 60 then
									if JY.Base.游戏难度 == 1 then
										WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 50
										var_126_7 = var_126_7 + 50
									else
										WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 80
										var_126_7 = var_126_7 + 80
									end
								else
									WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 30

									local var_126_8 = var_126_7 + 30
								end
							end
						end
					elseif PersonKF(var_126_5, 107) == false then
						local var_126_9 = 0

						if WAR.L_NYZH[WAR.Person[iter_126_0].人物编号] == nil then
							var_126_9 = math.random(WAR.Person[iter_126_0].TimeAdd) + 1
							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + var_126_9
						elseif WAR.L_NYZH[WAR.Person[iter_126_0].人物编号] == 1 then
							var_126_9 = math.random(math.floor(WAR.Person[iter_126_0].TimeAdd / 3), WAR.Person[iter_126_0].TimeAdd)
							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + var_126_9
						end

						if math.random(10) == 8 or math.random(10) == 8 then
							if var_126_5 == 60 or var_126_5 == 61 then
								if JY.Base.游戏难度 == 1 then
									WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 50
									var_126_9 = var_126_9 + 50
								else
									WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 80
									var_126_9 = var_126_9 + 80
								end
							else
								WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + 30

								local var_126_10 = var_126_9 + 30
							end
						end

						if JY.Person[WAR.Person[iter_126_0].人物编号].体力 < 20 then
							WAR.tmp[1000 + var_126_5] = nil
						end
					else
						WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + WAR.Person[iter_126_0].TimeAdd

						if WAR.LQZ[var_126_5] == 100 then
							WAR.Person[iter_126_0].Time = WAR.Person[iter_126_0].Time + WAR.Person[iter_126_0].TimeAdd
						end
					end
				else
					JY.Person[var_126_5].中封穴 = JY.Person[var_126_5].中封穴 - 1

					if PersonKF(var_126_5, 108) or PersonKF(var_126_5, 107) and PersonKF(var_126_5, 100) then
						JY.Person[var_126_5].中封穴 = JY.Person[var_126_5].中封穴 - 1
					end

					if cxtd(var_126_5, 143) or cxtd(var_126_5, 144) or cxtd(var_126_5, 145) or cxtd(var_126_5, 146) or cxtd(var_126_5, 147) or cxtd(var_126_5, 148) then
						JY.Person[var_126_5].中封穴 = JY.Person[var_126_5].中封穴 - 1
					end

					if (PersonKF(var_126_5, 100) or (var_126_5 == JY.Base.队伍1 or var_126_5 == JY.Base.畅想编号 and JY.Person[var_126_5].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5) and math.random(5) == 1 then
						JY.Person[var_126_5].中封穴 = JY.Person[var_126_5].中封穴 - 1
					end

					if cxtd(var_126_5, 157) and WAR.FXDS[var_126_5] > 10 then
						JY.Person[var_126_5].中封穴 = 0
					end

					if WAR.LQZ[var_126_5] == 100 then
						JY.Person[var_126_5].中封穴 = 0
					end

					if WAR.ZYZ[var_126_5] > 150 then
						JY.Person[var_126_5].中封穴 = 0
					end

					if JY.Person[var_126_5].中封穴 < 1 then
						JY.Person[var_126_5].中封穴 = 0
					end
				end

				if WAR.XDHFJQ == 1 then
					WAR.XDHFJQ = 0
				end

				if WAR.XDHFJQ == 2 then
					WAR.XDHFJQ = 0
				end

				if WAR.XDHFJQ == 3 then
					WAR.XDHFJQ = 0
				end

				if WAR.ICE[var_126_5] ~= nil and JY.Person[var_126_5].内力 > 0 and not cxtd(var_126_5, 124) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 - math.random(3) - math.modf(JY.Person[var_126_5].受伤程度 / 15)

					if WAR.ICE[var_126_5] > 60 then
						JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 - math.random(3) - math.modf(JY.Person[var_126_5].受伤程度 / 15)
					end

					if WAR.ICE[var_126_5] <= 0 then
						WAR.ICE[var_126_5] = nil
					end
				end

				if WAR.ICE[var_126_5] ~= nil and JY.Person[var_126_5].内力 < JY.Person[var_126_5].内力最大值 and cxtd(var_126_5, 124) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + math.random(3) + math.modf(JY.Person[var_126_5].受伤程度 / 15)

					if WAR.ICE[var_126_5] > 60 then
						JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + math.random(3) + math.modf(JY.Person[var_126_5].受伤程度 / 15)
					end

					if WAR.ICE[var_126_5] <= 0 then
						WAR.ICE[var_126_5] = nil
					end
				end

				local var_126_11 = JY.Person[var_126_5].主功体

				if var_126_11 > 0 then
					JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 + JY.Wugong[var_126_11].时序回复生命
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + JY.Wugong[var_126_11].时序回复内力

					if JY.Person[var_126_5].中毒程度 ~= nil and JY.Person[var_126_5].中毒程度 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - JY.Wugong[var_126_11].时序解毒

						if JY.Person[var_126_5].中毒程度 < 0 then
							JY.Person[var_126_5].中毒程度 = 0
						end
					end

					if JY.Person[var_126_5].受伤程度 ~= nil and JY.Person[var_126_5].受伤程度 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - JY.Wugong[var_126_11].时序回内伤

						if JY.Person[var_126_5].受伤程度 < 0 then
							JY.Person[var_126_5].受伤程度 = 0
						end
					end

					if JY.Person[var_126_5].流血值 ~= 0 and JY.Person[var_126_5].流血值 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].流血值 = JY.Person[var_126_5].流血值 - JY.Wugong[var_126_11].时序回流血

						if JY.Person[var_126_5].流血值 < 0 then
							JY.Person[var_126_5].流血值 = 0
						end
					end

					if JY.Person[var_126_5].中火毒 ~= 0 and JY.Person[var_126_5].中火毒 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].中火毒 = JY.Person[var_126_5].中火毒 - JY.Wugong[var_126_11].时序解火毒

						if JY.Person[var_126_5].中火毒 < 0 then
							JY.Person[var_126_5].中火毒 = 0
						end
					end

					if JY.Person[var_126_5].中冰毒 ~= 0 and JY.Person[var_126_5].中冰毒 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].中冰毒 = JY.Person[var_126_5].中冰毒 - JY.Wugong[var_126_11].时序解冰冻

						if JY.Person[var_126_5].中冰毒 < 0 then
							JY.Person[var_126_5].中冰毒 = 0
						end
					end

					if JY.Person[var_126_5].中封穴 ~= 0 and JY.Person[var_126_5].中封穴 <= JY.Wugong[var_126_11].武功等级 * 10 then
						JY.Person[var_126_5].中封穴 = JY.Person[var_126_5].中封穴 - JY.Wugong[var_126_11].时序解封穴

						if JY.Person[var_126_5].中封穴 < 0 then
							JY.Person[var_126_5].中封穴 = 0
						end
					end
				end

				if WAR.ICE[var_126_5] == nil and PersonKF(var_126_5, 106) and (JY.Person[var_126_5].内力性质 == 1 or var_126_5 == 0 and GetS(4, 5, 5, 5) == 5) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 5 + math.random(5)
				end

				if JY.Person[var_126_5].主功体 == 106 and WAR.ICE[var_126_5] == nil and PersonKF(var_126_5, 106) and (JY.Person[var_126_5].内力性质 == 1 or var_126_5 == 0 and GetS(4, 5, 5, 5) == 5) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 5
				end

				if PersonKF(var_126_5, 107) and (JY.Person[var_126_5].内力性质 == 0 or (var_126_5 == JY.Base.队伍1 or var_126_5 == JY.Base.畅想编号 or var_126_5 == 9999 and JY.Person[var_126_5].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5) and math.random(8) == 1 and JY.Person[var_126_5].体力 < 100 then
					JY.Person[var_126_5].体力 = JY.Person[var_126_5].体力 + 1
				end

				if JY.Person[var_126_5].主功体 == 90 and math.random(3) == 1 and JY.Person[var_126_5].体力 < 100 then
					JY.Person[var_126_5].体力 = JY.Person[var_126_5].体力 + 1
				end

				if PersonKF(var_126_5, 108) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 1
				end

				if cxtd(var_126_5, 169) then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 5
				end

				if Curr_NG(var_126_5, 100) and math.random(5) == 1 then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 2 + math.random(1)
					JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 + 1

					if cxtd(var_126_5, 68) or cxtd(var_126_5, 123) or cxtd(var_126_5, 124) or cxtd(var_126_5, 125) or cxtd(var_126_5, 126) or cxtd(var_126_5, 127) or cxtd(var_126_5, 128) or cxtd(var_126_5, 129) then
						JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 2 + math.random(1)
						JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 + 1
					end
				end

				if WAR.LXZT[var_126_5] ~= nil then
					if JY.Person[var_126_5].主功体 == 95 and math.random(5) == 1 then
						JY.Person[var_126_5].流血值 = JY.Person[var_126_5].流血值 - 1
					end

					if JY.Person[var_126_5].主功体 == 96 and math.random(5) == 1 then
						JY.Person[var_126_5].流血值 = JY.Person[var_126_5].流血值 - 1
					elseif PersonKF(var_126_5, 96) and math.random(10) == 1 then
						JY.Person[var_126_5].流血值 = JY.Person[var_126_5].流血值 - 1
					end

					if JY.Person[var_126_5].流血值 < 0 then
						JY.Person[var_126_5].流血值 = 0
					end
				end

				if JY.Person[var_126_5].受伤程度 > 0 and PersonKF(var_126_5, 108) then
					if JY.Person[var_126_5].受伤程度 > 70 and math.random(100) > 60 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					elseif JY.Person[var_126_5].受伤程度 > 40 and math.random(100) > 30 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					else
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					end
				end

				if (JY.Person[var_126_5].主功体 == 89 or JY.Person[var_126_5].主功体 == 103 or PersonKF(var_126_5, 100)) and math.random(5) == 1 and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if JY.Person[var_126_5].主功体 == 90 and math.random(3) == 1 and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if JY.Person[var_126_5].主功体 == 102 and JY.Person[var_126_5].内力性质 == 0 and math.random(3) == 1 and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if JY.Person[var_126_5].主功体 == 107 and JY.Person[var_126_5].内力性质 == 0 and math.random(8) == 1 and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if cxtd(var_126_5, 125) and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if JY.Person[var_126_5].主功体 == 106 and JY.Person[var_126_5].内力性质 == 1 and math.random(3) == 1 and JY.Person[var_126_5].受伤程度 > 0 then
					JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
				end

				if JY.Person[var_126_5].中毒程度 > 0 and Curr_NG(var_126_5, 99) then
					if JY.Person[var_126_5].中毒程度 > 70 and math.random(100) > 60 then
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					elseif JY.Person[var_126_5].中毒程度 > 40 and math.random(100) > 60 then
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					else
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					end
				end

				if JY.Person[var_126_5].防具 == 61 and JY.Person[var_126_5].中毒程度 > 0 then
					JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
				end

				if Curr_NG(var_126_5, 99) and JY.Person[var_126_5].中冰毒 > 0 and JY.Person[var_126_5].内力性质 == 1 and math.random(5) == 1 then
					JY.Person[var_126_5].中冰毒 = JY.Person[var_126_5].中冰毒 - 1
				end

				if cxtd(var_126_5, 5) and Curr_NG(var_126_5, 113) and JY.Person[var_126_5].中冰毒 > 0 and math.random(5) == 1 then
					JY.Person[var_126_5].中冰毒 = JY.Person[var_126_5].中冰毒 - 1
				end

				if JY.Person[var_126_5].中毒程度 > 0 and cxtd(var_126_5, 129) then
					JY.Person[var_126_5].中毒程度 = 0
				end

				if cxtd(var_126_5, 37) and GetS(86, 8, 10, 5) == 2 then
					if JY.Person[var_126_5].中毒程度 > 70 and math.random(100) > 60 then
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					elseif JY.Person[var_126_5].中毒程度 > 40 and math.random(100) > 30 then
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					else
						JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 - 1
					end

					if JY.Person[var_126_5].受伤程度 > 70 and math.random(100) > 60 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					elseif JY.Person[var_126_5].受伤程度 > 40 and math.random(100) > 30 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					else
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					end

					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 + 3 + math.random(1)
					JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 + 1 + math.random(1)
				end

				if cxtd(var_126_5, 37) and WAR.DYWY == 1 then
					JY.Person[var_126_5].内力 = JY.Person[var_126_5].内力 - 20

					if JY.Person[var_126_5].内力 < 250 then
						WAR.DYWY = 0
					end
				end

				if cxtd(var_126_5, 54) and WAR.YCZHL[var_126_5] ~= nil and WAR.YCZHL[var_126_5] > 0 then
					WAR.YCZHL[var_126_5] = WAR.YCZHL[var_126_5] - 1

					if WAR.YCZHL[var_126_5] <= 0 then
						WAR.YCZHL[var_126_5] = nil
					end
				end

				if WAR.ICE[var_126_5] ~= nil then
					WAR.ICE[var_126_5] = WAR.ICE[var_126_5] - 1

					if PersonKF(var_126_5, 106) and (JY.Person[var_126_5].内力性质 == 1 or var_126_5 == 0 and GetS(4, 5, 5, 5) == 5) then
						WAR.ICE[var_126_5] = WAR.ICE[var_126_5] - 1
					end

					if cxtd(var_126_5, 81) or cxtd(var_126_5, 153) then
						WAR.ICE[var_126_5] = WAR.ICE[var_126_5] - 1
					end

					if WAR.ICE[var_126_5] < 1 then
						WAR.ICE[var_126_5] = nil
					end
				end

				if WAR.HOT[var_126_5] ~= nil then
					WAR.HOT[var_126_5] = WAR.HOT[var_126_5] - 1

					if PersonKF(var_126_5, 107) and (JY.Person[var_126_5].内力性质 == 0 or (var_126_5 == JY.Base.队伍1 or var_126_5 == JY.Base.畅想编号 or var_126_5 == 9999 and JY.Person[var_126_5].姓名 == JY.Person[JY.Base.队伍1].姓名) and JY.Base.主角职业 == 5) then
						WAR.HOT[var_126_5] = WAR.HOT[var_126_5] - 1
					end

					if cxtd(var_126_5, 153) then
						WAR.HOT[var_126_5] = WAR.HOT[var_126_5] - 1
					end

					if WAR.HOT[var_126_5] < 1 then
						WAR.HOT[var_126_5] = nil
					end
				end

				if cxtd(var_126_5, 5) and Curr_NG(var_126_5, 113) and WAR.HOT[var_126_5] ~= nil and math.random(8) == 1 then
					WAR.HOT[var_126_5] = WAR.HOT[var_126_5] - 1
				end

				if WAR.JZPZ[var_126_5] ~= nil then
					WAR.JZPZ[var_126_5] = WAR.JZPZ[var_126_5] - 1

					if cxtd(var_126_5, 110) or cxtd(var_126_5, 111) or cxtd(var_126_5, 118) then
						WAR.JZPZ[var_126_5] = WAR.JZPZ[var_126_5] - 1

						if WAR.JZPZ[var_126_5] < 1 then
							WAR.JZPZ[var_126_5] = nil
						end
					end
				end

				if var_126_5 == 0 and T2SQ(var_126_5) and JY.Base.觉醒 == 1 then
					if WAR.YTFS < 100 then
						WAR.YTFS = WAR.YTFS + 1
					end

					if WAR.YTFS == 100 then
						lib.SetClip(0, 0, 0, 0)
						DrawStrBox(-1, -1, "水镜四奇云体风身蓄力完毕", C_GOLD, CC.DefaultFont)
						ShowScreen()
						lib.Delay(3 * CC.Frame)

						WAR.YTFS = 101

						lib.SetClip(var_126_0 - (var_126_1 - var_126_0) / 2, 0, CC.ScreenW, CC.ScreenH / 4)
					end
				end

				if WAR.L_WNGZL[var_126_5] ~= nil and WAR.L_WNGZL[var_126_5] > 0 then
					JY.Person[var_126_5].中毒程度 = JY.Person[var_126_5].中毒程度 + 1
					JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 - math.modf(JY.Person[var_126_5].生命 / 120)
					WAR.L_WNGZL[var_126_5] = WAR.L_WNGZL[var_126_5] - 1

					if WAR.L_WNGZL[var_126_5] <= 0 then
						WAR.L_WNGZL[var_126_5] = nil
					end
				end

				if WAR.L_HQNZL[var_126_5] ~= nil and WAR.L_HQNZL[var_126_5] > 0 then
					JY.Person[var_126_5].生命 = JY.Person[var_126_5].生命 + 1 + math.modf((JY.Person[var_126_5].生命最大值 - JY.Person[var_126_5].生命) / 40)

					if JY.Person[var_126_5].受伤程度 > 50 then
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 2
					else
						JY.Person[var_126_5].受伤程度 = JY.Person[var_126_5].受伤程度 - 1
					end

					WAR.L_HQNZL[var_126_5] = WAR.L_HQNZL[var_126_5] - 1

					if WAR.L_HQNZL[var_126_5] <= 0 then
						WAR.L_HQNZL[var_126_5] = nil
					end
				end

				if WAR.Person[iter_126_0].我方 == true and WAR.Person[iter_126_0].死亡 == false and WAR.NPC[var_126_5] ~= nil and WAR.NPC[var_126_5] < 1000 then
					WAR.NPC[var_126_5] = WAR.NPC[var_126_5] - 1

					if WAR.NPC[var_126_5] <= 0 then
						WAR.NPC[var_126_5] = nil
						WAR.Person[iter_126_0].我方 = false

						QZXS(JY.Person[var_126_5].姓名 .. "恢复清醒")
					end
				end

				if WAR.Person[iter_126_0].我方 == true and WAR.Person[iter_126_0].死亡 == false and WAR.NPC2[var_126_5] ~= nil and WAR.NPC2[var_126_5] < 1000 then
					WAR.NPC2[var_126_5] = WAR.NPC2[var_126_5] - 1

					if WAR.NPC2[var_126_5] <= 0 then
						if xiaobin(var_126_5) then
							WAR.NPC2[var_126_5] = nil
							WAR.Person[iter_126_0].死亡 = true

							QZXS(JY.Person[var_126_5].姓名 .. "死亡")
						else
							WAR.NPC2[var_126_5] = nil
							WAR.Person[iter_126_0].我方 = false

							QZXS(JY.Person[var_126_5].姓名 .. "恢复清醒")

							WAR.L_NYZH[var_126_5] = nil
						end
					end
				end

				if WAR.Person[iter_126_0].Time >= 1000 then
					WAR.JQSDXS[WAR.Person[iter_126_0].人物编号] = WAR.Person[iter_126_0].TimeAdd

					if WAR.ZYHB == 1 then
						if iter_126_0 ~= WAR.ZYHBP then
							WAR.Person[iter_126_0].Time = 990
						else
							WAR.Person[iter_126_0].Time = 1001
						end
					end

					var_126_3 = false
				end
			end
		end

		DrawTimeBar_sub(var_126_0, var_126_1, nil, 0)
		ShowScreen(1)

		WAR.SXTJ = WAR.SXTJ + 1

		local var_126_12 = lib.GetKey()

		if var_126_12 == VK_SPACE or var_126_12 == VK_RETURN then
			if WAR.AutoFight == 1 then
				WAR.AutoFight = 0
			end
		elseif var_126_12 == VK_ESCAPE then
			local var_126_13 = JYMsgBox("战斗选项", "返回：继续战斗*认输：本场战斗认输*退出：退出游戏", {
				"返回",
				"认输",
				"退出"
			}, 3, 261)

			if var_126_13 == 2 then
				if WAR.ZDDH == 238 then
					say("这么严肃的场合想要认输？小施主，你想多了……", 114, 0, "扫地神僧")
				else
					for iter_126_1 = 0, WAR.PersonNum - 1 do
						if WAR.Person[iter_126_1].我方 == true then
							WAR.Person[iter_126_1].死亡 = true
						else
							WAR.Person[iter_126_1].Time = 990
							WAR.Person[iter_126_1].TimeAdd = 10
						end
					end
				end
			elseif var_126_13 == 3 then
				JY.Status = x
			end

			Cls()
			lib.SetClip(var_126_0 - (var_126_1 - var_126_0) / 2, 0, CC.ScreenW, CC.ScreenH / 4)
		end

		lib.LoadSur(var_126_4, var_126_0 - (var_126_1 - var_126_0) / 2, 0)
	end

	for iter_126_2 = 0, WAR.PersonNum - 1 do
		if WAR.Person[iter_126_2].死亡 == false then
			WAR.Person[iter_126_2].TimeAdd = 0

			local var_126_14 = WAR.Person[iter_126_2].人物编号

			if var_126_14 == JY.MY and JY.Base.主角职业 == 7 then
				JY.Person[var_126_14].生命 = JY.Person[var_126_14].生命 + limitX(WAR.SXTJ / 100, 0, 100) + math.random(10)
				JY.Person[var_126_14].中毒程度 = JY.Person[var_126_14].中毒程度 - 5 - math.random(5)
			end

			if JY.Person[var_126_14].生命最大值 < JY.Person[var_126_14].生命 then
				JY.Person[var_126_14].生命 = JY.Person[var_126_14].生命最大值
			end

			if JY.Person[var_126_14].内力最大值 < JY.Person[var_126_14].内力 then
				JY.Person[var_126_14].内力 = JY.Person[var_126_14].内力最大值
			end

			if JY.Person[var_126_14].中毒程度 < 0 then
				JY.Person[var_126_14].中毒程度 = 0
			end

			if JY.Person[var_126_14].受伤程度 < 0 then
				JY.Person[var_126_14].受伤程度 = 0
			end

			if JY.Person[var_126_14].内力 < 0 then
				JY.Person[var_126_14].内力 = 0
			end

			if JY.Person[var_126_14].流血值 < 0 then
				JY.Person[var_126_14].流血值 = 0
			end

			if JY.Person[var_126_14].中火毒 < 0 then
				JY.Person[var_126_14].中火毒 = 0
			end

			if JY.Person[var_126_14].中冰毒 < 0 then
				JY.Person[var_126_14].中冰毒 = 0
			end

			if JY.Person[var_126_14].中封穴 < 0 then
				JY.Person[var_126_14].中封穴 = 0
			end

			if WAR.LXZT[var_126_14] ~= nil and WAR.LXZT[var_126_14] < 0 then
				WAR.LXZT[var_126_14] = nil
			end

			if WAR.HOT[var_126_14] ~= nil and WAR.HOT[var_126_14] < 0 then
				WAR.HOT[var_126_14] = nil
			end

			if WAR.ICE[var_126_14] ~= nil and WAR.ICE[var_126_14] < 0 then
				WAR.ICE[var_126_14] = nil
			end

			if WAR.FXDS[var_126_14] ~= nil and WAR.FXDS[var_126_14] < 0 then
				WAR.FXDS[var_126_14] = nil
			end
		end
	end

	WAR.ZYHBP = -1

	lib.SetClip(0, 0, 0, 0)
	lib.FreeSur(var_126_4)
end

function DrawTimeBar_sub(arg_127_0, arg_127_1, arg_127_2, arg_127_3)
	arg_127_1 = arg_127_1 or CC.ScreenW * 7 / 8
	arg_127_2 = arg_127_2 or CC.ScreenH / 10

	if not arg_127_0 then
		arg_127_0 = CC.ScreenW * 5 / 8

		DrawBox_1(arg_127_0 - 3, arg_127_2, arg_127_1 + 3, arg_127_2 + 3, C_ORANGE)
		DrawBox_1(arg_127_0 - (arg_127_1 - arg_127_0) / 2, arg_127_2, arg_127_0 - 3, arg_127_2 + 3, C_RED)
		DrawString(arg_127_1 + 10, arg_127_2 - 23, "时序", C_WHITE, CC.FontSmall)
	end

	for iter_127_0 = 0, WAR.PersonNum - 1 do
		if not WAR.Person[iter_127_0].死亡 and JY.Person[WAR.Person[iter_127_0].人物编号].生命 > 0 then
			local var_127_0 = arg_127_0 + math.modf(WAR.Person[iter_127_0].Time * (arg_127_1 - arg_127_0) / 1000)
			local var_127_1 = WAR.tmp[5000 + iter_127_0]

			if var_127_1 == nil then
				var_127_1 = JY.Person[WAR.Person[iter_127_0].人物编号].头像代号
			end

			local var_127_2 = limitX(CC.ScreenW / 25, 12, 35)
			local var_127_3 = limitX(CC.ScreenW / 25, 12, 35)

			if JY.Base.畅想编号 == 0 and (WAR.Person[iter_127_0].人物编号 == 0 or WAR.Person[iter_127_0].人物编号 == 9999 and JY.Person[9999].姓名 == JY.Person[0].姓名) then
				if JY.Base.主角职业 < 10 then
					if JY.Person[0].性别 == 0 then
						var_127_1 = 280 + JY.Base.主角职业
					else
						var_127_1 = 501 + JY.Base.主角职业
					end
				else
					var_127_1 = 289 + JY.Base.特殊主角
				end
			end

			if WAR.Person[iter_127_0].人物编号 == 445 and WAR.ZDDH == 226 then
				var_127_1 = 258
			end

			if WAR.Person[iter_127_0].我方 then
				if WAR.Person[iter_127_0].人物编号 == JY.Base.佣兵1 or WAR.Person[iter_127_0].人物编号 == JY.Base.佣兵2 or WAR.Person[iter_127_0].人物编号 == JY.Base.佣兵3 then
					drawname(var_127_0, 0, "佣", CC.Fontsmall, 12)
				end

				lib.LoadPNG(99, var_127_1 * 2, var_127_0 - var_127_2 / 2, arg_127_2 - var_127_3 - 4, 1, 0)
			else
				drawname(var_127_0, arg_127_2 + var_127_3 + 4, JY.Person[WAR.Person[iter_127_0].人物编号].姓名, CC.FontSmall, 12)
				lib.LoadPNG(99, var_127_1 * 2, var_127_0 - var_127_2 / 2, arg_127_2 + 6, 1, 0)
			end
		end
	end

	DrawString(arg_127_1 + 10, arg_127_2 - 3, WAR.SXTJ, C_GOLD, CC.Fontsmall)
end

function drawname(arg_128_0, arg_128_1, arg_128_2, arg_128_3)
	arg_128_0 = arg_128_0 - math.modf(arg_128_3 / 2)

	local var_128_0 = string.len(arg_128_2) / 2
	local var_128_1 = {}

	for iter_128_0 = 1, var_128_0 do
		var_128_1[iter_128_0] = string.sub(arg_128_2, iter_128_0 * 2 - 1, iter_128_0 * 2)

		DrawString(arg_128_0, arg_128_1, var_128_1[iter_128_0], C_WHITE, arg_128_3)

		arg_128_1 = arg_128_1 + arg_128_3
	end
end

function RealJL(arg_129_0, arg_129_1, arg_129_2)
	arg_129_2 = arg_129_2 or 1

	local var_129_0 = WAR.Person[arg_129_0].坐标X
	local var_129_1 = WAR.Person[arg_129_0].坐标Y
	local var_129_2 = WAR.Person[arg_129_1].坐标X
	local var_129_3 = WAR.Person[arg_129_1].坐标Y
	local var_129_4 = math.abs(var_129_0 - var_129_2) + math.abs(var_129_1 - var_129_3)

	if arg_129_2 == nil then
		return var_129_4
	end

	if var_129_4 <= arg_129_2 then
		return true
	else
		return false
	end
end

function refw(arg_130_0, arg_130_1)
	local var_130_0
	local var_130_1
	local var_130_2
	local var_130_3
	local var_130_4
	local var_130_5
	local var_130_6

	if JY.Wugong[arg_130_0].攻击范围 == -1 then
		return JY.Wugong[arg_130_0].加内力1, JY.Wugong[arg_130_0].加内力2, JY.Wugong[arg_130_0].未知1, JY.Wugong[arg_130_0].未知2, JY.Wugong[arg_130_0].未知3, JY.Wugong[arg_130_0].未知4, JY.Wugong[arg_130_0].未知5
	end

	local var_130_7 = JY.Wugong[arg_130_0].攻击范围
	local var_130_8 = JY.Wugong[arg_130_0].武功类型
	local var_130_9 = WAR.Person[WAR.CurID].人物编号
	local var_130_10 = 0
	local var_130_11 = 0
	local var_130_12 = 0
	local var_130_13 = 0

	if JY.Person[var_130_9].内力最大值 > 5000 then
		if var_130_8 == 1 then
			var_130_10 = math.modf(JY.Person[var_130_9].内力最大值 / 3000) - 1
			var_130_12 = math.modf(JY.Person[var_130_9].内力最大值 / 3000) - 1
		elseif var_130_8 == 2 or var_130_8 == 3 or var_130_8 == 4 then
			var_130_12 = math.modf(JY.Person[var_130_9].内力最大值 / 3000) - 1
		end
	end

	if Curr_NG(var_130_9, 110) and yongquan(arg_130_0) then
		var_130_10 = var_130_10 + 2
	end

	if Curr_NG(var_130_9, 89) and yongjian(arg_130_0) then
		var_130_10 = var_130_10 + 1
	end

	if var_130_9 == 0 and JY.Base.主角职业 == 9 and yongan(arg_130_0) then
		var_130_10 = var_130_10 + 2
	end

	if WAR.ZDDH == 279 and (var_130_9 == 659 or var_130_9 == 660 or var_130_9 == 661 or var_130_9 == 662 or var_130_9 == 663) then
		for iter_130_0 = 0, WAR.PersonNum - 1 do
			if WAR.Person[iter_130_0].死亡 == false and WAR.Person[iter_130_0].我方 == WAR.Person[WAR.CurID].我方 and WAR.Person[WAR.CurID].我方 == false then
				var_130_10 = var_130_10 + 2
			end
		end
	end

	local var_130_14

	var_130_14 = var_130_8 == 1 and 0 or (var_130_8 == 2 or var_130_8 == 3 or var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 ~= 3) and 1 or var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 == 3 and 2 or var_130_14

	local var_130_15 = 0
	local var_130_16 = 0
	local var_130_17 = 0
	local var_130_18 = 0

	if var_130_7 == 0 then
		if var_130_8 == 1 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_10
				var_130_17 = 1
				var_130_18 = 1
				var_130_4 = 0
			else
				var_130_15 = 0
				var_130_16 = 1
				var_130_17 = 0
				var_130_18 = 1
			end
		end

		if var_130_8 == 2 or var_130_8 == 3 or var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 ~= 3 then
			if arg_130_1 > 10 then
				var_130_16 = 2 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
				var_130_4 = 1
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
			end
		end

		if var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 == 3 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 3 + var_130_10
				var_130_17 = 0
				var_130_18 = 1
			else
				var_130_15 = 0
				var_130_16 = 3 + var_130_10
				var_130_17 = 0
				var_130_18 = 1
			end
		end

		if var_130_8 == 7 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = JY.Wugong[arg_130_0]["移动范围" .. 10] + var_130_10 + var_130_12
				var_130_17 = 1
				var_130_18 = 1
			else
				var_130_15 = 0
				var_130_16 = JY.Wugong[arg_130_0]["移动范围" .. arg_130_1]
				var_130_17 = 0
				var_130_18 = 1
			end
		end
	elseif var_130_7 == 1 then
		if var_130_8 == 1 then
			var_130_17 = 10

			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 1
				var_130_17 = 10
				var_130_18 = 7

				if arg_130_0 == 49 then
					var_130_15 = 0
					var_130_16 = 0
					var_130_17 = 1
					var_130_18 = 6
					var_130_4 = var_130_18
				end
			else
				var_130_15 = 0
				var_130_16 = 1
				var_130_17 = 10
				var_130_18 = 4
			end

			if arg_130_1 > 6 then
				var_130_18 = 5
			end
		elseif var_130_8 == 2 then
			if arg_130_1 > 7 then
				var_130_15 = 1
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
				var_130_4 = 2
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
			end
		elseif var_130_8 == 3 then
			if arg_130_1 > 7 then
				var_130_15 = 1
				var_130_16 = 1 + var_130_10
				var_130_17 = 12
				var_130_18 = 1
				var_130_4 = 1
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
			end
		elseif var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 == 3 then
			if arg_130_1 > 10 then
				var_130_15 = 1
				var_130_16 = 1 + var_130_10
				var_130_17 = 12
				var_130_18 = 2
				var_130_4 = 2
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 3
			end
		elseif var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 ~= 3 then
			if arg_130_1 > 10 then
				var_130_15 = 1
				var_130_16 = 2 + var_130_10
				var_130_17 = 12
				var_130_18 = 1
				var_130_4 = 1
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_10
				var_130_17 = 10
				var_130_18 = 2
			end
		end
	elseif var_130_7 == 2 then
		var_130_15 = 0
		var_130_16 = 0 + var_130_12

		if var_130_8 == 1 then
			if arg_130_1 > 6 then
				var_130_17 = 5
				var_130_18 = 1
				var_130_4 = 1
			else
				var_130_17 = 1
				var_130_18 = 1
				var_130_4 = 0
			end

			if arg_130_0 == 16 then
				var_130_15 = 0
				var_130_16 = 0
			end
		elseif var_130_8 == 3 then
			if arg_130_1 > 10 then
				var_130_17 = 8
				var_130_18 = 2
			else
				var_130_17 = 1
				var_130_18 = 2
			end
		elseif arg_130_1 > 6 then
			if var_130_8 == 2 then
				var_130_17 = 1
				var_130_18 = 2
				var_130_4 = var_130_18
			else
				var_130_17 = 2
				var_130_18 = 2
			end
		else
			var_130_17 = 1
			var_130_18 = 2
			var_130_4 = 0
		end

		if var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 == 3 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 0
				var_130_17 = 7
				var_130_18 = 3
				var_130_4 = var_130_18
			else
				var_130_16 = 0
				var_130_17 = 1
				var_130_18 = 3
				var_130_4 = 0
			end
		end
	elseif var_130_7 == 3 then
		var_130_15 = 0
		var_130_16 = 0
		var_130_17 = 3
		var_130_18 = 0

		if JY.Wugong[arg_130_0].武功属性 == 3 then
			if arg_130_1 > 10 then
				var_130_18 = 3
				var_130_4 = 1
			else
				var_130_18 = 2
				var_130_4 = 1
			end
		elseif var_130_8 == 5 then
			if arg_130_1 > 10 then
				var_130_18 = 3
				var_130_4 = var_130_18
			elseif arg_130_1 > 6 then
				var_130_18 = 3
				var_130_4 = var_130_18
			else
				var_130_18 = 2
				var_130_4 = var_130_18
			end
		else
			var_130_18 = 1
		end

		if arg_130_0 == 73 or arg_130_0 == 92 then
			var_130_18 = 6
			var_130_4 = var_130_18
		end

		if JY.Base.主角职业 == 5 and var_130_8 == 5 then
			var_130_16 = 1
		end
	elseif var_130_7 == 4 then
		var_130_17 = 11

		if var_130_8 == 2 then
			if arg_130_1 > 6 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_12
				var_130_17 = 1
				var_130_18 = 2
				var_130_4 = var_130_18
			else
				var_130_15 = 1
				var_130_16 = 2 + var_130_12
				var_130_17 = 12
				var_130_18 = 1
				var_130_4 = 1
			end

			if arg_130_0 == 46 then
				var_130_15 = 0
				var_130_16 = 0
			end
		elseif var_130_8 == 3 then
			if arg_130_1 > 6 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_12
				var_130_17 = 5
				var_130_18 = 2
				var_130_4 = 1
			else
				var_130_15 = 1
				var_130_16 = 1 + var_130_12
				var_130_17 = 10
				var_130_18 = 2
				var_130_4 = 2
			end

			if arg_130_0 == 66 then
				if arg_130_1 > 10 then
					var_130_15 = 1
					var_130_16 = 1 + var_130_12
					var_130_17 = 11
					var_130_18 = 3
					var_130_4 = 2
				else
					var_130_15 = 1
					var_130_16 = 1
					var_130_17 = 11
					var_130_18 = 2
					var_130_4 = 2
				end
			end
		elseif var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 ~= 3 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_12
				var_130_17 = 6
				var_130_18 = 2
				var_130_4 = var_130_18
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_12
				var_130_18 = 1
				var_130_4 = 2
			end
		else
			var_130_15 = 0
			var_130_16 = 1 + var_130_12
			var_130_17 = 11
			var_130_18 = 2
			var_130_4 = 1
		end
	elseif var_130_7 == 5 then
		var_130_17 = 12

		if var_130_8 == 3 then
			if arg_130_1 > 6 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_12
				var_130_17 = 5
				var_130_18 = 2
				var_130_4 = 1
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_12
				var_130_18 = 1
				var_130_4 = 1
			end
		elseif var_130_8 == 4 and JY.Wugong[arg_130_0].武功属性 ~= 3 then
			if arg_130_1 > 10 then
				var_130_15 = 0
				var_130_16 = 0 + var_130_12
				var_130_17 = 8
				var_130_18 = 2
				var_130_4 = 2
			else
				var_130_15 = 0
				var_130_16 = 1 + var_130_12
				var_130_18 = 1
				var_130_4 = 1
			end
		else
			var_130_15 = 0
			var_130_16 = 1 + var_130_12
			var_130_18 = 1
			var_130_4 = 1
		end
	end

	return var_130_15, var_130_16, var_130_17, var_130_18, var_130_4, var_130_5, var_130_6
end

function isteam(arg_131_0)
	local var_131_0 = false

	for iter_131_0, iter_131_1 in pairs(CC.PersonExit) do
		if iter_131_1[1] == arg_131_0 then
			var_131_0 = true

			break
		end
	end

	if arg_131_0 == 0 then
		var_131_0 = true
	end

	return var_131_0
end

function PersonKF(arg_132_0, arg_132_1)
	for iter_132_0 = 1, CC.Kungfunum do
		if JY.Person[arg_132_0]["武功" .. iter_132_0] == -1 then
			return false
		elseif JY.Person[arg_132_0]["武功" .. iter_132_0] == arg_132_1 then
			return true
		end
	end

	return false
end

function PersonKFJ(arg_133_0, arg_133_1)
	for iter_133_0 = 1, CC.Kungfunum do
		if JY.Person[arg_133_0]["武功" .. iter_133_0] == -1 then
			return false
		elseif JY.Person[arg_133_0]["武功" .. iter_133_0] == arg_133_1 and JY.Person[arg_133_0]["武功等级" .. iter_133_0] == 999 then
			return true
		end
	end

	return false
end

function myrandom(arg_134_0, arg_134_1)
	for iter_134_0 = 0, WAR.PersonNum - 1 do
		local var_134_0 = WAR.Person[iter_134_0].人物编号

		if WAR.Person[iter_134_0].死亡 == false and cxtd(var_134_0, 76) and instruct_16(arg_134_1) then
			arg_134_0 = arg_134_0 + 5
		end
	end

	for iter_134_1 = 1, CC.Kungfunum do
		if JY.Person[arg_134_1]["武功" .. iter_134_1] == 102 then
			arg_134_0 = arg_134_0 + (math.modf(JY.Person[arg_134_1]["武功等级" .. iter_134_1] / 100) + 1)
		end
	end

	arg_134_0 = math.modf(arg_134_0 + JY.Person[arg_134_1].生命最大值 * 4 / (JY.Person[arg_134_1].生命 + 20) + JY.Person[arg_134_1].体力 / 20)

	if cxtd(arg_134_1, 38) then
		arg_134_0 = arg_134_0 + 20
	end

	if WAR.tmp[1000 + arg_134_1] == 1 then
		arg_134_0 = arg_134_0 + 40
	end

	if instruct_16(arg_134_1) or ybdw(arg_134_1) then
		for iter_134_2 = 1, #TeamP do
			if TeamP[iter_134_2] == arg_134_1 then
				local var_134_1 = math.modf(JY.Person[arg_134_1].实战 / 25 + 1)

				if var_134_1 > 20 then
					var_134_1 = 20
				end

				arg_134_0 = arg_134_0 + var_134_1
			end
		end
	end

	for iter_134_3 = 0, WAR.PersonNum - 1 do
		local var_134_2 = WAR.Person[iter_134_3].人物编号

		if WAR.Person[iter_134_3].死亡 == false and WAR.Person[iter_134_3].我方 and cxtd(var_134_2, 5003) then
			arg_134_0 = arg_134_0 + 5
		end
	end

	for iter_134_4 = 0, WAR.PersonNum - 1 do
		local var_134_3 = WAR.Person[iter_134_4].人物编号

		if WAR.Person[iter_134_4].死亡 == false and WAR.Person[iter_134_4].我方 and cxtd(var_134_3, 5004) then
			arg_134_0 = arg_134_0 + 10
		end
	end

	if cxtd(arg_134_1, 12) then
		for iter_134_5 = 1, #TeamP do
			if TeamP[iter_134_5] == arg_134_1 then
				local var_134_4 = math.modf(JY.Person[arg_134_1].实战 / 25 + 1)

				if var_134_4 > 20 then
					var_134_4 = 20
				end

				arg_134_0 = arg_134_0 + var_134_4
			end
		end
	end

	arg_134_0 = arg_134_0 + limitX(math.modf(JY.Person[arg_134_1].内力 / 500), 0, 20)

	local var_134_5 = 1

	if instruct_16(arg_134_1) then
		if JY.Person[arg_134_1].悟性 < math.random(120) - 10 then
			var_134_5 = 2
		end

		if T1LEQ(arg_134_1) and JY.Base.觉醒 == 1 then
			var_134_5 = 2
		end
	else
		var_134_5 = 3
		arg_134_0 = arg_134_0 + 40
	end

	for iter_134_6 = 1, var_134_5 do
		if arg_134_0 >= math.random(120) + 10 then
			return true
		end
	end

	return false
end

function War_AutoSelectEnemy()
	local var_135_0 = War_AutoSelectEnemy_near()

	WAR.Person[WAR.CurID].自动选择对手 = var_135_0

	return var_135_0
end

function War_AutoSelectEnemy_near()
	War_CalMoveStep(WAR.CurID, 100, 1)

	local var_136_0 = math.huge
	local var_136_1 = -1

	for iter_136_0 = 0, WAR.PersonNum - 1 do
		if WAR.Person[WAR.CurID].我方 ~= WAR.Person[iter_136_0].我方 and WAR.Person[iter_136_0].死亡 == false then
			local var_136_2 = GetWarMap(WAR.Person[iter_136_0].坐标X, WAR.Person[iter_136_0].坐标Y, 3)

			if var_136_2 < var_136_0 then
				var_136_1 = iter_136_0
				var_136_0 = var_136_2
			end
		end
	end

	return var_136_1
end

function NewWARPersonZJ(arg_137_0, arg_137_1, arg_137_2, arg_137_3, arg_137_4, arg_137_5)
	WAR.Person[WAR.PersonNum].人物编号 = arg_137_0
	WAR.Person[WAR.PersonNum].我方 = arg_137_1
	WAR.Person[WAR.PersonNum].坐标X = arg_137_2
	WAR.Person[WAR.PersonNum].坐标Y = arg_137_3
	WAR.Person[WAR.PersonNum].死亡 = arg_137_4
	WAR.Person[WAR.PersonNum].人方向 = arg_137_5
	WAR.Person[WAR.PersonNum].贴图 = WarCalPersonPic(WAR.PersonNum)

	lib.PicLoadFile(string.format(CC.FightPicFile[1], JY.Person[arg_137_0].头像代号), string.format(CC.FightPicFile[2], JY.Person[arg_137_0].头像代号), 4 + WAR.PersonNum)
	SetWarMap(arg_137_2, arg_137_3, 2, WAR.PersonNum)
	SetWarMap(arg_137_2, arg_137_3, 5, WAR.Person[WAR.PersonNum].贴图)

	WAR.PersonNum = WAR.PersonNum + 1
end

function War_StatusMenu()
	WAR.ShowHead = 0

	Menu_Status()

	WAR.ShowHead = 1

	Cls()
end

function War_PersonTrainBook(arg_139_0)
	local var_139_0 = JY.Person[arg_139_0]
	local var_139_1 = var_139_0.修炼物品

	if var_139_1 < 0 then
		return
	end

	local var_139_2 = JY.Thing[var_139_1].练出武功
	local var_139_3 = 0
	local var_139_4 = 0

	for iter_139_0 = 1, CC.YbNum do
		var_139_4 = arg_139_0 == JY.Base["佣兵" .. iter_139_0] and 12 or 20
	end

	if JY.Person[arg_139_0]["武功" .. var_139_4] > 0 and var_139_2 >= 0 then
		for iter_139_1 = 1, var_139_4 do
			if JY.Thing[var_139_1].练出武功 == JY.Person[arg_139_0]["武功" .. iter_139_1] then
				var_139_3 = 1
			end
		end

		if var_139_3 == 0 then
			return
		end
	end

	local var_139_5 = Rnd(5)
	local var_139_6 = 0

	if var_139_2 > 0 then
		if JY.Wugong[var_139_2].武功类型 == 1 then
			var_139_6 = 1
		end

		if JY.Wugong[var_139_2].武功类型 == 2 then
			var_139_6 = 2
		end

		if JY.Wugong[var_139_2].武功类型 == 3 then
			var_139_6 = 3
		end

		if JY.Wugong[var_139_2].武功类型 == 4 then
			var_139_6 = 4
		end

		if JY.Wugong[var_139_2].武功类型 == 6 then
			var_139_6 = 1
		end

		if JY.Wugong[var_139_2].武功类型 == 7 then
			var_139_6 = 5
		end
	end

	local var_139_7 = false
	local var_139_8 = false
	local var_139_9

	while true do
		local var_139_10 = TrainNeedExp(arg_139_0)

		if var_139_10 <= var_139_0.修炼点数 then
			local var_139_11 = {
				{
					read_nump(1),
					"拳掌功夫",
					JY.Thing[var_139_1].加拳掌功夫
				},
				{
					read_nump(2),
					"御剑能力",
					JY.Thing[var_139_1].加御剑能力
				},
				{
					read_nump(3),
					"耍刀技巧",
					JY.Thing[var_139_1].加耍刀技巧
				},
				{
					read_nump(4),
					"特殊兵器",
					JY.Thing[var_139_1].加特殊兵器
				},
				{
					read_nump(5),
					"暗器技巧",
					JY.Thing[var_139_1].加暗器技巧
				}
			}
			local var_139_12 = 0

			if arg_139_0 == 0 then
				for iter_139_2, iter_139_3 in pairs(var_139_11) do
					if iter_139_3[2] == "拳掌功夫" then
						var_139_12 = 1
					end

					if iter_139_3[2] == "御剑能力" then
						var_139_12 = 2
					end

					if iter_139_3[2] == "耍刀技巧" then
						var_139_12 = 3
					end

					if iter_139_3[2] == "特殊兵器" then
						var_139_12 = 4
					end

					if iter_139_3[2] == "暗器技巧" then
						var_139_12 = 5
					end

					if iter_139_3[1] < 1 and JY.Person[0][iter_139_3[2]] == 99 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 80 and JY.Base.游戏难度 > 1 then
						if var_139_5 == 1 then
							DrawStrBoxWaitKey("你虽然辛苦的修炼，然而修炼却似乎遇到了瓶颈", C_WHITE, CC.DefaultFont)
						end

						JY.Person[0].修炼点数 = 1

						return
					end

					if iter_139_3[1] < 2 and JY.Person[0][iter_139_3[2]] == 199 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 90 and JY.Base.游戏难度 > 1 then
						if var_139_5 == 1 then
							DrawStrBoxWaitKey("你虽然辛苦的修炼，修炼却似乎遇到了瓶颈", C_WHITE, CC.DefaultFont)
						end

						JY.Person[0].修炼点数 = 1

						return
					end

					if iter_139_3[1] < 3 and JY.Person[0][iter_139_3[2]] == 299 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 95 and JY.Base.游戏难度 > 1 then
						if var_139_5 == 1 then
							DrawStrBoxWaitKey("你修炼遇到了瓶颈，武功始终没有进步", C_WHITE, CC.DefaultFont)
						end

						JY.Person[0].修炼点数 = 1

						return
					end
				end
			end

			var_139_7 = true

			AddPersonAttrib(arg_139_0, "生命最大值", JY.Thing[var_139_1].加生命最大值)

			if var_139_1 == 139 then
				AddPersonAttrib(arg_139_0, "生命最大值", -15)
				AddPersonAttrib(arg_139_0, "生命", -15)

				if JY.Person[arg_139_0].生命最大值 < 1 then
					JY.Person[arg_139_0].生命最大值 = 1
				end
			end

			if JY.Person[arg_139_0].生命 < 1 then
				JY.Person[arg_139_0].生命 = 1
			end

			if JY.Thing[var_139_1].改变内力性质 == 2 then
				var_139_0.内力性质 = 2
				JY.Person[arg_139_0].无用2 = 0
				JY.Person[arg_139_0].无用3 = 0
			end

			if JY.Thing[var_139_1].加攻击次数 == 1 then
				var_139_0.左右互搏 = 1
			end

			local var_139_13 = 0
			local var_139_14 = 0
			local var_139_15 = 0

			if JY.Person[arg_139_0].主功体 == var_139_2 then
				var_139_13 = JY.Wugong[JY.Person[arg_139_0].主功体].增幅攻击等级
				var_139_14 = JY.Wugong[JY.Person[arg_139_0].主功体].增幅防御等级
				var_139_15 = JY.Wugong[JY.Person[arg_139_0].主功体].增幅轻功等级
			end

			AddPersonAttrib(arg_139_0, "内力最大值", JY.Thing[var_139_1].加内力最大值)

			if cxtd(arg_139_0, 5119) or cxtd(arg_139_0, 183) then
				AddPersonAttrib(arg_139_0, "攻击力", JY.Thing[var_139_1].加攻击力 * 2 + var_139_13)
			else
				AddPersonAttrib(arg_139_0, "攻击力", JY.Thing[var_139_1].加攻击力 + var_139_13)
			end

			if cxtd(arg_139_0, 90) or cxtd(arg_139_0, 105) or cxtd(arg_139_0, 130) or cxtd(arg_139_0, 183) then
				AddPersonAttrib(arg_139_0, "轻功", JY.Thing[var_139_1].加轻功 * 2 + var_139_15)
			else
				AddPersonAttrib(arg_139_0, "轻功", JY.Thing[var_139_1].加轻功 + var_139_15)
			end

			if cxtd(arg_139_0, 5121) or cxtd(arg_139_0, 183) then
				AddPersonAttrib(arg_139_0, "防御力", JY.Thing[var_139_1].加防御力 * 2 + var_139_14)
			else
				AddPersonAttrib(arg_139_0, "防御力", JY.Thing[var_139_1].加防御力 + var_139_14)
			end

			AddPersonAttrib(arg_139_0, "医疗能力", JY.Thing[var_139_1].加医疗能力)
			AddPersonAttrib(arg_139_0, "用毒能力", JY.Thing[var_139_1].加用毒能力)
			AddPersonAttrib(arg_139_0, "解毒能力", JY.Thing[var_139_1].加解毒能力)

			if arg_139_0 == 0 and JY.Base.主角职业 == 8 and JY.Person[arg_139_0].抗毒能力 < 60 then
				AddPersonAttrib(arg_139_0, "抗毒能力", JY.Thing[var_139_1].加抗毒能力)
			elseif JY.Person[arg_139_0].抗毒能力 < 30 then
				AddPersonAttrib(arg_139_0, "抗毒能力", JY.Thing[var_139_1].加抗毒能力)
			end

			if cxtd(arg_139_0, 56) then
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫 * 2)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力 * 2)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧 * 2)
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器 * 2)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧 * 2)
			elseif cxtd(arg_139_0, 590) then
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器 * 2)
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			elseif cxtd(arg_139_0, 182) then
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫 * 2)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			elseif cxtd(arg_139_0, 5123) then
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力 * 2)
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			elseif cxtd(arg_139_0, 5124) then
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧 * 2)
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力)
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			elseif cxtd(arg_139_0, 5125) then
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器 * 2)
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			else
				AddPersonAttrib(arg_139_0, "拳掌功夫", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "御剑能力", JY.Thing[var_139_1].加御剑能力)
				AddPersonAttrib(arg_139_0, "耍刀技巧", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "特殊兵器", JY.Thing[var_139_1].加特殊兵器)
				AddPersonAttrib(arg_139_0, "暗器技巧", JY.Thing[var_139_1].加暗器技巧)
			end

			if cxtd(arg_139_0, 77) then
				AddPersonAttrib(arg_139_0, "攻击力", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "轻功", JY.Thing[var_139_1].加耍刀技巧)
				AddPersonAttrib(arg_139_0, "防御力", JY.Thing[var_139_1].加耍刀技巧)
			end

			if cxtd(arg_139_0, 182) then
				AddPersonAttrib(arg_139_0, "攻击力", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "轻功", JY.Thing[var_139_1].加拳掌功夫)
				AddPersonAttrib(arg_139_0, "防御力", JY.Thing[var_139_1].加拳掌功夫)
			end

			AddPersonAttrib(arg_139_0, "武学常识", JY.Thing[var_139_1].加武学常识)
			AddPersonAttrib(arg_139_0, "品德", JY.Thing[var_139_1].加品德)
			AddPersonAttrib(arg_139_0, "攻击带毒", JY.Thing[var_139_1].加攻击带毒)

			var_139_0.修炼点数 = var_139_0.修炼点数 - var_139_10

			if var_139_2 >= 0 then
				var_139_8 = true

				local var_139_16 = 0

				for iter_139_4 = 1, var_139_4 do
					if var_139_0["武功" .. iter_139_4] == var_139_2 then
						var_139_16 = 1
						var_139_0["武功等级" .. iter_139_4] = math.modf((var_139_0["武功等级" .. iter_139_4] + 100) / 100) * 100
						var_139_9 = iter_139_4

						break
					end
				end

				if var_139_16 == 0 then
					for iter_139_5 = 1, var_139_4 do
						if var_139_0["武功" .. iter_139_5] == 0 then
							var_139_0["武功" .. iter_139_5] = var_139_2
							var_139_0["武功等级" .. iter_139_5] = 0
							var_139_9 = iter_139_5

							break
						end
					end
				end
			end

			if arg_139_0 == 0 then
				for iter_139_6, iter_139_7 in pairs(var_139_11) do
					if iter_139_7[1] < 1 and JY.Person[0][iter_139_7[2]] + iter_139_7[3] > 99 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 80 and JY.Base.游戏难度 > 1 then
						JY.Person[0][iter_139_7[2]] = 99
					end

					if iter_139_7[1] < 2 and JY.Person[0][iter_139_7[2]] + iter_139_7[3] > 199 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 90 and JY.Base.游戏难度 > 1 then
						JY.Person[0][iter_139_7[2]] = 199
					end

					if iter_139_7[1] < 3 and JY.Person[0][iter_139_7[2]] + iter_139_7[3] > 299 and var_139_6 == var_139_12 and JY.Person[0].悟性 < 95 and JY.Base.游戏难度 > 1 then
						JY.Person[0][iter_139_7[2]] = 299
					end
				end
			end
		else
			break
		end
	end

	if var_139_7 then
		DrawStrBoxWaitKey(string.format("%s 修炼 %s 成功", var_139_0.姓名, JY.Thing[var_139_1].名称), C_WHITE, CC.DefaultFont)
	end

	if var_139_8 then
		DrawStrBoxWaitKey(string.format("%s 升为第%s级", JY.Wugong[var_139_2].名称, math.modf(var_139_0["武功等级" .. var_139_9] / 100) + 1), C_WHITE, CC.DefaultFont)
	end
end

function My_ZCXX()
	local var_140_0 = WAR.Person[WAR.CurID].坐标X
	local var_140_1 = WAR.Person[WAR.CurID].坐标Y

	for iter_140_0 = 0, WAR.PersonNum - 1 do
		local var_140_2 = WAR.Person[iter_140_0].人物编号

		if WAR.Person[iter_140_0].死亡 == false then
			local var_140_3 = WAR.Person[iter_140_0].坐标X - var_140_0
			local var_140_4 = WAR.Person[iter_140_0].坐标Y - var_140_1
			local var_140_5 = CC.XScale * (var_140_3 - var_140_4) + CC.ScreenW / 2
			local var_140_6 = CC.YScale * (var_140_3 + var_140_4) + CC.ScreenH / 2 - GetS(JY.SubScene, var_140_3 + var_140_0, var_140_4 + var_140_1, 4) - CC.YScale * 7
			local var_140_7 = WAR.Person[iter_140_0].人物编号
			local var_140_8 = JY.Person[var_140_7].姓名
			local var_140_9 = JY.Person[var_140_7].生命
			local var_140_10 = JY.Person[var_140_7].生命最大值
			local var_140_11 = C_WHITE

			if var_140_9 < math.modf(var_140_10 / 2) then
				var_140_11 = C_GOLD
			end

			if var_140_9 < math.modf(var_140_10 / 5) then
				var_140_11 = C_RED
			end

			if CC.Base_S.名字显示 == 1 then
				MyDrawString(var_140_5, var_140_5 + 0, var_140_6 + CONFIG.Zoom / 2 + 25, var_140_8, var_140_11, 24)
				MyDrawString(var_140_5, var_140_5 + 0, var_140_6 + CONFIG.Zoom / 2 + 50, "命:" .. var_140_9, var_140_11, 24)
			else
				MyDrawString(var_140_5, var_140_5 + 0, var_140_6 + CONFIG.Zoom / 2 + 25, "命:" .. var_140_9, var_140_11, 24)
			end

			local var_140_12 = WAR.Person[iter_140_0].人物编号
			local var_140_13 = JY.Person[var_140_12].姓名
			local var_140_14 = JY.Person[var_140_12].生命
			local var_140_15 = JY.Person[var_140_12].生命最大值
			local var_140_16 = JY.Person[var_140_12].内力
			local var_140_17 = JY.Person[var_140_12].内力最大值
			local var_140_18 = C_RED
			local var_140_19 = M_RoyalBlue
		end
	end
end

function DrawBox3(arg_141_0, arg_141_1, arg_141_2, arg_141_3, arg_141_4)
	lib.DrawRect(arg_141_0, arg_141_1, arg_141_2, arg_141_1, arg_141_4)
	lib.DrawRect(arg_141_0, arg_141_3, arg_141_2, arg_141_3, arg_141_4)
	lib.DrawRect(arg_141_0, arg_141_1, arg_141_0, arg_141_3, arg_141_4)
	lib.DrawRect(arg_141_2, arg_141_1, arg_141_2, arg_141_3, arg_141_4)
end

function cxtd(arg_142_0, arg_142_1)
	if arg_142_0 == arg_142_1 then
		return true
	end

	if JY.Base.队伍1 == arg_142_0 and JY.Base.畅想编号 == arg_142_1 then
		return true
	end

	if arg_142_0 == 9999 and JY.Person[arg_142_0].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Base.畅想编号 == arg_142_1 then
		return true
	end

	if JY.Person[arg_142_0].天赋 == arg_142_1 then
		return true
	end

	if JY.Person[arg_142_0].天赋2 == arg_142_1 then
		return true
	end

	if JY.Person[arg_142_0].天赋3 == arg_142_1 then
		return true
	end

	if JY.Person[arg_142_0].天赋4 == arg_142_1 then
		return true
	end

	if JY.Person[arg_142_0].天赋5 == arg_142_1 then
		return true
	end

	return false
end

function gtjl(arg_143_0, arg_143_1, arg_143_2)
	if JY.Person[arg_143_0].主功体 == arg_143_1 and arg_143_1 == arg_143_2 then
		return true
	end

	return false
end

function gtht(arg_144_0, arg_144_1, arg_144_2)
	if JY.Person[arg_144_0].主功体 == arg_144_1 and arg_144_1 == arg_144_2 then
		return true
	end

	return false
end
