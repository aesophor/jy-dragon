OEVENTLUA[9001] = function ()
	Cls()

	local var_1_0 = 0
	local var_1_1 = JY.Person[727].好感度 >= 60 and "金狗" or "元狗"

	if JY.Person[706].好感度 >= 60 or JY.Person[727].好感度 >= 60 and JY.Base.百年标记 == 0 then
		if JY.Person[706].好感度 >= 100 or JY.Person[727].好感度 >= 100 then
			say("听说武圣星君下凡了，要杀尽" .. var_1_1 .. "，恢复我华夏盛世。", 1137, 0, "酒客")
			say("我也听说了，据说杀了很多" .. var_1_1 .. "大将，" .. var_1_1 .. "已经快支持不住了。", 1139, 1, "酒客")
		else
			say("可恶的" .. var_1_1 .. "，最近扬州被他们杀了好多人，每天都看到他们在四处劫掠财物。", 1137, 0, "酒客")
			say("小声点，你不要命了？", 1139, 1, "酒客")
		end
	elseif JY.Person[0].宋罪恶值 > 970 and JY.Person[0].门派 == 21 and JY.Person[0].门派等级 == 25 and JY.Base.百年标记 == 0 then
		say("听说皇帝被一个什么野狗帮的帮主杀死了。", 1134, 0, "酒客")
		say("怎么可能？那可是皇帝，什么人能够杀他。", 1135, 1, "酒客")
		say("听说是在朝会上杀的，那个什么野狗帮主杀了皇帝，又打跑了皇宫禁卫，一路杀出了临安城，真是绝代凶人啊。", 1134, 0, "酒客")
		say("凶星降世，这是祸乱之兆啊，天下大乱不远已。", 1135, 1, "酒客")
	elseif math.random(2) == 1 and JY.Base.百年标记 == 0 then
		say("听说襄阳又战败了，伤亡了数万将士！", 1141, 0, "酒客1")
		say("可恶，难道咱们汉人就这么弱，就真的打不过西夏人？", 1142, 1, "酒客2")
		say("可不就是，千万别打过来，要真打过来了俺老婆儿子都跑不了。", 1141, 0, "酒客1")
		say("听说那些可恶的西夏人，金人都吃人，把咱们汉人叫做两脚羊，平时当奴隶，饿了就直接吃！", 1142, 1, "酒客1")
		say("哎哎，别说了别说了，听着就害怕，来，喝酒喝酒。", 1141, 0, "酒客2")
	else
		say("兄弟，今日不醉不归！", 1130, 0, "酒客")
		say("大哥，我实在喝不动了。", 1131, 1, "酒客")
		say("兄弟看不起我是不是，喝！", 1130, 0, "酒客")
		say("好，今天我拼了，给我换大杯。", 1131, 1, "酒客")
		say("佩服佩服！", 1130, 0, "酒客")
		say("来，干！", 1131, 1, "酒客")
		say("干！", 1130, 0, "酒客")
	end
end
OEVENTLUA[9002] = function ()
	Cls()

	if math.random(2) == 1 and JY.Base.百年标记 == 0 then
		say("最近越来越不太平了，出去经常遇到强盗！", math.random(1033, 1037), 0, "酒客1")
		say("官府也不管管，害得现在我都不敢出城了。", math.random(1033, 1037), 1, "酒客2")
		say("怎么管啊，听说上个月扬州城守带了3000大军去剿匪，结果大败而归！", math.random(1033, 1037), 0, "酒客1")
		say("不会吧，3000大军都打不过这些强盗了？", math.random(1033, 1037), 1, "酒客2")
		say("有啥奇怪的，现在官兵都不训练也不打仗，就欺负老百姓了！", math.random(1033, 1037), 0, "酒客1")
		say("哎，不说了，想想就愁，喝酒喝酒。", math.random(1033, 1037), 1, "酒客2")
	else
		say("干什么靠这么近，想挨揍啊？", math.random(1033, 1037), 0, "酒客")
	end
end
OEVENTLUA[9003] = function ()
	Cls()
	say("这位客官，您要在小店休息*一晚吗？只需10两银子。", 1040, 0, "掌柜")
	Cls()

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(10) == false then
		say("客官，我们这是小本生意，*概不赊帐。", 1040, 0, "掌柜")
		Cls()

		return
	end

	instruct_32(174, -10)
	instruct_14()
	instruct_12()
	addtime(1)
	instruct_13()
	say("客官，昨晚休息的还好吗？您可要再来光顾小店*哦。", 1040, 0, "掌柜")
	Cls()
end
OEVENTLUA[9004] = function ()
	Cls()
	say("热腾腾的馒头包子了，年轻人，你要来一个吗？", 1071, 0, "包子西施")
	Cls()

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(1) == false then
		say("客官，我们这是小本生意，*概不赊帐。", 1071, 0, "包子西施")

		return
	end

	say("好咧，包子两个，你拿好。", 1071, 0, "包子西施")
	Cls()
	instruct_32(174, -1)
	say("真好吃。", 0, 1)
	AddPersonAttrib(0, "体力", 1)
	AddPersonAttrib(0, "生命", 2)
	Cls()
end
OEVENTLUA[9005] = function ()
	Cls()

	if math.random(2) == 1 then
		say("客官，吃饭、住宿请到柜台点单。", 1051, 0, "店小二")
	else
		say("客官，来点白酒吗？上好的绍兴花酒，二两银子一瓶。", 1051, 0, "店小二")

		if instruct_11() == false then
			Cls()

			return
		end

		if instruct_31(2) == false then
			say("客官，我们这是小本生意，*概不赊帐。", 1051, 0, "店小二")

			return
		end

		say("好咧，绍兴花酒一瓶，客官你拿好。", 1051, 0, "店小二")
		Cls()
		instruct_32(174, -2)
		instruct_32(328, 1)

		return
	end
end
OEVENTLUA[9006] = function ()
	Cls()
	dark()
	light()
	DrawStrBoxWaitKey("锻炼了一整天，你感觉自己微有进步", C_ORANGE, CC.DefaultFont, 2)

	for iter_6_0 = 1, CC.TeamNum do
		local var_6_0 = JY.Base["队伍" .. iter_6_0]

		if var_6_0 >= 0 then
			if has_thing(321) and iter_6_0 == 1 then
				JY.Person[var_6_0].修炼点数 = JY.Person[var_6_0].修炼点数 + 100

				War_PersonTrainBook(var_6_0)

				JY.Person[var_6_0].经验 = JY.Person[var_6_0].经验 + 120

				War_AddPersonLVUP(var_6_0)
			elseif has_thing(320) and iter_6_0 > 1 then
				JY.Person[var_6_0].修炼点数 = JY.Person[var_6_0].修炼点数 + 100

				War_PersonTrainBook(var_6_0)

				JY.Person[var_6_0].经验 = JY.Person[var_6_0].经验 + 120

				War_AddPersonLVUP(var_6_0)
			else
				JY.Person[var_6_0].修炼点数 = JY.Person[var_6_0].修炼点数 + 40

				War_PersonTrainBook(var_6_0)

				JY.Person[var_6_0].经验 = JY.Person[var_6_0].经验 + 50

				War_AddPersonLVUP(var_6_0)
			end
		end
	end

	addtime(1)
end
OEVENTLUA[9007] = function ()
	Cls()
	say("武功不进则退，我该静心修炼一段时间了。", 0, 1)
	dark()
	light()
	addtime(29)
	say("快一个月了啊，该收工了。", 0, 1)
	addtime(1)

	for iter_7_0 = 1, CC.TeamNum do
		local var_7_0 = JY.Base["队伍" .. iter_7_0]

		if var_7_0 >= 0 then
			if has_thing(321) and iter_7_0 == 1 then
				JY.Person[var_7_0].修炼点数 = JY.Person[var_7_0].修炼点数 + 1200

				War_PersonTrainBook(var_7_0)

				JY.Person[var_7_0].经验 = JY.Person[var_7_0].经验 + 1500

				War_AddPersonLVUP(var_7_0)
			end

			if has_thing(320) and iter_7_0 > 1 then
				JY.Person[var_7_0].修炼点数 = JY.Person[var_7_0].修炼点数 + 1200

				War_PersonTrainBook(var_7_0)

				JY.Person[var_7_0].经验 = JY.Person[var_7_0].经验 + 1500

				War_AddPersonLVUP(var_7_0)
			end

			JY.Person[var_7_0].修炼点数 = JY.Person[var_7_0].修炼点数 + 1100

			War_PersonTrainBook(var_7_0)

			JY.Person[var_7_0].经验 = JY.Person[var_7_0].经验 + 1400

			War_AddPersonLVUP(var_7_0)
		end
	end

	for iter_7_1 = 1, 635 do
		if JY.Person[iter_7_1].无用1 == 1 and inteam(iter_7_1) == false then
			JY.Person[iter_7_1].修炼点数 = JY.Person[iter_7_1].修炼点数 + 1000
		end
	end
end
OEVENTLUA[9008] = function ()
	Cls()
	say("这是闭关修炼的地方，一闭关最短就是一年时间，你确定要闭关修炼吗？", 0, 2)

	if yesno("要闭关修炼吗？") then
		dark()
		light()
		DrawStrBoxWaitKey("一年过去，你颇有些山中无岁月的感觉", C_ORANGE, CC.DefaultFont, 2)

		for iter_8_0 = 1, CC.TeamNum do
			local var_8_0 = JY.Base["队伍" .. iter_8_0]

			if var_8_0 >= 0 then
				if has_thing(321) and iter_8_0 == 1 then
					JY.Person[var_8_0].修炼点数 = JY.Person[var_8_0].修炼点数 + 13000

					War_PersonTrainBook(var_8_0)

					JY.Person[var_8_0].经验 = JY.Person[var_8_0].经验 + 16000

					War_AddPersonLVUP(var_8_0)
				end

				if has_thing(320) and iter_8_0 > 1 then
					JY.Person[var_8_0].修炼点数 = JY.Person[var_8_0].修炼点数 + 13000

					War_PersonTrainBook(var_8_0)

					JY.Person[var_8_0].经验 = JY.Person[var_8_0].经验 + 16000

					War_AddPersonLVUP(var_8_0)
				end

				JY.Person[var_8_0].修炼点数 = JY.Person[var_8_0].修炼点数 + 12500

				War_PersonTrainBook(var_8_0)

				JY.Person[var_8_0].经验 = JY.Person[var_8_0].经验 + 15500

				War_AddPersonLVUP(var_8_0)
			end
		end

		for iter_8_1 = 1, 635 do
			if JY.Person[iter_8_1].无用1 == 1 and inteam(iter_8_1) == false then
				JY.Person[iter_8_1].修炼点数 = JY.Person[iter_8_1].修炼点数 + 12000
			end
		end

		JY.YEAR = JY.YEAR + 1
	end
end
OEVENTLUA[9009] = function ()
	Cls()
	say("年轻人，来点烧饼吗？还热着呢。", 1034, 0)
	Cls()

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(1) == false then
		say("客官，我们这是小本生意，*概不赊帐。", 1034, 0)

		return
	end

	say("好咧，烧饼两个，你拿好了。", 1034, 0)
	Cls()
	instruct_32(174, -1)
	dark()
	light()
	say("好吃，老伯手艺不错啊。", 0, 1)
	say("呵呵，这是我年轻时到西安闯荡时学得本事，吃了的都说好。", 1034, 0)
	AddPersonAttrib(0, "体力", 1)
	AddPersonAttrib(0, "生命", 5)
	Cls()
end
OEVENTLUA[9010] = function ()
	Cls()
	instruct_64()
end
OEVENTLUA[9011] = function ()
	Cls()
	say("在不起眼的这个角落，似乎有个发着微弱亮光的东西。", 0, 2)
	addthing(337, 1)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	say("又有人来抢这宝物了，兄弟们，上~", 1273, 0)

	if WarMain(314, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end
end
OEVENTLUA[9021] = function ()
	Cls()

	local var_12_0 = 0
	local var_12_1 = JY.Person[727].好感度 >= 60 and "金狗" or "元狗"

	if JY.Person[706].好感度 >= 60 or JY.Person[727].好感度 >= 60 and JY.Base.百年标记 == 0 then
		if JY.Person[706].好感度 >= 100 or JY.Person[727].好感度 >= 100 then
			say("听说武圣星君下凡了，要杀尽" .. var_12_1 .. "，恢复我华夏盛世。", math.random(1137, 1142), 0, "酒客")
			say("我也听说了，据说杀了很多" .. var_12_1 .. "大将，" .. var_12_1 .. "已经快支持不住了。", math.random(1130, 1136), 0, "酒客")
		else
			say("可恶的" .. var_12_1 .. "，最近扬州被他们杀了好多人，每天都看到他们在四处劫掠财物。", math.random(1137, 1142), 0, "酒客")
			say("小声点，你不要命了？", math.random(1130, 1136), 0, "酒客")
		end
	elseif JY.Person[0].宋罪恶值 > 970 and JY.Person[0].门派 == 21 and JY.Person[0].门派等级 == 25 and JY.Base.百年标记 == 0 then
		say("听说皇帝被一个什么野狗帮的帮主杀死了。", math.random(1130, 1136), 0, "酒客")
		say("怎么可能？那可是皇帝，什么人能够杀他。", math.random(1137, 1142), 0, "酒客")
		say("听说是在朝会上杀的，那个什么野狗帮主杀了皇帝，又打跑了皇宫禁卫，一路杀出了临安城，真是绝代凶人啊。", math.random(1130, 1136), 0, "酒客")
		say("凶星降世，这是祸乱之兆啊，天下大乱不远已。", math.random(1137, 1142), 0, "酒客")
	elseif JY.Base.百年标记 == 0 then
		say("听说天地会的英雄最近到了江南了，可惜不认识，不然我也想见一见。", 1130, 0, "酒客")
		say("平生不见陈近南，便称英雄也枉然！这样的英雄谁不想见一见？可惜可惜。", 1131, 0, "酒客")
	else
		say("世风日下啊。", 1130, 0, "酒客")
		say("有钱就是大爷，世道就是如此，你有啥看不开的。", 1131, 0, "酒客")
	end
end
OEVENTLUA[9022] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("大消息大消息，有人在扬州见到洪七公老帮主了。", 1037, 0, "酒客")
		say("那咱们得去拜见一下他老人家！万一老帮主一高兴，稍稍指点一下，那就是一生的福分啊。", 1036, 0, "酒客")
		say("正是正是。听闻他老人家嫉恶如仇，咱们正好将就近的贪官匪帮汇报一下，让这些恶霸也倒倒霉。", 1037, 0, "酒客")
	else
		say("没看见我们正喝酒吗？快闪一边去。", 1036, 0, "酒客")
		say("你这个土鳖，现在我们不是工作时间。", 1037, 0, "酒客")
	end
end
OEVENTLUA[9023] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "，我这有东海运来的宝药，你要不要看一看？", 1026, 0, "宝药商人")
	say("这是？这是千年何首乌？", 0, 1)
	say(JY.Person[0].称呼 .. "好眼力，我给你算便宜点，8000两银子一株怎么样？这可是可遇不可求的好东西啊。", 1026, 0, "宝药商人")

	if yesno("要买吗？") then
		say("我买了。", 0, 1)

		if instruct_31(8000) == false then
			say(JY.Person[0].称呼 .. "你银子不够啊。", 1026, 0, "宝药商人")

			return
		end

		say("好勒，这是千年何首乌，客人你收好。", 1026, 0, "宝药商人")
		instruct_32(174, -8000)
		instruct_32(17, 1)
	end
end
OEVENTLUA[9024] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("最近很多中州的武林人士跑咱们南方来了，也不知道是有什么事情？", math.random(1130, 1142), 0, "酒客")
		say("没打探到什么具体的消息，不过听说不少青城派的好手到了福州，一定有大事发生了。", math.random(1130, 1142), 0, "酒客")
		say("嘘，小声一点，我看旁边那桌的似乎就是青城派的人，小心让他们听到多生事端。", math.random(1130, 1142), 0, "酒客")
	else
		say("听说出海能挣大钱，兄弟，咱们一块去。", 1141, 0, "酒客")
		say("好，家里已经揭不开锅了，就跟兄弟去闯一把。", 1142, 0, "酒客")
	end
end
OEVENTLUA[9025] = function ()
	Cls()
	say("朝廷法令，私人不得持有刀具武器，违者重罚。", 1255, 0, "官军")
	say("三家共有一把菜刀，四家共有一把犁具，超数者重罚。", 1255, 0, "官军")
end
OEVENTLUA[9031] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说这北疆的冰雪之地隐居着两位了不得的侠客，乃是父子两人。", 1133, 0, "酒客")
		say("你说的是辽东大侠胡一刀和飞天狐狸胡斐两位英雄吧，他们就住在此处东北不远。", 1134, 1, "酒客")
		say("那咱们得去拜见一下，结识了这样的英雄，以后混江湖脸面都大一点。", 1133, 0, "酒客")
		say("有理，咱们喝完酒就去。", 1135, 1, "酒客")
		instruct_39(0)
	else
		say("近年长白山越来越乱，匪帮越来越多了。", 1130, 0, "酒客")
		say("是啊是啊，且不说这个，喝酒喝酒。", 1131, 0, "酒客")
		say("喝。", 1130, 0, "酒客")
	end
end
OEVENTLUA[9032] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("兄弟，知道哪儿能买到上好的人参吗？我急需一颗百年人参，在这儿呆了好几天了都没有找到。", 1130, 0, "酒客")
		say("那你可不要着急，好人参是需要耐心的，你在这儿多等等。每月都有长白山下来的采参客到这儿来，总会有百年以上的人参的。", 1131, 1, "酒客")
		say("正是正是，不要说百年人参，就是千年人参据说也有人采到过。这样的宝贝，只是能见到都是福分了。", 1132, 0, "酒客")
		say("来，兄弟，接着喝酒。", 1131, 1, "酒客")
		say("喝。", 1132, 0, "酒客")
	else
		say("听说元人都打到海边去了，灭了无数国家，也不知道是不是真的。", 1134, 0, "酒客")
		say("我中华上国就是厉害，那些蛮夷如何能够抵挡。", 1135, 0, "酒客")
	end
end
OEVENTLUA[9033] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "，我这有东海运来的宝药，你要不要看一看？", 1024, 0, "宝药商人")
	say("这是？这是千年人参？", 0, 1)
	say(JY.Person[0].称呼 .. "好眼力，我给你算便宜点，10000两银子一株怎么样？这可是可遇不可求的好东西啊。", 1024, 0, "宝药商人")

	if yesno("要买吗？") then
		say("我买了。", 0, 1)

		if instruct_31(10000) == false then
			say(JY.Person[0].称呼 .. "你银子不够啊。", 1024, 0, "宝药商人")

			return
		end

		say("好勒，这是千年人参，客人你收好。", 1024, 0, "宝药商人")
		instruct_32(174, -10000)
		instruct_32(16, 1)
	end
end
OEVENTLUA[9034] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说长白剑派的常大师兄和高大棒子打起来了，最近闹得沸沸扬扬。", 1134, 0, "酒客")
		say("高大棒子真是艺高人胆大，居然敢惹上了长白剑派。", 1135, 1, "酒客")
		say("不过听说是为了抢朝廷赏赐的掌门玉杯。", 1134, 0, "酒客")
		say("朝廷的事，还是少说为好。来，兄弟，接着喝酒。", 1137, 1, "酒客")
		say("喝。", 1134, 0, "酒客")
	else
		say("听说黑胡子往国外贩运山货挣了不少啊。", 1138, 0, "酒客")
		say("可不是，黑胡子那个黑啊，卖给咱们的都是萝卜做的人参，给国外卖的都是百年以上的好货，他不挣钱才奇怪。", 1138, 0, "酒客")
	end
end
OEVENTLUA[9035] = function ()
	Cls()
	say("我们白河帮的老帮主中了寒毒，四处寻找名医也治不好，最近几年更是卧病在床，眼看就不行了。", 1228, 0, "酒客")
	say("现在两位副帮主都虎视眈眈，真让人忧心啊。", 1228, 0, "酒客")

	if has_thing(344) or has_thing(345) then
		say("寒毒？正巧，我这就有专治寒毒的药物，你要不要看看。", 0, 1)
		say("这？真是能治寒毒的药物，太好了，老帮主有救了。", 1009, 0, "御天北")

		if yesno("要将药物给此人吗？") then
			say("给。", 0, 1)

			if has_thing(344) then
				addthing(344, -1)
			elseif has_thing(345) then
				addthing(345, -1)
			end

			say("这是给你的谢礼，还请一定收下。", 1228, 0, "酒客")
			addthing(174, 2000)
			say("帮主有救了，太好了。", 1009, 0, "御天北")
			null(-2, 2)
			null(-2, 3)
		else
			say("可惜我自己还要用，不能给你。", 0, 1)
			say("戏耍我们是吧，可恶。", 1228, 0, "酒客")

			if WarMain(364, 0, 1, 1) == false then
				instruct_15()

				return
			end

			dark()
			null(-2, 2)
			null(-2, 3)
			light()
		end
	end
end
OEVENTLUA[9061] = function ()
	Cls()
	say("汉人，这是大辽领地，速速离开。", 1160, 0, "大辽武士")
end
OEVENTLUA[9071] = function ()
	Cls()
	instruct_67(22)
	dark()
	null(-2, 18)
	null(-2, 19)
	null(-2, 20)
	light()
	say("咦！这是什么声音？难道洞中藏有怪物？待我进去看个究竟。", 0, 1)
	instruct_30(25, 49, 25, 40)
	say("哇塞！雕蛇大战，精彩！……咦！雕兄似乎快不行了，看我的！", 0, 1)

	if WarMain(66, 0) == false then
		Cls()
		instruct_15()
		Cls()

		return
	end

	null(-2, 5)
	addevent(7, 5, -2, -2, -2, 6224, -2, -2)
	Cls()
	instruct_13()

	if JY.Person[0].驱虫术 >= 20 then
		if yesno("是否要收服蛇儿为宠物？") then
			say("蛇儿乖，先不要死。", 0, 1)
			dark()
			light()

			if JY.Person[0].驱虫术 >= 80 then
				chongwu_choice(3)
			else
				say("可惜，可惜，我现在的能力还不足以收服此蛇。", 0, 1)
				addthing(325)
			end
		else
			addthing(325)
		end
	else
		addthing(325)
	end

	null(-2, 5)
	say("这巨蟒还真难对付，总算把它搞定了。雕兄，你还好吧？", 0, 1)
	say("咦？雕兄怎么跑了？这只雕颇有灵性，好像要带我到里边去……", 0, 1)
	addevent(7, 11, 1, 9073, 1, 6192, -2, -2)
end
OEVENTLUA[9072] = function ()
	Cls()

	if JY.Base.畅想编号 == 58 and PersonKF(0, 45) and JY.Person[0].天赋外功1 ~= 45 then
		JY.Person[0].天赋外功1 = 45

		say("重剑无锋……大巧不工……这位独孤前辈的风采，真是令人神往啊。", 0, 1)
		DrawStrBoxWaitKey("天赋外功改为玄铁剑法", C_ORANGE, CC.DefaultFont, 2)

		return
	end

	if inteam(35) and JY.Person[35].武功2 == 47 and JY.Person[35].天赋外功1 ~= 47 then
		JY.Person[35].天赋外功1 = 47

		SetS(10, 1, 1, 0, 1)

		TFJS[35] = {
			"Ｌ【天赋：灵奇洒脱】",
			"Ｗ战斗中移动力提升三格",
			"Ｗ连击时必暴",
			"Ｎ",
			"Ｌ【称号：剑魔再临】",
			"Ｗ进入战斗立即行动",
			"Ｗ领悟独孤九剑高级奥义"
		}

		say("飞花摘叶……皆可伤人……这位独孤前辈的风采，真是令人神往啊。", 35, 0)
		DrawStrBoxWaitKey("令狐冲领悟了【独孤九剑】奥义", C_ORANGE, CC.DefaultFont, 2)

		return
	end
end
OEVENTLUA[9073] = function ()
	Cls()
	say("嘎嘎嘎，嘎嘎？", 93, 0)
	say("雕兄这是要和我打架？", 0, 1)
	say("嘎嘎嘎！", 93, 0)
	say("来吧。", 0, 1)

	if WarMain(8, 0) == false then
		say("雕兄好厉害，佩服佩服。", 0, 1)
		say("嘎嘎嘎！", 93, 0)

		return
	end

	say("嘎嘎嘎！", 93, 0)
	say("雕兄，下次再陪你玩耍。", 0, 1)
	say("嘎嘎嘎！", 93, 0)
end
OEVENTLUA[9074] = function ()
	Cls()

	if has_thing(116) == false then
		say("这上面似乎记载着使用这柄重剑的法门，我赶紧记下来！", 0, 1)
		addthing(116, 1)
		instruct_3(-2, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	end
end
OEVENTLUA[9075] = function ()
	Cls()

	if JY.Person[0].御剑能力 == 99 then
		say("好高明的剑法。", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(4, 1)

		JY.Person[0].御剑能力 = 100
	elseif JY.Person[0].御剑能力 == 199 and JY.Person[0].实战 >= 500 then
		say("好高深的剑法。", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(4, 2)

		JY.Person[0].御剑能力 = 200
	elseif JY.Person[0].御剑能力 == 299 then
		say("好高深的剑法。", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(4, 3)

		JY.Person[0].御剑能力 = 300
	end
end
OEVENTLUA[9101] = function ()
	Cls()

	local var_28_0 = Rnd(10)

	say("呲呲~", 0, 2)

	if has_thing(323) then
		say("好大一群蜘蛛。", 0, 1)

		if yesno("是否要使用神木王鼎？") then
			say("呵呵，正好用用这神木王鼎。", 0, 1)
			dark()
			light()
			say("只见那毒物绕王鼎转了几圈，慢慢爬进王鼎，身形缓缓消失不见了。", 0, 1)
			say("哈哈，成了。", 0, 1)

			if var_28_0 == 3 or var_28_0 == 6 or var_28_0 == 9 then
				say("不错，不错，鼎内的药液已经足够用来炼制毒药了，我的敌人们可要小心了。", 0, 1)
				AddPersonAttrib(0, "攻击带毒", 1)
				QZXS(JY.Person[0].姓名 .. "攻击带毒增加了1")
			end

			instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end
	end

	say("哇，好大一群蜘蛛", 0, 1)

	if WarMain(61, 0) == false then
		instruct_15()
		Cls()

		return
	end

	Cls()
	say("这不知道是什么蜘蛛，毒性*好强，我得小心一点。", 0, 1)
	Cls()
	instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[9102] = function ()
	Cls()

	local var_29_0 = Rnd(10)

	say("呲呲~", 0, 2)

	if has_thing(323) then
		say("好大一群蜘蛛。", 0, 1)

		if yesno("是否要使用神木王鼎？") then
			say("呵呵，正好用用这神木王鼎。", 0, 1)
			dark()
			light()
			say("只见那毒物绕王鼎转了几圈，慢慢爬进王鼎，身形缓缓消失不见了。", 0, 1)
			say("哈哈，成了。", 0, 1)

			if var_29_0 == 3 or var_29_0 == 6 or var_29_0 == 9 then
				say("不错，不错，鼎内的药液已经足够用来炼制毒药了，我的敌人们可要小心了。", 0, 1)
				AddPersonAttrib(0, "攻击带毒", 1)
				QZXS(JY.Person[0].姓名 .. "攻击带毒增加了1")
			end

			instruct_3(-2, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end
	end

	say("哇，好大一群蜘蛛", 0, 1)

	if WarMain(62, 0) == false then
		instruct_15()
		Cls()

		return
	end

	Cls()
	say("这不知道是什么蜘蛛，毒性*好强，我得小心一点。", 0, 1)
	instruct_3(-2, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[9103] = function ()
	Cls()

	local var_30_0 = Rnd(10)

	say("呲呲~", 0, 2)

	if has_thing(323) then
		say("好大一群蜘蛛。", 0, 1)

		if yesno("是否要使用神木王鼎？") then
			say("呵呵，正好用用这神木王鼎。", 0, 1)
			dark()
			light()
			say("只见那毒物绕王鼎转了几圈，慢慢爬进王鼎，身形缓缓消失不见了。", 0, 1)
			say("哈哈，成了。", 0, 1)

			if var_30_0 == 3 or var_30_0 == 6 or var_30_0 == 9 then
				say("不错，不错，鼎内的药液已经足够用来炼制毒药了，我的敌人们可要小心了。", 0, 1)
				AddPersonAttrib(0, "攻击带毒", 1)
				QZXS(JY.Person[0].姓名 .. "攻击带毒增加了1")
			end

			instruct_3(-2, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end
	end

	say("哇，好大一群蜘蛛", 0, 1)

	if WarMain(63, 0) == false then
		instruct_15()
		Cls()

		return
	end

	say("这不知道是什么蜘蛛，毒性*好强，我得小心一点。", 0, 1)
	Cls()
	instruct_3(-2, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[9104] = function ()
	Cls()

	local var_31_0 = Rnd(10)

	say("呲呲~", 0, 2)

	if has_thing(323) then
		say("好大一群蜘蛛。", 0, 1)

		if yesno("是否要使用神木王鼎？") then
			say("呵呵，正好用用这神木王鼎。", 0, 1)
			dark()
			light()
			say("只见那毒物绕王鼎转了几圈，慢慢爬进王鼎，身形缓缓消失不见了。", 0, 1)
			say("哈哈，成了。", 0, 1)

			if var_31_0 == 3 or var_31_0 == 6 or var_31_0 == 9 then
				say("不错，不错，鼎内的药液已经足够用来炼制毒药了，我的敌人们可要小心了。", 0, 1)
				AddPersonAttrib(0, "攻击带毒", 1)
				QZXS(JY.Person[0].姓名 .. "攻击带毒增加了1")
			end

			instruct_3(10, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(10, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(10, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(10, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(10, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(10, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end
	end

	say("哇，好大一群蜘蛛", 0, 1)

	if WarMain(64, 0) == false then
		instruct_15()
		Cls()

		return
	end

	say("这不知道是什么蜘蛛，毒性*好强，我得小心一点。", 0, 1)
	Cls()
	instruct_3(10, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(10, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(10, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(10, 39, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(10, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(10, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[9105] = function ()
	Cls()

	local var_32_0 = Rnd(10)

	say("呲呲~", 0, 2)

	if has_thing(323) then
		say("好大一群蜘蛛。", 0, 1)

		if yesno("是否要使用神木王鼎？") then
			say("呵呵，正好用用这神木王鼎。", 0, 1)
			dark()
			light()
			say("只见那毒物绕王鼎转了几圈，慢慢爬进王鼎，身形缓缓消失不见了。", 0, 1)
			say("哈哈，成了。", 0, 1)

			if var_32_0 == 3 or var_32_0 == 6 or var_32_0 == 9 then
				say("不错，不错，鼎内的药液已经足够用来炼制毒药了，我的敌人们可要小心了。", 0, 1)
				AddPersonAttrib(0, "攻击带毒", 1)
				QZXS(JY.Person[0].姓名 .. "攻击带毒增加了1")
			end

			instruct_3(-2, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end
	end

	say("哇，好大一群蜘蛛", 0, 1)

	if WarMain(65, 0) == false then
		instruct_15()
		say("这不知道是什么蜘蛛，毒性*好强，我得小心一点。", 0, 1)
		Cls()

		return
	end

	instruct_3(-2, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 49, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[9111] = function ()
	Cls()
	dark()
	My_Enter_SubScene(13, 35, 24, 2)
	light()
end
OEVENTLUA[9112] = function ()
	Cls()

	if JY.Person[9].好感度 == 40 then
		say("明教不欢迎你，速速离开！", 194, 0)
	else
		say("明教圣地，无关人士速速离开！", 194, 0)
	end
end
OEVENTLUA[9113] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
	addthing(0, 2)
	addthing(11, 2)
end
OEVENTLUA[9114] = function ()
	Cls()

	if has_thing(242) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(242)
		null(-2, 147)
	end
end
OEVENTLUA[9121] = function ()
	Cls()

	if JY.Person[0].门派 == 7 and JY.Person[117].好感度 == 60 then
		say("小主人好。", 294, 0, "灵鹫宫女")
	elseif inteam(49) then
		say("灵鹫宫都是女子，还请不要乱闯，以免引来不便。", 294, 0, "灵鹫宫女")
	else
		say("灵鹫宫禁地，赶快离开。", 294, 0, "灵鹫宫女")
	end
end
OEVENTLUA[9122] = function ()
	Cls()
	say("原来这些画记录的是一门武功。", 0, 1)
	addthing(79)
	null(-2, 0)
end
OEVENTLUA[9123] = function ()
	Cls()
	addthing(24, 2)
	null(-2, 30)
end
OEVENTLUA[9124] = function ()
	Cls()
	addthing(99)
	null(-2, 1)
end
OEVENTLUA[9125] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 2)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 19)
end
OEVENTLUA[9126] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 5)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 20)
end
OEVENTLUA[9127] = function ()
	Cls()
	addthing(305)
	null(-2, 32)
end
OEVENTLUA[9181] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 6)
end
OEVENTLUA[9182] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 7)
end
OEVENTLUA[9183] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(107, 1)
	null(-2, 2)
end
OEVENTLUA[9184] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(119, 1)
	null(-2, 8)
end
OEVENTLUA[9185] = function ()
	Cls()
	say("这是谁的墓啊，怎么里面还藏有一本书。", 0, 1)
	addthing(153)
	null(-2, 20)
	say("原来是天书，难怪，难怪。", 0, 1)
end
OEVENTLUA[9186] = function ()
	Cls()
	say("这棺材盖上怎么还有些小字？我看看。", 0, 1)
	addthing(308, 1)
	null(-2, 3)

	if has_thing(84) then
		say("这边还有，这是？九阴真经的一部分？可惜我已经有了全本，没什么用处。", 0, 1)
	else
		say("这边还有，这是？九阴真经的一部分？可惜不全，没多大用处。", 0, 1)
		addthing(293, 1)
	end
end
OEVENTLUA[9187] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(304, 1)
	null(-2, 8)
end
OEVENTLUA[9191] = function ()
	Cls()
	say("晚辈拜见全真派诸位道长。", 0, 1)
	Cls()
	say("全真乃清修之所，" .. JY.Person[0].称呼 .. "若无*事，便请回吧。", 123, 0)
	Cls()
end
OEVENTLUA[9192] = function ()
	say("全真教乃中神通王重阳所建*，是天下武学的正宗。", 209, 0, "全真教徒")
	Cls()
end
OEVENTLUA[9193] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2612, 2612, 2612, -2, -2, -2)
	addthing(2, 1)
	addthing(209, 50)
	instruct_37(-1)
end
OEVENTLUA[9194] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(19, 9)
end
OEVENTLUA[9195] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(122, 1)
	say("大胆狂徒，居然敢在全真教*偷东西！", 128, 0)
	Cls()

	if WarMain(221, 0, 1, 1) == false then
		instruct_15()
		Cls()

		return
	end

	Cls()
	instruct_13()
	instruct_37(-3)
	null(19, 8)
end
OEVENTLUA[9196] = function ()
	Cls()
	say("这么多书，我得好好看看。", 0, 1)
	dark()
	light()
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	addtime(5)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(19, 33)
end
OEVENTLUA[9211] = function ()
	Cls()
	addthing(254)
	null(-2, 1)
end
OEVENTLUA[9212] = function ()
	Cls()
	say("这本书是？四象阵法？", 0, 1)
	dark()
	light()
	say("不错，不错。", 0, 1)
	addtime(5)
	AddPersonAttrib(0, "阵法知识", 3)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 2)
end
OEVENTLUA[9213] = function ()
	Cls()
	dark()
	light()
	say("这里布置了个阵法", 0, 2)

	if JY.Person[0].阵法知识 >= 20 then
		say("区区八卦阵，怎能困住我？", 0, 1)
		dark()
		My_Enter_SubScene(21, 38, 28, 0)
		light()
	else
		say("破不开，等以后再来吧。", 0, 1)
		My_Enter_SubScene(21, 45, 28, 0)
	end
end
OEVENTLUA[9214] = function ()
	Cls()
	dark()
	light()

	if JY.Person[0].阵法知识 >= 20 then
		say("区区八卦阵，怎能困住我？", 0, 1)
		dark()
		My_Enter_SubScene(21, 45, 28, 1)
		light()
	else
		say("破不开，麻烦了。", 0, 1)
		My_Enter_SubScene(21, 38, 35, 1)
	end
end
OEVENTLUA[9221] = function ()
	Cls()
	say("本谷不对外开放，" .. JY.Person[0].称呼 .. "请回。", 1073, 0, "绝情谷众")
end
OEVENTLUA[9222] = function ()
	Cls()
	say("我绝情谷数百年来独立于世外，乃是真正的世外桃源。", 1073, 0, "绝情谷众")
end
OEVENTLUA[9223] = function ()
	Cls()
	say("少侠，请。", 1073, 0, "绝情谷众")
end
OEVENTLUA[9224] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(22, 8)
end
OEVENTLUA[9225] = function ()
	Cls()
	say("这么多书，我得好好看看。", 0, 1)
	dark()
	light()
	say("这是阵法？果然是大有收获。", 0, 1)
	addtime(5)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(22, 7)
end
OEVENTLUA[9226] = function ()
	Cls()
	addthing(4, 5)
	addthing(209, 50)
	null(22, 2)
	instruct_37(-1)
end
OEVENTLUA[9227] = function ()
	Cls()
	addthing(39)
	null(22, 5)
	instruct_37(-1)
end
OEVENTLUA[9228] = function ()
	Cls()
	addthing(42)
	null(22, 4)
	instruct_37(-1)
end
OEVENTLUA[9229] = function ()
	Cls()
	addthing(201)
	null(22, 37)
end
OEVENTLUA[9251] = function ()
	Cls()

	if Rnd(3) == 1 then
		say("拜见盟主。", 208, 0)
	else
		say("盟主好。", 209, 0)
	end
end
OEVENTLUA[9252] = function ()
	Cls()

	if Rnd(3) == 1 then
		say("拜见盟主。", 210, 0)
	else
		say("盟主好。", 210, 0)
	end
end
OEVENTLUA[9261] = function ()
	Cls()

	if instruct_16(73) == false then
		say("黑木崖乃日月神教总坛所在*，非我教人员不得入内。", 202, 0, "日月教徒")
		Cls()

		return
	end

	say("圣、圣姑，属下参见圣姑！", 202, 0, "日月教徒")
	Cls()
	say("还不快让开！", 73, 1)
	Cls()
	say("是！", 202, 0, "日月教徒")
	Cls()
	instruct_14()
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	instruct_13()
end
OEVENTLUA[9262] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(1, 3)
	addthing(11, 5)
	instruct_37(-1)
end
OEVENTLUA[9263] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(26, 37)
end
OEVENTLUA[9264] = function ()
	Cls()
	addthing(209, 20)
	addthing(174, 500)
	null(26, 46)
end
OEVENTLUA[9265] = function ()
	Cls()
	addthing(236, 1)
	null(26, 47)
end
OEVENTLUA[9271] = function ()
	Cls()
	say("嵩山派禁地，生人勿近！", 198, 0, "嵩山弟子")
	Cls()

	if instruct_5() == false then
		do return end

		Cls()
	end

	if WarMain(29, 0) == false then
		instruct_15()
		Cls()

		do return end

		Cls()
	end

	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2, -2)
	Cls()
	instruct_13()
end
OEVENTLUA[9272] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(174, 500)
	addthing(1, 2)
	addthing(11, 5)
	instruct_37(-1)
end
OEVENTLUA[9273] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(27, 64)
end
OEVENTLUA[9274] = function ()
	Cls()
	addthing(209, 20)
	null(27, 61)
	instruct_37(-1)
end
OEVENTLUA[9275] = function ()
	local var_81_0 = Rnd(4)

	if var_81_0 == 1 then
		say("只左掌门上任以来，我嵩山派越发强盛，更是统领五岳剑派，江湖上人人敬畏。", 198, 0, "嵩山弟子")
	elseif var_81_0 == 2 then
		say("我嵩山派剑法分为\"内八路*，外九路\"，十七路剑法，*长短快慢应有尽有。", 198, 0, "嵩山弟子")
	else
		say("我嵩山有八景，分别是：*嵩门待月、轩辕早行、*颍水春耕、箕阴避暑、*石淙会饮、玉溪垂钓、*少室晴雪、卢崖瀑布。", 198, 0)
	end
end
OEVENTLUA[9281] = function ()
	Cls()

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		if JY.Person[0].攻击力 < 360 then
			say("我刚刚开始学习然木刀法，咱们一起练练吧。", 1147, 0, "慧聪")
			Cls()

			if instruct_5() == false then
				Cls()

				return
			end

			if WarMain(79, 1) == false then
				Cls()
			end

			Cls()
			instruct_13()
			Cls()

			return
		else
			say("师弟武艺已经如此高强，小僧万万不是对手。", 1147, 0, "慧聪")
		end
	else
		say("世上恶人太多，正是佛法弘扬之时。", 1147, 0, "慧聪")
	end
end
OEVENTLUA[9282] = function ()
	Cls()

	local var_83_0 = 0
	local var_83_1

	var_83_1 = JY.Person[0].门派等级 == 9 and "长老" or "小师弟"

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		if JY.Person[0].门派等级 == 9 then
			say("长老好。", 210, 0, "少林弟子")
		else
			say("我少林最重佛法，其次是门派贡献，达摩堂的善若师兄，因为门派贡献大，深得师伯喜爱，给传了易筋经，真是让人羡慕啊。", 210, 0, "少林弟子")
		end
	else
		say("少林少林～有多少英雄豪杰都来把你敬仰～～少林少林～～有多少神奇故事到处把你传扬～～", 210, 0, "少林弟子")
	end
end
OEVENTLUA[9283] = function ()
	Cls()

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		if JY.Person[0].门派贡献 < 30 then
			say("你的资格还不够，多去做做任务吧！", 210, 0, "少林弟子")

			return
		end

		if has_thing(88) then
			return
		end

		say("师弟，要挑战少林木人巷吗？", 210, 0, "少林弟子")
		Cls()

		if instruct_5() == false then
			do return end

			Cls()
		end

		say("好，施主里边请！", 210, 0, "少林弟子")
		Cls()
		instruct_19(35, 15)
		Cls()

		if WarMain(214, 1) then
			instruct_19(34, 10)
			Cls()
			instruct_13()
			Cls()

			return
		end

		Cls()
		instruct_19(35, 17)
		Cls()
		instruct_13()
	else
		say("少林木人巷，非本寺弟子不能挑战！", 210, 0, "少林弟子")
	end
end
OEVENTLUA[9284] = function ()
	Cls()

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		if JY.Person[0].门派贡献 < 50 then
			say("你的资格还不够，多去做做任务吧！", 210, 0, "少林弟子")

			return
		end

		if has_thing(85) then
			return
		end

		say("师弟，要挑战少林铜人巷？", 210, 0, "少林弟子")
		Cls()

		if instruct_5() == false then
			do return end

			Cls()
		end

		say("好，施主里边请！", 210, 0, "少林弟子")
		Cls()
		instruct_19(41, 14)
		Cls()

		if WarMain(217, 1) then
			instruct_19(41, 7)
			Cls()
			instruct_13()
			Cls()

			return
		end

		Cls()
		instruct_19(42, 17)
		Cls()
		instruct_13()
	else
		say("少林铜人巷，非本寺弟子不能挑战！", 210, 0, "少林弟子")
	end
end
OEVENTLUA[9285] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)

	if has_thing(88) == false then
		addthing(88, 1)
	end

	instruct_14()
	instruct_3(-2, 24, 1, 0, 710, 0, 0, -2, -2, -2, -2, -2, -2)
	instruct_19(35, 17)
	Cls()
	instruct_13()
end
OEVENTLUA[9286] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2952, 2952, 2952, -2, -2, -2)
	instruct_0()

	if has_thing(171) == false then
		addthing(171, 1)
	end

	instruct_0()
	instruct_14()
	instruct_3(-2, 25, 1, 0, 713, 0, 0, -2, -2, -2, -2, -2, -2)
	instruct_19(42, 17)
	instruct_0()
	instruct_13()
end
OEVENTLUA[9287] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(21, 5)
	addthing(21, 5)
	instruct_37(-2)
end
OEVENTLUA[9288] = function ()
	Cls()
	dark()
	My_Enter_SubScene(130, 53, 44, 2)
	light()
end
OEVENTLUA[9289] = function ()
	Cls()
	say("阿弥陀佛，身是菩提树,心如明镜台。", 1155, 0)
end
OEVENTLUA[9290] = function ()
	Cls()

	if JY.Base.畅想编号 == 50 then
		if JY.Person[169].好感度 >= 80 then
			say("峰儿,要记得时时为善，日审己身。", 169, 0, "玄苦大师")
		else
			say("乔峰,你来了？", 169, 0, "玄苦大师")
			say("拜见大师，大师你认识我？", 0, 1)
			say("认识认识，你就住在少室山下，你爹叫做乔三槐可对？", 169, 0, "玄苦大师")
			say("是啊。", 0, 1)
			say("你秉性仁厚，我欲收你为徒，你可愿意？", 169, 0, "玄苦大师")
			say("拜见师父！", 0, 1)
			say("好好好，这是清心咒，你要日日参详。我再教你一些健身的功夫，记住了，要时刻与人为善，不可枉动怒气！", 169, 0, "玄苦大师")
			say("是，师父！", 0, 1)

			local var_91_0 = JY.Person[0].主功体

			stop_ng(0)

			JY.Person[0].武功1 = 1
			JY.Person[0].武功等级1 = 50

			star_ng(0, var_91_0)

			if JY.Person[169].好感度 < 80 then
				JY.Person[169].好感度 = 80
			end
		end
	else
		say("看你一身武艺，身有杀气，宜多多参演佛学，解人生真谛，远江湖争斗。", 169, 0, "玄苦大师")
	end
end
OEVENTLUA[9641] = function ()
	Cls()
	say("我是少林的扫地僧。", 114, 0, "掃地老僧")
end
OEVENTLUA[9642] = function ()
	Cls()

	local var_93_0 = 0
	local var_93_1 = JY.Person[0].悟性
	local var_93_2 = 0
	local var_93_3 = JY.Person[0].气运
	local var_93_4 = 0
	local var_93_5 = JY.Person[0].悟性 / 20 + JY.Person[0].气运

	QZXS("这是一本佛经，看起来微微泛着光华")

	if yesno("要研习吗？") then
		if JY.Person[0].佛学修为 < 30 then
			JY.Person[0].佛学修为 = JY.Person[0].佛学修为 + 2

			dark()
			light()
			QZXS("你的佛性增加了")

			JY.MONTH = JY.MONTH + 1
		else
			say("这本书我已经研究透彻了。", 0, 1)
		end
	else
		say("还是算了。", 0, 1)
	end
end
OEVENTLUA[9643] = function ()
	Cls()

	local var_94_0 = 0
	local var_94_1 = JY.Person[0].悟性
	local var_94_2 = 0
	local var_94_3 = JY.Person[0].气运
	local var_94_4 = 0
	local var_94_5 = JY.Person[0].悟性 / 30 + JY.Person[0].气运

	QZXS("这是一本佛经，看起来微微泛着光华")

	if yesno("要研习吗？") then
		if JY.Person[0].佛学修为 >= 30 and JY.Person[0].佛学修为 < 60 then
			JY.Person[0].佛学修为 = JY.Person[0].佛学修为 + 2

			dark()
			light()
			QZXS("你的佛性增加了")

			JY.MONTH = JY.MONTH + 1
		else
			say("这本书我已经研究透彻了。", 0, 1)
		end
	else
		say("还是算了。", 0, 1)
	end
end
OEVENTLUA[9644] = function ()
	Cls()

	local var_95_0 = 0
	local var_95_1 = JY.Person[0].悟性
	local var_95_2 = 0
	local var_95_3 = JY.Person[0].气运
	local var_95_4 = 0
	local var_95_5 = JY.Person[0].悟性 / 40 + JY.Person[0].气运

	QZXS("这是一本佛经，看起来微微泛着光华")

	if yesno("要研习吗？") then
		if JY.Person[0].佛学修为 >= 60 and JY.Person[0].佛学修为 < 100 then
			JY.Person[0].佛学修为 = JY.Person[0].佛学修为 + 1

			dark()
			light()
			QZXS("你的佛性增加了")

			JY.MONTH = JY.MONTH + 1
		else
			say("这本书我已经研究透彻了。", 0, 1)
		end
	else
		say("还是算了。", 0, 1)
	end
end
OEVENTLUA[9645] = function ()
	Cls()
	say("这么多书，我得好好看看。", 0, 1)
	dark()
	light()
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	addtime(5)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(28, 37)
end
OEVENTLUA[9646] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 30 and has_thing(92) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(92)
		null(28, 38)
	end
end
OEVENTLUA[9647] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 50 and has_thing(137) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(137)
		null(28, 39)
	end
end
OEVENTLUA[9648] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 150 and has_thing(306) == false and JY.Person[0].门派贡献 > 100 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(306)
		null(28, 72)
	end

	if JY.Person[20].好感度 == 90 then
		addthing(306)
		null(28, 72)
	end
end
OEVENTLUA[9649] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 70 and has_thing(90) == false and JY.Person[0].门派贡献 > 60 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(90)
		null(28, 73)
	end

	if JY.Person[20].好感度 == 90 then
		addthing(90)
		null(28, 73)
	end
end
OEVENTLUA[9650] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 70 and has_thing(251) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(251)
		null(28, 74)
	end
end
OEVENTLUA[9651] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 80 and has_thing(69) == false and JY.Person[0].门派贡献 > 80 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(69)
		null(28, 75)
	end

	if JY.Person[20].好感度 == 90 then
		addthing(69)
		null(28, 75)
	end
end
OEVENTLUA[9652] = function ()
	Cls()

	if JY.Person[0].佛学修为 >= 140 and has_thing(85) == false and JY.Person[0].门派贡献 > 200 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(85)
		null(28, 76)
	end

	if JY.Person[20].好感度 == 90 then
		addthing(85)
		null(28, 76)
	end
end
OEVENTLUA[9653] = function ()
	Cls()

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		say("师弟，要进藏经阁看书啊。", 210, 0, "少林弟子")
		say("师兄，有劳了。", 0, 1)
		say("无妨无妨。", 210, 0, "少林弟子")
		dark()
		My_Enter_SubScene(28, 22, 53, 2)
		light()
	else
		say("施主止步。", 210, 0, "少林弟子")
		say("少林藏经阁，非本寺弟子不得入内。", 210, 0, "少林弟子")
	end
end
OEVENTLUA[9654] = function ()
	Cls()

	if JY.Person[0].门派 == 2 then
		say("师兄，有劳了。", 0, 1)
		say("无妨无妨。", 210, 0, "少林弟子")
		dark()
		My_Enter_SubScene(28, 25, 53, 1)
		light()
	end
end
OEVENTLUA[9655] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(174, 200)
	addthing(209, 20)
	instruct_37(-1)
end
OEVENTLUA[9656] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	dark()
	light()
	DrawStrBoxWaitKey("一个月后", C_ORANGE, CC.DefaultFont, 2)
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	addtime(30)
	AddPersonAttrib(0, "武学常识", 5)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(28, 89)
end
OEVENTLUA[9657] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	dark()
	light()
	DrawStrBoxWaitKey("一个月后", C_ORANGE, CC.DefaultFont, 2)
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	addtime(30)
	AddPersonAttrib(0, "武学常识", 5)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(28, 90)
end
OEVENTLUA[9658] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	dark()
	light()
	DrawStrBoxWaitKey("一个月后", C_ORANGE, CC.DefaultFont, 2)
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	addtime(30)
	AddPersonAttrib(0, "武学常识", 5)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(28, 91)
end
OEVENTLUA[9659] = function ()
	Cls()

	if has_thing(239) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(237)
		null(28, 92)
	end
end
OEVENTLUA[9660] = function ()
	Cls()

	if has_thing(240) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(240)
		null(28, 93)
	end
end
OEVENTLUA[9661] = function ()
	Cls()

	if has_thing(243) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(243)
		null(28, 94)
	end
end
OEVENTLUA[9662] = function ()
	Cls()

	if has_thing(242) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(242)
		null(28, 95)
	end
end
OEVENTLUA[9663] = function ()
	Cls()

	if has_thing(112) == false then
		say("这是什么？", 0, 1)
		addthing(112)
		null(28, 149)
	end
end
OEVENTLUA[9664] = function ()
	Cls()
	say("佛学书籍吗？看看先。", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "佛学修为", 5)
	DrawStrBoxWaitKey("你的佛学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 150)
end
OEVENTLUA[9665] = function ()
	Cls()

	if JY.Person[0].门派 == 2 and JY.Person[0].门派等级 ~= 6 then
		local var_116_0 = JY.Person[0]
		local var_116_1 = var_116_0.修炼物品

		if var_116_1 > 0 then
			say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

			if JY.Thing[var_116_1].练出物品需经验 <= 0 then
				return
			end

			dark()
			light()
			addtime(1)

			var_116_0.物品修炼点数 = 300

			War_PersonTrainDrug(0)
		elseif has_something(209, 2) and JY.Person[0].医疗能力 >= 20 then
			say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

			local var_116_2 = {
				9,
				20
			}
			local var_116_3 = var_116_2[math.random(#var_116_2)]

			addtime(1)
			addthing(var_116_3)
			addthing(209, -2)
		else
			say("一座古朴的大药炉，似乎是周朝时期的", 0, 1)
		end
	end
end
OEVENTLUA[9291] = function ()
	Cls()

	local var_117_0 = math.random(10)

	if var_117_0 == 1 then
		say("我泰山派的五大夫剑据说很厉害，知道为什么叫五大夫剑吗？", 1075, 0, "泰山派弟子")
	elseif var_117_0 == 2 then
		say("我们家是大财主，我爸叫王大财，每次和师兄师弟们一块吃饭都是我掏钱，他们对我很尊敬。", 1079, 0, "泰山派弟子")
	elseif var_117_0 == 3 then
		say("想我在家时也是风流倜傥，到了泰山派每天都要练武，练武，好无聊啊！", 1124, 0, "泰山派弟子")
	elseif var_117_0 == 4 then
		say("泰山派是我们这儿第一大派，所以我千辛万苦拜入泰山派，为啥？威风啊！", 1093, 0, "泰山派弟子")
	else
		say("我们泰山风景雄伟，少侠可以多逛逛！", 1079, 0, "泰山派弟子")
	end
end
OEVENTLUA[9292] = function ()
	Cls()
	say("师长都在闭关，少侠止步！", 1079, 0, "泰山派弟子")
	say("我大老远来的，你还不让我看看，以为在泰山盖个房子，泰山就是你们家的了？", 0, 1)
	say("无理取闹！赶快离开。", 1079, 0, "泰山派弟子")

	if yesno("要硬闯泰山派吗？") then
		instruct_37(-1)

		if WarMain(25, 0) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		dark()
		null(-2, 5)
		light()
	end

	say("哼，说我无理取闹，我哪里无理取闹了？", 0, 1)
end
OEVENTLUA[9293] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 2)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(29, 14)
end
OEVENTLUA[9294] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(174, 200)
	addthing(209, 20)
	instruct_37(-1)
end
OEVENTLUA[9295] = function ()
	Cls()
	say("阁下硬闯我泰山派，不知是何用意。", 23, 0)
	Cls()
	say("你的徒弟硬要我跟你拜师，我就来看看你够不够格当我师父。", 0, 1)
	Cls()
	say("好个顽劣的恶徒，让我来教训教训你。", 23, 0)
	Cls()

	if WarMain(26, 0) == false then
		Cls()
		instruct_15()
		Cls()

		return
	end

	Cls()
	instruct_13()
	say("哼！魔教的恶徒，要杀就杀，别在那罗唆。", 23, 0)
	Cls()
	say("好好的，干么杀你？你只是不够格当我师父罢了", 0, 1)
	Cls()
	say("今日不杀我，我五岳剑派同气连枝，改日我们再上黑木崖向阁下及东方不败讨教。", 23, 0)
	Cls()
	addthing(130, 1)
	Cls()
	addevent(29, 0, 1, 9296, 1, -2, -2, -2)
	addevent(29, 1, 1, 9296, 1, -2, -2, -2)
end
OEVENTLUA[9296] = function ()
	Cls()
	say("想不到左盟主为了五岳并派之事，也不顾同盟之谊了。", 23, 0)
end
OEVENTLUA[9301] = function ()
	Cls()
	addthing(209, 50)
	null(30, 1)
end
OEVENTLUA[9302] = function ()
	Cls()
	addthing(10, 10)
	null(30, 2)
end
OEVENTLUA[9303] = function ()
	Cls()
	addthing(6, 2)
	null(30, 3)
end
OEVENTLUA[9304] = function ()
	Cls()
	say("这是医书？", 0, 1)

	if JY.Person[0].医疗能力 >= 20 then
		dark()
		light()
		addtime(5)
		AddPersonAttrib(0, "医疗能力", 5)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 4)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9311] = function ()
	Cls()
	say("见性峰乃恒山派禁地，施主*勿近。", 191, 0)
	Cls()

	if instruct_5() == false then
		Cls()

		return
	end

	if WarMain(23, 0) == false then
		Cls()
		instruct_15()
		Cls()

		return
	end

	instruct_3(-2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	instruct_13()
	instruct_37(-1)
end
OEVENTLUA[9312] = function ()
	Cls()

	local var_128_0 = math.random(5)

	if var_128_0 == 1 then
		say("我们恒山派剑法含蓄收敛，*防守严密，破绽甚少。", 191, 0)
	elseif var_128_0 == 2 then
		say("相传舜帝北巡时，遥望恒山*奇峰耸立，山势巍峨，遂叩*封为北岳，为北国万山之宗*主。", 191, 0)
	elseif var_128_0 == 3 then
		say("我恒山派擅长炼制白云丹，可以迅速回复内力。", 191, 0)
	elseif var_128_0 == 4 then
		say("我恒山派都是女弟子，可以说是江湖第二大女子门派。但是是江湖最互敬互爱的门派。", 191, 0)
	else
		say("我们恒山风景隗丽，少侠可以多逛逛！", 191, 0)
	end
end
OEVENTLUA[9313] = function ()
	Cls()

	if JY.Person[603].好感度 > 50 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		AddPersonAttrib(0, "武学常识", 1)
		DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 1)
	else
		addthing(131, 1)
		say("大胆！胆敢偷我恒山派剑谱。", 21, 0)
		Cls()

		if WarMain(24, 0) == false then
			Cls()
			instruct_15()
			Cls()

			return
		end
	end

	null(31, 9)
end
OEVENTLUA[9314] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(174, 200)
	addthing(209, 50)
	instruct_37(-1)
end
OEVENTLUA[9315] = function ()
	Cls()
	addthing(209, 10)
	addthing(3, 20)
	null(31, 12)
	instruct_37(-1)
end
OEVENTLUA[9316] = function ()
	Cls()
	addthing(209, 10)
	null(31, 13)
	instruct_37(-1)
end
OEVENTLUA[9317] = function ()
	Cls()
	say("想不到左盟主为了五岳并派之事，也不顾同盟之谊了。", 21, 0)
end
OEVENTLUA[9318] = function ()
	Cls()
	say("阿弥陀佛~，施主，我这有恒山疗伤圣药白云熊胆丸，3颗只要2000两银子，不知施主可有需要？", 191, 0)

	if yesno("要买吗？") then
		say("好，我买了。", 0, 1)

		if instruct_31(2000) == false then
			say("施主，你银子不够啊。", 191, 0)

			return
		end

		say("我这是偷偷卖给你的，你可不要说出去，要不以后你就买不到了。", 191, 0)
		say("放心放心。", 0, 1)
		instruct_32(174, -2000)
		addthing(3, 3)
	end
end
OEVENTLUA[9321] = function ()
	Cls()
	addthing(213)
	null(-2, 18)
end
OEVENTLUA[9322] = function ()
	Cls()
	say("阿黄啊，你走吧，不要再跟着我了。", 1262, 0)
	say("老爷子，这马怎么了？", 0, 1)
	say("哎，我年纪大了，眼看快不行了，养不起这马了。", 1262, 0)
	say("这马虽然很瘦弱，可是骨骼粗大，颇有些威势", 0, 2)
	say("老爷子，这马你放了它只怕它也活不了，不如你卖给我吧？", 0, 1)
	say("你要这马？那你随便给点吧，不过要好好待它，跟着我苦了一辈子，没过着一天好日子。", 1262, 0)
	say("没问题，我会好好照顾它的。", 0, 1)
	addthing(174, -100)
	say("哎，阿黄啊，再见了，孤零零来，孤零零走，好没来由。", 1262, 0)
	dark()
	null(-2, 20)
	light()
	say("阿黄，我们走吧。", 0, 1)
	addthing(226)
	null(-2, 21)
end
OEVENTLUA[9331] = function ()
	Cls()
	say("你是何人，到我峨嵋派做什么？是想随我六大派一起进剿光明顶的侠义之士？还是魔教派来的奸细，想打探我六大派的动静。", 6, 0)
	Cls()
	say("师太快别误会了，我并不是您口中什么\"魔教\"奸细，所以还请放心。虽然我自命为侠义之士，但是我并不想随你们去打那个”魔教”。你身为一派掌门，应该为你的徒弟着想。要是我，可舍不得让这些美貌的小尼姑去送命。", 0, 1)
	Cls()
	say("大胆狂徒！念在你非魔教徒的份子上，快快离去，免得我后悔，动手要了你的命。", 6, 0)
	Cls()
end
OEVENTLUA[9332] = function ()
	Cls()
	say("我们峨嵋派掌门灭绝师太，武功高强，手持无双利器倚天剑，斩妖除魔！", 191, 0, "峨眉弟子")
	Cls()
end
OEVENTLUA[9333] = function ()
	Cls()
	addthing(209, 20)
	null(-2, 24)
	instruct_37(-1)
end
OEVENTLUA[9334] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 1)
	null(-2, 23)
end
OEVENTLUA[9341] = function ()
	Cls()
	say("这里是我们崆峒派的地盘，不许乱闯！", 193, 0)
	Cls()

	if instruct_5() == false then
		do return end

		Cls()
	end

	if WarMain(222, 0) == false then
		instruct_15()
		Cls()

		do return end

		Cls()
	end

	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	instruct_13()
end
OEVENTLUA[9342] = function ()
	Cls()
	say("想当年我掌门师祖木灵子以*一套七伤拳威镇天下，名扬*四海，奠定我崆峒派百年的*基业，名列当今武林六大派*之一。", 193, 0)
	Cls()
end
OEVENTLUA[9343] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "别在崆峒派逗留了，*我六大派即将围攻魔教总坛*光明顶了。", 8, 0)
	Cls()
end
OEVENTLUA[9351] = function ()
	Cls()

	local var_144_0 = Rnd(5)

	if JY.Person[0].门派 == 7 or JY.Person[0].门派 == 6 and JY.Person[0].门派等级 == 5 then
		say("拜见教主。", 206, 0, "星宿门人")
		say("教主德配天地，威震当世，古今无比。", 206, 0, "星宿门人")
	elseif var_144_0 == 1 then
		say("本派的理念是——不想当掌门的弟子不是好弟子！", 206, 0, "星宿门人")
	elseif var_144_0 == 2 then
		say("本门的马屁，法螺，厚颜三门神功是很难修习的。寻常人于世俗之见沾染甚深总觉得有些事是好的，有些事是坏的。只要心中存了这种无聊的善恶之念，是非之分，要修习厚颜功便是事倍功半，往往在紧要关头，功亏一篑。", 206, 0, "星宿门人")
	elseif var_144_0 == 3 then
		say("你若想在本门中混下去，最重要的秘诀，自然是将师父奉若神明，他老人家便放个屁，当然也是香的。更须大声吸，小声呼的衷心赞颂。", 206, 0, "星宿门人")
	elseif var_144_0 == 4 and JY.Person[0].门派 == 6 and JY.Person[0].门派等级 < 4 then
		say("新来的，过来。", 206, 0, "星宿门人")
		say("什么事？", 0, 1)
		say("我这袜子有两个月没洗了，你去给我洗洗去。", 206, 0, "星宿门人")
		say("你说什么？", 0, 1)
		say("快去！", 206, 0, "星宿门人")
		say("找死。", 0, 1)
		SetS(28, 12, 18, 5, 3)

		if WarMain(79, 0, 1, 1) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		SetS(28, 12, 18, 5, 0)
		say("给我洗袜子去。", 0, 1)
		say("啊，是是。", 206, 0, "星宿门人")
		dark()
		light()
	else
		say("本门的功夫虽然变化万状，但基本功诀，也不繁复，只须牢记“抹杀良心”四字，大致也差不多了。", 206, 0, "星宿门人")
	end
end
OEVENTLUA[9352] = function ()
	Cls()

	local var_145_0 = 0
	local var_145_1 = JY.Person[0].性别 == 1 and "师姐" or "师兄"

	if JY.Person[0].门派 == 6 and JY.Person[0].门派等级 > 2 and JY.Person[0].门派等级 < 3 then
		say("听说你很厉害？", 0, 1)
		say("放肆，我乃是门派二师兄，还不拜见？", 1093, 0, "二师兄")
		say("可惜，从今天开始你就不是二师兄了，以后你得叫我" .. var_145_1 .. "。", 0, 1)
		say("哼，打过再说。", 1093, 0, "二师兄")
		SetS(35, 15, 30, 5, 2)

		if WarMain(79) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		SetS(35, 15, 30, 5, 0)
		say("叫" .. var_145_1 .. "。", 0, 1)
		say(var_145_1 .. "。", 1093, 0, "二师兄")
		say("哈哈哈。", 0, 1)
		addthing(32, 1)
		say("你别得意，明天我们再打过，我会赢回来的。", 1093, 0, "二师兄")
	elseif JY.Person[0].门派 == 7 or JY.Person[0].门派 == 6 and JY.Person[0].门派等级 == 5 then
		say("掌门好。掌门你如今真是威震四海，环宇无敌啊。", 1093, 0, "二师兄")
	else
		say("什么大" .. var_145_1 .. "，总有一天，我会把你踩在脚下的。", 1093, 0, "二师兄")
	end
end
OEVENTLUA[9353] = function ()
	Cls()

	if JY.Person[0].门派 == 6 then
		if JY.Person[0].门派等级 >= 3 then
			say("阿紫，咱们出去玩吧。", 0, 1)
			say("好啊好啊。", 47, 0, "阿紫")

			if instruct_20() == false then
				instruct_14()
				instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_13()
				instruct_10(47)
				Cls()

				return
			end

			say("你的队伍满了，我无法加入。", 47, 0)
		else
			if JY.Person[47].好感度 >= 55 then
				dark()
				light()
				say("谁阴险啊我阴险，谁可怕啊我可怕。", 47, 0, "阿紫")
				say("你怎么还在这儿？秘籍已经没有了，快滚出去。", 47, 0, "阿紫")

				return
			end

			say("老仙的高级秘籍要不要，大甩卖了，一律3000两银子一本。", 47, 0, "阿紫")

			if instruct_31(3000) == false then
				say("算了，看你就是个屌丝。", 47, 0, "阿紫")

				return
			end

			local var_146_0 = JYMsgBox("请选择", "你想要的高级秘籍", {
				"摧心掌",
				"归元功",
				"龙抓手",
				"含沙射影",
				"啥也不要"
			}, 5, 1115)

			if var_146_0 == 1 then
				addthing(261)
				addthing(174, -3000)

				JY.Person[47].好感度 = JY.Person[47].好感度 + 1
			elseif var_146_0 == 2 then
				addthing(237)
				addthing(174, -3000)

				JY.Person[47].好感度 = JY.Person[47].好感度 + 1
			elseif var_146_0 == 3 then
				addthing(92)
				addthing(174, -3000)

				JY.Person[47].好感度 = JY.Person[47].好感度 + 1
			elseif var_146_0 == 4 then
				addthing(302)
				addthing(174, -3000)

				JY.Person[47].好感度 = JY.Person[47].好感度 + 1
			elseif var_146_0 == 5 then
				return
			end

			say("我就要这个了。", 0, 1)
		end
	else
		say("谁让你进来的？快滚出去。", 47, 0, "阿紫")
	end
end
OEVENTLUA[9354] = function ()
	Cls()
	say("老仙最喜欢奇珍异宝，你有什么宝物可以献上去讨老仙欢喜。", 206, 0, "星宿门人")
	say("若是没有宝物献上，银子也不错，老仙一高兴，咱们都欢喜。", 206, 0, "星宿门人")
end
OEVENTLUA[9361] = function ()
	Cls()

	if instruct_16(36) then
		say("余沧海，你还认得我吗？", 36, 1)
		Cls()
		say("你，你，你是福威镖局的林*平之！", 24, 0)
		Cls()
		say("不错，正是我！你为了辟邪*剑谱，害的我家破人亡，今*日，我就让你见识一下辟邪*剑法，你看清楚了！", 36, 1)
		Cls()

		if WarMain(51, 0) == false then
			if JY.Person[0].门派 == 5 then
				say("怎么？余掌门，你是要当着我的面杀我五岳剑派弟子吗？", 0, 1)
				say("你，你到底要怎么样？", 24, 0)
				say("没什么？总之你不能杀我五岳剑派弟子，否则我就出手灭了你青城派！", 0, 1)
				say("你，你欺人太甚！", 24, 0)
				say("那又怎样？", 0, 1)
				say("......", 24, 0)
				say("林兄弟，咱们先回去，等你练好武功再来。我总要你亲手报了父母的仇。", 0, 1)
				say("多谢掌门！", 36, 1)

				JY.Person[36].好感度 = JY.Person[36].好感度 + 1
			else
				say("林兄弟，我来帮你。", 0, 1)

				if WarMain(354, 0) == false then
					instruct_15()
					Cls()
				end

				dark()
				instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_3(-2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				instruct_13()
				say("爹，娘，我终于为你们报仇了。我好想你们。", 36, 1)
				say("林兄弟，节哀！", 0, 1)

				JY.Person[36].好感度 = JY.Person[36].好感度 + 20

				addthing(174, 1000)
				addthing(209, 200)
			end

			Cls()

			return
		end

		dark()
		instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_13()
		say("爹，娘，我终于为你们报仇了。我好想你们。", 36, 1)
		say("林兄弟，节哀！", 0, 1)

		JY.Person[36].好感度 = JY.Person[36].好感度 + 20

		addthing(174, 1000)
		addthing(209, 200)

		if JY.Person[0].门派 == 5 then
			say("来人，以后这儿就是咱们的青城分堂了，派几个人驻扎在这儿。", 0, 1)
			say("是。", 193, 0, "五岳弟子")
			addevent(36, 7, 1, 2100, 1, 5180)
			addevent(36, 8, 1, 2100, 1, 5180)
		end

		instruct_37(1)

		return
	end

	say("嘿嘿嘿，我要想办法把青城*派发扬广大……", 24, 0)
	Cls()
end
OEVENTLUA[9362] = function ()
	Cls()
	say("我们师兄弟四人，侯人英、*洪人雄、于人豪和在下罗人*杰，被江湖中人称为\"英雄豪杰，青城四秀\"。", 200, 0, "青城弟子")
end
OEVENTLUA[9363] = function ()
	Cls()
	say("我青城派的绝技松风剑法，*刚劲轻灵，兼而有之，那真*是如松之劲，如风之轻。", 200, 0, "青城弟子")
end
OEVENTLUA[9364] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(21, 3)
	addthing(9, 5)
	instruct_37(-1)
end
OEVENTLUA[9365] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(36, 6)
end
OEVENTLUA[9391] = function ()
	Cls()
	say("来者何人，*胆敢擅闯凌霄城。", 204, 0, "雪山弟子")
	Cls()

	if instruct_5() == false then
		return
	end

	say("啊，没事，我就是想进来逛*逛。", 0, 1)
	Cls()
	say("哼，堂堂雪山派，岂容你随*意来去！", 204, 0, "雪山弟子")
	Cls()

	if WarMain(58, 0) == false then
		instruct_15()
		Cls()

		return
	end

	instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	instruct_13()
end
OEVENTLUA[9392] = function ()
	say("我们雪山派的上一代掌门，乃是威德先生白自在，据他自己说乃是震古烁今德武学大宗师，真是我们雪山派德骄傲啊。", 204, 0, "雪山弟子")
	Cls()
end
OEVENTLUA[9393] = function ()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
	Cls()
	addthing(21, 5)
	Cls()
	addthing(3, 5)
	Cls()
	addthing(174, 200)
	Cls()
	instruct_37(-1)
end
OEVENTLUA[9394] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	addthing(126)
	null(39, 21)
end
OEVENTLUA[9401] = function ()
	Cls()

	local var_157_0 = Rnd(5)

	if JY.Base.百年标记 == 0 then
		if var_157_0 == 1 then
			say("想当年，辽国想要派大军入侵中原，被七公他老人家得到消息，一夜之间宰杀了统军元帅及旗下七名大将军，弄得各国王公大臣人人自危，再不敢轻言入中原。", 1133, 0, "酒客")
			say("不错，从此后各国王公莫不是深居简出，深怕被中原的高手得到行踪，如此豪气，江湖上谁不称道。", 1137, 1, "酒客")
			say("好男儿当如是，来来来，为七公他老人家干一杯。", 1133, 0, "酒客")
			say("干。", 1137, 1, "酒客")
		elseif var_157_0 == 2 then
			say("自五岳剑派与魔教一场大战后，近10余年来，魔教偃旗息鼓，看来是损伤不小，到如今都没有恢复元气。", 1133, 0, "酒客")
			say("不错，听说任老魔失踪了，现任教主是东方不败，十分年轻，估计已经不是五岳剑派的对手了。", 1137, 1, "酒客")
			say("是啊，如今嵩山的左盟主可不是好相与的，武功只怕不比当年的任老魔差了。", 1133, 0, "酒客")
		else
			say("听说武当又出了一个青年高手叫宋青书，最近出来行走江湖了！", 1133, 0, "酒客")
			say("武当七侠威名远播，这个宋青书定不会弱了。", 1137, 1, "酒客")
			say("是啊是啊。", 1133, 0, "酒客")
		end
	else
		say("洛阳是千古名都，不知出了多少千古名人。", 1133, 0, "酒客")
		say("是啊是啊。", 1137, 0, "酒客")
	end
end
OEVENTLUA[9402] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		if JY.YEAR > 4 then
			say("北乔峰南慕容，北乔峰我知道，那是真豪杰真英雄，慕容复算什么？不过是家世好，算什么英雄。", 1130, 0, "酒客")
			say("南慕容这么大名气，只怕也不简单，传闻慕容家传的斗转星移能够使用和他对敌的人的武功，许多好汉都死在自己最得意的绝技之下。", 1132, 0, "酒客")
			say("多半是假的，这世上要有这样的武功，那还不无敌了。", 1130, 0, "酒客")
			say("江湖传闻嘛，夸张还是有的，不过没有人知道真假，因为见过的人都已经死了。", 1132, 0, "酒客")
		elseif JY.YEAR > 2 then
			say("听说了吗？玄铁令出世了。", 1130, 0, "酒客")
			say("玄铁令？莫不是摩天居士谢烟客的玄铁令？这下可好，怕不是江湖上要一阵大乱了。", 1132, 0, "酒客")
			say("那是，得到玄铁令就是得到摩天居士的一个承诺，摩天居士出道以来从无敌手，谁不想得他的助力？", 1130, 0, "酒客")
			say("我要得到玄铁令，就让摩天居士收我做徒弟，练就一身绝顶武艺，纵横江湖，嘿嘿。", 1132, 0, "酒客")
			say("你就想吧，我不打搅你。", 1130, 0, "酒客")
		else
			say("雷家近些时间发展好快，势力都发展到陕西境内了！", 1130, 0, "酒客")
			say("陕西境内？那不是华山派的势力范围吗？他们胆子也太大了。", 1132, 0, "酒客")
			say("可不是说，说也奇怪，华山派居然一直不管不问，也不知道什么缘故。", 1130, 0, "酒客")
		end
	else
		say("据说百年前的大侠都能飞檐走壁，也不知道是不是真的。", 1133, 0, "酒客")
		say("你呀，少看一些志怪小说吧，家里老婆孩子还指着你养活呢。", 1137, 0, "酒客")
	end
end
OEVENTLUA[9403] = function ()
	Cls()

	if JY.Person[106].好感度 == 51 then
		say("我金刀王家和林家素来交好。如今林家惨遭灭门，真是可惜。", 106, 0)
	else
		say("年轻人，要学武去练功房报名。", 106, 0)
	end
end
OEVENTLUA[9404] = function ()
	Cls()

	if JY.Person[106].好感度 == 51 then
		say("我金刀门雄踞洛阳，就是太守和郡守也得看看我王家的脸色，靠的就是江湖朋友抬爱。", 208, 0, "金刀门人")
	else
		say("我爷爷就是威震中原的金刀*无敌王元霸，怎么样，吓到*了吧。", 208, 0, "金刀门人")
	end
end
OEVENTLUA[9405] = function ()
	Cls()
	say("想要学习刀法吗？", 208, 0, "金刀门人")

	if yesno("要学习刀法吗？") then
		say("很好，一月200两银子", 208, 0, "金刀门人")

		if instruct_31(200) == false then
			say("你的银子不够。", 208, 0, "金刀门人")

			return
		end

		say("我金刀门称雄中原，刀法雄劲霸道，基础刀法就是其重中之重。我演练一遍，自己看，学到什么地步看你自己的能力了。", 208, 0, "金刀门人")
		dark()
		light()
		addtime(30)
		addthing(174, -200)
		say("好了，一月的修炼结束了。", 208, 0, "金刀门人")

		if JY.Person[0].耍刀技巧 < 30 then
			AddPersonAttrib(0, "耍刀技巧", 5)
		end

		say("金刀门对外授徒乃是与武林人士结个善缘，年轻人，要努力修炼，以后也像我们金家一样成为一方豪雄的。", 208, 0, "金刀门人")
	end
end
OEVENTLUA[9406] = function ()
	Cls()
	dark()
	light()

	if has_thing(206) then
		say("尊龙会所，进入需要先交纳1000两银子。", 1124, 0, "看门人")

		if yesno("要交纳1000两银子吗？") then
			Cls()

			if instruct_31(1000) == false then
				say("你的银子不够，等凑够银子再来吧。", 1124, 0, "看门人")
				My_Enter_SubScene(40, 53, 39, 0)

				return
			end

			say("尊客请进。", 1124, 0, "看门人")
			addthing(174, -1000)
			dark()
			My_Enter_SubScene(40, 53, 46, 3)
			light()
		else
			say("请离开。", 1124, 0, "看门人")
			My_Enter_SubScene(40, 53, 39, 0)
		end
	elseif JY.Person[0].门派 == 1 and JY.Person[82].好感度 == 49 then
		say("站住！", 1124, 0, "看门人")
		say("私人会所，没有熟人介绍不得进入。", 1124, 0, "看门人")
		say("我大师兄是武当的宋青书。", 0, 1)
		say("让他进来！", 1009, 0, "舵主")
		say("是。", 1124, 0, "看门人")
		dark()
		My_Enter_SubScene(40, 52, 48, 2)
		light()
		say("尊龙会所，进入需要先交纳1000两银子，你还要进去吗？", 1009, 0, "舵主")

		if yesno("要交纳1000两银子吗？") then
			Cls()

			if instruct_31(1000) == false then
				say("你的银子不够，等凑够银子再来吧。", 1009, 0, "舵主")
				My_Enter_SubScene(40, 53, 39, 0)

				return
			end

			say("很好，这是会所信物，你拿好。", 1009, 0, "舵主")
			addthing(174, -1000)
			addthing(206, 1)
			Cls()
		else
			say("入门费不交是不能进去的，请离开吧。", 1009, 0, "舵主")
			My_Enter_SubScene(40, 53, 39, 0)
		end
	else
		say("站住！", 1124, 0, "看门人")
		say("尊龙会所，闲人不得进入。", 1124, 0, "看门人")
		My_Enter_SubScene(40, 53, 39, 0)
	end
end
OEVENTLUA[9407] = function ()
	Cls()
	dark()
	light()
	say(JY.Person[0].称呼 .. "，欢迎再来啊！", 1124, 0, "看门人")
	My_Enter_SubScene(40, 53, 39, 0)
end
OEVENTLUA[9408] = function ()
	Cls()

	local var_164_0 = {
		516,
		517,
		518,
		519,
		520,
		521,
		522
	}
	local var_164_1 = var_164_0[math.random(#var_164_0)]
	local var_164_2 = Rnd(4)

	if var_164_2 == 1 then
		say("唉，好无聊哦～～", var_164_1, 0)
		dark()
		addthing(174, -100)
		light()
	elseif var_164_2 == 2 then
		say("我会跳敦煌舞，我跳给你看啊。", var_164_1, 0)
		dark()
		addthing(174, -100)
		light()
	elseif var_164_2 == 3 then
		say("闺中少妇不知愁，春日凝妆上翠楼。忽见陌头杨柳色，悔教夫婿觅封侯。", var_164_1, 0)
		dark()
		addthing(174, -100)
		light()
	elseif var_164_2 == 4 then
		say("云母屏风烛影深，长河渐落晓星沉。嫦娥应悔偷灵药，碧海青天夜夜心。", var_164_1, 0)
		dark()
		addthing(174, -100)
		light()
	else
		say("听我弹一首小曲吧。", var_164_1, 0)
		dark()
		addthing(174, -100)
		light()
	end
end
OEVENTLUA[9409] = function ()
	Cls()

	local var_165_0 = {
		1008,
		1060,
		1063,
		1072,
		1258,
		1259,
		1273
	}
	local var_165_1 = var_165_0[math.random(#var_165_0)]
	local var_165_2 = Rnd(4)

	if var_165_2 == 1 then
		say(JY.Person[0].称呼 .. "，人生苦短，及时行乐啊。", var_165_1, 0)
	elseif var_165_2 == 2 then
		say("鸣筝金粟柱，素手玉房前。欲得周郎顾，时时误拂弦。", var_165_1, 0)
	elseif var_165_2 == 3 then
		say("银烛秋光冷画屏，轻罗小扇扑流萤。天阶夜色凉如水，卧看牵牛织女星。", var_165_1, 0)
	else
		say("本以高难饱，徒劳恨费声。五更疏欲断，一树碧无情。", var_165_1, 0)
	end
end
OEVENTLUA[9410] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "，你今天气色不错啊。", 1009, 0, "舵主")
end
OEVENTLUA[9411] = function ()
	Cls()
	say("我家公子乃是洛阳四大公子之首，人称玉面郎君常太俊，老爷就是洛阳太守常泰山，在洛阳，乃至中州都是大名鼎鼎。", 371, 0, "仆人")
end
OEVENTLUA[9412] = function ()
	Cls()

	if inteam(91) then
		dark()
		addevent(40, 114, 1, -2, 1, 7032, -2, -2)
		light()
		say("刚进城门处有间客栈，我们去歇息一下吧。", 91, 0)
		say("好。", 0, 1)
		say("去年今日此门中，人面桃花相映红。", 1077, 0, "常太俊")
		say(JY.Person[0].称呼 .. "，看你仪表不凡，这位美女也是花容月貌，不似凡人，不知可否赏脸，本公子请你喝酒如何？", 1077, 0, "常太俊")

		if yesno("要和这俊俏公子喝酒吗？") then
			say("恭敬不如从命。", 0, 1)
			say(JY.Person[0].称呼 .. "爽快，就旁边这醉仙居如何？乃是洛阳最好的酒楼，他家酿的女儿红也是酒香浓郁，四野有名。", 1077, 0, "常太俊")
			say("兄台请。", 0, 1)
			dark()
			null(-2, 110)
			null(-2, 111)
			null(-2, 114)
			My_Enter_SubScene(40, 13, 50, 2)
			addevent(40, 113, 1, -2, 1, 10452, -2, -2)
			addevent(40, 112, 1, -2, 1, 7032, -2, -2)
			light()
			say(JY.Person[0].称呼 .. "，你我一见如故，今日不醉不归，来，喝！", 1077, 0, "常太俊")
			say("好酒，青青，你也喝点。", 0, 1)

			if JY.Person[0].抗毒能力 > 30 then
				say("酒过半饷，你只觉头脑一片昏沉，不过一会儿后又恢复清明", 0, 2)
				say("来，兄弟，咱们再喝。", 0, 1)
				say("俊俏公子略有疑惑的看了看你，接着又和你谈笑风生", 0, 2)
				dark()
				light()
				say(JY.Person[0].称呼 .. "好酒量，果非常人！", 1077, 0, "常太俊")
				say("今日依然尽兴，愚兄告辞！", 1077, 0, "常太俊")
				dark()
				null(-2, 112)
				null(-2, 113)
				light()
				say("呼，一顿好酒，这兄台不愧我辈中人。", 0, 1)

				return
			end

			say("酒过半饷，你只觉头脑一片昏沉，不由一头栽下，睡了过去", 0, 2)
			dark()
			null(-2, 112)
			null(-2, 113)
			My_Enter_SubScene(40, 57, 2, 1)
			light()

			if JY.Person[0].性别 == 0 then
				instruct_27(-1, 5974, 5992)
			else
				instruct_27(-1, 10642, 10650)
			end

			say("哎呀，头好晕。", 0, 1)
			say("咦？青青呢？", 0, 1)
			instruct_21(91)
			null(70, 109)

			JY.Person[91].好感度 = 10

			addevent(40, 104, 1, 9413, 1, 9388, -2, -2)
		else
			say("可惜，可惜。", 1077, 0, "常太俊")
		end
	elseif inteam(77) then
		dark()
		addevent(40, 114, 1, -2, 1, 7248, -2, -2)
		light()
		say("刚进城门处有间客栈，我们去歇息一下吧。", 77, 0)
		say("好。", 0, 1)
		say("去年今日此门中，人面桃花相映红。", 1077, 0, "常太俊")
		say(JY.Person[0].称呼 .. "，看你仪表不凡，这位美女也是花容月貌，不似凡人，不知可否赏脸，本公子请你喝酒如何？", 1077, 0, "常太俊")

		if yesno("要和这俊俏公子喝酒吗？") then
			say("恭敬不如从命。", 0, 1)
			say(JY.Person[0].称呼 .. "爽快，就旁边这醉仙居如何？乃是洛阳最好的酒楼，他家酿的女儿红也是酒香浓郁，四野有名。", 1077, 0, "常太俊")
			say("兄台请。", 0, 1)
			dark()
			null(-2, 110)
			null(-2, 111)
			null(-2, 114)
			My_Enter_SubScene(40, 13, 50, 2)
			addevent(40, 113, 1, -2, 1, 10452, -2, -2)
			addevent(40, 112, 1, -2, 1, 7248, -2, -2)
			light()
			say(JY.Person[0].称呼 .. "，你我一见如故，今日不醉不归，来，喝！", 1077, 0, "常太俊")
			say("好酒，妹子，你也喝点。", 0, 1)

			if JY.Person[0].抗毒能力 >= 60 then
				say("酒过半饷，你只觉头脑一片昏沉，不过一会儿后又恢复清明", 0, 2)
				say("来，兄弟，咱们再喝。", 0, 1)
				say("俊俏公子略有疑惑的看了看你，接着又和你谈笑风生", 0, 2)
				dark()
				light()
				say(JY.Person[0].称呼 .. "好酒量，果非常人！", 1077, 0, "常太俊")
				say("今日依然尽兴，愚兄告辞！", 1077, 0, "常太俊")
				dark()
				null(-2, 112)
				null(-2, 113)
				light()
				say("呼，一顿好酒，这兄台不愧我辈中人。", 0, 1)

				return
			end

			say("酒过半饷，你只觉头脑一片昏沉，不由一头栽下，睡了过去", 0, 2)
			dark()
			null(-2, 112)
			null(-2, 113)
			My_Enter_SubScene(40, 57, 2, 1)
			light()

			if JY.Person[0].性别 == 0 then
				instruct_27(-1, 5974, 5992)
			else
				instruct_27(-1, 10642, 10650)
			end

			say("哎呀，头好晕。", 0, 1)
			say("咦？萧妹妹呢？", 0, 1)
			instruct_21(77)
			null(70, 50)

			JY.Person[77].好感度 = 10

			addevent(40, 104, 1, 9413, 1, 9388, -2, -2)
		else
			say("可惜，可惜。", 1077, 0, "常太俊")
		end
	else
		say("炉香闲袅凤凰儿，空持罗带，回首恨依依。好桃花，好美。", 1077, 0, "常太俊")
	end
end
OEVENTLUA[9413] = function ()
	Cls()
	say("此是私人别院，你进来做什么？", 1257, 0, "太守")
	say("你可是洛阳太守？", 0, 1)
	say("本官正是。", 1257, 0, "太守")
	say("将常太俊给我交出来，否则我饶不了你。", 0, 1)
	say("大胆，来人啊，将这个狂徒拿下！", 1257, 0, "太守")

	if WarMain(515, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("敬酒不吃吃罚酒，我这就结果了你。", 0, 1)
	say("等等，来人啊，快将少爷叫过来。", 1257, 0, "太守")
	say("是，老爷。", 372, 0, "仆人")
	dark()
	addevent(40, 108, 1, -2, 1, 10456, -2, -2)
	light()
	say("老爹，你找我做什么啊？扰了我的好事。", 1077, 0, "常太俊")
	My_Enter_SubScene(40, 18, 28, 1)
	say("常~太~俊~", 0, 1)
	say(JY.Person[0].称呼 .. "，原来是你，一夜未见，甚是想念，不如一会儿咱们再去喝一杯如何？", 1077, 0, "常太俊")
	say("废话少说，我的女伴呢？", 0, 1)
	say(JY.Person[0].称呼 .. "，这我如何知道？昨日一别我就回府了，许是她有什么事情先走了吧。", 1077, 0, "常太俊")
	say("好胆！", 0, 1)
	My_Enter_SubScene(40, 21, 29, 1)
	say("我数三下，不说我就杀了你！", 0, 1)
	say("一~", 0, 1)
	say("二~", 0, 1)
	say("等等。", 1077, 0, "常太俊")
	say(JY.Person[0].称呼 .. "，你这么着急做什么，玩玩而已嘛。", 1077, 0, "常太俊")
	say("阿忠，去别府将小娘子带过来。", 1077, 0, "常太俊")
	say("是，少爷。", 372, 0, "仆人")

	if JY.Person[91].好感度 == 10 then
		dark()
		addevent(40, 116, 1, -2, 1, 7062, -2, -2)
		light()
		say("青青，你怎么样了？", 0, 1)
		say("我，我全身无力。", 91, 0)
		say("快把解药拿来。", 0, 1)
		dark()
		light()
		say("好些了吗？", 0, 1)
		say("淫贼！我杀了你！", 91, 0)
		say("等等，我有话说。", 1257, 0, "太守")
		say("事情已经发生，你杀了他也是不能挽回，不如我们做个交易。", 1257, 0, "太守")
		say("什么？", 0, 1)
		say("人生一世，不过权钱。我为官数十年，积累颇厚。", 1257, 0, "太守")
		say("这官员的语速极快，似乎生怕你一下手快将人杀了", 0, 2)
		say("你看，你们是江湖人，免不了与朝廷产生摩擦，我官场人脉颇厚，这些麻烦我都可以帮你解决。", 1257, 0, "太守")
		say("另外，你若是有不用的兵器、秘籍、药物等，也可以和我交易，我绝对出比外面更高的价格来买的。", 1257, 0, "太守")
		say("你可以得到长远的利益，少侠你看可好？", 1257, 0, "太守")

		if yesno("要接受太守的提议吗？") then
			say("说得好听，难道这次的事就算了？", 0, 1)
			say("补偿，我肯定补偿。", 1257, 0, "太守")
			say("太俊，你去后院取些银票过来给少侠。", 1257, 0, "太守")
			say("好。", 1077, 1, "常太俊")
			null(-2, 108)
			dark()
			addevent(40, 108, 1, -2, 1, 10594, -2, -2)
			light()
			say("老爷，银票取来了。", 372, 0, "仆人")
			addthing(327, 3)
			say("少爷呢？", 1257, 1, "太守")
			say("少爷受了惊吓，说是头晕，在后院躺下了。", 372, 0, "仆人")
			say("这个不成器的小子，回头送他去汤老大人那里去，免得总给我惹事。", 1257, 1, "太守")
			say("青青，你看？", 0, 1)
			say("你~", 91, 0)
			say("无耻！", 91, 0)
			say("青青，你不要激动，事情已经这样了，这是最理智的做法。", 0, 1)
			null(-2, 116)
			say("青青~", 0, 1)
			say("少侠，没事的，女人嘛，就是这样，不识大体。", 1257, 0, "太守")
			say("阿忠，你去叫常师爷过来。", 1257, 0, "太守")
			say("是。", 372, 1, "仆人")
			dark()
			addevent(40, 108, 1, -2, 1, 10298, -2, -2)
			light()
			say("拜见太守大人。", 1260, 0, "常师爷")
			say("常守啊，我和这位少侠展开合作了，具体事务你都熟悉，你来操办一下。", 1257, 1, "太守")
			say("是，大人。", 1260, 0, "常师爷")

			if JY.Person[0].中原罪恶值 > 0 then
				say("先帮少侠把罪名清除了，少侠你看可好？", 1257, 1, "太守")
				say("好好。", 0, 0)
			end

			say("少侠这次把我吓得不轻，我也下去休息休息，少侠你随意，随意，当自己家里就好。", 1257, 1, "太守")
			dark()
			null(-2, 104)
			addevent(40, 108, 1, 9425, 1, 10082, -2, -2)
			light()
			say("少侠，你看可需要什么服务？", 1260, 0, "常师爷")

			return
		else
			say("惹了我的人，你还想活着？", 0, 1)
			say("去死！", 0, 1)
			say("啊~", 1077, 0, "常太俊")
			addevent(40, 108, 1, 6533, 1, 10206, -2, -2)
			say("你，你好狠~", 1077, 0, "常太俊")
			say("太俊~", 1257, 0, "太守")
			say("杀人啦~", 372, 1, "仆人")
			null(-2, 115)
			say("你们，居然敢杀我的儿子~", 1257, 0, "太守")
			say("还有你！", 91, 1)
			say("啊~~", 1257, 0, "太守")
			addevent(40, 104, 1, 6533, 1, 10222, -2, -2)
			say("青青，你？", 0, 1)
			say("哼。", 91, 0)
			null(-2, 116)
			say("青青~，等一等。", 0, 1)
			say("这，这可如何是好？", 0, 1)

			JY.Person[0].中原罪恶值 = JY.Person[0].中原罪恶值 + 100
		end
	end

	if JY.Person[77].好感度 == 10 then
		dark()
		addevent(40, 116, 1, -2, 1, 7010, -2, -2)
		light()
		say("小妹，你怎么样了？", 0, 1)
		say("我，我全身无力。", 77, 0)
		say("快把解药拿来。", 0, 1)
		dark()
		light()
		say("好些了吗？", 0, 1)
		say("淫贼！我杀了你！", 77, 0)
		say("等等，我有话说。", 1257, 0, "太守")
		say("事情已经发生，你杀了他也是不能挽回，不如我们做个交易。", 1257, 0, "太守")
		say("什么？", 0, 1)
		say("人生一世，不过权钱。我为官数十年，积累颇厚。", 1257, 0, "太守")
		say("这官员的语速极快，似乎生怕你一下手快将人杀了", 0, 2)
		say("你看，你们是江湖人，免不了与朝廷产生摩擦，我官场人脉颇厚，这些麻烦我都可以帮你解决。", 1257, 0, "太守")
		say("另外，你若是有不用的兵器、秘籍、药物等，也可以和我交易，我绝对出比外面更高的价格来买的。", 1257, 0, "太守")
		say("你可以得到长远的利益，少侠你看可好？", 1257, 0, "太守")

		if yesno("要接受太守的提议吗？") then
			say("说得好听，难道这次的事就算了？", 0, 1)
			say("补偿，我肯定补偿。", 1257, 0, "太守")
			say("太俊，你去后院取些银票过来给少侠。", 1257, 0, "太守")
			say("好。", 1077, 1, "常太俊")
			null(-2, 108)
			dark()
			addevent(40, 108, 1, -2, 1, 10594, -2, -2)
			light()
			say("老爷，银票取来了。", 372, 0, "仆人")
			addthing(327, 3)
			say("少爷呢？", 1257, 1, "太守")
			say("少爷受了惊吓，说是头晕，在后院躺下了。", 372, 0, "仆人")
			say("这个不成器的小子，回头送他去汤老大人那里去，免得总给我惹事。", 1257, 1, "太守")
			say("小妹，你看？", 0, 1)
			say("你~", 77, 0)
			say("无耻！", 77, 0)
			say("小妹，你不要激动，事情已经这样了，这是最理智的做法。", 0, 1)
			say("我", 77, 0)
			null(-2, 116)
			say("小妹~", 0, 1)
			say("少侠，没事的，女人嘛，就是这样，不识大体。", 1257, 0, "太守")
			say("阿忠，你去叫常师爷过来。", 1257, 0, "太守")
			say("是。", 372, 1, "仆人")
			dark()
			addevent(40, 108, 1, -2, 1, 10298, -2, -2)
			light()
			say("拜见太守大人。", 1260, 0, "常师爷")
			say("常守啊，我和这位少侠展开合作了，具体事务你都熟悉，你来操办一下。", 1257, 1, "太守")
			say("是，大人。", 1260, 0, "常师爷")

			if JY.Person[0].中原罪恶值 > 0 then
				say("先帮少侠把罪名清除了，少侠你看可好？", 1257, 1, "太守")
				say("好好。", 0, 0)
			end

			say("少侠这次把我吓得不轻，我也下去休息休息，少侠你随意，随意，当自己家里就好。", 1257, 1, "太守")
			dark()
			null(-2, 104)
			addevent(40, 108, 1, 9425, 1, 10082, -2, -2)
			light()
			say("少侠，你看可需要什么服务？", 1260, 0, "常师爷")

			return
		else
			say("惹了我的人，你还想活着？", 0, 1)
			say("去死！", 0, 1)
			say("啊~", 1077, 0, "常太俊")
			addevent(40, 108, 1, -2, 1, 10206, -2, -2)
			say("你，你好狠~", 1077, 0, "常太俊")
			say("太俊~", 1257, 0, "太守")
			say("你们，居然敢杀我的儿子~", 1257, 0, "太守")
			say("小妹，你？", 0, 1)
			say("我，我想回家。", 77, 0)
			say("好，好，我这就送你回去。", 0, 1)
			say("不用，我想自己走，别了。", 77, 0)
			null(-2, 116)
			say("等等，小妹？", 0, 1)
			say("你们死定了，敢杀我的儿子~", 1257, 0, "太守")
			say("滚！", 0, 1)
			say("哼。", 1257, 0, "太守")
			null(-2, 104)
			null(-2, 115)

			JY.Person[0].中原罪恶值 = JY.Person[0].中原罪恶值 + 150
		end
	end

	dark()
	addevent(40, 118, 1, -2, 1, 10594, -2, -2)
	addevent(40, 119, 1, -2, 1, 10594, -2, -2)
	addevent(40, 120, 1, -2, 1, 10594, -2, -2)
	light()
	say("抓住这个狂徒。", 1250, 0, "捕快")

	if WarMain(515, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	null(40, 120)
	say("好厉害的贼子，快去请守备大人派城守军过来。", 1250, 0, "捕快")
	say("真是麻烦，我还是先避避风头。", 0, 1)
	say("不要跑。", 1250, 0, "捕快")
	dark()
	ReturnMMap2(225, 293)
	null(40, 118)
	null(40, 119)
	null(40, 104)
	null(40, 108)
	addevent(40, 115, 1, 6481, 1, 10592, -2, -2)
	light()
	addtime(1)
end
OEVENTLUA[9414] = function ()
	Cls()
	say("我是川西御家的御天北，奉家主之命打通往西域的商路，可惜过了洛阳就被强盗截了商队。", 1009, 0, "御天北")
	say("不知少侠可否帮忙找回货物？我有重谢。", 1009, 0, "御天北")

	if yesno("要出手帮忙吗？") then
		say("太好了，出事地点就在洛阳西北，还请少侠尽快前往。", 1009, 0, "御天北")
		addevent(103, 32, 1, 9415, 1, 8932, -2, -2)
		addevent(103, 33, 1, 9415, 1, 10194, -2, -2)
		addevent(103, 34, 1, -2, 1, 486, -2, -2)

		JY.Person[535].好感度 = 49
	else
		say("可惜。", 1009, 0, "御天北")
	end
end
OEVENTLUA[9415] = function ()
	Cls()

	if JY.Person[535].好感度 == 49 then
		say("谁？", 1270, 0, "强盗2")
		say("你们是什么人？鬼鬼祟祟在做什么？", 0, 1)
		say("滚！", 1270, 0, "强盗2")
		say("好胆！", 0, 1)

		if WarMain(336, 0, 1, 1) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		say("说，前次的商队被劫是不是和你们有关？", 0, 1)
		say("我什么也不会说的，你就是杀了我也没用。", 1270, 0, "强盗2")
		say("不错，杀了我们也没用。", 1271, 0, "强盗1")
		say("好，那我就杀了你。", 0, 1)
		say("不劳你动手。", 1270, 0, "强盗2")
		say("唔。", 1270, 0, "强盗2")
		addevent(103, 33, 1, 6533, 1, 10210, -2, -2)
		say("哎？...", 0, 1)
		say("别杀我，我说，我说。", 1271, 0, "强盗1")
		say("哦？", 0, 1)
		say("老大叫我们在这里打探消息，要是有去往西域的商队就汇报上去。", 1271, 0, "强盗1")
		say("这么说御家的商队就是你们截的了？你们把货物运到哪里去了？", 0, 1)
		say("都分发给各位兄弟了。", 1271, 0, "强盗1")
		say("分发？你们老大在哪里？", 0, 1)
		say("我们总部在中州密洞，你进去也是找不到人的。", 1271, 0, "强盗1")
		say("那和你无关。", 0, 1)

		if yesno("要杀了这个强盗吗？") then
			say("死~", 0, 1)
			say("你，你说活不算话。", 1271, 0, "强盗1")
			say("唔。", 1271, 0, "强盗1")
			addevent(103, 32, 1, 6533, 1, 10222, -2, -2)
		else
			addevent(103, 32, 1, 9416, 1, 8932, -2, -2)
		end

		addevent(41, 3, 0, 9417, 3, -2, -2, -2)
		addevent(41, 21, 1, 9417, 1, 10364, -2, -2)
		addevent(41, 29, 1, 9417, 1, 10190, -2, -2)
		addevent(41, 30, 1, 9417, 1, 10304, -2, -2)
		addevent(40, 110, 1, 9418, 1, 10080, -2, -2)
	else
		say("谁？", 1270, 0, "强盗2")
		say("你们在这里做什么？", 0, 1)
		say("没看我们在这里烤火吗？不要来打扰我们。", 1270, 0, "强盗1")
	end
end
OEVENTLUA[9416] = function ()
	Cls()

	local var_172_0 = Rnd(3)

	if var_172_0 == 1 then
		say("你武功这么高，为什么要帮助那些叛徒？", 1271, 0, "强盗1")
		say("嗯？", 0, 1)
		say("他们这些家族，为了私利，将中原的武器盔甲卖给西域的胡人，不知害了咱们多少百姓。", 1271, 0, "强盗1")
		say("你为什么要帮他们？", 1271, 0, "强盗1")
		say("这是真的？", 0, 1)
		say("这种事一查便知，如何能够欺瞒？", 1271, 0, "强盗1")
		say("你走吧。", 0, 1)
		say("你杀了王刀，老大不会放过你的。", 1271, 0, "强盗1")
		dark()
		null(-2, 32)
		null(-2, 33)
		light()

		JY.Person[535].好感度 = 51
	elseif var_172_0 == 2 then
		say("这次算是遇到狠人了，这活太危险了，我不干了。", 1271, 0, "强盗1")
		say("嗯？", 0, 1)
		say("啊~", 1271, 0, "强盗1")
		dark()
		null(-2, 32)
		light()
	else
		say("果然是道高一尺，魔高一丈。", 1271, 0, "强盗1")
		say("嗯？", 0, 1)
		say("大侠，我这就走，这就走。", 1271, 0, "强盗1")
		dark()
		null(-2, 32)
		null(-2, 33)
		light()
	end
end
OEVENTLUA[9417] = function ()
	Cls()
	dark()
	null(-2, 3)
	light()
	say("老大，有敌人杀进来了。", 1270, 0, "强盗1")
	say("怕什么？给我杀！", 1274, 1, "强盗首领")
	say("等下。", 0, 1)
	say("杀啊~", 1272, 0, "强盗首领")

	if WarMain(337, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	dark()
	null(-2, 21)
	null(-2, 29)
	null(-2, 30)
	light()
	addthing(237)
	say("强盗是杀了，可是你搜遍了周围，也没有找到什么货物", 0, 2)

	if JY.Person[535].好感度 == 51 then
		instruct_37(-5)
	end

	JY.Person[535].好感度 = 48
end
OEVENTLUA[9418] = function ()
	Cls()
	say("怎么样？找到货物了吗？", 1009, 0, "御天北")

	if JY.Person[535].好感度 == 51 then
		say("我听说你们将武器盔甲卖给西域胡人，可是真的？", 0, 1)
		say("怎么？少侠要管这事？", 1009, 0, "御天北")

		if yesno("你要管这事吗？") then
			say("少侠，我劝你还是不要管这事了，我御家可不是普通家族。", 1009, 0, "御天北")
			say("此事我管定了。", 0, 1)
			say("那你能怎么样？当街杀我？还是骂我一顿？有用吗？", 1009, 0, "御天北")
			say("那就杀你。", 0, 1)
			say("死~", 0, 1)
			say("你~你怎敢？", 1009, 0, "御天北")
			addevent(40, 110, 1, 6533, 1, 10236, -2, -2)
			dark()
			addevent(40, 111, 1, -2, 1, 10592, -2, -2)
			addevent(40, 114, 1, -2, 1, 10590, -2, -2)
			light()
			say("大胆狂徒，居然敢当街杀人，随我衙门走一趟。", 221, 0, "捕快")

			if yesno("要反抗官兵吗？") then
				say("居然还敢拒捕。", 1250, 0, "捕快")

				if WarMain(514, 0, 1, 1) == false then
					instruct_15(0)
					instruct_0()

					return
				end

				null(40, 111)
				null(40, 114)
				null(40, 110)

				JY.Person[0].中原罪恶值 = JY.Person[0].中原罪恶值 + 100
			else
				say("大哥，你别激动，我和你去府衙。", 0, 1)
				dark()
				My_Enter_SubScene(119, 2, 48, 1)
				null(40, 110)
				null(40, 111)
				null(40, 114)
				light()
				addtime(300)
				say("搞什么？你们快放我出去。", 0, 1)
				dark()
				light()
				addtime(300)
				say("还没审案呢，你们就关我。", 0, 1)
				dark()
				light()
				addtime(300)
				addtime(300)
				addtime(300)
				addtime(300)
				addtime(300)
				addtime(300)
				addtime(300)
				dark()
				light()
				addtime(300)
				say("算你运气好，新任太守娶28房小妾，要冲喜，你们这些快到期的犯人可以出去了。", 1250, 0, "捕快")
				say("出去后老老实实做人，另外把这几天的伙食费交了，赶快出去吧。", 1250, 0, "捕快")
				addthing(174, -30000)
				dark()
				My_Enter_SubScene(40, 33, 33, 1)
				light()
				say("这都什么事啊。", 0, 1)
				say("你左右张望，只觉沧海桑狗，四顾茫然", 0, 2)

				JY.Person[0].生命 = 50
				JY.Person[0].生命最大值 = JY.Person[0].生命最大值 - 100
				JY.Person[0].生命增长 = JY.Person[0].生命增长 - 1
				JY.Person[0].精神 = JY.Person[0].精神 - 1
				JY.Person[0].中原罪恶值 = 0
			end
		else
			say("与我无关。", 0, 1)
			say("识时务。", 1009, 0, "御天北")
			say("既然一时找不回货物，我也只能回家求助了。", 1009, 0, "御天北")
			dark()
			null(40, 110)
			light()
		end
	elseif JY.Person[535].好感度 == 48 then
		say("我已经将强盗都杀了，可惜没有找到货物。", 0, 1)
		say("真是可惜。", 1009, 0, "御天北")
		say("这是给你的报酬，还请不要推辞。哎，我该怎么向家主交待？", 1009, 0, "御天北")
		dark()
		null(-2, 110)
		light()
	else
		say("我还没有找到货物。", 0, 1)
		say("少侠还请努力。", 1009, 0, "御天北")
	end

	null(103, 32)
	null(103, 33)
	null(103, 34)
end
OEVENTLUA[9419] = function ()
	Cls()
	null(-2, 121)
	addthing(0)
	instruct_37(-1)
end
OEVENTLUA[9420] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(0)
	instruct_37(-1)
end
OEVENTLUA[9421] = function ()
	Cls()
	My_Enter_SubScene(99, 2, 42, 1)
end
OEVENTLUA[9425] = function ()
	Cls()
	say("少侠，你看可需要什么服务？", 1260, 0, "常师爷")

	local var_178_0 = JYMsgBox("洛阳太守府", "只针对尊贵客人的服务**大官员联盟会员特享服务", {
		"卖出物品",
		"清除罪名"
	}, 2, 1260, 1)

	if var_178_0 == 1 then
		sell(1260, 3)
	elseif var_178_0 == 2 then
		clear(1260, 2, 400)
	end
end
OEVENTLUA[9431] = function ()
	Cls()

	local var_179_0 = 0
	local var_179_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"
	local var_179_2 = math.random(10)
	local var_179_3 = Rnd(10)

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		if var_179_2 == 1 then
			say(var_179_1 .. "，咱们来练练？", 1124, 0, "武当弟子")
			SetS(43, 38, 28, 5, 4)

			if WarMain(295, 0) == false then
				if var_179_3 == 10 then
					say("笨，你这儿使得不对！", 1075, 0, "武当弟子")
					dark()
					light()
					say("原来如此，多谢师兄指点。", 0, 1)

					JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + JY.Person[0].悟性 / 10

					War_PersonTrainBook(0)
					addtime(1)
				end
			else
				say("小师弟，你的资质颇高，将来定会有所成就的。", 1124, 0, "武当弟子")
			end

			SetS(43, 38, 28, 5, 0)
		elseif var_179_2 == 2 then
			say(var_179_1 .. "，太极要动静结合，可不要一个劲傻练啊。", 1093, 0, "武当弟子")
			say("是，师兄。", 0, 1)
		elseif var_179_2 == 3 then
			say("今天练的绕指柔剑第三式，似乎手势要更灵活一些才成！", 1075, 0, "武当弟子")
		elseif var_179_2 == 4 then
			say("我武当的太极拳喻攻于守，四两拨千斤，是武林一等一的拳法！", 1075, 0, "武当弟子")
		elseif var_179_2 == 5 then
			say("我武当的镇派神功太极神功，在战斗时可出太极奥义，大大增加攻击和防守！可惜我还不够条件学习。", 1075, 0, "武当弟子")
		else
			say(var_179_1 .. "，你又来练功吗？真是努力啊。", 1075, 0, "武当弟子")
		end
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	elseif var_179_2 == 1 then
		say("我们家是大财主，我爸叫旺老财，每次和师兄师弟们一块吃饭都是我掏钱，他们对我很尊敬。", 1093, 0, "武当弟子")
	elseif var_179_2 == 2 then
		say("我们武当最厉害的就是大师兄了，是我们武当第一弟子！", 1079, 0, "武当弟子")
	elseif var_179_2 == 3 then
		say("想我在家时也是风流倜傥，到了武当每天都要练武，练武，好无聊啊！", 1124, 0, "武当弟子")
	elseif var_179_2 == 4 then
		say("有武当镇压，周边几郡都安宁太平，没有强盗匪帮敢犯。所以我千辛万苦拜入武当，为啥？威风啊！", 1093, 0, "武当弟子")
	elseif var_179_2 == 5 then
		say("过几天又该用洗身汤炼体了，真期待啊，每次洗身后就精神百倍，武功大进！", 1093, 0, "武当弟子")
	elseif var_179_2 == 6 then
		say("听说曾经有人学会了20门武功，真是奇才啊。", 1079, 0, "武当弟子")
	else
		say("我们武当风景优美，少侠可以多逛逛！", 1079, 0, "武当弟子")
	end
end
OEVENTLUA[9432] = function ()
	Cls()

	local var_180_0 = {
		15,
		38,
		62,
		81,
		102,
		103,
		116,
		126,
		131
	}
	local var_180_1 = var_180_0[math.random(#var_180_0)]
	local var_180_2 = Rnd(5)

	if JY.Person[0].门派 == 1 then
		if JY.Person[0].门派等级 < 4 then
			if JY.Person[0].无用4 < 10 then
				say("如今武当药材来源紧张，之前是师兄们先让着你用，从现在起，你也得出任务了！", 1079, 0, "武当弟子")
				say("咱们的附属小门派每月都会汇集珍贵药材送到武当。", 1079, 0, "武当弟子")
				say("如今盗匪猖獗，路上不够安全，所以咱们的弟子要时常出去接应他们入武当来。", 1079, 0, "武当弟子")

				if yesno("要出去护送珍贵药材吗？") == false then
					say("我如今还不想出去做任务。", 0, 1)
					say("那就算了，我找其他人去吧！", 1079, 0, "武当弟子")
					instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
				else
					say("很好，咱们走。", 1079, 0, "武当弟子")
					dark()
					addevent(var_180_1, 150, 1, -2, 1, 10142, 26, 28)
					addevent(var_180_1, 151, 1, -2, 1, 10142, 25, 28)
					addevent(var_180_1, 152, 1, -2, 1, 2784, 25, 32)
					addevent(var_180_1, 153, 1, -2, 1, 2786, 26, 32)
					addevent(var_180_1, 154, 1, -2, 1, 10368, 25, 30)
					addevent(var_180_1, 155, 1, -2, 1, 10192, 26, 30)
					addevent(var_180_1, 156, 1, -2, 1, 6112, 33, 31)
					My_Enter_SubScene(var_180_1, 33, 30, 2)
					light()
					say("可恶，武当的人来接应了！", 1271, 0, "盗匪")
					say("呼，终于安全了。", 1229, 1, "附属帮派")

					if var_180_2 > 2 then
						say("武当的人又怎么了，咱们可不怕。", 1270, 0, "盗匪")
						say("好胆！", 1079, 1, "武当弟子")

						if WarMain(414, 0, 1, 1) == false then
							instruct_15(0)
							instruct_0()

							return
						end

						null(-2, 154)
						null(-2, 155)
					elseif var_180_2 == 2 then
						say("糟糕，怎么来的这么快，我们快走。", 1270, 0, "盗匪")
						say("哪里走！", 1079, 1, "武当弟子")

						if WarMain(414, 0, 1, 1) == false then
							instruct_15(0)
							instruct_0()

							return
						end

						null(-2, 154)
						null(-2, 155)
					else
						say("糟糕，怎么来的这么快，我们快走。", 1270, 0, "盗匪")
						say("哪里走！", 1079, 1, "武当弟子")
						null(-2, 154)
						null(-2, 155)
						say("跑得倒是快。", 1079, 1, "武当弟子")
					end

					say("辛亏你们来得及时，最近道上真是不太安全。", 1229, 1, "附属帮派")
					say("无妨，我武当地界，那容他们行凶，咱们回去吧。", 1079, 1, "武当弟子")
					dark()
					null(-2, 152)
					null(-2, 153)
					null(-2, 150)
					null(-2, 151)
					null(-2, 156)
					addevent(43, 46, 1, -2, 1, 5388)
					My_Enter_SubScene(43, 5, 49, 2)
					light()
					say("你表现得不错，如今药材有了，我这就给你配置药液。", 1079, 1, "武当弟子")

					JY.Person[0].门派贡献 = JY.Person[0].门派贡献 + 1

					dark()
					light()
					say("可以了，自己进去吧。", 1079, 1, "武当弟子")
					say("多谢师兄。", 0, 1)
					dark()
					instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
					light()

					if JY.Person[0].无用4 > 1 then
						say("洗身之后果然神清气爽，精神百倍。", 0, 1)
						DrawStrBox(-1, -1, "你感觉自己的经脉似乎打开，身体更通透了", C_ORANGE, CC.DefaultFont)
						ShowScreen()
						lib.Delay(2000)
						Cls()

						local var_180_3 = math.modf(JY.Base.游戏难度 - 1)

						AddPersonAttrib(0, "生命最大值", 20)
						instruct_47(0, 5 + var_180_3)
						instruct_43(0, 5 + var_180_3)
						instruct_45(0, 5 + var_180_3)

						JY.Person[0].无用4 = JY.Person[0].无用4 - 1
					else
						say("洗过之后似乎没有什么变化。", 0, 1)
					end

					addtime(1)
				end

				return
			end

			say("每月的5号是弟子锻身炼体的日子，嗯，你这月还没有洗过，可以进去了！", 1079, 0, "武当弟子")
			say("多谢师兄。", 0, 1)
			dark()
			light()

			if JY.Person[0].无用4 > 1 then
				DrawStrBox(-1, -1, "你感觉自己的经脉似乎打开，身体更通透了", C_ORANGE, CC.DefaultFont)
				ShowScreen()
				lib.Delay(2000)
				Cls()

				local var_180_4 = math.modf(JY.Base.游戏难度 - 1)

				say("洗过之后果然神清气爽，精神百倍。", 0, 0)
				AddPersonAttrib(0, "生命最大值", 20)
				instruct_47(0, 5 + var_180_4)
				instruct_43(0, 5 + var_180_4)
				instruct_45(0, 5 + var_180_4)

				JY.Person[0].无用4 = JY.Person[0].无用4 - 1
			else
				say("洗过之后似乎没有什么变化。", 0, 1)
			end

			addtime(1)
			say("好了，我又该去收集药材了。", 1079, 0, "武当弟子")
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		elseif JY.Person[0].门派等级 == 4 then
			say("长老好。", 1124, 0, "武当弟子")
		end
	else
		say("少侠，这儿是武当弟子炼身之地，不方便参观！", 1079, 0, "武当弟子")
	end
end
OEVENTLUA[9433] = function ()
	Cls()

	local var_181_0 = 0
	local var_181_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		say(var_181_1 .. "，和师伯说说，下次下山带我一起去啊。", 1079, 0, "武当弟子")
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	else
		say("我们武当是中原大派，出了很多侠客的！", 1079, 0, "武当弟子")
	end
end
OEVENTLUA[9434] = function ()
	Cls()

	local var_182_0 = 0
	local var_182_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"
	local var_182_2 = Rnd(10)

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		say(var_182_1 .. "，我们来练练，光靠打木人是很难进步的！", 1075, 0, "武当弟子")
		say("好，请师兄指教。", 0, 1)
		SetS(43, 38, 28, 5, 1)

		if WarMain(295, 0) == false then
			if JY.Person[0].修炼物品 == 106 then
				say(var_182_1 .. "，我看你正在修习绵掌，这个是这样的。", 1075, 0, "武当弟子")
				dark()
				light()
				say("如何？可有所领悟？", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄！", 0, 1)

				JY.Person[0].修炼点数 = TrainNeedExp(0) - 1
			else
				say("你这招式还有点问题，应该这样这样！", 1075, 0, "武当弟子")
				dark()
				light()
				say("能领悟多少，就看你自己的了。", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄指点。", 0, 1)

				JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + JY.Person[0].悟性 * 3

				War_PersonTrainBook(0)
			end

			say("今日练武也累了，该休息了。", 1075, 0, "武当弟子")
		else
			say(var_182_1 .. "，你进步真快啊！", 1075, 0, "武当弟子")
			say("居然被" .. var_182_1 .. "追上了，我也该更努力了。", 1075, 0, "武当弟子")
		end

		addtime(1)
		null(43, 2)
		SetS(43, 38, 28, 5, 0)
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	else
		say("冬练三九，夏练三伏，要成为大侠，苦练是免不了的。", 1075, 0, "武当弟子")
	end
end
OEVENTLUA[9435] = function ()
	Cls()

	local var_183_0 = 0
	local var_183_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"
	local var_183_2 = Rnd(10)

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		say(var_183_1 .. "，我们来练练，光靠打木人是很难进步的！", 1075, 0, "武当弟子")
		say("好，请师兄指教。", 0, 1)
		SetS(43, 38, 28, 5, 2)

		if WarMain(295, 0) == false then
			if JY.Person[0].修炼物品 == 97 then
				say(var_183_1 .. "，我看你正在修习太极拳，这个是这样的。", 1075, 0, "武当弟子")
				dark()
				light()
				say("如何？可有所领悟？", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄！", 0, 1)

				JY.Person[0].修炼点数 = TrainNeedExp(0) - 1
			else
				say("你这招式还有点问题，应该这样这样！", 1075, 0, "武当弟子")
				dark()
				light()
				say("能领悟多少，就看你自己的了。", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄指点。", 0, 1)

				JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + JY.Person[0].悟性 * 3

				War_PersonTrainBook(0)
			end

			say("今日练武也累了，该休息了。", 1075, 0, "武当弟子")
		else
			say(var_183_1 .. "，你进步真快啊！", 1075, 0, "武当弟子")
			say("居然被" .. var_183_1 .. "追上了，我也该更努力了。", 1075, 0, "武当弟子")
		end

		addtime(1)
		null(43, 3)
		SetS(43, 38, 28, 5, 0)
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	else
		say("冬练三九，夏练三伏，要成为大侠，苦练是免不了的。", 1075, 0, "武当弟子")
	end
end
OEVENTLUA[9436] = function ()
	Cls()

	local var_184_0 = 0
	local var_184_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"
	local var_184_2 = Rnd(10)

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		say(var_184_1 .. "，你进步很快啊，来，我们来练练。", 1075, 0, "武当弟子")
		say("好，请师兄指教。", 0, 1)
		SetS(43, 38, 28, 5, 3)

		if WarMain(295, 0) == false then
			if JY.Person[0].修炼物品 == 125 then
				say(var_184_1 .. "，我看你正在修习柔云剑术，这个是这样的。", 1075, 0, "武当弟子")
				dark()
				light()
				say("如何？可有所领悟？", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄！", 0, 1)

				JY.Person[0].修炼点数 = TrainNeedExp(0) - 1
			else
				say("你这招式还有点问题，应该这样这样！", 1075, 0, "武当弟子")
				dark()
				light()
				say("能领悟多少，就看你自己的了。", 1075, 0, "武当弟子")
				say("原来如此，多谢师兄指点。", 0, 1)

				JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + JY.Person[0].悟性 * 3

				War_PersonTrainBook(0)
			end

			say("今日练武也累了，该休息了。", 1075, 0, "武当弟子")
		else
			say(var_184_1 .. "，你进步真快啊！", 1075, 0, "武当弟子")
			say("居然被" .. var_184_1 .. "追上了，我也该更努力了。", 1075, 0, "武当弟子")
		end

		addtime(1)
		null(43, 1)
		SetS(43, 38, 28, 5, 0)
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	else
		say("冬练三九，夏练三伏，要成为大侠，苦练是免不了的。", 1075, 0, "武当弟子")
	end
end
OEVENTLUA[9437] = function ()
	Cls()

	local var_185_0 = 0
	local var_185_1 = JY.Person[0].性别 == 1 and "小师妹" or "小师弟"
	local var_185_2 = math.random(3)

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 < 4 then
		say(var_185_1 .. "，我们在这儿斗蛐蛐呢，有没有兴趣来一把？", 1066, 0, "武当弟子")

		if yesno("要来一把吗？") then
			say("好，我加入。", 0, 1)
			say("一次押十两，来，开始了。", 1066, 0, "武当弟子")
			say("只见两只蛐蛐在瓮里斗来斗去，十分的激烈。", 0, 2)
			dark()
			light()

			if var_185_2 == 1 then
				say(var_185_1 .. "有眼光，你赢了。", 1081, 0, "武当弟子")
				addthing(174, 30)
			else
				say("哈哈，我赢了，银子都拿来。", 1081, 0, "武当弟子")
				addthing(174, -10)
			end
		end
	elseif JY.Person[0].门派 == 1 and JY.Person[0].门派等级 == 4 then
		say("长老好。", 1124, 0, "武当弟子")
	else
		say("少侠有事请到大厅找我们师父师伯。", 1081, 0, "武当弟子")
	end
end
OEVENTLUA[9438] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(174, 200)
	addthing(209, 20)

	if JY.Person[0].门派 ~= 1 then
		instruct_37(-1)
	end
end
OEVENTLUA[9439] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2492, 2492, 2492, -2, -2, -2)
	addthing(7, 2)
	addthing(10, 5)
	addthing(209, 20)

	if JY.Person[0].门派 ~= 1 then
		instruct_37(-1)
	end
end
OEVENTLUA[9440] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 and has_thing(281) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(281)
		null(43, 48)
	end
end
OEVENTLUA[9441] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 and has_thing(265) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(265)
		null(43, 49)
	end
end
OEVENTLUA[9442] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		dark()
		light()
		DrawStrBoxWaitKey("一个月后", C_ORANGE, CC.DefaultFont, 2)
		say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
		addtime(30)
		AddPersonAttrib(0, "武学常识", 5)
		DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
		null(43, 50)

		return
	end
end
OEVENTLUA[9443] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		dark()
		light()
		addtime(30)
		say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
		AddPersonAttrib(0, "武学常识", 5)
		DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
		null(43, 51)

		return
	end
end
OEVENTLUA[9444] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 and has_thing(237) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(237)
		null(43, 52)
	end
end
OEVENTLUA[9445] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 and has_thing(240) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(240)
		null(43, 53)
	end
end
OEVENTLUA[9446] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(241)
	null(43, 54)
end
OEVENTLUA[9447] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and JY.Person[0].门派等级 ~= 6 and has_thing(284) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(284)
		null(43, 55)
	end
end
OEVENTLUA[9448] = function ()
	Cls()
	say("咦？这块石头下怎么还压着一本书？", 0, 1)
	addthing(106)
	null(43, 82)
end
OEVENTLUA[9449] = function ()
	Cls()
	say("这么多书，我得好好看看。嗯？这是什么？真武七截阵？", 0, 1)
	dark()
	light()
	addtime(5)
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(43, 60)
end
OEVENTLUA[9450] = function ()
	Cls()

	if JY.Person[0].门派 == 1 and (JY.Person[0].中毒程度 > 0 or JY.Person[0].受伤程度 > 0 or JY.Person[0].流血值 > 0 or JY.Person[0].生命 < JY.Person[0].生命最大值) then
		say("又受伤了，该泡一下药浴了，可别留下病根。", 0, 1)
		dark()
		light()
		addtime(1)
		say("入了名门大派就是好啊。", 0, 1)

		for iter_198_0 = 0, CC.HeadNum do
			if inteam(iter_198_0) then
				JY.Person[iter_198_0].中毒程度 = 0
				JY.Person[iter_198_0].受伤程度 = 0
				JY.Person[iter_198_0].流血值 = 0
				JY.Person[iter_198_0].生命 = JY.Person[iter_198_0].生命 + 100

				if JY.Person[iter_198_0].生命 > JY.Person[iter_198_0].生命最大值 then
					JY.Person[iter_198_0].生命 = JY.Person[iter_198_0].生命最大值
				end

				JY.Person[iter_198_0].体力 = JY.Person[iter_198_0].体力 + 30

				if JY.Person[iter_198_0].体力 > 100 then
					JY.Person[iter_198_0].体力 = 100
				end

				JY.Person[iter_198_0].内力 = JY.Person[iter_198_0].内力 + 500

				if JY.Person[iter_198_0].内力 > JY.Person[iter_198_0].内力最大值 then
					JY.Person[iter_198_0].内力 = JY.Person[iter_198_0].内力最大值
				end
			end
		end
	end
end
OEVENTLUA[9451] = function ()
	Cls()

	if JY.Person[0].门派 == 1 then
		local var_199_0 = JY.Person[0]
		local var_199_1 = var_199_0.修炼物品

		if var_199_1 > 0 then
			say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

			if JY.Thing[var_199_1].练出物品需经验 <= 0 then
				return
			end

			dark()
			light()
			addtime(1)

			var_199_0.物品修炼点数 = 300

			War_PersonTrainDrug(0)
		elseif has_something(209, 2) and JY.Person[0].医疗能力 >= 20 then
			say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

			local var_199_2 = {
				9,
				20
			}
			local var_199_3 = var_199_2[math.random(#var_199_2)]

			addtime(1)
			addthing(var_199_3)
			addthing(209, -2)
		else
			say("一座古朴的大药炉，似乎是唐朝时期的", 0, 1)
		end
	end
end
OEVENTLUA[9456] = function ()
	Cls()
	say("这个是？《麻服散》？", 0, 1)

	if JY.Person[0].医疗能力 >= 20 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "医疗能力", 5)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 7)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9457] = function ()
	Cls()
	say("这儿还有几本书。", 0, 1)

	if JY.Person[0].医疗能力 >= 30 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "解毒能力", 5)
		DrawStrBoxWaitKey("你的解毒能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 4)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9458] = function ()
	Cls()
	addthing(21, 3)
	addthing(9, 5)
	null(-2, 5)
end
OEVENTLUA[9459] = function ()
	Cls()
	dark()
	null(-2, 8)
	light()
	say("胡青牛呢？他在哪里？", 1112, 0)
	say("他不在。", 0, 1)
	say("你是谁？", 1112, 0)
	say("我？我是，那个", 0, 1)
	say("好胆，敢进蝴蝶谷里偷东西~", 1112, 0)

	if WarMain(156, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	dark()
	addevent(44, 2, 1, 9460, 1, 5286, -2, -2)
	light()
	say("你是什么人？在我这儿做什么？", 16, 0)
	say("原来是主人回来了。", 0, 1)
	say("赶快离开，这儿不欢迎外人。", 16, 0)
end
OEVENTLUA[9460] = function ()
	Cls()

	if JY.Person[12].好感度 == 51 then
		say("你就是胡青牛？", 0, 1)
		say("你是？", 16, 0)
		say("原来是教主大人，胡青牛拜见教主。", 16, 0)
		say("不用多礼，听说你医shu术不错，我身边正需要一个杏林圣手。", 0, 1)
		say("小的有为教主效劳的地方，是小的荣幸。", 16, 0)
		say("好。", 0, 1)
		say("只是小的还有一些私事要处理，不知可否晚一些时日再到光明顶为教主效力。", 16, 0)
		say("既如此，你办完事就赶去小村吧，我有事会去那儿找你。", 0, 1)
		say("是。", 16, 0)
		dark()
		null(-2, 2)
		addevent(70, 46, 1, 2687, 1, 5284, -2, -2)
		light()
	else
		say("赶快离开，我这儿不给人治病，也不欢迎访客。", 16, 0)
	end
end
OEVENTLUA[9461] = function ()
	Cls()
	My_Enter_SubScene(80, 35, 14, 3)
end
OEVENTLUA[9462] = function ()
	Cls()

	if instruct_16(91) then
		dark()
		null(-2, 3)
		null(-2, 4)
		addevent(-2, 0, 1, -2, 1, 8426)
		light()
		say("山壁上刻着许多小子，似乎是某种武功的注解，可惜没有对应秘笈，完全不知道到底在说些什么", 0, 2)
		say("呜呜爹爹。", 91, 0)
		say("青青，别伤心了。", 0, 1)
		say("从墙上的字来看，这位金蛇*郎君夏前辈真是一位了不起*的高人啊。", 0, 1)
		Cls()
		say("那是，我爹爹自然了不起。", 91, 0)
		dark()
		addevent(-2, 2, 1, -2, 1, 7060)
		light()
		say("袁公子？", 91, 0)
		say("青青姑娘，当年我就是在这里学到你爹的金蛇剑法，今日我就传授给你。", 54, 1)
		say("多谢袁师兄。", 91, 0)
		Cls()
		stop_ng(91)
		instruct_35(91, 0, 40, 500)

		JY.Person[91].修炼物品 = 121

		DrawStrBoxWaitKey("温青青学会武功【金蛇剑法】", C_ORANGE, CC.DefaultFont, 2)
		say("这把剑是你爹爹的随身武器，今日也交给你。", 54, 1)
		say("多谢袁师兄。", 91, 0)
		addthing(40)

		if has_thing(121) == false then
			say("怎么样？又学到一门厉害的武功，你要不要学？", 91, 0)
			say("我学。", 0, 1)
			say("青青姑娘对你可真好。", 54, 0)
			say("是啊，青青人很好。", 0, 1)
			say("那是，不过我只对你好。", 91, 0)
			say("真是让人羡慕啊，你可得好好珍惜。", 54, 1)
			addthing(121, 1)
		end

		dark()
		null(-2, 0)
		null(-2, 2)
		addevent(116, 16, 0, 1750, 3, -2, -2, -2)
		addevent(116, 17, 1, -2, 1, 9132, -2, -2)
		addevent(116, 18, 1, -2, 1, 10106, -2, -2)
		addevent(116, 21, 1, -2, 1, 9188, -2, -2)
		addevent(116, 19, 1, -2, 1, 10144, -2, -2)
		addevent(116, 20, 1, -2, 1, 10144, -2, -2)
		light()
	else
		say("山壁上刻着许多小子，似乎是某种武功的注解，可惜没有对应秘笈，完全不知道到底在说些什么", 0, 2)
	end
end
OEVENTLUA[9463] = function ()
	Cls()

	if instruct_16(91) then
		say("金蛇郎君夏雪宜之墓。", 0, 2)
		say("呜呜爹爹。", 91, 0)
		say("青青，没事的，还有我陪着你呢。", 0, 1)
	else
		say("金蛇郎君夏雪宜之墓。", 0, 2)
	end
end
OEVENTLUA[9471] = function ()
	Cls()
	say("晚辈参见一灯大师。", 0, 1)
	say("阿弥陀佛，" .. JY.Person[0].称呼 .. "不必多礼。", 65, 0)
	say("晚辈有些迷障，还请大师指点。", 0, 1)
	say("阿弥陀佛。", 65, 0)
	dark()
	light()
	addtime(7)

	if JY.Person[0].佛学修为 < 100 then
		JY.Person[0].佛学修为 = JY.Person[0].佛学修为 + 5

		DrawStrBoxWaitKey(string.format("你的佛学修为增加了"), C_ORANGE, CC.DefaultFont)
	end
end
OEVENTLUA[9481] = function ()
	Cls()
	say("铁掌山不欢迎外人，赶快离开。", 67, 0)
end
OEVENTLUA[9482] = function ()
	Cls()
	say("铁掌山不欢迎外人，赶快离开。", 208, 0)
end
OEVENTLUA[9483] = function ()
	Cls()
	say("家师人送外号铁掌水上漂，轻功掌法都是绝顶，当年横扫衡山派，打得衡山派无人敢出来迎战，真是威震武林。", 208, 0)
end
OEVENTLUA[9484] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(48, 31)
end
OEVENTLUA[9485] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(240)
	null(48, 32)
end
OEVENTLUA[9491] = function ()
	Cls()

	if inteam(2) == false then
		dark()
		light()
		say("树林茂密，鲜花怒放，空气十分清新，你靠近了一点，感觉头脑突然一阵眩晕。", 0, 2)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 5974, 5992)
		else
			instruct_27(-1, 10642, 10650)
		end

		JY.Person[0].中毒程度 = 40

		dark()
		light()
		My_Enter_SubScene(49, 30, 53, 0)
		say("该死，刚才是晕倒了？这地方好危险，我得离这些花远一点儿。", 0, 1)

		if JY.Person[0].解毒能力 >= 20 or JY.Person[0].抗毒能力 >= 20 or JY.Person[0].医疗能力 >= 30 then
			null(49, 0)
		end
	end
end
OEVENTLUA[9492] = function ()
	Cls()
	null(49, 6)
	say("你看见一本有着一层灰尘的书籍，你拿了起来，上面写着《洗身汤》。", 0, 2)
	addthing(326, 1)

	if inteam(2) == false then
		instruct_37(-1)
		say("不好，中毒了。", 0, 1)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 5974, 5992)
		else
			instruct_27(-1, 10642, 10650)
		end

		JY.Person[0].中毒程度 = 40

		dark()
		null(-2, 8)
		addevent(49, 7, 1, -2, 1, 8684, -2, -2)
		light()
		say("小贼，你胆子不小啊，偷到毒手药王的家里来了。", 2, 0, "程灵素 ")
		say("啊？这位姐姐，你误会了，我是无意中闯进来的。", 0, 1)
		say("是吗？（似笑非笑的看你）", 2, 0, "程灵素 ")
		say("真的。", 0, 1)
		say("你到那边粪池去装小半桶粪，到溪里加满清水，帮我把这块花地浇一浇。", 2, 0, "程灵素 ")
		say("我......", 0, 1)
		say("不去也行，或者你愿意在床上躺上两三年也是可以的。", 2, 0, "程灵素 ")
		say("我去我去。", 0, 1)
		dark()
		My_Enter_SubScene(49, 14, 31, 0)
		light()
		instruct_27(-1, 6702, 6742)
		instruct_27(-1, 6702, 6742)
		addtime(30)
		dark()
		My_Enter_SubScene(49, 21, 32, 0)
		light()
		say("大姐，都做完了。", 0, 1)
		say("你叫我什么？", 2, 0, "程灵素 ")
		say("啊？那个，美女，活都做完了。", 0, 1)

		JY.Person[0].中毒程度 = 0

		say("好了好了，放你一马了，江湖凶险，以后不要随便拿人东西了知道吗？", 2, 0, "程灵素 ")
		say("快离开吧。", 2, 0, "程灵素 ")
		null(49, 7)
	end
end
OEVENTLUA[9493] = function ()
	Cls()
	null(49, 1)
	addthing(1, 5)
	addthing(209, 10)

	if inteam(2) == false then
		instruct_37(-1)
		say("不好，中毒了。", 0, 1)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 5974, 5992)
		else
			instruct_27(-1, 10642, 10650)
		end

		JY.Person[0].中毒程度 = 40

		dark()
		addevent(49, 11, 1, -2, 1, 8682, -2, -2)
		light()
		stands()
		say("小贼，你胆子不小啊，偷到毒手药王的家里来了。", 2, 0, "程灵素 ")
		say("啊？这位姐姐，你误会了，我是无意中闯进来的。", 0, 1)
		say("是吗？（似笑非笑的看你）", 2, 0, "程灵素 ")
		say("真的。", 0, 1)
		say("去外边菜地，帮我捉捉虫儿。", 2, 0, "程灵素 ")
		say("我......", 0, 1)
		say("不去也行，或者你愿意在床上躺上两三年也是可以的。", 2, 0, "程灵素 ")
		say("我去我去。", 0, 1)
		dark()
		My_Enter_SubScene(49, 36, 44, 0)
		light()
		instruct_27(-1, 6702, 6742)
		instruct_27(-1, 6702, 6742)
		addtime(30)
		dark()
		My_Enter_SubScene(49, 29, 21, 2)
		light()
		say("大姐，都做完了。", 0, 1)
		say("你叫我什么？", 2, 0, "程灵素 ")
		say("啊？那个，美女，活都做完了。", 0, 1)
		say("好了好了，放你一马了，江湖凶险，以后不要随便拿人东西了知道吗？", 2, 0, "程灵素 ")
		say("快离开吧。", 2, 0, "程灵素 ")

		JY.Person[0].中毒程度 = 0

		null(49, 11)
	end
end
OEVENTLUA[9494] = function ()
	Cls()
	say("这个是？《幽冥花混毒解析》？", 0, 1)

	if JY.Person[0].医疗能力 >= 30 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "医疗能力", 5)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 4)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9511] = function ()
	Cls()

	if JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 25 then
		say("参见帮主。", 207, 0, "丐帮弟子")
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 4 then
		say("参见护法长老。", 207, 0, "丐帮弟子")
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 < 4 then
		say("丐帮人最擅长的歌曲叫做《莲花落》，你要不要学一下？", 207, 0, "丐帮弟子")
	else
		say("休息时间，请勿施舍。", math.random(1033, 1037), 0)
	end
end
OEVENTLUA[9512] = function ()
	Cls()

	if JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 25 then
		say("帮主我好饿，有没有吃的？", 207, 0, "丐帮弟子")
		say("给，自己去买点吃的。", 0, 1)
		addthing(174, -5)
		say("谢谢帮主。", 207, 0, "丐帮弟子")
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 4 then
		say("参见护法长老。", 207, 0, "丐帮弟子")
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 < 4 then
		say("丐帮是中原第一大帮，你算是入对地方了。", 207, 0, "丐帮弟子")
	else
		say("丐帮聚会，" .. JY.Person[0].称呼 .. "请先离去吧。", math.random(1033, 1037), 0)
	end
end
OEVENTLUA[9513] = function ()
	Cls()
	say("今日阳光明媚，*一群乞丐开会，*不是英雄好汉，*请退！", math.random(1033, 1037), 0, "丐帮弟子")

	if JY.Person[458].好感度 >= 60 then
		say("各位英雄，我认识丐帮一个朋友，还请通融一下。", 0, 1)
		say("既是丐帮的朋友，进去吧！", math.random(1033, 1037), 0, "丐帮弟子")
		instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	else
		Cls()

		if instruct_5() == false then
			do return end

			Cls()
		end

		say("我就来试试丐帮打狗大阵！", 0, 1)
		Cls()

		if WarMain(82, 0) == false then
			say("*不是英雄好汉，*请退！", math.random(1033, 1037), 0, "丐帮弟子")
			Cls()

			return
		end

		Cls()
		instruct_13()
		say("阁下武功了得，我们乔帮主*一定会很欣赏你的。", math.random(1033, 1037), 0, "丐帮弟子")
		Cls()
		instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		instruct_3(-2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		Cls()

		return
	end
end
OEVENTLUA[9514] = function ()
	Cls()
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	say("这里居然有个宝箱，不*知道是那个乞丐藏的，正好便宜喽。", 0, 1)
	Cls()
	addthing(22, 2)
	addevent(51, 48, 1, 9515, 1, -2)
end
OEVENTLUA[9515] = function ()
	Cls()

	if JY.Person[0].门派 == 3 and instruct_28(0, 50, 60) and JY.Person[0].盗贼技巧 >= 20 and PersonKF(0, 195) == false then
		say("咦？这箱子居然还有个夹层，这是？", 0, 1)
		say("飞龙探云手？哈哈，好，好，好。", 0, 1)

		local var_222_0 = JY.Person[0].主功体

		stop_ng(0)
		instruct_35(0, 0, 195, 50)
		star_ng(0, var_222_0)
		null(51, 48)
		QZXS(JY.Person[0].姓名 .. "学会飞龙探云手初级！")
	end
end
OEVENTLUA[9516] = function ()
	Cls()

	local var_223_0 = math.random(3)

	if JY.Person[0].门派 == 3 then
		if var_223_0 == 1 then
			say("听说沿海一带海寇时常杀入渔村，罗长老去了调查，一直没有回来，实在让人担心啊。", 207, 0, "丐帮弟子")
		else
			say("丐帮罗长老可是驱虫的第一好手，江湖上人人都要退避几分。", 207, 0, "丐帮弟子")
		end
	else
		say("今日风和日丽，正是晒太阳的好天气啊。", 207, 0, "丐帮弟子")
	end
end
OEVENTLUA[9517] = function ()
	Cls()

	local var_224_0 = math.random(3)

	if JY.Person[0].门派 == 3 then
		if JY.Person[0].驱虫术 >= 20 and has_something(174, 200) then
			say("听说罗长老将驱虫术传给了你？不知道是不是真的。", 207, 0, "丐帮弟子")
			say("不错，罗长老战死沙场，是个英雄。", 0, 1)
			say("那就好，这么一来你也可算是罗长老的弟子了。", 207, 0, "丐帮弟子")
			say("我整理罗长老遗物发现了这个，你看看可有用不？", 207, 0, "丐帮弟子")
			dark()
			light()
			say("原来是罗长老的驱虫心得，甚好，甚好。", 0, 1)
			DrawStrBoxWaitKey("你的驱虫技能提升了十点", C_GOLD, CC.DefaultFont)

			JY.Person[0].驱虫术 = JY.Person[0].驱虫术 + 10

			say("多谢大哥，这是一点心意，还请收下。", 0, 1)
			addthing(174, -200)
			say("我一个乞丐，要这么多银子做什么。", 207, 0, "丐帮弟子")
			addthing(174, 195)
			say("这就可以了，老谢啊，走，兄弟请你喝酒去。", 207, 0, "丐帮弟子")
			say("走，我这几天正馋呢，走走。", 1033, 1, "丐帮弟子")
			dark()
			null(-2, 16)
			null(-2, 19)
			light()
		else
			say("罗长老居然死在了海边小渔村，真是可惜。", 207, 0, "丐帮弟子")
		end
	else
		say("今日风和日丽，正是晒太阳的好天气啊。", 207, 0, "丐帮弟子")
	end
end
OEVENTLUA[9518] = function ()
	Cls()

	local var_225_0 = math.random(3)

	if JY.Person[0].门派 == 3 then
		if var_225_0 == 1 then
			say("丐帮禁止偷盗，不过屡禁不止，毕竟是小偷小摸，也不是大奸大恶，帮里也不好重罚。", 207, 0, "丐帮弟子")
		else
			say("前几年听说丐帮得到了南盗侠的秘籍，可惜不知道是谁？一点儿消息也没有。", 207, 0, "丐帮弟子")
		end
	else
		say("今日风和日丽，正是晒太阳的好天气啊。", 207, 0, "丐帮弟子")
	end
end
OEVENTLUA[9521] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 3)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(52, 21)
end
OEVENTLUA[9522] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 3)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(52, 22)
end
OEVENTLUA[9523] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)

	if JY.Person[0].拳掌功夫 < 95 then
		AddPersonAttrib(0, "拳掌功夫", 5)
		DrawStrBoxWaitKey("你的拳掌功夫增加了", C_ORANGE, CC.DefaultFont, 2)
		null(52, 12)
	end
end
OEVENTLUA[9524] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)

	if JY.Person[0].御剑能力 < 95 then
		AddPersonAttrib(0, "御剑能力", 5)
		DrawStrBoxWaitKey("你的御剑能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(52, 13)
	end
end
OEVENTLUA[9525] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)

	if JY.Person[0].耍刀技巧 < 95 then
		AddPersonAttrib(0, "耍刀技巧", 5)
		DrawStrBoxWaitKey("你的耍刀技巧增加了", C_ORANGE, CC.DefaultFont, 2)
		null(52, 16)
	end
end
OEVENTLUA[9526] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)

	if JY.Person[0].特殊兵器 < 95 then
		AddPersonAttrib(0, "特殊兵器", 5)
		DrawStrBoxWaitKey("你的特殊兵器能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(52, 18)
	end
end
OEVENTLUA[9527] = function ()
	Cls()

	if JY.Person[0].盗贼技巧 < 60 then
		say("啊~，这岛上是怎么回事？绕来绕去的，我这是走到哪了？", 0, 1)
		instruct_14()
		My_Enter_SubScene(52, 25, 36, 0)
		instruct_13()
	else
		null(-2, 7)
	end
end
OEVENTLUA[9541] = function ()
	Cls()
	say("聚贤庄欢迎各路英雄豪杰，到了这儿你就当在自己家就好。", 111, 0)
end
OEVENTLUA[9542] = function ()
	Cls()
	say("听说阎王敌受邀来了聚贤庄，要是有他帮忙，大哥你的伤就能治好了。", 1130, 0, "小弟")
	say("阎王敌威名在外，医术必然是了得的，我让你取的《边氏功法》你带了吗？听说这阎王敌不受金银，只收武功秘籍。", 1142, 0, "大哥")
	say("带了带了，大哥你放心。", 1130, 0, "小弟")
end
OEVENTLUA[9543] = function ()
	Cls()
	say("约了和萧老三在聚贤庄会面，这都好几天了，怎么还没有到？", 1044, 0)
end
OEVENTLUA[9544] = function ()
	Cls()
	say("小子，你看我干什么？", 1236, 0)
	say("啊，我路过。", 0, 1)
	say("路过就路过，你干嘛斜眼瞟我？", 1236, 0)
	say("...", 0, 1)
	say("你嘀咕啥？我这锤重89斤，你想吃俺一锤？", 1236, 0)
	say("你有病啊，我今天就教训教训你。", 0, 1)
	say("来啊~", 1236, 0)
	say("小子，我今天就如你所愿。", 0, 1)
	say("等等，俺今天不想打了，咱们不如喝酒吧。", 1236, 0)
	say("...", 0, 1)
end
OEVENTLUA[9561] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 then
		say("小师弟你要出去吗？", 209, 0)
		say("是啊，师兄你们守这么久了，也该休息休息了。", 0, 1)
		say("小师弟你说的对啊，我腿都站麻了。我去休息一下。", 209, 0)
		dark()
		instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		light()
		say("......", 0, 1)
		say("走得好快，我就是客气一下...", 0, 1)
	else
		say("请离开，华山派封山，不理俗务。", 209, 0)
	end
end
OEVENTLUA[9562] = function ()
	Cls()

	if Rnd(3) == 1 then
		say("家师外号君子剑，不仅武艺高强，而且颇有君子之风，乃是道家和儒家相结合的新派文化传人。", 209, 0)
	else
		say("别看我们华山派现在人丁稀薄，10年前可是五岳剑派的盟主，所谓瘦死的骆驼比马大，我们的实力仍然覆盖陕西全境。", 209, 0)
	end
end
OEVENTLUA[9563] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 then
		say("真无聊啊。", 79, 0)
		say("咦~，小师弟，来，陪师姐练练。", 79, 0)

		if JY.Person[79].好感度 == 50 then
			meet_self(79)
		end

		if WarMain(361, 1) == false then
			say("小师弟，你还要多加练习啊！", 79, 0)
		else
			say("哼，小师弟你下手真重，一点也不知道让着师姐。", 1124, 0, "武当弟子")
		end
	else
		say("大师兄现在越来越正经了，不像小时候了。", 79, 0)
	end
end
OEVENTLUA[9564] = function ()
	Cls()

	if instruct_16(35) then
		say("冲儿，你身体还没好，进屋去休息吧。", 19, 0)
	elseif instruct_16(36) then
		say("平之，练功也不要太过了，要劳逸结合。", 19, 0)
	elseif JY.Person[0].门派 == 4 then
		if JY.Person[0].门派等级 < 2 then
			say("让我看看你如今修炼得如何了？", 19, 0)
			say("是，师父。", 0, 1)
			dark()
			light()

			if PersonKFJ(0, 122) then
				say("徒儿略有所得。", 0, 1)
				say("好，好，很有进步。", 19, 0)
				say("这都是师父指点有方。", 0, 1)
				say("从今天起，你可以学习我华山派的进阶武学了。", 19, 0)
				say("是，师父。", 0, 1)

				JY.Person[0].门派等级 = 2

				addthing(127)
				addthing(237)

				if PersonKF(0, 34) == false then
					local var_240_0 = JY.Person[0].主功体

					stop_ng(0)

					JY.Person[0].武功1 = 34
					JY.Person[0].武功等级1 = 50

					star_ng(0, var_240_0)
				end
			else
				say("内功乃我华山派之根基，要沉下心来好好修炼，将内功基础打好。", 19, 0)
				say("徒儿惭愧！", 0, 1)

				if JY.Person[0].武学常识 < 50 then
					say("我华山派乃是道家正宗，今日为师就给你讲讲道家练气之道。", 19, 0)
					say("是，师父！", 0, 1)
					dark()
					light()
					addtime(30)

					JY.Person[0].武学常识 = JY.Person[0].武学常识 + 1

					say("谢师父！", 0, 1)
				end
			end
		else
			say("华山派以气为先，你要谨记。", 19, 0)
			say("是，师父。", 0, 1)
		end
	else
		say("晚辈拜见君子剑岳先生。", 0, 1)
		say(JY.Person[0].称呼 .. "不必拘礼。姗儿、平之*他们都在外面，去和他们聊*聊吧。", 19, 0)
	end
end
OEVENTLUA[9565] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 then
		if JY.Person[0].无用4 < 10 then
			say("咱们库存的珍贵药材已经用完了，一直没有新的药材进来！", 195, 0)
			say("希望掌门能够想到办法。", 195, 0)
			say("...", 0, 1)
			say("你要有材料，我可以悄悄让你使用一下。", 195, 0)
			say("多谢师兄。", 0, 1)

			local var_241_0 = 0

			for iter_241_0 = 1, CC.MyThingNum do
				if JY.Base["物品" .. iter_241_0] == 209 then
					var_241_0 = JY.Base["物品数量" .. iter_241_0]

					break
				end
			end

			if var_241_0 <= 10 then
				say("可惜我身上药材已经不够再使用一次的了", 0, 2)
			else
				DrawStrBox(CC.MainSubMenuX + 10, CC.MainSubMenuY, "要给谁洗身炼体？", C_WHITE, CC.DefaultFont)

				local var_241_1 = CC.MainSubMenuY + CC.SingleLineHeight
				local var_241_2 = SelectTeamMenu(CC.MainSubMenuX + 10, var_241_1)

				if var_241_2 == nil or var_241_2 < 1 then
					return
				end

				local var_241_3 = JY.Base["队伍" .. var_241_2]

				if var_241_3 >= 0 then
					dark()
					light()

					local var_241_4 = JY.Person[var_241_3].姓名

					if JY.Person[var_241_3].无用4 > 1 then
						local var_241_5 = math.modf(JY.Base.游戏难度 - 1)

						say("洗过之后果然神清气爽，精神百倍。", var_241_3, 0)
						AddPersonAttrib(var_241_3, "生命最大值", 20)
						instruct_47(var_241_3, 5 + var_241_5)
						instruct_43(var_241_3, 5 + var_241_5)
						instruct_45(var_241_3, 5 + var_241_5)

						JY.Person[var_241_3].无用4 = JY.Person[var_241_3].无用4 - 1

						addthing(209, -10)
					else
						say("洗过之后似乎没有什么变化。", var_241_3, 0)
					end

					addtime(1)

					return 1
				else
					Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

					return 0
				end
			end

			say("师兄们谁都没瞧出这个严重性，长此以往，哎。", 195, 0)
			instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

			return
		end

		say("每月的10号是弟子洗身炼体的日子，嗯，你这月还没有洗过，可以进去了！", 195, 0)
		say("多谢师兄。", 0, 1)
		dark()
		light()

		if JY.Person[0].无用4 > 1 then
			say("洗过之后果然神清气爽，精神百倍。", 0, 2)

			local var_241_6 = math.modf(JY.Base.游戏难度 - 1)

			say("洗过之后果然神清气爽，精神百倍。", 0, 0)
			AddPersonAttrib(0, "生命最大值", 20)
			instruct_47(0, 5 + var_241_6)
			instruct_43(0, 5 + var_241_6)
			instruct_45(0, 5 + var_241_6)

			JY.Person[0].无用4 = JY.Person[0].无用4 - 1
		else
			say("洗过之后似乎没有什么变化。", 0, 2)
		end

		addtime(1)
		say("好了，我又该去收集药材了。", 195, 0)
		instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	else
		say("少侠，这儿是华山弟子炼身之地，不方便参观！", 195, 0)
	end
end
OEVENTLUA[9566] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 9)
end
OEVENTLUA[9567] = function ()
	Cls()
	addthing(1, 2)
	addthing(209, 10)
	instruct_37(-1)
	null(-2, 1)
end
OEVENTLUA[9568] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 and has_thing(239) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(237)
		null(-2, 57)
	end
end
OEVENTLUA[9569] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 and has_thing(241) == false then
		say("这么多武学书籍，我得好好看看。", 0, 1)
		addthing(241)
		null(-2, 13)
	end
end
OEVENTLUA[9570] = function ()
	Cls()
	say("这里还有儒学书籍？", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 68)
end
OEVENTLUA[9571] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].门派等级 ~= 6 and has_thing(142) == false then
		say("这似乎是本刀法秘籍，上面已经有了灰尘，似乎很久没有人翻看了。", 0, 2)
		addthing(142)
		null(-2, 69)
	end
end
OEVENTLUA[9581] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "，你擅闯我衡山，是何用意？莫非是左冷禅派来的奸细。", 20, 0)

	if WarMain(28, 0) == false then
		Cls()
		instruct_15()
		Cls()

		return
	end

	Cls()
	instruct_13()
	say("回去告诉左冷禅，下月十五在嵩山召开的大会，我莫大一定到场。我倒要看看其它三派的掌门怎么说。", 20, 0)
	Cls()
	addthing(129, 1)
	Cls()
	instruct_3(-2, -2, -2, 0, 9582, 0, 0, -2, -2, -2, -2, -2, -2)
end
OEVENTLUA[9582] = function ()
	Cls()
	say("回去告诉左冷禅，下月十五在嵩山召开的大会，我莫大一定到场。我倒要看看其它三派的掌门怎么说。", 20, 0)
end
OEVENTLUA[9583] = function ()
	Cls()
	say("衡山派禁地，外人勿近！", 196, 0)
	Cls()

	if instruct_5() == false then
		Cls()

		return
	end

	if WarMain(27, 0) == false then
		instruct_15()
		Cls()

		do return end

		Cls()
	end

	instruct_3(-2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	instruct_3(-2, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	Cls()
	instruct_13()
	instruct_37(-1)
end
OEVENTLUA[9584] = function ()
	Cls()
	say("我们衡山处处是茂林修竹，*终年翠绿，奇花异草，四时*放香，自然景色十分秀丽，*有\"南岳独秀\"的美称。", 196, 0)
end
OEVENTLUA[9585] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(58, 42)
end
OEVENTLUA[9586] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	addthing(241)
	null(-2, 53)
end
OEVENTLUA[9591] = function ()
	Cls()
	say("爹爹出去办事去了，留我看家。", 1085, 0, "焦宛儿")
end
OEVENTLUA[9601] = function ()
	say("客官你需要什么服务？我们这儿高价回收各种物品，还可以兑换银票。", 1022, 0, "掌柜")

	local var_255_0 = JYMsgBox("龙门回收站", "高价回收各类物品**提供银两/银票兑换服务", {
		"卖出物品",
		"兑换服务"
	}, 2, 1022, 1)

	if var_255_0 == 1 then
		repeat
			say("想卖出什么物品？", 1022, 0, "掌柜")

			local var_255_1 = MenuDSJ()

			if var_255_1 > -1 and DrawStrBoxYesNo(-1, -1, "确定要卖出" .. JY.Thing[var_255_1].名称 .. "吗？", C_WHITE, CC.DefaultFont) then
				if var_255_1 < 36 or var_255_1 == 334 then
					Cls()

					local var_255_2 = 0
					local var_255_3 = math.ceil(JY.Thing[var_255_1].物品价值 / 4)

					for iter_255_0 = 1, CC.MyThingNum do
						if JY.Base["物品" .. iter_255_0] == var_255_1 then
							var_255_2 = JY.Base["物品数量" .. iter_255_0]

							break
						end
					end

					local var_255_4 = InputNum("卖出数量", 1, var_255_2, 1)

					if var_255_4 ~= nil then
						instruct_32(var_255_1, -var_255_4)
						addthing(174, var_255_3 * var_255_4)
					end
				elseif JY.Thing[var_255_1].使用人 == -1 then
					local var_255_5 = math.ceil(JY.Thing[var_255_1].物品价值 / 4)

					if JY.Thing[var_255_1].物品价值 ~= nil then
						instruct_32(var_255_1, -1)
						addthing(174, var_255_5)
					else
						say("这玩意不值钱啊。", 1022, 0, "掌柜")
					end
				else
					DrawStrBoxWaitKey("此物品有人正在使用，无法卖出。", C_WHITE, CC.DefaultFont)
				end
			end

			Cls()
		until not DrawStrBoxYesNo(-1, -1, "还想继续卖出物品吗？", C_WHITE, CC.DefaultFont)
	elseif var_255_0 == 2 then
		local var_255_6 = JYMsgBox("兑换服务", " 1张銀票 = 10000银两，手续费5个点。 ", {
			"兑换銀票",
			"兑换银两"
		}, 2, 1022, 1)

		if var_255_6 == 1 then
			local var_255_7 = math.modf(JY.GOLD / 10500)

			if var_255_7 > 0 then
				local var_255_8 = InputNum("兑换数量", 1, var_255_7, 1)

				if var_255_8 ~= nil then
					addthing(174, -10500 * var_255_8)
					addthing(327, var_255_8)
				end
			else
				say("您身上的银两好像不够呢。", 1022, 0, "掌柜")
			end
		elseif var_255_6 == 2 then
			local var_255_9 = 0

			for iter_255_1 = 1, CC.MyThingNum do
				if JY.Base["物品" .. iter_255_1] == -1 then
					break
				end

				if JY.Base["物品" .. iter_255_1] == 327 then
					var_255_9 = JY.Base["物品数量" .. iter_255_1]

					break
				end
			end

			if var_255_9 > 0 then
				local var_255_10 = InputNum("使用数量", 1, var_255_9, 1)

				if var_255_10 ~= nil then
					addthing(327, -var_255_10)
					addthing(174, 10000 * var_255_10)
				end
			else
				say("没有銀票无法兑换。", 1022, 0, "掌柜")
			end
		end
	end
end
OEVENTLUA[9602] = function ()
	Cls()
	say("这位客官，您要在小店休息*一晚吗？只需10两银子。", 1116, 0, "佟湘玉")
	Cls()

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(10) == false then
		say("客官，我们这是小本生意，*概不赊帐。", 1116, 0, "佟湘玉")

		return
	end

	instruct_32(174, -10)
	instruct_14()
	instruct_12()
	instruct_13()
	say("客官，昨晚休息的还好吗？您可要再来光顾小店*哦。", 1116, 0, "佟湘玉")
	Cls()
end
OEVENTLUA[9603] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说白驼山的少主最近又下山了。", math.random(1130, 1142), 0, "酒客")
		say("哎呀，回去得赶紧将家里的小娘藏起来。", math.random(1130, 1142), 1, "酒客")
		say("你们家的小娘？那是不用了，白衣队是不会找去你们家的，放心吧。", math.random(1130, 1142), 0, "酒客")
		say("听说每次白驼山的少女队都抓捕美貌少女，然后还会往受害人家里放1000两银子，不知道是真的假的？", math.random(1130, 1142), 1, "酒客")
		say("那谁知道？你家要是有这丢人的事会往外说吗？难道说将女儿卖了1000两银子？", math.random(1130, 1142), 0, "酒客")
		say("那倒是。", math.random(1130, 1142), 1, "酒客")
		say("来，接着喝酒。", math.random(1130, 1142), 0, "酒客")
		say("喝。", math.random(1130, 1142), 1, "酒客")
	else
		say("听说去往北边的商队又被截了。", 1137, 1, "酒客")
		say("谁叫他们不雇请咱们飞鹰护送的，活该。", 1138, 1, "酒客")
	end
end
OEVENTLUA[9604] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说敦煌守备献了一只瓷瓶给北京城的万岁爷，万岁爷是龙颜大悦。", math.random(1130, 1142), 0, "酒客")
		say("什么宝瓶啊，难道是什么奇特的宝物。", math.random(1130, 1142), 1, "酒客")
		say("哪是什么宝物？就是一只普通瓶子，不过是瓶子上绘了一个美女的画像，万岁爷是惊为天人啊，最近都茶饭不思。", math.random(1130, 1142), 0, "酒客")
		say("画像就是画像，又不是真人，他这么当真干啥？", math.random(1130, 1142), 1, "酒客")
		say("不是，据说这个画像是照着香香公主画的。", math.random(1130, 1142), 0, "酒客")
		say("原来如此，据说这回疆的香香公主乃是古今罕有的美女，还有个姐姐叫翠羽黄衫，也是顶级的大美女，看来是真的了。", math.random(1130, 1142), 1, "酒客")
		say("那是自然。", math.random(1130, 1142), 0, "酒客")
		say("不知道这事会如何结局？", math.random(1130, 1142), 1, "酒客")
		say("那谁知道啊。", math.random(1130, 1142), 0, "酒客")
	else
		say("敦煌发现汉代的古墓了，好多人都赶去了。", 1139, 1, "酒客")
		say("不知道又要死多少人，发多少人。咱们就做做二手买卖就好了，安全要紧。", 11340, 1, "酒客")
		say("正是正是。", 1139, 1, "酒客")
	end
end
OEVENTLUA[9605] = function ()
	Cls()

	if has_thing(332) == true then
		say("客人你这乌拉草质量不错，我出1300两银子一箱买进怎么样？", 1023, 0, "批发商人")

		if yesno("要卖出乌拉草吗？") then
			say("好。", 0, 1)

			local var_259_0 = InputNum("卖出数量", 1, 25, 1)

			if var_259_0 == nil then
				say("客人，你不卖就算了，本店也瞧不上你这么点货。", 1023, 0, "批发商人")
			elseif has_something(332, var_259_0) == false then
				say("客人，你这数目不对啊，麻烦你再检查一下。", 1023, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, 1300 * var_259_0)
				instruct_32(332, -var_259_0)
				say("合作愉快，下次再来啊。", 1023, 0, "批发商人")
			end
		end
	else
		say("紅景天批发，一箱紅景天1000两银子，客人要不要进一些货。", 1023, 0, "批发商人")

		if yesno("要买进一些紅景天吗？") then
			local var_259_1 = InputNum("卖出数量", 1, 10, 1)

			if var_259_1 == nil then
				say("客人，你再多看看，本店都是精选好货。", 1023, 0, "批发商人")

				return
			elseif instruct_31(1000 * var_259_1) == false then
				say("非常抱歉，*你身上的钱似乎不够。", 1023, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, -1000 * var_259_1)
				instruct_32(333, var_259_1)
				say("上好的紅景天，少侠你收好。", 1023, 0, "批发商人")
			end
		end
	end
end
OEVENTLUA[9606] = function ()
	Cls()
	say(JY.Person[0].称呼 .. "，我这有东海运来的宝药，你要不要看一看？", 1026, 0, "宝药商人")
	say("这是？这是千年灵芝？", 0, 1)
	say(JY.Person[0].称呼 .. "好眼力，我给你算便宜点，7000两银子一株怎么样？这可是可遇不可求的好东西啊。", 1026, 0, "宝药商人")

	if yesno("要买吗？") then
		say("我买了。", 0, 1)

		if instruct_31(7000) == false then
			say(JY.Person[0].称呼 .. "你银子不够啊。", 1026, 0, "宝药商人")

			return
		end

		say("好勒，这是千年灵芝，客人你收好。", 1026, 0, "宝药商人")
		instruct_32(174, -7000)
		instruct_32(14, 1)
	end
end
OEVENTLUA[9611] = function ()
	Cls()

	local var_261_0 = 0
	local var_261_1 = JY.Person[727].好感度 >= 60 and "金狗" or "元狗"

	if JY.Base.百年标记 == 0 then
		if JY.Person[0].宋罪恶值 > 970 and JY.Person[0].门派 == 21 and JY.Person[0].门派等级 == 25 then
			say("听说皇帝被一个什么野狗帮的帮主杀死了。", math.random(1130, 1136), 0, "酒客")
			say("怎么可能？那可是皇帝，什么人能够杀他。", math.random(1137, 1142), 1, "酒客")
			say("听说是在朝会上杀的，那个什么野狗帮主杀了皇帝，又打跑了皇宫禁卫，一路杀出了临安城，真是绝代凶人啊。", math.random(1130, 1136), 0, "酒客")
			say("凶星降世，这是祸乱之兆啊，天下大乱不远已。", math.random(1137, 1142), 1, "酒客")
		elseif JY.Person[0].宋罪恶值 > 500 and JY.Person[0].宋罪恶值 < 970 and JY.Person[56].好感度 > 50 and JY.Person[56].好感度 < 70 then
			say("襄阳被" .. var_261_1 .. "攻陷了，" .. var_261_1 .. "一路南下，只怕很快会打到这里，咱们得往南方逃。", math.random(1130, 1136), 1, "酒客")
			say("怎么回事？襄阳不是有十万大军吗？还有支援襄阳的50万大军应该也在襄阳附近吧。", math.random(1137, 1142), 0, "酒客")
			say("谁知道呢？少不得上面有人和" .. var_261_1 .. "串通，利益合作呗，只是苦了老百姓了，哎~", math.random(1130, 1136), 1, "酒客")
		else
			say("听说五毒教魔教联手了，最近横扫云南、广西，遇到的帮派不是被灭，就是被抓取做练毒材料了。", math.random(1130, 1136), 0, "酒客")
			say("哎呀，那咱们还是绕着走吧，五毒教的人可是不讲人情的。", math.random(1137, 1142), 1, "酒客")
			say("是的绕远点走，万一碰到总是麻烦。", math.random(1130, 1136), 0, "酒客")
			say("据说苗疆还有个僵尸门，都修炼僵尸拳，动作出其不意，还全身是毒，极为难缠。", math.random(1137, 1142), 1, "酒客")
			say("这个与咱们无关吧？", math.random(1130, 1136), 0, "酒客")
			say("门里最出名的人物外号瀟湘子，最近已经出山了，这样的人物咱们照样惹不起，都得躲着走。", math.random(1137, 1142), 1, "酒客")
			say("哎，就怕这些使毒的，让人防不胜防，武功练得再高遇到了也得趴窝。", math.random(1130, 1136), 0, "酒客")
		end
	else
		say("听说版纳发现了一条青龙，落在罗拉寨里起不来了，当地寨民都在给它浇水，希望它能重新飞起来。", 1132, 0, "酒客")
		say("都是谣传，哪儿有什么龙，你信啊。", 1133, 0, "酒客")
		say("不信啊。", 1132, 0, "酒客")
		say("明天咱们就钻林子了，这些神神叨叨的少说。", 1133, 0, "酒客")
	end
end
OEVENTLUA[9612] = function ()
	Cls()

	local var_262_0 = math.random(2)

	if JY.Base.百年标记 == 0 then
		if var_262_0 == 1 then
			say("据说神龙架一代还有野人，还有人遇到了僵尸，不知道真的假的？", 1036, 0, "酒客")
			say("野人咱是不知道，可是僵尸是有的，前年昆明分会的刘大胆就是被僵尸咬了一口，毒发而亡的。", 1037, 1, "酒客")
			say("这深山老林的，什么都有，咱们要进去了可得小心。", 1036, 0, "酒客")
		else
			say("听说五毒教有一个毒龙窟，里面有着无数的凶猛毒物。", 1036, 0, "酒客")
		end
	else
		say("听说版纳丛林里面有着无数的凶猛毒物。", 1037, 0, "酒客")
		say("不错，你要请喝酒我就带你进去看看？", 1038, 0, "酒客")
		say("算了算了，君子不立危墙之下，来，喝酒。", 1037, 0, "酒客")
	end
end
OEVENTLUA[9631] = function ()
	Cls()

	local var_263_0 = "功德箱"
	local var_263_1 = "旁边有个功德箱，想要做些什么呢*捐赠：1000两增加1点道德*慈悲：有多少捐多少*偷窃：减少5点道德得100两*抢劫：全拿了不多说"
	local var_263_2 = {
		"捐赠",
		"慈悲",
		"偷窃",
		"抢劫",
		"路过"
	}
	local var_263_3 = #var_263_2
	local var_263_4 = JYMsgBox(var_263_0, var_263_1, var_263_2, var_263_3)

	if var_263_4 == 1 then
		say("银子太多了也没啥用，拿出1000两做慈善事业吧。", 0, 0)
		instruct_0()

		if instruct_31(1000) then
			addthing(174, -1000)

			if JY.Person[0].品德 < 50 then
				instruct_37(1)
			end
		else
			say("额，原来我身上连1000两都没有。", 0, 1)
			instruct_0()
		end
	elseif var_263_4 == 2 then
		say("银子用在该花的地方也是一件乐事", 0, 0)

		if instruct_31(1000) == false then
			say("可惜我身上连1000两都没有。", 0, 1)

			return
		end

		local var_263_5 = 0

		for iter_263_0 = JY.Person[0].品德 + 1, 50 do
			if JY.GOLD - var_263_5 >= 1000 then
				var_263_5 = var_263_5 + 1000
				JY.Person[0].品德 = iter_263_0
			end
		end

		addthing(174, -var_263_5)
	elseif var_263_4 == 3 then
		say("这谁的银子！没人应我拿了啊。", 0, 1)

		if JY.Person[0].品德 >= 5 then
			addthing(174, 100)
			instruct_37(-5)
		else
			say("可惜箱子里是空的。", 0, 2)
		end
	elseif var_263_4 == 4 then
		say("这谁的银子！没人应我拿了啊。", 0, 1)

		if JY.Person[0].品德 >= 30 then
			local var_263_6 = JY.Person[0].品德 - 30

			addthing(174, var_263_6 * 90)

			JY.Person[0].品德 = 30
		else
			say("可惜箱子里是空的。", 0, 2)
		end
	end
end
OEVENTLUA[9667] = function ()
	Cls()
	say("小娟，今日我出去垂钓，中午带几位鲫鱼回来咱们喝鱼汤。", 253, 1, "谭公")
end
OEVENTLUA[9668] = function ()
	Cls()
	say("家里没有盐了，你出去带点回来。", 1237, 1, "谭婆")
end
OEVENTLUA[9669] = function ()
	Cls()
	say("小娟……", 1149, 0, "赵钱孙")
end
OEVENTLUA[9681] = function ()
	Cls()
	say("此处原本也是个不毛之地。**但自从开山祖师爷何掌门以*来，历代掌门人于七八十年*中花了极大力气整顿山坳。*派遣弟子东至江南，西至天*竺搬移各种奇花异树到此种*植，才有了目前此番美景。", 192, 0)
end
OEVENTLUA[9682] = function ()
	Cls()
	say("在下云游各方，途经昆仑，*见此三圣坳绿草如茵，*忍不住前来欣赏一番，*并顺道拜会人称*”铁琴先生”的何掌门。", 0, 1)
	say("你是打从中原来的吧！*欣赏完了就赶紧离去吧。**最近西域已成多事之地，*小心惹上祸端。", 7, 0)
end
OEVENTLUA[9683] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	AddPersonAttrib(0, "武学常识", 1)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(68, 6)
end
OEVENTLUA[9684] = function ()
	Cls()
	say("这么多书，我得好好看看。嗯？这是什么？昆仑两仪阵？", 0, 1)
	dark()
	light()
	addtime(5)
	say("果然是名门大派，底蕴丰厚，这次是大有收获。", 0, 1)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(68, 7)
end
OEVENTLUA[9691] = function ()
	Cls()

	local var_271_0 = 0
	local var_271_1 = JY.Person[727].好感度 >= 60 and "金狗" or "元狗"

	if JY.Base.百年标记 == 0 then
		if JY.Person[706].好感度 >= 60 or JY.Person[727].好感度 >= 60 then
			if JY.Person[706].好感度 >= 100 or JY.Person[727].好感度 >= 100 then
				say("听说武圣星君下凡了，要杀尽" .. var_271_1 .. "，恢复我华夏盛世。", math.random(1137, 1142), 0, "酒客")
				say("我也听说了，据说杀了很多" .. var_271_1 .. "大将，" .. var_271_1 .. "已经快支持不住了。", math.random(1130, 1136), 0, "酒客")
			else
				say("可恶的" .. var_271_1 .. "，最近扬州被他们杀了好多人，每天都看到他们在四处劫掠财物。", math.random(1137, 1142), 0, "酒客")
				say("小声点，你不要命了？", math.random(1130, 1136), 0, "酒客")
			end

			return
		elseif JY.Person[0].宋罪恶值 > 970 and JY.Person[0].门派 == 21 and JY.Person[0].门派等级 == 25 then
			say("听说皇帝被一个什么野狗帮的帮主杀死了。", math.random(1130, 1136), 0, "酒客")
			say("怎么可能？那可是皇帝，什么人能够杀他。", math.random(1137, 1142), 0, "酒客")
			say("听说是在朝会上杀的，那个什么野狗帮主杀了皇帝，又打跑了皇宫禁卫，一路杀出了临安城，真是绝代凶人啊。", math.random(1130, 1136), 0, "酒客")
			say("凶星降世，这是祸乱之兆啊，天下大乱不远已。", math.random(1137, 1142), 0, "酒客")

			return
		else
			say("晋阳大侠萧半和要过60大寿了，咱们得去恭贺一下！", 1025, 0, "酒客1")
			say("不知多少豪杰英雄要去给萧大侠贺寿，咱们得去看看，只是没有就手的礼物啊！", 1026, 0, "酒客2")
			say("哎，不然，这么多人来给萧大侠贺寿，带的礼物是不会少的，咱们去借两件也就可以了！", 1025, 0, "酒客1")
			say("大哥，好主意。", 1027, 0, "酒客3")
			say("哎，大哥你头脑就是灵活，我得多跟你学习学习！", 1026, 0, "酒客2")
			say("来，喝酒！", 1025, 0, "酒客1")
			say("喝！", 1026, 0, "酒客2")
		end
	else
		say("哎，如今城里男人越来越少了，都被元人征去打仗，一去不回啊。", 1026, 0, "酒客2")
		say("别说了，不久就轮到我了！", 1025, 0, "酒客1")
		say("一醉解千愁，来，喝！", 1026, 0, "酒客2")
		say("喝！", 1025, 0, "酒客1")
	end
end
OEVENTLUA[9692] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说萧大侠有个又漂亮又聪慧的女儿，也不知道是不是真的？", 1019, 0, "酒客1")
		say("真不真的和你也没关系，你已经有老婆了！呵呵。", 1010, 0, "酒客2")
		say("和你也没关系，不过我们可以去看看，你说怎么样？", 1019, 0, "酒客1")
		say("同去同去，所谓君子好逑，所以说咱两都是君子！", 1010, 0, "酒客2")
		say("来，喝酒！", 1019, 0, "酒客1")
		say("喝！", 1010, 0, "酒客2")
	else
		say("我决定了，下月我就随舅舅出海，舅舅说南边很多土族，人傻钱多。", 1019, 0, "酒客2")
		say("听说土族很野蛮的。", 1010, 0, "酒客1")
		say("怕什么，难道现在就好了，反正都没有活路。", 1019, 0, "酒客2")
		say("说的也是，来，喝酒！", 1010, 0, "酒客1")
	end
end
OEVENTLUA[9693] = function ()
	Cls()

	local var_273_0 = Rnd(4)

	if JY.Base.百年标记 == 0 then
		if var_273_0 == 1 then
			say("听说赏善罚恶二使者又出现了。", 323, 0, "酒客1")
			say("哦，又10年了吗？", 1129, 0, "酒客2")
			say("不知道这次又是哪一门的掌门人要被请去喝腊八粥。", 1129, 0, "酒客2")
			say("哪一门的掌门人要被请去喝腊八粥不知道，只这一路不知道多少的恶徒恶霸要被赏善罚恶二使清杀干净。", 323, 0, "酒客1")
			say("正是正是。", 1129, 0, "酒客2")
			say("连云十八寨那帮匪徒连官府都避而远之，也不知道这次会不会倒霉。", 323, 0, "酒客1")
			say("这可难说，多半赏善罚恶二使不会进入山林去寻的，他们可不会浪费如此多的时间。", 1129, 0, "酒客2")
			say("说的是，兄弟，干。", 323, 0, "酒客1")
			say("干。", 1129, 0, "酒客2")
		elseif var_273_0 == 2 then
			say("听说了吗？有人最近在洛阳附近找到玄铁令的消息了。", 1129, 0, "酒客2")
			say("玄铁令？据说任何人拿到这块令牌，都可以向摩天居士提一个要求？", 323, 0, "酒客1")
			say("正是，要是我得到的话，就让摩天居士收我为徒，我也要成为顶尖高手。", 1129, 0, "酒客2")
			say("来，喝酒，喝完咱们也去看一看，说不定也有机会得到玄铁令。", 323, 0, "酒客1")
			say("正是，干。", 1129, 0, "酒客2")
		elseif var_273_0 == 3 then
			say("赏善罚恶使者来到中原，这次长乐帮和雪山派恐怕都逃不过去。", 323, 0, "酒客1")
		elseif var_273_0 == 4 then
			say("听说侠客岛有一种酒，能调和阴阳，真想拿来尝尝。", 1129, 0, "酒客2")
		end
	else
		say("真希望会武功啊，就不受欺负了。", 323, 0, "酒客2")
		say("哪有什么武功，不过是传说，真有武功高手咱们汉人能到如今这样？", 1129, 0, "酒客1")
		say("说的也是，都是野史，可惜，可惜！", 323, 0, "酒客2")
		say("别想多了，来，喝酒！", 1129, 0, "酒客1")
	end
end
OEVENTLUA[9694] = function ()
	Cls()

	local var_274_0 = {
		516,
		517,
		518,
		519,
		520,
		521,
		522
	}
	local var_274_1 = var_274_0[math.random(#var_274_0)]
	local var_274_2 = Rnd(4)

	if var_274_2 == 1 then
		if JY.Person[0].性别 == 0 then
			say("唉，好无聊哦～～，这位大爷，来和我玩玩吧～～", 1116, 0)
		else
			say("唉，好无聊哦～～，这位姑娘，来和我玩玩吧～～", 1116, 0)
		end
	elseif var_274_2 == 2 then
		say(JY.Person[0].称呼 .. "，我给你跳一支舞吧？", 1116, 0)
	elseif var_274_2 == 3 then
		say(JY.Person[0].称呼 .. "，你看我穿这件衣服好看吗？", 1116, 0)
	elseif var_274_2 == 4 then
		say(JY.Person[0].称呼 .. "，给你一样东西你要不要？", 1116, 0)
		say("什么？", 0, 1)
		say("我你要不要？", 1116, 0)
	end
end
OEVENTLUA[9695] = function ()
	Cls()
	say("欢迎光临。", 1116, 0)
end
OEVENTLUA[9696] = function ()
	Cls()

	if JY.Person[0].儒学修为 >= 20 and JY.Person[0].性别 == 0 then
		say("年轻人，你基础不错，想多学习一些知识吗？", 1125, 0)

		if yesno("要学习四书五经吗？") then
			say("很好，一个月20两银子。", 1125, 0)

			if instruct_31(10) == false then
				say("等你银子筹够了再来吧。", 1125, 0)

				return
			end

			instruct_32(174, -20)
			say("你到那边位置坐下，咱们这就开始。", 1125, 0)
			dark()
			light()
			My_Enter_SubScene(69, 52, 32, 1)
			say("人之初，性本善。性相近，习相远。来，跟着我念。", 1125, 0)
			say("人之初，性本善。性相近，习相远。", 0, 1)
			addtime(30)

			if JY.Person[0].儒学修为 < 40 then
				AddPersonAttrib(0, "儒学修为", 10)
			end
		else
			say("可惜，可惜。", 1125, 0)
		end
	else
		say("人之初，性本善。性相近，习相远。来，跟着我念。", 1125, 0)
		say("人之初，性本善。性相近，习相远。", 369, 0)
	end
end
OEVENTLUA[9697] = function ()
	Cls()
	say("书中有黄金，书中有美人。", 369, 0)
end
OEVENTLUA[9698] = function ()
	Cls()

	if Rnd(2) == 1 then
		say("我爹可是大土豪，我爹说了，等我学完了就给我买个秀才功名。", 368, 0)
	else
		say("那边那个穷小子，还在书里面找黄金美人呢，哪有啊，刚入学我就找过了，根本没有，就是大人想让我们多看书撒的谎。", 368, 0)
	end
end
OEVENTLUA[9699] = function ()
	Cls()
	say("商家堡内，禁止江湖人物进入。", 371, 0)
end
OEVENTLUA[9700] = function ()
	Cls()
	say("中州残破耻难平，何辞请缨拒贼兵。", 361, 0)
	say("家国一时多少恨，江流不尽月无声！", 361, 0)
end
OEVENTLUA[9701] = function ()
	Cls()
	say("这么多书！看一看。", 0, 1)
	dark()
	light()
	addtime(1)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(69, 45)
end
OEVENTLUA[9702] = function ()
	Cls()
	null(69, 46)
	addthing(174, 500)
	addthing(209, 10)

	if instruct_16(91) == false then
		say("好胆，居然敢进入温家堡内偷东西。", 371, 0)

		if WarMain(317, 0, 1, 1) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		instruct_37(-1)
	end
end
OEVENTLUA[9703] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("（告牌上贴着一张告示，已经有些残破了）官府公示：天下高手以比武排名，上得擂台，生死勿论，伤残勿论。门派封地及门派收益以擂台战排名，由朝廷分封。擂台战排名靠前者，可加入朝廷任用。", 0, 2)
	else
		say("（告牌上贴着几张告示）朝廷公告：严格等级制度，违者杀立决。第一等级蒙古人，第二等级色目人，第三等级少数游牧民族，第四等级南人。", 0, 2)
	end
end
OEVENTLUA[9704] = function ()
	Cls()

	local var_284_0 = math.random(5)

	if var_284_0 == 1 then
		say("（告牌上贴着几张告示，将下面的官府告示盖住了）：张姓老太，于近日走失，帮助寻到者必有厚报。", 0, 2)
	elseif var_284_0 == 2 then
		say("（告牌上贴着几张告示，将下面的官府告示盖住了）：李家女儿于近日被歹徒绑架，帮助寻到者必有厚报。", 0, 2)
	elseif var_284_0 == 3 then
		say("（告牌上贴着几张告示，将下面的官府告示盖住了）：张员外家近日遇盗，有帮助抓获贼人者必有重赏。", 0, 2)
	end
end
OEVENTLUA[9705] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("（告牌上贴着一张告示，已经有些残破了）官府公示：天下高手以比武排名，天下第一：灭绝师太； 天下第二：江南四奇；天下第三：威德先生；天下第四：衡山莫大；天下第五：归辛树", 0, 2)
	else
		say("（告牌上贴着几张告示）朝廷公告：严格等级制度，违者杀立决。第一等级蒙古人，第二等级色目人，第三等级少数游牧民族，第四等级南人。", 0, 2)
	end
end
OEVENTLUA[9706] = function ()
	Cls()
	say("西域特产，看看吧。", 1055, 0, "卖货老伯")
end
OEVENTLUA[9707] = function ()
	Cls()
	say("阿福，咱们一块儿做菜吧。", 369, 0)
	addevent(69, 88, 1, 9707, 1, 6888, -2, -2)
	say("小朋友，你这是什么啊？", 0, 1)
	say("这是阿福，是我的好朋友。", 369, 0)
	say("（这个布娃娃看着有些奇怪啊，我怎么有些熟悉的感觉？）", 0, 1)
	say("小朋友，这个布娃娃能给我看看吗？", 0, 1)
	say("不给，这是我的。", 369, 0)
	say("我给你买糖吃好不好？", 0, 1)
	say("不好，妈妈说不能要陌生人的东西。", 369, 0)
	say("这样，我拿东西跟你换好不好？我有好多的好东西哦。", 0, 1)

	if has_thing(338) then
		say("你说的是真的？", 369, 0)
		say("真的真的。", 0, 1)
		say("那，我要这个长命锁。", 369, 0)
		say("这个...", 0, 1)

		if yesno("要交换么？") == true then
			say("好，给你。", 0, 1)
			dark()
			null(-2, 88)
			light()
			addthing(339, 1)
			addthing(338, -1)
			say("上次爸爸舍不得给我买，现在我也有长命锁了。我要给小胖看看去。", 369, 0)
			null(-2, 87)
		else
			say("还是算了。", 0, 1)
		end
	else
		say("不换，阿福是我的好朋友呢。", 369, 0)
		say("...", 0, 1)
	end
end
OEVENTLUA[9708] = function ()
	Cls()
	say("丝滑柔顺的丝衣，年轻人，买一个送给女朋友啊？", 1071, 0, "李嫂")
	say("好漂亮的丝绸衣服，多少钱一件？", 0, 1)
	say("扬州特制的高档丝衣，6000两一件。", 1071, 0, "李嫂")

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(6000) == false then
		say("客官，我这是小本生意，不赊帐的。", 1071, 0, "李嫂")

		return
	end

	say("好咧，丝衣一件，你拿好。", 1071, 0, "李嫂")
	Cls()
	instruct_32(174, -6000)
	addthing(336)
	Cls()
end
OEVENTLUA[9709] = function ()
	Cls()

	if Rnd(3) == 1 then
		dark()
		null(-2, 133)
		light()
		say("阿秀，你又在对着墙壁发呆啦，来客人了，快过来。", 1116, 0)
		say("哦，来了。", 522, 0)
		dark()
		null(-2, 93)
		light()
		addevent(69, 134, 0, 9711, 3, -2, -2, -2)
		addevent(69, 135, 1, 9710, 1, -2, -2, -2)
	end
end
OEVENTLUA[9710] = function ()
	Cls()
	say("咦？这砖似乎有点松啊。", 0, 1)
	addthing(174, 992)
	null(-2, 135)
end
OEVENTLUA[9711] = function ()
	Cls()
	dark()
	null(-2, 134)
	addevent(69, 93, 1, -2, 1, 10216, -2, -2)
	addevent(69, 136, 1, -2, 1, 6084, -2, -2)
	addevent(69, 137, 1, -2, 1, 8740, -2, -2)
	light()
	say("阿秀~，阿秀~，快来人啊，阿秀自杀了~。", 1116, 0)
	say("啊？哎，这等灯红酒绿之地，果然不是善地。", 0, 1)
	addevent(69, 133, 0, 9712, 3, -2, -2, -2)
end
OEVENTLUA[9712] = function ()
	Cls()
	dark()
	null(-2, 133)
	light()
	say("阿秀积攒的赎身银眼看就快够了，结果被人给偷了~", 1116, 0)
	say("可怜的阿秀~，呜呜。", 1116, 0)
	say("这个杀千刀的小偷~，那么多富人的不偷，到咱们这儿来偷东西。", 1114, 0)
	say("我咒他骑马摔断腿，走路被雷劈~", 1114, 0)
	say("快送阿秀去找医生，可怜的阿秀~，你可别死啊，你的爹娘，小妹还盼着你回家呢，呜呜~", 1116, 0)

	if instruct_55(135, 9710) == false then
		instruct_37(-1)
	end

	dark()
	null(-2, 93)
	null(-2, 135)
	null(-2, 136)
	null(-2, 137)
	light()
end
OEVENTLUA[9713] = function ()
	Cls()
	dark()
	null(-2, 59)
	light()
	say("辛兄，你既已将房屋抵押于我，又还不起钱来，我只好亲自上门讨要了。", 1099, 0)
	say("文兄，我何时欠你钱了，你莫不是昨日酒醉还未醒？", 361, 1)
	say("哎，辛兄，你这话可就不对了，昨日咱们一块儿出去喝花酒，你请了怡红楼的头牌姑娘，还是找我借的钱，你怎可反口不认呢。", 1099, 0)
	say("断不可能，昨日我和你去的西街夜市，也只是点了两个菜喝了点酒然后我就醉倒了，什么时候去过青楼？我是决计不会去那个地方的。", 361, 1)
	say("辛兄，你这么说可就不讲理了，以咱两的交情，难道还要我报官处理，辛兄，我可不想将你的名声毁了啊。", 1099, 0)
	say("你~，枉我将你当兄弟，原来你是这种人。", 361, 1)
	say("辛兄，既如此，那我可就报官了，你可不要后悔。", 1099, 0)
	say("是我识人不清，居然和你这种人称兄道弟，哼。", 361, 1)
	dark()
	addevent(69, 116, 1, -2, 1, 10594)
	addevent(69, 117, 1, -2, 1, 10594)
	light()
	say("文秀才，你状告辛秀才欠你银子不还，可有证据？", 1250, 0, "捕快")
	say("有的有的，大人，这是辛秀才写的欠条，上写欠我纹银3000两。", 1099, 1)
	say("下方还有他按的手印，大人请看。", 1099, 1)
	dark()
	light()
	say("果然是有，辛秀才，你赶快将银子还于文秀才，若是银两不够，你这抵押的房屋就充公变卖了。", 1250, 0, "捕快")
	say("魑魅魍魉，文秀才，你居然与温老六勾结要谋我祖产，我乃功名在身，岂敢欺我~", 361, 1)
	say("拿下，先下入牢里，再慢慢处置。", 1250, 0, "捕快")
	say("青天白日，难道就没有王法了吗？", 361, 1)

	if yesno("要出手帮忙吗？") then
		say("住手~", 0, 1)
		instruct_30(54, 11, 54, 8)
		say("什么人？官差办案，速速退避！", 1250, 0, "捕快")
		say("此事颇多蹊跷之处，大人还是查个清楚再说。", 0, 1)
		say("好胆，官差办案，也敢阻挠，一同拿下了！", 1250, 0, "捕快")

		if WarMain(514, 0, 1, 1) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		say("还不快滚~", 0, 1)
		say("你厉害，有本事别跑！", 1250, 0, "捕快")
		null(-2, 116)
		null(-2, 117)
		say("你，你连官差也敢打？", 1099, 0)
		say("嗯？", 0, 1)
		say("哎呀~", 1099, 0)
		null(-2, 138)
		say("多谢少侠出手相助。", 361, 1)
		say("少侠还是速速离开吧，只怕一会儿官差就会召唤人手过来，却是连累少侠了。", 361, 1)
		say("那你？", 0, 1)
		say("我老师乃是当世名儒，我要去找老师帮忙去了。", 361, 1)
		dark()
		null(-2, 44)
		light()

		JY.Person[0].宋罪恶值 = JY.Person[0].宋罪恶值 + 10

		addevent(69, 45, 1, 9714, 1, -2)
	else
		say("还是算了。", 0, 1)
		say("辛秀才，对不住了，拿下。", 1250, 0, "捕快")
		dark()
		null(-2, 44)
		null(-2, 116)
		null(-2, 117)
		light()
		say("嘿嘿，辛兄啊辛兄，上次你不愿意介绍李姑娘给我，那就是看不起我。这次看你还不脱层皮。", 1099, 0)
		null(-2, 138)
	end
end
OEVENTLUA[9714] = function ()
	Cls()
	say("这么多书！看一看。", 0, 1)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 10)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(69, 45)
	addevent(69, 59, 0, 9715, 3, -2)
end
OEVENTLUA[9715] = function ()
	Cls()
	dark()
	null(-2, 59)
	light()
	say("就是这个恶徒，敢打伤官差，拿下了！", 1250, 0, "捕快")

	if WarMain(514, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("真是麻烦。", 0, 1)

	JY.Person[0].宋罪恶值 = JY.Person[0].宋罪恶值 + 10
end
OEVENTLUA[9721] = function ()
	Cls()
	dark()
	null(-2, 9)
	light()
	say("咕~，瓜~...咕~，瓜~，", 0, 2)
	say("什么东西？", 0, 1)
end
OEVENTLUA[9722] = function ()
	Cls()
	dark()
	null(-2, 5)
	null(-2, 6)
	null(-2, 7)
	light()
	say("咕~，瓜~...咕~，瓜~，", 0, 2)
	say("这只蟾蜍长的好古怪~", 0, 1)

	if WarMain(151, 0) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	addthing(231)
	say("这小东西，攻击性这么强。想喷火烧我，哼哼，我一会儿就吃了你。", 0, 1)

	if inteam(83) then
		say("好蟾儿，等回去你将这东西给我研究研究，少不了你的好处。", 83, 0)
	end
end
OEVENTLUA[9751] = function ()
	Cls()

	if JY.Person[0].阵法知识 >= 30 then
		My_Enter_SubScene(75, 32, 39, 0)
	else
		My_Enter_SubScene(75, 53, 36, 0)
	end
end
OEVENTLUA[9752] = function ()
	Cls()

	if JY.Person[0].阵法知识 >= 30 then
		My_Enter_SubScene(75, 32, 39, 0)
	else
		My_Enter_SubScene(75, 6, 51, 0)
	end
end
OEVENTLUA[9753] = function ()
	Cls()

	if JY.Person[0].阵法知识 >= 30 then
		My_Enter_SubScene(75, 32, 39, 0)
	else
		My_Enter_SubScene(75, 20, 52, 1)
	end
end
OEVENTLUA[9754] = function ()
	Cls()

	if JY.Person[0].阵法知识 >= 30 then
		My_Enter_SubScene(75, 32, 39, 0)
	else
		My_Enter_SubScene(75, 49, 52, 0)
	end
end
OEVENTLUA[9755] = function ()
	Cls()

	if JY.Person[0].阵法知识 >= 30 then
		My_Enter_SubScene(75, 32, 39, 0)
	else
		My_Enter_SubScene(75, 20, 52, 1)
	end
end
OEVENTLUA[9756] = function ()
	Cls()
	null(-2, 18)
	addthing(209, 20)
	instruct_37(-1)
end
OEVENTLUA[9757] = function ()
	Cls()
	null(-2, 20)
	say("居然有这么多阵法的书籍，很好很好。", 0, 1)
	dark()
	light()
	addtime(7)

	JY.Person[0].阵法知识 = JY.Person[0].阵法知识 + 5
end
OEVENTLUA[9758] = function ()
	Cls()
	say("这里还有医书？", 0, 1)

	if JY.Person[0].医疗能力 >= 30 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "医疗能力", 5)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 19)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9761] = function ()
	Cls()
	say("台湾有郑王爷在，那些夷人都老老实实的，可比中原安稳多了。", 1235, 0, "老人")
end
OEVENTLUA[9762] = function ()
	Cls()
	addthing(209, 20)
	instruct_37(-1)
	null(-2, 3)
end
OEVENTLUA[9763] = function ()
	Cls()
	addthing(325, 1)
	instruct_37(-1)
	null(-2, 4)
end
OEVENTLUA[9771] = function ()
	Cls()
	instruct_3(-2, -2, -2, 0, 0, 0, 0, 2608, 2608, 2608, -2, -2, -2)
	addthing(61, 1)
	null(-2, 14)
end
OEVENTLUA[9772] = function ()
	Cls()
	dark()
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	light()
	say("啊，好多的鳄鱼。", 0, 1)
	instruct_27(2, 6420, 6448)
	instruct_27(6, 6420, 6448)
	instruct_27(9, 6420, 6448)

	if WarMain(89, 0) == false then
		instruct_15()
		Cls()
		Cls()

		return
	end
end
OEVENTLUA[9773] = function ()
	Cls()
	say("这儿居然有几本书，这是？", 0, 1)

	if JY.Person[0].驱虫术 >= 20 then
		say("居然是驱虫术，甚好甚好。", 0, 1)

		JY.Person[0].驱虫术 = JY.Person[0].驱虫术 + 5

		say("你的驱蛇能力增加了", 0, 2)
		null(-2, 16)
	else
		say("可惜，完全看不懂。", 0, 1)
	end
end
OEVENTLUA[9791] = function ()
	Cls()
	null(-2, 7)
	instruct_17(79, 2, 18, 15, 2608)
	addthing(157, 1)
	say("什么人？敢偷取我族圣物？", 309, 0, "大祭祀")

	if WarMain(291, 0) == false then
		instruct_15()
		Cls()
		Cls()

		return
	end

	if JY.Person[0].暗器技巧 == 199 then
		say("这老头好厉害的暗器功夫。", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(5, 2)

		JY.Person[0].暗器技巧 = 200
	end

	if JY.Person[0].驱虫术 >= 20 then
		if yesno("是否要收服蛇儿为宠物？") then
			say("蛇儿乖，先不要死。", 0, 1)
			dark()
			light()

			if JY.Person[0].驱虫术 >= 80 then
				chongwu_choice(3)
			else
				say("可惜，可惜，我现在的能力还不足以收服此蛇。", 0, 1)
				addthing(325)
			end
		else
			addthing(325)
		end
	else
		addthing(325)
	end
end
OEVENTLUA[9792] = function ()
	Cls()
	addthing(54, 1)
	null(-2, 6)
end
OEVENTLUA[9793] = function ()
	Cls()
	say("什么人？", 1016, 0, "蛮族")

	if WarMain(292, 0) == false then
		instruct_15()
		Cls()
		Cls()

		return
	end

	addthing(10, 5)
	addthing(9, 10)
	null(-2, 0)
	null(-2, 1)
end
OEVENTLUA[9794] = function ()
	Cls()
	say("什么人？", 1016, 0, "蛮族")

	if WarMain(292, 0, 1, 1) == false then
		instruct_15()
		Cls()
		Cls()

		return
	end

	addthing(10, 5)
	addthing(9, 10)
	null(-2, 2)
end
OEVENTLUA[9795] = function ()
	Cls()
	addthing(8, 2)
	null(-2, 5)
end
OEVENTLUA[9801] = function ()
	Cls()
	My_Enter_SubScene(111, 19, 58, 0)
end
OEVENTLUA[9802] = function ()
	Cls()
	say("山壁上有一个很小的洞，需要趴着才能爬进去", 0, 2)

	if yesno("要爬进去看看吗？") then
		My_Enter_SubScene(46, 12, 48, 0)
	else
		say("还是算了。", 0, 1)
		My_Enter_SubScene(80, 35, 15, 3)
	end
end
OEVENTLUA[9803] = function ()
	Cls()
	say("金蛇郎君夏雪宜之墓", 0, 2)

	if inteam(91) then
		say("爹爹...", 91, 0)
		say("青青", 0, 1)
	end
end
OEVENTLUA[9804] = function ()
	Cls()

	if JY.Person[0].御剑能力 == 299 and JY.Person[0].实战 >= 1000 then
		say("灵迹露指爪，杀气见棱角。凡木不敢生，神仙聿来托。", 0, 1)
		say("哈哈哈~哈哈哈~", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(2, 3)

		JY.Person[0].御剑能力 = 300
	else
		say("日月临高掌，神仙仰大风。攒峰势岌岌，翊辇气雄雄。", 0, 1)
		say("好山，好山。", 0, 1)
	end
end
OEVENTLUA[9831] = function ()
	Cls()
	say("书架上有张叠放的地图，里面似乎包着什么东西", 0, 2)
	null(-2, 2)
	addthing(182, 1)
end
OEVENTLUA[9832] = function ()
	Cls()
	say("这是？谁在这里面藏的钱，便宜我了。", 0, 1)
	null(-2, 3)
	addthing(174, 200)
end
OEVENTLUA[9833] = function ()
	Cls()
	say("这是什么药丸？先收起来，呵呵。", 0, 1)
	null(-2, 4)
	addthing(21, 3)
end
OEVENTLUA[9834] = function ()
	Cls()
	say("这是什么？机关秘籍，开锁密要？这是要做小偷吗？真是要不得啊。", 0, 1)
	addtime(5)
	AddPersonAttrib(0, "盗贼技巧", 10)
	DrawStrBoxWaitKey("你对各种机关的了解增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 5)
end
OEVENTLUA[9891] = function ()
	null(-2, 7)
	Cls()
	addthing(149, 1)
	Cls()
end
OEVENTLUA[9892] = function ()
	Cls()
	null(-2, 0)
	addthing(138, 1)
	instruct_0()
end
OEVENTLUA[9893] = function ()
	Cls()

	if JY.Person[0].盗贼技巧 < 30 then
		dark()
		light()
		say("啊~，可恶，这是个陷阱。", 0, 1)
		null(-2, 6)

		for iter_327_0 = 1, CC.TeamNum do
			local var_327_0 = JY.Base["队伍" .. iter_327_0]
			local var_327_1 = JY.Base["队伍" .. iter_327_0]

			if var_327_1 >= 0 then
				AddPersonAttrib(var_327_1, "生命", -200)
			end
		end

		if JY.Person[0].生命 == 0 then
			instruct_15(0)
			instruct_0()

			return
		end
	else
		say("这里面什么也没有。", 0, 1)
	end
end
OEVENTLUA[9894] = function ()
	Cls()

	if JY.Person[0].盗贼技巧 < 50 then
		dark()
		light()
		say("啊~，可恶，这是个陷阱。", 0, 1)
		null(-2, 1)

		for iter_328_0 = 1, CC.TeamNum do
			local var_328_0 = JY.Base["队伍" .. iter_328_0]
			local var_328_1 = JY.Base["队伍" .. iter_328_0]

			if var_328_1 >= 0 then
				AddPersonAttrib(var_328_1, "生命", -300)
			end
		end

		if JY.Person[0].生命 == 0 then
			instruct_15(0)
			instruct_0()

			return
		end
	else
		say("这里面什么也没有。", 0, 1)
	end
end
OEVENTLUA[9895] = function ()
	Cls()
	dark()
	light()
	say("这里居然还有先贤书籍？看看看看。", 0, 1)
	addtime(20)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 8)
end
OEVENTLUA[9896] = function ()
	Cls()
	dark()
	light()
	say("这里居然还有先贤书籍？奇怪。这个地方难道是汉人建造的？我看看。", 0, 1)
	addtime(20)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 9)
end
OEVENTLUA[9921] = function ()
	Cls()
	dark()
	light()
	say("此乃私人领地，非得主人相邀，不可进入。", 384, 0, "白衣少女")
	My_Enter_SubScene(92, 42, 46, 1)
end
OEVENTLUA[9941] = function ()
	say("加入长乐帮，是你今生无悔*的选择！*想长乐，入长乐！", 1133, 0)
	Cls()
end
OEVENTLUA[9942] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(209, 30)
	addthing(174, 200)
	instruct_37(-1)
end
OEVENTLUA[9943] = function ()
	Cls()
	null(94, 13)
	addthing(1, 5)
	addthing(2, 1)
	instruct_37(-1)
end
OEVENTLUA[9944] = function ()
	Cls()
	say("这是医书？", 0, 1)

	if JY.Person[0].医疗能力 >= 10 then
		dark()
		light()
		addtime(5)
		AddPersonAttrib(0, "医疗能力", 3)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 14)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9951] = function ()
	Cls()
	null(-2, 5)
	addthing(174, 200)
	instruct_37(-1)
end
OEVENTLUA[9952] = function ()
	Cls()

	if inteam(91) and JY.Person[91].好感度 == 51 then
		say("我大功坊言而有信，青青姑娘，这儿归你了，告辞。", 1099, 0, "帮众")
		addevent(95, 10, 1, 1712, 1, -2)
		null(-2, 6)
	else
		say("我大功坊广结江湖朋友，在湖广一带素有侠名。", 1099, 0, "帮众")
	end
end
OEVENTLUA[9961] = function ()
	Cls()

	if inteam(83) then
		say("参见教主。", 201, 0)
		say("我和师父进去转转，你去别处忙吧。", 83, 0)
		say("是，教主。", 201, 0)
		instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	else
		say("客人，在花园里走走就好，有些地方是不能进去的。", 201, 0)
	end
end
OEVENTLUA[9962] = function ()
	Cls()

	if inteam(83) then
		say("参见教主。", 201, 0)
		say("我和师父外出游历，你们把地盘给我守好了。", 83, 0)
		say("是，教主。", 201, 0)
	else
		say("汉人，南疆毒虫众多，十分危险，没事就赶快离去吧。", 201, 0)
	end
end
OEVENTLUA[9963] = function ()
	Cls()
	say("这儿居然有几本书，不会是秘籍吧。", 0, 1)

	if JY.Person[0].驱虫术 >= 20 then
		say("居然是驱虫术，甚好甚好。", 0, 1)

		JY.Person[0].驱虫术 = JY.Person[0].驱虫术 + 5

		say("你的驱蛇能力增加了", 0, 2)
		null(96, 26)
	else
		say("这书里记录的似乎是苗疆驱虫的法门，可惜各种术语材料，你完全看不懂。", 0, 1)
	end
end
OEVENTLUA[9964] = function ()
	Cls()
	say("这儿居然有几本书，难道是秘籍？", 0, 1)

	if JY.Person[0].驱虫术 >= 20 then
		say("居然是驱虫术，甚好甚好。", 0, 1)

		JY.Person[0].驱虫术 = JY.Person[0].驱虫术 + 5

		say("你的驱蛇能力增加了", 0, 2)
		null(96, 25)
	else
		say("这书里记录的似乎是苗疆驱虫的法门，可惜各种术语材料，你完全看不懂。", 0, 1)
	end
end
OEVENTLUA[9965] = function ()
	Cls()
	say("这里居然有一坛酒，怎么碧绿碧绿的？", 0, 1)
	addthing(25)
	null(96, 6)
end
OEVENTLUA[9966] = function ()
	Cls()

	if inteam(83) then
		say("哼，百药门不欢迎你，赶快离开。", 1089, 0)
	else
		say("喂，那边井里的水可千万不要喝，里边被五毒教的人下了毒。", 1089, 0)
		say("上次就是有个汉人跑南疆来玩，结果被毒死了。", 1089, 0)
	end
end
OEVENTLUA[9967] = function ()
	Cls()

	if inteam(83) then
		say("百药门不欢迎你，赶快离开。", 1232, 0)
	else
		say("我们百药门和五毒教斗了上百年，他们下毒，我们就解毒，总不能叫他们出世害人。", 1232, 0)
	end
end
OEVENTLUA[9968] = function ()
	Cls()
	say("这是医书？", 0, 1)

	if JY.Person[0].医疗能力 >= 20 then
		dark()
		light()
		addtime(5)
		AddPersonAttrib(0, "医疗能力", 2)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 27)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9969] = function ()
	Cls()
	say("这儿还有几本书。", 0, 1)

	if JY.Person[0].医疗能力 >= 30 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "解毒能力", 5)
		DrawStrBoxWaitKey("你的解毒能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 28)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[9981] = function ()
	Cls()
	say("这个是？何首乌？", 0, 1)
	addthing(17)
	null(98, 1)
end
OEVENTLUA[9982] = function ()
	Cls()
	say("这个是？何首乌？", 0, 1)
	addthing(17)
	null(116, 22)
end
OEVENTLUA[9991] = function ()
	say(JY.Person[0].称呼 .. "，我看你根骨不错，可惜错过了这次招收时间，下次再来吧。", 1009, 0, "无量剑掌门")
	Cls()
end
OEVENTLUA[9992] = function ()
	Cls()

	if Rnd(2) == 1 then
		say("我无量剑派分东西两宗，每五年一次大比，获胜的一宗就可以居住在无量山总坛。", 1013, 0, "无量剑派弟子")
	else
		say("我无量剑派学习的乃是仙人剑法，可惜数十年来都没有人能领悟剑法要诀。", 1013, 0, "无量剑派弟子")
	end
end
OEVENTLUA[9993] = function ()
	say("芝麻开门。", 0, 1)
	say("轰隆隆隆  隆隆隆", 0, 2)
	null(-2, 0)
	instruct_17(99, 1, 45, 52, 0)
	instruct_17(99, 1, 45, 54, 0)
	Cls()
end
OEVENTLUA[9994] = function ()
	Cls()
	dark()
	light()
	say("这是个悬崖，深不见底，你探头往下看", 0, 2)
	say("你自持武功高强，这次却失了手", 0, 2)
	say("啊啊啊~", 0, 1)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8120, 8128)
	else
		instruct_27(-1, 8140, 8146)
	end

	dark()
	My_Enter_SubScene(99, 47, 49, 3)
	light()

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 5974, 5992)
	else
		instruct_27(-1, 10642, 10650)
	end

	say("还好掉到谭水里了，没有淹死。", 0, 1)
end
OEVENTLUA[9995] = function ()
	Cls()
	say("地上有个蒲团，中间有一个新的破洞，似乎有人刚从里面取走了什么东西。", 0, 2)
	addevent(99, 5, 0, 2902, 3, -2, -2, -2)
	null(-2, 0)
end
OEVENTLUA[9996] = function ()
	Cls()
	say("这是一个残局，你看了一会儿，只觉得头晕眼花，黑子已经陷入了死局，无论如何难以挽回败势。", 0, 2)
end
OEVENTLUA[10001] = function ()
	Cls()
	say("谁对？谁又是错呢？我佛慈悲。", 250, 0, "老和尚")
end
OEVENTLUA[10002] = function ()
	Cls()
	say("阿弥陀佛，身是菩提树,心如明镜台。", 1155, 0)
end
OEVENTLUA[10003] = function ()
	Cls()
	say("咦？这块木鱼下怎么还有一本书？", 0, 1)
	addthing(160, 1)
	say("阿弥陀佛，举起屠刀，慈悲在心，施主身有杀戒，还望莫要失去本心。", 1155, 0)
	null(100, 23)
end
OEVENTLUA[10101] = function ()
	dark()
	null(-2, 43)
	light()
	say("李小见，你今日被我们哥俩截住，那是你命不好，谁也救不了你。", 1270, 0, "洞窟双雄")
	say("洞窟三狗，就凭你们两也敢动手？不怕牛王爷回来吗？牛王爷发怒你们老大也得掉层皮，何况你们几个。", 1050, 1, "李小见")
	say("我们悄悄做掉你，谁也不知道，怕什么？谁？", 1270, 0, "洞窟双雄")
	say("（糟糕，碰见杀人现场了，真是倒霉）", 0, 1)
	say("连云寨办事，滚远一点。", 1270, 0, "洞窟双雄")

	if yesno("这一看就是盗匪窝里斗，要管闲事么？") == true then
		say("敢和我这么说话？上一个和我这么说话的人现在都死了你知道吗？", 0, 1)
		say("找死！", 1270, 0, "洞窟双雄")

		if WarMain(336, 0, 1, 1) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		dark()
		null(-2, 34)
		null(-2, 35)
		null(-2, 42)
		addevent(-2, 38, 1, 10102, 1, 10188)
		light()
		say("多谢" .. JY.Person[0].称呼 .. "相助。", 1050, 0, "李小见")
		say("我看你也是连云寨的人吗，怎么他们会对付你的？", 0, 1)
		say("哎，此事说来话长。", 1050, 0, "李小见")
		say("连云寨有十八位寨主，相互之间拉帮结派，有意见的也不少。", 1050, 0, "李小见")
		say("我是牛王爷这边的人，牛王爷乃是岳家军后人，一向劫富济贫，总劝其他寨主不要抢劫平民，最近成立了游侠团接外面的生意，结果和不少寨主都闹了矛盾。", 1050, 0, "李小见")
		say("岳家军后人？游侠团？", 0, 1)
		say("牛王爷家祖是牛皋，乃是岳爷爷手下大将，岳爷爷被抓后全家流落到此。", 1050, 0, "李小见")
		say("牛王爷得了家传兵法残篇，便将岳家军之前的练兵来训练我们，等练好了就派我们出任务，任务少时大家就接接外面的生意，类似保镖护卫一样的活路来挣点零花钱，牛王爷说总比闲着强。", 1050, 0, "李小见")
		say("原来如此，果是虎父无犬子，不知可否带我认识一下这位牛王爷？", 0, 1)
		say("这却是不巧，牛王爷却是不在，要不然他们也不敢拦截我了。", 1050, 0, "李小见")
		say("这样？那我可否雇佣游侠团的人？", 0, 1)
		say("当然可以，你随我来。", 1050, 0, "李小见")
		dark()
		null(-2, 38)
		addevent(-2, 44, 1, 10102, 1, 10190)
		My_Enter_SubScene(101, 40, 37, 0)
		light()
		say("你等我看看都谁可以出任务。", 1050, 0, "李小见")
	else
		say("还是算了，和我有什么关系。", 0, 1)
		say("我还是离远一点的好。", 0, 1)
		dark()
		null(-2, 34)
		null(-2, 35)
		null(-2, 42)
		null(-2, 38)
		ReturnMMap2(379, 274)
		light()
	end
end
OEVENTLUA[10102] = function ()
	Cls()
	say("这个雇佣护卫是从雇佣之日月付薪金。", 1050, 0, "李小见")
	say("另外，在中洲密洞虽然可以对其它寨主的人出手，但最好不要让他们出战，不然会给牛王爷带来很大麻烦。", 1050, 0, "李小见")
	say("你看看你要雇佣哪位？", 1050, 0, "李小见")

	local var_359_0 = {
		{
			"------------可以雇佣的人手-----------",
			nil,
			1
		},
		{
			"游侠罗继忠：江湖人称小罗成，擅使长枪",
			nil,
			1
		},
		{
			"游侠张恒：江湖人称刀剑笑，惯使大刀，辅以袖中剑",
			nil,
			1
		},
		{
			"游侠张晓波：江湖人称平地疾风，擅使长枪",
			nil,
			1
		}
	}

	if JY.Person[653].佛学修为 == 1 then
		var_359_0[2][3] = 0
	end

	if JY.Person[654].佛学修为 == 1 then
		var_359_0[3][3] = 0
	end

	if JY.Person[655].佛学修为 == 1 then
		var_359_0[4][3] = 0
	end

	local var_359_1 = 50
	local var_359_2 = 30
	local var_359_3 = var_359_2 * var_359_1 / 2 + 2 * CC.MenuBorderPixel
	local var_359_4 = var_359_2 + 2 * CC.MenuBorderPixel
	local var_359_5 = -1
	local var_359_6 = -1
	local var_359_7 = ShowMenu(var_359_0, #var_359_0, 0, CC.MainSubMenuX, CC.MainSubMenuY + 100, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_359_7 == 1 then
		-- Nothing
	elseif var_359_7 == 2 then
		say("游侠罗继忠，月薪2000两银子。", 1050, 0, "李小见")

		if yesno("要雇佣吗？") then
			if instruct_31(2000) == false then
				say("客人你银子不够啊。", 1050, 0, "李小见")

				return
			end

			addthing(174, -2000)
			DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_359_2)

			local var_359_8 = {
				{
					"第一护卫",
					nil,
					1
				},
				{
					"第二护卫",
					nil,
					2
				},
				{
					"第三护卫",
					nil,
					3
				}
			}
			local var_359_9 = ShowMenu(var_359_8, 3, 0, var_359_5 + var_359_3 - 4 * var_359_2 - 2 * CC.MenuBorderPixel, var_359_6 + var_359_4 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

			if var_359_9 == 1 then
				if JY.Base.佣兵1 > 0 then
					JY.Person[JY.Base.佣兵1].佛学修为 = 0
				end

				JY.Base.佣兵1 = 653
			elseif var_359_9 == 2 then
				if JY.Base.佣兵2 > 0 then
					JY.Person[JY.Base.佣兵2].佛学修为 = 0
				end

				JY.Base.佣兵2 = 653
			elseif var_359_9 == 3 then
				if JY.Base.佣兵3 > 0 then
					JY.Person[JY.Base.佣兵3].佛学修为 = 0
				end

				JY.Base.佣兵3 = 653
			end

			JY.Person[653].姓名 = "游侠罗继忠"
			JY.Person[653].头像代号 = 52
			JY.Person[653].生命 = 630
			JY.Person[653].生命最大值 = 630
			JY.Person[653].内力 = 2200
			JY.Person[653].内力最大值 = 2200
			JY.Person[653].攻击力 = 280
			JY.Person[653].防御力 = 280
			JY.Person[653].轻功 = 250
			JY.Person[653].特殊兵器 = 60
			JY.Person[653].武功1 = 68
			JY.Person[653].武功等级1 = 999
			JY.Person[653].儒学修为 = JY.DAY
			JY.Person[653].盗贼技巧 = 950
			JY.Person[653].佛学修为 = 1
		else
			say("没关系，你再多看看也好。", 1050, 0, "李小见")
		end
	elseif var_359_7 == 3 then
		say("游侠张恒，月薪2000两银子。", 1050, 0, "李小见")

		if yesno("要雇佣吗？") then
			if instruct_31(2000) == false then
				say("客人你银子不够啊。", 1050, 0, "李小见")

				return
			end

			addthing(174, -2000)
			DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_359_2)

			local var_359_10 = {
				{
					"第一护卫",
					nil,
					1
				},
				{
					"第二护卫",
					nil,
					2
				},
				{
					"第三护卫",
					nil,
					3
				}
			}
			local var_359_11 = ShowMenu(var_359_10, 3, 0, var_359_5 + var_359_3 - 4 * var_359_2 - 2 * CC.MenuBorderPixel, var_359_6 + var_359_4 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

			if var_359_11 == 1 then
				if JY.Base.佣兵1 > 0 then
					JY.Person[JY.Base.佣兵1].佛学修为 = 0
				end

				JY.Base.佣兵1 = 654
			elseif var_359_11 == 2 then
				if JY.Base.佣兵2 > 0 then
					JY.Person[JY.Base.佣兵2].佛学修为 = 0
				end

				JY.Base.佣兵2 = 654
			elseif var_359_11 == 3 then
				if JY.Base.佣兵3 > 0 then
					JY.Person[JY.Base.佣兵3].佛学修为 = 0
				end

				JY.Base.佣兵3 = 654
			end

			JY.Person[654].姓名 = "游侠张恒"
			JY.Person[654].头像代号 = 204
			JY.Person[654].生命 = 550
			JY.Person[654].生命最大值 = 550
			JY.Person[654].内力 = 2300
			JY.Person[654].内力最大值 = 2300
			JY.Person[654].攻击力 = 280
			JY.Person[654].防御力 = 280
			JY.Person[654].轻功 = 250
			JY.Person[654].耍刀技巧 = 50
			JY.Person[654].暗器技巧 = 50
			JY.Person[654].武功1 = 57
			JY.Person[654].武功等级1 = 999
			JY.Person[654].武功1 = 188
			JY.Person[654].武功等级1 = 999
			JY.Person[654].儒学修为 = JY.DAY
			JY.Person[654].盗贼技巧 = 900
			JY.Person[654].佛学修为 = 1
		else
			say("没关系，你再多看看也好。", 1050, 0, "李小见")
		end
	elseif var_359_7 == 4 then
		say("游侠张晓波，月薪2000两银子。", 1050, 0, "李小见")

		if yesno("要雇佣吗？") then
			if instruct_31(2000) == false then
				say("客人你银子不够啊。", 1050, 0, "李小见")

				return
			end

			addthing(174, -2000)
			DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_359_2)

			local var_359_12 = {
				{
					"第一护卫",
					nil,
					1
				},
				{
					"第二护卫",
					nil,
					2
				},
				{
					"第三护卫",
					nil,
					3
				}
			}
			local var_359_13 = ShowMenu(var_359_12, 3, 0, var_359_5 + var_359_3 - 4 * var_359_2 - 2 * CC.MenuBorderPixel, var_359_6 + var_359_4 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

			if var_359_13 == 1 then
				if JY.Base.佣兵1 > 0 then
					JY.Person[JY.Base.佣兵1].佛学修为 = 0
				end

				JY.Base.佣兵1 = 655
			elseif var_359_13 == 2 then
				if JY.Base.佣兵2 > 0 then
					JY.Person[JY.Base.佣兵2].佛学修为 = 0
				end

				JY.Base.佣兵2 = 655
			elseif var_359_13 == 3 then
				if JY.Base.佣兵3 > 0 then
					JY.Person[JY.Base.佣兵3].佛学修为 = 0
				end

				JY.Base.佣兵3 = 655
			end

			JY.Person[655].姓名 = "游侠张晓波"
			JY.Person[655].头像代号 = 52
			JY.Person[655].生命 = 500
			JY.Person[655].生命最大值 = 500
			JY.Person[655].内力 = 2300
			JY.Person[655].内力最大值 = 2300
			JY.Person[655].攻击力 = 280
			JY.Person[655].防御力 = 280
			JY.Person[655].轻功 = 250
			JY.Person[655].特殊兵器 = 50
			JY.Person[655].武功1 = 68
			JY.Person[655].武功等级1 = 999
			JY.Person[655].儒学修为 = JY.DAY
			JY.Person[655].盗贼技巧 = 900
			JY.Person[655].佛学修为 = 1
		else
			say("没关系，你再多看看也好。", 1050, 0, "李小见")
		end
	end

	say("有需要再来找我啊。", 1050, 0, "李小见")
end
OEVENTLUA[10501] = function ()
	Cls()

	if JY.Person[0].儒学修为 >= 30 then
		say("你？你就是来教我们娃认字的吧？", 121, 0, "村夫")
		say("（教他们认字？怎么也得花个两三个月的时间吧？）", 0, 1)

		if yesno("要帮助这些孩子吗？") then
			say("太好了……太好了……", 121, 0, "村夫")
			instruct_14()
			My_Enter_SubScene(105, 37, 24, 2)
			instruct_13()
			say("孩子们，你们的老师终于来了，这可是个难得的机会，大家要认真学，好的老师会带你上天堂哦。", 121, 0, "村夫")
			instruct_14()
			instruct_13()
			addtime(30)
			say("真是太感谢你了，这些娃子上不起武馆，一直都没有人教他们。今天你教了他们，说不定他们长大了都会成为名扬天下的大侠呢。唉，我们这里穷，没多少报酬，这是我积攒了半年才攒够的五两银子，你拿着吧。", 121, 0, "村夫")
			say("Ｌ＜不是吧？半年才攒了五两银子？还不够我一次斗地主的呢……我该收吗？＞", 0, 1)
			Cls()

			JY.Person[121].好感度 = 80

			addevent(105, 4, 1, 10502, 1, -2, -2, -2)
			addevent(105, 7, 1, 10504, 1, -2, -2, -2)

			if instruct_11() == false then
				say("Ｌ＜这么点钱，还不如不要呢，干脆好人做到底吧＞Ｗ大叔，我怎么能收您底钱呢，这钱给孩子们买点书吧。", 0, 1)
				say("好人啊，你真是好人啊，我为唱个曲吧。", 121, 0, "村夫")
				say("好啊。", 0, 1)
				say("青风相待，白云相爱。梦不到紫罗袍共黄金带。一茅斋，野花开，管甚谁家兴废谁成败？陋巷单瓢亦乐哉。贫，气如山！达，志如山！", 121, 0, "村夫")
				instruct_37(2)

				return
			end

			say("Ｌ＜付出了就要有回报，虽然少点，但也比没有强啊＞Ｗ那我就不客气了。", 0, 1)
			addthing(174, 5)
			instruct_37(1)

			return
		else
			say("我很想帮你，可是我实在没有时间。", 0, 1)
			say("唉，穷人的孩子，想上个学*咋就这么难啊！", 121, 0, "村夫")
		end
	else
		say("唉，谁能来教教这些孩子们*啊。", 121, 0, "村夫")
	end
end
OEVENTLUA[10502] = function ()
	Cls()
	say("如今已经种了七万多株树了，终有一天，这儿会变成一个不缺粮食不缺水的家园。", 121, 0, "村夫")
end
OEVENTLUA[10503] = function ()
	Cls()
	say("谢谢老师，这是我捡到的宝物，天上掉下来的呦，送给老师。", 264, 0, "小孩")
	addthing(337)
	addevent(105, 7, 1, 10504, 1, -2, -2, -2)
end
OEVENTLUA[10504] = function ()
	Cls()
	say("老师，我叫种师道，老师你有时间一定来看我们啊。", 265, 0, "小孩")
end
OEVENTLUA[10505] = function ()
	Cls()

	if JY.Person[121].好感度 == 80 then
		say("谢谢老师，老师你有时间一定来看我们啊。", 265, 0, "小孩")
	else
		say("为什么还不下雨啊，昨天我明明做梦到今天要下雨了的。", 265, 0, "小孩")
		say("伯伯说这个月要是接不到足够的雨水咱们就都会渴死了。", 264, 0, "小孩")
	end
end
OEVENTLUA[10701] = function ()
	Cls()

	if math.random(2) == 1 then
		say("听说红花会新任的总舵主才20来岁，也不知道是不是真的？", 1132, 0, "酒客2")
		say("当然是真的，我听西疆的朋友说过，这红花会新任的总舵主不但武艺高强，而且侠肝义胆，乃是真正地大英雄大豪杰！", 1131, 0, "酒客1")
		say("官府现在到处通缉红花会的英雄，咱们得找人通知他们，不要往京城来了！", 1132, 0, "酒客1")
		say("正是，所谓君子不立危墙之下。", 1131, 0, "酒客1")
	else
		say("听说敦煌的守备最近升官了，是因为他给皇上献了一个花瓶。", 1132, 0, "酒客")
		say("哼，又是一个溜须拍马的小人。", 1131, 0, "酒客1")
	end
end
OEVENTLUA[10702] = function ()
	Cls()

	if has_thing(331) == true then
		say("客人你这龍涎香质量不错，我出3200两银子一箱买进怎么样？", 1142, 0, "批发商人")

		if yesno("要卖出龍涎香吗？") then
			say("好。", 0, 1)

			local var_366_0 = InputNum("卖出数量", 1, 25, 1)

			if var_366_0 == nil then
				say("客人，你不卖就算了，本店也瞧不上你这么点货。", 1142, 0, "批发商人")
			elseif has_something(331, var_366_0) == false then
				say("客人，你这数目不对啊，麻烦你再检查一下。", 1142, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, 3200 * var_366_0)
				instruct_32(331, -var_366_0)
				say("合作愉快，下次再来啊。", 1023, 0, "批发商人")
			end
		end
	else
		say("乌拉草批发，一箱乌拉草1200两银子，客人要不要进一些货。", 1142, 0, "批发商人")

		if yesno("要买进一些乌拉草吗？") then
			local var_366_1 = InputNum("卖出数量", 1, 10, 1)

			if var_366_1 == nil then
				say("客人，你再多看看，本店都是精选好货。", 1142, 0, "批发商人")

				return
			elseif instruct_31(1200 * var_366_1) == false then
				say("非常抱歉，*你身上的钱似乎不够。", 1142, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, -1200 * var_366_1)
				instruct_32(332, var_366_1)
				say("上好的乌拉草，少侠你收好。", 1142, 0, "批发商人")
			end
		end
	end
end
OEVENTLUA[10703] = function ()
	Cls()

	if JY.Person[0].清罪恶值 >= 50 then
		DrawStrBoxWaitKey("通缉江洋大盗" .. JY.Person[0].姓名 .. "及其同党！得其首级者奖万两白银，封千户。", C_ORANGE, CC.DefaultFont, 2)
		DrawStrBoxWaitKey("提供消息者奖励白银500两，欢迎大家踊跃检举。", C_ORANGE, CC.DefaultFont, 2)
	else
		DrawStrBoxWaitKey("通缉江洋大盗陈家洛及其同党！得其首级者奖万两白银，封千户。", C_ORANGE, CC.DefaultFont, 2)
		DrawStrBoxWaitKey("提供消息者奖励白银500两，欢迎大家踊跃检举。", C_ORANGE, CC.DefaultFont, 2)
	end
end
OEVENTLUA[10704] = function ()
	Cls()
	say("这位客人，要来点鸦片吗？绝对是京城独家售卖。", 1040, 0)
end
OEVENTLUA[10705] = function ()
	Cls()

	if JY.Person[3].好感度 == 51 then
		say("听说金面佛苗人凤与辽东大侠胡一刀决斗了，胡一刀战败被杀。", 1133, 1, "酒客")
		say("不会吧，那苗人凤乃是响当当一位大侠，不至于一个比武就杀了胡大侠吧？", 1134, 0, "酒客")
		say("谁说不是呢？所以说知人知面不知心啊。", 1133, 1, "酒客")
	else
		say("听说金面佛苗人凤与辽东大侠胡一刀过几天就要进行决斗。", 1026, 0, "酒客")
		say("此话当真？这等高手间的比武，一定要去见识一下才行。不知决斗地点在哪里？", 1027, 1, "酒客")
		say("就在西边的皇城。", 1026, 0, "酒客")
		say("好，等喝完这杯酒我们就上路！", 1027, 1, "酒客")
		say("好，干！", 1026, 0, "酒客")
	end
end
OEVENTLUA[10706] = function ()
	dark()
	light()
	My_Enter_SubScene(107, 32, 30, 3)
end
OEVENTLUA[10801] = function ()
	Cls()
	null(108, 64)
	addthing(209, 50)
end
OEVENTLUA[10802] = function ()
	Cls()
	instruct_3(-2, -2, 1, 0, 0, 0, 0, 2468, 2468, 2468, -2, -2, -2)
	addthing(1, 5)
	addthing(16, 1)
end
OEVENTLUA[10803] = function ()
	Cls()
	say("这是...", 0, 1)
	addthing(215, 1)
	null(108, 66)
end
OEVENTLUA[10804] = function ()
	Cls()
	say("好多的书，我得看看。", 0, 1)
	dark()
	light()
	addtime(30)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 67)
end
OEVENTLUA[10805] = function ()
	Cls()
	say("好多的书，我得看看。", 0, 1)
	dark()
	light()
	addtime(30)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 68)
end
OEVENTLUA[11101] = function ()
	Cls()
	My_Enter_SubScene(80, 15, 2, 3)
end
OEVENTLUA[11102] = function ()
	Cls()

	if JY.Person[0].轻功 >= 200 then
		My_Enter_SubScene(111, 9, 33, 0)
	end
end
OEVENTLUA[11103] = function ()
	Cls()
	My_Enter_SubScene(111, 20, 47, 3)
end
OEVENTLUA[11104] = function ()
	Cls()
	DrawStrBox(-1, -1, "这墙上刻着一些简陋的人形，你仔细看去，似乎是一些高明的武功", C_GOLD, CC.DefaultFont)
	ShowScreen()
	lib.Delay(2000)
	Cls()
	say("这是...？五岳剑派的剑法？似乎还有一些其他专破此剑法的招式。", 0, 1)
	AddPersonAttrib(0, "攻击力", 2)
	QZXS(JY.Person[0].姓名 .. "的攻击力增加了")
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[11105] = function ()
	Cls()
	DrawStrBox(-1, -1, "这墙上刻着一些简陋的人形，你仔细看去，似乎是一些高明的武功", C_GOLD, CC.DefaultFont)
	ShowScreen()
	lib.Delay(2000)
	say("这是...？五岳剑派的剑法？似乎还有一些其他专破此剑法的招式。", 0, 1)

	if (PersonKF(0, 30) or PersonKF(0, 31) or PersonKF(0, 32) or PersonKF(0, 33) or PersonKF(0, 34)) and PersonKF(0, 196) == false then
		for iter_380_0 = 1, 20 do
			if JY.Person[0]["武功" .. iter_380_0] == 30 and JY.Person[0]["武功等级" .. iter_380_0] == 999 then
				say("原来如此，这五岳剑派的剑法我若是能融汇贯通，岂不又是一门顶尖的剑法？", 0, 1)
				instruct_35(0, iter_380_0 - 1, 196, 780)
				QZXS(JY.Person[0].姓名 .. "领悟了五岳神剑！")
				AddPersonAttrib(0, "御剑能力", 2)
				QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
				addtime(1)
				null(111, 6)

				return
			elseif JY.Person[0]["武功" .. iter_380_0] == 31 and JY.Person[0]["武功等级" .. iter_380_0] == 999 then
				say("原来如此，这五岳剑派的剑法我若是能融汇贯通，岂不又是一门顶尖的剑法？", 0, 1)
				instruct_35(0, iter_380_0 - 1, 196, 780)
				QZXS(JY.Person[0].姓名 .. "领悟了五岳神剑！")
				AddPersonAttrib(0, "御剑能力", 2)
				QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
				addtime(1)
				null(111, 6)

				return
			elseif JY.Person[0]["武功" .. iter_380_0] == 32 and JY.Person[0]["武功等级" .. iter_380_0] == 999 then
				say("原来如此，这五岳剑派的剑法我若是能融汇贯通，岂不又是一门顶尖的剑法？", 0, 1)
				instruct_35(0, iter_380_0 - 1, 196, 780)
				QZXS(JY.Person[0].姓名 .. "领悟了五岳神剑！")
				AddPersonAttrib(0, "御剑能力", 2)
				QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
				addtime(1)
				null(111, 6)

				return
			elseif JY.Person[0]["武功" .. iter_380_0] == 33 and JY.Person[0]["武功等级" .. iter_380_0] == 999 then
				say("原来如此，这五岳剑派的剑法我若是能融汇贯通，岂不又是一门顶尖的剑法？", 0, 1)
				instruct_35(0, iter_380_0 - 1, 196, 780)
				QZXS(JY.Person[0].姓名 .. "领悟了五岳神剑！")
				AddPersonAttrib(0, "御剑能力", 2)
				QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
				addtime(1)
				null(111, 6)

				return
			elseif JY.Person[0]["武功" .. iter_380_0] == 34 and JY.Person[0]["武功等级" .. iter_380_0] == 999 then
				say("原来如此，这五岳剑派的剑法我若是能融汇贯通，岂不又是一门顶尖的剑法？", 0, 1)
				instruct_35(0, iter_380_0 - 1, 196, 780)
				QZXS(JY.Person[0].姓名 .. "领悟了五岳神剑！")
				AddPersonAttrib(0, "御剑能力", 2)
				QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
				addtime(1)
				null(111, 6)

				return
			end
		end

		say("可惜我连五岳剑派的一门基础剑法都没有练到极处，无法看得明白。", 0, 1)
	else
		if JY.Person[0].御剑能力 < 198 then
			say("原来如此，原来如此。", 0, 1)
			AddPersonAttrib(0, "御剑能力", 2)
			QZXS(JY.Person[0].姓名 .. "的御剑能力增加了")
		end

		AddPersonAttrib(0, "攻击力", 2)
		QZXS(JY.Person[0].姓名 .. "的攻击力增加了")
		null(111, 6)
	end
end
OEVENTLUA[11106] = function ()
	Cls()

	if JY.Person[0].门派 == 4 and JY.Person[0].盗贼技巧 >= 30 then
		say("嗯？我华山派之上还有一个密洞？", 0, 1)
		null(-2, 0)
	elseif instruct_16(35) and JY.Person[0].门派 ~= 4 then
		say(JY.Person[0].称呼 .. "，这是我华山密地，不能进去，还请见谅。", 35, 0)
		say("哦，无妨，是我失礼了。", 0, 1)
		Cls()

		return
	end
end
OEVENTLUA[11111] = function ()
	Cls()
	dark()
	null(-2, 44)
	light()

	if JY.Person[0].盗贼技巧 < 30 then
		dark()
		light()
		say("啊~，可恶，这是个陷阱。", 0, 1)

		for iter_382_0 = 1, CC.TeamNum do
			local var_382_0 = JY.Base["队伍" .. iter_382_0]
			local var_382_1 = JY.Base["队伍" .. iter_382_0]

			if var_382_1 >= 0 then
				AddPersonAttrib(var_382_1, "生命", -200)
			end
		end

		if JY.Person[0].生命 == 0 then
			instruct_15(0)
			instruct_0()

			return
		end
	else
		say("地面有个机关，你小心的躲了过去。", 0, 2)
	end
end
OEVENTLUA[11112] = function ()
	Cls()
	dark()
	null(-2, 42)
	light()

	if JY.Person[0].盗贼技巧 < 40 then
		say("啊~，可恶，这是个陷阱。", 0, 1)

		for iter_383_0 = 1, CC.TeamNum do
			local var_383_0 = JY.Base["队伍" .. iter_383_0]
			local var_383_1 = JY.Base["队伍" .. iter_383_0]

			if var_383_1 >= 0 then
				AddPersonAttrib(var_383_1, "生命", -200)
			end
		end

		if JY.Person[0].生命 == 0 then
			instruct_15(0)
			instruct_0()

			return
		end
	else
		say("墙上有个机括，你仔细看了看，小心的躲了过去。", 0, 2)
	end
end
OEVENTLUA[11113] = function ()
	Cls()
	say("这个是？", 0, 1)
	say("只见一滩碧水闪着微微的光华，让人忍不住想去喝一口", 0, 2)

	if yesno("你有些拿不准，要喝吗？") then
		if JY.Person[0].抗毒能力 >= 20 or JY.Person[0].解毒能力 >= 30 then
			dark()
			light()
			AddPersonAttrib(0, "抗毒能力", 5)
			DrawStrBoxWaitKey("你的抗毒能力增加了", C_ORANGE, CC.DefaultFont, 2)
			null(-2, 36)
			say("年轻人，这水你也敢喝？不知道腐臭几百年了，佩服佩服。", 1052, 0, "独行大盗")
			addevent(111, 46, 1, -2, 1, 10126, -2, -2)
			say("你是什么人？", 0, 1)
			say("我是姜别鹤，江湖人称绝迹刀，十余年来，打败江湖无敌手。", 1052, 0, "独行大盗")
			instruct_27(50, 5058, 5086)
			say("这是什么？", 1052, 0, "独行大盗")
			say("他伸手向那小虫儿抓去", 0, 2)
			instruct_27(46, 9460, 9464)
			say("那人刚伸出手，就见小虫儿喷出一口蓝色的寒气", 0, 2)
			say("啊？", 1052, 0, "独行大盗")
			null(-2, 46)
			say("那人全身都变得一片湛蓝，转眼身体就发黑腐化，化为一滩黑水", 0, 2)
			say("...", 0, 1)
			say("好好厉害。", 0, 1)
			say("那小虫儿吐了口气，似乎也十分疲惫", 0, 2)
			say("你小心的靠近，那虫儿似乎累了，趴在地上一动也不动", 0, 2)
			say("好机会，拼了。", 0, 1)
			say("好虫儿，好虫儿，我带你去见见外面的世界啊。", 0, 1)
			say("你找出一个瓷瓶，小心的将虫儿装上", 0, 2)
			addthing(194)

			if inteam(83) then
				say("好虫儿，等回去你将这东西给我研究研究，少不了你的好处。", 83, 0)
			end

			addevent(111, 1, 0, 11117, 3, -2, -2, -2)
		else
			say("啊？有毒...", 0, 1)
			instruct_15()
			Cls()

			return
		end
	else
		say("周边都是骸骨，一看就有问题，还是离开吧。", 0, 1)
	end
end
OEVENTLUA[11114] = function ()
	Cls()
	say("年轻人，你也是来探寻上古洞府的？", 250, 0, "冰蚕老人")
	say("不错。", 0, 1)
	say("阿弥陀佛，人为财死，鸟为食亡，少侠不如归去。", 250, 0, "冰蚕老人")
	say("无妨。", 0, 1)
	say("刚进去了好几个高手，到现在一个都没有出来，你要小心。", 250, 0, "冰蚕老人")
	say("你还有什么事吗？", 0, 1)
	say("正是要请少侠帮忙。", 250, 0, "冰蚕老人")
	say("我养了一条小蚕儿，前些日子走丢了，还请少侠帮忙寻找。", 250, 0, "冰蚕老人")
	say("小蚕儿？好说好说。", 0, 1)
	null(-2, 1)
	say("(这僧人好生古怪，这么老的，养只小蚕儿？)", 0, 1)
end
OEVENTLUA[11115] = function ()
	Cls()
	dark()
	null(-2, 45)
	light()
	addthing(174, 526)
	addevent(111, 48, 1, 11115, 1, 10150, -2, -2)
	say("把你得到的宝物交出来。", 1081, 0, "大盗")
	say("什么宝物？", 0, 1)
	say("少给我装傻。杀了你再取也是一样。", 1081, 0, "大盗")

	if WarMain(511, 0, 1, 1) == false then
		instruct_15()
		Cls()

		return
	end

	null(-2, 48)
	say("果然是人为财死，鸟为食亡。可惜我不是鸟，而是虎。", 0, 1)
end
OEVENTLUA[11116] = function ()
	Cls()
	dark()
	null(-2, 49)
	addevent(111, 39, 1, 11116, 1, 10158, -2, -2)
	addevent(111, 40, 1, 11116, 1, 10304, -2, -2)
	addevent(111, 41, 1, 11116, 1, 10144, -2, -2)
	light()
	say("朋友，将东西交出来吧，你虽然武功不错，不过毕竟双拳难敌四手。", 1271, 0, "桥老大")
	say("呵呵，我认得你，太行山的桥老大。就你这种货色，也敢在我面前猖狂，不自量力！", 1048, 1, "杀手")
	say("找死。", 1271, 0, "桥老大")
	dark()
	light()
	say("啊~", 1271, 0, "桥老大")
	null(-2, 40)
	null(-2, 41)
	say("这种角色，简直是浪费我的时间。", 1048, 1, "杀手")
	say("朋友，看半天了，怎么，你也要抢我手里的东西？", 1048, 1, "杀手")

	if yesno("这个人似乎得到了什么宝物，要抢夺吗？") then
		say("现在的年轻人都这么不知天高地厚吗？", 1048, 1, "杀手")

		if WarMain(444, 0, 1, 1) == false then
			instruct_15()
			Cls()

			return
		end

		null(-2, 39)
		addthing(46)
	else
		say("寻宝各凭运气，你运气好得到的自然归你了。", 0, 1)
		say("算你识相。", 1048, 1, "杀手")
		null(-2, 39)
	end
end
OEVENTLUA[11117] = function ()
	Cls()
	dark()
	null(-2, 1)
	light()
	say("年轻人，你寻到我的蚕儿了吗？", 250, 0, "冰蚕老人")

	if has_thing(194) == false then
		say("没有。", 0, 1)
		say("小蚕子，你到底在哪儿啊？", 250, 0, "冰蚕老人")
		say("...", 0, 1)
		say("难道你自己回昆仑山去了？不行，我要去昆仑看看。", 250, 0, "冰蚕老人")

		return
	end

	if yesno("要将蚕儿交给老和尚吗？") then
		say("找到了，给你。", 0, 1)
		addthing(194, -1)
		say("太好了，小蚕子，你到这儿来干什么？害我找你好几年。", 250, 0, "冰蚕老人")
		say("年轻人，你不错，这个给你。", 250, 0, "冰蚕老人")
		addthing(94)
		say("小蚕子，走，咱们回家了。", 250, 0, "冰蚕老人")
	else
		say("没有。", 0, 1)
		instruct_37(-2)
		say("小蚕子，你到底在哪儿啊？", 250, 0, "冰蚕老人")
		say("...", 0, 1)
		say("难道你自己回昆仑山去了？不行，我要去昆仑看看。", 250, 0, "冰蚕老人")
	end

	null(-2, 47)
end
OEVENTLUA[11118] = function ()
	Cls()
	say("这是一个古老的神像，年代久远，具体已经难以辨识是谁了。", 0, 2)

	if JY.Person[0].盗贼技巧 < 20 then
		return
	end

	say("你仔细观察，发现雕像十分精细，在衣袖内部似乎有一个衣兜", 0, 2)
	say("里面是一本薄薄的石书，上面隐隐有些字迹", 0, 2)
	say("汇天灵之气冲天汇穴，再入天寿穴...", 0, 1)
	say("后面就再也难以辨识了。", 0, 2)
	say("这是？", 0, 1)

	if JY.Person[0].内力最大值 >= 10000 then
		say("你试着以内力按照石书所述冲击穴位", 0, 2)
		dark()
		light()
		AddPersonAttrib(0, "生命增长", 1)
		AddPersonAttrib(550, "生命增长", 1)
		DrawStrBoxWaitKey("你的体质增加了一点", C_ORANGE, CC.DefaultFont)
		say("这...", 0, 1)
		say("...，这究竟是什么功法？", 0, 1)
		say("可惜只能识出这几个字，真是可惜，可惜。", 0, 1)
		null(-2, 51)
	else
		say("你试着以内力按照石书所述冲击穴位", 0, 2)
		dark()
		light()
		say("可惜除了经脉隐隐作疼以外，什么作用也没有", 0, 2)
		say("难道是我内力不够，还是内力根本不行？", 0, 1)
	end
end
OEVENTLUA[11201] = function ()
	Cls()
	say("这是...", 0, 1)
	addthing(212, 1)
	null(112, 1)
	say("你干什么？", 372, 0, "仆人")
	say("没事没事，我就是爱好书籍，随便翻翻。", 0, 1)
	say("主人不在，还请客人不要乱动家里东西。", 372, 0, "仆人")
end
OEVENTLUA[11202] = function ()
	Cls()
	say("主人外出，还请客人过些日子再来。", 372, 0, "仆人")
end
OEVENTLUA[11501] = function ()
	Cls()

	if JY.Person[0].官阶 == 12 then
		say("微臣参见皇上。", 242, 0, "统帅")
		say("唔，不错不错。", 0, 1)
		say("谢皇上。", 242, 0, "统帅")
		say("皇上龙体，怎可到边关冒险，我这就安排大军护送皇上离开。", 242, 0, "统帅")
		say("区区外族，能耐我何？", 0, 1)
		say("还请皇上以万民为上。", 242, 0, "统帅")
		say("好，知道了知道了，我这就回去。", 0, 1)
	else
		say("你是什么人？怎么进来的？军营重地，赶快离开。", 242, 0, "统帅")
	end
end
OEVENTLUA[11502] = function ()
	Cls()
	say("皇上将如此重任交付与我，我一定要将襄阳城守住。", 1140, 0, "太监监军")
end
OEVENTLUA[11503] = function ()
	Cls()
	say("开始训练了，都给我打起精神来。先给我练一遍枪法！", 1056, 0, "教官")
end
OEVENTLUA[11504] = function ()
	Cls()

	if JY.Person[0].官阶 == 12 then
		say("李将军一定会带我们打到贼寇老家去。", 1255, 0, "官军")
	else
		say("好几天没吃饱了，还要训练啊，每天都是喝粥，喝粥，我连枪都拿不稳了。", 1255, 0, "官军")
	end
end
OEVENTLUA[11505] = function ()
	Cls()
	say("小狗狗，你好啊。", 0, 1)
	say("汪汪汪，汪汪汪。", 1103, 0)
end
OEVENTLUA[11506] = function ()
	Cls()
	say("军营重地，赶快离开。", 1255, 0, "官军")
end
OEVENTLUA[11507] = function ()
	Cls()

	if JY.Person[740].好感度 < 50 then
		local var_398_0 = 50 - JY.Person[740].好感度

		say("各位父老乡亲，咱们到襄阳了，你们安全了。", 0, 1)
		dark()
		addevent(115, 112, 1, -2, 1, 10106, -2, -2)
		addevent(115, 113, 1, -2, 1, 7022, -2, -2)
		addevent(115, 114, 1, -2, 1, 9246, -2, -2)
		light()
		say("多谢恩公，我们永记你的恩情。", 1037, 0, "农民")
		addthing(324, 1)

		if JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 5 then
			say("参见帮主，帮主仁义。", 207, 0, "丐帮弟子")
			say("你安排好这些人，不要让他们再吃苦。", 0, 1)
			say("是，帮主。", 207, 0, "丐帮弟子")
		elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 4 then
			say("参见长老，长老仁义。", 207, 0, "丐帮弟子")
			say("你安排好这些人，不要让他们再吃苦。", 0, 1)
			say("是，长老。", 207, 0, "丐帮弟子")
		else
			say("好样的，" .. JY.Person[0].称呼 .. "，我丐帮定当宣扬你的侠名。", 207, 0, "丐帮弟子")
		end

		say("各位父老乡亲，有家的回家，无家的，丐帮就是你们的新家，得我丐帮相助，定能渡过这困难时期。", 207, 0, "丐帮弟子")
		say("请随丐帮弟子前去安置。", 207, 0, "丐帮弟子")
		dark()
		null(115, 112)
		null(115, 113)
		null(115, 114)
		light()
		instruct_37(2)

		if has_something(324, 3) then
			instruct_56(1)
		else
			instruct_56(var_398_0)
		end

		JY.Person[740].好感度 = 50
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 5 then
		say("参见帮主，这是丐帮在襄阳设立的收容点，专门收留失去财产和土地的兄弟姐妹入帮，虽然会过的艰难点，但至少不会饿死。", 207, 0, "丐帮弟子")
		say("很好，做的不错。", 0, 1)
		say("是，帮主。", 207, 0, "丐帮弟子")
	elseif JY.Person[0].门派 == 3 and JY.Person[0].门派等级 == 4 then
		say("参见长老，这是丐帮在襄阳设立的收容点，专门收留失去财产和土地的兄弟姐妹入帮，虽然会过的艰难点，但至少不会饿死。", 207, 0, "丐帮弟子")
		say("很好，做的不错。", 0, 1)
		say("是，长老。", 207, 0, "丐帮弟子")
	else
		say("奉帮主之命，丐帮在襄阳设立收容点，收留失去财产和土地的兄弟姐妹入帮，虽然会过的艰难点，但至少不会饿死。", 207, 0, "丐帮弟子")
	end
end
OEVENTLUA[11703] = function ()
	Cls()
	DrawStrBoxWaitKey("《苍龙逐日》，--小小猪", C_WHITE, CC.DefaultFont)
	DrawStrBoxWaitKey("世界扩展者，--游泳的鱼等", C_WHITE, CC.DefaultFont)
	DrawStrBoxWaitKey("世界扩展者，--weyl等", C_WHITE, CC.DefaultFont)

	JY.Person[551].好感度 = 51

	if has_thing(352) == false then
		say("" .. JY.Person[0].称呼 .. "，等一等。", 1145, 0, "grgame")
		say("前辈？", 0, 1)
		say("你能到这儿，就算有缘，看到了吧，桌子上有个小盒子。", 1145, 0, "grgame")
		say("看到了，好小的盒子。", 0, 1)
		addthing(352, 1)
		say("前辈，这个盒子是什么宝物？有什么用的？", 0, 1)
		say("宝物？也算是吧，此物乃钛晶所铸，千古不灭，万劫不化，最适合保存重要的东西，就送给你了。", 1145, 0, "grgame")
		say("多谢前辈。", 0, 1)
		say("（千古不灭？万劫不化？这位前辈似乎精神有点问题，还真能吹）", 0, 1)
	end
end
OEVENTLUA[11705] = function ()
	Cls()
	DrawStrBoxWaitKey("《再战江湖》，--南宫梦", C_WHITE, CC.DefaultFont)
end
OEVENTLUA[11706] = function ()
	Cls()
	DrawStrBoxWaitKey("《金书群芳谱》，--慕容玄恭", C_WHITE, CC.DefaultFont)
end
OEVENTLUA[11707] = function ()
	Cls()
	DrawStrBoxWaitKey("《金庸群侠前传》，--不算工作室：KG", C_WHITE, CC.DefaultFont)
end
OEVENTLUA[11708] = function ()
	Cls()
	DrawStrBoxWaitKey("《山寨江湖》，--多版本多人", C_WHITE, CC.DefaultFont)
end
OEVENTLUA[11709] = function ()
	Cls()
	DrawStrBoxWaitKey("《至尊江湖》，--星河Star", C_WHITE, CC.DefaultFont)
end
OEVENTLUA[11711] = function ()
	Cls()

	if JY.Person[551].好感度 == 52 then
		say("采菊东篱下，悠然见南山，这就是我想要的生活。", 1145, 0, "grgame")
	elseif JY.Person[551].好感度 == 51 then
		say("前辈，这到底是什么地方？那些奇怪的东西是什么？", 0, 1)
		say("这儿啊，不知道是什么地方，我自己叫它界外之岛。至于那些东西，我也不知道是什么，很奇妙的东西是吧？", 1145, 0, "grgame")
		say("前辈，这儿怎么出去？", 0, 1)

		if JY.Base.轮回数2 > 1 then
			say("出去？这得问你自己。", 1145, 0, "grgame")
			say("我？我怎么知道？", 0, 1)
			say("（这位前辈神神叨叨的，看来不是仙人，是个神棍。）", 0, 1)
		else
			say("出去？出不去的。别担心，那边有桃树，饿了就吃一个桃子，渴了到这儿喝一口水，死不了。", 1145, 0, "grgame")
			say("不可能，怎么会这样？", 0, 1)
		end

		JY.Person[551].好感度 = 52
	elseif JY.Base.轮回数2 > 1 then
		say("前辈你好。", 0, 1)
		say("你又来了。", 1145, 0, "grgame")
		say("又？前辈此话怎说？这儿我是第一次来。", 0, 1)
		say("对于现在的你，你确实是第一次来。对于过往的你，你确定自己是第一次？", 1145, 0, "grgame")
		say("我...（这位前辈似乎精神有点问题，我先自己四处观察看看）", 0, 1)
	else
		say("前辈你好。", 0, 1)
		say("你？原来是你，你怎么进来的？", 1145, 0, "grgame")
		say("我？前辈，不是你让我来的吗？", 0, 1)
		say("我没法和外界接触，又怎么可能让你来这儿？", 1145, 0, "grgame")
		say("什么？这？难道这是一个针对我的大阴谋？啊~", 0, 1)
	end
end
OEVENTLUA[11712] = function ()
	Cls()

	if has_thing(337) == true then
		say("这儿到底有什么秘密...，这是最后一块屏幕了。", 0, 1)

		JY.Person[551].好感度 = 52

		addevent(70, 1, 0, 2, 3, -2, -2, -2)
	else
		say("这儿到底有什么秘密...", 0, 1)
	end

	addevent(117, 22, 1, 11713, 1, -2, -2, -2)
	addevent(117, 23, 1, 11713, 1, -2, -2, -2)
	addevent(117, 24, 1, 11713, 1, -2, -2, -2)
end
OEVENTLUA[11713] = function ()
	Cls()

	if has_thing(337) == false then
		say("咦？这个地方怎么看着这么眼熟？我似乎见过...", 0, 1)
		say("走近点看看...", 0, 1)

		JY.Person[551].好感度 = 52

		say("屏幕上突然出现一个漩涡", 0, 2)
		say("啊~，又怎么了？我靠啊~", 0, 1)

		if JY.Person[0].生命增长 * 10 + math.ceil(JY.Person[0].内力最大值 / 500) + Rnd(5) < JY.YEAR + 100 then
			say("一阵剧烈的眩晕传来，你突然头脑短路，一头倒了下去", 0, 2)
			say("不~", 0, 1)
			gameover()

			return
		end

		JY.YEAR = JY.YEAR + 100

		say("一股强大的吸力传来，你一身雄浑的内力完全没有作用", 0, 2)
		say("啊~", 0, 1)
		dark()
		My_Enter_SubScene(91, 10, 8, 3)
		light()

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 8120, 8128)
		else
			instruct_27(-1, 8140, 8146)
		end

		say("这怎么那么像我来的那个通道。", 0, 0)
		say("内力在急速消耗，转眼就消耗一空", 0, 2)
		My_Enter_SubScene(91, 32, 31, 3)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 8120, 8128)
		else
			instruct_27(-1, 8140, 8146)
		end

		say("你头脑有些发晕，浑身的生命力，还有一些其他的东西在被急速吸取走", 0, 2)
		say("难道...", 0, 0)

		JY.Base.百年标记 = 1

		local var_407_0 = 20

		for iter_407_0 = 1, var_407_0 do
			JY.Person[0]["武功" .. iter_407_0] = 0
			JY.Person[0]["武功等级" .. iter_407_0] = 0
		end

		for iter_407_1 = 1, CC.MyThingNum do
			JY.Base["物品" .. iter_407_1] = -1
			JY.Base["物品数量" .. iter_407_1] = -1
		end

		instruct_59()

		JY.Person[0].宋罪恶值 = 0
		JY.Person[0].中原罪恶值 = 0
		JY.Person[0].清罪恶值 = 0
		JY.Person[0].武功1 = 121
		JY.Person[0].武功等级1 = 10
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].主功体 = 0
		JY.Person[0].副功体 = 0
		JY.Person[0].主运轻功 = 0
		JY.Person[0].左右互搏 = 0
		JY.Person[0].门派 = 0
		JY.Person[0].门派等级 = 0
		JY.Person[0].门派贡献 = 0
		JY.Person[0].官阶 = 0
		JY.Base.宠物1 = -1
		JY.Base.宠物2 = -1
		JY.Base.宠物3 = -1
		JY.Base.宠物4 = -1
		JY.Person[0].中原罪恶值 = 0
		JY.Person[0].宋罪恶值 = 0
		JY.Person[0].清罪恶值 = 0
		JY.Person[0].战斗控制 = 0
		JY.Person[0].战斗模式 = 1
		JY.Person[0].喜使武功 = 0
		JY.Person[0].生命增长 = JY.Person[0].生命增长 - 4
		JY.Person[0].生命 = 1
		JY.Person[0].生命最大值 = 44
		JY.Person[0].内力 = 0
		JY.Person[0].内力最大值 = 0
		JY.Person[0].攻击力 = 26
		JY.Person[0].防御力 = 20
		JY.Person[0].轻功 = 23
		JY.Person[0].拳掌功夫 = 14
		JY.Person[0].御剑能力 = 12
		JY.Person[0].耍刀技巧 = 12
		JY.Person[0].特殊兵器 = 13
		JY.Person[0].暗器技巧 = 14

		null(70, 0)
		null(70, 3)
		null(70, 4)
		null(70, 69)
		null(70, 71)
		null(70, 72)
		null(70, 114)
		null(70, 115)
		null(70, 87)
		null(70, 111)
		null(43, 38)
		addevent(70, 4, 1, 11721, 1, 10172, -2, -2)
		addevent(70, 113, 1, 11722, 1, 10312, -2, -2)
		addevent(70, 0, 1, 11723, 1, 9362, -2, -2)
		null(70, 5)
		null(70, 6)
		null(70, 33)
		null(70, 17)
		null(70, 118)
		null(70, 34)
		null(70, 13)
		null(57, 53)
		null(70, 15)
		null(57, 6)
		null(70, 25)
		null(70, 20)
		null(70, 16)
		null(70, 58)
		null(70, 12)
		null(70, 23)
		null(70, 24)
		null(70, 10)
		null(70, 11)
		null(70, 45)
		null(121, 9)
		null(70, 51)
		null(70, 14)
		null(57, 54)
		null(70, 35)
		null(70, 50)
		null(57, 5)
		null(70, 125)
		null(107, 2)
		null(70, 92)
		null(70, 103)
		null(70, 49)
		null(70, 107)
		null(70, 81)
		null(70, 109)
		null(70, 12)
		null(3, 106)
		null(70, 26)
		null(70, 88)
		null(70, 19)
		null(70, 86)
		null(108, 16)

		JY.Scene[0].进入条件 = 1
		JY.Scene[2].进入条件 = 1
		JY.Scene[4].进入条件 = 1
		JY.Scene[5].进入条件 = 1
		JY.Scene[6].进入条件 = 1
		JY.Scene[7].进入条件 = 1
		JY.Scene[11].进入条件 = 1
		JY.Scene[12].进入条件 = 1
		JY.Scene[16].进入条件 = 1
		JY.Scene[20].进入条件 = 1
		JY.Scene[21].进入条件 = 1
		JY.Scene[22].进入条件 = 1
		JY.Scene[23].进入条件 = 1
		JY.Scene[24].进入条件 = 1
		JY.Scene[25].进入条件 = 1
		JY.Scene[26].进入条件 = 1
		JY.Scene[27].进入条件 = 1
		JY.Scene[30].进入条件 = 1
		JY.Scene[32].进入条件 = 1
		JY.Scene[34].进入条件 = 1
		JY.Scene[35].进入条件 = 1
		JY.Scene[36].进入条件 = 1
		JY.Scene[39].进入条件 = 1
		JY.Scene[44].进入条件 = 1
		JY.Scene[45].进入条件 = 1
		JY.Scene[46].进入条件 = 1
		JY.Scene[47].进入条件 = 1
		JY.Scene[48].进入条件 = 1
		JY.Scene[49].进入条件 = 1
		JY.Scene[50].进入条件 = 1
		JY.Scene[51].进入条件 = 1
		JY.Scene[52].进入条件 = 1
		JY.Scene[53].进入条件 = 1
		JY.Scene[54].进入条件 = 1
		JY.Scene[55].进入条件 = 1
		JY.Scene[59].进入条件 = 1
		JY.Scene[67].进入条件 = 1
		JY.Scene[68].进入条件 = 1
		JY.Scene[71].进入条件 = 1
		JY.Scene[73].进入条件 = 1
		JY.Scene[74].进入条件 = 1
		JY.Scene[75].进入条件 = 1
		JY.Scene[84].进入条件 = 1
		JY.Scene[90].进入条件 = 1
		JY.Scene[92].进入条件 = 1
		JY.Scene[94].进入条件 = 1
		JY.Scene[95].进入条件 = 1
		JY.Scene[99].进入条件 = 1
		JY.Scene[112].进入条件 = 1
		JY.Scene[118].进入条件 = 1
		JY.Scene[120].进入条件 = 1
		JY.Scene[122].进入条件 = 1
		JY.Scene[132].进入条件 = 1
		JY.Scene[133].进入条件 = 1
		JY.Scene[134].进入条件 = 1
		JY.Scene[135].进入条件 = 1
		JY.Scene[136].进入条件 = 1

		null(25, 14)
		null(25, 15)
		null(25, 16)
		null(25, 17)
		null(25, 18)
		null(25, 19)
		null(25, 20)
		null(25, 21)
		null(25, 22)
		null(25, 24)
		null(25, 52)
		null(25, 54)
		null(25, 56)
		null(25, 57)
		null(25, 64)
		null(25, 65)
		null(25, 66)
		null(25, 67)
		null(25, 68)
		null(25, 69)
		null(25, 71)
		null(25, 73)
		null(25, 74)
		null(25, 75)
		null(25, 76)
		null(25, 84)
		null(25, 85)
		null(25, 86)
		null(25, 87)
		null(25, 88)
		null(25, 89)
		addevent(25, 35, 1, 11736, 1, 8542, -2, -2)
		addevent(25, 10, 1, 11735, 1, 8454, -2, -2)
		addevent(25, 11, 1, 11735, 1, 8456, -2, -2)
		addevent(25, 12, 1, 11735, 1, 8452, -2, -2)
		null(40, 33)
		null(40, 46)
		null(40, 96)
		null(40, 110)
		addevent(40, 31, 1, 11729, 1, 8692, -2, -2)
		addevent(40, 43, 1, 11730, 1, 8454, -2, -2)
		addevent(40, 104, 1, 11730, 1, 8452, -2, -2)
		null(60, 22)
		null(60, 23)
		null(1, 4)
		null(1, 5)
		null(1, 6)
		null(69, 95)
		null(69, 0)
		null(69, 21)
		null(69, 44)
		null(69, 59)
		null(69, 138)
		null(69, 133)
		addevent(69, 44, 1, 11729, 1, 10422, -2, -2)
		addevent(69, 123, 1, 11730, 1, 8452, -2, -2)
		addevent(69, 124, 1, 11730, 1, 8452, -2, -2)
		addevent(69, 125, 1, 11730, 1, 8458, -2, -2)
		addevent(69, 126, 1, 11730, 1, 8458, -2, -2)
		null(107, 56)
		addevent(107, 13, 1, 11730, 1, 8454, -2, -2)
		addevent(107, 14, 1, 11730, 1, 8454, -2, -2)
		addevent(107, 19, 1, 11730, 1, 8454, -2, -2)
		addevent(107, 28, 1, 11730, 1, 8454, -2, -2)
		addevent(107, 45, 1, 11730, 1, 8454, -2, -2)
		null(115, 24)
		null(119, 57)
		null(119, 55)
		null(119, 45)
		null(119, 46)
		null(119, 49)
		addevent(119, 22, 1, 11730, 1, 8452, -2, -2)
		addevent(119, 60, 1, 11730, 1, 8452, -2, -2)
		null(121, 1)
		null(121, 2)
		null(121, 3)
		null(123, 12)
		null(123, 13)
		null(123, 14)
		null(123, 114)
		addevent(123, 0, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 1, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 2, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 3, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 4, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 5, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 36, 1, 11730, 1, 8454, -2, -2)
		addevent(123, 109, 1, 11730, 1, 8454, -2, -2)
		null(128, 23)
		null(128, 11)
		null(128, 19)
		null(128, 24)
		null(128, 46)
		null(128, 48)
		null(128, 49)
		null(128, 100)
		addevent(128, 21, 1, 11724, 1, 10372, -2, -2)
		addevent(128, 16, 1, 11730, 1, 8452, -2, -2)
		addevent(128, 25, 1, 11730, 1, 8452, -2, -2)
		addevent(128, 120, 1, 11730, 1, 8454, -2, -2)
		addevent(128, 121, 1, 11730, 1, 8454, -2, -2)
		addevent(128, 122, 1, 11730, 1, 8454, -2, -2)
		null(43, 4)
		null(43, 11)
		null(43, 12)
		null(43, 13)
		null(43, 14)
		null(43, 19)
		null(43, 34)
		null(43, 36)
		null(43, 38)
		null(43, 47)
		null(43, 62)
		addevent(43, 4, 1, 11725, 1, 5382, -2, -2)
		null(28, 8)
		null(28, 9)
		null(28, 10)
		null(28, 11)
		null(28, 14)
		null(28, 24)
		null(28, 25)
		null(28, 42)
		null(28, 143)
		null(28, 144)
		addevent(28, 21, 1, 9289, 1, 5372, -2, -2)
		addevent(28, 78, 1, 11726, 1, 5372, -2, -2)
		addevent(28, 87, 1, 9289, 1, 5372, -2, -2)
		null(57, 2)
		null(57, 5)
		null(57, 15)
		null(57, 51)
		null(57, 53)
		null(57, 54)
		null(57, 60)
		null(57, 61)
		null(57, 50)
		null(57, 62)
		null(57, 52)
		null(57, 63)
		null(57, 66)
		null(57, 67)
		addevent(57, 3, 1, 11727, 1, 8452, -2, -2)
		addevent(57, 4, 1, 11727, 1, 8452, -2, -2)
		null(29, 0)
		null(29, 1)
		null(29, 3)
		null(29, 4)
		null(29, 13)
		addevent(29, 5, 1, 11728, 1, 10276, -2, -2)
		null(58, 12)
		null(58, 13)
		addevent(58, 0, 1, 11734, 1, 8454, -2, -2)
		addevent(58, 20, 1, 11734, 1, 8454, -2, -2)
		null(31, 0)
		null(31, 1)
		null(31, 4)
		null(31, 7)
		addevent(31, 5, 1, 11732, 1, 5196, -2, -2)
		addevent(31, 3, 1, 11733, 1, 5194, -2, -2)
		null(33, 2)
		null(33, 5)
		null(33, 6)
		null(33, 7)
		null(33, 8)
		null(33, 9)
		null(33, 10)
		null(33, 23)
		null(33, 24)
		addevent(33, 4, 1, 11732, 1, 5196, -2, -2)
		addevent(33, 3, 1, 11733, 1, 5196, -2, -2)
		null(19, 7)
		null(19, 8)
		null(19, 9)
		null(19, 31)
		null(19, 32)
		null(19, 33)
		addevent(19, 0, 1, 11728, 1, 5404, -2, -2)
		addevent(19, 45, 1, 11731, 1, 10294, -2, -2)
		addevent(19, 34, 1, -2, 1, 3244, -2, -2)
		null(77, 14)
		null(105, 3)
		null(105, 5)
		null(105, 6)
		null(105, 7)
		null(115, 9)
		null(115, 14)
		null(115, 15)
		null(115, 18)
		null(115, 19)
		null(115, 20)
		null(115, 21)
		null(115, 22)
		null(115, 23)
		addevent(115, 99, 1, 11730, 1, 8452, -2, -2)
		addevent(115, 100, 1, 11730, 1, 8452, -2, -2)
		dark()
		My_Enter_SubScene(70, 27, 31, 2)
		addevent(70, 99, 1, 11794, 1, -2, -2, -2)
		light()
		say("还好，我毕竟是天命之人，没有死掉", 0, 1)
	else
		say("咦？这个地方怎么看着这么眼熟？", 0, 1)
		say("走近点看看...", 0, 1)
		say("一股强大的吸力传来，你一身雄浑的内力完全没有作用", 0, 2)
		say("啊~", 0, 1)
		dark()
		My_Enter_SubScene(91, 10, 8, 3)
		light()
		say("又怎么了，啊~", 0, 1)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 8120, 8128)
		else
			instruct_27(-1, 8140, 8146)
		end

		say("这里怎么那么像我来的那个通道。", 0, 0)
		say("内力在急速消耗，转眼就消耗一空", 0, 2)
		My_Enter_SubScene(91, 32, 31, 3)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 8120, 8128)
		else
			instruct_27(-1, 8140, 8146)
		end

		say("你头脑有些发晕，突然，身上的电池似乎闪了一下", 0, 2)
		addthing(337, -1)

		if GetS(53, 0, 1, 5) >= CC.CircleNum - 1 then
			local var_407_1 = string.format("%s&&%d&&%d&&%d\n", JY.Person[JY.Base.队伍1].姓名, JY.Base.主角职业, JY.Base.特殊主角, JY.Base.游戏难度)
			local var_407_2 = io.open(CC.CircleFile, "ab")

			if var_407_2 then
				for iter_407_2 = 1, #var_407_1 do
					var_407_2:write(string.format("%02X", string.byte(string.sub(var_407_1, iter_407_2, iter_407_2))))
				end

				var_407_2:close()
			end
		end

		local var_407_3 = JY.Base.游戏难度
		local var_407_4 = JY.Person[0].精神
		local var_407_5 = JY.Person[0].气运
		local var_407_6 = JY.Person[0].生命增长 - (JY.Person[550].生命增长 - 7)
		local var_407_7 = JY.Base.畅想编号
		local var_407_8 = JY.Base.主角职业
		local var_407_9 = JY.Base.特殊主角
		local var_407_10 = JY.Person[0].姓名
		local var_407_11 = JY.Person[0].性别
		local var_407_12 = JY.Person[0].头像代号
		local var_407_13 = JY.Person[0].初始天赋级别
		local var_407_14 = JY.Base.轮回数2
		local var_407_15 = JY.Base.电池数

		say("难道...", 0, 0)
		say("你晕了过去", 0, 2)
		My_Enter_SubScene(91, 40, 4, 3)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 8120, 8128)
		else
			instruct_27(-1, 8140, 8146)
		end

		My_Enter_SubScene(5, 102, 35, 3)
		say("砰", 0, 2)
		say("谁啊？", 266, 0, "阿牛")
		say("哪个混小子，把我家屋顶砸了一个大洞？", 266, 0, "阿牛")
		say("阿豹，那儿有一个人。", 1030, 1, "阿豹")
		say("啊？", 266, 0, "阿牛")
		say("不会死了吧。", 1030, 1, "阿豹")
		say("哎呀不好，快送去找医生。", 266, 0, "阿牛")
		say("奇怪，这青天白日的，这人从哪儿来的？难道是天上掉下来的？", 1030, 1, "阿豹")
		say("嘀咕啥呢，还不快点。", 266, 0, "阿牛")
		say("哎，快快。", 1030, 1, "阿豹")
		ClsN()
		dark()

		JY.Status = GAME_SMAP
		JY.MmapMusic = -1

		CleanMemory()
		Init_SMap(0)
		light()
		lib.ShowSlow(100, 0)
		say("不知过了多久，你悠悠醒转", 0, 2)
		LoadRecord(0)
		Cls()

		if JYMsgBox("请选择游戏难度", "游戏难度可以升级", {
			"不变",
			"难度升级"
		}, 2, 1115) == 2 then
			JY.Base.游戏难度 = var_407_3 + 1
		end

		local var_407_16 = JYMsgBox("恭喜通关，你可以选择提升你的基础属性并带入下一场游戏", "你的精神、气运、体质最大可以提升到10", {
			"提升精神",
			"提升气运",
			"提升体质",
			"放弃"
		}, 4, 1115)

		if var_407_16 == 1 then
			JY.Person[0].精神 = var_407_4 + 1
			JY.Person[0].生命增长 = var_407_6

			if JY.Person[0].精神 > 10 then
				JY.Person[0].精神 = 10
			end
		end

		if var_407_16 == 2 then
			JY.Person[0].气运 = var_407_5 + 1
			JY.Person[0].生命增长 = var_407_6

			if JY.Person[0].气运 > 10 then
				JY.Person[0].气运 = 10
			end
		end

		if var_407_16 == 3 then
			JY.Person[0].生命增长 = var_407_6 + 1

			if JY.Person[0].生命增长 > 10 then
				JY.Person[0].生命增长 = 10
			end
		end

		JY.Base.畅想编号 = var_407_7
		JY.Base.主角职业 = var_407_8
		JY.Base.特殊主角 = var_407_9
		JY.Person[0].姓名 = var_407_10
		JY.Person[0].性别 = var_407_11
		JY.Person[0].头像代号 = var_407_12
		JY.Person[0].初始天赋级别 = var_407_13
		JY.Base.轮回数1 = var_407_14
		JY.Base.轮回数2 = var_407_14 + 1
		JY.Base.电池数 = var_407_15

		local var_407_17 = 20

		for iter_407_3 = 1, CC.Kungfunum do
			JY.Person[0]["武功" .. iter_407_3] = 0
			JY.Person[0]["武功等级" .. iter_407_3] = 0
		end

		GRTS[0] = "无"
		JY.Person[0].武功1 = 121
		JY.Person[0].武功等级1 = 10
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].主功体 = 0
		JY.Person[0].副功体 = 0
		JY.Person[0].主运轻功 = 0
		JY.Person[0].左右互搏 = 0
		JY.Person[0].门派 = 0
		JY.Person[0].门派等级 = 0
		JY.Person[0].门派贡献 = 0
		JY.Person[0].佛学修为 = 0
		JY.Person[0].阵法知识 = 0
		JY.Person[0].盗贼技巧 = 0
		JY.Person[0].儒学修为 = 0
		JY.Person[0].官阶 = 0
		JY.Person[0].驱虫术 = 0
		JY.Person[0].中原罪恶值 = 0
		JY.Person[0].宋罪恶值 = 0
		JY.Person[0].清罪恶值 = 0
		JY.Person[0].战斗控制 = 0
		JY.Person[0].战斗模式 = 1
		JY.Person[0].喜使武功 = 0
		JY.Person[0].生命最大值 = 50
		JY.Person[0].内力最大值 = 0
		JY.Person[0].攻击力 = 30
		JY.Person[0].防御力 = 30
		JY.Person[0].轻功 = 30
		JY.Person[0].医疗能力 = 0
		JY.Person[0].用毒能力 = 0
		JY.Person[0].解毒能力 = 0
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].拳掌功夫 = 30 + JY.Base.轮回数2
		JY.Person[0].御剑能力 = 30 + JY.Base.轮回数2
		JY.Person[0].耍刀技巧 = 30 + JY.Base.轮回数2
		JY.Person[0].特殊兵器 = 30 + JY.Base.轮回数2
		JY.Person[0].暗器技巧 = 30 + JY.Base.轮回数2

		for iter_407_4 = 1, CC.MyThingNum do
			JY.Base["物品" .. iter_407_4] = -1
			JY.Base["物品数量" .. iter_407_4] = -1
		end

		for iter_407_5 = 2, CC.TeamNum do
			JY.Base["队伍" .. iter_407_5] = -1
		end

		addevent(70, 87, 1, 21, 1, 8348, -2, -2)
		addevent(70, 4, 1, 36, 1, 8250, -2, -2)
		addevent(70, 3, 1, -2, 1, 5098, -2, -2)
		addevent(70, 113, 1, -2, 1, 8830, -2, -2)
		addevent(70, 111, 1, 26, 1, 5266, -2, -2)
		My_Enter_SubScene(70, 8, 27, 3)
	end
end
OEVENTLUA[11719] = function ()
	Cls()
	addthing(15, 1)
end
OEVENTLUA[11721] = function ()
	Cls()
	say("你是谁？在我家里做什么？", 1235, 0, "100年后的老人")
	say("...，见鬼了，这是什么情况？", 0, 1)
	say("小梅，小梅，谁让你放人进来的？你赶快离开，要不我报官了。", 1235, 0, "100年后的老人")
end
OEVENTLUA[11722] = function ()
	Cls()
	say("老爷睡觉老打呼噜，弄得我老睡不好觉，今天得让他去医馆看看。", 522, 0, "100年后的夫人")
	say("小梅，小梅，谁让你放人进来的？", 522, 0, "100年后的夫人")
	say("...，怎么回事这是？", 0, 1)
end
OEVENTLUA[11723] = function ()
	Cls()
	say("你是谁？在这里做什么？", 1110, 0, "100年后的丫鬟")
	say("你又是谁？", 0, 1)
	say("我是家里的丫鬟小梅。", 1110, 0, "100年后的丫鬟")
	say("...，？", 0, 1)
	say("喂，你赶快走吧，老爷发现了会骂我的。", 1110, 0, "100年后的丫鬟")
end
OEVENTLUA[11724] = function ()
	Cls()
	say("嘘，宝宝快睡觉，宝宝快睡觉。", 1070, 0, "100年后的夫人")
	say("你是谁？谁让你进来的？赶快离开，要不我报官了。", 1070, 0, "100年后的夫人")
end
OEVENTLUA[11725] = function ()
	Cls()
	say("两百年前，三丰真人在此创建了武当派。本人不才，乃当代武当掌门。", 1023, 0, "100年后的武当掌门")
	say("近年来来我武当观光的游客越来越多，人人都踊跃捐款，客人要不要捐一些啊？", 1023, 0, "100年后的武当掌门")
end
OEVENTLUA[11726] = function ()
	Cls()
	say("我少林与朝廷关系深厚，时常有王爷将军前来参佛。", 602, 0, "100年后的少林掌门")
	say("近年来来我少林观光的游客越来越多，人人都踊跃捐款，客人要不要捐一些啊？", 602, 0, "100年后的少林掌门")
end
OEVENTLUA[11727] = function ()
	Cls()
	say("此处是速不台将军别院，南人不得进入。", 1093, 0, "华山护卫")
end
OEVENTLUA[11728] = function ()
	Cls()
	say("请在其他区域观赏。", 1093, 0, "华山护卫")
	say("此处是私人别院，游客不得进入。", 1093, 0, "华山护卫")
end
OEVENTLUA[11729] = function ()
	Cls()
	say("你是谁？在我家里做什么？", 1151, 0, "100年后的老人")
	say("你赶快离开，要不我报官了。", 1151, 0, "100年后的老人")
end
OEVENTLUA[11730] = function ()
	Cls()
	say("这不是你该来的地方。赶快离开。", 243, 0, "100年后的元兵")
end
OEVENTLUA[11731] = function ()
	Cls()
	say("你是谁？在我家里做什么？赶快离开。", 1151, 0, "100年后的老人")
end
OEVENTLUA[11732] = function ()
	Cls()
	say("青灯伴古佛，伴我清净心。", 191, 0, "100年后的尼姑")
end
OEVENTLUA[11733] = function ()
	Cls()
	say("师父师姐下山化缘去了，居士请自便。", 191, 0, "100年后的尼姑")
end
OEVENTLUA[11734] = function ()
	Cls()
	say("此处是呼必来将军别院，南人不得进入。", 1093, 0, "华山护卫")
end
OEVENTLUA[11735] = function ()
	Cls()
	say("这是武道大会故址，参观需要收取纹银百两。", 243, 0, "100年后的元兵")

	if yesno("要参观此处吗？") then
		say("很好，快拿银子。", 243, 0, "100年后的元兵")

		if instruct_31(100) == false then
			say("你的银子不够。", 243, 0, "100年后的元兵")

			return
		end

		say("行了，进去看吧。", 243, 0, "100年后的元兵")
		dark()
		null(-2, 12)
		light()
		addthing(174, -100)
	end
end
OEVENTLUA[11736] = function ()
	Cls()

	local var_424_0 = JY.Person[0].姓名

	if JY.Person[22].好感度 == 70 then
		say("这里是南人的一个武道团体聚会旧址，首领叫做..aa..，后来被大军剿灭了。", 519, 0, "100年后的少女")
		say("怎么可能？", 0, 1)
		say("听说那一战打的十分激烈，后来大汗就下令封存了这一段历史的资料，谁也不知道事情的具体经过了。", 519, 0, "100年后的少女")
		say("元军能攻下这里？里面一定有蹊跷。", 0, 1)
		say("谁知道呢，据说这些人十分崇拜他们的首领，临死还坚信他们首领会回来救他们，可惜那个首领自己跑了，再也没有露面。", 519, 0, "100年后的少女")
		say("...", 0, 1)
		say("兄弟们，我对不住你们，很快我就来找你们了。", 0, 1)
		say("这些人也是傻，怎么可能对抗大军的，我们大军是无敌的。", 519, 0, "100年后的少女")
		say("你？不是汉人？", 0, 1)
		say("我爸爸是元人，妈妈是汉人的。", 519, 0, "100年后的少女")
	else
		say("这里是南人的一个武道团体聚会旧址，首领叫做左冷禅，后来被大军剿灭了。", 519, 0, "100年后的少女")
		say("怎么可能？", 0, 1)
		say("听说那一战打的十分激烈，后来大汗就下令封存了这一段历史的资料，谁也不知道事情的具体经过了。", 519, 0, "100年后的少女")
		say("元军能攻下这里？里面一定有蹊跷。", 0, 1)
		say("谁知道呢，反正全死光了。", 519, 0, "100年后的少女")
		say("...", 0, 1)
		say("左冷禅，你到底做了什么？", 0, 1)
		say("这些人也是傻，怎么可能对抗大军的，我们大军是无敌的。", 519, 0, "100年后的少女")
		say("你？不是汉人？", 0, 1)
		say("我爸爸是元人，妈妈是汉人的。", 519, 0, "100年后的少女")
	end
end
OEVENTLUA[11791] = function ()
	Cls()

	local var_425_0 = Rnd(10)

	dark()
	null(-2, 29)
	null(-2, 30)
	null(-2, 31)
	null(-2, 32)
	null(-2, 33)
	light()

	if var_425_0 == 1 then
		say("你转过弯去，却见前方尽头居然有一个身形十分高挑窈窕的女子", 0, 2)
		addevent(117, 1, -2, -2, -2, 10112, -2, -2)
		instruct_40(0)
		say("喂~", 0, 1)
		say("哦？想不到居然这么快就有觉醒者来到这里了。", 1276, 0, "神秘女子")
		say("什么？", 0, 1)
		say("她十分认真的看了你一会儿", 0, 2)
		say("可惜，似乎是刚刚觉醒的，等以后再来看看吧。", 1276, 0, "神秘女子")
		say("等一下，你刚刚说的什么觉醒者？", 0, 1)
		null(-2, 1)
		say("喂~，说清楚再走。", 0, 1)
		say("怎么回事？神神秘秘的样子。", 0, 1)
	elseif var_425_0 == 2 then
		say("你转过弯去，却见前方尽头居然有一个身形十分高挑窈窕的女子", 0, 2)
		addevent(117, 1, -2, -2, -2, 10112, -2, -2)
		instruct_40(0)
		say("喂~", 0, 1)
		say("哦？我们又见面了。", 1276, 0, "神秘女子")
		say("什么？", 0, 1)
		say("她十分认真的看了你一会儿", 0, 2)
		say("奇怪，你身上有一股奇怪的气息，你好像不是这个世界的人？", 1276, 0, "神秘女子")
		say("我？", 0, 1)
		say("你隐约间一阵恍惚，似乎想起了什么，又什么也没有想起", 0, 2)
		say("我想起来了，我好像来自一个叫地球的地方。", 0, 1)
		say("地球吗，我知道那个地方，是个很低等的世界。", 1276, 0, "神秘女子")
		say("奇怪，我感觉这只是一个虚拟的世界，是因为我才开启的，你怎么？", 0, 1)
		say("虚拟的世界么？", 1276, 0, "神秘女子")
		say("她上下看了你一遍", 0, 2)
		say("什么才是真实，什么才是虚假，你真的知道吗？", 1276, 0, "神秘女子")
		say("所谓一念生世界，一念世界灭。", 1276, 0, "神秘女子")
		say("地球所在的世界也不过是一些数学规则的组合吧了，", 1276, 0, "神秘女子")
		say("何谈什么真实虚幻，不愧是低纬的生物。", 1276, 0, "神秘女子")
		null(-2, 1)
		say("喂~，什么意思？等等。", 0, 1)
	elseif var_425_0 == 3 then
		addevent(117, 36, -2, -2, -2, 8362, 52, 61)
		say("阿财，你果然有问题。", 367, 0, "大姐大")
		instruct_40(2)
		say("大姐大？你怎么来了？", 0, 1)
		say("我听到南叔和丑叔偷偷说什么命中注定，天命什么的，似乎说你有问题，这次就跟着你来看看。", 367, 0, "大姐大")
		say("果然，阿财，你到底是什么人？", 367, 0, "大姐大")
		say("我吗？", 0, 1)
		say("你隐约间一阵恍惚，似乎想起了什么，又什么也没有想起", 0, 2)
		say("我好像不是这个世界的人。", 0, 1)
		say("不是这个世界的人？", 367, 0, "大姐大")

		if JY.Person[0].官阶 > 0 then
			say("你的父母不是在福州吗？", 367, 0, "大姐大")
			say("不，那只是个误会，不过他们对我挺好的。", 0, 1)
		end

		say("你不是这个世界的人？那你从哪里来？到我们这儿做什么？", 367, 0, "大姐大")
		say("我？我想不起来了，但是我隐约觉得这个世界是因为我才存在的。", 0, 1)
		say("阿财，你虽然有点成就，可也不要太自大了，世界不是围着你转的。", 367, 0, "大姐大")
		say("可能吧，我该回去了，这对我来说只是一个梦。", 0, 1)
		say("等等，从这儿能够去你的世界？", 367, 0, "大姐大")
		say("应该可以。", 0, 1)
		say("带我一起去。", 367, 0, "大姐大")
		say("这可以吗？", 0, 1)
		say("有什么不可以。", 367, 0, "大姐大")
		say("我感觉会很难。再说你去做什么去？", 0, 1)
		say("人的一生就是一次旅行，这个世界我逛得差不多了，现在有个机会去其他世界旅行，我为什么不去？", 367, 0, "大姐大")
		say("可能会有生命危险。我觉得你还是回去更好。", 0, 1)
		say("回得去吗？你看看这个地方，怎么回去？", 367, 0, "大姐大")
		say("你左右上下看看，只见一片白云缭绕的绝壁，外围是一片虚空，果然没有路可走", 0, 2)
		say("那好吧，我们试试。", 0, 1)
		say("大姐大随队行动", 0, 2)
		null(-2, 36)
	else
		null(-2, 1)
		say("喂~，等等！", 0, 1)
	end
end
OEVENTLUA[11792] = function ()
	Cls()
	dark()
	null(-2, 33)
	null(-2, 34)
	null(-2, 35)
	addevent(117, 1, 0, 11793, 3, -2, -2, -2)
	addevent(117, 29, 0, 11793, 3, -2, -2, -2)
	addevent(117, 30, 0, 11793, 3, -2, -2, -2)
	light()
	say("通道尽头的巨大岩壁上有一个幽深的山洞", 0, 2)
	say("该死。", 0, 1)
	say("你有些疑神疑鬼，可是周边都是绝壁，无法可想", 0, 2)
end
OEVENTLUA[11793] = function ()
	Cls()
	dark()
	null(-2, 29)
	null(-2, 30)
	light()
	say("一股巨大的吸力传来", 0, 2)
	say("该死，又是这个。", 0, 1)
	say("一股巨大的无法抗拒的力量将你往山洞里拉去，你似乎穿过了一层透明的薄膜", 0, 2)
	say("啊~", 0, 1)
	My_Enter_SubScene(91, 32, 31, 3)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8160, 8166)
	else
		instruct_27(-1, 8140, 8146)
	end

	My_Enter_SubScene(5, 102, 35, 3)
	say("在这危机关头，你隐隐有了明悟，似乎自己要醒过来了", 0, 2)
	say("感谢你下载grgame的《龙启江湖》", 0, 2)
	dark()
	gameover()
end
OEVENTLUA[11794] = function ()
	Cls()
	dark()
	null(-2, 99)
	light()
	say("这个世界...，真是无趣了啊。", 0, 0)
	say("不如归去~", 0, 0)
	dark()
	My_Enter_SubScene(91, 32, 31, 3)
	light()

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8120, 8128)
	else
		instruct_27(-1, 8140, 8146)
	end

	say("好熟悉的感觉~", 0, 0)
	My_Enter_SubScene(5, 102, 35, 3)
	say("在这危机关头，你隐隐有了明悟，似乎自己要醒过来了", 0, 2)
	say("感谢你下载grgame的《龙启江湖》", 0, 2)
	dark()
	gameover()
end
OEVENTLUA[11795] = function ()
	Cls()
	dibang()
end
OEVENTLUA[11796] = function ()
	Cls()
	tianbang()
end
OEVENTLUA[11802] = function ()
	Cls()
	say("大金国王府，汗猪快滚。", 1074, 0, "金兵")
end
OEVENTLUA[11803] = function ()
	Cls()
	say("这是？居然有儒学书籍？看看先。", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 40)
end
OEVENTLUA[11804] = function ()
	Cls()
	say("这是？居然有儒学书籍？看看先。", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 41)
end
OEVENTLUA[11805] = function ()
	Cls()
	say("皇宫禁地，两脚羊快滚。", 1074, 0, "金兵")
end
OEVENTLUA[11806] = function ()
	Cls()

	if has_something(324, 10) then
		say("快走快走，主上下令，不允许将奴隶卖给汉人了。", 1074, 0, "金兵")
		say("为什么？", 0, 1)
		say("可恶的汉人，偷偷将奴隶运送回南朝，主上大怒，连郝连将军都受了责罚，谁还敢卖的？就地处死。", 1074, 0, "金兵")
		say("...", 0, 1)
		say("还不走？快滚！", 1074, 0, "金兵")

		return
	end

	say("奴隶，你是代主人来领取奴隶的吗？", 1074, 0, "金兵")

	if yesno("要认可吗？") then
		say("啊？是的。", 0, 1)
		say("一个奴隶20两，一批100个共2000两，拿来吧。", 1074, 0, "金兵")

		if instruct_31(2000) == false then
			say("没带银子？", 1074, 0, "金兵")
			say("你这么傻，你主人知道吗？啊？哈哈哈", 1074, 0, "金兵")
			say("...", 0, 1)

			return
		end

		instruct_32(174, -2000)
		dark()
		light()
		say("一批奴隶跟随了你", 0, 2)

		JY.Person[740].好感度 = JY.Person[740].好感度 - 1

		say("和你主人说，这些可都是挑出来的好货色，能干活，还有嚼头，这价钱绝对值了。", 1074, 0, "金兵")
		say("...", 0, 1)
	else
		say("我？不是。", 0, 1)
		say("没有主人带领不许乱跑，快滚！。", 1074, 0, "金兵")
	end
end
OEVENTLUA[11807] = function ()
	Cls()
	say("这是南朝的岳飞神将，当年打败了我们金兀术大帅，乃是当世大英雄，大豪杰。", 1074, 0, "金兵")
	say("可惜被南朝皇帝杀死了，幸好，幸好。", 1074, 0, "金兵")
end
OEVENTLUA[11808] = function ()
	Cls()
	say("我是酒泉的人，我15岁就被抓到这儿了。", 518, 0, "妇人")
	say("我被六王爷赐给了呼鲁而赞，现在都有三个孩子了。", 518, 0, "妇人")
	say("王爷让我照顾汗血宝马，这是小王爷最喜欢的坐骑。", 518, 0, "妇人")
end
OEVENTLUA[11901] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("菊花剑客前几年纵横江湖，好不威风，却突然销声匿迹，你们知道是为什么吗？", 254, 0, "酒客2")
		say("你知道？", 338, 0, "酒客1")
		say("我听说他结识了一个大美人，已经封剑归隐了。", 254, 0, "酒客2")
		say("不会吧？听说他得了铁骨墨萼梅念笙的传承，如此归隐岂不是对不起梅大侠的一番心意。", 338, 0, "酒客1")
		say("你想多了，他再收几个弟子也就行了。", 254, 0, "酒客2")
		say("有理，只是不知道谁人有这福气？", 338, 0, "酒客1")
	else
		say("李家四个儿子，死了三个，最后一个被封了义勇兵，老李现在高兴了。", 254, 0, "酒客2")
		say("有啥好高兴的，也不知道是不是好事。", 338, 0, "酒客1")
		say("可不是，现在的人啊，奴颜媚骨。", 254, 0, "酒客2")
	end
end
OEVENTLUA[11902] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说嵩山掌门左冷禅新创了一门剑法，快慢一十七路剑，取嵩山剑法大成，十分了得。", 254, 0, "酒客2")
		say("这个左冷禅实是天才，年纪轻轻就隐然成了五岳剑派第一人，成就远超历代先祖。", 338, 0, "酒客1")
		say("这人野心勃勃，只怕对当今武林非是好事啊。", 254, 0, "酒客2")
		say("禁声，这可是在嵩山派的势力范围，说话小心一点。", 338, 0, "酒客1")
		say("哎，对对对。", 254, 0, "酒客2")
		say("来，喝酒喝酒。", 338, 0, "酒客1")
	else
		say("听说逃兵役的人都回来了。", 1026, 0, "酒客2")
		say("怎么？", 1027, 0, "酒客1")
		say("元人找了一些熟悉路径的人进去，人人为了立功，将数百里的密洞都转遍了。", 1026, 0, "酒客2")
		say("这些可好，谁也别想逃了。", 1027, 0, "酒客1")
	end
end
OEVENTLUA[11903] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("（告牌上贴着几张告示）江湖通缉榜。黑道巨枭榜：丁春秋、金輪法王、段延慶、成崑、血刀老祖。江洋大盗榜：瀟湘子、李莫愁、梅超風、石万嗔。江湖匪盗榜：閻基、葉二娘、岳老三、云中鶴、田伯光、勝諦。", 0, 2)
	else
		say("（告牌上贴着几张告示）朝廷公告：严格等级制度，违者杀立决。第一等级蒙古人，第二等级色目人，第三等级少数游牧民族，第四等级南人。", 0, 2)
	end
end
OEVENTLUA[11904] = function ()
	Cls()

	local var_441_0 = {
		1,
		22,
		111,
		132,
		163,
		239,
		294
	}
	local var_441_1 = {
		2,
		6,
		23,
		24,
		25,
		253,
		261,
		280,
		287,
		292,
		299,
		300
	}
	local var_441_2 = {
		8,
		16,
		38,
		45,
		46,
		68,
		71,
		90,
		120,
		137,
		168
	}
	local var_441_3 = Rnd(6)

	if JY.Person[0].门派 == 10 and (JY.Person[550].儒学修为 == 1 or JY.Person[601].好感度 == 0) and (JY.Person[0].官阶 > 10 or JY.Person[621].好感度 == 0) then
		say(JY.Person[0].称呼 .. "，想不到你能做到这个地步。我家主人有请。", 1131, 0, "值守人")
		say("你家主人？", 0, 1)
		say("正是。你不会以为江湖通缉榜是没有人管的吧？", 1131, 0, "值守人")
		say("这确是江湖上最大的谜团，那我就去看看，你家主人到底是什么人？是怎么做到的？", 0, 1)
		say("且随我来。", 1131, 0, "值守人")
		dark()
		My_Enter_SubScene(70, 45, 12, 0)
		addevent(70, 61, 0, 0, 0, 8846, -2, -2)
		light()
		say("这？这不是小村吗？", 0, 1)
		say("你进入井里，一直往下潜，水很深，你得憋很长的气才行。", 1131, 0, "值守人")
		say("你？你是说你们总部在这个井下？", 0, 1)
		say("不错！", 1131, 0, "值守人")
		say("这不可能，我们怎么从来没有发现的？", 0, 1)
		say("呵呵，你下去看看就知道了。", 1131, 0, "值守人")

		if yesno("要下井里看看嘛？") then
			say("真让人好奇啊，我且下去看看。", 0, 1)
			instruct_59()

			JY.Base.佣兵1 = -1
			JY.Base.佣兵2 = -1
			JY.Base.佣兵3 = -1
			JY.Person[0].修炼物品 = -1
			JY.Person[0].武器 = -1
			JY.Person[0].防具 = -1
			JY.Person[0].饰品 = -1
			JY.Person[0].坐骑 = -1

			dark()
			My_Enter_SubScene(91, 10, 8, 3)
			null(70, 61)
			light()

			if JY.Person[0].性别 == 0 then
				instruct_27(-1, 8120, 8128)
			else
				instruct_27(-1, 8140, 8146)
			end

			say("好深的井，似乎没有尽头似的，你不由心里有点打鼓。", 0, 0)
			My_Enter_SubScene(91, 32, 31, 3)

			if JY.Person[0].性别 == 0 then
				instruct_27(-1, 8120, 8128)
			else
				instruct_27(-1, 8140, 8146)
			end

			say("内力耗光大半了，我得回，咦？前面似乎有点光亮。", 0, 0)
			dark()
			My_Enter_SubScene(117, 9, 23, 0)
			light()
			say("这是什么地方？奇怪，我明明一直往下潜的，怎么反而从湖里出来了。", 0, 0)
			My_Enter_SubScene(117, 11, 23, 0)
			instruct_59()
		else
			say("我不相信你，你到底有什么阴谋？", 0, 1)
			say("呵呵，这个世界有大秘密。你既不相信，那我就走了。", 1131, 0, "值守人")
			dark()
			null(70, 61)
			null(119, 57)
			null(128, 23)
			light()
		end

		return
	end

	if JY.Person[0].功德值 >= 30 then
		say(JY.Person[0].称呼 .. "，你完成了通缉令任务，这是你应得的奖励。", 1131, 0, "值守人")
		addthing(var_441_2[var_441_3])
		addthing(174, JY.Person[0].功德值 * 500)

		JY.Person[0].功德值 = 0
	elseif JY.Person[0].功德值 >= 20 then
		say(JY.Person[0].称呼 .. "，你完成了通缉令任务，这是你应得的奖励。", 1131, 0, "值守人")
		addthing(var_441_1[var_441_3])
		addthing(174, JY.Person[0].功德值 * 500)

		JY.Person[0].功德值 = 0
	elseif JY.Person[0].功德值 >= 10 then
		say(JY.Person[0].称呼 .. "，你完成了通缉令任务，这是你应得的奖励。", 1131, 0, "值守人")
		addthing(var_441_0[var_441_3])
		addthing(174, JY.Person[0].功德值 * 500)

		JY.Person[0].功德值 = 0
	elseif JY.Person[0].功德值 > 0 then
		say(JY.Person[0].称呼 .. "，你完成了通缉令任务，这是你应得的奖励。", 1131, 0, "值守人")
		addthing(174, JY.Person[0].功德值 * 500)

		JY.Person[0].功德值 = 0
	else
		say("铁血堂发布江湖通缉令，追杀通缉令上的江洋大盗、黑道巨枭，可以获得高额的悬赏。", 1131, 0, "值守人")
	end
end
OEVENTLUA[11905] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("听说了吗？有人发现唐诗宝藏了？", 338, 0, "酒客1")
		say("哦？传说有绝世剑法，还有黄金宝藏的那个唐诗宝藏？", 254, 0, "酒客2")
		say("正是，最近好多武林高手云集荆州，只怕又是一场腥风血雨啊。", 338, 0, "酒客1")
		say("兄弟，喝完酒咱们也去看看去？", 254, 0, "酒客2")
		say("很危险啊，只怕不小心丢了性命。", 338, 0, "酒客1")
		say("怕什么？所谓富贵险中求，咱们就博一把。", 254, 0, "酒客2")
		say("说的是，不博一把咱们能甘心，兄弟，干了此杯。", 338, 0, "酒客1")
		say("干。", 254, 0, "酒客2")
	else
		say("北边杏子林被封了，围了好多军队啊。", 1033, 0, "酒客1")
		say("怎么？", 1033, 0, "酒客2")
		say("有人学古时的李广，要揭竿而起，结果先内讧了。", 1033, 0, "酒客1")
		say("哎，可惜，可惜。", 1033, 0, "酒客2")
	end
end
OEVENTLUA[11906] = function ()
	Cls()
	say("私人府邸，非请勿入。", 371, 0, "仆人")
end
OEVENTLUA[11907] = function ()
	Cls()
	say("官府重地，无关人等赶快离开。", 1250, 0, "捕快")
end
OEVENTLUA[11908] = function ()
	Cls()

	if instruct_60(119, 59, 7182) == false then
		say("要黄龙玉吗？这是我偷偷从家里拿出来的黄龙玉，听人说很值钱的。", 369, 0)
		say("小骗子，你还在这儿呢。你上次骗我买了你的黄龙玉，到现在还没有卖出去，你还我银子来。", 0, 1)
		say("我不认识你啊，你不要看我小就欺负我。", 369, 0)
		say("小骗子，赶快还我银子来。", 0, 1)
		say("这黄龙玉真的很值钱的，我没有骗你，你上次没有问掌柜的吗？是不是收300两银子一颗的。", 369, 0)
		say("他说收几百两银子都没用，现在已经不收黄龙玉了。", 0, 1)
		say("你别急啊，想挣钱得有耐心，现在不收，不代表以后就不收啊，既然有人要收这玉，你总会挣着的。", 369, 0)
		say("......", 0, 1)
		say("怎么样，我这还有10块，我便宜点转给你，就1800怎么样？", 369, 0)

		if yesno("要收购黄龙玉吗？") then
			if instruct_31(1800) == false then
				say("你这不到1800两银子，别想蒙我。", 369, 0)

				return
			end

			addthing(174, -1800)
			addthing(334, 10)
		else
			say("小骗子，还想骗我，找打。", 0, 1)
			say("啊，救命啊，打人了。", 369, 0)
			say("你脖子上的这是什么？拿来！", 0, 1)
			addthing(337, 1)
			dark()
			addevent(119, 96, 1, 0, 1, 10592, -2, -2)
			light()
			say("大胆，放下那孩子，府衙重地，居然敢拦路抢劫。", 1250, 0, "捕快")
			say("大哥，你误会了，事情是这样的。", 0, 1)
			say("休得啰嗦，抗拒从严。", 1250, 0, "捕快")

			if JY.Person[0].门派 == 1 then
				say("原来是武当的少侠，误会，误会了。", 1250, 0, "捕快")
				say("啊...", 0, 1)
				say("你，是不是又骗人银子了？这可是武当的少侠，还不快将银子还给人家。", 1250, 0, "捕快")
				say("武当的？哎呀，我最崇拜武当的大侠了，这真是大水冲了龙王庙，大侠，还请收下。", 369, 0)
				addthing(174, 2400)
				say("哦...", 0, 1)
				say("大侠，能不能介绍我拜入武当啊，我根骨清奇，是练武的好苗子啊。", 369, 0)
				say("去去去，还不快滚，小心我把你抓起来。少侠，难得见到武当高第，不如小人请你喝杯酒。", 1250, 0, "捕快")
				say("不了，我还有事在身。", 0, 1)
				say("是是是，不敢耽误少侠正事，少侠在荆州有什么事尽管到府衙找我，像这等小事，必不会令少侠失望。", 1250, 0, "捕快")
				say("如此多谢了。", 0, 1)
				say("不敢，不敢，小的告退。小子，还不快走。", 1250, 0, "捕快")
				say("大侠，你收下我吧，哎呀...", 369, 0)
				dark()
				null(-2, 95)
				null(-2, 96)
				light()

				return
			end

			if JY.Person[0].门派 == 2 then
				say("原来是少林寺的大师，误会，误会了。", 1250, 0, "捕快")
				say("啊...", 0, 1)
				say("你，是不是又骗人银子了？这可是少林的大师，还不快将银子还给人家。", 1250, 0, "捕快")
				say("哎？是是，大师，我错了，还请收下。", 369, 0)
				addthing(174, 2400)
				say("哦...", 0, 1)
				say("小子，今天好好教训教训你，少林寺的大师是你能惹的吗？", 1250, 0, "捕快")
				say("大师，等我回去好好教训教训这个小子，还不快走？", 1250, 0, "捕快")
				say("哎呀...", 369, 0)
				dark()
				null(-2, 95)
				null(-2, 96)
				light()
				say("...", 0, 1)

				return
			end

			if JY.Person[0].门派 == 5 and JY.Person[0].门派等级 == 5 then
				say("原来是华山派的掌门，误会，误会了。", 1250, 0, "捕快")
				say("哦？", 0, 1)
				say("你，是不是又骗人银子了？这可是华山掌门，还不快将银子还给人家。", 1250, 0, "捕快")
				say("哎？是是，大人，我错了，还请收下。", 369, 0)
				addthing(174, 2400)
				say("哦...", 0, 1)
				say("小子，今天好好教训教训你，华山掌门是你能惹的吗？", 1250, 0, "捕快")
				say("大人，等我回去好好教训教训这个小子，还不快走？", 1250, 0, "捕快")
				say("哎呀...", 369, 0)
				dark()
				null(-2, 95)
				null(-2, 96)
				light()
				say("...", 0, 1)

				return
			end

			null(-2, 95)

			if yesno("要反抗官兵吗？") then
				say("来人啊，抓捕江洋大盗啊。", 1250, 0, "捕快")

				if WarMain(514, 0, 1, 1) == false then
					instruct_15(0)
					instruct_0()

					return
				end

				say("居然敢拒捕，快请捕头大人过来。", 1250, 0, "捕快")
				say("真是麻烦，我还是先避避风头再说。", 0, 1)
				dark()
				null(-2, 96)
				ReturnMMap2(278, 259)
				light()
				addtime(1)

				JY.Person[0].中原罪恶值 = JY.Person[0].中原罪恶值 + 20

				say("呼，一路追杀，终于摆脱了，这都什么事啊？", 0, 1)
			else
				say("大哥，你别激动，我和你去府衙，你把这小孩也带上。", 0, 1)
				dark()
				null(-2, 96)
				My_Enter_SubScene(119, 2, 48, 1)
				light()
				say("搞什么？你们快放我出去。", 0, 1)
				dark()
				light()
				say("冤枉啊，放我出去。", 0, 1)
				dark()
				light()
				say("好了，我们已经查清了，那孩子没有骗你，你和那孩子做生意是你情我愿。", 1250, 0, "捕快")
				say("出去后老老实实做人，不要以为会点武功就欺负小孩。把这几天的伙食费交了，赶快出去吧。", 1250, 0, "捕快")
				addtime(14)
				addthing(174, -2000)
				dark()
				My_Enter_SubScene(119, 28, 45, 1)
				light()
				say("这都什么事啊？", 0, 1)
			end
		end
	else
		say("小朋友，你手里拿的是什么啊？", 0, 1)
		say("这是我偷偷从家里拿出来的黄龙玉，听人说很值钱的。", 369, 0)
		say("（这玉看起来温润透明，成色不错）小朋友，我给你100两银子你把这石头给我怎么样？", 0, 1)
		say("骗小孩的东西，你羞不羞？", 369, 0)
		say("我怎么会骗你，100两银子啊，你可以买很多很多玩具的。", 0, 1)
		say("以为我不知道？杂货店就在收黄玉，收300两银子一块的。想骗我？不可能的。", 369, 0)
		say("真的？", 0, 1)
		say("不信你去问啊。", 369, 0)

		if yesno("要想办法得到黄龙玉吗？") then
			say("小朋友，既然这石头能卖很多钱，你怎么不去卖掉啊？", 0, 1)
			say("以为我不想啊？这店老板和我爹认识的，我要卖了石头，回家我就得挨打。", 369, 0)
			say("这样啊？那这样，我给你200两银子，你把石头卖给我怎么样？你想我才挣100，你可是挣了200的。", 0, 1)
			say("我算算，1个200，2个400，3个600，......", 369, 0)
			say("你有很多这种石头？", 0, 1)
			say("没有很多，只有12个。", 369, 0)
			say("12个？12个是2400两。", 0, 1)
			say("不行，我要自己算，1个200，2个400，3个600，......。", 369, 0)
			say("......", 0, 1)
			dark()
			light()
			say("算好了，是2400。", 369, 0)
			say("给你。", 0, 1)

			if instruct_31(2400) == false then
				say("你这不到2400两银子，别想蒙我。", 369, 0)

				return
			end

			addthing(174, -2400)
			addthing(334, 12)
		end
	end
end
OEVENTLUA[11909] = function ()
	Cls()

	if has_thing(334) and instruct_60(119, 59, 7182) then
		say("小店帮其他客人定的黄龙玉，如今已经收购足了。", 1027, 0)
		say("客人，你要有黄龙玉出售等下次机会吧。", 1027, 0)
		say("...", 0, 1)
		null(-2, 59)
		addevent(119, 95, 1, 11908, 1, 7182, -2, -2)
	else
		say("本店急着收购黄龙玉，我300两银子一颗收购了。", 1027, 0)
	end
end
OEVENTLUA[11910] = function ()
	Cls()
	say("听说黑白神剑夫妇丢失了孩儿，近十几年一直在江湖上行走，要找回他们的孩子。", 1034, 0, "酒客1")
	say("石庄主夫妇武功高强，也不知道怎么会丢失他们的孩子的？又有谁敢偷走他们的孩子。", 1035, 0, "酒客2")
	say("是啊，黑白神剑夫妇武功既高，对人又友善，也不知道是谁要对付他们。", 1034, 0, "酒客1")
	say("也许是些人贩子，不知道他们的背景，反而敢下手，只是十几年过去了，只怕找不到了。", 1035, 0, "酒客1")
	say("哎，武功高强也不是万能的，来，喝酒喝酒。", 1034, 0, "酒客2")
	say("喝。", 1035, 0, "酒客1")
end
OEVENTLUA[12001] = function ()
	Cls()
	say("这是...", 0, 1)
	addthing(240, 1)
	null(120, 0)
end
OEVENTLUA[12101] = function ()
	Cls()
	say("听说五毒教和百药门又打起来了。", 254, 0, "酒客2")
	say("这两教不知道争斗了多少年了，一直也不相上下，这次不知道又是什么原因打起来。", 338, 0, "酒客1")
	say("听说是五毒教的镇教三宝给人偷了。", 254, 0, "酒客2")
	say("难道是百药门的人偷的？", 338, 0, "酒客1")
	say("这却不是，据说是一个汉人，只是五毒教不知道发了什么疯，找不回宝物，将气撒在了百药门身上。", 254, 0, "酒客2")
	say("就是不讲理啊，咱们在云南行事可得小心。", 338, 0, "酒客1")
	say("是啊，咱们买了毒药就赶紧回去，我可不想多待了。", 338, 0, "酒客1")
end
OEVENTLUA[12102] = function ()
	Cls()
	say("听说有人在神龙架找到了千年何首乌，卖得了万两银子。", 254, 0, "酒客2")
	say("好福气啊。", 338, 0, "酒客1")
	say("咱们也去转转，说不得也挖一颗来，不就是一颗千年何首乌嘛。", 254, 0, "酒客2")
	say("这深山老林的，毒虫甚多，咱们只怕。", 338, 0, "酒客1")
	say("无妨，我联系了帮内的玩虫高手来，这次一点要在帮里出口气。", 254, 0, "酒客2")
end
OEVENTLUA[12103] = function ()
	Cls()

	if math.random(2) == 1 then
		say("前面就是我大理有名的镜湖，听说镜湖中心有一口鬼井，总有人莫名其妙的掉进去，你可不要靠近那里。", 1033, 0, "酒客")
	else
		say("你是外来的汉人吧，到大理千万别惹黑苗族的人，听闻他们都会巫蛊之术，十分可怕。", 1033, 0, "酒客2")
	end
end
OEVENTLUA[12104] = function ()
	Cls()
	say("大理皇宫，闲人莫入。", 1164, 0, "卫士")
end
OEVENTLUA[12201] = function ()
	Cls()
	say("南人，这不是你来的地方，赶快离开。", 243, 0, "蒙古武士")
end
OEVENTLUA[12301] = function ()
	Cls()
	say("好多的书，我得看看。", 0, 1)
	dark()
	light()
	addtime(30)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "悟性", 1)
	DrawStrBoxWaitKey("你遍阅诸子百家典籍，你的悟性增加了1", C_ORANGE, CC.DefaultFont, 2)
	null(123, 20)
end
OEVENTLUA[12302] = function ()
	Cls()

	if JY.Person[0].官阶 == 7 then
		if JY.Person[742].好感度 >= 55 and JY.Person[741].好感度 >= 85 then
			dark()
			addevent(123, 87, 1, -2, 1, 9386, -2, -2)
			light()
			say(JY.Person[0].姓名 .. "何在？", 255, 0, "严大人")
			say("下官在此。", 0, 1)
			say("大理寺少卿病故，经太师推荐，大理寺少卿由你接任。", 255, 0, "严大人")
			say("多谢大人。", 0, 1)
			say("虽有太师推荐，但是做事还是要踏踏实实，不要忘记了你的本心。", 255, 0, "严大人")
			say("是，下官谨记。", 0, 1)
			say("你搬到我这里来，我平常来的少，你多多费心。", 255, 0, "严大人")
			say("是，大人。", 0, 1)
			dark()
			null(-2, 87)
			My_Enter_SubScene(123, 6, 5, 3)
			light()

			JY.Person[0].官阶 = 8
			JY.Person[0].宋罪恶值 = 0
		elseif JY.Person[741].好感度 >= 90 and JY.Person[60].好感度 == 51 and JY.Person[56].好感度 == 50 then
			dark()
			addevent(123, 97, 0, 8840, 3, -2, -2, -2)
			addevent(123, 93, 1, 0, 1, 9606, -2, -2)
			addevent(123, 94, 1, 0, 1, 10394, -2, -2)
			addevent(123, 95, 1, 0, 1, 10384, -2, -2)
			addevent(123, 96, 1, 0, 1, 9602, -2, -2)
			light()
			say("大人，太师有请。", 1164, 0, "卫士")
			say("啊？在什么地方？", 0, 1)
			say("太师在厢房等候，大人请。", 1164, 0, "卫士")
			null(-2, 93)
		else
			say("又是这么多的文书要整理啊，啊，好累。", 0, 1)
			dark()
			light()
			addtime(30)
			say("终于好了，该休息了。", 0, 1)
			say("什么时候能再升一下啊。", 0, 1)

			if JY.Person[741].好感度 <= 90 then
				JY.Person[741].好感度 = JY.Person[741].好感度 + 1
			end
		end
	end
end
OEVENTLUA[12303] = function ()
	Cls()

	if JY.Person[0].官阶 > 10 then
		say("参见皇上。", 1164, 0, "卫士")
		say("唔。", 0, 1)
	elseif JY.Person[0].官阶 >= 7 and JY.Person[0].官阶 <= 10 then
		say("参见大人。", 1164, 0, "卫士")
		say("唔，各位辛苦了。", 0, 1)
		say("不敢，大人慢走。", 1164, 0, "卫士")
		null(123, 3)
	elseif JY.Person[0].宋罪恶值 >= 970 then
		if JY.Person[0].官阶 > 0 and JY.Person[0].官阶 < 7 then
			say("是你？你还敢到官衙来！你的事犯了，已经被去官离职，来人啊，抓住他~", 1250, 0, "捕快")

			JY.Person[0].官阶 = 0

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		else
			say("是你？你还敢到皇城来！来人啊，抓住这个逆贼~", 1164, 0, "卫士")

			if WarMain(385, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫禁卫大军过来~", 1164, 0, "卫士")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(123, 30, 58, 3)
			light()
		end
	else
		say("皇城禁地，闲人赶快离开。", 1164, 0, "卫士")
	end
end
OEVENTLUA[12304] = function ()
	Cls()
	say("官人，我给你唱个小曲吧，只要5两银子。", 512, 0, "卖艺女")

	if instruct_11() == false then
		Cls()

		return
	end

	if instruct_31(5) == false then
		say("官人，不要开小女的玩笑啦。", 512, 0, "卖艺女")

		return
	end

	say("行啊，给大爷我唱一曲。", 0, 1)
	instruct_32(174, -5)
	say("春花秋月何时了...", 512, 0, "卖艺女")
	say("小楼一夜又东风...", 512, 0, "卖艺女")
	instruct_14()
	instruct_13()
	say("官人，下次再来啊。", 512, 0, "卖艺女")
end
OEVENTLUA[12305] = function ()
	Cls()
	say("昨夜的知了叫个不停，都没有睡好。", 302, 0, "小姐")
	say("姐姐，你黑眼圈都出来了。", 332, 0, "小妹")
	say("哎呀，一会儿还要去参加个诗会呢，这样子怎么行，你快帮我敷一敷。", 302, 0, "小姐")
end
OEVENTLUA[12306] = function ()
	Cls()
	say("这么多的风流才子，我每天都来这里，总会碰上一个能看上我的。", 311, 0, "小姐")
	say("我才不要和爹妈介绍的那个矮胖子过一辈子呢。", 311, 0, "小姐")
end
OEVENTLUA[12307] = function ()
	Cls()

	if JY.Person[0].官阶 == 8 then
		if JY.Person[60].好感度 == 51 and JY.Person[56].好感度 == 50 then
			dark()
			addevent(123, 97, 0, 8840, 3, -2, -2, -2)
			addevent(123, 93, 1, 0, 1, 9606, -2, -2)
			addevent(123, 94, 1, 0, 1, 10394, -2, -2)
			addevent(123, 95, 1, 0, 1, 10384, -2, -2)
			addevent(123, 96, 1, 0, 1, 9602, -2, -2)
			light()
			say("大人，太师有请。", 1164, 0, "卫士")
			say("啊？在什么地方？", 0, 1)
			say("太师在厢房等候，大人请。", 1164, 0, "卫士")
		else
			say("新的一天又开始了，真是浑身充满了干劲啊。", 0, 1)
			say("嗳，诸位同僚，都给我好好干活，今年的指标一定要漂漂亮亮的。", 0, 1)
			say("是，大人。", 1045, 0, "寺丞")
			dark()
			light()
			addtime(30)
		end
	end
end
OEVENTLUA[12308] = function ()
	Cls()

	local var_461_0 = Rnd(3)

	if var_461_0 == 1 then
		say("每天都是这么多的文案要做，好累啊。", 1027, 0, "寺丞")
	elseif var_461_0 == 2 then
		say("咱们这工作一定要用心，一个错误，可能就会害了数千数万的百姓。", 1045, 0, "寺丞")
	else
		say("我在这儿做了好多年了，希望能有机会分到地方上去，我的梦想就是为官一任，造福一方。", 1026, 0, "寺丞")
	end
end
OEVENTLUA[12309] = function ()
	Cls()
	dark()
	null(123, 37)
	light()

	if JY.Person[0].官阶 > 10 then
		say("参见皇上。", 1164, 0, "卫士")
		say("唔。", 0, 1)
		null(123, 0)
		null(123, 2)
		null(123, 3)
		addevent(123, 108, 0, 12310, 3, -2, -2, -2)
	else
		say("皇宫禁地，未得圣上召见不得进入，速速离开。", 1164, 0, "卫士")
		My_Enter_SubScene(123, 31, 39, 3)
	end
end
OEVENTLUA[12310] = function ()
	dark()
	null(123, 37)
	null(123, 108)
	addevent(123, 109, 1, 12313, 1, -2, -2, -2)
	light()
	say("皇上， 你是要出宫去？", 1164, 0, "卫士")
	say("不错。", 0, 1)
	say("皇上，请待我报上大将军，为皇上安排仪仗。", 1164, 0, "卫士")
	say("不用，不过你提醒我了，待我换一个装，微服出宫，哈哈。", 0, 1)
	say("末将禁卫军左营统领李蝉，愿意跟随皇上左右，护卫皇上安全。", 1164, 0, "卫士")

	local var_463_0 = 50
	local var_463_1 = 30
	local var_463_2 = var_463_1 * var_463_0 / 2 + 2 * CC.MenuBorderPixel
	local var_463_3 = var_463_1 + 2 * CC.MenuBorderPixel
	local var_463_4 = -1
	local var_463_5 = -1

	if yesno("要让李蝉随行护卫吗？") then
		say("那你跟着我吧，不过都换上普通衣服。", 0, 1)
		say("是，谢皇上。", 1164, 0, "卫士")
		DrawStrBox(-1, -1, "给你的护卫李铁蝉一行选一个位置", C_WHITE, var_463_1)

		local var_463_6 = {
			{
				"第一护卫",
				nil,
				1
			},
			{
				"第二护卫",
				nil,
				2
			},
			{
				"第三护卫",
				nil,
				3
			}
		}
		local var_463_7 = ShowMenu(var_463_6, 3, 0, var_463_4 + var_463_2 - 4 * var_463_1 - 2 * CC.MenuBorderPixel, var_463_5 + var_463_3 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

		if var_463_7 == 1 then
			if JY.Base.佣兵1 > 0 then
				JY.Person[JY.Base.佣兵1].佛学修为 = 0
			end

			JY.Base.佣兵1 = 417
		elseif var_463_7 == 2 then
			if JY.Base.佣兵2 > 0 then
				JY.Person[JY.Base.佣兵2].佛学修为 = 0
			end

			JY.Base.佣兵2 = 417
		elseif var_463_7 == 3 then
			if JY.Base.佣兵3 > 0 then
				JY.Person[JY.Base.佣兵3].佛学修为 = 0
			end

			JY.Base.佣兵3 = 417
		end

		JY.Person[417].姓名 = "李蝉(左营)"
		JY.Person[417].头像代号 = 208
		JY.Person[417].生命 = 4300
		JY.Person[417].生命最大值 = 4300
		JY.Person[417].内力 = 6200
		JY.Person[417].内力最大值 = 6200
		JY.Person[417].攻击力 = 300
		JY.Person[417].防御力 = 300
		JY.Person[417].轻功 = 260
		JY.Person[417].耍刀技巧 = 60
		JY.Person[417].武功1 = 58
		JY.Person[417].武功等级1 = 999
		JY.Person[417].儒学修为 = JY.DAY
		JY.Person[417].佛学修为 = 1

		null(123, 36)
		addevent(123, 37, 0, 12314, 3, -2, -2, -2)
		addevent(123, 115, 0, 12314, 3, -2, 31, 34)
	else
		say("唔，不用跟着我。", 0, 1)
		say("是，皇上。", 1164, 0, "卫士")
	end

	dark()

	JY.Person[0].官阶 = 11

	light()
end
OEVENTLUA[12311] = function ()
	Cls()
	say("佛学？且先看看", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "佛学修为", 5)
	DrawStrBoxWaitKey("你的佛学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 98)
end
OEVENTLUA[12313] = function ()
	say("末将禁卫军右营统领傅传，愿意跟随皇上左右，护卫皇上安全。", 1164, 0, "卫士")

	local var_465_0 = 50
	local var_465_1 = 30
	local var_465_2 = var_465_1 * var_465_0 / 2 + 2 * CC.MenuBorderPixel
	local var_465_3 = var_465_1 + 2 * CC.MenuBorderPixel
	local var_465_4 = -1
	local var_465_5 = -1

	if yesno("要让傅传随行护卫吗？") then
		say("那你跟着我吧，不过都换上普通衣服。", 0, 1)
		say("是，谢皇上。", 1164, 0, "卫士")
		DrawStrBox(-1, -1, "给你的护卫傅传博一行选一个位置", C_WHITE, var_465_1)

		local var_465_6 = {
			{
				"第一护卫",
				nil,
				1
			},
			{
				"第二护卫",
				nil,
				2
			},
			{
				"第三护卫",
				nil,
				3
			}
		}
		local var_465_7 = ShowMenu(var_465_6, 3, 0, var_465_4 + var_465_2 - 4 * var_465_1 - 2 * CC.MenuBorderPixel, var_465_5 + var_465_3 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

		if var_465_7 == 1 then
			if JY.Base.佣兵1 > 0 then
				JY.Person[JY.Base.佣兵1].佛学修为 = 0
			end

			JY.Base.佣兵1 = 418
		elseif var_465_7 == 2 then
			if JY.Base.佣兵2 > 0 then
				JY.Person[JY.Base.佣兵2].佛学修为 = 0
			end

			JY.Base.佣兵2 = 418
		elseif var_465_7 == 3 then
			if JY.Base.佣兵3 > 0 then
				JY.Person[JY.Base.佣兵3].佛学修为 = 0
			end

			JY.Base.佣兵3 = 418
		end

		JY.Person[418].姓名 = "傅传(右营)"
		JY.Person[418].头像代号 = 208
		JY.Person[418].生命 = 4300
		JY.Person[418].生命最大值 = 4300
		JY.Person[418].内力 = 6200
		JY.Person[418].内力最大值 = 6200
		JY.Person[418].攻击力 = 300
		JY.Person[418].防御力 = 300
		JY.Person[418].轻功 = 260
		JY.Person[418].耍刀技巧 = 60
		JY.Person[418].武功1 = 59
		JY.Person[418].武功等级1 = 999
		JY.Person[418].儒学修为 = JY.DAY
		JY.Person[418].佛学修为 = 1

		null(123, 109)
		addevent(123, 37, 0, 12314, 3, -2, -2, -2)
		addevent(123, 115, 0, 12314, 3, -2, 31, 34)
	else
		say("唔，不用跟着我。", 0, 1)
		say("是，皇上。", 1164, 0, "卫士")
	end

	dark()

	JY.Person[0].官阶 = 11

	light()
end
OEVENTLUA[12314] = function ()
	dark()
	null(123, 37)
	null(123, 115)
	light()

	if instruct_60(123, 36, 9600) == false then
		addevent(123, 36, 1, 12310, 1, 9600, -2, -2)

		if JY.Base.佣兵1 == 417 then
			JY.Base.佣兵1 = -1
		elseif JY.Base.佣兵2 == 417 then
			JY.Base.佣兵2 = -1
		elseif JY.Base.佣兵3 == 417 then
			JY.Base.佣兵3 = -1
		end
	end

	if instruct_60(123, 109, 9600) == false then
		addevent(123, 109, 1, 12313, 1, 9600, -2, -2)

		if JY.Base.佣兵1 == 418 then
			JY.Base.佣兵1 = -1
		elseif JY.Base.佣兵2 == 418 then
			JY.Base.佣兵2 = -1
		elseif JY.Base.佣兵3 == 418 then
			JY.Base.佣兵3 = -1
		end
	end
end
OEVENTLUA[12326] = function ()
	Cls()
	say("少侠，你看见小三子了吗？", 1123, 0, "老妇人")
	say("小三子？", 0, 1)
	say("小三子前天跑出去后就再没有回来，我找了好久都没有找到。", 1123, 0, "老妇人")
	say("小三子是？", 0, 1)
	say("小三子个子很大，一身黑毛，很好认的。", 1123, 0, "老妇人")
	say("狗啊，老人家，我会帮你留意。", 0, 1)
	addevent(123, 114, 1, 12327, 1, 10316, -2, -2)
end
OEVENTLUA[12327] = function ()
	Cls()
	say("两个儿子全上了战场，一去就不回来。可怜我老人家就大黑子陪着我了。", 1123, 0, "老妇人")
	say("我的孩子啊。", 1123, 0, "老妇人")
	addevent(115, 120, 1, 12328, 1, 6272, -2, -2)
end
OEVENTLUA[12328] = function ()
	Cls()
	say("好想家。", 1104, 0, "小黑")
	say("好想母亲，母亲，我回不去了，呜呜...", 1104, 0, "小黑")
	say("你这是？", 0, 1)
	say("我和哥哥被官府征召来前线打仗，三年前哥哥战死了。", 1104, 0, "小黑")
	say("去年我被金兵砍中了大腿，残疾了。", 1104, 0, "小黑")
	say("我想回家...", 1104, 0, "小黑")
	say("你家是哪里的？", 0, 1)
	say("临安同锣鼓巷。", 1104, 0, "小黑")

	if yesno("是否要送可怜人回家？") then
		say("真是可怜，我送你回去吧。", 0, 1)
		say("啊？谢谢！谢谢！", 1104, 0, "小黑")
		null(-2, 120)
		say("小黑随队行动，请尽快赶至临安", 0, 2)
		null(128, 50)
		addevent(123, 114, 1, 12329, 1, 10316, -2, -2)
	else
		say("真是可怜，命不好啊。", 0, 1)
	end
end
OEVENTLUA[12329] = function ()
	Cls()
	dark()
	addevent(123, 113, 1, -2, 1, 6266, -2, -2)
	light()
	say("娘，我回来了。", 1104, 0, "小黑")
	say("我的儿啊~", 1123, 0, "老妇人")
	say("娘~", 1104, 0, "小黑")
	say("回来就好，回来就好。", 1123, 0, "老妇人")
	say("多谢恩人，这是我在军中学的刀法，就送与恩人，愿你长命百岁。", 1104, 0, "小黑")
	addthing(289)
	say("多谢你了，好人会有好报的，小黑，我们回家吧。", 1123, 0, "老妇人")
	dark()
	null(-2, 113)
	null(-2, 114)
	light()
	say("小黑么？希望你后半辈子能够幸福。", 0, 1)
end
OEVENTLUA[12401] = function ()
	Cls()

	if JY.Person[0].耍刀技巧 == 299 and JY.Person[0].实战 >= 1000 then
		say("北风卷地百草折，胡天八月即飞雪。好一片大漠风光。", 0, 1)
		say("哈哈哈~哈哈哈~", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(3, 3)

		JY.Person[0].耍刀技巧 = 300
	else
		say("千里黄云白日曛，北风吹雁雪纷纷。", 0, 1)
		say("好一片大漠风光。", 0, 1)
	end
end
OEVENTLUA[12501] = function ()
	Cls()
	say("食人岛", 0, 1)
end
OEVENTLUA[12502] = function ()
	Cls()

	if instruct_16(77) then
		dark()
		light()
		say("哎，" .. JY.Person[0].称呼 .. "，快看，这后边有个山洞。", 77, 0)
		say("小心一点，走我后面。", 0, 1)
		say("嗯。", 77, 0)
		null(-2, 3)
		instruct_17(125, 1, 34, 2, 0)
	elseif JY.Person[0].盗贼技巧 > 30 then
		say("原来这后面有个山洞，被草丛遮住了。。", 0, 1)
		null(-2, 3)
		instruct_17(125, 1, 34, 2, 0)
	end
end
OEVENTLUA[12503] = function ()
	Cls()
	say("好多的蜘蛛。", 0, 1)

	if WarMain(293, 0) == false then
		instruct_15()
		Cls()
		Cls()

		return
	end

	if instruct_16(77) then
		dark()
		light()
		say("哎呀，好多的蜘蛛。", 77, 0)

		if WarMain(293, 0) == false then
			instruct_15()
			Cls()
			Cls()

			return
		end

		addthing(209, 50)
		addthing(10, 5)
		addthing(9, 10)
		say("就这些东西啊，没有了？这算什么宝藏嘛？", 77, 0)
		say("我们再仔细找找，看有没有什么机关暗门。", 0, 1)
		addevent(125, 3, 0, 12502, 3, -2, -2, -2)
		null(-2, 2)
	end
end
OEVENTLUA[12801] = function ()
	Cls()
	say("本店招收药僮，一月一两银子，有兴趣吗？", 1022, 0, "药店掌柜")

	if yesno("要打工挣钱吗？") then
		say("很好，我先教你辨认药材，了解它的基本药理。", 1022, 0, "药店掌柜")
		dark()
		light()

		if JY.Person[0].医疗能力 < 20 then
			AddPersonAttrib(0, "医疗能力", 10)
		end

		dark()
		light()
		addtime(30)
		say("喏，这是你本月的工钱。", 1022, 0, "药店掌柜")
		addthing(174, 1)
		say("工作还不够努力啊，记得要有爱心，讲奉献，立志高远。", 1022, 0, "药店掌柜")
		say("啥意思？", 0, 1)
		say("你悟性太低，就是工作要更努力啊。", 1022, 0, "药店掌柜")
		say("......", 0, 1)
	elseif instruct_31(2500) then
		say("售卖名贵中药材，一大包只要2500两银子，你要不要来一点儿？", 1022, 0, "药店掌柜")

		if yesno("要购买吗？") then
			say("很好，这是你的药材，你拿好了。", 1022, 0, "药店掌柜")
			addthing(209, 10)
			addthing(174, -2500)
		end
	end
end
OEVENTLUA[12802] = function ()
	Cls()

	if JY.Person[0].宋罪恶值 >= 970 then
		if JY.Person[0].官阶 > 0 and JY.Person[0].官阶 < 7 then
			say("是你？你还敢到官衙来！你的事犯了，已经被去官离职，来人啊，抓住他~", 1250, 0, "捕快")

			JY.Person[0].官阶 = 0

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		else
			say("是你？你还敢到官衙来！来人啊，抓住这个逆贼~", 1250, 0, "捕快")

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		end
	elseif JY.Person[0].官阶 >= 5 then
		say("大人。", 1250, 0, "捕快")
		say("最近怎么样？没有麻烦吧。", 0, 1)
		say("回大人，一切安好。", 1250, 0, "捕快")
	elseif JY.Person[0].官阶 == 1 then
		say("怎么才来，先生已经开讲了，赶快进去。", 1250, 0, "捕快")
		My_Enter_SubScene(128, 23, 49, 2)
		dark()
		light()
		say("好了，今天的课就讲到这里，回去好好温习，今天的重点默100遍。明天交来。", 1235, 0, "学正大人")
		say("是。", 1128, 1, "众学子")
		dark()
		light()
		My_Enter_SubScene(128, 30, 52, 1)
		say("书山有路勤为径，学海无涯苦作舟。我一定要努力。", 0, 1)
		say("先回家吃饭吧。", 0, 1)
		addtime(3)

		if JY.Person[0].儒学修为 < 50 then
			JY.Person[0].儒学修为 = JY.Person[0].儒学修为 + 1
		end
	elseif JY.Person[0].官阶 == 2 then
		say("小秀才，先生已经开讲了，赶快进去吧。", 1250, 0, "捕快")
		My_Enter_SubScene(128, 23, 49, 2)
		dark()
		light()
		say("好了，今天的课就讲到这里，回去好好温习，今天的重点默100遍。明天交来。", 1235, 0, "学正大人")
		say("是。", 1128, 1, "众学子")
		dark()
		light()
		My_Enter_SubScene(128, 30, 52, 1)
		say("书山有路勤为径，学海无涯苦作舟。我一定要努力。", 0, 1)
		addtime(10)

		if JY.Person[0].儒学修为 < 80 and JY.Person[0].悟性 > 60 then
			JY.Person[0].儒学修为 = JY.Person[0].儒学修为 + 1
		end
	elseif JY.Person[0].官阶 == 3 then
		say("大人，先生已经开讲了，请进去吧。", 1250, 0, "捕快")
		My_Enter_SubScene(128, 23, 49, 2)
		dark()
		light()
		say("好了，今天的课就讲到这里，回去好好温习，今天的重点默100遍。明天交来。", 1235, 0, "学正大人")
		say("是。", 1128, 1, "众学子")
		dark()
		light()
		My_Enter_SubScene(128, 30, 52, 1)
		say("这书得念到什么时候啊，我胡子都长出来了。", 0, 1)
		addtime(30)

		if JY.Person[0].儒学修为 < 100 and JY.Person[0].悟性 > 80 then
			JY.Person[0].儒学修为 = JY.Person[0].儒学修为 + 1
		end
	elseif JY.Person[0].官阶 == 4 then
		say("大人，先生说了，他的学问不足以教导你了，你要自去寻求路径。", 1250, 0, "捕快")
		say("路径？先生不说寻求学识，而说路径，先生果是智慧之人。", 0, 1)
	else
		say("府学重地，无关人等速速离开。", 1250, 0, "捕快")
		say("我不能进去学习吗？", 0, 1)
		say("只有功名在身之学子，或有名士大儒举荐之人方可进入府学学习。", 1250, 0, "捕快")
	end
end
OEVENTLUA[12803] = function ()
	Cls()
	say("啊啊，坏人来了，坏人来了，我苦命的孩儿，快躲起来，躲起来。", 258, 0, "阿四嫂")
	say("什么坏人？", 0, 1)
	say("快躲起来，躲起来。", 258, 0, "阿四嫂")
	say("大嫂，有什么坏人，你说是谁，我帮你处理。", 0, 1)
	say("啊啊，坏人来了，坏人来了，我苦命的孩儿，快躲起来，躲起来。", 258, 0, "阿四嫂")
	say("......", 0, 1)
end
OEVENTLUA[12804] = function ()
	Cls()

	local var_478_0 = math.random(3)
	local var_478_1 = math.random(30)

	say("福威镖局招聘趟子手！走一次镖500两白银，这位少侠，可有兴趣？", 1137, 0, "镖师")

	if yesno("要报名么？") == true then
		say("好，我们出发。", 1137, 0, "镖师")
		say("这么快？", 0, 1)
		say("这次是急镖，要不也不会急着招人了。", 1137, 0, "镖师")
		say("走吧。", 1137, 0, "镖师")
		dark()
		ChangeSMap(126, 28, 32, 2)
		addevent(126, 150, 1, -2, 1, 8626, 26, 32)
		light()

		if var_478_0 == 1 then
			say("倒霉，刚出门就遇到劫匪了。", 1137, 0, "镖师")
			say("是哪路英雄好汉在此办事？这是我们福威镖局孝敬大伙儿的银子，望大伙儿给个面子！", 1137, 0, "镖师")
			say("少废话，大伙儿都饿了好几天了，今天不能给面子。", 1035, 0, "强盗")
			say("没办法了，趟子手，给我冲~。", 1137, 0, "镖师")
			say("后路的镖师，押着镖银后撤。", 1137, 0, "镖师")

			if WarMain(336, 0, 1, 1) == false then
				instruct_15()

				return
			end

			say(JY.Person[0].称呼 .. "，做得好！这是你的报酬，记得要挣钱下次还来找我啊！", 1137, 0, "镖师")
			addthing(174, 550)
			addtime(5)
		else
			say("一路都很顺利，运气不错啊。", 1137, 0, "镖师")
			say(JY.Person[0].称呼 .. "，这是你的报酬，记得要挣钱下次还来找我啊！", 1137, 0, "镖师")
			addthing(174, 500)
			addtime(5)
		end

		instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

		JY.Base.人X = JY.Base.人X + var_478_1
		JY.Base.人Y = JY.Base.人Y - var_478_1

		ReturnMMap()
	else
		say("在林总镖头的带领下，我们福威镖局是越来越兴旺了。", 1137, 0, "镖师")
		say("作为福威镖局的镖师，最重要的就是多和各路英雄搞好关系。", 1137, 0, "镖师")
	end
end
OEVENTLUA[12805] = function ()
	Cls()
	say("听说又有人在西北方的密林里被狼咬死了。", 338, 0, "酒客1")
	say("真是可怜，最近那儿可死了好几个人了，就没人管管吗？", 254, 0, "酒客2")
	say("谁愿意冒险去啊，又没啥好处。", 338, 0, "酒客1")
	say("哎，只不知道有哪个壮士愿意出马，去杀退这些恶狼。", 338, 0, "酒客1")
end
OEVENTLUA[12806] = function ()
	Cls()

	local var_480_0 = 0
	local var_480_1 = JY.Person[727].好感度 >= 60 and "金狗" or "元狗"

	if JY.Person[706].好感度 >= 60 or JY.Person[727].好感度 >= 60 then
		if JY.Person[706].好感度 >= 100 or JY.Person[727].好感度 >= 100 then
			say("听说武圣星君下凡了，要杀尽" .. var_480_1 .. "，恢复我华夏盛世。", math.random(1137, 1142), 0, "酒客")
			say("我也听说了，据说杀了很多" .. var_480_1 .. "大将，" .. var_480_1 .. "已经快支持不住了。", math.random(1130, 1136), 0, "酒客")
		else
			say("前几天老张家被抄了，说是有人告密老张与叛军有来往，可恶，咱们白雪帮的堂主就这么稀里糊涂的死了。", math.random(1130, 1136), 0, "酒客")
			say("可恶的" .. var_480_1 .. "，希望连云寨的好汉把他们都杀光。", math.random(1137, 1142), 0, "酒客")
		end
	elseif JY.Person[0].宋罪恶值 > 970 and JY.Person[0].门派 == 21 and JY.Person[0].门派等级 == 25 then
		say("听说皇帝被一个什么野狗帮的帮主杀死了。", math.random(1130, 1136), 0, "酒客")
		say("怎么可能？那可是皇帝，什么人能够杀他。", math.random(1137, 1142), 0, "酒客")
		say("听说是在朝会上杀的，那个什么野狗帮主杀了皇帝，又打跑了皇宫禁卫，一路杀出了临安城，真是绝代凶人啊。", math.random(1130, 1136), 0, "酒客")
		say("凶星降世，这是祸乱之兆啊，天下大乱不远已。", math.random(1137, 1142), 0, "酒客")
	else
		say("我常听师父说，这福威镖局*的辟邪剑谱十分厉害。", 254, 0, "酒客2")
		say("可不就是，当年的辟邪剑客可是打败天下无敌手，一直到现在都无人敢惹啊。", 338, 0, "酒客1")
	end
end
OEVENTLUA[12807] = function ()
	Cls()
	say("福威镖局开展多项服务，这位少侠，可有需要？", 1137, 0, "镖师")
	say("单人挑战一次10两银子，多人群战陪练一次50两银子。", 1137, 0, "镖师")
	say("雇佣保镖从雇佣之日月付薪金。", 1137, 0, "镖师")

	if yesno("要看看么？") == true then
		local var_481_0 = JYMsgBox("请选择", "你想要的陪练或保镖服务", {
			"单挑",
			"群战",
			"雇佣保镖"
		}, 3, 1115, 1)

		if var_481_0 == 1 then
			if instruct_31(10) == false then
				say("少侠，你的银子不够啊。", 1137, 0, "镖师")

				return
			end

			WarMain(569, 0)
			addthing(174, -10)
		elseif var_481_0 == 2 then
			if instruct_31(50) == false then
				say("少侠，你的银子不够啊。", 1137, 0, "镖师")

				return
			end

			WarMain(570, 0)
			addthing(174, -50)
		elseif var_481_0 == 3 then
			say("你要雇佣哪位镖师？", 1137, 0, "镖师")

			local var_481_1 = {
				{
					"------------可以雇佣的人手-----------",
					nil,
					1
				},
				{
					"镖师张海：江湖人称血手张海，擅使一门修罗刀，州府罕有敌手",
					nil,
					1
				},
				{
					"镖师贺老汉：江湖人称贺棒棒，曾一棒打死猛虎，威名远扬",
					nil,
					1
				},
				{
					"镖师罗中枢：江湖人称一门中枢，擅使暗器，敌人防不胜防",
					nil,
					1
				},
				{
					"趟子手张加：擅使地趟刀法",
					nil,
					1
				},
				{
					"趟子手李免：擅使地趟刀法",
					nil,
					1
				},
				{
					"趟子手王麻：擅使地趟刀法",
					nil,
					1
				}
			}

			if JY.Person[647].佛学修为 == 1 then
				var_481_1[2][3] = 0
			end

			if JY.Person[648].佛学修为 == 1 then
				var_481_1[3][3] = 0
			end

			if JY.Person[649].佛学修为 == 1 then
				var_481_1[4][3] = 0
			end

			if JY.Person[650].佛学修为 == 1 then
				var_481_1[5][3] = 0
			end

			if JY.Person[651].佛学修为 == 1 then
				var_481_1[6][3] = 0
			end

			if JY.Person[652].佛学修为 == 1 then
				var_481_1[7][3] = 0
			end

			local var_481_2 = 50
			local var_481_3 = 30
			local var_481_4 = var_481_3 * var_481_2 / 2 + 2 * CC.MenuBorderPixel
			local var_481_5 = var_481_3 + 2 * CC.MenuBorderPixel
			local var_481_6 = -1
			local var_481_7 = -1
			local var_481_8 = ShowMenu(var_481_1, #var_481_1, 0, CC.MainSubMenuX, CC.MainSubMenuY + 100, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

			if var_481_8 == 1 then
				-- Nothing
			elseif var_481_8 == 2 then
				say("镖师张海，月薪950两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(950) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -950)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_9 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_10 = ShowMenu(var_481_9, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_10 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 647
					elseif var_481_10 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 647
					elseif var_481_10 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 647
					end

					JY.Person[647].姓名 = "镖师张海"
					JY.Person[647].头像代号 = 227
					JY.Person[647].生命 = 430
					JY.Person[647].生命最大值 = 430
					JY.Person[647].内力 = 1200
					JY.Person[647].内力最大值 = 1200
					JY.Person[647].攻击力 = 180
					JY.Person[647].防御力 = 200
					JY.Person[647].轻功 = 200
					JY.Person[647].耍刀技巧 = 40
					JY.Person[647].武功1 = 58
					JY.Person[647].武功等级1 = 999
					JY.Person[647].儒学修为 = JY.DAY
					JY.Person[647].盗贼技巧 = 950
					JY.Person[647].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			elseif var_481_8 == 3 then
				say("镖师贺老汉，月薪900两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(900) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -900)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_11 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_12 = ShowMenu(var_481_11, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_12 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 648
					elseif var_481_12 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 648
					elseif var_481_12 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 648
					end

					JY.Person[648].姓名 = "镖师贺老汉"
					JY.Person[648].头像代号 = 227
					JY.Person[648].生命 = 450
					JY.Person[648].生命最大值 = 450
					JY.Person[648].内力 = 1300
					JY.Person[648].内力最大值 = 1300
					JY.Person[648].攻击力 = 180
					JY.Person[648].防御力 = 200
					JY.Person[648].轻功 = 200
					JY.Person[648].特殊兵器 = 50
					JY.Person[648].武功1 = 179
					JY.Person[648].武功等级1 = 999
					JY.Person[648].儒学修为 = JY.DAY
					JY.Person[648].盗贼技巧 = 900
					JY.Person[648].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			elseif var_481_8 == 4 then
				say("镖师罗中枢，月薪900两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(900) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -900)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_13 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_14 = ShowMenu(var_481_13, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_14 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 649
					elseif var_481_14 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 649
					elseif var_481_14 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 649
					end

					JY.Person[649].姓名 = "镖师罗中枢"
					JY.Person[649].头像代号 = 227
					JY.Person[649].生命 = 400
					JY.Person[649].生命最大值 = 400
					JY.Person[649].内力 = 1300
					JY.Person[649].内力最大值 = 1300
					JY.Person[649].攻击力 = 180
					JY.Person[649].防御力 = 200
					JY.Person[649].轻功 = 200
					JY.Person[649].暗器技巧 = 50
					JY.Person[649].武功1 = 188
					JY.Person[649].武功等级1 = 999
					JY.Person[649].儒学修为 = JY.DAY
					JY.Person[649].盗贼技巧 = 900
					JY.Person[649].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			elseif var_481_8 == 5 then
				say("趟子手张加，月薪200两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(200) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -200)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_15 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_16 = ShowMenu(var_481_15, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_16 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 650
					elseif var_481_16 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 650
					elseif var_481_16 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 650
					end

					JY.Person[650].姓名 = "趟子手张加"
					JY.Person[650].头像代号 = 227
					JY.Person[650].生命 = 200
					JY.Person[650].生命最大值 = 200
					JY.Person[650].内力 = 500
					JY.Person[650].内力最大值 = 500
					JY.Person[650].攻击力 = 60
					JY.Person[650].防御力 = 80
					JY.Person[650].轻功 = 70
					JY.Person[650].耍刀技巧 = 25
					JY.Person[650].武功1 = 174
					JY.Person[650].武功等级1 = 500
					JY.Person[650].儒学修为 = JY.DAY
					JY.Person[650].盗贼技巧 = 900
					JY.Person[650].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			elseif var_481_8 == 6 then
				say("趟子手李免，月薪200两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(200) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -200)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_17 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_18 = ShowMenu(var_481_17, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_18 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 651
					elseif var_481_18 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 651
					elseif var_481_18 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 651
					end

					JY.Person[651].姓名 = "趟子手李免"
					JY.Person[651].头像代号 = 227
					JY.Person[651].生命 = 200
					JY.Person[651].生命最大值 = 200
					JY.Person[651].内力 = 500
					JY.Person[651].内力最大值 = 500
					JY.Person[651].攻击力 = 60
					JY.Person[651].防御力 = 80
					JY.Person[651].轻功 = 70
					JY.Person[651].耍刀技巧 = 25
					JY.Person[651].武功1 = 174
					JY.Person[651].武功等级1 = 500
					JY.Person[651].儒学修为 = JY.DAY
					JY.Person[651].盗贼技巧 = 900
					JY.Person[651].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			elseif var_481_8 == 7 then
				say("趟子手王麻，月薪200两银子。", 1137, 0, "镖师")

				if yesno("要雇佣吗？") then
					if instruct_31(200) == false then
						say("客人你银子不够啊。", 1137, 0, "镖师")

						return
					end

					addthing(174, -200)
					DrawStrBox(-1, -1, "给你的护卫选一个位置", C_WHITE, var_481_3)

					local var_481_19 = {
						{
							"第一护卫",
							nil,
							1
						},
						{
							"第二护卫",
							nil,
							2
						},
						{
							"第三护卫",
							nil,
							3
						}
					}
					local var_481_20 = ShowMenu(var_481_19, 3, 0, var_481_6 + var_481_4 - 4 * var_481_3 - 2 * CC.MenuBorderPixel, var_481_7 + var_481_5 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

					if var_481_20 == 1 then
						if JY.Base.佣兵1 > 0 then
							JY.Person[JY.Base.佣兵1].佛学修为 = 0
						end

						JY.Base.佣兵1 = 652
					elseif var_481_20 == 2 then
						if JY.Base.佣兵2 > 0 then
							JY.Person[JY.Base.佣兵2].佛学修为 = 0
						end

						JY.Base.佣兵2 = 652
					elseif var_481_20 == 3 then
						if JY.Base.佣兵3 > 0 then
							JY.Person[JY.Base.佣兵3].佛学修为 = 0
						end

						JY.Base.佣兵3 = 652
					end

					JY.Person[652].姓名 = "趟子手王麻"
					JY.Person[652].头像代号 = 227
					JY.Person[652].生命 = 200
					JY.Person[652].生命最大值 = 200
					JY.Person[652].内力 = 500
					JY.Person[652].内力最大值 = 500
					JY.Person[652].攻击力 = 60
					JY.Person[652].防御力 = 80
					JY.Person[652].轻功 = 70
					JY.Person[652].耍刀技巧 = 25
					JY.Person[652].武功1 = 174
					JY.Person[652].武功等级1 = 500
					JY.Person[652].儒学修为 = JY.DAY
					JY.Person[652].盗贼技巧 = 900
					JY.Person[652].佛学修为 = 1
				else
					say("没关系，你再多看看也好。", 1137, 0, "镖师")
				end
			end
		end

		say("多谢少侠光临服务，下次再来啊。", 1137, 0, "镖师")
	else
		say("我福威镖局业务广泛，少侠多多捧场啊。", 1137, 0, "镖师")
	end
end
OEVENTLUA[12808] = function ()
	Cls()

	local var_482_0 = 0
	local var_482_1 = JY.Person[0].性别 == 1 and "小姐" or "小少爷"

	say("哎，我那苦命的孩儿，也不知道现在过得怎么样了。", 1118, 0, "夫人")
	say("夫人不用担心，" .. var_482_1 .. "好人有好福，说不定在哪个富贵人家里过着好日子呢。", 1110, 0, "丫鬟")
end
OEVENTLUA[12809] = function ()
	Cls()

	local var_483_0 = Rnd(3)

	if var_483_0 == 1 then
		say("后天史老英雄给孙儿庆百日诞辰，我得准备些礼物才好。", 1141, 0, "林震南")
	elseif var_483_0 == 2 then
		say("大后天连老英雄给儿子庆考中秀才，我得准备些礼物才好。", 1141, 0, "林震南")
	else
		say("下个月华老英雄娶第十一房姨太，我得准备些礼物才好。", 1141, 0, "林震南")
	end
end
OEVENTLUA[12810] = function ()
	Cls()

	if JY.Person[0].宋罪恶值 >= 970 then
		if JY.Person[0].官阶 > 0 and JY.Person[0].官阶 < 7 then
			say("是你？你还敢到官衙来！你的事犯了，已经被去官离职，来人啊，抓住他~", 1250, 0, "捕快")

			JY.Person[0].官阶 = 0

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		else
			say("是你？你还敢到官衙来！来人啊，抓住这个逆贼~", 1250, 0, "捕快")

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		end
	elseif JY.Person[0].官阶 > 5 then
		say("参见大人。", 1250, 0, "捕快")
		say("唔，今天有鸣冤的没有？", 0, 1)
		say("回大人，今天还没有人前来。", 1250, 0, "捕快")
		say("唔，怎么还是没有人来？", 0, 1)
		say("...", 1250, 0, "捕快")
	elseif JY.Person[0].官阶 == 5 then
		say("参见大人。", 1250, 0, "捕快")
	else
		say("官府重地，赶快离开。", 1250, 0, "捕快")
	end
end
OEVENTLUA[12811] = function ()
	Cls()

	if JY.Base.畅想编号 == 36 then
		instruct_17(128, 1, 11, 4, 0)
	end
end
OEVENTLUA[12812] = function ()
	Cls()

	if JY.Person[0].宋罪恶值 >= 970 then
		if JY.Person[0].官阶 > 0 and JY.Person[0].官阶 < 7 then
			say("是你？你还敢到官衙来！你的事犯了，已经被去官离职，来人啊，抓住他~", 1250, 0, "捕快")

			JY.Person[0].官阶 = 0

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		else
			say("是你？你还敢到官衙来！来人啊，抓住这个逆贼~", 1250, 0, "捕快")

			if WarMain(514, 0, 1, 1) == false then
				instruct_15(0)
				instruct_0()

				return
			end

			say("还敢反抗，快叫驻防官军过来~", 1250, 0, "捕快")
			say("真是麻烦啊，还是不要硬闯好了。", 0, 1)
			dark()
			My_Enter_SubScene(128, 53, 33, 1)
			light()

			return
		end
	elseif JY.Person[0].官阶 >= 5 then
		say("参见大人。", 1250, 0, "捕快")
		say("这儿不用你值守了，忙别的去吧。", 0, 1)
		say("是，大人。", 1250, 0, "捕快")
		null(128, 130)
	else
		say("官府重地，赶快离开。", 1250, 0, "捕快")
	end
end
OEVENTLUA[12813] = function ()
	Cls()
	say("听说前主人犯事了，官府低价把这房屋卖给了我。", 1260, 0, "老人")
	say("我真是捡了老大一个便宜。", 1260, 0, "老人")

	if inteam(36) then
		say("谁说的犯事了？我就是这家的主人。", 36, 0, "林平之")
		say("这房屋已经卖给了我，我是有房契的。", 1260, 0, "老人")
		say("可恶。我高价买回来如何？", 36, 0, "林平之")
		say("不卖，这地段多好，我还等着它升值呢。", 1260, 0, "老人")
	end
end
OEVENTLUA[12814] = function ()
	Cls()
	say("州府学衙门前禁止吵闹", 0, 2)
	say("下面为官府大考之日期：", 0, 2)
	say("秀才考试，双月月初2-4号", 0, 2)
	say("举人考试，3月，7月，11月，月中15-17号", 0, 2)
	say("进士考试，5月月尾28-30号", 0, 2)
end
OEVENTLUA[12815] = function ()
	Cls()
	say("州府学衙名人录：", 0, 2)
	say("---,---,---,于仁宗5年考中进士，得皇上召见，现俱任府州大员要职", 0, 2)
	say("---,---,于仁宗12年考中进士，得皇上召见，现俱任大理寺要职", 0, 2)
	say("---,---,于仁宗21年考中进士，得皇上召见，现俱任府州大员要职", 0, 2)
	say("福州学员共勉之", 0, 2)
end
OEVENTLUA[12816] = function ()
	Cls()

	local var_490_0 = Rnd(3)

	if var_490_0 == 1 then
		say("每天都是这么多的文案要做，好累啊。", 1079, 0, "同知")
	elseif var_490_0 == 2 then
		say("年轻人，十年前我也是新中的进士，还得圣上召见。你见到圣上了吗？", 1141, 0, "同知")
	else
		say("什么时候能够外放出去啊？我十年寒窗，是为了造福一方，现在还在这儿呆着，真是造化弄人。", 1043, 0, "同知")
	end
end
OEVENTLUA[12817] = function ()
	Cls()
	say("佛学？且先看看", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "佛学修为", 2)
	DrawStrBoxWaitKey("你的佛学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 146)
end
OEVENTLUA[12821] = function ()
	Cls()
	say("最近南海海寇时常劫持商船，我想雇佣几个高手出海，看少侠你仪表堂堂，英武不凡，不似常人，不知可愿护送我去台湾岛，我愿意出高薪。", 1023, 0, "批发商人")

	if yesno("是否护送老人出海？") then
		say("没有问题，我正想出海转转。", 0, 1)
		say("好，那我们出发吧。", 1023, 0, "批发商人")
		null(-2, 18)
		say("老人随队行动，请尽快赶至台湾岛", 0, 2)
		addevent(76, 13, 1, 12822, 1, 10398, -2, -2)
	else
		say("不行，我没有时间。", 0, 1)
		say("可惜。", 1023, 0, "批发商人")
	end
end
OEVENTLUA[12822] = function ()
	Cls()
	dark()
	addevent(76, 15, 1, -2, 1, 10178, -2, -2)
	light()
	say("郑老弟啊，我终于找到你了。", 1023, 0, "批发商人")
	say("梁老哥，多年不见，一向可好？", 1235, 1, "老人")
	say("好，好，少侠，我已经找到郑老弟了，多谢你一路护送，这些谢礼不成敬意。", 1023, 0, "批发商人")
	addthing(174, 500)
	say("郑老弟，这次来找你是有要事商量，咱们找个安静的地方详谈可好？", 1023, 0, "批发商人")
	say("好，好，梁老哥，你随我来。", 1235, 1, "老人")
	dark()
	null(-2, 13)
	null(-2, 15)
	addevent(128, 18, 1, 12825, 1, 10076, -2, -2)
	light()
end
OEVENTLUA[12825] = function ()
	Cls()

	if has_thing(333) == true then
		say("少侠，你这紅景天质量不错，我出1200两银子一箱买进怎么样？", 1023, 0, "批发商人")

		if yesno("要卖出紅景天吗？") then
			say("好。", 0, 1)

			local var_494_0 = InputNum("卖出数量", 1, 25, 1)

			if var_494_0 == nil then
				say("客人，你不卖就算了，本店也瞧不上你这么点货。", 1023, 0, "批发商人")
			elseif has_something(333, var_494_0) == false then
				say("客人，你这数目不对啊，麻烦你再检查一下。", 1023, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, 1200 * var_494_0)
				instruct_32(333, -var_494_0)
				say("合作愉快，下次再来啊。", 1023, 0, "批发商人")
			end
		end
	else
		say("龍涎香批发，一箱香料3000两银子，少侠要不要进一些货。", 1023, 0, "批发商人")

		if yesno("要买进一些龍涎香吗？") then
			local var_494_1 = InputNum("卖出数量", 1, 10, 1)

			if var_494_1 == nil then
				say("客人，你再多看看，本店都是精选好货。", 1023, 0, "批发商人")

				return
			elseif instruct_31(3000 * var_494_1) == false then
				say("非常抱歉，*你身上的钱似乎不够。", 1023, 0, "批发商人")

				return
			else
				instruct_32(CC.MoneyID, -3000 * var_494_1)
				instruct_32(331, var_494_1)
				say("上好的龍涎香，少侠你收好。", 1023, 0, "批发商人")
			end
		end
	end
end
OEVENTLUA[12826] = function ()
	Cls()
	say("肖大哥，你又送来这么多东西，如何使得？", 1027, 0, "阿庆哥")
	say("有什么使不得的，阿庆嫂病了这么久，你们入不敷出的，邻里邻居的，我还能不帮衬一下啊。", 1038, 1, "肖大哥")
	say("只是每月都叫你破费，小弟过意不去啊。", 1027, 0, "阿庆哥")
	say("和我还客气啥，我店里还要忙，有事你招呼我啊。", 1038, 1, "肖大哥")
	say("谢谢肖大哥，谢谢肖大哥。", 1027, 0, "阿庆哥")
	dark()
	null(-2, 13)
	light()
	say("哎，这日子没法过了。", 1027, 0, "阿庆哥")
	dark()
	null(-2, 12)
	light()
end
OEVENTLUA[12827] = function ()
	Cls()
	dark()
	null(-2, 48)
	null(128, 12)
	null(128, 13)
	light()
	say("阿庆哥，为什么？为什么你要害我？", 1038, 1, "肖大哥")
	say("为什么？你不知道？还装傻？", 1027, 0, "阿庆哥")
	say("你？", 1038, 1, "肖大哥")
	say("事到如今，我就和你说个明白。", 1027, 0, "阿庆哥")
	say("你看我们家里穷，这些年总是给我们送东西是吧？可是你每次就是送一点，有什么用？", 1027, 0, "阿庆哥")
	say("什么？你？", 1038, 1, "肖大哥")
	say("你什么？你家那么有钱，就是给我个几千两银子也不算什么，你却舍不得给，每次就给一点点，搞得我下个月没有吃的，还得求你，你说你装什么善人？", 1027, 0, "阿庆哥")
	say("我，我是看你们过不下去，真心想帮你。", 1038, 1, "肖大哥")
	say("这且不说，你为什么从年前就不给我们送东西了？是不是觉得饿死我们最好，看我们腻味了？", 1027, 0, "阿庆哥")
	say("没有，是我生意失败了，家里没钱了。", 1038, 1, "肖大哥")
	say("撒谎，那前天遇到桥大哥的时候，你身上那五千两银子是什么？想骗我？", 1027, 0, "阿庆哥")
	say("那，那是我借的钱，我想冒险去西域进些香料，把钱挣回来。", 1038, 1, "肖大哥")
	say("哼，谁知道你说的真的假的？", 1027, 0, "阿庆哥")
	say("真的，你快把解药给我服下，要不来不及了。", 1038, 1, "肖大哥")
	say("哪有解药？我那天问桥老大要毒药的时候根本就没有要解药，你就安心的去吧。", 1027, 0, "阿庆哥")
	say("你，你~", 1038, 1, "肖大哥")
	say("真是个小人。", 0, 1)
	say("什么人？", 1027, 0, "阿庆哥")
	instruct_30(29, 4, 31, 4)
	instruct_40(0)
	say("你都听到了？", 1027, 0, "阿庆哥")
	say("若要人不知，除非己莫为。", 0, 1)
	say("啊？大侠饶命啊。我一时犯了糊涂，还请不要报官，我愿意将银两全部献给大侠。", 1027, 0, "阿庆哥")

	if yesno("要饶此人性命吗？") then
		say("好，钱拿来。", 0, 1)
		say("是，是。", 1027, 0, "阿庆哥")
		addthing(174, 300)
		say("滚。", 0, 1)
		say("是，是。", 1027, 0, "阿庆哥")
		dark()
		null(-2, 47)
		light()
		say("你将他放了？", 1038, 0, "肖大哥")
		say("不错。人不为己天诛地灭，你现在明白了？", 0, 1)
		say("不，不是这样的。噗~", 1038, 0, "肖大哥")
		addevent(61, 46, 1, -2, 1, 10236, -2, -2)
		say("非要在我在的时候死，真是麻烦。", 0, 1)
		dark()
		null(-2, 46)
		light()
	else
		say("你这等小人，不杀你我心意不畅快。", 0, 1)
		say("死！", 0, 1)
		say("啊~", 1027, 0, "阿庆哥")
		addevent(61, 47, 1, -2, 1, 10214, -2, -2)
		say("该杀，枉我之前一直帮他。", 1038, 0, "肖大哥")
		say("我看看你中的什么毒？", 0, 1)
		dark()
		light()
		say("好了，你没事了。", 0, 1)
		say("多谢大侠救命之恩。", 1038, 0, "肖大哥")
		say("无妨，你以后有什么打算？", 0, 1)
		say("这个阿庆之前和强盗勾结，抢了我的货物，他身上有分润的银两，虽然不多，但也够我再去西域进一点货物了。", 1038, 0, "肖大哥")
		say("如此也好。", 0, 1)
		say("那个桥老大是什么人？", 0, 1)
		say("他是太行山的土匪头子，最是阴狠狡诈。", 1038, 0, "肖大哥")
		say("你能从他手里逃得性命，运气也是不错。", 0, 1)
		say("本来我是死定了的，不过桥老大收到消息，说是华山发现了上古洞府，他就急急忙忙赶去，顾不上我这等小人物了。", 1038, 0, "肖大哥")
		say("上古洞府？", 0, 1)
		say("似乎是广成子的洞府，也不知道真的假的。", 1038, 0, "肖大哥")
		say("广成子？", 0, 1)
		say("不管真的假的，看看去无妨。", 0, 1)
		say("你自行去吧，自己小心。", 0, 1)
		say("是，多谢少侠，这是我在苗疆得到的丹药，就送给少侠了。", 1038, 0, "肖大哥")
		addthing(347, 5)
		dark()
		null(-2, 47)
		null(-2, 46)
		addevent(111, 47, 1, 11114, 1, 9062, -2, -2)
		null(111, 1)
		light()
		instruct_37(2)
	end
end
OEVENTLUA[13001] = function ()
	Cls()
	dark()
	My_Enter_SubScene(28, 2, 41, 1)
	light()
end
OEVENTLUA[13002] = function ()
	Cls()

	if JY.Person[0].拳掌功夫 == 299 and JY.Person[0].实战 >= 1000 then
		say("隐映连青壁，嵯峨向碧空。好山，好山。", 0, 1)
		say("哈哈哈~哈哈哈~", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(1, 3)

		JY.Person[0].拳掌功夫 = 300
	else
		say("独背焦桐访洞天，暂攀灵迹弃尘缘。深逢野草皆疑药，静见樵人恐是仙。", 0, 1)
		say("好山，好山。", 0, 1)
	end
end
OEVENTLUA[13201] = function ()
	Cls()
	say("这是...", 0, 1)
	addthing(214, 1)
	null(132, 0)
end
OEVENTLUA[13202] = function ()
	Cls()
	say("汉猪，这不是你来的地方，赶快离开。", 1160, 0, "西夏武士")
end
OEVENTLUA[13203] = function ()
	Cls()
	say("西夏皇宫，不要乱闯。", 1160, 0, "西夏武士")
end
OEVENTLUA[13204] = function ()
	Cls()
	say("我们要多练习汉人的武艺，总有一天能够进入一品堂，从此成为真正的勇士。", 1160, 0, "西夏武士")
end
OEVENTLUA[13205] = function ()
	Cls()
	say("这是？居然有儒学书籍？看看先。", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 37)
end
OEVENTLUA[13206] = function ()
	Cls()
	say("这是？居然有儒学书籍？看看先。", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "儒学修为", 5)
	DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 38)
end
OEVENTLUA[13207] = function ()
	Cls()

	if has_something(324, 10) then
		say("快走快走，主上下令，不允许将奴隶卖给汉人了。", 1074, 0, "金兵")
		say("为什么？", 0, 1)
		say("可恶的汉人，偷偷将奴隶运送回南朝，主上大怒，连郝连将军都受了责罚，谁还敢卖的？就地处死。", 1074, 0, "金兵")
		say("...", 0, 1)
		say("还不走？快滚！", 1074, 0, "金兵")

		return
	end

	say("要汉人奴隶吗？20两银子一个，汉人买的话，一次最少100个。", 1160, 0, "西夏武士")

	if yesno("要买奴隶吗？") then
		say("买。", 0, 1)
		say("一个奴隶20两，一批100个共2000两，拿来吧。", 1160, 0, "西夏武士")

		if instruct_31(2000) == false then
			say("钱不够。", 1160, 0, "西夏武士")
			say("...", 0, 1)

			return
		end

		instruct_32(174, -2000)
		dark()
		light()
		say("一批奴隶跟随了你", 0, 2)

		JY.Person[740].好感度 = JY.Person[740].好感度 - 1
	else
		say("我？不买。", 0, 1)
		say("不买？汉猪，滚开。", 1160, 0, "西夏武士")
	end
end
OEVENTLUA[13301] = function ()
	Cls()

	if JY.Person[0].特殊兵器 == 299 and JY.Person[0].实战 >= 1000 then
		say("怎么总感觉有寒气在周围，好奇诡的地方。", 0, 1)
		say("唔？~哈哈哈~", 0, 1)
		say("你只感觉以前的关隘豁然开朗。", 0, 2)
		write_nump(4, 3)

		JY.Person[0].特殊兵器 = 300
	else
		say("断肠人 在天涯。", 0, 1)
		say("好凄凉，好凄凉。", 0, 1)
	end
end
OEVENTLUA[13302] = function ()
	Cls()
	say("古藤老树昏鸦，小桥流水人家，断肠人 在天涯", 1135, 0, "四弟子")
end
OEVENTLUA[13303] = function ()
	Cls()
	say("年轻人，你可以在我这里多待待，外面红尘纷乱，在我这里可以静心研究学问。", 360, 0, "隐士")
end
OEVENTLUA[13304] = function ()
	Cls()
	say("历史都不可信，都是胜利者杜撰的。", 1008, 0, "三弟子")
end
OEVENTLUA[13305] = function ()
	Cls()
	say("年轻人，让我看看你的面相。", 263, 0, "二弟子")
	say("...", 0, 1)
	say("奇怪，奇怪，时而枭雄，时而帝王，时而草寇，这...，怎么可能？", 263, 0, "二弟子")
end
OEVENTLUA[13306] = function ()
	Cls()
	say("人徒知枯坐息思为进德之功，殊不知上达之士，圆通定慧，体用双修，即静而动，虽撄而宁。", 366, 0, "大弟子")
	say("...(虽然听不懂，但似乎是极为高深的东西。)", 0, 1)
end
OEVENTLUA[13307] = function ()
	Cls()
	say("这么多武学书籍，我得好好看看。", 0, 1)
	dark()
	light()
	addtime(5)
	AddPersonAttrib(0, "武学常识", 5)
	DrawStrBoxWaitKey("你的武学常识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 22)
end
OEVENTLUA[13308] = function ()
	Cls()
	say("这个是？《伤寒杂病论》？", 0, 1)

	if JY.Person[0].医疗能力 >= 20 then
		dark()
		light()
		addtime(10)
		AddPersonAttrib(0, "医疗能力", 5)
		DrawStrBoxWaitKey("你的医疗能力增加了", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 24)
	else
		say("这都什么啊？完全看不懂啊。", 0, 1)
	end
end
OEVENTLUA[13309] = function ()
	Cls()
	say("这么多书，我得好好看看。", 0, 1)
	dark()
	light()
	addtime(10)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "阵法知识", 5)
	DrawStrBoxWaitKey("你的阵法知识增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 23)
end
OEVENTLUA[13310] = function ()
	Cls()
	say("这是？先秦时的古籍？居然保存至今。", 0, 1)

	if JY.Person[0].儒学修为 >= 50 then
		dark()
		light()
		addtime(20)
		AddPersonAttrib(0, "儒学修为", 5)
		DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
		say("果然是大有收获。", 0, 1)
		AddPersonAttrib(0, "悟性", 1)
		DrawStrBoxWaitKey("你遍阅诸子百家典籍，你的悟性增加了1", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 25)
	else
		say("可惜，我看不明白。", 0, 1)
	end
end
OEVENTLUA[13311] = function ()
	Cls()
	say("这是？诸子百家，果然深奥。", 0, 1)

	if JY.Person[0].儒学修为 >= 70 then
		dark()
		light()
		addtime(20)
		AddPersonAttrib(0, "儒学修为", 5)
		DrawStrBoxWaitKey("你的儒学修为增加了", C_ORANGE, CC.DefaultFont, 2)
		say("果然是大有收获。", 0, 1)
		AddPersonAttrib(0, "悟性", 1)
		DrawStrBoxWaitKey("你遍阅诸子百家典籍，你的悟性增加了1", C_ORANGE, CC.DefaultFont, 2)
		null(-2, 26)
	else
		say("可惜，我看不明白。", 0, 1)
	end
end
OEVENTLUA[13312] = function ()
	Cls()
	say("这是？居然还有机关学？难道是班家的秘术？", 0, 1)
	dark()
	light()
	addtime(20)
	say("果然是大有收获。", 0, 1)
	AddPersonAttrib(0, "盗贼技巧", 10)
	DrawStrBoxWaitKey("你对各种机关的了解增加了", C_ORANGE, CC.DefaultFont, 2)
	null(-2, 27)
end
OEVENTLUA[13313] = function ()
	Cls()
	addthing(1, 2)
	instruct_37(-1)
	null(-2, 28)
end
OEVENTLUA[13314] = function ()
	Cls()
	say("在不起眼的角落，似乎有个发着微弱亮光的东西。", 0, 2)
	addthing(337, 1)
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[13501] = function ()
	Cls()
	say("可恶，这只大虫逃到哪里去了？", 1020, 0, "猎人")
	say("喂，年轻人，不要往里面走了，密林里有猛虎，桃林深处还有桃花障，进去的人没有人回来过的。", 1020, 0, "猎人")
	addevent(135, 3, 1, 13502, 1, 10744, -2, -2)
end
OEVENTLUA[13502] = function ()
	Cls()
	say("好一只大虫。", 0, 1)

	if WarMain(574, 0, 1, 1) == false then
		instruct_15()
		Cls()

		return
	end

	null(-2, 3)
	addevent(135, 0, 1, 13503, 1, 10376, -2, -2)
end
OEVENTLUA[13503] = function ()
	Cls()
	say("大叔，你不用担心那只猛虎，我已经将它打死了。", 0, 1)
	say("很好，你帮了我大忙了。", 1020, 0, "猎人")
	say("这个给你。", 1020, 0, "猎人")
	addthing(296)
	addevent(135, 0, 1, 13504, 1, 10376, -2, -2)
end
OEVENTLUA[13504] = function ()
	Cls()
	say("年轻人不错，不错。", 1020, 0, "猎人")
end
OEVENTLUA[13505] = function ()
	Cls()
	dark()
	light()

	if JY.Person[0].医疗能力 > 60 or JY.Person[0].抗毒能力 > 30 then
		say("桃花障吗？这点毒如何能拦得住我？", 0, 1)
		null(-2, 2)
	else
		say("你往桃林云雾里面走了几步，只感觉头晕眼花，恶心难受", 0, 2)
		say("还是不要冒险了。", 0, 1)
		My_Enter_SubScene(135, 8, 46, 0)
	end
end
OEVENTLUA[13506] = function ()
	Cls()
	say("所谓平天下在治其国者，上老老而民兴孝，上长长而民兴弟，上恤孤而民不倍。", 1128, 0, "桃小树")
	say("故礼之于人也，犹酒之有蘖也。君子以厚，小人以薄。故圣王修义之柄、礼之序，以治人情。", 1128, 0, "桃小树")
	say("想不到这荒僻之地还有这样好学之人。", 0, 1)
end
OEVENTLUA[13507] = function ()
	Cls()
	say("老村长，你真是生了一个好儿子啊，我可真是羡慕啊。", 1005, 0, "老宋")
	say("老宋啊，你羡慕个啥，你家阿木也不错啊。", 1151, 0, "老村长")
	say("我家阿木那个小子，木木呆呆的，他要有你家小树一半聪明就好了。", 1005, 0, "老宋")
	say("阿木挺好的，忠厚老实，老宋你别老骂他，越骂越呆的。", 1112, 0, "夫人")
	say("是，是，回头我叫阿木来跟小树学习，最好让他也开开窍，学会几个字才好。", 1005, 0, "老宋")
end
OEVENTLUA[13508] = function ()
	Cls()
	say("年轻人，你是从哪儿来的？我们这儿很久没有外人进来了。", 1037, 0, "老李")
end
OEVENTLUA[13509] = function ()
	Cls()

	local var_528_0 = math.random(1, 3)

	if var_528_0 == 1 then
		say("据说桃小树小时候得过异人传授，学会了推算气运之术，也不知道是真是假。", 1027, 0, "老严")
	elseif var_528_0 == 2 then
		say("对门的小碧姑娘前年在林子里救了个书生，两个人成了婚。结果书生耐不住寂寞，年初跑出去了，也不知道现在怎么样了。", 1027, 0, "老严")
	else
		say("我家狗娃也是很聪明的，像我，哈哈哈。", 1027, 0, "老严")
	end
end
OEVENTLUA[13510] = function ()
	Cls()
	say("小朋友，你们在干啥呢？", 0, 1)
	say("做饭呀。我做一个菜，狗娃做一个菜。", 370, 0)
	say("小静的做好了，我的还没有呢。", 368, 0)
	say("真乖。咦？这个桃子？（只见那只桃子十分的大，水灵鲜嫩，很是诱人）", 0, 1)
	say("小朋友，这个桃子能给我吗？", 0, 1)
	say("不能，这是狗娃从桃林里采的，好大好大的桃。", 370, 0)
	say("这样啊，我用东西和你换好不好。狗娃，你想要什么？", 0, 1)
	say("和我换吗？那我要宝剑。", 368, 0)

	if has_thing(341) then
		say("我要你身上这把木头剑。", 368, 0)

		if yesno("要用木剑换吗？") then
			say("好，给。", 0, 1)
			addthing(341, -1)
			instruct_17(135, 1, 48, 23, 0)
			addthing(15, 1)
			say("好啊好啊，我有宝剑勒。这个桃子给你。", 368, 0)
		else
			say("这个不能给你。", 0, 1)
			say("真小气。", 368, 0)
		end
	elseif has_thing(342) then
		say("我要你身上这把木头剑。", 368, 0)

		if yesno("要用木剑换吗？") then
			say("好，给。", 0, 1)
			addthing(342, -1)
			say("好啊好啊，我有宝剑勒。这个桃子给你。", 368, 0)
			instruct_17(135, 1, 48, 23, 0)
			addthing(15, 1)
		else
			say("这个不能给你。", 0, 1)
			say("真小气。", 368, 0)
		end
	else
		say("我这儿没有合适你玩的剑呢。", 0, 1)

		if has_thing(29) then
			say("不过我有一把刀，这个你要不要。", 0, 1)
			say("马马虎虎吧，这个桃子给你。", 368, 0)
			say("好，这个小刀给你给。", 0, 1)
			addthing(29, -1)
			instruct_17(135, 1, 48, 23, 0)
			addthing(15, 1)
		else
			say("那就算了。", 368, 0)
			say("我这儿还有很多好东西的呢。", 0, 1)
			say("不要，我只要宝剑。", 368, 0)
			say("小静，咱们接着玩。", 368, 0)
			say("好呀。", 370, 0)
		end
	end

	addevent(135, 8, 1, 13511, 1, -2)
	addevent(135, 9, 1, 13511, 1, -2)
end
OEVENTLUA[13511] = function ()
	Cls()
	say("张老三，李老三，王老三。", 370, 0)
	say("谁家的老三最勤劳。", 368, 0)
	say("咿呀咿呀哎~", 370, 0)
	say("咿呀咿呀哎~", 368, 0)
end
OEVENTLUA[13512] = function ()
	Cls()
	say("相公，你什么时候回来啊？桃花都已经开了两次了。", 346, 0, "桃小碧")
end
OEVENTLUA[13513] = function ()
	Cls()
	dark()
	null(135, 20)
	light()
	say("老村长，恭喜恭喜。", 1027, 0, "老朱")
	say("恭喜恭喜啊，小树真是好福气。", 1026, 1, "老姜")
	say("同喜同喜。", 1151, 0, "老村长")
	say("啊，有客人来了，快请进快请进。", 1112, 1, "夫人")
	say("客人请进，今日小树成婚，客人不妨进来喝杯喜酒。", 1151, 0, "老村长")
	say("好漂亮的新娘子，正是天作之合啊。如此叨扰了。", 0, 1)
	instruct_30(44, 30, 40, 30)
	say("新人一叩首~", 1049, 0, "小李子")
	dark()
	light()
	say("新人二叩首~", 1049, 0, "小李子")
	dark()
	addevent(135, 21, -2, -2, -2, 10290, -2, -2)
	light()
	say("不好了，外面有金兵打进来了，大家快跑啊。", 1005, 0, "老宋")
	instruct_40(1)
	say("什么？", 1151, 1, "老村长")
	say("快跑啊。", 1026, 0, "老姜")
	dark()
	null(135, 16)
	null(135, 17)
	null(135, 18)
	light()
	say("金兵在哪里？", 0, 1)
	say("已经穿过桃林，往这边来了，村长，快跑吧。", 1005, 0, "老宋")
	say("小静，你还在这里做什么？快跟我跑。", 1005, 1, "老宋")
	dark()
	addevent(135, 22, 1, 13521, 1, 10482, -2, -2)
	addevent(135, 23, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 24, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 25, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 26, 1, 13520, 1, 10480, -2, -2)
	addevent(135, 12, 1, 6533, 1, 5428, -2, -2)
	null(135, 21)
	null(135, 19)
	light()
	say("怎么会这样？", 1151, 0, "老村长")
	say("爹，娘，我们快躲起来吧。", 1128, 1, "桃小树")
	say("躲？往哪里躲？进村就一条路，咱们完了。", 1151, 0, "老村长")
	say("村长，你别着急，待我去看看。", 0, 1)
end
OEVENTLUA[13514] = function ()
	Cls()
	say("桃小树要结婚了，新娘子好漂亮。", 370, 0)
end
OEVENTLUA[13515] = function ()
	Cls()
	say("大侠，还请救救我们。", 1128, 0, "桃小树")
end
OEVENTLUA[13516] = function ()
	Cls()
	say("小树，我们怎么办？", 1078, 0, "新娘")
	say("没事的没事的，有大侠在，你我爹娘都会没事的。", 1128, 1, "桃小树")
end
OEVENTLUA[13517] = function ()
	Cls()
	say("怎么办？怎么办？", 1151, 0, "老村长")
end
OEVENTLUA[13518] = function ()
	Cls()
	say("小树，你们快进屋里躲起来，我和你爹挡在外面。", 1112, 0, "夫人")
end
OEVENTLUA[13520] = function ()
	Cls()
	say("两脚羊，杀~", 1074, 0, "金兵")

	if WarMain(507, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end
OEVENTLUA[13521] = function ()
	Cls()
	say("好凶悍的汉人，杀~", 1074, 0, "金兵")

	if WarMain(507, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("你死定了。", 1074, 0, "金兵")
	instruct_3(-2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	addevent(135, 31, 1, 6533, 1, 5428, -2, -2)
	addevent(135, 32, 1, 6533, 1, 5430, -2, -2)
	addevent(135, 33, 1, 6533, 1, 5428, -2, -2)
	addevent(135, 27, 1, 13522, 1, 10482, -2, -2)
	addevent(135, 28, 1, 13520, 1, 10480, -2, -2)
	addevent(135, 29, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 30, 1, 13523, 1, 10482, -2, -2)
	null(135, 14)
	null(135, 15)
	addevent(135, 5, 1, 6533, 1, 5430, -2, -2)
	addevent(135, 6, 1, 6533, 1, 5436, -2, -2)
	addevent(135, 4, 1, 13525, 1, 10230, -2, -2)
end
OEVENTLUA[13522] = function ()
	Cls()
	say("好凶悍的汉人，杀~", 1074, 0, "金兵")

	if WarMain(508, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("你武功再高，也是挡不住我大金国将士的，你死定了。", 1074, 0, "金兵")
	null(135, 27)
	addevent(135, 28, 1, 13520, 1, 10480, -2, -2)
	addevent(135, 29, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 30, 1, 13520, 1, 10482, -2, -2)
end
OEVENTLUA[13523] = function ()
	Cls()
	say("好凶悍的汉人，杀~", 1074, 0, "金兵")

	if WarMain(508, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("你武功再高，也是挡不住我大金国将士的，你死定了。", 1074, 0, "金兵")
	null(135, 30)
	addevent(135, 27, 1, 13520, 1, 10482, -2, -2)
	addevent(135, 28, 1, 13520, 1, 10480, -2, -2)
	addevent(135, 29, 1, 13520, 1, 10482, -2, -2)
end
OEVENTLUA[13525] = function ()
	Cls()
	say("小树，小树，快醒醒。", 0, 1)
	say("啊~~~", 1128, 0, "桃小树")
	dark()
	addevent(135, 4, -2, -2, -2, 7136, -2, -2)
	light()
	say("娘子，我娘子被金兵抓走了，我要去救他。", 1128, 0, "桃小树")
	say("小树，如今到处都是金兵，你如何去救，不如先随我走吧。", 0, 1)
	say("随你走？去哪里？", 1128, 0, "桃小树")
	say("我在卧虫山下的小村居住，那在江南地带，金兵是决计打不到那里去的。", 0, 1)
	say("不，我要去救娘子。", 1128, 0, "桃小树")
	say("我早该算到有这一劫的，只是没想到...", 1128, 0, "桃小树")
	dark()
	null(135, 4)
	light()
	say("小树，小树。", 0, 1)
	say("哎~", 0, 1)

	JY.Person[634].好感度 = 51
end
OEVENTLUA[13531] = function ()
	Cls()
	dark()
	null(-2, 19)
	null(-2, 28)
	light()
	say("这就是主上说的乱世之人了，杀~", 362, 0, "隐世杀手1")

	if WarMain(538, 0) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("这不像清廷的人啊，奇怪！", 0, 1)
end
OEVENTLUA[13533] = function ()
	Cls()
	dark()
	null(-2, 26)
	null(-2, 28)
	null(-2, 29)
	light()
	say("这就是主上说的乱世之人了，杀~", 362, 0, "隐世杀手1")

	if JY.Person[634].好感度 == 53 then
		if WarMain(541, 0) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		say("这世上还有会葵花宝典的高手？到底是谁要杀我？", 0, 1)
	else
		if WarMain(540, 0) == false then
			instruct_15(0)
			instruct_0()

			return
		end

		say("如此多的高手，这不像一般帮派能派出的，到底是谁要杀我？", 0, 1)
	end
end
OEVENTLUA[13601] = function ()
	Cls()
	say("这是大辽南院大王居所，南院大王是契丹史上最强大的勇士。", 1160, 0, "大辽武士")
end
OEVENTLUA[13602] = function ()
	Cls()
	say("一只羊，两只羊，三只羊，四只羊...，呼，还好今天羊儿没丢。", 1094, 0, "牧羊女")
end
OEVENTLUA[13603] = function ()
	Cls()
	say("我是大王的马夫，也是大辽的勇士。", 1160, 0, "大辽武士")
end
OEVENTLUA[13604] = function ()
	Cls()
	say("南院大王是无敌勇士，听说是他救了辽王，然后又助辽王平乱，将辽王扶上了皇位。", 1154, 0, "大辽老头")
	say("年末就是猎狼大会，我一定要取得名次，获得加入南院的机会。", 1229, 0, "大辽青年")
end
