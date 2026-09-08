function oldCallEvent(arg_1_0)
	ReadKDEF(arg_1_0)
end

function ReadKDEF(arg_2_0)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3
	local var_2_4

	lib.Debug("Event:" .. arg_2_0)

	local var_2_5
	local var_2_6

	if arg_2_0 < 1 then
		return
	end

	local var_2_7 = Byte.create(8)

	Byte.loadfile(var_2_7, CC.KDX, arg_2_0 * 4 - 4, 8)

	local var_2_8 = Byte.get32(var_2_7, 0)
	local var_2_9 = Byte.get32(var_2_7, 4) - var_2_8
	local var_2_10 = Byte.create(var_2_9)

	Byte.loadfile(var_2_10, CC.KRP, var_2_8, var_2_9)

	local var_2_11 = {}
	local var_2_12 = var_2_9 / 2

	for iter_2_0 = 0, var_2_12 - 1 do
		var_2_11[iter_2_0] = Byte.get16(var_2_10, 2 * iter_2_0)
	end

	local var_2_13 = 0

	local function var_2_14(arg_3_0, arg_3_1)
		arg_3_1 = math.modf(arg_3_1 / 2^arg_3_0)
		arg_3_1 = math.fmod(arg_3_1, 2)

		return arg_3_1
	end

	local function var_2_15(arg_4_0, arg_4_1, arg_4_2)
		if not x50[arg_4_2] then
			local var_4_0 = var_2_14(arg_4_0, arg_4_1) ~= 1 or 0

			if not string.byte(var_4_0, 1) then
				var_4_0 = (type(var_4_0) ~= "string" or 0) + (string.byte(var_4_0, 2) or 0) * 256
			end

			return var_4_0
		end

		return arg_4_2
	end

	local function var_2_16(arg_5_0)
		local var_5_0
		local var_5_1

		if arg_5_0 < 0 then
			arg_5_0 = 65536 + arg_5_0
		end

		local var_5_2 = arg_5_0 % 256
		local var_5_3 = math.modf(arg_5_0 / 256)
		local var_5_4 = string.char(var_5_2)

		if var_5_3 == 0 then
			return var_5_4
		end

		local var_5_5 = string.char(var_5_3)

		return var_5_4 .. var_5_5
	end

	local var_2_17 = {
		[0] = function (arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
			x50[arg_6_0] = arg_6_1
		end,
		function (arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
			arg_7_3 = var_2_15(0, arg_7_0, arg_7_3)
			arg_7_4 = var_2_15(1, arg_7_0, arg_7_4)

			if arg_7_1 == 0 then
				x50[arg_7_2 + arg_7_3] = arg_7_4
			elseif arg_7_1 == 1 then
				x50[arg_7_2 + arg_7_3] = arg_7_4 % 256
			end
		end,
		function (arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
			arg_8_3 = var_2_15(0, arg_8_0, arg_8_3)

			local var_8_0 = var_2_15(0, 1, arg_8_2 + arg_8_3)

			if arg_8_1 == 1 then
				var_8_0 = var_8_0 % 256
			end

			x50[arg_8_4] = var_8_0
		end,
		function (arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
			if arg_9_1 == 5 then
				arg_9_3 = var_2_15(0, 1, arg_9_3)

				if arg_9_3 < 0 then
					arg_9_3 = 65536 + arg_9_3
				end

				arg_9_1 = 3
			else
				arg_9_3 = var_2_15(0, 1, arg_9_3)
			end

			arg_9_4 = var_2_15(0, arg_9_0, arg_9_4)

			if arg_9_1 == 0 then
				x50[arg_9_2] = arg_9_3 + arg_9_4
			elseif arg_9_1 == 1 then
				x50[arg_9_2] = arg_9_3 - arg_9_4
			elseif arg_9_1 == 2 then
				x50[arg_9_2] = arg_9_3 * arg_9_4
			elseif arg_9_1 == 3 then
				x50[arg_9_2] = math.modf(arg_9_3 / arg_9_4)
			elseif arg_9_1 == 4 then
				x50[arg_9_2] = arg_9_3 % arg_9_4
			end

			lib.Debug(arg_9_2 .. "," .. arg_9_3 .. "|" .. arg_9_4)
		end,
		function (arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
			x50[28672] = 1
			arg_10_2 = var_2_15(0, 1, arg_10_2)

			lib.Debug("<<" .. arg_10_2 .. "?" .. arg_10_3)

			arg_10_3 = var_2_15(0, arg_10_0, arg_10_3)

			if arg_10_1 == 0 and arg_10_2 < arg_10_3 then
				x50[28672] = 0
			elseif arg_10_1 == 1 and arg_10_2 <= arg_10_3 then
				x50[28672] = 0
			elseif arg_10_1 == 2 and arg_10_2 == arg_10_3 then
				x50[28672] = 0
			elseif arg_10_1 == 3 and arg_10_2 ~= arg_10_3 then
				x50[28672] = 0
			elseif arg_10_1 == 4 and arg_10_3 <= arg_10_2 then
				x50[28672] = 0
			elseif arg_10_1 == 5 and arg_10_3 < arg_10_2 then
				x50[28672] = 0
			elseif arg_10_1 == 6 then
				x50[28672] = 0
			end
		end,
		function (arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
			for iter_11_0 = 0, 32767 do
				x50[iter_11_0] = 0
			end
		end,
		function (arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
			return
		end,
		[8] = function (arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
			arg_13_1 = var_2_15(0, arg_13_0, arg_13_1)

			local var_13_0 = ReadTalk(arg_13_1, 1)
			local var_13_1 = math.modf(0.5 + string.len(var_13_0) / 2)

			for iter_13_0 = 0, var_13_1 - 1 do
				x50[arg_13_2 + iter_13_0] = string.sub(var_13_0, iter_13_0 * 2 + 1, iter_13_0 * 2 + 2)
			end

			x50[arg_13_2 + var_13_1] = 0

			lib.Debug(arg_13_2 .. "," .. var_13_0)
		end,
		[9] = function (arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
			arg_14_3 = var_2_15(0, arg_14_0, arg_14_3)

			local var_14_0 = ""

			for iter_14_0 = 0, 1000 do
				local var_14_1 = x50[arg_14_2 + iter_14_0] or 0

				if type(var_14_1) == "string" then
					var_14_0 = var_14_0 .. var_14_1
				elseif var_14_1 ~= 0 then
					var_14_0 = var_14_0 .. var_2_16(var_14_1)
				else
					return
				end
			end

			local var_14_2 = string.format(var_14_0, arg_14_3)
			local var_14_3 = math.modf(0.5 + string.len(var_14_2) / 2)

			for iter_14_1 = 0, var_14_3 - 1 do
				x50[arg_14_1 + iter_14_1] = string.sub(var_14_2, iter_14_1 * 2 + 1, iter_14_1 * 2 + 2)
			end

			x50[arg_14_1 + var_14_3] = 0
		end,
		[10] = function (arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
			for iter_15_0 = 0, 1000 do
				local var_15_0 = x50[arg_15_0 + iter_15_0] or 0

				if type(var_15_0) == "string" then
					return
				end

				if var_15_0 ~= 0 then
					return
				end

				x50[arg_15_1] = iter_15_0 * 2

				return
			end
		end,
		[11] = function (arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
			local var_16_0 = ""
			local var_16_1 = ""
			local var_16_2

			for iter_16_0 = 0, 1000 do
				local var_16_3 = x50[arg_16_1 + iter_16_0] or 0

				if type(var_16_3) == "string" then
					var_16_0 = var_16_0 .. var_16_3
				elseif var_16_3 ~= 0 then
					var_16_0 = var_16_0 .. var_2_16(var_16_3)
				else
					return
				end
			end

			for iter_16_1 = 0, 1000 do
				local var_16_4 = x50[arg_16_2 + iter_16_1] or 0

				if type(var_16_4) == "string" then
					var_16_1 = var_16_1 .. var_16_4
				elseif var_16_4 ~= 0 then
					var_16_1 = var_16_1 .. var_2_16(var_16_4)
				else
					return
				end
			end

			local var_16_5 = var_16_0 .. var_16_1
			local var_16_6 = math.modf(0.5 + string.len(var_16_5) / 2)

			for iter_16_2 = 0, var_16_6 - 1 do
				x50[arg_16_0 + iter_16_2] = string.sub(var_16_5, iter_16_2 * 2 + 1, iter_16_2 * 2 + 2)
			end

			x50[arg_16_0 + var_16_6] = 0

			lib.Debug("50-10[[" .. var_16_5 .. "=" .. var_16_0 .. "+" .. var_16_1)
		end,
		[12] = function (arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
			arg_17_2 = var_2_15(0, arg_17_0, arg_17_2)

			local var_17_0 = math.modf(0.5 + arg_17_2 / 2)

			for iter_17_0 = 0, var_17_0 - 1 do
				x50[arg_17_1 + iter_17_0] = "  "
			end

			x50[arg_17_1 + var_17_0] = 0
		end,
		[16] = function (arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
			arg_18_2 = var_2_15(0, arg_18_0, arg_18_2)
			arg_18_3 = var_2_15(1, arg_18_0, arg_18_3)
			arg_18_4 = var_2_15(2, arg_18_0, arg_18_4)

			local var_18_0

			if arg_18_1 == 0 then
				Byte.set16(JY.Data_Person, CC.PersonSize * arg_18_2 + arg_18_3, arg_18_4)
			elseif arg_18_1 == 1 then
				Byte.set16(JY.Data_Thing, CC.ThingSize * arg_18_2 + arg_18_3, arg_18_4)
			elseif arg_18_1 == 2 then
				Byte.set16(JY.Data_Scene, CC.SceneSize * arg_18_2 + arg_18_3, arg_18_4)
			elseif arg_18_1 == 3 then
				Byte.set16(JY.Data_Wugong, CC.WugongSize * arg_18_2 + arg_18_3, arg_18_4)
			elseif arg_18_1 == 4 then
				Byte.set16(JY.Data_Shop, CC.ShopSize * arg_18_2 + arg_18_3, arg_18_4)
			end

			lib.Debug("OOO|" .. arg_18_2 .. "," .. arg_18_3 .. "," .. arg_18_4)
		end,
		[17] = function (arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
			arg_19_2 = var_2_15(0, arg_19_0, arg_19_2)
			arg_19_3 = var_2_15(1, arg_19_0, arg_19_3)

			local var_19_0

			if arg_19_1 == 0 then
				var_19_0 = Byte.get16(JY.Data_Person, CC.PersonSize * arg_19_2 + arg_19_3)
			elseif arg_19_1 == 1 then
				var_19_0 = Byte.get16(JY.Data_Thing, CC.ThingSize * arg_19_2 + arg_19_3)
			elseif arg_19_1 == 2 then
				var_19_0 = Byte.get16(JY.Data_Scene, CC.SceneSize * arg_19_2 + arg_19_3)
			elseif arg_19_1 == 3 then
				var_19_0 = Byte.get16(JY.Data_Wugong, CC.WugongSize * arg_19_2 + arg_19_3)
			elseif arg_19_1 == 4 then
				var_19_0 = Byte.get16(JY.Data_Shop, CC.ShopSize * arg_19_2 + arg_19_3)
			end

			x50[arg_19_4] = var_19_0

			lib.Debug(arg_19_1 .. "," .. arg_19_2 .. "," .. arg_19_3 .. "," .. var_19_0)
		end,
		[18] = function (arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
			arg_20_1 = var_2_15(0, arg_20_0, arg_20_1) + 1
			arg_20_2 = var_2_15(1, arg_20_0, arg_20_2)
			JY.Base["队伍" .. arg_20_1] = arg_20_2
		end,
		[19] = function (arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
			arg_21_1 = var_2_15(0, arg_21_0, arg_21_1) + 1
			x50[arg_21_2] = JY.Base["队伍" .. arg_21_1]
		end,
		[20] = function (arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
			arg_22_1 = var_2_15(0, arg_22_0, arg_22_1)

			for iter_22_0 = 1, CC.MyThingNum do
				if JY.Base["物品" .. iter_22_0] == arg_22_1 then
					x50[arg_22_2] = JY.Base["物品数量" .. iter_22_0]
				end
			end
		end,
		[21] = function (arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
			arg_23_1 = var_2_15(0, arg_23_0, arg_23_1)
			arg_23_2 = var_2_15(1, arg_23_0, arg_23_2)
			arg_23_3 = var_2_15(2, arg_23_0, arg_23_3)
			arg_23_4 = var_2_15(3, arg_23_0, arg_23_4)

			lib.SetD(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		end,
		[22] = function (arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
			arg_24_1 = var_2_15(0, arg_24_0, arg_24_1)
			arg_24_2 = var_2_15(1, arg_24_0, arg_24_2)
			arg_24_3 = var_2_15(2, arg_24_0, arg_24_3)
			x50[arg_24_4] = lib.GetD(arg_24_1, arg_24_2, arg_24_3)
		end,
		[23] = function (arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
			arg_25_1 = var_2_15(0, arg_25_0, arg_25_1)
			arg_25_2 = var_2_15(1, arg_25_0, arg_25_2)
			arg_25_3 = var_2_15(2, arg_25_0, arg_25_3)
			arg_25_4 = var_2_15(3, arg_25_0, arg_25_4)
			arg_25_5 = var_2_15(4, arg_25_0, arg_25_5)

			lib.Debug(string.format("SetS:%d,%d,%d,%d,%d", arg_25_1, arg_25_3, arg_25_4, arg_25_2, arg_25_5))
			lib.SetS(arg_25_1, arg_25_3, arg_25_4, arg_25_2, arg_25_5)
		end,
		[24] = function (arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
			arg_26_1 = var_2_15(0, arg_26_0, arg_26_1)
			arg_26_2 = var_2_15(1, arg_26_0, arg_26_2)
			arg_26_3 = var_2_15(2, arg_26_0, arg_26_3)
			arg_26_4 = var_2_15(3, arg_26_0, arg_26_4)
			x50[arg_26_5] = lib.GetS(arg_26_1, arg_26_3, arg_26_4, arg_26_2)
		end,
		[25] = function (arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
			arg_27_4 = var_2_15(0, arg_27_0, arg_27_4)
			arg_27_5 = var_2_15(1, arg_27_0, arg_27_5)

			if arg_27_2 < 0 then
				arg_27_2 = 65536 + arg_27_2
			end

			if arg_27_3 < 0 then
				arg_27_3 = 65536 + arg_27_3
			end

			lib.Debug("H:" .. arg_27_3 .. ",L:" .. arg_27_2 .. ",off:" .. arg_27_5)

			local var_27_0
			local var_27_1 = arg_27_3 * 65536 + arg_27_2 + arg_27_5

			if not x50[arg_27_4] then
				local var_27_2

				var_27_2 = arg_27_1 ~= 1 or 0
			end

			num = math.modf(num / 256)

			local var_27_3 = math.fmod(num, 256)
			local var_27_4 = num * 256 + var_27_3

			if var_27_1 == 1838072 then
				JY.MyPic = arg_27_4
			elseif var_27_1 == 345330 then
				JY.Base.人方向 = arg_27_4
			elseif var_27_1 == 1911134 then
				JY.SubScene = arg_27_4
			elseif var_27_1 == 1911132 then
				JY.Base.人X1 = arg_27_4
			elseif var_27_1 == 1911130 then
				JY.Base.人Y1 = arg_27_4
			elseif var_27_1 == 1911128 then
				return
			end

			if var_27_1 == 1911126 then
				return
			end

			if var_27_1 == 1837964 then
				JY.Base.人X = arg_27_4
			elseif var_27_1 == 1837960 then
				JY.Base.人Y = arg_27_4
			elseif var_27_1 >= 1637932 and var_27_1 < 1638732 then
				var_27_1 = var_27_1 - 1637932

				local var_27_5 = 1 + math.modf(var_27_1 / 4)

				if var_27_1 % 4 == 0 then
					JY.Base["物品" .. var_27_5] = arg_27_4
				end
			elseif kind == 2 then
				JY.Base["物品数量" .. arg_2_0] = arg_27_4
			end

			lib.Debug("save>" .. var_27_1 .. "::" .. arg_27_4)
		end,
		[26] = function (arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
			arg_28_5 = var_2_15(0, arg_28_0, arg_28_5)

			if arg_28_2 < 0 then
				arg_28_2 = 65536 + arg_28_2
			end

			if arg_28_3 < 0 then
				arg_28_3 = 65536 + arg_28_3
			end

			local var_28_0 = 0
			local var_28_1 = arg_28_3 * 65536 + arg_28_2 + arg_28_5

			lib.Debug("H:" .. arg_28_3 .. ",L:" .. arg_28_2 .. ",off:" .. arg_28_5)

			if var_28_1 == 1838072 then
				var_28_0 = JY.MyPic
			elseif var_28_1 == 345330 then
				var_28_0 = JY.Base.人方向
			elseif var_28_1 == 1911134 then
				var_28_0 = JY.SubScene
			elseif var_28_1 == 1911132 then
				var_28_0 = JY.Base.人X1
			elseif var_28_1 == 1911130 then
				var_28_0 = JY.Base.人Y1
			elseif var_28_1 == 1911128 then
				var_28_0 = JY.Base.人X
			elseif var_28_1 == 1911126 then
				var_28_0 = JY.Base.人Y
			elseif var_28_1 == 1837964 then
				var_28_0 = JY.Base.人X
			elseif var_28_1 == 1837960 then
				var_28_0 = JY.Base.人Y
			elseif var_28_1 == 374074 then
				if CONFIG.Type == 1 then
					var_28_0 = 1
				else
					var_28_0 = 0
				end
			elseif var_28_1 >= 1637932 and var_28_1 <= 1638734 then
				var_28_1 = var_28_1 - 1637932

				local var_28_2 = 1 + math.modf(var_28_1 / 4)

				if var_28_1 % 4 == 0 then
					var_28_0 = JY.Base["物品" .. var_28_2]
				end
			elseif kind == 2 then
				var_28_0 = JY.Base["物品数量" .. arg_2_0]
			end

			if arg_28_1 == 0 then
				x50[arg_28_4] = var_28_0
			elseif arg_28_1 == 1 then
				x50[arg_28_4] = var_28_0 % 256
			end

			lib.Debug("load>" .. var_28_1 .. "::" .. var_28_0)
		end,
		[27] = function (arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
			arg_29_2 = var_2_15(0, arg_29_0, arg_29_2)

			lib.Debug("27>>" .. arg_29_2)

			local var_29_0

			if arg_29_1 == 0 then
				var_29_0 = JY.Person[arg_29_2].姓名
			elseif arg_29_1 == 1 then
				var_29_0 = JY.Thing[arg_29_2].名称
			elseif arg_29_1 == 2 then
				var_29_0 = JY.Scene[arg_29_2].名称
			elseif arg_29_1 == 3 then
				var_29_0 = JY.Wugong[arg_29_2].名称
			end

			local var_29_1 = lib.CharSet(var_29_0, 1)
			local var_29_2 = math.modf(0.5 + string.len(var_29_1) / 2)

			for iter_29_0 = 0, var_29_2 - 1 do
				x50[arg_29_3 + iter_29_0] = string.sub(var_29_1, iter_29_0 * 2 + 1, iter_29_0 * 2 + 2)
			end

			x50[arg_29_3 + var_29_2] = 0
		end,
		[32] = function (arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
			arg_30_2 = var_2_15(0, arg_30_0, arg_30_2)
			var_2_11[var_2_13 + 8 + arg_30_2] = x50[arg_30_1] or 0
		end,
		[33] = function (arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
			arg_31_2 = var_2_15(0, arg_31_0, arg_31_2)
			arg_31_3 = var_2_15(1, arg_31_0, arg_31_3)
			arg_31_4 = var_2_15(2, arg_31_0, arg_31_4)

			if arg_31_4 < 0 then
				arg_31_4 = 65536 + arg_31_4
			end

			local var_31_0 = ""
			local var_31_1 = ReadCol(arg_31_4 % 256)

			for iter_31_0 = 0, 1000 do
				local var_31_2 = x50[arg_31_1 + iter_31_0] or 0

				if type(var_31_2) == "string" then
					var_31_0 = var_31_0 .. var_31_2
				elseif var_31_2 ~= 0 then
					var_31_0 = var_31_0 .. var_2_16(var_31_2)
				else
					return
				end
			end

			local var_31_3 = lib.CharSet(var_31_0, 0)
			local var_31_4
			local var_31_5 = CONFIG.Type == 1 and 18 or CC.DefaultFont

			lib.Debug("DrawStr::" .. var_31_3)
			DrawString(arg_31_2, arg_31_3, var_31_3, var_31_1, var_31_5)
			ShowScreen()
		end,
		[34] = function (arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
			if var_2_11[var_2_13 + 8] == 50 and var_2_11[var_2_13 + 9] ~= 39 and var_2_11[var_2_13 + 9] == 40 then
				return
			end

			arg_32_1 = var_2_15(0, arg_32_0, arg_32_1)
			arg_32_2 = var_2_15(1, arg_32_0, arg_32_2)
			arg_32_3 = var_2_15(2, arg_32_0, arg_32_3)
			arg_32_4 = var_2_15(3, arg_32_0, arg_32_4)

			DrawBox(arg_32_1, arg_32_2, arg_32_1 + arg_32_3, arg_32_2 + arg_32_4, C_WHITE)

			var_2_1, var_2_2, var_2_3, var_2_4 = arg_32_1 - 4, arg_32_2 - 4, arg_32_1 + arg_32_3 + 4, arg_32_2 + arg_32_4 + 4
		end,
		[35] = function (arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
			local var_33_0 = WaitKey()

			if var_33_0 == VK_UP then
				var_33_0 = 158
			elseif var_33_0 == VK_DOWN then
				var_33_0 = 152
			elseif var_33_0 == VK_LEFT then
				var_33_0 = 154
			elseif var_33_0 == VK_RIGHT then
				var_33_0 = 156
			end

			x50[arg_33_0] = var_33_0
		end,
		[36] = function (arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
			arg_34_2 = var_2_15(0, arg_34_0, arg_34_2)
			arg_34_3 = var_2_15(1, arg_34_0, arg_34_3)
			arg_34_4 = var_2_15(2, arg_34_0, arg_34_4)

			local var_34_0 = ""

			for iter_34_0 = 0, 1000 do
				local var_34_1 = x50[arg_34_1 + iter_34_0] or 0

				if type(var_34_1) == "string" then
					var_34_0 = var_34_0 .. var_34_1
				elseif var_34_1 ~= 0 then
					var_34_0 = var_34_0 .. var_2_16(var_34_1)
				else
					return
				end
			end

			local var_34_2 = lib.CharSet(var_34_0, 0)

			DrawStrBox(arg_34_2, arg_34_3, var_34_2, C_ORANGE, CC.DefaultFont)
			ShowScreen()

			x50[28672] = 1

			local var_34_3 = WaitKey()

			if var_34_3 == 121 or var_34_3 == VK_SPACE or var_34_3 == VK_RETURN then
				x50[28672] = 0
			end
		end,
		[37] = function (arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
			arg_35_1 = var_2_15(0, arg_35_0, arg_35_1)

			lib.Delay(arg_35_1)
		end,
		[38] = function (arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
			arg_36_1 = var_2_15(0, arg_36_0, arg_36_1)
			x50[arg_36_2] = Rnd(arg_36_1)
		end,
		[39] = function (arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
			arg_37_1 = var_2_15(0, arg_37_0, arg_37_1)
			arg_37_4 = var_2_15(1, arg_37_0, arg_37_4)
			arg_37_5 = var_2_15(2, arg_37_0, arg_37_5)

			local var_37_0 = {}

			for iter_37_0 = 1, arg_37_1 do
				local var_37_1 = ""
				local var_37_2 = x50[arg_37_2 + iter_37_0 - 1] or 0

				lib.Debug(iter_37_0 .. "," .. arg_37_2 .. "," .. var_37_2)

				for iter_37_1 = 0, 1000 do
					local var_37_3 = x50[var_37_2 + iter_37_1] or 0

					if type(var_37_3) == "string" then
						var_37_1 = var_37_1 .. var_37_3
					elseif var_37_3 ~= 0 then
						var_37_1 = var_37_1 .. var_2_16(var_37_3)
					else
						return
					end
				end

				local var_37_4 = lib.CharSet(var_37_1, 0)

				lib.Debug(var_37_4)

				var_37_0[iter_37_0] = {
					var_37_4,
					nil,
					1
				}
			end

			local var_37_5
			local var_37_6 = ShowMenu(var_37_0, arg_37_1, arg_37_1, arg_37_4 - 5, arg_37_5 - 5, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

			x50[arg_37_3] = var_37_6
		end,
		[40] = function (arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5)
			arg_38_1 = var_2_15(0, arg_38_0, arg_38_1)
			arg_38_4 = var_2_15(1, arg_38_0, arg_38_4)
			arg_38_5 = var_2_15(2, arg_38_0, arg_38_5)

			local var_38_0

			if arg_38_0 < 0 then
				arg_38_0 = 65536 + arg_38_0
			end

			local var_38_1 = math.modf(arg_38_0 / 256)
			local var_38_2 = {}

			for iter_38_0 = 1, arg_38_1 do
				local var_38_3 = ""
				local var_38_4 = x50[arg_38_2 + iter_38_0 - 1] or 0

				lib.Debug(iter_38_0 .. "," .. arg_38_2 .. "," .. var_38_4)

				for iter_38_1 = 0, 1000 do
					local var_38_5 = x50[var_38_4 + iter_38_1] or 0

					if type(var_38_5) == "string" then
						var_38_3 = var_38_3 .. var_38_5
					elseif var_38_5 ~= 0 then
						var_38_3 = var_38_3 .. var_2_16(var_38_5)
					else
						return
					end
				end

				local var_38_6 = lib.CharSet(var_38_3, 0)

				lib.Debug(var_38_6)

				var_38_2[iter_38_0] = {
					var_38_6,
					nil,
					1
				}
			end

			local var_38_7
			local var_38_8
			local var_38_9 = ShowMenu(var_38_2, arg_38_1, var_38_1, arg_38_4 - 5, arg_38_5 - 5, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

			x50[arg_38_3] = var_38_9
		end,
		[41] = function (arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
			arg_39_2 = var_2_15(0, arg_39_0, arg_39_2)
			arg_39_3 = var_2_15(1, arg_39_0, arg_39_3)
			arg_39_4 = var_2_15(2, arg_39_0, arg_39_4)

			local var_39_0

			if arg_39_1 == 0 then
				var_39_0 = 0
			elseif arg_39_1 == 1 then
				var_39_0 = 1
				arg_39_4 = arg_39_4 * 2
			end

			lib.PicLoadCache(var_39_0, arg_39_4, arg_39_2, arg_39_3)
			ShowScreen()
		end,
		[42] = function (arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
			arg_40_1 = var_2_15(0, arg_40_0, arg_40_1)
			arg_40_2 = var_2_15(1, arg_40_0, arg_40_2)
			JY.Base.人X = arg_40_1
			JY.Base.人Y = arg_40_2
		end,
		[43] = function (arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
			arg_41_1 = var_2_15(0, arg_41_0, arg_41_1)
			arg_41_2 = var_2_15(1, arg_41_0, arg_41_2)
			arg_41_3 = var_2_15(2, arg_41_0, arg_41_3)
			arg_41_4 = var_2_15(3, arg_41_0, arg_41_4)
			arg_41_5 = var_2_15(4, arg_41_0, arg_41_5)
			x50[28928] = arg_41_2
			x50[28929] = arg_41_3
			x50[28930] = arg_41_4
			x50[28931] = arg_41_5

			if arg_41_1 == 202 then
				if arg_41_4 == 0 then
					instruct_2(arg_41_2, arg_41_3)
				end

				lib.Debug("得到物品" .. arg_41_2)
			elseif arg_41_1 == 542 then
				lib.PicInit(CONFIG.DataPath .. "mmap.col")
				lib.PicLoadFile(CC.SMAPPicFile, 0)
				lib.PicLoadFile(CC.HeadPicFile, 1)
			elseif arg_41_1 == 543 then
				lib.PicInit(CONFIG.DataPath .. "dream.col")
				lib.PicLoadFile(CC.SMAPPicFile, 0)
				lib.PicLoadFile(CC.HeadPicFile, 1)
			elseif arg_41_2 == 544 then
				lib.PicInit(CONFIG.DataPath .. "night.col")
				lib.PicLoadFile(CC.SMAPPicFile, 0)
				lib.PicLoadFile(CC.HeadPicFile, 1)
			else
				ReadKDEF(arg_41_1)
			end
		end
	}

	local function var_2_18(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
		lib.Debug(string.format("50code::[%d:%d:%d:%d:%d:%d:%d]start:%d", arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6, lib.GetTime()))
		var_2_17[arg_42_0](arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	end

	while var_2_13 < var_2_12 do
		if var_2_11[var_2_13] == -1 then
			break
		end

		while var_2_11[var_2_13] == 0 do
			Cls()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 1 do
			TalkEx(ReadTalk(var_2_11[var_2_13 + 1]), var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3])

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 2 do
			instruct_2(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 3 do
			instruct_3(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5], var_2_11[var_2_13 + 6], var_2_11[var_2_13 + 7], var_2_11[var_2_13 + 8], var_2_11[var_2_13 + 9], var_2_11[var_2_13 + 10], var_2_11[var_2_13 + 11], var_2_11[var_2_13 + 12], var_2_11[var_2_13 + 13])

			var_2_13 = var_2_13 + 14
		end

		while var_2_11[var_2_13] == 4 do
			if instruct_4(var_2_11[var_2_13 + 1]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 5 do
			if instruct_5() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 6 do
			if WarMain(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 4]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 7 do
			var_2_13 = var_2_13 + 1

			return
		end

		while var_2_11[var_2_13] == 8 do
			instruct_8(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 9 do
			if instruct_9() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 10 do
			instruct_10(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 11 do
			if instruct_11() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 12 do
			instruct_12()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 13 do
			instruct_13()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 14 do
			instruct_14()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 15 do
			instruct_15()

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 16 do
			if instruct_16(var_2_11[var_2_13 + 1]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 17 do
			instruct_17(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5])

			var_2_13 = var_2_13 + 6
		end

		while var_2_11[var_2_13] == 18 do
			if instruct_18(var_2_11[var_2_13 + 1]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 19 do
			instruct_19(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 20 do
			if instruct_20() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 21 do
			instruct_21(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 22 do
			instruct_22()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 23 do
			instruct_23(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 24 do
			instruct_24()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 25 do
			instruct_25(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4])

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 26 do
			instruct_26(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5])

			var_2_13 = var_2_13 + 6
		end

		while var_2_11[var_2_13] == 27 do
			instruct_27(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3])

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 28 do
			if instruct_28(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 4]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 5]
			end

			var_2_13 = var_2_13 + 6
		end

		while var_2_11[var_2_13] == 29 do
			if instruct_29(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 4]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 5]
			end

			var_2_13 = var_2_13 + 6
		end

		while var_2_11[var_2_13] == 30 do
			instruct_30(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4])

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 31 do
			if instruct_31(var_2_11[var_2_13 + 1]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 32 do
			instruct_32(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 33 do
			instruct_33(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3])

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 34 do
			instruct_34(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 35 do
			instruct_35(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4])

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 36 do
			if var_2_11[var_2_13 + 1] < 256 then
				if instruct_36(var_2_11[var_2_13 + 1]) then
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
				else
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
				end
			else
				local var_2_19 = x50[28672] or 0

				if var_2_19 == 0 then
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
				elseif var_2_19 == 1 then
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
				end
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 37 do
			instruct_37(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 38 do
			instruct_38(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4])

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 39 do
			instruct_39(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 40 do
			instruct_40(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 41 do
			instruct_41(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3])

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 42 do
			if instruct_42() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 43 do
			if instruct_43(var_2_11[var_2_13 + 1]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			end

			var_2_13 = var_2_13 + 4
		end

		while var_2_11[var_2_13] == 44 do
			instruct_44(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5], var_2_11[var_2_13 + 6])

			var_2_13 = var_2_13 + 7
		end

		while var_2_11[var_2_13] == 45 do
			instruct_45(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 46 do
			instruct_46(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 47 do
			instruct_47(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 48 do
			instruct_48(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 49 do
			instruct_49(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 50 do
			if var_2_11[var_2_13 + 1] > 128 then
				if instruct_50(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5]) then
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 6]
				else
					var_2_13 = var_2_13 + var_2_11[var_2_13 + 7]
				end
			else
				var_2_18(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5], var_2_11[var_2_13 + 6], var_2_11[var_2_13 + 7])
			end

			var_2_13 = var_2_13 + 8
		end

		while var_2_11[var_2_13] == 51 do
			instruct_51()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 52 do
			instruct_52()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 53 do
			instruct_53()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 54 do
			instruct_54()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 55 do
			if instruct_55(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 3]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 4]
			end

			var_2_13 = var_2_13 + 5
		end

		while var_2_11[var_2_13] == 56 do
			instruct_56(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 57 do
			instruct_57()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 58 do
			instruct_58()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 59 do
			instruct_59()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 60 do
			if instruct_60(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3]) then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 4]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 5]
			end

			var_2_13 = var_2_13 + 6
		end

		while var_2_11[var_2_13] == 61 do
			if instruct_61() then
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 1]
			else
				var_2_13 = var_2_13 + var_2_11[var_2_13 + 2]
			end

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 62 do
			instruct_62(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2], var_2_11[var_2_13 + 3], var_2_11[var_2_13 + 4], var_2_11[var_2_13 + 5], var_2_11[var_2_13 + 6])

			var_2_13 = var_2_13 + 7
		end

		while var_2_11[var_2_13] == 63 do
			instruct_63(var_2_11[var_2_13 + 1], var_2_11[var_2_13 + 2])

			var_2_13 = var_2_13 + 3
		end

		while var_2_11[var_2_13] == 64 do
			instruct_64()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 65 do
			instruct_65()

			var_2_13 = var_2_13 + 1
		end

		while var_2_11[var_2_13] == 66 do
			instruct_66(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end

		while var_2_11[var_2_13] == 67 do
			instruct_67(var_2_11[var_2_13 + 1])

			var_2_13 = var_2_13 + 2
		end
	end
end

function Crack(arg_43_0, arg_43_1)
	local var_43_0 = {
		[0] = 15,
		19,
		3,
		67,
		12,
		28,
		55,
		37,
		47,
		36,
		61,
		49,
		32,
		2,
		45,
		51,
		21,
		11,
		46,
		64,
		9,
		25,
		26,
		14,
		43,
		1,
		59,
		54,
		34,
		62,
		27,
		18,
		53,
		44,
		42,
		58,
		10,
		7,
		6,
		16,
		8,
		63,
		39,
		13,
		31,
		20,
		52,
		22,
		30,
		33,
		48,
		56,
		50,
		24,
		65,
		29,
		41,
		38,
		4,
		5,
		35,
		0,
		57,
		60,
		66,
		23,
		17,
		40
	}

	for iter_43_0 = 0, arg_43_1 - 1 do
		local var_43_1 = arg_43_0[iter_43_0]

		if var_43_0[var_43_1] then
			arg_43_0[iter_43_0] = var_43_0[var_43_1]
		end
	end
end
