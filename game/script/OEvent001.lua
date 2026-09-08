OEVENTLUA[1] = function ()
	Cls()
	say("阿豹，你加把劲，咱们就快到了。", 6, 0, "阿牛")
	say("等我歇一歇，我实在抬不动了，这小子怎么越来越沉，连身子都僵硬了。", 6, 0, "阿豹")
	say("你胡说什么呢？身体怎么还会僵硬的？哎，还真是。", 6, 0, "阿牛")
	say("哎呀，不好，他不是死了吧？", 6, 0, "阿豹")
	say("不会吧。", 6, 0, "阿牛")
	say("我探探他的鼻息，哎呀，真的死了，都没气了。", 6, 0, "阿豹")
	say("咱们快走。", 6, 0, "阿豹")
	say("就这么走吗，把他扔在这儿？不太好吧。", 6, 0, "阿牛")
	say("你傻啊，这时候还不走，你别忘了，你还打了他两拳，说不定就是你那两拳打死他的。", 6, 0, "阿豹")
	say("俺可没想打死他。", 6, 0, "阿牛")
	say("废话，这话你去和官府解释去？走。", 6, 0, "阿豹")
	dark()
	null(-2, 108)
	null(-2, 111)
	light()
	dark()
	light()
	say("哎呀，头好疼，浑身无力，我怎么躺在地上？", 0, 1)
	say("我靠，我头上怎么还留着血？这是怎么回事，难道我要死在这儿？", 0, 1)
	dark()
	light()
	say("救命啊！来人啊！有人听见吗？", 0, 1)
	dark()
	light()
	say("这样下去不行，再不止血我就死定了。前面似乎是个小村子，希望有医生。", 0, 1)
	say("我爬，我爬，我爬爬爬。", 0, 1)
	dark()
	light()
end
OEVENTLUA[2] = function ()
	Cls()
	say("阿财，你醒了？", 255, 0, "南贤")
	instruct_40(3)
	say("这是哪里？你是谁？", 0, 1)
	say("阿财，你忘了？我是南伯。", 255, 0, "南贤")
	say("我......。", 0, 1)
	say("我想不起来了，我是叫做阿财吗？", 0, 1)
	say("没事没事，你可能是碰到了头，慢慢来，总会想起来的。", 255, 0, "南贤")
	say("你身体还没有大好，多休息休息。", 255, 0, "南贤")
	say("小燕，照顾好阿财。", 255, 0, "南贤")
	say("是，南伯。", 1070, 1, "小燕")
	dark()
	null(-2, 109)
	addevent(70, 3, 1, 44, 1, 5098, 7, 41)
	light()
	say("小燕，你知道我是怎么受的伤吗？", 0, 0)
	say("大姐大派你去接应洛阳过来的货物，前几天护卫发现你倒在院子里，就把你送进来南伯给你医治了。", 1070, 1, "小燕")
	say("这么说不知道我是怎么受的伤？", 0, 0)
	say("是啊，你自己也不知道吗？", 1070, 1, "小燕")
	say("我......，我记不起来了。大姐大又是谁？", 0, 0)
	say("大姐大你都忘记了？你这回要惨了。", 1070, 1, "小燕")
	say("......。", 0, 0)

	if JY.Base.轮回数2 > JY.Base.轮回数1 then
		say("（我为什么有一种熟悉感，好奇怪）", 0, 0)
		say("（这场景...）", 0, 1)
	end

	dark(50)
	say("Ｌ＜3天之后＞", 0, 1)
	addevent(70, 109, 1, -2, 1, 8248, -2, -2)
	null(-2, 3)
	light()
	say("阿财，你看起来好多了啊。", 255, 0, "南贤")
	say("多谢南伯关心。", 0, 1)
	say("都回忆起来了吗？", 255, 0, "南贤")
	say("我......，我记得自己似乎叫" .. JY.Person[0].姓名 .. "。", 0, 1)
	say("呵呵，叫什么无所谓，你还是你。", 255, 0, "南贤")
	say("阿财啊，你这回受伤是我们没有料到的，我和你丑叔商量，准备推荐你去武当山学艺，你愿意去吗？", 255, 0, "南贤")
	say("学艺？", 0, 1)
	say("不错，武当派乃是江湖上的一流门派，武当派的太极神功更是一门了不起的神功绝学。", 255, 0, "南贤")
	say("当年张三丰欠我一个人情，想来是不会拒绝我这个要求的。", 255, 0, "南贤")
	say("南伯，这个，我行吗？", 0, 1)
	say("行，我们从小看着你长大的，你根骨极佳，又踏实勤奋，没问题的。", 255, 0, "南贤")
	say("给。", 255, 0, "南贤")
	say("还有路上的盘缠，这些银子足够你路上使用了。", 255, 0, "南贤")
	say("谢谢南伯。", 0, 1)
	say("有事就回小村来，这是你从小长大的家，我们都是你的家人。", 255, 0, "南贤")
	say("走之前记得去找找小倩，她有些东西要交给你。", 255, 0, "南贤")
	say("是，南伯。", 0, 1)
	say("终于开始了，呵呵。", 255, 0, "南贤")

	JY.Person[0].初始天赋级别 = (18 - JY.Person[0].生命增长) * 100 + (100 - JY.Person[0].悟性) * 100 + (10 - JY.Person[0].气运) * 10 + (10 - JY.Person[0].精神) * 3 + (10 - JY.Person[0].魅力) * 3

	addthing(174, 400)
	addthing(234)
	dark()
	null(-2, 2)
	null(-2, 109)
	null(-2, 113)
	addevent(70, 0, 1, 30, 1, 8826, -2, -2)
	addevent(70, 3, 1, 44, 1, 5098, -2, -2)
	light()
	say("武当山？江湖，我来了。", 0, 1)
	addevent(70, 114, 1, 25, 1, 9248, -2, -2)
	addevent(70, 115, 1, 25, 1, 9132, -2, -2)
	addevent(70, 71, 1, 101, 1, 5266, -2, -2)
	addevent(70, 72, 1, -2, 1, 9586, -2, -2)
end
OEVENTLUA[21] = function ()
	Cls()

	if has_thing(234) then
		say("阿财，两个老头说你是什么天命之人？", 367, 0, "大姐大")

		if JY.Base.轮回数2 > JY.Base.轮回数1 then
			say("天命之人？，我？", 0, 1)
		else
			say("天命之人？这位小姐，你说的什么？", 0, 1)
			say("什么小姐？要叫我大姐大知道吗？", 367, 0, "大姐大")
			say("？，好吧，大姐大。", 0, 1)
		end

		say("哼，我是不信什么天命之人的，两个老头是老糊涂了，相信这些神神叨叨的东西。", 367, 0, "大姐大")
		say("我从小看着你长大的，你身上有几根毛我不知道？突然就说你是天命之人？怎么可能。", 367, 0, "大姐大")
		say("说吧，找我什么事？", 367, 0, "大姐大")
		say("那个，大姐大，两位老伯说你这儿有些东西要给我。", 0, 1)
		say("东西？你想要那些东西？两个臭老头。", 367, 0, "大姐大")
		say("你知不知道，为了这些东西，我们从5岁开始就锻炼各种技能，10岁后就开始出去江湖闯荡。", 367, 0, "大姐大")
		say("我......", 0, 1)
		say("你知不知道，为了一株千年灵芝，兄弟们出生入死，九死一生；为了偷一本秘籍，兄弟们混入江湖门派，冒了多大险？", 367, 0, "大姐大")
		say("我......", 0, 1)
		say("呼，东西我可以给你，不过你也得表现下你的能力，不是天命之人吗？你拿5000两银子我就给你。", 367, 0, "大姐大")
		say("我......", 0, 1)
		say("拿不出来？", 367, 0, "大姐大")

		if DrawStrBoxYesNo(-1, -1, "是否给大姐大银子？", M_PaleGreen, CC.DefaultFont, C_GOLD) == false then
			say("我......", 0, 1)
			say("银子不够？没关系。", 367, 0, "大姐大")
			say("老头是不是给了你一封信？那个你拿着也没什么大用，就勉强抵5000两吧。", 367, 0, "大姐大")

			if yesno("是否给大姐大介绍信？") == false then
				say("这个不能给你，我还留着有用呢。", 0, 1)
				say("哼，瞧你那小气样。", 367, 0, "大姐大")
				addevent(70, 87, 1, 23, 1, 8348, -2, -2)
			else
				say("好吧，我觉得这封信也没啥用。给你。", 0, 1)
				say("爽快，你等一下。", 367, 0, "大姐大")
				addthing(234, -1)

				JY.Person[620].好感度 = 60

				addevent(70, 87, 1, 22, 1, 8348, -2, -2)
			end
		else
			if instruct_31(5000) == false then
				say("你是在逗我吗？", 367, 0, "大姐大")

				return
			end

			Cls()
			say("给。", 0, 1)
			instruct_32(174, -5000)
			say("爽快，你等一下。", 367, 0, "大姐大")
			addevent(70, 87, 1, 22, 1, 8348, -2, -2)

			JY.Person[620].好感度 = 55
		end
	else
		say("你在干什么？不要闲逛，去扫扫地，打打水。", 367, 0, "大姐大")
		say("我......", 0, 1)
		say("我什么我？我小村不养闲人，赶快干活去。", 367, 0, "大姐大")
		addevent(70, 87, 1, 23, 1, 8348, -2, -2)
	end

	addevent(70, 111, 1, 24, 1, 5266, -2, -2)
end
OEVENTLUA[22] = function ()
	Cls()
	say("接好了，真是便宜你了。", 367, 0, "大姐大")
	instruct_2(209, 100)
	instruct_2(21, 10)
	instruct_2(3, 10)
	addthing(14)
	addthing(17)
	addthing(29, 20)
	addthing(239)
	say("两个老头把你当宝，我也不会亏待了你。我这有些武功秘籍，你要不要？", 367, 0, "大姐大")
	say("唔，你要多少钱？太贵了我不要。", 0, 1)
	say("哼，谁像你那么小气，刀枪棍棒，你喜欢挨哪个？", 367, 0, "大姐大")
	say("啊？", 0, 1)
	say("哎？不小心说错了。那个，是拳剑刀奇暗，你想学哪种？", 367, 0, "大姐大")

	local var_4_0 = JYMsgBox("请选择", "你想要的入门武功类型？", {
		"拳法",
		"剑法",
		"刀法",
		"暗器",
		"奇门"
	}, 5, 367)

	if var_4_0 == 1 then
		addthing(112, 1)
		Cls()
	elseif var_4_0 == 2 then
		addthing(134, 1)
		Cls()
	elseif var_4_0 == 3 then
		addthing(166, 1)
		Cls()
	elseif var_4_0 == 4 then
		addthing(303, 1)
		Cls()
	elseif var_4_0 == 5 then
		addthing(186, 1)
		Cls()
	end

	say("我就学这个了。", 0, 1)
	instruct_27(87, 8344, 8358)
	say("好好好，年轻人有眼光。你去找护卫练一练，连护卫都打不过的话，你就老死在小村吧，也别出去给我丢人现眼了。", 367, 0, "大姐大")
	say("我......", 0, 1)

	if JY.Person[620].好感度 == 60 and has_thing(234) == false then
		say("武当吗？江湖顶尖门派，我也应该去看一看了。", 367, 0, "大姐大")
		null(70, 87)

		JY.Person[523].门派 = 1
		JY.Person[523].门派等级 = 2

		addevent(43, 41, 1, 27, 1, 8348, -2, -2)
	else
		addevent(70, 87, 1, 23, 1, 8348, -2, -2)
	end
end
OEVENTLUA[23] = function ()
	Cls()
	say("什么事？", 367, 0, "大姐大")
	say("啊？我没事。", 0, 1)
	say("没事你到我这儿晃什么？", 367, 0, "大姐大")
	say("大姐大虚眯着眼看着你，你不由心里有些发毛", 0, 2)
	say("对了，你过来。", 367, 0, "大姐大")
	say("是，大姐大。", 0, 1)

	if JY.Person[0].声望 >= 60 and JY.Person[620].好感度 < 80 then
		say("你最近在外边混得不错啊。", 367, 0, "大姐大")
		say("啊？略有薄名，略有薄名。", 0, 1)
		say("我打算在各大城市都建立商会据点，你要见到商会的人要帮助一下。", 367, 0, "大姐大")
		say("啊？没问题，没问题。", 0, 1)

		if has_thing(145) and (has_thing(329) or has_thing(318)) then
			addevent(107, 56, 1, 104, 1, 5268, -2, -2)
			addevent(107, 57, 1, 120, 1, 5088, -2, -2)
			addevent(107, 58, 0, 6770, 3, -2, -2, -2)
		end
	else
		say("你整天在小村闲逛是不是觉得有点闷。", 367, 0, "大姐大")
		say("唔，是有一点。", 0, 1)
		say("很好，小村的厕所好久没人打扫了，你去打扫干净，不要偷懒。", 367, 0, "大姐大")
		say("我......", 0, 1)
		say("还愣着干什么？快去。", 367, 0, "大姐大")
		say("是，大姐大。", 0, 1)
	end

	addevent(70, 111, 1, 24, 1, 5266, -2, -2)
end
OEVENTLUA[24] = function ()
	Cls()
	say("财少爷，你要练武吗？", 514, 0, "护卫")
	say("请指教。", 0, 1)
	say("光打练功木人是不行的，真要提高战斗力，就是实战。", 514, 0, "护卫")
	say("怎么样？和我打一场？", 514, 0, "护卫")

	if yesno("要挑战护卫吗？") then
		if WarMain(102, 1) == false then
			say("你太弱了。", 514, 0, "护卫")

			if JY.Person[0].攻击力 < 100 then
				JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + 100
			end

			if JY.Person[0].修炼点数 > TrainNeedExp(0) - 1 then
				JY.Person[0].修炼点数 = TrainNeedExp(0) - 1
			end

			if has_thing(241) == false then
				say("这个给你，拿去好好练习。", 514, 0, "护卫")
				addthing(241)
			end

			instruct_0()

			return
		end

		say("很好，你有如此实力，大姐大也会为你高兴的。", 514, 0, "护卫")

		if JY.Person[0].攻击力 < 100 then
			JY.Person[0].修炼点数 = JY.Person[0].修炼点数 + 100
		end

		if JY.Person[0].修炼点数 > TrainNeedExp(0) - 1 then
			JY.Person[0].修炼点数 = TrainNeedExp(0) - 1
		end

		dark()
		null(-2, 114)
		null(-2, 115)
		light()
	end
end
OEVENTLUA[25] = function ()
	Cls()
	say("喂，你赔我银子。", 266, 0, "阿牛")
	say("100两，不，150两银子。", 266, 0, "阿牛")
	say("快赔。", 1030, 0, "阿豹")

	if DrawStrBoxYesNo(-1, -1, "是否给阿牛银子？", M_PaleGreen, CC.DefaultFont, C_GOLD) == false then
		if WarMain(297, 0) == false then
			JY.Person[0].经验 = JY.Person[0].经验 + 1

			instruct_0()

			return
		end

		say("你还讲不讲道理。", 1030, 0, "阿豹")
		say("怎么？", 0, 1)
		say("你将阿牛家屋顶砸了一个大洞，要不是阿牛把你送到小村，你早死了。", 1030, 0, "阿豹")
		say("啊？屋顶？", 0, 1)
		say("可不是，那天我和阿牛在院子里干活，就听见嘭的一声，一个东西从天上掉下来砸在屋顶上了，我们赶去一看，就是你躺在地上。", 1030, 0, "阿豹")
		say("啊？", 0, 1)
		say("我一点都不记得了。", 0, 1)
		say("是啊，我现在家里不能住了。", 266, 0, "阿牛")
		say("对不起啊，那个，你叫什么？", 0, 1)
		say("我叫阿牛，他叫阿豹。", 266, 0, "阿牛")
		say("那个阿牛兄，对不住啊，摔着了头，都记不得了。", 0, 1)
		say("这是我赔你的银子。", 0, 1)

		if instruct_31(150) == false then
			say("我身上银子不够。", 0, 1)
			say("啊，没事没事，没钱就不赔了。", 266, 0, "阿牛")
			say("阿牛兄，我一定会凑够银子还你的。", 0, 1)
			say("好了，我们走了。", 266, 0, "阿牛")
			say("牛兄慢走。", 0, 1)

			do return end

			instruct_32(174, -150)
		end

		say("阿牛兄，多谢你救我。", 0, 1)
		say("没事没事，你好好休息，我们走了。", 266, 0, "阿牛")
		say("牛兄慢走。", 0, 1)
		instruct_32(174, -150)
	else
		say("大哥，要银子就早说嘛，给。", 0, 1)
		instruct_32(174, -150)
		say("这小子怎么怪怪的。", 1030, 0, "阿豹")
		say("是啊，和以前有点不一样了，他这么说话，我怎么感觉有点发毛。", 266, 0, "阿牛")
		say("我也觉得有点发冷，咱们快走吧，回去修房子去，我帮你混泥去。", 1030, 0, "阿豹")
	end

	dark()
	null(-2, 114)
	null(-2, 115)
	light()
end
OEVENTLUA[26] = function ()
	Cls()

	if JY.Person[523].好感度 == 50 and JY.Person[0].性别 == 1 then
		say("财少爷，你醒了？", 514, 0, "护卫")
		say("少爷？", 0, 1)
		say("小燕说你失忆了，果然是真的。", 514, 0, "护卫")
		say("大姐大从小把你当小子养大的，你小时候我们都叫你假小子，现在长漂亮了，只好都叫财少爷了，哈哈。", 514, 0, "护卫")
		say("原来是这样。", 0, 1)
		say("财少爷，你在家里多转转，兴许能恢复记忆。", 514, 0, "护卫")
		say("好。", 0, 1)

		JY.Person[523].好感度 = 51

		return
	end

	if JY.Person[620].好感度 == 50 then
		say("大姐大说了，让你先去找她。", 514, 0, "守卫")
	else
		say("我要练好武功，以后保护大姐大。", 514, 0, "守卫")
	end
end
OEVENTLUA[27] = function ()
	Cls()
	null(70, 87)

	if JY.Person[0].声望 >= 200 then
		say("差不多了，我该出去游戏江湖了。", 367, 0, "大姐大")
		say("啊？", 0, 1)
		say("我要从南走到北~，我还要从东走东西~，江湖，我来了！", 367, 0, "大姐大")
		dark()
		null(43, 41)
		light()
	elseif JY.Person[0].声望 >= 60 and JY.Person[620].好感度 < 80 then
		say("你最近在外边混得不错啊。", 367, 0, "大姐大")
		say("啊？略有薄名，略有薄名。", 0, 1)
		say("我打算在各大城市都建立商会据点，你要见到商会的人要帮助一下。", 367, 0, "大姐大")
		say("啊？没问题，没问题。", 0, 1)

		if instruct_60(40, 96, 5268) == false then
			addevent(40, 96, 1, 102, 1, 5268, -2, -2)
			addevent(70, 71, 1, 109, 1, 5266, -2, -2)
			addevent(70, 72, 1, -2, 1, 9586, -2, -2)
		end

		if has_thing(145) and (has_thing(329) or has_thing(318)) then
			addevent(107, 56, 1, 104, 1, 5268, -2, -2)
			addevent(107, 57, 1, 120, 1, 5088, -2, -2)
			addevent(107, 58, 0, 6770, 3, -2, -2, -2)
		end
	else
		say("什么事？", 367, 0, "大姐大")
		say("啊？我没事。", 0, 1)
		say("没事你到我这儿晃什么？", 367, 0, "大姐大")
		say("啊？我就是来打个招呼。", 0, 1)
	end
end
OEVENTLUA[30] = function ()
	Cls()

	local var_10_0 = math.random(1, 10)

	if JY.Person[87].好感度 == 51 then
		if JY.Person[0].性别 == 0 then
			say("赵敏姐姐走了。", 1070, 0, "小燕")
			say("敏儿走了？去哪儿了？", 0, 1)
			say("不知道啊，她让我和你说，她要的是对她一心一意的人陪伴她走过人生。", 1070, 0, "小燕")
			say("事实证明你不是她要等的人，所以她就走了。", 1070, 0, "小燕")
			say("这...", 0, 1)
			say("小燕用有点怜悯的眼光看着你", 0, 2)
			say("阿财，你是和以前不一样了。", 1070, 0, "小燕")
		else
			say("赵敏姐姐走了。", 1070, 0, "小燕")
			say("敏儿走了？去哪儿了？", 0, 1)
			say("不知道啊，她让我和你说，三年了，她终于熟悉了武林情况。", 1070, 0, "小燕")
			say("所谓的武林侠客都是一盘散沙，等大元铁骑一到简直不堪一击。", 1070, 0, "小燕")
			say("这...", 0, 1)
			say("小燕用有点怜悯的眼光看着你", 0, 2)
			say("阿财，是不是大元要打过来了啊？", 1070, 0, "小燕")
		end

		JY.Person[87].好感度 = 50

		return
	end

	if var_10_0 == 1 then
		say("今天的水还没打呢。", 1070, 0, "小燕")
	elseif var_10_0 == 2 then
		say("丑叔说极西偏僻之地有个桃源村，漫山遍野都是桃树，全都结满了大蟠桃，真是好啊。", 1070, 0, "小燕")
	elseif var_10_0 == 3 then
		say("还是小时候好啊，什么都不用做。", 1070, 0, "小燕")
	elseif var_10_0 == 4 then
		say("阿财，你给我带东西了吗？小时候你有好东西都给我的。", 1070, 0, "小燕")
	elseif var_10_0 == 5 then
		say("我们都是大姐大捡来的孤儿。", 1070, 0, "小燕")
	elseif var_10_0 == 6 then
		say("院子里的树可挡阳光了，上次我说找人来砍了啊，可丑叔不让，说这是上任主人留下来的，一草一木都不让动。", 1070, 0, "小燕")
	elseif var_10_0 == 7 and JY.Person[523].佛学修为 == 0 then
		say("这是我打扫时翻出来的一件皮衣，很漂亮的，阿财，你拿去穿吧。", 1070, 0, "小燕")
		say("好啊。", 0, 1)
		addthing(63)

		JY.Person[523].佛学修为 = 1

		return
	elseif var_10_0 == 8 then
		say("听说以前小村就几间茅草房，穷得要死。后来大姐大带领大家闯荡，就有了现在的基业。", 1070, 0, "小燕")
	elseif var_10_0 == 9 and JY.Base.轮回数2 > JY.Base.轮回数1 then
		say("小燕，我看见你觉得好亲切哦。", 0, 1)
		say("油嘴滑舌，去去去。", 1070, 0, "小燕")
	else
		say("又该去做饭了。", 1070, 0, "小燕")
	end

	if has_thing(339) then
		say("咦？这个是什么？", 1070, 0, "小燕")
		say("哦，这个啊，是我从一个小孩那儿换得的布娃娃。", 0, 1)
		say("好可爱。", 1070, 0, "小燕")
		say("哎，你干什么？", 0, 1)
		say("这儿有条缝，你仔细看。", 1070, 0, "小燕")
		say("有吗？真的有啊，小燕，你可真细心。", 0, 1)
		say("那是当然。可以打开哎，我看看里面有什么？", 1070, 0, "小燕")
		dark()
		light()
		say("什么嘛，就一个洞，里面什么也没有。", 1070, 0, "小燕")
		say("这个洞好圆，这是什么材质的？从来没见过这样的材质。", 0, 1)
		say("不知道。喂，这个小娃娃给我玩几天，你不会舍不得吧。", 1070, 0, "小燕")
		say("不会，你可别弄丢了，我能感觉到，这个布娃娃对我很重要", 0, 1)
		say("放心吧，这么脏，我先拿去洗洗。", 1070, 0, "小燕")
		null(-2, 0)
		addthing(339, -1)
		addevent(70, 68, 0, 68, 3, -2, -2, -2)
	end
end
OEVENTLUA[31] = function ()
	Cls()
	dark()
	instruct_12()
	light()
	say("＜新的一天又开始了。＞", 0, 0)
	addtime(1)
end
OEVENTLUA[32] = function ()
	Cls()

	if has_thing(195) then
		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 6702, 6742)
		else
			say("用铲子，挖挖看。", 0, 1)
		end

		dark()
		light()
		say("你挖了半天，可惜什么也没有挖到", 0, 2)
	end
end
OEVENTLUA[33] = function ()
	Cls()

	if has_thing(195) then
		say("有铁铲，挖挖看。", 0, 1)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 6702, 6742)
		else
			say("会不会埋着什么好东西呢？", 0, 1)
		end

		dark()
		light()

		if JY.Base.轮回数2 > JY.Base.轮回数1 then
			if has_thing(352) then
				say("周围没人，我赶快把重要的东西藏起来。藏什么好呢？", 0, 1)

				repeat
					local var_13_0 = MenuDSJ()

					if var_13_0 > -1 and DrawStrBoxYesNo(-1, -1, "确定要藏" .. JY.Thing[var_13_0].名称 .. "吗？", C_WHITE, CC.DefaultFont) then
						if var_13_0 == 339 or JY.Thing[var_13_0].装备类型 == 0 or JY.Thing[var_13_0].装备类型 == 1 or JY.Thing[var_13_0].装备类型 == 3 then
							say("这个东西太大了，完全放不进盒子里。", 0, 2)
						elseif var_13_0 < 36 or var_13_0 == 337 then
							Cls()

							local var_13_1 = 0

							for iter_13_0 = 1, CC.MyThingNum do
								if JY.Base["物品" .. iter_13_0] == var_13_0 then
									var_13_1 = JY.Base["物品数量" .. iter_13_0]

									break
								end
							end

							local var_13_2 = InputNum("藏物品数量", 1, var_13_1, 1)

							if var_13_2 ~= nil then
								instruct_32(var_13_0, -var_13_2)

								JY.Base.电池数 = var_13_2
							end
						elseif JY.Thing[var_13_0].使用人 == -1 then
							instruct_32(var_13_0, -1)

							JY.Base.电池数 = 1
						else
							DrawStrBoxWaitKey("此物品有人正在使用。", C_WHITE, CC.DefaultFont)
						end
					end

					Cls()
				until not DrawStrBoxYesNo(-1, -1, "还想继续藏物品吗？", C_WHITE, CC.DefaultFont)

				if JY.Base.电池数 == 0 then
					say("没有什么贵重的东西来藏，我先把宝盒收起来，以后再说。", 0, 1)
					addthing(352, 1)
				else
					addthing(352, -1)
					instruct_3(70, 62, 1, 0, 0, 34, 0, -2, -2, -2, -2, -2, -2)
				end

				return
			end

			say("你挖了半天，终于挖出一个金属小盒", 0, 2)
			say("哇~", 0, 1)

			if JY.Base.电池数 > 0 then
				local var_13_3 = JY.Base.电池数

				for iter_13_1 = 1, 100 do
					if JY.Base.轮回数2 == 3 * iter_13_1 then
						JY.Person[634].罪恶值 = 1
						var_13_3 = 1
					end
				end

				say("真的有东西。", 0, 1)
				null(-2, 4)
				addevent(70, 93, 1, -2, 1, 8250, -2, -2)
				say("你挖到什么了？", 256, 0, "北丑")
				say("宝物啊，给你看看。", 0, 1)
				say("果然。", 256, 0, "北丑")
				say("什么？", 0, 1)
				say("没什么。这盒子...好奇怪的材质，我拿去研究研究。", 256, 0, "北丑")
				say("不行，我感觉这盒子我还有用呢。", 0, 1)
				say("是吗？", 256, 0, "北丑")
				addthing(337, var_13_3)
				addthing(352, 1)

				JY.Base.电池数 = 0
			else
				addthing(352, 1)
				say("你打开盒子，可惜里面什么也没有", 0, 2)
				say("真是可惜。", 0, 1)
				null(-2, 4)
				addevent(70, 93, 1, -2, 1, 8250, -2, -2)
				say("你挖到什么了？", 256, 0, "北丑")
				say("啊~，丑叔，你怎么无声无息的。", 0, 1)
				say("就挖到一个空盒子，里面什么都没有。", 0, 1)
				say("空盒子？有什么用？", 256, 0, "北丑")
				say("不知道啊。（这盒子？为什么我有种熟悉的感觉）", 0, 1)
				say("给我看看。", 256, 0, "北丑")
				dark()
				light()
				say("好奇怪的材质。", 256, 0, "北丑")
				say("（为什么觉得这盒子特别适合放东西，而且能长久保存）", 0, 1)
				say("这盒子给我去研究研究如何？", 256, 0, "北丑")
				say("不行。我要用它藏重要的东西。", 0, 1)
				say("哦？重要的东西，你要藏什么呢？", 256, 0, "北丑")
				say("我看看。", 0, 1)

				repeat
					local var_13_4 = MenuDSJ()

					if var_13_4 > -1 and DrawStrBoxYesNo(-1, -1, "确定要藏" .. JY.Thing[var_13_4].名称 .. "吗？", C_WHITE, CC.DefaultFont) then
						if var_13_4 < 36 or var_13_4 == 337 then
							Cls()

							local var_13_5 = 0

							for iter_13_2 = 1, CC.MyThingNum do
								if JY.Base["物品" .. iter_13_2] == var_13_4 then
									var_13_5 = JY.Base["物品数量" .. iter_13_2]

									break
								end
							end

							local var_13_6 = InputNum("藏物品数量", 1, var_13_5, 1)

							if var_13_6 ~= nil then
								instruct_32(var_13_4, -var_13_6)

								JY.Base.电池数 = var_13_6
							end
						elseif JY.Thing[var_13_4].使用人 == -1 then
							instruct_32(var_13_4, -1)

							JY.Base.电池数 = 1
						else
							DrawStrBoxWaitKey("此物品有人正在使用。", C_WHITE, CC.DefaultFont)
						end
					end

					Cls()
				until not DrawStrBoxYesNo(-1, -1, "还想继续藏物品吗？", C_WHITE, CC.DefaultFont)

				if JY.Base.电池数 == 0 then
					say("没有什么贵重的东西来藏，我先把宝盒收起来，以后再说。", 0, 1)
				else
					addthing(352, -1)
					instruct_3(70, 62, 1, 0, 0, 34, 0, -2, -2, -2, -2, -2, -2)
				end
			end

			say("有意思，有意思。", 256, 0, "北丑")
			null(-2, 93)
			addevent(70, 4, 1, 36, 1, 8250, -2, -2)
		else
			say("你挖了半天，可惜什么也没有挖到", 0, 2)
		end
	end
end
OEVENTLUA[34] = function ()
	Cls()

	if has_thing(195) then
		say("闲着没事，把宝物挖出来看看。", 0, 1)

		if JY.Person[0].性别 == 0 then
			instruct_27(-1, 6702, 6742)
		else
			say("心里放不下啊。", 0, 1)
		end

		dark()
		light()
		say("你挖了半天，可惜什么也没有挖到", 0, 2)
		say("怎么回事？不会吧。", 0, 1)
		say("你疑惑地左右望望", 0, 2)
		dark()
		light()
		say("欲哭无泪", 0, 2)
		instruct_3(70, 62, 1, 0, 0, 32, 0, -2, -2, -2, -2, -2, -2)
	end
end
OEVENTLUA[35] = function ()
	Cls()
	dark()
	null(-2, 21)
	null(-2, 22)
	light()

	if JY.Person[634].好感度 == 52 then
		say("如此我便告辞了。", 1128, 0, "桃小树")
		say("小树，切记天命无常，不可尽信。", 256, 1, "北丑")
		say("我理会得。", 1128, 0, "桃小树")
		say("小树？", 0, 1)
		instruct_30(12, 21, 9, 21)
		say(JY.Person[0].称呼 .. "你回来了。", 1128, 0, "桃小树")
		say("路过小村，特来拜访。", 1128, 0, "桃小树")
		say("这是我路上无意中得到的千年人参，便献给" .. JY.Person[0].称呼 .. "。", 1128, 0, "桃小树")
		say("小树你太客气了。", 0, 1)
		say("还请" .. JY.Person[0].称呼 .. "收下，我还要在小村待上几日，就麻烦" .. JY.Person[0].称呼 .. "了。", 1128, 0, "桃小树")
		addthing(16)
		say("无妨无妨。", 0, 1)
		say("数日后", 0, 2)
		addtime(3)
		say(JY.Person[0].称呼 .. "，我还有生意上的事，叨扰了好几日，这边告辞了。", 1128, 0, "桃小树")
		say("小树，有空便来啊。", 0, 1)
		say("好，告辞了。", 1128, 0, "桃小树")

		JY.Person[634].好感度 = 53
	else
		say("如此我便告辞了。", 1128, 0, "桃小树")
		say("小树，切记天命无常，不可尽信。", 256, 1, "北丑")
		say("我理会得。", 1128, 0, "桃小树")
		say("小树？", 0, 1)
		instruct_30(12, 21, 9, 21)
		say(JY.Person[0].称呼 .. "你回来了。", 1128, 0, "桃小树")
		say("路过小村，特来拜访。", 1128, 0, "桃小树")
		say("你既安然无恙，甚好，甚好。", 0, 1)
		say("我那日离开桃源村后，四处寻娘子不到，便做些小生意，到处打探，如今也没有消息，也不知道她是否还安好。", 1128, 0, "桃小树")
		say("我在江湖四处行走，便帮你寻一寻吧。", 0, 1)
		say("难得你一直帮我，这是我路上无意中得到的千年人参，便献给" .. JY.Person[0].称呼 .. "。", 1128, 0, "桃小树")
		say("这个...", 0, 1)
		say("还请不要客气，我还要在小村待上几日，就麻烦" .. JY.Person[0].称呼 .. "了。", 1128, 0, "桃小树")
		addthing(16)
		say("无妨无妨。", 0, 1)
		say("数日后", 0, 2)
		addtime(3)
		say(JY.Person[0].称呼 .. "，我还有生意上的事，叨扰了好几日，这边告辞了。", 1128, 0, "桃小树")
		say("小树，有空便来啊。", 0, 1)
		say("好，告辞了。", 1128, 0, "桃小树")

		JY.Person[634].好感度 = 52
	end

	dark()
	null(-2, 44)
	light()
end
OEVENTLUA[36] = function ()
	Cls()

	if ts_num() == 14 or ts_num() >= 12 and ts_num() < 14 and JY.YEAR > 85 then
		say("你来了。", 256, 0, "北丑")
		say("啊，我来了，丑叔你在做干啥呢？", 0, 1)
		say("你有没有觉得，你做的事不是你做的，你知道的事都是莫名知道的？", 256, 0, "北丑")
		say("丑叔你说啥呢？我做的事当然是我做的，我不会否认的。", 0, 1)
		say("是吗？", 256, 0, "北丑")
		say("丑叔定定的看着你，目不转睛", 0, 2)
		say("（你不由有些发毛）", 0, 1)
		say("怎么了？丑叔你秀逗了？", 0, 1)
		say("那你有没有觉得，有些事你似乎经历过，可仔细想却又完全没有印象？", 256, 0, "北丑")
		say("丑叔你是不是志怪小说看多了，陷进去了。", 0, 1)
		say("也许吧。", 256, 0, "北丑")
		say("一切都是安排好的吗？天数，天数啊。", 256, 0, "北丑")
		say("...", 0, 1)
		say("丑叔你好好休息，我走了啊。", 0, 1)
		say("对了，你南叔找你有事，你快过去吧。", 256, 0, "北丑")
		say("啊，好。", 0, 1)
	elseif ts_num() > 0 and inteam(75) and has_thing(152) == false then
		say("咦，你身上这是什么书？", 256, 0, "北丑")
		say("这个吗？这是一本无字的书，我总觉得它很重要，就一直带在身上。", 75, 1)
		say("我看看。", 256, 0, "北丑")
		say("果然是天书。" .. JY.Person[0].称呼 .. "，你看看。", 256, 0, "北丑")
		say("是《书剑恩仇录》，嗯？不过张召重喂了狼，有些不一样啊。", 0, 1)
		say("你能看见书上的字？", 75, 0)
		say("这是天书，只有天命之人才能看见里面的内容。", 256, 1, "北丑")
		say("我~~，就是天命之人，注定会天下无敌，天下共主，天下~", 0, 0)
		say("天下什么？你现在就是只小虾米。", 256, 1, "北丑")
		say("...", 0, 0)
		say("等我收集齐天书，就天下无敌了，这是注定的。陈舵主，这书对我很重要，能送给我吗？", 0, 1)
		say("你以后能助我恢复汉室江山，重振华夏盛世吗？", 75, 0)
		say("那是自然，我是汉人。", 0, 1)
		say("好，这书就给兄弟你了，不要忘记今日的话。", 75, 0)
		addthing(152, 1)
	elseif inteam(600) and has_thing(229) then
		say("咦，你身上这是什么书？", 256, 0, "北丑")
		say("这个吗？这是四十二章经，据说里面藏着清廷的大秘密，丑叔你要不帮我看看？", 0, 1)
		say("这就是你说的丑老头？", 225, 0, "韦小宝")
		say("什么丑老头？要叫我丑叔。", 256, 1, "北丑")
		say("是，丑叔。", 225, 0, "韦小宝")
		say("哎，小伙子真机灵。这书本身没什么，不过这封面的材质有点奇怪，我看看啊。", 256, 1, "北丑")
		say("哎呀，丑叔，你干什么？不能烧啊，我们好不容易找到的。咦？显出字来了。", 225, 0, "韦小宝")
		say("真神奇，鹿鼎山，（66，117）是什么？", 225, 0, "韦小宝")
		say("鹿鼎山？这应该是一个地名。", 256, 1, "北丑")
		say("谢谢丑叔。", 0, 0)
		instruct_32(229, -1)
		instruct_39(90)
	elseif ts_num() < 7 then
		if ts_num() == 1 then
			say("咦，" .. JY.Person[0].称呼 .. "，你身上这是什么书？", 256, 0, "北丑")
			say("这个？这是我在外面收集到的故事书。不过有些奇怪，它里面记录的是刚发生过的事。", 0, 1)
			say("我看看。", 256, 0, "北丑")
			say("你能看见里面的字？", 256, 0, "北丑")
			say("我自然能看见，没看见我有一双大大的眼睛，正闪着神秘的光泽吗？", 0, 1)
			say("不，这本书是一部白纸，上面什么都没有。", 256, 0, "北丑")
			say("南老头，这小子找到天书了。", 256, 0, "北丑")
			dark()
			addevent(70, 1, 0, 0, 0, 5098, -2, -2)
			null(-2, 3)
			light()
			say("我看看，果然是无字天书。", 255, 1, "南贤")
			say("...", 0, 0)
			say("天命之人，天命之人啊。果然如此。", 255, 1, "南贤")
			say("到底怎么回事啊？", 0, 0)
			say("我给你讲讲啊。这个啊，就是无字天书，传说中记载着世界上所有的人和所有发生的事，如果能得到它，就能天下无敌~。", 256, 1, "北丑")
			say("而这个世界上只有一种人可以看到书中的内容，那就是天命之人。也就是你。", 256, 1, "北丑")
			say("我得到了天书，没有天下无敌啊？而且我看里面的内容是已经发生过的事。", 0, 0)
			say("一共有14本天书，你要全部得到才能知道所有的人和所有发生的事。如果记得是已经发生过的事，那就是你得到的太晚了哇，你不会早点找到它吗？这样就提前知道要发生什么事了，还能不无敌？", 256, 1, "北丑")
			say("似乎有点道理。", 0, 0)
			say("我的话自然是有道理的。", 256, 1, "北丑")
			say("晚上过来下盘棋，北老头。", 255, 0, "南贤")
			say("好。", 256, 1, "北丑")
			dark()
			addevent(70, 3, 1, 44, 1, 5098, -2, -2)
			null(-2, 1)
			light()

			return
		end

		if has_thing(320) or has_thing(321) then
			say("给你的著作要好好研习。", 256, 0, "北丑")
			say("知道了丑叔。", 0, 0)

			return
		end

		local var_16_0 = (100 - JY.Person[0].品德) / 10

		if var_16_0 < 1 then
			var_16_0 = 1
		end

		if (JY.Person[634].好感度 == 52 or CC.CircleNum >= 3) and instruct_28(0, 80, 100) and has_thing(321) == false and has_something(324, var_16_0) then
			say("你身上这是？万民书？", 256, 0, "北丑")
			say("南老头，快来。", 256, 0, "北丑")
			dark()
			addevent(70, 1, 0, 0, 0, 5098, -2, -2)
			null(-2, 3)
			light()
			say("看看这些是什么？", 256, 0, "北丑")
			say("我看看，这是万民书？", 255, 1, "南贤")
			say("...", 0, 0)
			say("天命之人，天命之人啊。果然如此。", 255, 1, "南贤")
			say("不愧是心怀天下之人。", 255, 0, "南贤")
			say("" .. JY.Person[0].称呼 .. "，你在江湖中的所为我已有所闻，这个拿着，对你必有用处。", 255, 0, "南贤")
			say("今日就给你了，没事就翻看翻看，记住，要时刻走在正道之上。", 255, 0, "南贤")
			say("不是武功啊？", 0, 1)
			addthing(321, 1)
			say("我看看。", 0, 1)
			addtime(30)
			say("好书，好书，大清...、西夏...、大金...，天下大势我已明了，好男儿生在当世，正该有所作为。", 0, 1)
			say("你感觉自己一下顿悟了", 0, 2)
		end

		if (JY.Person[634].好感度 == 52 or CC.CircleNum >= 3) and instruct_28(0, 0, 30) and has_thing(320) == false and has_something(324, var_16_0) then
			say("果然是心有天下之人。", 256, 1, "北丑")
			say("" .. JY.Person[0].称呼 .. "，你在江湖中的所为我已有所闻，这个拿着，对你必有用处。", 256, 0, "北丑")
			say("不是武功啊？", 0, 1)
			addthing(320, 1)
			say("我看看。", 0, 1)
			addtime(30)
			say("好书，好书，天下之事，无非利益，所有东西都可以取，所有人都可以用，说的不错，不错。", 0, 1)
			say("你一下顿悟了", 0, 2)
		end

		say("晚上过来下盘棋，北老头。", 255, 0, "南贤")
		say("好。", 256, 1, "北丑")
		dark()
		addevent(70, 3, 1, 44, 1, 5098, -2, -2)
		null(-2, 1)
		light()
		instruct_46(550, 1)
	elseif math.random(2) == 1 then
		say("要找到你的机会。", 256, 0, "北丑")
	else
		say("这个世界有大秘密。", 256, 0, "北丑")
	end
end
OEVENTLUA[44] = function ()
	if ts_num() == 14 then
		say("年轻人，你终于完成了你的使命。", 255, 0, "南贤")
		say("老头，你在说什么？什么使命？", 0, 1)
		say("按照古老的约定，你可以返回你的世界了。", 255, 0, "南贤")
		say("老头，你今天吃错药了吧？什么我的世界？", 0, 1)
		say("时间到了，上界之门已经开放，你去看看就知道了。", 255, 0, "南贤")
		say("上界之门？在什么地方？", 0, 1)
		dark()
		instruct_17(-2, 1, 6, 31, 0)
		instruct_17(-2, 1, 0, 29, 0)
		instruct_17(-2, 1, 0, 28, 0)
		addevent(70, 76, 1, 45, 1, 10668, -2, -2)
		addevent(70, 78, 0, 46, 3, -2, -2, -2)
		addevent(70, 79, 0, 45, 3, -2, -2, -2)
		null(-2, 3)
		null(-2, 4)
		addevent(70, 109, 0, 0, 0, 8250, -2, -2)
		addevent(70, 110, 0, 0, 0, 5098, -2, -2)
		My_Enter_SubScene(70, 9, 31, 2)
		light()
		say("在这个密室里。", 255, 0, "南贤")
		say("？这是？这是什么时候出现的？", 0, 1)
		say("我们都会怀恋你的。", 255, 0, "南贤")
		say("我可没说我要走，现在我过得好着呢，我哪都不去。", 0, 1)
		say("......", 0, 1)
		say("好奇怪，看看先。", 0, 1)
		instruct_30(9, 31, 3, 31)
		instruct_30(3, 31, 3, 29)
		My_Enter_SubScene(70, 3, 29, 2)
	elseif ts_num() < 14 and JY.YEAR > 100 then
		say("年轻人，时间到了。", 255, 0, "南贤")
		say("老头，你在说什么？", 0, 1)
		say("按照古老的约定，你可以返回你的世界了。", 255, 0, "南贤")
		say("老头，你今天吃错药了吧？什么我的世界？", 0, 1)
		say("时间到了，上界之门已经开放，你去看看就知道了。", 255, 0, "南贤")
		say("上界之门？在什么地方？", 0, 1)
		dark()
		instruct_17(-2, 1, 6, 31, 0)
		instruct_17(-2, 1, 0, 29, 0)
		instruct_17(-2, 1, 0, 28, 0)
		addevent(70, 76, 1, 45, 1, 10668, -2, -2)
		addevent(70, 78, 0, 46, 3, -2, -2, -2)
		addevent(70, 79, 0, 45, 3, -2, -2, -2)
		null(-2, 3)
		null(-2, 4)
		addevent(70, 110, 0, 0, 0, 8250, -2, -2)
		addevent(70, 113, 0, 0, 0, 5098, -2, -2)
		My_Enter_SubScene(70, 9, 31, 2)
		light()
		say("在这个密室里。", 255, 0, "南贤")
		say("？这是？这是什么时候出现的？", 0, 1)
		say("我们都会怀恋你的。", 255, 0, "南贤")
		say("我可没说我要走，现在我过得好着呢，我哪都不去。", 0, 1)
		say("好奇怪，看看先。", 0, 1)
		instruct_30(9, 31, 3, 31)
		instruct_30(3, 31, 3, 29)
		My_Enter_SubScene(70, 3, 29, 2)
	elseif has_thing(339) then
		say("年轻人，你来啦。", 255, 0, "南贤")
		say("咦，这是什么？拿来我看看。", 255, 0, "南贤")
		say("这个布娃娃？不会吧，你都一把年纪了，还喜欢这个？", 0, 1)
		say("胡说什么？快给我看看。", 255, 0, "南贤")
		dark()
		light()
		say("果然是，果然是，你居然把这个宝物找到了，果然是天命之人啊。", 255, 0, "南贤")
		say("这个到底是什么？", 0, 1)
		say("这个啊，这个是小村第一代主人小虾米的宝物，想当年，小虾米东征西战，天下无敌，那真是武林的一代传说啊。", 255, 0, "南贤")
		say("小虾米？这么厉害？我怎么没听说过。", 0, 1)
		say("时过境迁，现在只有我和北丑知道他的名字了，哎，真是令人唏嘘啊。", 255, 0, "南贤")
		say("好吧。那这个宝物有啥用？", 0, 1)
		say("不知道。", 255, 0, "南贤")
		say("不知道？", 0, 1)
		say("不知道。不过当年小虾米很看重这个东西，没想到他最后把它留在了这个世界。", 255, 0, "南贤")
		say("啥啥？你说这个世界？小虾米最后去哪了？", 0, 1)
		say("小虾米天下无敌，无限寂寞，最终破碎虚空而去。", 255, 0, "南贤")
		say("呼，老头你就吹吧，还破碎虚空而去，不如直接说成仙升天了。", 0, 1)
		say("不是，是破碎了虚空，我和北丑当年亲眼看见他跨过一片虚空消失在我们眼前。", 255, 0, "南贤")
		say("......", 0, 1)
		say("搞啥？难道世界上真的有神仙这种东西？怎么可能？", 0, 1)
		say("好了，别多想了，只要你锐意进取，惩奸除恶，总有一天也会有所成就的。", 255, 0, "南贤")
	else
		say("年轻人，你来啦。", 255, 0, "南贤")
		Cls()
		say("死老头，就会这句，难道会说这句话就是贤者吗？", 0, 1)
		Cls()
		say("不，作为贤者，我还有更重要的事情要对你说。", 255, 0, "南贤")
		Cls()
		say("我就知道，你总会再给我一些提示的。", 0, 1)
		Cls()
		say("在江湖上行走，最重要的就是使自己保持在正道之上。", 255, 0, "南贤")
		Cls()
		say("...", 0, 1)
	end
end
OEVENTLUA[45] = function ()
	Cls()
	null(-2, 79)
	say("这就是所谓的次元门？果然很奇异啊？", 0, 1)
	say("这门框似乎是金属的，既然是门，我不跨过去不就行了，谁知道那边是什么东西？危不危险。", 0, 1)
	say("傻子才会去开门呢。", 0, 1)
	say("咦？这里面这是？我为什么有一种熟悉的感觉？", 0, 1)
	say("这是什么？啊啊啊~", 0, 1)
	say("一股巨大的吸力传来，你完全不能抗拒", 0, 2)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8160, 8166)
	else
		instruct_27(-1, 8140, 8146)
	end

	My_Enter_SubScene(70, 2, 29, 1)
	null(-2, 79)
end
OEVENTLUA[46] = function ()
	Cls()
	null(-2, 78)
	instruct_59()
	say("啊啊啊~，这是什么？什么？", 0, 1)
	say("啊啊~，救命啊，我好不容易打下的江山，还没有享受呢，妈蛋！", 0, 1)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8160, 8166)
	else
		instruct_27(-1, 8140, 8146)
	end

	say("很不幸，你被这奇怪的门吸了进去！怎么抗拒都没有作用", 0, 2)
	dark()
	My_Enter_SubScene(91, 10, 8, 3)
	light()
	say("啊啊啊~", 0, 1)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 8120, 8128)
	else
		instruct_27(-1, 8140, 8146)
	end

	My_Enter_SubScene(117, 47, 61, 3)

	if JY.Person[0].性别 == 0 then
		instruct_27(-1, 5974, 5992)
	else
		instruct_27(-1, 10642, 10650)
	end

	addevent(117, 1, -2, -2, -2, 10118, -2, -2)
end
OEVENTLUA[63] = function ()
	Cls()
	say("（这是一本厚厚的历史书籍，你大致看了一下就没有兴趣了）", 0, 1)
	say("天下三分", 0, 2)
	say("北为清廷，以汉人为奴，法制严苛，纷争不断", 0, 2)
	say("中为中原，门派林立，争斗不止", 0, 2)
	say("南为南朝，抑武扬文，外族入侵", 0, 2)
	say("壮哉我山河，悲哉我山河...", 0, 2)
end
OEVENTLUA[64] = function ()
	instruct_17(70, 1, 6, 31, 0)
end
OEVENTLUA[65] = function ()
	addevent(70, 68, -2, -2, -2, 1844, -2, -2)
end
OEVENTLUA[66] = function ()
	instruct_17(70, 1, 6, 31, 0)
	addevent(70, 67, 0, 67, 3, -2, -2, -2)
end
OEVENTLUA[67] = function ()
	addevent(70, 68, -2, -2, -2, 1844, -2, -2)
end
OEVENTLUA[68] = function ()
	Cls()
	dark()
	addevent(70, 70, 0, 0, 0, 8830, -2, -2)
	null(-2, 68)
	light()
	say("小燕？你在这儿干什么？", 0, 1)
	say("这个布娃娃我洗干净了，今后就放在这里了。", 1070, 0, "小燕")
	dark()
	addevent(70, 69, 0, 0, 0, 6888, -2, -2)
	light()
	say("好了，好好好对它哦，不要玩坏了。", 1070, 0, "小燕")
	say("...，不用你管。", 0, 1)
	say("呵呵，阿财你还是有点傻傻的样子更可爱。", 1070, 0, "小燕")
	null(-2, 70)
	say("......", 0, 1)
	addevent(70, 0, 1, 30, 1, 8826, -2, -2)
	addevent(70, 69, 1, 69, 1, -2, -2, -2)
end
OEVENTLUA[69] = function ()
	Cls()

	if has_thing(337) then
		say("咦，这个大小，我记得得到过大小差不多的金属币。试试看。", 0, 1)
		say("这个小金属块正好能塞进布娃娃后背的洞里面。", 0, 2)
		dark()
		light()
		instruct_27(69, 6852, 6888)
		say("啊~，我终于回来了。", 267, 0, "软件娃娃")
		say("...", 0, 1)
		say("你会说话？你是什么东西？", 0, 1)
		say("我是软体娃娃，我要电池，电池", 267, 0, "软件娃娃")
		say("给我电池，我能帮你的。电池，电池", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 70, 1, -2, -2, -2)
	else
		say("一个神秘的布娃娃。", 0, 1)
	end
end
OEVENTLUA[70] = function ()
	Cls()
	addevent(70, 18, 0, 66, 3, -2, -2, -2)
	say("软件娃娃，你能帮我做什么？", 0, 1)
	say("我看看啊。", 267, 0, "软件娃娃")

	if has_something(337, 6) then
		say("我能帮你推演一门新的内功，你的底蕴越深，推演出的内功就越厉害。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 71, 1, -2, -2, -2)
	elseif hav_anything(337, 4) or hav_anything(337, 5) then
		say("我能帮你大幅激发身体的潜力。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 72, 1, -2, -2, -2)
	elseif hav_anything(337, 3) then
		say("你可以抽取一门高深武功作为奖励。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 73, 1, -2, -2, -2)
	elseif hav_anything(337, 2) then
		say("你可以抽取一门中等武功作为奖励。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 74, 1, -2, -2, -2)
	elseif hav_anything(337, 1) then
		say("你可以抽取一门基础武功作为奖励。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 75, 1, -2, -2, -2)
	else
		say("没有电池你来干啥？别打扰我睡觉。", 267, 0, "软件娃娃")
	end
end
OEVENTLUA[71] = function ()
	Cls()

	if yesno("要推演内功吗？") then
		if JY.Base.觉醒 == 1 then
			if JY.Base.主角职业 == 10 then
				say("你的天赋已经很强了，不能继续提升。不过你的身体还有一些潜力，我已经将它激发出来了。", 267, 0, "软件娃娃")
			else
				say("你以前已经推演过一次，这次可以在前次的基础上继续推演。", 267, 0, "软件娃娃")
				say("好吧。", 0, 1)
				dark()
				light()
				addtime(7)
				say("可以了。", 267, 0, "软件娃娃")
				DrawStrBoxWaitKey(string.format("%s领悟了【六如】", JY.Person[0].姓名), C_ORANGE, CC.DefaultFont, 2)

				JY.Wugong[91].名称 = "六如苍龙诀"
				JY.Wugong[91].攻击力10 = 1600
				JY.Wugong[91].增幅攻击等级 = 12
				JY.Wugong[91].增幅防御等级 = 12
				JY.Wugong[91].增幅轻功等级 = 12

				SetS(10, 0, 12, 0, 0)
			end

			addthing(337, -6)

			JY.Base.二次觉醒 = 1

			addevent(70, 69, 1, 70, 1, -2, -2, -2)
		else
			local var_28_0 = 0

			for iter_28_0 = 1, CC.Kungfunum do
				if JY.Person[0]["武功" .. 10] > 0 then
					var_28_0 = 1
				end
			end

			if var_28_0 == 0 then
				say("等我看一下。", 267, 0, "软件娃娃")
				dark()
				light()
				say("你现在根基还不够雄厚，推演不出什么好东西，你还要推演吗？", 267, 0, "软件娃娃")

				if yesno("要继续推演内功吗？") then
					JY.Person[JY.Base.队伍1].武功2 = 91
					JY.Person[JY.Base.队伍1].武功等级2 = 900

					dark()
					light()
					say("好了，自己看看吧，现在的年轻人啊，真是不比当年...", 267, 0, "软件娃娃")
				else
					say("很好，继续努力吧，年轻人。", 267, 0, "软件娃娃")
				end

				return
			end

			say("好吧，推演需要的时间比较长，你将头挨着我的前额处，保持无思无想。", 267, 0, "软件娃娃")
			say("好吧。", 0, 1)
			dark()
			light()
			addtime(7)

			if JY.Base.畅想编号 == 0 then
				if JY.Base.主角职业 < 8 then
					say("太强了！我好像领悟到什么了..........", 280 + JY.Base.主角职业, 1, JY.Person[JY.Base.队伍1].姓名)
				else
					say("太强了！我好像领悟到什么了..........", 287 + JY.Base.特殊主角, 1, JY.Person[JY.Base.队伍1].姓名)
				end
			else
				say("太强了！我好像领悟到什么了..........", JY.Person[JY.Base.队伍1].头像代号, 1, JY.Person[JY.Base.畅想编号].姓名)
			end

			if JY.Base.可领悟六如 == 1 then
				JY.Base.觉醒 = 1
				JY.Person[0].武功2 = 91
				JY.Person[0].武功等级2 = 900
				JY.Wugong[91].名称 = "风林火山功"
				JY.Wugong[91].攻击力10 = 1300
				JY.Wugong[91].火毒 = 0
				JY.Wugong[91]["武功动画&音效"] = 6
				JY.Wugong[91].增幅攻击等级 = 10
				JY.Wugong[91].增幅防御等级 = 10
				JY.Wugong[91].增幅轻功等级 = 10

				DrawStrBox(-1, -1, "主角学会绝技--风林火山功", C_ORANGE, CC.DefaultFont)
				ShowScreen()
				lib.Delay(1000)
				Cls()

				if JY.Base.畅想编号 == 0 then
					DrawStrBox(-1, -1, "主角获得称号--觉醒之苍龙", C_ORANGE, CC.DefaultFont)
				end

				ShowScreen()
				lib.Delay(1000)
				SetS(10, 0, 12, 0, 1)
			else
				say("可惜，推演失败了。不过你的身体还有一些潜力，我已经将它激发出来了。", 267, 0, "软件娃娃")

				JY.Base.觉醒 = 1
				JY.Person[JY.Base.队伍1].攻击力 = JY.Person[JY.Base.队伍1].攻击力 + 30
				JY.Person[JY.Base.队伍1].防御力 = JY.Person[JY.Base.队伍1].防御力 + 30
				JY.Person[JY.Base.队伍1].轻功 = JY.Person[JY.Base.队伍1].轻功 + 30

				if T1LEQ(0) and JY.Base.畅想编号 == 0 then
					QZXS("获得称号：真苍半无双")
				end
			end

			if T2SQ(0) then
				QZXS("主角的左右互搏机率提升")
				QZXS("主角习得特技--火凤燎原")
			end

			if T3XXM(0) then
				QZXS("主角习得特技--森罗万象")
			end

			if T4RM(0) and JY.Base.畅想编号 == 0 then
				-- Nothing
			end

			say("可以了，哎，电量快耗光了。", 267, 0, "软件娃娃")
			addthing(337, -6)
			addevent(70, 69, 1, 70, 1, -2, -2, -2)
		end
	else
		say("我要看看其他的功能。", 0, 1)
		say("我还能帮你大幅激发身体的潜力。", 267, 0, "软件娃娃")
		say("等下。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 72, 1, -2, -2, -2)
	end
end
OEVENTLUA[72] = function ()
	Cls()

	if yesno("要激发潜力吗？") then
		dark()
		light()
		say("可以了。", 267, 0, "软件娃娃")
		addthing(337, -3)

		JY.Person[0].攻击力 = JY.Person[0].攻击力 + 30
		JY.Person[0].防御力 = JY.Person[0].防御力 + 30
		JY.Person[0].轻功 = JY.Person[0].轻功 + 30

		if JY.Person[0].生命增长 < 15 then
			AddPersonAttrib(0, "生命增长", 1)
		end

		DrawStrBoxWaitKey(string.format("%s攻防轻能力各提升30点", JY.Person[0].姓名), C_ORANGE, CC.DefaultFont)
		addevent(70, 69, 1, 70, 1, -2, -2, -2)
	else
		say("我要看看其他的功能。", 0, 1)
		say("你还可以抽取一门高深武功作为奖励。", 267, 0, "软件娃娃")
		say("等下。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 73, 1, -2, -2, -2)
	end
end
OEVENTLUA[73] = function ()
	Cls()

	local var_30_0 = JY.Person[550].拳掌功夫

	if yesno("要抽取高级武功秘笈吗？") then
		say("看见我帽子上的图案了吧，那几个大的图案，每一个都代表一门武功，你随便选一个图案按一下。", 267, 0, "软件娃娃")
		say("好。", 0, 1)
		dark()
		light()
		say("可以了。", 267, 0, "软件娃娃")

		if has_thing(var_30_0) == false then
			addthing(var_30_0, 1)
			addthing(337, -3)
		else
			say("可惜，你这次抽奖轮空了，下次再来吧。", 267, 0, "软件娃娃")
		end

		addevent(70, 69, 1, 70, 1, -2, -2, -2)
	else
		say("我要看看其他的功能。", 0, 1)
		say("你还可以抽取一门中等武功作为奖励。", 267, 0, "软件娃娃")
		say("等下。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 74, 1, -2, -2, -2)
	end
end
OEVENTLUA[74] = function ()
	Cls()

	local var_31_0 = JY.Person[550].御剑能力

	if yesno("要抽取中级武功秘笈吗？") then
		say("看见我帽子上的图案了吧，那几个大的图案，每一个都代表一门武功，你随便选一个图案按一下。", 267, 0, "软件娃娃")
		say("好。", 0, 1)
		dark()
		light()
		say("可以了。", 267, 0, "软件娃娃")

		if has_thing(var_31_0) == false then
			addthing(var_31_0, 1)
			addthing(337, -2)
		else
			say("可惜，你这次抽奖轮空了，下次再来吧。", 267, 0, "软件娃娃")
		end

		addevent(70, 69, 1, 70, 1, -2, -2, -2)
	else
		say("我要看看其他的功能。", 0, 1)
		say("你还可以抽取一门基础武功作为奖励。", 267, 0, "软件娃娃")
		say("等下。", 267, 0, "软件娃娃")
		addevent(70, 69, 1, 75, 1, -2, -2, -2)
	end
end
OEVENTLUA[75] = function ()
	Cls()

	local var_32_0 = JY.Person[550].耍刀技巧

	if yesno("要抽取基础武功秘笈吗？") then
		say("看见我帽子上的图案了吧，那几个大的图案，每一个都代表一门武功，你随便选一个图案按一下。", 267, 0, "软件娃娃")
		say("好。", 0, 1)
		dark()
		light()
		say("可以了。", 267, 0, "软件娃娃")

		if has_thing(var_32_0) == false then
			addthing(var_32_0, 1)
			addthing(337, -1)
		else
			say("可惜，你这次抽奖轮空了，下次再来吧。", 267, 0, "软件娃娃")
		end
	end

	addevent(70, 69, 1, 70, 1, -2, -2, -2)
end
OEVENTLUA[89] = function ()
	Cls()
	dark()
	My_Enter_SubScene(83, 14, 13, 2)
	light()
end
OEVENTLUA[90] = function ()
	Cls()
	dark()
	My_Enter_SubScene(70, 10, 28, 3)
	light()
end
OEVENTLUA[91] = function ()
	Cls()
	addevent(70, 18, 0, 66, 3, -2, -2, -2)

	if has_thing(326) then
		say("这个大药缸子正好可以用来做药浴炼体。", 0, 1)

		local var_35_0 = 0

		for iter_35_0 = 1, CC.MyThingNum do
			if JY.Base["物品" .. iter_35_0] == 209 then
				var_35_0 = JY.Base["物品数量" .. iter_35_0]

				break
			end
		end

		if var_35_0 <= 10 then
			say("可惜身上药材已经不够再使用一次的了", 0, 2)
		else
			DrawStrBox(CC.MainSubMenuX + 10, CC.MainSubMenuY, "要给谁洗身炼体？", C_WHITE, CC.DefaultFont)

			local var_35_1 = CC.MainSubMenuY + CC.SingleLineHeight
			local var_35_2 = SelectTeamMenu(CC.MainSubMenuX + 10, var_35_1)

			if var_35_2 == nil or var_35_2 < 1 then
				return
			end

			local var_35_3 = JY.Base["队伍" .. var_35_2]

			if var_35_3 >= 0 then
				dark()
				light()

				local var_35_4 = JY.Person[var_35_3].姓名

				if JY.Person[var_35_3].无用4 > 1 then
					local var_35_5 = math.modf(JY.Base.游戏难度 - 1)

					say("洗过之后果然神清气爽，精神百倍。", var_35_3, 0)
					AddPersonAttrib(var_35_3, "生命最大值", 20)
					instruct_47(var_35_3, 5 + var_35_5)
					instruct_43(var_35_3, 5 + var_35_5)
					instruct_45(var_35_3, 5 + var_35_5)

					JY.Person[var_35_3].无用4 = JY.Person[var_35_3].无用4 - 1

					addthing(209, -10)
				else
					say("洗过之后似乎没有什么变化。", var_35_3, 0)
				end

				addtime(1)

				return 1
			else
				Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

				return 0
			end
		end
	end
end
OEVENTLUA[95] = function ()
	Cls()
	addevent(70, 18, 0, 66, 3, -2, -2, -2)

	if JY.Person[0].医疗能力 >= 30 and has_something(209, 10) and (JY.Person[0].中毒程度 > 0 or JY.Person[0].受伤程度 > 0 or JY.Person[0].流血值 > 0 or JY.Person[0].生命 < JY.Person[0].生命最大值) then
		say("既有药材，我就做个药浴，洗去身上伤势吧。", 0, 1)
		say("不过这池子要稍微改造下。", 0, 1)
		dark()
		light()
		say("好了，可以使用了。", 0, 1)
		addevent(70, 47, 1, 96, 1, -2, -2, -2)
	end
end
OEVENTLUA[96] = function ()
	Cls()

	if JY.Person[0].中毒程度 > 0 or JY.Person[0].受伤程度 > 0 or JY.Person[0].流血值 > 0 or JY.Person[0].生命 < JY.Person[0].生命最大值 then
		say("且泡一下药浴，恢复一下身体状态。", 0, 1)

		if has_something(209, 2) == false then
			say("可惜药材不够了。", 0, 1)

			return
		end

		addtime(1)
		say("好舒服。", 0, 1)

		for iter_37_0 = 1, CC.TeamNum do
			local var_37_0 = JY.Base["队伍" .. iter_37_0]

			if var_37_0 >= 0 then
				JY.Person[var_37_0].中毒程度 = 0
				JY.Person[var_37_0].受伤程度 = 0
				JY.Person[var_37_0].流血值 = 0
				JY.Person[var_37_0].生命 = JY.Person[var_37_0].生命 + 100

				if JY.Person[var_37_0].生命 > JY.Person[var_37_0].生命最大值 then
					JY.Person[var_37_0].生命 = JY.Person[var_37_0].生命最大值
				end

				JY.Person[var_37_0].体力 = JY.Person[var_37_0].体力 + 30

				if JY.Person[var_37_0].体力 > 100 then
					JY.Person[var_37_0].体力 = 100
				end

				JY.Person[var_37_0].内力 = JY.Person[var_37_0].内力 + 500

				if JY.Person[var_37_0].内力 > JY.Person[var_37_0].内力最大值 then
					JY.Person[var_37_0].内力 = JY.Person[var_37_0].内力最大值
				end
			end
		end

		addthing(209, -2)
	else
		say("没有受伤，就不要泡澡了。", 0, 1)
	end
end
OEVENTLUA[97] = function ()
	Cls()

	local var_38_0 = JY.Person[0]
	local var_38_1 = var_38_0.修炼物品

	if var_38_1 > 0 then
		say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

		if JY.Thing[var_38_1].练出物品需经验 <= 0 then
			return
		end

		dark()
		light()
		addtime(1)

		var_38_0.物品修炼点数 = 300

		War_PersonTrainDrug(0)
	elseif has_something(209, 2) and JY.Person[0].医疗能力 >= 20 then
		say("今日闲暇，就用这药炉炼制一些丹药吧", 0, 1)

		local var_38_2 = {
			9,
			20
		}
		local var_38_3 = var_38_2[math.random(#var_38_2)]

		addtime(1)
		addthing(var_38_3)
		addthing(209, -2)
	else
		say("一座古朴的大药炉，似乎是商朝时期的", 0, 1)
	end
end
OEVENTLUA[101] = function ()
	Cls()

	if has_thing(234) then
		say("阿财，我送你去中原。", 514, 0, "守卫")
		say("好，能直接去武当吗？", 0, 1)
		say("我可以送你到洛阳，武当离洛阳不远。", 514, 0, "守卫")
		say("也好。", 0, 1)
		say("我们走。", 514, 0, "守卫")
		dark()
		My_Enter_SubScene(40, 29, 56, 2)
		addevent(40, 83, 1, 0, 1, 5264, -2, -2)
		light()

		if has_thing(182) then
			addtime(18)
		else
			addtime(20)
		end

		say("我们到洛阳了，阿财，武当就在洛阳的西南方向，接下来的路要你自己走了。", 514, 0, "守卫")
		say("我知道了，放心吧。", 0, 1)
		say("老爷和大姐大都很看重你，一路小心。", 514, 0, "守卫")
		dark()
		null(40, 83)
		addevent(40, 96, 1, 102, 1, 5268, -2, -2)
		addevent(70, 71, 1, 109, 1, 5266, -2, -2)
		addevent(70, 72, 1, -2, 1, 9586, -2, -2)
		light()
	else
		say("这是大姐大商队，要去洛阳的。", 514, 0, "守卫")
		say("洛阳？能带我去吗？", 0, 1)
		say("没问题。", 514, 0, "守卫")
		say("我们走。", 514, 0, "守卫")
		dark()
		My_Enter_SubScene(40, 29, 56, 2)
		addevent(40, 83, 1, 0, 1, 5264, -2, -2)
		light()
		addtime(20)
		say("我们到洛阳了，阿财，洛阳这儿龙蛇混杂，你要小心一些。", 514, 0, "守卫")
		say("我知道了，放心吧。", 0, 1)
		null(40, 83)
		addevent(40, 96, 1, 102, 1, 5268, -2, -2)
		addevent(70, 71, 1, 109, 1, 5266, -2, -2)
		addevent(70, 72, 1, -2, 1, 9586, -2, -2)
	end
end
OEVENTLUA[102] = function ()
	Cls()
	say("财少爷好。", 514, 0, "守卫")
	say("咦？你怎么在这儿？", 0, 1)
	say("大姐大准备把生意做到洛阳来，现在咱们到洛阳的商路已经打通了，很快这就有咱们的落脚点了。", 514, 0, "守卫")
	dark()
	addevent(40, 105, 1, 0, 1, 8246, -2, -2)
	addevent(40, 106, 1, 0, 1, 10140, -2, -2)
	addevent(40, 107, 1, 0, 1, 10140, -2, -2)
	light()
	say("这谁的店铺啊？老板呢？交这个月的保护费了，100两只能多不能少。", 1129, 0, "帮众")
	say("你们是扳刀门的人？上次你们来收保护费我就说了，本店才刚刚开张，还请几位兄弟宽限些日子。", 514, 0, "守卫")
	say("新来的吧？果然不知道规矩，咱们是开门就得交费，你以为兄弟们在这条街上是白晃悠的呢？", 1129, 0, "帮众")
	say("几位兄弟，还请给在下一个面子，这是给弟兄们的茶酒钱。", 514, 0, "守卫")
	say("你谁啊？给你的面子？不给是吧，兄弟们，给我砸！", 1129, 0, "帮众")
	say("找死！", 0, 1)

	if WarMain(338, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("滚！", 0, 1)
	say("你们敢动手反抗，等着，我们老大很快就来！", 1129, 0, "帮众")
	dark()
	null(40, 105)
	null(40, 106)
	null(40, 107)
	light()
	say("财少爷武艺居然这么高了？不愧是老爷选中的人。", 514, 0, "守卫")
	say("呵呵，咱们等等这个什么老大，今日就把这事解决了。", 0, 1)
	say("好。", 514, 0, "守卫")
	dark()
	addevent(40, 105, 1, 0, 1, 10098, -2, -2)
	addevent(40, 106, 1, 0, 1, 10140, -2, -2)
	addevent(40, 107, 1, 0, 1, 10140, -2, -2)
	light()
	say("是谁打伤了我的人？给我滚出来！", 1132, 0, "帮派首领")
	say("财少爷，他们来了。", 514, 0, "守卫")
	say("是你们？兄弟们，给我打！", 1132, 0, "帮派首领")
	say("呵呵，不知死活。", 0, 1)

	if WarMain(335, 0, 1, 1) == false then
		instruct_15(0)
		instruct_0()

		return
	end

	say("饶命啊！小的有眼不识泰山，还请恕罪。", 1132, 0, "帮派首领")
	say("滚，再来就打断你们的腿！", 0, 1)
	say("是，是。", 1132, 0, "帮派首领")
	dark()
	null(40, 105)
	null(40, 106)
	null(40, 107)
	light()

	if JY.Person[578].好感度 >= 65 then
		say("洛阳有我野狗帮的人，我会叫他们在周围巡逻，免得还有人来捣乱。", 0, 1)
		say("好。", 514, 0, "守卫")
	else
		say("好，财少爷好气势。", 514, 0, "守卫")
	end

	addevent(40, 96, 1, 109, 1, 5268, -2, -2)
	addevent(40, 95, 1, 120, 1, 5106, -2, -2)

	JY.Scene[40].马车开通 = 1
	JY.Person[620].好感度 = 70
end
OEVENTLUA[104] = function ()
	Cls()
	say("财少爷好。", 514, 0, "守卫")
	say("嗯？你是小村的人？", 0, 1)
	say("是啊，大姐大说有你在北京，我们就可以来北方发展了。", 514, 0, "守卫")
	say("哦，大姐大消息真是灵通啊。", 0, 1)
	say("那是，财少爷，我们这要有捣乱的报你的名号可好。", 514, 0, "守卫")

	if JY.Person[583].好感度 >= 65 then
		say("北京有我野狗帮的人，我会叫他们在周围巡逻，免得还有人来捣乱。", 0, 1)
		say("好。", 514, 0, "守卫")
	else
		say("没问题。", 0, 1)
		say("好，财少爷好气魄。", 514, 0, "守卫")
	end

	addevent(107, 56, 1, 109, 1, 5268, -2, -2)

	JY.Scene[107].马车开通 = 1
	JY.Person[620].好感度 = 80

	addevent(60, 22, 1, 105, 1, 5266, -2, -2)
	addevent(60, 23, 1, -2, 1, 9586, -2, -2)
end
OEVENTLUA[105] = function ()
	Cls()
	say("财少爷好。", 514, 0, "守卫")
	say("咦？你是小村的人？你们怎么跑到这西北边漠来了？", 0, 1)
	say("大姐大一直想重新打通丝绸古路，如今财力人力足够，大姐大已经开始安排这个事情了。", 514, 0, "守卫")
	say("大姐大真是好气魄。", 0, 1)
	say("不错，现在咱们已经打通了到这儿的商路，财少爷要是想回小村就可以到这里找我。", 514, 0, "守卫")
	say("很好，可有要我出手的？", 0, 1)
	say("不用，大姐大和龙门客栈的老板娘已经结成了好姐妹，在这块地界，没人敢动我们。", 514, 0, "守卫")
	say("那就好。", 0, 1)
	addevent(60, 22, 1, 109, 1, 5266, -2, -2)

	JY.Scene[60].马车开通 = 1
	JY.Person[620].好感度 = 90
end
OEVENTLUA[109] = function ()
	Cls()
	say("财少爷好，你需要我帮忙吗？", 514, 0, "守卫")
	say("嗯，我看下咱们现在有到哪的商队，出去办点事。", 0, 1)
	say("财少爷，咱们现在有这些地方的商队在活动。", 514, 0, "守卫")
	My_mache_List()
end
OEVENTLUA[110] = function ()
	Cls()
	say("财少爷好。", 514, 0, "守卫")
	say("你是小村大姐大商会的？", 0, 1)
	say("不错，这是大姐大商会在这儿的分店，财少爷有事可以过来，咱们有开辟的商路，财少爷可以乘坐马车往返小村和各地。", 514, 0, "守卫")

	if yesno("要乘坐小村马车吗？") then
		say("我们走。", 514, 0, "守卫")
		My_mache_List()
	end
end
OEVENTLUA[120] = function ()
	Cls()

	if JY.Base.百年标记 == 0 then
		say("财少爷好。", 1022, 0, "分店掌柜")

		if JY.Person[620].好感度 == 90 then
			say("我们和龙门商会有了合作，现在可以回收各种物品，还可以兑换银票了。", 1022, 0, "掌柜")

			local var_45_0 = JYMsgBox("大姐大商会", "高价回收各类物品**提供银两/银票兑换服务", {
				"卖出物品",
				"兑换服务"
			}, 2, 1022, 1)

			if var_45_0 == 1 then
				sell(1022, 2)
			elseif var_45_0 == 2 then
				local var_45_1 = JYMsgBox("兑换服务", " 1张銀票 = 10000银两，手续费5个点。 ", {
					"兑换銀票",
					"兑换银两"
				}, 2, 1022, 1)

				if var_45_1 == 1 then
					local var_45_2 = math.modf(JY.GOLD / 10500)

					if var_45_2 > 0 then
						local var_45_3 = InputNum("兑换数量", 1, var_45_2, 1)

						if var_45_3 ~= nil then
							addthing(174, -10500 * var_45_3)
							addthing(327, var_45_3)
						end
					else
						say("您身上的银两好像不够呢。", 1022, 0, "掌柜")
					end
				elseif var_45_1 == 2 then
					local var_45_4 = 0

					for iter_45_0 = 1, CC.MyThingNum do
						if JY.Base["物品" .. iter_45_0] == -1 then
							break
						end

						if JY.Base["物品" .. iter_45_0] == 327 then
							var_45_4 = JY.Base["物品数量" .. iter_45_0]

							break
						end
					end

					if var_45_4 > 0 then
						local var_45_5 = InputNum("使用数量", 1, var_45_4, 1)

						if var_45_5 ~= nil then
							addthing(327, -var_45_5)
							addthing(174, 10000 * var_45_5)
						end
					else
						say("没有銀票无法兑换。", 1022, 0, "掌柜")
					end
				end
			end
		else
			say("这儿都卖些什么？", 0, 1)
			say("这是大姐大商会在这儿的分店，主要经营茶叶和瓷器这些东西。", 1022, 0, "分店掌柜")
		end
	else
		say("客人，你需要什么茶叶或瓷器？", 1022, 0, "分店掌柜")
	end
end
