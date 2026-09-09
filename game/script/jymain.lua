function IncludeFile()
	package.path = CONFIG.ScriptLuaPath

	require("jyconst")
	require("readkdef")
	require("jywar")
	require("jyyb")
	require("OEvent001")
	require("OEvent8001")
	require("OEvent6001")
	require("OEvent9001")
	require("OEvent1101")
	require("OEvent1301")
	require("OEvent1501")
	require("OEvent1701")
	require("OEvent1901")
	require("OEvent2301")
	require("OEvent2501")
	require("OEvent2701")
	require("OEvent2901")
end

function SetGlobal()
	JY = {}
	JY.Status = GAME_INIT
	JY.Base = {}
	JY.PersonNum = 0
	JY.Person = {}
	JY.ThingNum = 0
	JY.Thing = {}
	JY.SceneNum = 0
	JY.Scene = {}
	JY.WugongNum = 0
	JY.Wugong = {}
	JY.ShopNum = 0
	JY.Shop = {}
	JY.Data_Base = nil
	JY.Data_Person = nil
	JY.Data_Thing = nil
	JY.Data_Scene = nil
	JY.Data_Wugong = nil
	JY.Data_Shop = nil
	JY.wjjc1 = {}
	JY.wjjc2 = {}
	JY.MyCurrentPic = 0
	JY.MyPic = 0
	JY.Mytick = 0
	JY.MyTick2 = 0
	JY.CDD = 0
	JY.LOADTIME = 0
	JY.SAVETIME = 0
	JY.GTIME = 0
	JY.JB = 1
	JY.GOLD = 0
	JY.WGLVXS = 0
	JY.MY = 0
	JY.ZJSL = 0
	JY.SID = nil
	JY.LID = nil
	JY.XZSPD = 1
	JY.MV = 0
	JY.MAPKJ = 0
	JY.HEADXZ = 1
	JY.LEQ = "零二七"
	JY.SQ = "水镜四奇"
	JY.XXM = "小虾米"
	JY.RM = "冉闵"
	JY.SMKG = 0
	JY.YEAR = 0
	JY.MONTH = 1
	JY.DAY = 1
	JY.TIMECOUNT = 0
	yxsdate = {}
	yxsd = {}
	JY.TF = 0
	JY.CXTF = 0
	JY.SJBJ = math.random(4)
	JY.SubScene = -1
	JY.SubSceneX = 0
	JY.SubSceneY = 0
	JY.Darkness = 0
	JY.CurrentD = -1
	JY.OldDPass = -1
	JY.CurrentEventType = -1
	JY.CurrentThing = -1
	JY.MmapMusic = -1
	JY.CurrentMIDI = -1
	JY.EnableMusic = 1
	JY.EnableSound = 1
	JY.ThingUseFunction = {}
	JY.SceneNewEventFunction = {}
	WAR = {}
end

function JY_Main()
	os.remove("debug.txt")
	xpcall(JY_Main_sub, myErrFun)
end

function myErrFun(arg_4_0)
	lib.Debug(arg_4_0)
	lib.Debug(debug.traceback())
end

function JY_Main_sub()
	IncludeFile()
	SetGlobalConst()
	SetGlobal()
	GenTalkIdx()
	setmetatable(_G, {
		__newindex = function (arg_6_0, arg_6_1)
			error("attempt read write to undeclared variable " .. arg_6_1, 2)
		end,
		__index = function (arg_7_0, arg_7_1)
			error("attempt read read to undeclared variable " .. arg_7_1, 2)
		end
	})
	lib.Debug("JY_Main start.")
	math.randomseed(os.time())
	lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRePeatInterval)

	JY.Status = GAME_START

	lib.PicInit(CC.PaletteFile)
	lib.FillColor(0, 0, 0, 0, 0)
	lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 800 * 100, 0, 100))
	PlayMIDI(11)
	Cls()
	lib.ShowSlow(50, 0)

	if StartMenu() ~= nil then
		return
	end

	lib.LoadPicture("", 0, 0)
	lib.GetKey()
	Game_Cycle()
end

function loadpng1()
	local var_8_0 = math.random(5)
	local var_8_1 = 0

	if var_8_0 == 1 then
		var_8_1 = lib.LoadPicture(CC.FirstFile1, -1, -1)
	elseif var_8_0 == 2 then
		var_8_1 = lib.LoadPicture(CC.FirstFile2, -1, -1)
	elseif var_8_0 == 3 then
		var_8_1 = lib.LoadPicture(CC.FirstFile3, -1, -1)
	else
		var_8_1 = lib.LoadPicture(CC.FirstFile4, -1, -1)
	end

	return var_8_1
end

function StartMenu()
	-- [port] Menu_Exit reaches the title without going through
	-- JY_Main_sub, which is where these two normally happen (122, 127).
	JY.Status = GAME_START
	PlayMIDI(11)
	Cls()
	loadpng1()

	local var_9_0 = {
		{
			"重新开始",
			nil,
			1
		},
		{
			"载入进度",
			nil,
			1
		},
		{
			"离开游戏",
			nil,
			1
		}
	}
	local var_9_1 = (CC.ScreenW - 4 * CC.StartMenuFontSize - 2 * CC.MenuBorderPixel) / 2
	local var_9_2 = ShowMenu(var_9_0, 3, 0, var_9_1, CC.StartMenuY, 0, 0, 0, 0, CC.StartMenuFontSize, C_STARTMENU, C_RED)

	Cls()

	if var_9_2 == 1 then
		NewGame()

		JY.SubScene = CC.NewGameSceneID
		JY.Base.人X1 = 8
		JY.Base.人Y1 = 27

		if JY.Person[0].性别 == 1 then
			JY.MyPic = CC.NewPersonPicF
		else
			JY.MyPic = CC.NewPersonPicM
		end

		JY.Status = GAME_SMAP
		JY.MmapMusic = -1

		CleanMemory()
		Init_SMap(0)
		lib.ShowSlow(50, 0)
	elseif var_9_2 == 2 then
		loadpng1()

		local var_9_3 = (CC.ScreenW - 38.5 * CC.FontSmall3 - 2 * CC.MenuBorderPixel) / 3
		local var_9_4 = (CC.ScreenH - 1 * (CC.FontSmall3 + CC.RowPixel)) / 3

		DrawStrBox(var_9_3, var_9_4, string.format("%-8s %-7s %-4s %-4s %8s %13s %-10s %-10s", "  存档", "姓名", "年龄", "门派", "阶级", "位置", "难度", "存档时间          "), C_ORANGE, CC.FontSmall3, C_GOLD)  -- [port] see docs/PATCHES.md

		local var_9_5 = SaveList()

		if var_9_5 < 1 then
			return (StartMenu())
		end

		Cls()
		DrawStrBox(-1, CC.StartMenuY, "请稍候...", C_GOLD, CC.DefaultFont)
		ShowScreen()

		if LoadRecord(var_9_5) ~= nil then
			StartMenu()

			return
		end

		if JY.Base.存档标识 ~= -1 then
			if JY.SubScene < 0 then
				CleanMemory()
				lib.UnloadMMap()
			end

			lib.PicInit()
			lib.ShowSlow(50, 1)

			JY.Status = GAME_SMAP
			JY.SubScene = JY.Base.存档标识
			JY.MmapMusic = -1
			JY.MyPic = GetMyPic()

			Init_SMap(1)
		else
			JY.SubScene = -1
			JY.Status = GAME_FIRSTMMAP
		end
	elseif var_9_2 == 3 then
		JY_Main()
	end
end

function CleanMemory()
	if CONFIG.CleanMemory == 1 then
		collectgarbage("collect")
	end
end

function NewGame()
	LoadRecord(0)
	ClsN()

	local var_11_0 = limitX(CC.CircleNum + 3, 1, #MODEXZ2)

	JY.Base.游戏难度 = JYMsgBox("难度选择", " 请选择游戏难度。 * 如果是对本游戏世界不熟悉，则强烈建议选新手难度 ", MODEXZ2, var_11_0, 1115)

	local var_11_1 = JYMsgBox("请选择角色类型", "想要用哪种类型的角色呢？", {
		"普通",
		"特殊",
		"畅想"
	}, 3, 1115)
	local var_11_2 = JY.Base.游戏难度
	local var_11_3 = 20

	for iter_11_0 = 1, CC.Kungfunum do
		JY.Person[0]["武功" .. iter_11_0] = 0
		JY.Person[0]["武功等级" .. iter_11_0] = 0
	end

	GRTS[0] = "无"

	if JY.Base.游戏难度 < 3 then
		JY.Person[0].攻击力 = 60
		JY.Person[0].防御力 = 60
		JY.Person[0].轻功 = 60
	end

	JY.Person[0].武功1 = 121
	JY.Person[0].武功等级1 = 10

	if var_11_1 == 1 then
		local var_11_4

		if JYMsgBox("请选择", "请选择你的主角性别 ", {
			"男",
			"女"
		}, 2, 1115) == 2 then
			JY.Person[0].性别 = 1
			JY.Person[0].头像代号 = 303

			local var_11_5 = {
				{
					0,
					0,
					0
				},
				{
					9,
					2,
					3
				},
				{
					8,
					3,
					4
				},
				{
					8,
					3,
					4
				},
				{
					9,
					5,
					6
				}
			}

			for iter_11_1 = 1, 5 do
				JY.Person[0]["出招动画帧数" .. iter_11_1] = var_11_5[iter_11_1][1]
				JY.Person[0]["出招动画延迟" .. iter_11_1] = var_11_5[iter_11_1][3]
				JY.Person[0]["武功音效延迟" .. iter_11_1] = var_11_5[iter_11_1][2]
			end
		else
			JY.Person[0].性别 = 0
			JY.Person[0].头像代号 = 0
		end

		DrawStrBoxWaitKey("请选择你的主角姓名", C_WHITE, CC.DefaultFont)

		JY.Person[0].姓名 = CC.NewPersonName

		while JY.Person[0].姓名 == CC.NewPersonName do
			JY.Person[0].姓名 = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)

			if JY.Person[0].姓名 == "" then
				DrawStrBoxWaitKey("大侠，没名字怎么玩游戏？", C_WHITE, CC.DefaultFont)

				JY.Person[0].姓名 = "无名氏"
			end
		end

		JY.TZ = JYMsgBox("请根据现实中的你选择主角的体质", TZSAY1, TZX, 10, 1115)

		if JY.TZ == 1 then
			JY.Base.主角职业 = 1
			JY.Person[0].生命增长 = 1
		elseif JY.TZ == 2 then
			JY.Base.主角职业 = 2
			JY.Person[0].生命增长 = 2
		elseif JY.TZ == 3 then
			JY.Person[0].生命增长 = 3
		elseif JY.TZ == 4 then
			JY.Person[0].生命增长 = 4
		elseif JY.TZ == 5 then
			JY.Person[0].生命增长 = 5
		elseif JY.TZ == 6 then
			JY.Person[0].生命增长 = 6
		elseif JY.TZ == 7 then
			JY.Person[0].生命增长 = 7
		elseif JY.TZ == 8 then
			JY.Person[0].生命增长 = 8
		elseif JY.TZ == 9 then
			JY.Person[0].生命增长 = 9
		elseif JY.TZ == 10 then
			JY.Person[0].生命增长 = 10
		end

		ClsN()

		local var_11_6 = 250
		local var_11_7 = 50
		local var_11_8 = CC.FontSmall3 + CC.PersonStateRowPixel
		local var_11_9 = 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_9, "精神=1：你经常头晕，微微耗神就会晕倒", C_WHITE, CC.FontSmall3)

		local var_11_10 = var_11_9 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_10, "精神=2：你一用脑就头疼，这让你几乎什么都做不了", C_WHITE, CC.FontSmall3)

		local var_11_11 = var_11_10 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_11, "精神=3：这是当代大学生的普通水准", C_WHITE, CC.FontSmall3)

		local var_11_12 = var_11_11 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_12, "精神=4：你的精神健旺，即使疼痛也打击不倒你", C_WHITE, CC.FontSmall3)

		local var_11_13 = var_11_12 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_13, "精神=5：你的精神强健，比起特训过的特工或杀手也不差分毫", C_WHITE, CC.FontSmall3)

		local var_11_14 = var_11_13 + 10

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_14, "精神=6：身经百战，百折不挠说得就是你", C_WHITE, CC.FontSmall3)

		local var_11_15 = var_11_14 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_15, "精神=7：你能轻易感觉到他人的情绪，这让你总以为自己有特异功能", C_WHITE, CC.FontSmall3)

		local var_11_16 = var_11_15 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_16, "精神=8：曾有活佛说过你是转世灵身，你当天就觉得身上发着金光", C_WHITE, CC.FontSmall3)

		local var_11_17 = var_11_16 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_17, "精神=9：或许世界有仙佛，因为你就可以控制自身的疼痛情绪甚至部分的体液流动", C_WHITE, CC.FontSmall3)

		local var_11_18 = var_11_17 + 1

		DrawString(var_11_6, var_11_7 + var_11_8 * var_11_18, "精神=10：你刚出生那天就意识到自己与别人的不同，你就是世界的主角", C_WHITE, CC.FontSmall3)

		JY.Person[0].精神 = InputNum("请参照现实中的你输入主角的精神", 1, 10)

		ClsN()

		local var_11_19 = 250
		local var_11_20 = 50
		local var_11_21 = 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_21, "悟性<=10：你既不会说话也不会思想，你能玩游戏本身就是个bug", C_WHITE, CC.FontSmall3)

		local var_11_22 = var_11_21 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_22, "10<悟性<=20：你有简单的思想，吃和饿是你唯二会说的话", C_WHITE, CC.FontSmall3)

		local var_11_23 = var_11_22 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_23, "20<悟性<=30：你说不出完整的话语，别人都叫你白痴", C_WHITE, CC.FontSmall3)

		local var_11_24 = var_11_23 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_24, "30<悟性<=40：你的思维总是比别人慢很多，能自己养活自己都是奇迹", C_WHITE, CC.FontSmall3)

		local var_11_25 = var_11_24 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_25, "40<悟性<=50：你的反应总是比别人慢一线，特别是说笑话的时候", C_WHITE, CC.FontSmall3)

		local var_11_26 = var_11_25 + 10

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_26, "50<悟性<=60：这是当前绝大多数人的属性值", C_WHITE, CC.FontSmall3)

		local var_11_27 = var_11_26 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_27, "60<悟性<=70：你上中学时很轻松就能挤到年级前10", C_WHITE, CC.FontSmall3)

		local var_11_28 = var_11_27 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_28, "70<悟性<=80：你从小到大学什么都很快，每个人都觉得你以后必将有所成就", C_WHITE, CC.FontSmall3)

		local var_11_29 = var_11_28 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_29, "80<悟性<=90：你是绝对的天才，无论做什么你都不拿第二，除了蛮力", C_WHITE, CC.FontSmall3)

		local var_11_30 = var_11_29 + 1

		DrawString(var_11_19, var_11_20 + var_11_8 * var_11_30, "90<悟性<=100：爱因斯坦达芬奇最多也就你这水平了", C_WHITE, CC.FontSmall3)

		JY.Person[0].悟性 = InputNum("请参照现实中的你输入主角的悟性", 1, 100)

		ClsN()

		local var_11_31 = 250
		local var_11_32 = 50
		local var_11_33 = 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_33, "魅力=1：没有人敢看你一眼，你的颜值就是一个传说", C_WHITE, CC.FontSmall3)

		local var_11_34 = var_11_33 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_34, "魅力=2：别提了，绝对是地狱级别", C_WHITE, CC.FontSmall3)

		local var_11_35 = var_11_34 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_35, "魅力=3：一个字，好丑", C_WHITE, CC.FontSmall3)

		local var_11_36 = var_11_35 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_36, "魅力=4：你就是所谓的略丑，要靠气质来弥补", C_WHITE, CC.FontSmall3)

		local var_11_37 = var_11_36 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_37, "魅力=5：无论你怎么打扮，别人都不会关注到你的长相", C_WHITE, CC.FontSmall3)

		local var_11_38 = var_11_37 + 10

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_38, "魅力=6：周围的年轻人老是看你，你就是所谓的班花班草", C_WHITE, CC.FontSmall3)

		local var_11_39 = var_11_38 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_39, "魅力=7：电视上的美女帅哥也并不比你强多少", C_WHITE, CC.FontSmall3)

		local var_11_40 = var_11_39 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_40, "魅力=8：站在任何明星大腕面前你都毫不逊色", C_WHITE, CC.FontSmall3)

		local var_11_41 = var_11_40 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_41, "魅力=9：年轻人都不敢正眼看你，他们怕自己自惭形秽", C_WHITE, CC.FontSmall3)

		local var_11_42 = var_11_41 + 1

		DrawString(var_11_31, var_11_32 + var_11_8 * var_11_42, "魅力=10：你就和妲己一个级别，甚至更完美", C_WHITE, CC.FontSmall3)

		JY.Person[0].魅力 = InputNum("请参照现实中的你输入主角的魅力", 1, 10)

		ClsN()

		local var_11_43 = JYMsgBox("请选择", "想要哪种属性的内力", {
			"阴性",
			"阳性",
			"调和"
		}, 3, 1115)

		if var_11_43 == 1 then
			JY.Person[0].内力性质 = 0
		elseif var_11_43 == 2 then
			JY.Person[0].内力性质 = 1
		else
			JY.Person[0].内力性质 = 2
		end

		JY.TF = JYMsgBox("请选择你的主角的天赋能力", TFXZSAY1, TFE, 9, 1115)
		JY.Base.可领悟六如 = 1

		if JY.TF == 1 then
			JY.Base.主角职业 = 1
			JY.Person[0].拳掌功夫 = 30 + CC.CircleNum
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 2 then
			JY.Base.主角职业 = 2
			JY.Person[0].御剑能力 = 30 + CC.CircleNum
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].畅想级别 = "8"
		elseif JY.TF == 3 then
			JY.Base.主角职业 = 3
			JY.Person[0].耍刀技巧 = 30 + CC.CircleNum
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 4 then
			JY.Base.主角职业 = 4
			JY.Person[0].特殊兵器 = 30 + CC.CircleNum
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 5 then
			JY.Person[0].内力最大值 = 500
			JY.Person[0].内力 = 500
			JY.Person[0].内力性质 = 2
			JY.Base.主角职业 = 5
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 6 then
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].品德 = 100
			JY.Person[0].拳掌功夫 = 20 + CC.CircleNum
			JY.Person[0].御剑能力 = 20 + CC.CircleNum
			JY.Person[0].耍刀技巧 = 20 + CC.CircleNum
			JY.Person[0].特殊兵器 = 20 + CC.CircleNum
			JY.Base.主角职业 = 6
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 7 then
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].医疗能力 = 100
			JY.Person[0].用毒能力 = 30
			JY.Person[0].解毒能力 = 30
			JY.Base.主角职业 = 7
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 8 then
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].医疗能力 = 30
			JY.Person[0].用毒能力 = 100
			JY.Person[0].解毒能力 = 100
			JY.Person[0].攻击带毒 = 10
			JY.Base.主角职业 = 8
			JY.Person[0].畅想级别 = "7"
		elseif JY.TF == 9 then
			JY.Person[0].副功体显示 = "禁用"
			JY.Person[0].暗器技巧 = 30 + CC.CircleNum
			JY.Person[0].攻击带毒 = 10
			JY.Base.主角职业 = 9
			JY.Person[0].畅想级别 = "7"
		end

		JY.Person[0].天赋 = ZJTF[JY.Base.主角职业]
	end

	ClsN()

	if var_11_1 == 2 then
		ClsN()

		local var_11_44 = JYMsgBox("要选择哪位特殊人物", "【零】天赋：颖悟绝伦 称号：苍半无双 *【水】天赋：万般皆通 称号：百花谷主 *【小】天赋：笨鸟先飞 称号：武林至尊 *【冉】天赋：攻战无前 称号：武悼天王 ", TSXMLB, 4, 1115)

		if var_11_44 == 2 then
			JY.Person[0].姓名 = TSXMLB[2]
			JY.Person[0].畅想级别 = "7"
		elseif var_11_44 == 3 then
			JY.Person[0].姓名 = TSXMLB[3]
			JY.Person[0].畅想级别 = "7"
		elseif var_11_44 == 1 then
			JY.Person[0].姓名 = TSXMLB[1]
			JY.Person[0].畅想级别 = "7"
		elseif var_11_44 == 4 then
			JY.Person[0].姓名 = TSXMLB[4]
			JY.Person[0].畅想级别 = "8"

			local var_11_45 = JYMsgBox("请选择", "想要哪种属性的内力", {
				"阴性",
				"阳性",
				"调和"
			}, 3, 1115)

			if var_11_45 == 1 then
				JY.Person[0].内力性质 = 0
			elseif var_11_45 == 2 then
				JY.Person[0].内力性质 = 1
			else
				JY.Person[0].内力性质 = 2
			end

			ClsN()

			JY.Person[0].悟性 = InputNum("请输入悟性", 1, 100)
		end

		JY.Person[0].头像代号 = 0
		JY.Base.畅想编号 = 0
		JY.Person[0].天赋 = RWTFLB[JY.Base.畅想编号]
	end

	ClsN()

	if var_11_1 == 3 then
		local var_11_46 = {}

		for iter_11_2 = 1, JY.PersonNum - 1 do
			var_11_46[#var_11_46 + 1] = {
				JY.Person[iter_11_2].姓名,
				nil,
				1,
				iter_11_2
			}
		end

		for iter_11_3 = 1, #var_11_46 do
			if JY.Person[iter_11_3].畅想级别 < 4 or JY.Person[iter_11_3].畅想级别 > 100 then
				var_11_46[iter_11_3][3] = 2
			elseif JY.Person[iter_11_3].畅想级别 < 5 and CC.CircleNum > 0 then
				var_11_46[iter_11_3][3] = 1
			elseif JY.Person[iter_11_3].畅想级别 < 8 and CC.CircleNum > 1 then
				var_11_46[iter_11_3][3] = 1
			elseif JY.Person[iter_11_3].畅想级别 < 9 and CC.CircleNum > 2 then
				var_11_46[iter_11_3][3] = 1
			elseif JY.Person[iter_11_3].畅想级别 < 10 and CC.CircleNum > 3 then
				var_11_46[iter_11_3][3] = 1
			elseif JY.Person[iter_11_3].畅想级别 < 13 and CC.CircleNum > 4 then
				var_11_46[iter_11_3][3] = 1
			else
				var_11_46[iter_11_3][3] = 3
			end
		end

		var_11_46[30][1] = "郭靖-南山"
		var_11_46[55][1] = "郭靖-降龙"

		Cls()

		local var_11_47 = ShowMenu2(var_11_46, #var_11_46, 5, 12, -1, -1, 0, 0, 0, 0, CC.DefaultFont, C_ORANGE, C_WHITE, "请选择畅想主角")

		if var_11_47 > 0 then
			var_11_47 = var_11_46[var_11_47][4]
		end

		local var_11_48
		local var_11_49 = var_11_46[var_11_47][4]

		ClsN()

		JY.Base.畅想编号 = var_11_49

		for iter_11_4 = 1, #PSX do
			JY.Person[0][PSX[iter_11_4]] = JY.Person[var_11_49][PSX[iter_11_4]]
		end

		JY.Person[0].姓名 = JY.Person[var_11_49].姓名
		JY.Person[0].品德 = 50
		JY.Person[0].等级 = 1
		JY.Person[0].经验 = 0
		JY.Base.主角职业 = nil
		JY.Person[0].天赋 = RWTFLB[JY.Base.畅想编号]

		if JY.Base.游戏难度 < 3 then
			JY.Person[0].攻击力 = 50
			JY.Person[0].防御力 = 50
			JY.Person[0].轻功 = 50
		else
			JY.Person[0].攻击力 = 40
			JY.Person[0].防御力 = 40
			JY.Person[0].轻功 = 40
		end

		JY.Person[0].主功体 = 0
		JY.Person[0].生命增长 = 6
		JY.Person[0].拳掌功夫 = 20
		JY.Person[0].御剑能力 = 20
		JY.Person[0].耍刀技巧 = 20
		JY.Person[0].特殊兵器 = 20
		JY.Person[0].暗器技巧 = 20
		JY.Person[0].修炼物品 = -1
		JY.Person[0].武学常识 = 0
		JY.Person[0].医疗能力 = 0
		JY.Person[0].用毒能力 = 0
		JY.Person[0].解毒能力 = 0
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].暗器技巧 = 0
		JY.Person[0].生命 = 50
		JY.Person[0].生命最大值 = 50
		JY.Person[0].内力 = 0
		JY.Person[0].内力最大值 = 0
		JY.Person[0].称呼 = ""
		JY.Person[0].武功1 = 121
		JY.Person[0].武功等级1 = 10
		JY.Person[0].武功2 = 0
		JY.Person[0].武功等级2 = 0
		JY.Person[0].武功3 = 0
		JY.Person[0].武功等级3 = 0
		JY.Person[0].武功4 = 0
		JY.Person[0].武功等级4 = 0

		local var_11_50

		for iter_11_5 = 1, var_11_3 do
			local var_11_51 = JY.Person[0]["武功" .. iter_11_5]

			for iter_11_6 = 0, JY.ThingNum - 1 do
				if JY.Thing[iter_11_6].练出武功 == var_11_51 then
					local var_11_52 = 0

					if JY.Base.畅想编号 == 56 then
						AddPersonAttrib(0, "拳掌功夫", var_11_52 * JY.Thing[iter_11_6].加拳掌功夫 * 2)
						AddPersonAttrib(0, "御剑能力", var_11_52 * JY.Thing[iter_11_6].加御剑能力 * 2)
						AddPersonAttrib(0, "耍刀技巧", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧 * 2)
						AddPersonAttrib(0, "特殊兵器", var_11_52 * JY.Thing[iter_11_6].加特殊兵器 * 2)
						AddPersonAttrib(0, "暗器技巧", var_11_52 * JY.Thing[iter_11_6].加暗器技巧 * 2)
					elseif JY.Base.畅想编号 == 590 then
						AddPersonAttrib(0, "拳掌功夫", var_11_52 * JY.Thing[iter_11_6].加拳掌功夫)
						AddPersonAttrib(0, "御剑能力", var_11_52 * JY.Thing[iter_11_6].加御剑能力)
						AddPersonAttrib(0, "耍刀技巧", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "特殊兵器", var_11_52 * JY.Thing[iter_11_6].加特殊兵器 * 2)
						AddPersonAttrib(0, "暗器技巧", var_11_52 * JY.Thing[iter_11_6].加暗器技巧)
					elseif JY.Base.畅想编号 == 77 then
						AddPersonAttrib(0, "攻击力", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "轻功", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "防御力", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "拳掌功夫", var_11_52 * JY.Thing[iter_11_6].加拳掌功夫)
						AddPersonAttrib(0, "御剑能力", var_11_52 * JY.Thing[iter_11_6].加御剑能力)
						AddPersonAttrib(0, "耍刀技巧", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "特殊兵器", var_11_52 * JY.Thing[iter_11_6].加特殊兵器)
						AddPersonAttrib(0, "暗器技巧", var_11_52 * JY.Thing[iter_11_6].加暗器技巧)
					else
						AddPersonAttrib(0, "拳掌功夫", var_11_52 * JY.Thing[iter_11_6].加拳掌功夫)
						AddPersonAttrib(0, "御剑能力", var_11_52 * JY.Thing[iter_11_6].加御剑能力)
						AddPersonAttrib(0, "耍刀技巧", var_11_52 * JY.Thing[iter_11_6].加耍刀技巧)
						AddPersonAttrib(0, "特殊兵器", var_11_52 * JY.Thing[iter_11_6].加特殊兵器)
						AddPersonAttrib(0, "暗器技巧", var_11_52 * JY.Thing[iter_11_6].加暗器技巧)
					end

					AddPersonAttrib(0, "内力最大值", var_11_52 * JY.Thing[iter_11_6].加内力最大值)
					AddPersonAttrib(0, "攻击力", var_11_52 * JY.Thing[iter_11_6].加攻击力)
					AddPersonAttrib(0, "轻功", var_11_52 * JY.Thing[iter_11_6].加轻功)
					AddPersonAttrib(0, "防御力", var_11_52 * JY.Thing[iter_11_6].加防御力)
					AddPersonAttrib(0, "医疗能力", var_11_52 * JY.Thing[iter_11_6].加医疗能力)
					AddPersonAttrib(0, "用毒能力", var_11_52 * JY.Thing[iter_11_6].加用毒能力)
					AddPersonAttrib(0, "解毒能力", var_11_52 * JY.Thing[iter_11_6].加解毒能力)
					AddPersonAttrib(0, "抗毒能力", var_11_52 * JY.Thing[iter_11_6].加抗毒能力)
					AddPersonAttrib(0, "暗器技巧", var_11_52 * JY.Thing[iter_11_6].加暗器技巧)
					AddPersonAttrib(0, "武学常识", var_11_52 * JY.Thing[iter_11_6].加武学常识)
					AddPersonAttrib(0, "品德", var_11_52 * JY.Thing[iter_11_6].加品德)
					AddPersonAttrib(0, "攻击带毒", var_11_52 * JY.Thing[iter_11_6].加攻击带毒)
				end
			end
		end

		JY.Person[0].生命 = JY.Person[0].生命最大值
		JY.Person[0].内力 = JY.Person[0].内力最大值
	end

	if JY.Person[0].姓名 == JY.LEQ and var_11_1 == 2 then
		JY.Person[0].生命增长 = 8
		JY.Person[0].内力性质 = 0
		JY.Person[0].内力最大值 = 300
		JY.Person[0].攻击力 = 50
		JY.Person[0].防御力 = 50
		JY.Person[0].轻功 = 60
		JY.Person[0].医疗能力 = 40
		JY.Person[0].用毒能力 = 40
		JY.Person[0].解毒能力 = 40
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].拳掌功夫 = 50
		JY.Person[0].御剑能力 = 50
		JY.Person[0].耍刀技巧 = 50
		JY.Person[0].特殊兵器 = 50
		JY.Person[0].暗器技巧 = 40
		JY.Person[0].生命最大值 = 75
		JY.Person[0].悟性 = 100
	end

	if JY.Person[0].姓名 == JY.SQ and var_11_1 == 2 then
		JY.Person[0].生命增长 = 7
		JY.Person[0].内力性质 = 1
		JY.Person[0].内力最大值 = 100
		JY.Person[0].攻击力 = 50
		JY.Person[0].防御力 = 60
		JY.Person[0].轻功 = 50
		JY.Person[0].医疗能力 = 40
		JY.Person[0].用毒能力 = 40
		JY.Person[0].解毒能力 = 40
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].拳掌功夫 = 40
		JY.Person[0].御剑能力 = 40
		JY.Person[0].耍刀技巧 = 40
		JY.Person[0].特殊兵器 = 40
		JY.Person[0].暗器技巧 = 40
		JY.Person[0].左右互搏 = 1
		JY.Person[0].生命最大值 = 75
		JY.Person[0].悟性 = 50
	end

	if JY.Person[0].姓名 == JY.XXM and var_11_1 == 2 then
		JY.Person[0].生命增长 = 8
		JY.Person[0].内力性质 = 2
		JY.Person[0].内力最大值 = 200
		JY.Person[0].攻击力 = 50
		JY.Person[0].防御力 = 60
		JY.Person[0].轻功 = 50
		JY.Person[0].医疗能力 = 40
		JY.Person[0].用毒能力 = 40
		JY.Person[0].解毒能力 = 40
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].拳掌功夫 = 40
		JY.Person[0].御剑能力 = 40
		JY.Person[0].耍刀技巧 = 40
		JY.Person[0].特殊兵器 = 40
		JY.Person[0].暗器技巧 = 40
		JY.Person[0].生命最大值 = 75
		JY.Person[0].悟性 = 1
		JY.Person[0].左右互搏 = 1
		JY.Person[0].武功1 = 191
		JY.Person[0].武功等级1 = 390
	end

	if JY.Person[0].姓名 == JY.RM and var_11_1 == 2 then
		JY.Person[0].生命增长 = 7
		JY.Person[0].生命最大值 = 75
		JY.Person[0].内力最大值 = 200
		JY.Person[0].攻击力 = 60
		JY.Person[0].防御力 = 50
		JY.Person[0].轻功 = 50
		JY.Person[0].医疗能力 = 40
		JY.Person[0].用毒能力 = 40
		JY.Person[0].解毒能力 = 40
		JY.Person[0].抗毒能力 = 0
		JY.Person[0].拳掌功夫 = 40
		JY.Person[0].御剑能力 = 40
		JY.Person[0].耍刀技巧 = 40
		JY.Person[0].特殊兵器 = 40
		JY.Person[0].暗器技巧 = 40
		JY.Person[0].性别 = 0
	end

	JY.Person[0].生命 = JY.Person[0].生命最大值
	JY.Person[0].内力 = JY.Person[0].内力最大值

	ClsN()
	ShowScreen()

	for iter_11_7 = 0, JY.PersonNum - 1 do
		JY.Person[iter_11_7].副功体显示 = "无"

		local var_11_53 = 0

		for iter_11_8, iter_11_9 in pairs(CC.PersonExit) do
			if iter_11_9[1] == iter_11_7 then
				var_11_53 = 1
			end
		end

		if iter_11_7 == 0 then
			var_11_53 = 1
		end

		if var_11_53 == 0 then
			for iter_11_10 = 1, var_11_3 do
				if JY.Person[iter_11_7]["武功" .. iter_11_10] > 0 then
					if iter_11_7 < 191 then
						JY.Person[iter_11_7]["武功等级" .. iter_11_10] = 999
					elseif JY.Person[iter_11_7]["武功等级" .. iter_11_10] > 999 then
						JY.Person[iter_11_7]["武功等级" .. iter_11_10] = 999
					end
				else
					break
				end
			end

			if not instruct_16(iter_11_7) and not ybdw(iter_11_7) then
				if iter_11_7 > 531 and iter_11_7 < 541 then
					AddPersonAttrib(iter_11_7, "攻击力", 50)
				end

				local var_11_54 = math.modf(JY.Base.游戏难度 * 25 + CC.CircleNum * 10)

				if JY.Base.游戏难度 > 2 and JY.Person[iter_11_7].畅想级别 > 4 and JY.Person[iter_11_7].畅想级别 < 100 then
					AddPersonAttrib(iter_11_7, "拳掌功夫", var_11_54 * 2)
					AddPersonAttrib(iter_11_7, "御剑能力", var_11_54 * 2)
					AddPersonAttrib(iter_11_7, "耍刀技巧", var_11_54 * 2)
					AddPersonAttrib(iter_11_7, "特殊兵器", var_11_54 * 2)
					AddPersonAttrib(iter_11_7, "暗器技巧", var_11_54 * 2)

					local var_11_55 = (JY.Base.游戏难度 - 1) * 100 + CC.CircleNum * 50 + JY.Person[iter_11_7].畅想级别 * 50

					AddPersonAttrib(iter_11_7, "实战", var_11_55)

					local var_11_56 = (JY.Base.游戏难度 - 1) * 20

					AddPersonAttrib(iter_11_7, "武学常识", var_11_56)
				else
					AddPersonAttrib(iter_11_7, "拳掌功夫", var_11_54 / 2)
					AddPersonAttrib(iter_11_7, "御剑能力", var_11_54 / 2)
					AddPersonAttrib(iter_11_7, "耍刀技巧", var_11_54 / 2)
					AddPersonAttrib(iter_11_7, "特殊兵器", var_11_54 / 2)
					AddPersonAttrib(iter_11_7, "暗器技巧", var_11_54 / 2)

					JY.Person[iter_11_7].实战 = math.modf(JY.Person[iter_11_7].实战 + CC.CircleNum * 20)
				end

				JY.Person[iter_11_7].攻击力 = JY.Person[iter_11_7].攻击力 + JY.Wugong[JY.Person[iter_11_7].主功体].增幅攻击等级 * 10
				JY.Person[iter_11_7].防御力 = JY.Person[iter_11_7].防御力 + JY.Wugong[JY.Person[iter_11_7].主功体].增幅防御等级 * 10
				JY.Person[iter_11_7].轻功 = JY.Person[iter_11_7].轻功 + JY.Wugong[JY.Person[iter_11_7].主功体].增幅轻功等级 * 10
				JY.Person[iter_11_7].轻功 = JY.Person[iter_11_7].轻功 + JY.Wugong[JY.Person[iter_11_7].主运轻功].增幅轻功等级 * 10
			end
		end
	end

	if JY.Person[0].姓名 == JY.LEQ and var_11_1 == 2 then
		JY.Base.主角职业 = 10
		JY.Base.特殊主角 = 1
		JY.Person[0].副功体显示 = "禁用"
	end

	if JY.Person[0].姓名 == JY.SQ and var_11_1 == 2 then
		JY.Base.主角职业 = 10
		JY.Base.特殊主角 = 2
		JY.Person[0].副功体显示 = "禁用"
	end

	if JY.Person[0].姓名 == JY.XXM and var_11_1 == 2 then
		JY.Base.主角职业 = 10
		JY.Base.特殊主角 = 3
		JY.Person[0].副功体显示 = "禁用"
	end

	if JY.Person[0].姓名 == JY.RM and var_11_1 == 2 then
		JY.Base.主角职业 = 10
		JY.Base.特殊主角 = 4
		JY.Person[0].副功体显示 = "禁用"
	end

	local var_11_57 = JY.Person[0].姓名

	if var_11_57 == "SYP" then
		JY.Person[0].姓名 = "阿弥陀佛"
	end

	if (var_11_57 == JY.LEQ or var_11_57 == JY.SQ or var_11_57 == JY.XXM or var_11_57 == JY.RM) and var_11_1 ~= 2 then
		JY.Person[0].姓名 = "天下"
	end

	if JY.Person[0].副功体显示 == "无" and JY.Base.畅想编号 == 0 then
		ClsN()
	end

	FINALWORK2()
	addevent(70, 87, 1, 21, 1, 8348, -2, -2)
	addevent(70, 4, 1, 36, 1, 8250, -2, -2)
	addevent(70, 109, 1, -2, 1, 8248, -2, -2)
	addevent(70, 113, 1, -2, 1, 8830, -2, -2)
	addevent(70, 111, 1, 26, 1, 5266, -2, -2)
	addevent(70, 43, 1, 31, 1, -2, -2, -2)
	addevent(70, 64, 1, 31, 1, -2, -2, -2)
	addevent(70, 116, 1, 31, 1, -2, -2, -2)
	chenhu()
	PlayMIDI(702)

	for iter_11_11 = 1, #TeamP do
		SetS(86, 16, iter_11_11, 5, 2)
		SetS(86, 17, iter_11_11, 5, 1)
		SetS(86, 18, iter_11_11, 5, 1)
		SetS(86, 19, iter_11_11, 5, 1)
	end
end

function FINALWORK2()
	JY.Person[116].姓名 = "逍遥子"

	SetS(70, 32, 7, 1, 0)
	SetS(70, 33, 7, 1, 0)
	SetS(70, 29, 7, 1, 0)
	SetS(28, 37, 11, 1, 1)
	SetS(28, 45, 9, 1, 1)
	SetD(12, 22, 2, 0)

	if GetS(10, 0, 17, 0) ~= 1 then
		SetD(83, 48, 4, 0)
	end

	if JY.Base.主角职业 == 3 then
		JY.Thing[138].需内力性质 = 2
		JY.Thing[138].名称 = "无名刀谱"
		JY.Thing[138].物品说明 = "虽无名，却是绝世刀法"
		JY.Wugong[64].名称 = "无名刀法"

		for iter_12_0 = 1, 10 do
			JY.Wugong[64]["移动范围" .. iter_12_0] = 4
			JY.Wugong[64]["杀伤范围" .. iter_12_0] = 0
		end

		JY.Wugong[64].攻击范围 = 3
	end

	JY.Thing[8].加中毒解毒 = -100
	JY.Thing[8].加冰毒解毒 = -30
	JY.Thing[8].加火毒解毒 = -30
	JY.Thing[8].加内力 = 3000

	if GetS(86, 10, 12, 5) == 1 then
		GRTS[29] = "浪荡"
		GRTSSAY[29] = "效果：本次攻击有机率打出浪荡招式*条件：体力大于50 内力大于500*消耗：体力12点 内力500点"
	elseif GetS(86, 10, 12, 5) == 2 then
		GRTS[29] = "戒色"
		GRTSSAY[29] = "效果：本回合气防和集气速度提高，受到伤害减少*条件：体力大于50 内力大于500*消耗：体力10点 内力500点"
	end

	if JY.Base.畅想编号 ~= 0 and GRTS[JY.Base.畅想编号] ~= nil then
		GRTS[0] = GRTS[JY.Base.畅想编号]
		GRTSSAY[0] = GRTSSAY[JY.Base.畅想编号]
	end
end

function JLSD(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = math.random(100)

	if instruct_16(arg_13_2) then
		if arg_13_0 < var_13_0 and var_13_0 < arg_13_1 then
			return true
		else
			return false
		end
	elseif var_13_0 > arg_13_0 - 5 and var_13_0 < arg_13_1 + 5 then
		return true
	else
		return false
	end
end

function Paused()
	return
end

function Resume()
	return
end

function Game_Cycle()
	lib.Debug("Start game cycle")

	while JY.Status ~= GAME_END do
		local var_16_0 = lib.GetTime()

		JY.Mytick = JY.Mytick + 1

		if JY.Mytick % 20 == 0 then
			JY.MyCurrentPic = 0
		end

		if JY.Mytick % 1000 == 0 then
			JY.MYtick = 0
		end

		if JY.Status == GAME_FIRSTMMAP then
			CleanMemory()
			lib.ShowSlow(50, 1)

			JY.MmapMusic = 501
			JY.Status = GAME_MMAP

			Init_MMap()
			lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
			lib.ShowSlow(50, 0)
		elseif JY.Status == GAME_MMAP then
			Game_MMap()
		elseif JY.Status == GAME_SMAP then
			Game_SMap()
		end

		collectgarbage("step", 0)

		local var_16_1 = lib.GetTime()

		if var_16_1 - var_16_0 < CC.Frame then
			lib.Delay(CC.Frame - (var_16_1 - var_16_0))
		end
	end
end

function Game_MMap()
	local var_17_0 = -1
	local var_17_1 = lib.GetKey()

	if var_17_1 ~= -1 then
		JY.Mytick = 0

		if var_17_1 == VK_ESCAPE then
			ShowScreen()
			lib.SetClip(0, 0, 0, 0)
			MMenu()

			if JY.Status ~= GAME_MMAP then
				return
			end
		elseif var_17_1 == VK_UP then
			var_17_0 = 0
		elseif var_17_1 == VK_DOWN then
			var_17_0 = 3
		elseif var_17_1 == VK_LEFT then
			var_17_0 = 2
		elseif var_17_1 == VK_RIGHT then
			var_17_0 = 1
		elseif var_17_1 == VK_H then
			return
		elseif var_17_1 == VK_K then
			Menu_FullScreen()

			return
		elseif var_17_1 == VK_Q then
			DrawStrBox(-1, -1, "自动存档中，请稍后...", C_WHITE, CC.DefaultFont)
			ShowScreen()

			JY.Base.存档标识 = -1

			SaveRecord(10)
		elseif var_17_1 == VK_S then
			if JY.SubScene ~= 42 and JY.SubScene ~= 82 and JY.SubScene ~= 13 then
				DrawStrBox(-1, -1, "存档中，请稍后...", C_WHITE, CC.DefaultFont)
				ShowScreen()

				JY.Base.存档标识 = -1

				SaveRecord(1)
				DrawStrBoxWaitKey("存档完毕", C_WHITE, CC.DefaultFont)
			else
				DrawStrBoxWaitKey("特殊场景，禁止存档", C_WHITE, CC.DefaultFont)
			end
		end
	end

	local var_17_2
	local var_17_3

	if var_17_0 ~= -1 then
		AddMyCurrentPic()

		var_17_2 = JY.Base.人X + CC.DirectX[var_17_0 + 1]
		var_17_3 = JY.Base.人Y + CC.DirectY[var_17_0 + 1]
		JY.Base.人方向 = var_17_0
	else
		var_17_2 = JY.Base.人X
		var_17_3 = JY.Base.人Y
	end

	if var_17_0 ~= -1 then
		JY.SubScene = CanEnterScene(var_17_2, var_17_3)
	end

	if lib.GetMMap(var_17_2, var_17_3, 3) == 0 and lib.GetMMap(var_17_2, var_17_3, 4) == 0 then
		JY.Base.人X = var_17_2
		JY.Base.人Y = var_17_3
	end

	JY.Base.人X = limitX(JY.Base.人X, 10, CC.MWidth - 10)
	JY.Base.人Y = limitX(JY.Base.人Y, 10, CC.MHeight - 10)

	if CC.MMapBoat[lib.GetMMap(JY.Base.人X, JY.Base.人Y, 0)] == 1 then
		JY.Base.乘船 = 1
	else
		JY.Base.乘船 = 0
	end

	lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())

	if CC.ShowXY == 1 then
		DrawString(10, CC.ScreenH - 50, string.format("%d %d", JY.Base.人X, JY.Base.人Y), C_GOLD, 16)
	end

	DrawTimer()
	JYZTB()
	ShowScreen()

	if JY.SubScene >= 0 then
		CleanMemory()
		lib.UnloadMMap()
		lib.PicInit()
		lib.ShowSlow(50, 1)

		JY.Status = GAME_SMAP
		JY.MmapMusic = -1
		JY.MyPic = GetMyPic()
		JY.Base.人X1 = JY.Scene[JY.SubScene].入口X
		JY.Base.人Y1 = JY.Scene[JY.SubScene].入口Y

		Init_SMap(1)

		return
	end
end

function GetMyPic()
	local var_18_0

	if JY.Status == GAME_MMAP and JY.Base.乘船 == 1 then
		if JY.MyCurrentPic >= 4 then
			JY.MyCurrentPic = 0
		end
	elseif JY.MyCurrentPic > 6 then
		JY.MyCurrentPic = 1
	end

	if JY.Base.乘船 == 0 then
		if JY.Person[0].官阶 == 12 then
			var_18_0 = CC.MyStartPicH + JY.Base.人方向 * 7 + JY.MyCurrentPic
		elseif JY.Person[0].性别 == 1 or JY.Base.畅想编号 == 27 then
			var_18_0 = CC.MyStartPicF + JY.Base.人方向 * 7 + JY.MyCurrentPic
		else
			var_18_0 = CC.MyStartPicM + JY.Base.人方向 * 7 + JY.MyCurrentPic
		end
	else
		var_18_0 = CC.BoatStartPic + JY.Base.人方向 * 4 + JY.MyCurrentPic
	end

	return var_18_0
end

function AddMyCurrentPic()
	JY.MyCurrentPic = JY.MyCurrentPic + 1

	if JY.MyCurrentPic == 4 then
		JY.TIMECOUNT = JY.TIMECOUNT + 1

		OEVENTLUA[7001]()
	end

	if JY.TIMECOUNT == 24 then
		local var_19_0 = Rnd(10)

		if var_19_0 == 1 and JY.SubScene == -1 and JY.MmapMusic < 0 then
			PlayMIDI(135)
		elseif var_19_0 == 2 and JY.SubScene == -1 and JY.MmapMusic < 0 then
			PlayMIDI(503)
		elseif var_19_0 > 2 and var_19_0 < 9 and JY.SubScene == -1 and JY.MmapMusic < 0 then
			PlayMIDI(502)
		end

		for iter_19_0 = 0, 635 do
			if inteam(iter_19_0) == false and JY.Person[iter_19_0].无用1 == 1 then
				JY.Person[iter_19_0].修炼点数 = JY.Person[iter_19_0].修炼点数 + 20
			end
		end

		if JY.Person[0].副功体 > 0 or has_thing(348) then
			AddPersonAttrib(0, "内力最大值", 1)
		end

		JY.TIMECOUNT = 0

		addtime(1)
	end
end

function CanEnterScene(arg_20_0, arg_20_1)
	for iter_20_0 = 0, JY.SceneNum - 1 do
		local var_20_0 = JY.Scene[iter_20_0]

		if arg_20_0 == var_20_0.外景入口X1 and arg_20_1 == var_20_0.外景入口Y1 or arg_20_0 == var_20_0.外景入口X2 and arg_20_1 == var_20_0.外景入口Y2 then
			local var_20_1 = var_20_0.进入条件

			if var_20_1 == 0 then
				return iter_20_0
			elseif var_20_1 == 1 then
				return -1
			elseif var_20_1 == 2 then
				for iter_20_1 = 1, CC.TeamNum do
					local var_20_2 = JY.Base["队伍" .. iter_20_1]

					if var_20_2 >= 0 and JY.Person[var_20_2].轻功 >= 100 then
						return iter_20_0
					end
				end
			end
		end
	end

	return -1
end

function MMenu()
	Cls()

	local var_21_0 = {
		{
			"医疗",
			Menu_Doctor,
			1
		},
		{
			"解毒",
			Menu_DecPoison,
			1
		},
		{
			"物品",
			Menu_Thing,
			1
		},
		{
			"状态",
			Menu_Status,
			1
		},
		{
			"功体",
			YunGongMenu,
			1
		},
		{
			"离队",
			Menu_PersonExit,
			1
		},
		{
			"系统",
			Menu_System,
			1
		}
	}

	ShowMenu(var_21_0, #var_21_0, 0, CC.MainMenuX, CC.MainMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
end

function Menu_System()
	local var_22_0 = {
		{
			"读取进度",
			Menu_ReadRecord,
			1
		},
		{
			"保存进度",
			Menu_SaveRecord,
			1
		},
		{
			"打赏&赞助",
			Menu_zhanzhu,
			0  -- [port] was 1; hides the entry, keeps the indices
		},
		{
			"游戏调速",
			Menu_sudu,
			1
		},
		{
			"离开游戏",
			Menu_Exit,
			1
		}
	}

	if JY.EnableMusic == 0 then
		var_22_0[3][1] = "打开音乐"
	end

	if JY.EnableSound == 0 then
		var_22_0[4][1] = "打开音效"
	end

	if JY.Status == GAME_SMAP then
		if JY.SubScene ~= 42 and JY.SubScene ~= 82 and JY.SubScene ~= 13 then
			var_22_0[1][3] = 1
			var_22_0[2][3] = 1
		else
			var_22_0[1][3] = 0
			var_22_0[2][3] = 0
		end
	end

	local var_22_1 = ShowMenu(var_22_0, #var_22_0, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_22_1 == 7 then
		Menu_HYZB()

		return 1
	end

	if var_22_1 == 8 then
		My_ChuangSong_Ex()

		return 1
	end

	if var_22_1 == 0 then
		return 0
	elseif var_22_1 < 0 then
		return 1
	end
end

function Menu_DW()
	local var_23_0 = "队伍设置"
	local var_23_1 = "队伍控制：设置队伍为手动或是由AI控制" .. "*重设队列：重新排列队伍顺序" .. "*ESC键：直接退出。"
	local var_23_2 = {
		"队友控制",
		"重排队列"
	}
	local var_23_3 = #var_23_2
	local var_23_4 = JYMsgBox(var_23_0, var_23_1, var_23_2, var_23_3, nil, 1)

	if var_23_4 == 1 then
		local var_23_5 = "队伍控制"
		local var_23_6 = "队伍控制分两种方式" .. "*一种为手动控制，由玩家自行操控队友作战" .. "*而AI控制的话，玩家只需观战即可" .. "*设置为自动控制时，队友将享受到部分NPC待遇" .. "*也就是额外的生命和内力加成，主角除外" .. "*ESC键：直接退出。"
		local var_23_7 = {
			"玩家手动控制",
			"AI自动控制"
		}
		local var_23_8 = #var_23_7
		local var_23_9 = JYMsgBox(var_23_5, var_23_6, var_23_7, var_23_8, nil, 1)

		if var_23_9 == 1 then
			JY.Base.队友控制 = 0

			QZXS("队伍设置为手动控制")
		elseif var_23_9 == 2 then
			JY.Base.队友控制 = 1

			QZXS("队伍设置为由AI控制")
		end
	elseif var_23_4 == 2 then
		Menu_DDTH()
	end
end

function Menu_sudu()
	local var_24_0 = JYMsgBox("请选择你想要的游戏速度", "游戏中按K键可以切换全屏", {
		"原速",
		"快速",
		"极快"
	}, 3, 1115)

	if var_24_0 == 1 then
		CC.Frame = 30
	elseif var_24_0 == 2 then
		CC.Frame = 20
	elseif var_24_0 == 3 then
		CC.Frame = 10

		return
	end
end

function Menu_zhanzhu()
	local var_25_0 = "打赏&赞助"
	local var_25_1 = "《龙启江湖》是玩家grgame制作的绿色免费游戏" .. "*游戏制作的主旨是对市场现在的游戏不满意。" .. "*所以创作一个非快餐，有剧情深度的游戏供爱好者体验交流。" .. "*游戏计划持续添加剧情和设定。" .. "*为良性持续发展，提供游戏赞助窗口。" .. "*我的微博号龙启江湖，会不定时提供最新消息。"
	local var_25_2 = {
		"打赏窗口",
		"赞助窗口"
	}
	local var_25_3 = #var_25_2
	local var_25_4 = JYMsgBox(var_25_0, var_25_1, var_25_2, var_25_3, nil, 1)

	if var_25_4 == 1 then
		zhan()
	elseif var_25_4 == 2 then
		zhi()
	end

	return 1
end

function zhan()
	local var_26_0 = "我要打赏"
	local var_26_1 = "" .. "*做的不错，有点意思" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*       打赏"
	local var_26_2 = {
		"感谢支持"
	}
	local var_26_3 = #var_26_2

	if JYMsgBox(var_26_0, var_26_1, var_26_2, var_26_3, nil, 1) == 1 then
		lib.LoadPicture(CC.zhanFile, -1, -1)
		ShowScreen()

		local var_26_4, var_26_5, var_26_6, var_26_7 = WaitKey()

		lib.Delay(CC.Frame)
		Cls()
	end

	return 1
end

function zhi()
	local var_27_0 = "我要赞助"
	local var_27_1 = "" .. "*  做的不错，我鼓励你继续开发" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*赞助请扫描上方二维码联系作者grgame"
	local var_27_2 = {
		"感谢支持"
	}
	local var_27_3 = #var_27_2

	if JYMsgBox(var_27_0, var_27_1, var_27_2, var_27_3, nil, 1) == 1 then
		lib.LoadPicture(CC.zhuFile, -1, -1)
		ShowScreen()

		local var_27_4, var_27_5, var_27_6, var_27_7 = WaitKey()

		lib.Delay(CC.Frame)
		Cls()
	end

	return 1
end

function liu()
	local var_28_0 = "玩家交流学习之处"
	local var_28_1 = "" .. "*  探索、发现与交流" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*" .. "*若微信二维码失效，可关注微博 龙启江湖 见新二维码"
	local var_28_2 = {
		"机遇与奇遇并存"
	}
	local var_28_3 = #var_28_2

	if JYMsgBox(var_28_0, var_28_1, var_28_2, var_28_3, nil, 1) == 1 then
		lib.LoadPicture(CC.weiFile, -1, -1)
		ShowScreen()

		local var_28_4, var_28_5, var_28_6, var_28_7 = WaitKey()

		lib.Delay(CC.Frame)
		Cls()
	end

	return 1
end

function Hero(arg_29_0)
	local var_29_0 = 1
	local var_29_1 = 3
	local var_29_2 = 599
	local var_29_3 = {}

	for iter_29_0 = 1, JY.PersonNum - 1 do
		var_29_3[#var_29_3 + 1] = {
			iter_29_0 .. "." .. JY.Person[iter_29_0].姓名,
			nil,
			1,
			iter_29_0
		}
	end

	for iter_29_1 = 1, #var_29_3 do
		if iter_29_1 >= 190 and iter_29_1 <= 588 then
			var_29_3[iter_29_1][3] = 2
		end

		if iter_29_1 > 593 and iter_29_1 < 598 then
			var_29_3[iter_29_1][3] = 2
		end

		if iter_29_1 == 92 or iter_29_1 == 93 then
			var_29_3[iter_29_1][3] = 2
		end
	end

	Cls()

	local var_29_4 = ShowMenu2(var_29_3, #var_29_3, 4, 12, -1, -1, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE, "选择要查看的人物图鉴")

	if var_29_4 > 0 then
		arg_29_0 = var_29_3[var_29_3[var_29_4][4]][4]

		ClsN()
	end

	while true do
		Cls()
		ShowPersonStatus_sub(arg_29_0, var_29_0, AI_s1, AI_s2)
		ShowScreen()

		local var_29_5 = WaitKey()

		lib.Delay(100)

		if var_29_5 == VK_ESCAPE then
			break
		elseif var_29_5 == VK_UP then
			arg_29_0 = arg_29_0 - 1

			while arg_29_0 >= 92 and arg_29_0 <= 93 or arg_29_0 >= 190 and arg_29_0 <= 450 or arg_29_0 > 454 and arg_29_0 < 458 or arg_29_0 > 459 and arg_29_0 <= 588 or arg_29_0 > 593 and arg_29_0 < 598 do
				arg_29_0 = arg_29_0 - 1
			end
		elseif var_29_5 == VK_DOWN then
			arg_29_0 = arg_29_0 + 1

			while arg_29_0 >= 92 and arg_29_0 <= 93 or arg_29_0 >= 190 and arg_29_0 <= 450 or arg_29_0 > 454 and arg_29_0 < 458 or arg_29_0 > 459 and arg_29_0 <= 588 or arg_29_0 > 593 and arg_29_0 < 598 do
				arg_29_0 = arg_29_0 + 1
			end
		elseif var_29_5 == VK_LEFT then
			var_29_0 = var_29_0 - 1
		elseif var_29_5 == VK_RIGHT then
			var_29_0 = var_29_0 + 1
		elseif var_29_5 == VK_SPACE then
			if arg_29_0 == 0 and JY.Person[arg_29_0].姓名 == JY.LEQ and JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["001"], 290, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Person[arg_29_0].姓名 == JY.SQ and JY.Base.特殊主角 == 2 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["002"], 291, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Person[arg_29_0].姓名 == JY.XXM and JY.Base.特殊主角 == 3 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["003"], 292, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Person[arg_29_0].姓名 == JY.RM and JY.Base.特殊主角 == 4 and JY.Base.主角职业 == 10 and JY.Base.畅想编号 == 0 then
				if JY.Person[JY.Base.队伍1].悟性 < 50 then
					say(TFNLJS["004a"], 293, 5, JY.Person[arg_29_0].姓名)
				elseif JY.Person[JY.Base.队伍1].悟性 == 50 then
					say(TFNLJS["004b"], 293, 5, JY.Person[arg_29_0].姓名)
				elseif JY.Person[JY.Base.队伍1].悟性 > 50 then
					say(TFNLJS["004c"], 293, 5, JY.Person[arg_29_0].姓名)
				end
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 1 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["01"], 281, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 2 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["02"], 282, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 3 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["03"], 283, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 4 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["04"], 284, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 5 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["05"], 285, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 6 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["06"], 286, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 7 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["07"], 287, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 8 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["08"], 288, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and JY.Base.主角职业 == 9 and JY.Base.畅想编号 == 0 then
				say(TFNLJS["09"], 289, 5, JY.Person[arg_29_0].姓名)
			end

			if arg_29_0 == 0 and TFNLJS[JY.Base.畅想编号] ~= nil and JY.Base.畅想编号 ~= 0 then
				say(TFNLJS[JY.Base.畅想编号], JY.Person[JY.Base.畅想编号].头像代号, 5, JY.Person[JY.Base.畅想编号].姓名)
			end

			if TFNLJS[arg_29_0] ~= nil then
				say(TFNLJS[arg_29_0], JY.Person[arg_29_0].头像代号, 5, JY.Person[arg_29_0].姓名)
			end
		end

		arg_29_0 = limitX(arg_29_0, 1, var_29_2)
		var_29_0 = limitX(var_29_0, 1, var_29_1)
	end
end

function Menu_SetMusic()
	if JY.EnableMusic == 0 then
		JY.EnableMusic = 1

		PlayMIDI(JY.CurrentMIDI)
	else
		JY.EnableMusic = 0

		lib.PlayMIDI("")
	end

	return 1
end

function Menu_SetSound()
	if JY.EnableSound == 0 then
		JY.EnableSound = 1
	else
		JY.EnableSound = 0
	end

	return 1
end

function Menu_WPXG()
	local var_32_0 = "系统开关设置"
	local var_32_1 = "物品整理：把物品栏中的物品重新排序。" .. "*秘籍说明：选择秘籍时是否先显示其相关说明。" .. "*战场显血：选择战场上是否显示血量。" .. "*ESC：关闭菜单。"
	local var_32_2 = {
		"物品整理",
		"秘籍说明",
		"战场显血"
	}
	local var_32_3 = #var_32_2
	local var_32_4 = JYMsgBox(var_32_0, var_32_1, var_32_2, var_32_3, nil, 1)

	if var_32_4 == 1 then
		Menu_WPZL()
	elseif var_32_4 == 2 then
		if JY.SMKG == 0 then
			JY.SMKG = 1

			DrawStrBoxWaitKey("秘籍说明已开启", C_WHITE, CC.DefaultFont)
		elseif JY.SMKG == 1 then
			JY.SMKG = 0

			DrawStrBoxWaitKey("秘籍说明已关闭", C_WHITE, CC.DefaultFont)
		end
	elseif var_32_4 == 3 then
		if CC.Base_S.血量显示 == 1 then
			CC.Base_S.血量显示 = 0

			DrawStrBoxWaitKey("战场显血已关闭", C_WHITE, CC.DefaultFont)
		elseif CC.Base_S.血量显示 == 0 then
			CC.Base_S.血量显示 = 1

			DrawStrBoxWaitKey("战场显血已开启", C_WHITE, CC.DefaultFont)
		end
	end
end

function Menu_Thing()
	local var_33_0 = {
		{
			"全部物品",
			nil,
			1
		},
		{
			"剧情物品",
			nil,
			1
		},
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
		},
		{
			"伤人暗器",
			nil,
			1
		},
		{
			"物品整理",
			Menu_WPZL,
			1
		}
	}
	local var_33_1 = ShowMenu(var_33_0, 7, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_33_1 > 0 then
		local var_33_2 = {}
		local var_33_3 = {}

		for iter_33_0 = 0, CC.MyThingNum - 1 do
			var_33_2[iter_33_0] = -1
			var_33_3[iter_33_0] = 0
		end

		local var_33_4 = 0

		for iter_33_1 = 0, CC.MyThingNum - 1 do
			local var_33_5 = JY.Base["物品" .. iter_33_1 + 1]

			if var_33_5 >= 0 then
				if var_33_1 == 1 then
					var_33_2[iter_33_1] = var_33_5
					var_33_3[iter_33_1] = JY.Base["物品数量" .. iter_33_1 + 1]
				elseif JY.Thing[var_33_5].类型 == var_33_1 - 2 then
					var_33_2[var_33_4] = var_33_5
					var_33_3[var_33_4] = JY.Base["物品数量" .. iter_33_1 + 1]
					var_33_4 = var_33_4 + 1
				end
			end
		end

		local var_33_6 = SelectThing(var_33_2, var_33_3)

		if var_33_6 >= 0 then
			UseThing(var_33_6)

			return 1
		end
	end

	return 0
end

function Menu_WPZL()
	for iter_34_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_34_0] > -1 then
			for iter_34_1 = iter_34_0 + 1, CC.MyThingNum do
				if JY.Base["物品" .. iter_34_1] > -1 and JY.Base["物品" .. iter_34_1] < JY.Base["物品" .. iter_34_0] then
					JY.Base["物品" .. iter_34_0], JY.Base["物品" .. iter_34_1] = JY.Base["物品" .. iter_34_1], JY.Base["物品" .. iter_34_0]
					JY.Base["物品数量" .. iter_34_0], JY.Base["物品数量" .. iter_34_1] = JY.Base["物品数量" .. iter_34_1], JY.Base["物品数量" .. iter_34_0]
				end
			end
		end
	end

	Cls()
	DrawStrBoxWaitKey("物品整理完成", C_WHITE, CC.DefaultFont)
end

function MenuDSJ()
	local var_35_0 = {
		{
			"全部物品",
			nil,
			0
		},
		{
			"剧情物品",
			nil,
			0
		},
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
		},
		{
			"伤人暗器",
			nil,
			1
		}
	}
	local var_35_1 = ShowMenu(var_35_0, 6, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_35_1 > 0 then
		local var_35_2 = {}
		local var_35_3 = {}

		for iter_35_0 = 0, CC.MyThingNum - 1 do
			var_35_2[iter_35_0] = -1
			var_35_3[iter_35_0] = 0
		end

		local var_35_4 = 0

		for iter_35_1 = 0, CC.MyThingNum - 1 do
			local var_35_5 = JY.Base["物品" .. iter_35_1 + 1]

			if var_35_5 >= 0 and var_35_5 ~= 202 then
				if var_35_1 == 1 then
					var_35_2[iter_35_1] = var_35_5
					var_35_3[iter_35_1] = JY.Base["物品数量" .. iter_35_1 + 1]
				elseif JY.Thing[var_35_5].类型 == var_35_1 - 2 then
					var_35_2[var_35_4] = var_35_5
					var_35_3[var_35_4] = JY.Base["物品数量" .. iter_35_1 + 1]
					var_35_4 = var_35_4 + 1
				end
			end
		end

		local var_35_6 = SelectThing(var_35_2, var_35_3)

		if var_35_6 >= 0 then
			return var_35_6
		end
	end

	return -1
end

function Menu_HYZB()
	if JY.SubScene ~= 25 then
		JY.SubScene = 70
		JY.Base.人X1 = 8
		JY.Base.人Y1 = 28
		JY.Base.人X = 358
		JY.Base.人Y = 235
	end
end

function Menu_Exit()
	Cls()

	if DrawStrBoxYesNo(-1, -1, "是否真的要离开游戏(Y/N)?", C_WHITE, CC.DefaultFont) == true then
		StartMenu()
	end

	return 1
end

function Menu_SaveRecord()
	local var_38_0 = (CC.ScreenW - 38.5 * CC.FontSmall3 - 2 * CC.MenuBorderPixel) / 3
	local var_38_1 = (CC.ScreenH - 1 * (CC.FontSmall3 + CC.RowPixel)) / 3

	DrawStrBox(var_38_0, var_38_1, string.format("%-8s %-7s %-4s %-4s %8s %13s %-10s %-10s", "  存档", "姓名", "年龄", "门派", "阶级", "位置", "难度", "存档时间          "), C_ORANGE, CC.FontSmall3, C_GOLD)  -- [port] see docs/PATCHES.md

	local var_38_2 = SaveList()

	if var_38_2 > 0 then
		DrawStrBox(CC.MainSubMenuX2, CC.MainSubMenuY, "请稍候......", C_WHITE, CC.DefaultFont)
		ShowScreen()
		SaveRecord(var_38_2)
		Cls()
	end

	return 0
end

function Menu_ReadRecord()
	local var_39_0 = (CC.ScreenW - 38.5 * CC.FontSmall3 - 2 * CC.MenuBorderPixel) / 3
	local var_39_1 = (CC.ScreenH - 1 * (CC.FontSmall3 + CC.RowPixel)) / 3

	DrawStrBox(var_39_0, var_39_1, string.format("%-8s %-7s %-4s %-4s %8s %13s %-10s %-10s", "  存档", "姓名", "年龄", "门派", "阶级", "位置", "难度", "存档时间          "), C_ORANGE, CC.FontSmall3, C_GOLD)  -- [port] see docs/PATCHES.md

	local var_39_2 = SaveList()

	if var_39_2 < 1 then
		return 0
	end

	Cls()
	DrawStrBox(-1, CC.StartMenuY, "请稍候...", C_GOLD, CC.DefaultFont)
	ShowScreen()

	if LoadRecord(var_39_2) ~= nil then
		return 0
	end

	if JY.Base.存档标识 ~= -1 then
		if JY.SubScene < 0 then
			CleanMemory()
			lib.UnloadMMap()
		end

		lib.PicInit()
		lib.ShowSlow(50, 1)

		JY.Status = GAME_SMAP
		JY.SubScene = JY.Base.存档标识
		JY.MmapMusic = -1
		JY.MyPic = GetMyPic()

		Init_SMap(1)
	else
		JY.SubScene = -1
		JY.Status = GAME_FIRSTMMAP
	end

	return 1
end

function Menu_Status()
	DrawStrBox(CC.MainSubMenuX + 10, CC.MainSubMenuY, "要查阅谁的状态", C_WHITE, CC.DefaultFont)

	local var_40_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_40_1 = SelectTeamMenu(CC.MainSubMenuX + 10, var_40_0)

	if var_40_1 > 0 then
		ShowPersonStatus(var_40_1)

		return 1
	else
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)

		return 0
	end
end

function Menu_PersonExit()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要求谁离队", C_WHITE, CC.DefaultFont)

	local var_41_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_41_1 = SelectTeamMenu(CC.MainSubMenuX, var_41_0)

	if var_41_1 == 1 then
		DrawStrBoxWaitKey("抱歉！没有你游戏进行不下去", C_WHITE, CC.DefaultFont, 1)
	end

	if var_41_1 > 0 and (JY.SubScene == 55 or JY.SubScene == 82) and JY.Base["队伍" .. var_41_1] == 35 then
		say("现在不能离开。", 35, 1)

		return
	end

	if var_41_1 > 0 and JY.SubScene == 22 and JY.Base["队伍" .. var_41_1] == 59 then
		say("现在不能离开。", 59, 1)

		return
	end

	if var_41_1 > 0 and JY.SubScene == 108 and JY.Base["队伍" .. var_41_1] == 588 then
		say("现在不能离开。", 269, 1)

		return
	end

	if var_41_1 > 1 then
		local var_41_2 = JY.Base["队伍" .. var_41_1]

		for iter_41_0, iter_41_1 in ipairs(CC.PersonExit) do
			if var_41_2 == iter_41_1[1] then
				if OEVENTLUA[iter_41_1[2]] ~= nil then
					OEVENTLUA[iter_41_1[2]]()

					break
				end

				oldCallEvent(iter_41_1[2])

				break
			end
		end
	end

	Cls()

	return 0
end

function SelectTeamMenu(arg_42_0, arg_42_1)
	local var_42_0 = {}

	for iter_42_0 = 1, CC.TeamNum do
		var_42_0[iter_42_0] = {
			"",
			nil,
			0
		}

		local var_42_1 = JY.Base["队伍" .. iter_42_0]

		if var_42_1 >= 0 and JY.Person[var_42_1].生命 > 0 then
			var_42_0[iter_42_0][1] = JY.Person[var_42_1].姓名
			var_42_0[iter_42_0][3] = 1
		end
	end

	return ShowMenu(var_42_0, CC.TeamNum, 0, arg_42_0, arg_42_1, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
end

function GetTeamNum()
	local var_43_0 = CC.TeamNum

	for iter_43_0 = 1, CC.TeamNum do
		if JY.Base["队伍" .. iter_43_0] < 0 then
			var_43_0 = iter_43_0 - 1

			break
		end
	end

	return var_43_0
end

function ShowPersonStatus(arg_44_0)
	local var_44_0 = 1
	local var_44_1 = 3
	local var_44_2 = GetTeamNum()
	local var_44_3 = 1
	local var_44_4 = 1
	local var_44_5 = 0
	local var_44_6 = 0

	while true do
		if JY.Restart == 1 then
			break
		end

		Cls()

		local var_44_7 = JY.Base["队伍" .. arg_44_0]
		local var_44_8 = JY.Person[var_44_7]
		local var_44_9 = {
			var_44_8.战斗控制,
			var_44_8.战斗模式,
			var_44_8.喜使武功
		}
		local var_44_10 = {}
		local var_44_11 = 0

		for iter_44_0 = 1, CC.Kungfunum do
			if var_44_8["武功" .. iter_44_0] == 0 then
				break
			end

			if JY.Wugong[var_44_8["武功" .. iter_44_0]].武功类型 ~= 10 then
				var_44_11 = var_44_11 + 1
				var_44_10[var_44_11] = var_44_8["武功" .. iter_44_0]
			end
		end

		ShowPersonStatus_sub(var_44_7, var_44_0, var_44_4, var_44_9)
		ShowScreen()

		local var_44_12, var_44_13, var_44_14, var_44_15 = WaitKey()

		lib.Delay(CC.Frame)

		if var_44_12 == VK_ESCAPE or var_44_13 == 4 then
			if var_44_0 == 3 and var_44_5 > 0 then
				var_44_5 = 0
			else
				break
			end
		elseif var_44_12 == VK_UP then
			if var_44_0 == 1 then
				arg_44_0 = arg_44_0 - 1
			elseif var_44_0 == 2 then
				arg_44_0 = arg_44_0 - 1
			elseif var_44_0 == 3 and var_44_5 == 0 then
				var_44_4 = var_44_4 - 1

				if var_44_4 < 1 then
					var_44_4 = 3
				end
			end
		elseif var_44_12 == VK_DOWN then
			if var_44_0 == 1 then
				arg_44_0 = arg_44_0 + 1
			elseif var_44_0 == 2 then
				arg_44_0 = arg_44_0 + 1
			elseif var_44_0 == 3 and var_44_5 == 0 then
				var_44_4 = var_44_4 + 1

				if var_44_4 > 3 then
					var_44_4 = 1
				end
			end
		elseif var_44_12 == VK_LEFT then
			if var_44_0 == 3 and var_44_5 > 0 then
				if var_44_5 == 1 then
					JY.Person[var_44_7].战斗控制 = JY.Person[var_44_7].战斗控制 - 1

					if JY.Person[var_44_7].战斗控制 < 1 then
						JY.Person[var_44_7].战斗控制 = 2
					end
				elseif var_44_5 == 2 then
					JY.Person[var_44_7].战斗模式 = JY.Person[var_44_7].战斗模式 - 1

					if JY.Person[var_44_7].战斗模式 < 1 then
						JY.Person[var_44_7].战斗模式 = 2
					end
				elseif var_44_5 == 3 and var_44_6 > 0 then
					var_44_6 = var_44_6 - 1
					JY.Person[var_44_7].喜使武功 = var_44_10[var_44_6]
				end
			else
				var_44_0 = var_44_0 - 1

				if var_44_3 > 1 then
					var_44_3 = 1
				end

				if var_44_4 > 1 then
					var_44_4 = 1
				end
			end
		elseif var_44_12 == VK_RIGHT then
			if var_44_0 == 3 and var_44_5 > 0 then
				if var_44_5 == 1 then
					JY.Person[var_44_7].战斗控制 = JY.Person[var_44_7].战斗控制 + 1

					if JY.Person[var_44_7].战斗控制 > 2 then
						JY.Person[var_44_7].战斗控制 = 1
					end
				elseif var_44_5 == 2 then
					JY.Person[var_44_7].战斗模式 = JY.Person[var_44_7].战斗模式 + 1

					if JY.Person[var_44_7].战斗模式 > 2 then
						JY.Person[var_44_7].战斗模式 = 1
					end
				elseif var_44_5 == 3 and var_44_6 < var_44_11 then
					var_44_6 = var_44_6 + 1
					JY.Person[var_44_7].喜使武功 = var_44_10[var_44_6]
				end
			else
				var_44_0 = var_44_0 + 1

				if var_44_3 > 1 then
					var_44_3 = 1
				end
			end
		elseif var_44_12 == VK_X then
			local var_44_16 = var_44_7
			local var_44_17 = JY.Person[var_44_16].修炼物品
			local var_44_18 = JY.Person[var_44_16].武器
			local var_44_19 = JY.Person[var_44_16].防具
			local var_44_20 = JY.Person[var_44_16].饰品
			local var_44_21 = JY.Person[var_44_16].坐骑

			Cls()

			if var_44_17 ~= -1 and DrawStrBoxYesNo(-1, -1, "是否要卸载秘籍?", C_WHITE, CC.DefaultFont, 1) == true then
				Cls()

				JY.Person[var_44_16].修炼物品 = -1
				JY.Thing[var_44_17].使用人 = -1

				Cls()
				DrawStrBoxWaitKey("卸载秘籍完毕", C_GOLD, CC.DefaultFont)
				Cls()
			end

			if var_44_18 ~= -1 and DrawStrBoxYesNo(-1, -1, "是否要卸载武器?", C_WHITE, CC.DefaultFont, 1) == true then
				Cls()

				if JY.Thing[var_44_18].使用人 >= 0 then
					addthing(var_44_18, -1)
				end

				JY.Person[var_44_16].武器 = -1
				JY.Thing[var_44_18].使用人 = -1

				addthing(var_44_18, 1)
				Cls()
				DrawStrBoxWaitKey("卸载武器完毕", C_GOLD, CC.DefaultFont)
				Cls()

				if T2SQ(var_44_16) or cxtd(var_44_16, 123) then
					JY.Thing[var_44_18].加攻击力 = JY.Thing[var_44_18].加攻击力 / 2
					JY.Thing[var_44_18].加防御力 = JY.Thing[var_44_18].加防御力 / 2
					JY.Thing[var_44_18].加轻功 = JY.Thing[var_44_18].加轻功 / 2
				else
					JY.Thing[var_44_18].加攻击力 = JY.Thing[var_44_18].加攻击力
					JY.Thing[var_44_18].加防御力 = JY.Thing[var_44_18].加防御力
					JY.Thing[var_44_18].加轻功 = JY.Thing[var_44_18].加轻功
				end
			end

			if var_44_19 ~= -1 and DrawStrBoxYesNo(-1, -1, "是否要卸载防具?", C_WHITE, CC.DefaultFont, 1) == true then
				Cls()

				if JY.Thing[var_44_19].使用人 >= 0 then
					addthing(var_44_19, -1)
				end

				JY.Person[var_44_16].防具 = -1
				JY.Thing[var_44_19].使用人 = -1

				addthing(var_44_19, 1)
				Cls()
				DrawStrBoxWaitKey("卸载防具完毕", C_GOLD, CC.DefaultFont)

				if T2SQ(var_44_16) or cxtd(var_44_16, 123) then
					JY.Thing[var_44_19].加攻击力 = JY.Thing[var_44_19].加攻击力 / 2
					JY.Thing[var_44_19].加防御力 = JY.Thing[var_44_19].加防御力 / 2
					JY.Thing[var_44_19].加轻功 = JY.Thing[var_44_19].加轻功 / 2
				else
					JY.Thing[var_44_19].加攻击力 = JY.Thing[var_44_19].加攻击力
					JY.Thing[var_44_19].加防御力 = JY.Thing[var_44_19].加防御力
					JY.Thing[var_44_19].加轻功 = JY.Thing[var_44_19].加轻功
				end
			end

			if var_44_20 ~= -1 and DrawStrBoxYesNo(-1, -1, "是否要卸载饰品?", C_WHITE, CC.DefaultFont, 1) == true then
				Cls()

				if JY.Thing[var_44_20].使用人 >= 0 then
					addthing(var_44_20, -1)
				end

				JY.Person[var_44_16].饰品 = -1
				JY.Thing[var_44_20].使用人 = -1

				addthing(var_44_20, 1)
				Cls()
				DrawStrBoxWaitKey("卸载饰品完毕", C_GOLD, CC.DefaultFont)
			end

			if var_44_21 ~= -1 and DrawStrBoxYesNo(-1, -1, "是否要卸载坐骑?", C_WHITE, CC.DefaultFont, 1) == true then
				Cls()

				if JY.Thing[var_44_21].使用人 >= 0 then
					addthing(var_44_21, -1)
				end

				JY.Person[var_44_16].坐骑 = -1
				JY.Thing[var_44_21].使用人 = -1

				addthing(var_44_21, 1)
				Cls()
				DrawStrBoxWaitKey("卸载坐骑完毕", C_GOLD, CC.DefaultFont)
			end

			if var_44_17 == -1 and var_44_18 == -1 and var_44_19 == -1 and var_44_20 == -1 and var_44_21 == -1 then
				DrawStrBoxWaitKey("没有物品可以卸载", C_GOLD, CC.DefaultFont)
			end
		elseif (var_44_12 == VK_SPACE or var_44_12 == VK_RETURN) and var_44_0 == 3 then
			if var_44_5 == 0 then
				var_44_5 = var_44_4
			else
				var_44_5 = 0
			end
		end

		arg_44_0 = limitX(arg_44_0, 1, var_44_2)
		var_44_0 = limitX(var_44_0, 1, var_44_1)
	end
end

function WGWL(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = 0

	if arg_45_2 > 10 then
		var_45_0 = JY.Wugong[arg_45_1]["攻击力" .. 10]
	else
		var_45_0 = JY.Wugong[arg_45_1]["攻击力" .. arg_45_2]
	end

	if arg_45_1 == 62 and PersonKF(arg_45_0, 54) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 54 and PersonKF(arg_45_0, 62) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 37 and PersonKF(arg_45_0, 60) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 60 and PersonKF(arg_45_0, 37) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 36 and PersonKF(arg_45_0, 99) then
		var_45_0 = var_45_0 + 100
	elseif arg_45_1 == 35 and PersonKF(arg_45_0, 61) then
		var_45_0 = var_45_0 + 600
	elseif arg_45_1 == 61 and PersonKF(arg_45_0, 35) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 30 and PersonKF(arg_45_0, 31) and PersonKF(arg_45_0, 32) and PersonKF(arg_45_0, 33) and PersonKF(arg_45_0, 34) then
		var_45_0 = var_45_0 + 600
	elseif PersonKF(arg_45_0, 30) and arg_45_1 == 31 and PersonKF(arg_45_0, 32) and PersonKF(arg_45_0, 33) and PersonKF(arg_45_0, 34) then
		var_45_0 = var_45_0 + 600
	elseif PersonKF(arg_45_0, 30) and PersonKF(arg_45_0, 31) and arg_45_1 == 32 and PersonKF(arg_45_0, 33) and PersonKF(arg_45_0, 34) then
		var_45_0 = var_45_0 + 600
	elseif PersonKF(arg_45_0, 30) and PersonKF(arg_45_0, 31) and PersonKF(arg_45_0, 32) and arg_45_1 == 33 and PersonKF(arg_45_0, 34) then
		var_45_0 = var_45_0 + 600
	elseif PersonKF(arg_45_0, 30) and PersonKF(arg_45_0, 31) and PersonKF(arg_45_0, 32) and PersonKF(arg_45_0, 33) and arg_45_1 == 34 then
		var_45_0 = var_45_0 + 600
	elseif arg_45_1 == 72 and (PersonKF(arg_45_0, 73) and PersonKF(arg_45_0, 81) and PersonKF(arg_45_0, 71) or cxtd(arg_45_0, 115)) then
		var_45_0 = var_45_0 + 600
	elseif arg_45_1 == 73 and (PersonKF(arg_45_0, 72) and PersonKF(arg_45_0, 81) and PersonKF(arg_45_0, 71) or cxtd(arg_45_0, 115)) then
		var_45_0 = var_45_0 + 500
	elseif arg_45_1 == 81 and (PersonKF(arg_45_0, 72) and PersonKF(arg_45_0, 73) and PersonKF(arg_45_0, 71) or cxtd(arg_45_0, 115)) then
		var_45_0 = var_45_0 + 300
	elseif arg_45_1 == 71 and (PersonKF(arg_45_0, 72) and PersonKF(arg_45_0, 73) and PersonKF(arg_45_0, 81) or cxtd(arg_45_0, 115)) then
		var_45_0 = var_45_0 + 300
	elseif PersonKF(arg_45_0, 57) and JY.Person[0].品德 > 80 then
		local var_45_1 = JY.Person[0].品德 - 80

		var_45_0 = var_45_0 + 300 + var_45_1 * 20
	elseif PersonKF(arg_45_0, 58) and JY.Person[0].品德 < 40 then
		local var_45_2 = 40 - JY.Person[0].品德

		var_45_0 = var_45_0 + 300 + var_45_2 * 15
	end

	if arg_45_1 == 85 or arg_45_1 == 87 or arg_45_1 == 88 then
		if arg_45_2 > 10 then
			var_45_0 = JY.Wugong[arg_45_1]["杀内力" .. 10]
		else
			var_45_0 = JY.Wugong[arg_45_1]["杀内力" .. arg_45_2]
		end
	end

	if arg_45_1 == 123 and JY.Person[arg_45_0].拳掌功夫 >= 100 then
		var_45_0 = var_45_0 + JY.Person[arg_45_0].拳掌功夫
	end

	if arg_45_1 == 124 and JY.Person[arg_45_0].御剑能力 >= 100 then
		var_45_0 = var_45_0 + JY.Person[arg_45_0].御剑能力
	end

	if arg_45_1 == 125 and JY.Person[arg_45_0].耍刀技巧 >= 100 then
		var_45_0 = var_45_0 + JY.Person[arg_45_0].耍刀技巧
	end

	if arg_45_1 == 126 and JY.Person[arg_45_0].特殊兵器 >= 100 then
		var_45_0 = var_45_0 + JY.Person[arg_45_0].特殊兵器
	end

	if arg_45_1 == 8 and PersonKFJ(arg_45_0, 8) and JY.Person[arg_45_0].内力最大值 > 3000 then
		var_45_0 = math.modf(var_45_0 + (JY.Person[arg_45_0].内力最大值 - 3000) / 10)
	end

	if arg_45_1 == 14 and PersonKFJ(arg_45_0, 14) then
		local var_45_3 = JY.Person[arg_45_0].拳掌功夫 / 2
		local var_45_4 = JY.Person[arg_45_0].御剑能力 / 5
		local var_45_5 = JY.Person[arg_45_0].耍刀技巧 / 5
		local var_45_6 = JY.Person[arg_45_0].特殊兵器 / 5
		local var_45_7 = JY.Person[arg_45_0].暗器技巧 / 5

		var_45_0 = var_45_0 + math.modf(var_45_3 + var_45_4 + var_45_5 + var_45_6 + var_45_7)
	end

	if arg_45_1 == 67 and PersonKFJ(arg_45_0, 67) and PersonKFJ(arg_45_0, 44) then
		if PersonKFJ(arg_45_0, 77) then
			var_45_0 = var_45_0 + 500
		else
			var_45_0 = var_45_0 + 250
		end
	end

	if arg_45_1 == 44 and PersonKFJ(arg_45_0, 67) and PersonKFJ(arg_45_0, 44) then
		if PersonKFJ(arg_45_0, 77) then
			var_45_0 = var_45_0 + 500
		else
			var_45_0 = var_45_0 + 250
		end
	end

	if arg_45_1 == 26 and JY.Person[arg_45_0].生命增长 >= 8 then
		var_45_0 = var_45_0 + (JY.Person[arg_45_0].生命增长 - 8) * 100

		if var_45_0 > 1400 then
			var_45_0 = 1400
		end
	end

	if arg_45_1 == 172 and (arg_45_0 == 0 or JY.Person[arg_45_0].畅想级别 >= 4) then
		var_45_0 = var_45_0 + JY.Person[arg_45_0].实战

		if var_45_0 > 1300 then
			var_45_0 = 1300
		end
	end

	if arg_45_1 == 68 and (JY.Person[arg_45_0].坐骑 == 230 or JY.Person[arg_45_0].坐骑 == 225 or JY.Person[arg_45_0].坐骑 == 226) then
		var_45_0 = var_45_0 + 500
	end

	if arg_45_1 == 175 and (JY.Person[arg_45_0].坐骑 == 230 or JY.Person[arg_45_0].坐骑 == 225 or JY.Person[arg_45_0].坐骑 == 226) then
		var_45_0 = var_45_0 + 500
	end

	for iter_45_0, iter_45_1 in ipairs(CC.ExtraOffense) do
		if iter_45_1[1] == JY.Person[arg_45_0].武器 and iter_45_1[2] == arg_45_1 then
			var_45_0 = var_45_0 + iter_45_1[3]

			break
		end
	end

	return var_45_0
end

function ShowPersonStatus_sub(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	CleanMemory()

	local var_46_0 = CC.FontSmall3
	local var_46_1 = JY.Person[arg_46_0]
	local var_46_2 = JY.Person[0]
	local var_46_3 = 28 * var_46_0
	local var_46_4 = var_46_0 + CC.PersonStateRowPixel
	local var_46_5 = 18 * var_46_4 + 5
	local var_46_6 = (CC.ScreenW - var_46_3) / 2
	local var_46_7 = (CC.ScreenH - var_46_5) / 2
	local var_46_8 = 1
	local var_46_9
	local var_46_10
	local var_46_11

	DrawBox(50, 50, 50 + 38 * CC.FontSmall3, 50 + 18 * (CC.FontSmall3 + CC.RowPixel), M_SandyBrown)
	lib.SetClip(0, 0, 0, 0)

	local var_46_12 = var_46_6 + 5
	local var_46_13 = var_46_7 + 5
	local var_46_14 = 4 * var_46_0
	local var_46_15

	if arg_46_0 == 0 and JY.Base.畅想编号 == 0 then
		if JY.Base.主角职业 < 10 then
			if JY.Person[0].性别 == 0 then
				var_46_15 = 280 + JY.Base.主角职业
			else
				var_46_15 = 501 + JY.Base.主角职业
			end
		else
			var_46_15 = 289 + JY.Base.特殊主角
		end
	else
		var_46_15 = var_46_1.头像代号
	end

	local var_46_16, var_46_17 = lib.GetPNGXY(1, var_46_15 * 2)
	local var_46_18 = (var_46_3 / 2 - var_46_16) / 3
	local var_46_19 = (var_46_4 * 6 - var_46_17) / 6

	lib.LoadPNG(1, var_46_15 * 2, var_46_12 + var_46_18, var_46_13 + var_46_19, 1)

	local var_46_20 = 5

	DrawString(var_46_12, var_46_13 + var_46_4 * var_46_20, var_46_1.姓名, C_WHITE, var_46_0)
	DrawString(var_46_12 + 12 * var_46_0 / 2, var_46_13 + var_46_4 * var_46_20, string.format("%3d", var_46_1.等级), C_GOLD, var_46_0)
	DrawString(var_46_12 + 15 * var_46_0 / 2, var_46_13 + var_46_4 * var_46_20, "级", C_ORANGE, var_46_0)

	local var_46_21 = var_46_20 + 1

	DrawString(var_46_12, var_46_13 + var_46_4 * var_46_21, "天赋：", C_GOLD, var_46_0)

	if arg_46_0 == 0 and var_46_1.姓名 ~= JY.LEQ and var_46_1.姓名 ~= JY.SQ and var_46_1.姓名 ~= JY.XXM and var_46_1.姓名 ~= JY.RM and JY.Base.畅想编号 == 0 then
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, ZJTF[JY.Base.主角职业], C_GOLD, var_46_0)
	end

	if arg_46_0 == 0 and var_46_1.姓名 ~= JY.LEQ and var_46_1.姓名 ~= JY.SQ and var_46_1.姓名 ~= JY.XXM and var_46_1.姓名 ~= JY.RM and JY.Base.畅想编号 > 0 and RWTFLB[JY.Base.畅想编号] ~= nil then
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Base.畅想编号], C_GOLD, var_46_0)
	end

	if var_46_1.姓名 == JY.LEQ and arg_46_0 == 0 then
		if JY.Base.畅想编号 == 0 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB["01"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Base.畅想编号], C_GOLD, var_46_0)
		end
	end

	if var_46_1.姓名 == JY.SQ and arg_46_0 == 0 then
		if JY.Base.畅想编号 == 0 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB["02"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Base.畅想编号], C_GOLD, var_46_0)
		end
	end

	if var_46_1.姓名 == JY.XXM and arg_46_0 == 0 then
		if JY.Base.畅想编号 == 0 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB["03"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Base.畅想编号], C_GOLD, var_46_0)
		end
	end

	if var_46_1.姓名 == JY.RM and arg_46_0 == 0 then
		if JY.Base.畅想编号 == 0 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB["04"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Base.畅想编号], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 ~= 0 and arg_46_0 ~= 594 and arg_46_0 ~= 595 and arg_46_0 ~= 596 then
		if RWTFLB[arg_46_0] == nil then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, "无", C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[arg_46_0], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 ~= 0 and (arg_46_0 == 594 or arg_46_0 == 595 or arg_46_0 == 596) then
		if RWTFLB[JY.Person[arg_46_0].天赋] == nil then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, "无", C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_21, RWTFLB[JY.Person[arg_46_0].天赋], C_GOLD, var_46_0)
		end
	end

	local var_46_22 = var_46_21 + 1

	DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "称号：", C_GOLD, var_46_0)

	if JY.Base.畅想编号 ~= 35 and JY.Base.畅想编号 ~= 49 and JY.Base.畅想编号 ~= 0 and arg_46_0 == 0 then
		if RWWH[JY.Base.畅想编号] ~= nil then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[JY.Base.畅想编号], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, "无", C_GOLD, var_46_0)
		end
	end

	if arg_46_0 ~= 0 and arg_46_0 ~= 35 and arg_46_0 ~= 49 and arg_46_0 ~= 594 and arg_46_0 ~= 595 and arg_46_0 ~= 596 then
		if RWWH[arg_46_0] == nil then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, "无", C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[arg_46_0], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 ~= 0 and arg_46_0 ~= 35 and arg_46_0 ~= 49 and (arg_46_0 == 594 or arg_46_0 == 595 or arg_46_0 == 596) then
		if RWWH[JY.Person[arg_46_0].天赋] == nil then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, "无", C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[JY.Person[arg_46_0].天赋], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 0 and var_46_1.姓名 ~= JY.LEQ and var_46_1.姓名 ~= JY.SQ and var_46_1.姓名 ~= JY.XXM and var_46_1.姓名 ~= JY.RM and JY.Base.畅想编号 == 35 then
		if GetS(10, 1, 1, 0) == 1 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["35"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[35], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 35 then
		if GetS(10, 1, 1, 0) == 1 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["35"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[35], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 0 and var_46_1.姓名 == JY.LEQ then
		if JY.Base.觉醒 == 1 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["01b"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["01"], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 0 and var_46_1.姓名 == JY.SQ then
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["02"], C_GOLD, var_46_0)
	end

	if arg_46_0 == 0 and var_46_1.姓名 == JY.XXM then
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["03"], C_GOLD, var_46_0)
	end

	if arg_46_0 == 0 and var_46_1.姓名 == JY.RM then
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["04"], C_GOLD, var_46_0)
	end

	if arg_46_0 == 0 and JY.Base.主角职业 ~= 10 and JY.Base.畅想编号 == 0 then
		if JY.Base.觉醒 == 1 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["1"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["0"], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 0 and var_46_1.姓名 ~= JY.LEQ and var_46_1.姓名 ~= JY.SQ and var_46_1.姓名 ~= JY.XXM and var_46_1.姓名 ~= JY.RM and JY.Base.畅想编号 == 49 then
		if JY.Person[0].武功1 == 8 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["49"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[49], C_GOLD, var_46_0)
		end
	end

	if arg_46_0 == 49 then
		if JY.Person[49].武功1 == 8 then
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH["49"], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, RWWH[49], C_GOLD, var_46_0)
		end
	end

	local function var_46_23(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		arg_47_3 = arg_47_3 or 0

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, arg_47_0, arg_47_1, var_46_0)
		DrawString(var_46_12 + var_46_14, var_46_13 + var_46_4 * var_46_22, string.format("%5d", var_46_1[arg_47_0] + arg_47_3), arg_47_2, var_46_0)

		var_46_22 = var_46_22 + 1
	end

	if arg_46_1 == 1 then
		local var_46_24

		if var_46_1.受伤程度 < 33 then
			var_46_24 = RGB(236, 200, 40)
		elseif var_46_1.受伤程度 < 66 then
			var_46_24 = RGB(244, 128, 32)
		else
			var_46_24 = RGB(232, 32, 44)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "生命", C_ORANGE, var_46_0)
		DrawString(var_46_12 + 2 * var_46_0, var_46_13 + var_46_4 * var_46_22, string.format("%5d", var_46_1.生命), var_46_24, var_46_0)
		DrawString(var_46_12 + 9 * var_46_0 / 2, var_46_13 + var_46_4 * var_46_22, "/", C_GOLD, var_46_0)

		if var_46_1.中毒程度 == 0 then
			var_46_24 = RGB(252, 148, 16)
		elseif var_46_1.中毒程度 < 50 then
			var_46_24 = RGB(120, 208, 88)
		else
			var_46_24 = RGB(56, 136, 36)
		end

		DrawString(var_46_12 + 5 * var_46_0, var_46_13 + var_46_4 * var_46_22, string.format("%5s", var_46_1.生命最大值), var_46_24, var_46_0)

		var_46_22 = var_46_22 + 1

		if var_46_1.内力性质 == 0 then
			var_46_24 = RGB(208, 152, 208)
		elseif var_46_1.内力性质 == 1 then
			var_46_24 = RGB(236, 200, 40)
		else
			var_46_24 = RGB(236, 236, 236)
		end

		if JY.Base.主角职业 == 5 and arg_46_0 == JY.Base.队伍1 then
			var_46_24 = RGB(216, 20, 24)
		end

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "内力", C_ORANGE, var_46_0)
		DrawString(var_46_12 + 2 * var_46_0, var_46_13 + var_46_4 * var_46_22, string.format("%5d/%5d", var_46_1.内力, var_46_1.内力最大值), var_46_24, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "体力", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 2 + 8, var_46_13 + var_46_4 * var_46_22, var_46_1.体力, C_GOLD, var_46_0)
		DrawString(var_46_12 + var_46_0 * 4 + 16, var_46_13 + var_46_4 * var_46_22, "体质", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 6 + 32, var_46_13 + var_46_4 * var_46_22, var_46_1.生命增长, C_GOLD, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "魅力", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 2 + 8, var_46_13 + var_46_4 * var_46_22, Person_ml(arg_46_0), C_GOLD, var_46_0)
		DrawString(var_46_12 + var_46_0 * 4 + 16, var_46_13 + var_46_4 * var_46_22, "精神", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 6 + 32, var_46_13 + var_46_4 * var_46_22, Person_js(arg_46_0), C_GOLD, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "实战", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 2 + 8, var_46_13 + var_46_4 * var_46_22, var_46_1.实战, C_GOLD, var_46_0)
		DrawString(var_46_12 + var_46_0 * 4 + 16, var_46_13 + var_46_4 * var_46_22, "互搏", C_ORANGE, var_46_0)

		local var_46_25
		local var_46_26 = var_46_1.左右互搏 == 1 and "◎" or "※"

		DrawString(var_46_12 + var_46_0 * 6 + 24, var_46_13 + var_46_4 * var_46_22, var_46_26, C_GOLD, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "悟性", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 2 + 8, var_46_13 + var_46_4 * var_46_22, var_46_1.悟性, C_GOLD, var_46_0)
		DrawString(var_46_12 + var_46_0 * 4 + 16, var_46_13 + var_46_4 * var_46_22, "升级", C_ORANGE, var_46_0)

		local var_46_27

		if var_46_1.等级 >= 30 then
			var_46_27 = " ="
		else
			var_46_27 = var_46_1.经验

			if var_46_27 < 0 then
				var_46_27 = " 0"
			elseif var_46_27 < 10 then
				var_46_27 = " " .. var_46_27
			elseif var_46_27 < 100 then
				var_46_27 = " " .. var_46_27
			elseif var_46_27 < 1000 then
				var_46_27 = " " .. var_46_27
			end
		end

		DrawString(var_46_12 + var_46_0 * 6 + 12, var_46_13 + var_46_4 * var_46_22, var_46_27, C_GOLD, var_46_0)

		local var_46_28
		local var_46_29 = CC.Level <= var_46_1.等级 and "=" or CC.Exp[var_46_1.等级 + 1] - CC.Exp[var_46_1.等级]

		DrawString(var_46_12 + var_46_0 * 6 + 64, var_46_13 + var_46_4 * var_46_22, "/" .. var_46_29, C_GOLD, var_46_0)

		var_46_22 = var_46_22 + 2

		DrawString(var_46_12 + var_46_0 * 1, var_46_13 + var_46_4 * var_46_22, "武器:", M_YellowGreen, var_46_0)

		if var_46_1.武器 > -1 then
			DrawString(var_46_12 + 20 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, JY.Thing[var_46_1.武器].名称, C_WHITE, var_46_0)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12 + var_46_0 * 1, var_46_13 + var_46_4 * var_46_22, "防具:", M_YellowGreen, var_46_0)

		if var_46_1.防具 > -1 then
			DrawString(var_46_12 + 20 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, JY.Thing[var_46_1.防具].名称, C_WHITE, var_46_0)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12 + var_46_0 * 1, var_46_13 + var_46_4 * var_46_22, "饰品:", M_YellowGreen, var_46_0)

		if var_46_1.饰品 > -1 then
			DrawString(var_46_12 + 20 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, JY.Thing[var_46_1.饰品].名称, C_WHITE, var_46_0)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12 + var_46_0 * 1, var_46_13 + var_46_4 * var_46_22, "坐骑:", M_YellowGreen, var_46_0)

		if var_46_1.坐骑 > -1 then
			DrawString(var_46_12 + 20 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, JY.Thing[var_46_1.坐骑].名称, C_WHITE, var_46_0)
		end

		local var_46_30 = 0
		local var_46_31 = 0
		local var_46_32 = 0

		if var_46_1.武器 > -1 then
			var_46_30 = var_46_30 + JY.Thing[var_46_1.武器].加攻击力
			var_46_31 = var_46_31 + JY.Thing[var_46_1.武器].加防御力
			var_46_32 = var_46_32 + JY.Thing[var_46_1.武器].加轻功
		end

		if var_46_1.防具 > -1 then
			var_46_30 = var_46_30 + JY.Thing[var_46_1.防具].加攻击力
			var_46_31 = var_46_31 + JY.Thing[var_46_1.防具].加防御力
			var_46_32 = var_46_32 + JY.Thing[var_46_1.防具].加轻功
		end

		if var_46_1.坐骑 > -1 then
			var_46_30 = var_46_30 + JY.Thing[var_46_1.坐骑].加攻击力
			var_46_31 = var_46_31 + JY.Thing[var_46_1.坐骑].加防御力
			var_46_32 = var_46_32 + JY.Thing[var_46_1.坐骑].加轻功
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * 19, "左右键翻页 上下键换人 快捷键X卸载装备", C_RED, var_46_0)

		var_46_22 = 0
		var_46_12 = var_46_6 + var_46_3 / 2 - 24

		var_46_23("攻击力", C_WHITE, C_GOLD)
		DrawString(var_46_12 + var_46_0 * 7, var_46_13, "↑ " .. var_46_30, C_GOLD, var_46_0)
		var_46_23("防御力", C_WHITE, C_GOLD)
		DrawString(var_46_12 + var_46_0 * 7, var_46_13 + var_46_4, "↑ " .. var_46_31, C_GOLD, var_46_0)
		var_46_23("轻功", C_WHITE, C_GOLD)

		if var_46_32 > -1 then
			DrawString(var_46_12 + var_46_0 * 7, var_46_13 + var_46_4 * 2, "↑ " .. var_46_32, C_GOLD, var_46_0)
		else
			local var_46_33 = -var_46_32

			DrawString(var_46_12 + var_46_0 * 7, var_46_13 + var_46_4 * 2, "↓ " .. var_46_33, C_GOLD, var_46_0)
		end

		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 5), "中毒：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 5), var_46_1.中毒程度, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 6), "冰毒：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 6), var_46_1.中冰毒, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 7), "内伤：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 7), var_46_1.受伤程度, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 8), "火毒：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 8), var_46_1.中火毒, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 9), "封穴：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 9), var_46_1.中封穴, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 260, var_46_13 + var_46_4 * (var_46_22 + 10), "流血：", M_YellowGreen, CC.FontSmall2)
		DrawString(var_46_12 + 260 + 70, var_46_13 + var_46_4 * (var_46_22 + 10), var_46_1.流血值, C_WHITE, CC.FontSmall2)
		DrawString(var_46_12 + 230, var_46_13 + var_46_4 * (var_46_22 + 11), "连击率：", M_Magenta, var_46_0)
		DrawString(var_46_12 + 320, var_46_13 + var_46_4 * (var_46_22 + 11), " " .. LJLV(arg_46_0) .. "%", C_GOLD, var_46_0)
		DrawString(var_46_12 + 230, var_46_13 + var_46_4 * (var_46_22 + 12), "暴击率：", M_Magenta, var_46_0)
		DrawString(var_46_12 + 320, var_46_13 + var_46_4 * (var_46_22 + 12), " " .. BJlV(arg_46_0) .. "%", C_GOLD, var_46_0)
		DrawString(var_46_12 + 230, var_46_13 + var_46_4 * (var_46_22 + 13), "特色指令:", C_ORANGE, var_46_0)

		if arg_46_0 == 0 then
			GRTS[0] = "无"

			if JY.Person[0].驱虫术 >= 20 then
				DrawString(var_46_12 + 340 + 10, var_46_13 + var_46_4 * (var_46_22 + 14), "【驱虫术】", C_GOLD, var_46_0)
			end

			if JY.Base.畅想编号 > 0 and GRTS[JY.Base.畅想编号] ~= nil then
				GRTS[0] = GRTS[JY.Base.畅想编号]
				GRTSSAY[0] = GRTSSAY[JY.Base.畅想编号]

				DrawString(var_46_12 + 340 + 10, var_46_13 + var_46_4 * (var_46_22 + 13), "【" .. GRTS[JY.Base.畅想编号] .. "】", C_GOLD, var_46_0)
			end
		elseif GRTS[arg_46_0] ~= nil then
			DrawString(var_46_12 + 340 + 10, var_46_13 + var_46_4 * (var_46_22 + 13), "【" .. GRTS[arg_46_0] .. "】", C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + 340 + 10, var_46_13 + var_46_4 * (var_46_22 + 13), "【无】", C_GOLD, var_46_0)
		end

		DrawString(var_46_12 + 230, var_46_13 + var_46_4 * (var_46_22 + 15), "隐藏天赋:", C_ORANGE, var_46_0)

		if JY.Person[0].性格 > 0 then
			local var_46_34 = ""

			if JY.Person[0].性格 == 1 then
				var_46_34 = " 初级"
			elseif JY.Person[0].性格 == 2 then
				var_46_34 = " 中级"
			elseif JY.Person[0].性格 == 3 then
				var_46_34 = " 高级"
			end

			DrawString(var_46_12 + 230 + 15, var_46_13 + var_46_4 * (var_46_22 + 16), "【豪气冲天】" .. var_46_34, C_GOLD, var_46_0)
		end

		var_46_23("医疗能力", C_WHITE, C_GOLD)
		var_46_23("用毒能力", C_WHITE, C_GOLD)
		var_46_23("解毒能力", C_WHITE, C_GOLD)
		var_46_23("拳掌功夫", M_YellowGreen, C_GOLD)
		var_46_23("御剑能力", M_YellowGreen, C_GOLD)
		var_46_23("耍刀技巧", M_YellowGreen, C_GOLD)
		var_46_23("特殊兵器", M_YellowGreen, C_GOLD)
		var_46_23("暗器技巧", M_YellowGreen, C_GOLD)
		var_46_23("抗毒能力", C_WHITE, C_GOLD)
		var_46_23("武学常识", C_WHITE, C_GOLD)
		var_46_23("儒学修为", C_WHITE, C_GOLD)
		var_46_23("佛学修为", C_WHITE, C_GOLD)
		var_46_23("阵法知识", C_WHITE, C_GOLD)
		var_46_23("盗贼技巧", C_WHITE, C_GOLD)
		var_46_23("驱虫术", C_WHITE, C_GOLD)
	elseif arg_46_1 == 2 then
		var_46_22 = 7
		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "主功体：", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, "【" .. JY.Wugong[var_46_1.主功体].名称 .. "】", C_RED, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "副功体：", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 3, var_46_13 + var_46_4 * var_46_22, "【" .. JY.Wugong[var_46_1.副功体].名称 .. "】", C_RED, var_46_0)

		var_46_22 = var_46_22 + 1

		local var_46_35 = var_46_1.主运轻功

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "主运轻功：", C_ORANGE, var_46_0)
		DrawString(var_46_12 + var_46_0 * 4, var_46_13 + var_46_4 * var_46_22, "【" .. JY.Wugong[var_46_1.主运轻功].名称 .. "】", C_RED, var_46_0)

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "集气速度:", C_ORANGE, var_46_0)

		if JY.Status == GAME_WMAP and WAR.JQSDXS[arg_46_0] ~= nil then
			DrawString(var_46_12 + var_46_0 * 5, var_46_13 + var_46_4 * var_46_22, WAR.JQSDXS[arg_46_0], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 5, var_46_13 + var_46_4 * var_46_22, 0, C_GOLD, var_46_0)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "战意:", C_ORANGE, var_46_0)

		if JY.Status == GAME_WMAP and WAR.ZYZ[arg_46_0] ~= nil then
			DrawString(var_46_12 + var_46_0 * 4, var_46_13 + var_46_4 * var_46_22, math.modf(WAR.ZYZ[arg_46_0]), C_GOLD, CC.size)
		else
			DrawString(var_46_12 + var_46_0 * 4, var_46_13 + var_46_4 * var_46_22, 0, C_GOLD, CC.size)
		end

		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "怒气:", C_ORANGE, var_46_0)

		if JY.Status == GAME_WMAP and WAR.LQZ[arg_46_0] ~= nil then
			DrawString(var_46_12 + var_46_0 * 4, var_46_13 + var_46_4 * var_46_22, WAR.LQZ[arg_46_0], C_GOLD, var_46_0)
		else
			DrawString(var_46_12 + var_46_0 * 4, var_46_13 + var_46_4 * var_46_22, 0, C_GOLD, var_46_0)
		end

		var_46_22 = var_46_22 + 2

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, "修炼物品", M_YellowGreen, var_46_0)

		local var_46_36 = var_46_1.修炼物品

		if var_46_36 > 0 then
			var_46_22 = var_46_22 + 1

			DrawString(var_46_12 + var_46_0, var_46_13 + var_46_4 * var_46_22, JY.Thing[var_46_36].名称, C_GOLD, var_46_0)

			var_46_22 = var_46_22 + 1

			local var_46_37 = TrainNeedExp(arg_46_0)

			if var_46_37 < math.huge then
				DrawString(var_46_12 + var_46_0, var_46_13 + var_46_4 * var_46_22, string.format("%5d/%5d", var_46_1.修炼点数, var_46_37), C_GOLD, var_46_0)
			else
				DrawString(var_46_12 + var_46_0, var_46_13 + var_46_4 * var_46_22, string.format("%5d/===", var_46_1.修炼点数), C_GOLD, var_46_0)
			end
		else
			var_46_22 = var_46_22 + 2
		end

		var_46_22 = var_46_22 + 2

		DrawString(var_46_12, var_46_13 + var_46_4 * 19, "左右键翻页 上下键换人", C_RED, var_46_0)

		var_46_22 = 0
		var_46_12 = var_46_6 + var_46_3 / 2

		DrawString(var_46_12 - var_46_0, var_46_13 + var_46_4 * var_46_22, "所会功夫　　等级　威力", C_ORANGE, var_46_0)

		local var_46_38 = {
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

		for iter_46_0 = 1, 20 do
			var_46_22 = var_46_22 + 1

			local var_46_39 = var_46_1["武功" .. iter_46_0]

			if var_46_39 > 0 then
				local var_46_40 = math.modf(var_46_1["武功等级" .. iter_46_0] / 100) + 1

				if var_46_1["武功等级" .. iter_46_0] == 999 then
					var_46_40 = 11
				end

				local var_46_41 = C_GOLD

				if var_46_39 == 43 or var_46_39 == 85 or var_46_39 > 86 and var_46_39 < 109 then
					var_46_41 = RGB(200, 36, 69)
				end

				for iter_46_1, iter_46_2 in pairs(CC.PersonWs) do
					if iter_46_2[1] ~= nil and cxtd(arg_46_0, iter_46_2[1]) and var_46_39 == iter_46_2[2] then
						var_46_41 = RGB(192, 192, 192)
					end
				end

				local var_46_42 = C_ORANGE

				if var_46_39 == 43 or var_46_39 == 85 or var_46_39 > 86 and var_46_39 < 109 then
					var_46_42 = C_RED
				end

				for iter_46_3, iter_46_4 in pairs(CC.PersonWs) do
					if iter_46_4[1] ~= nil and cxtd(arg_46_0, iter_46_4[1]) and var_46_39 == iter_46_4[2] then
						var_46_42 = C_WHITE
					end
				end

				DrawString(var_46_12 - CC.FontSmall2, var_46_13 + var_46_4 * var_46_22, string.format("%s", JY.Wugong[var_46_39].名称), var_46_41, CC.FontSmall2)

				if var_46_1["武功等级" .. iter_46_0] > 900 then
					lib.SetClip(var_46_12 - CC.FontSmall2, var_46_13 + var_46_4 * 1, var_46_12 + CC.FontSmall2 - string.len(JY.Wugong[var_46_39].名称) * CC.FontSmall2 * (var_46_1["武功等级" .. iter_46_0] - 900) / 200, var_46_13 + var_46_4 * var_46_22 + var_46_4)
					DrawString(var_46_12 - CC.FontSmall2, var_46_13 + var_46_4 * var_46_22, string.format("%s", JY.Wugong[var_46_39].名称), var_46_42, CC.FontSmall2)
					lib.SetClip(0, 0, 0, 0)
				end

				DrawString(var_46_12 + CC.FontSmall3 * 5, var_46_13 + var_46_4 * var_46_22, var_46_38[var_46_40], var_46_41, CC.FontSmall2)
				DrawString(var_46_12 + CC.FontSmall3 * 8, var_46_13 + var_46_4 * var_46_22, WGWL(arg_46_0, var_46_39, var_46_40), var_46_41, CC.FontSmall2)

				if var_46_1["武功等级" .. iter_46_0] == 999 then
					DrawString(var_46_12 + CC.FontSmall3 * 5, var_46_13 + var_46_4 * var_46_22, var_46_38[var_46_40], var_46_42, CC.FontSmall2)
					DrawString(var_46_12 + CC.FontSmall3 * 8, var_46_13 + var_46_4 * var_46_22, WGWL(arg_46_0, var_46_39, var_46_40), var_46_41, CC.FontSmall2)
				end
			end
		end
	elseif arg_46_1 == 3 then
		local var_46_43 = C_WHITE
		local var_46_44 = C_ORANGE

		if JY.Status == GAME_WMAP then
			var_46_43 = C_ORANGE

			local var_46_45 = C_ORANGE
		end

		var_46_22 = 8
		var_46_22 = var_46_22 + 1

		DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22, var_46_1.姓名 .. " AI设定", C_ORANGE, var_46_0)

		var_46_22 = var_46_22 + 1

		local var_46_46 = {
			"战斗控制",
			"战斗模式",
			"喜使武功"
		}

		for iter_46_5 = 1, 3 do
			local var_46_47 = M_YellowGreen

			if arg_46_2 == iter_46_5 then
				var_46_47 = M_PaleGreen

				DrawString(var_46_12 - var_46_0 - 2, var_46_13 + var_46_4 * var_46_22 + var_46_4 * (iter_46_5 - 1) * 2, ">", var_46_47, var_46_0)
			end

			if JY.Status == GAME_WMAP and iter_46_5 == 3 then
				var_46_47 = M_PaleGreen
			end

			DrawString(var_46_12, var_46_13 + var_46_4 * var_46_22 + var_46_4 * (iter_46_5 - 1) * 2, var_46_46[iter_46_5], var_46_47, var_46_0)
		end

		var_46_13 = var_46_13 + var_46_4

		local var_46_48 = {
			"【自动攻击】",
			"【手动控制】"
		}

		for iter_46_6 = 1, 2 do
			local var_46_49 = C_WHITE

			if arg_46_3[1] == iter_46_6 then
				var_46_49 = C_GOLD
			end

			DrawString(var_46_12 - 110 + var_46_4 * 5 * iter_46_6, var_46_13 + var_46_4 * var_46_22, var_46_48[iter_46_6], var_46_49, var_46_0 * 0.9)
		end

		var_46_22 = var_46_22 + 2

		local var_46_50 = {
			"【攻击型】",
			"【防御型】"
		}

		for iter_46_7 = 1, 2 do
			local var_46_51 = C_WHITE

			if arg_46_3[2] == iter_46_7 then
				var_46_51 = C_GOLD
			end

			DrawString(var_46_12 - 110 + var_46_4 * 5 * iter_46_7, var_46_13 + var_46_4 * var_46_22, var_46_50[iter_46_7], var_46_51, var_46_0 * 0.9)
		end

		var_46_22 = var_46_22 + 2

		if var_46_1.喜使武功 == 0 then
			DrawString(var_46_12 - 110 + var_46_4 * 5, var_46_13 + var_46_4 * var_46_22, "【未设定】", var_46_43, var_46_0 * 0.9)
		else
			DrawString(var_46_12 - 110 + var_46_4 * 5, var_46_13 + var_46_4 * var_46_22, JY.Wugong[var_46_1.喜使武功].名称, var_46_43, var_46_0 * 0.9)
		end

		if JY.Restart == 1 then
			return
		end

		local var_46_52 = CC.FontSmall4
		local var_46_53 = JY.Person[arg_46_0]
		local var_46_54 = JY.Person[0]
		local var_46_55 = var_46_52 + CC.PersonStateRowPixel

		var_46_12 = var_46_6 + var_46_3 / 2 - 24
		var_46_13 = 120

		local var_46_56 = 1
		local var_46_57 = var_46_13
		local var_46_58

		if arg_46_0 == 0 and JY.Base.畅想编号 == 0 then
			if JY.Base.主角职业 < 10 then
				var_46_58 = 280 + JY.Base.主角职业
			else
				var_46_58 = 289 + JY.Base.特殊主角
			end
		elseif arg_46_0 == 0 and JY.Base.畅想编号 > 0 then
			var_46_58 = JY.Base.畅想编号
		else
			var_46_58 = arg_46_0
		end

		local function var_46_59(arg_48_0)
			local var_48_0 = {
				{
					"Ｒ",
					PinkRed
				},
				{
					"Ｇ",
					C_GOLD
				},
				{
					"Ｂ",
					C_BLACK
				},
				{
					"Ｗ",
					C_WHITE
				},
				{
					"Ｏ",
					C_ORANGE
				},
				{
					"Ｌ",
					C_RED
				},
				{
					"Ｄ",
					M_DeepSkyBlue
				},
				{
					"Ｚ",
					Violet
				}
			}

			for iter_48_0 = 1, 8 do
				if var_48_0[iter_48_0][1] == arg_48_0 then
					return var_48_0[iter_48_0][2]
				end
			end
		end

		var_46_12 = var_46_12 - var_46_52

		local var_46_60 = 1

		if TFJS[var_46_58] ~= nil then
			local var_46_61 = var_46_57 + 13

			for iter_46_8 = var_46_56, #TFJS[var_46_58] do
				local var_46_62 = TFJS[var_46_58][iter_46_8]

				if var_46_60 < 20 then
					if string.sub(var_46_62, 1, 2) == "Ｎ" then
						var_46_60 = var_46_60 + 1
					else
						local var_46_63
						local var_46_64 = var_46_59(string.sub(var_46_62, 1, 2))
						local var_46_65 = string.sub(var_46_62, 3, -1)

						DrawString(var_46_12, var_46_61 + (var_46_55 - 2) * var_46_60, var_46_65, var_46_64, var_46_52 * 0.9)

						var_46_60 = var_46_60 + 1
					end
				end
			end

			local var_46_66 = var_46_60 + 1
		end
	end
end

function TrainNeedExp(arg_49_0)
	local var_49_0 = JY.Person[arg_49_0].修炼物品
	local var_49_1 = 0

	if var_49_0 >= 0 then
		if JY.Thing[var_49_0].练出武功 >= 0 then
			local var_49_2 = 0

			for iter_49_0 = 1, CC.Kungfunum do
				if JY.Person[arg_49_0]["武功" .. iter_49_0] == JY.Thing[var_49_0].练出武功 then
					var_49_2 = math.modf(JY.Person[arg_49_0]["武功等级" .. iter_49_0] / 100)

					break
				end
			end

			if var_49_2 < 9 then
				var_49_1 = (7 - math.modf(JY.Person[arg_49_0].悟性 / 15)) * JY.Thing[var_49_0].需经验 * (var_49_2 + 1)
			else
				var_49_1 = math.huge
			end
		else
			var_49_1 = (7 - math.modf(JY.Person[arg_49_0].悟性 / 15)) * JY.Thing[var_49_0].需经验 * 2
		end
	end

	if PersonKFJ(arg_49_0, 106) then
		var_49_1 = math.modf(var_49_1 * 3 / 4)
	end

	return var_49_1
end

function Menu_Doctor()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁要使用医术", C_WHITE, CC.DefaultFont)

	local var_50_0 = CC.MainSubMenuY + CC.SingleLineHeight

	DrawStrBox(CC.MainSubMenuX, var_50_0, "医疗能力", C_ORANGE, CC.DefaultFont)

	local var_50_1 = {}

	for iter_50_0 = 1, CC.TeamNum do
		var_50_1[iter_50_0] = {
			"",
			nil,
			0
		}

		local var_50_2 = JY.Base["队伍" .. iter_50_0]

		if var_50_2 >= 0 and JY.Person[var_50_2].医疗能力 >= 20 then
			var_50_1[iter_50_0][1] = string.format("%-10s%4d", JY.Person[var_50_2].姓名, JY.Person[var_50_2].医疗能力)
			var_50_1[iter_50_0][3] = 1
		end
	end

	local var_50_3
	local var_50_4
	local var_50_5 = var_50_0 + CC.SingleLineHeight
	local var_50_6 = ShowMenu(var_50_1, CC.TeamNum, 0, CC.MainSubMenuX, var_50_5, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_50_6 > 0 then
		local var_50_7 = JY.Base["队伍" .. var_50_6]

		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要医治谁", C_WHITE, CC.DefaultFont)

		local var_50_8 = CC.MainSubMenuY + CC.SingleLineHeight
		local var_50_9 = {}

		for iter_50_1 = 1, CC.TeamNum do
			var_50_9[iter_50_1] = {
				"",
				nil,
				0
			}

			local var_50_10 = JY.Base["队伍" .. iter_50_1]

			if var_50_10 >= 0 then
				var_50_9[iter_50_1][1] = string.format("%-10s%4d/%4d", JY.Person[var_50_10].姓名, JY.Person[var_50_10].生命, JY.Person[var_50_10].生命最大值)
				var_50_9[iter_50_1][3] = 1
			end
		end

		local var_50_11 = ShowMenu(var_50_9, CC.TeamNum, 0, CC.MainSubMenuX, var_50_8, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

		if var_50_11 > 0 then
			local var_50_12 = JY.Base["队伍" .. var_50_11]
			local var_50_13 = ExecDoctor(var_50_7, var_50_12)

			if var_50_13 > 0 then
				AddPersonAttrib(var_50_7, "体力", -2)

				if JY.Person[var_50_7].医疗能力 >= 100 then
					AddPersonAttrib(var_50_12, "流血值", -5)
					AddPersonAttrib(var_50_12, "受伤程度", -5)
				end
			end

			if JY.Person[var_50_12].流血值 < 0 then
				JY.Person[var_50_12].流血值 = 0
			end

			if JY.Person[var_50_12].受伤程度 < 0 then
				JY.Person[var_50_12].受伤程度 = 0
			end

			DrawStrBoxWaitKey(string.format("%s 生命增加 %d", JY.Person[var_50_12].姓名, var_50_13), C_ORANGE, CC.DefaultFont)
		end
	end

	Cls()

	return 0
end

function ExecDoctor(arg_51_0, arg_51_1)
	if JY.Person[arg_51_0].体力 < 50 then
		return 0
	end

	local var_51_0 = JY.Person[arg_51_0].医疗能力
	local var_51_1 = JY.Person[arg_51_1].受伤程度

	if var_51_1 > var_51_0 + 20 then
		return 0
	end

	if var_51_1 < 25 then
		var_51_0 = var_51_0 * 4 / 5
	elseif var_51_1 < 50 then
		var_51_0 = var_51_0 * 3 / 4
	elseif var_51_1 < 75 then
		var_51_0 = var_51_0 * 2 / 3
	else
		var_51_0 = var_51_0 / 2
	end

	local var_51_2 = math.modf(var_51_0) + Rnd(5)

	AddPersonAttrib(arg_51_1, "受伤程度", -var_51_2)
	AddPersonAttrib(arg_51_1, "流血值", -var_51_2)

	return AddPersonAttrib(arg_51_1, "生命", var_51_2)
end

function Menu_DecPoison()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁要帮人解毒", C_WHITE, CC.DefaultFont)

	local var_52_0 = CC.MainSubMenuY + CC.SingleLineHeight

	DrawStrBox(CC.MainSubMenuX, var_52_0, "解毒能力", C_ORANGE, CC.DefaultFont)

	local var_52_1 = {}

	for iter_52_0 = 1, CC.TeamNum do
		var_52_1[iter_52_0] = {
			"",
			nil,
			0
		}

		local var_52_2 = JY.Base["队伍" .. iter_52_0]

		if var_52_2 >= 0 and JY.Person[var_52_2].解毒能力 >= 20 then
			var_52_1[iter_52_0][1] = string.format("%-10s%4d", JY.Person[var_52_2].姓名, JY.Person[var_52_2].解毒能力)
			var_52_1[iter_52_0][3] = 1
		end
	end

	local var_52_3
	local var_52_4
	local var_52_5 = var_52_0 + CC.SingleLineHeight
	local var_52_6 = ShowMenu(var_52_1, CC.TeamNum, 0, CC.MainSubMenuX, var_52_5, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_52_6 > 0 then
		local var_52_7 = JY.Base["队伍" .. var_52_6]

		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "替谁解毒", C_WHITE, CC.DefaultFont)

		local var_52_8 = CC.MainSubMenuY + CC.SingleLineHeight

		DrawStrBox(CC.MainSubMenuX, var_52_8, "中毒程度", C_WHITE, CC.DefaultFont)

		local var_52_9 = var_52_8 + CC.SingleLineHeight
		local var_52_10 = {}

		for iter_52_1 = 1, CC.TeamNum do
			var_52_10[iter_52_1] = {
				"",
				nil,
				0
			}

			local var_52_11 = JY.Base["队伍" .. iter_52_1]

			if var_52_11 >= 0 then
				var_52_10[iter_52_1][1] = string.format("%-10s%5d", JY.Person[var_52_11].姓名, JY.Person[var_52_11].中毒程度)
				var_52_10[iter_52_1][3] = 1
			end
		end

		local var_52_12 = ShowMenu(var_52_10, CC.TeamNum, 0, CC.MainSubMenuX, var_52_9, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

		if var_52_12 > 0 then
			local var_52_13 = JY.Base["队伍" .. var_52_12]
			local var_52_14 = ExecDecPoison(var_52_7, var_52_13)

			DrawStrBoxWaitKey(string.format("%s 中毒程度减少 %d", JY.Person[var_52_13].姓名, var_52_14), C_ORANGE, CC.DefaultFont)
		end
	end

	Cls()
	ShowScreen()

	return 0
end

function ExecDecPoison(arg_53_0, arg_53_1)
	local var_53_0 = JY.Person[arg_53_0].解毒能力
	local var_53_1 = JY.Person[arg_53_1].中毒程度

	if var_53_1 > var_53_0 + 20 then
		return 0
	end

	local var_53_2 = limitX(math.modf(var_53_0 / 3) + Rnd(10) - Rnd(10), 0, var_53_1)

	return -AddPersonAttrib(arg_53_1, "中毒程度", -var_53_2)
end

function SelectThing(arg_54_0, arg_54_1)
	local var_54_0 = CC.MenuThingXnum
	local var_54_1 = CC.MenuThingYnum
	local var_54_2 = CC.ThingPicWidth * var_54_0 * 2.5 + (var_54_0 - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut
	local var_54_3 = CC.ThingPicHeight * var_54_1 * 2.5 + (var_54_1 - 1) * CC.ThingGapIn + 2 * CC.ThingGapOut
	local var_54_4 = (CC.ScreenW - var_54_2) / 2
	local var_54_5 = (CC.ScreenH - var_54_3 - 2 * (CC.ThingFontSize + 2 * CC.MenuBorderPixel + 5)) / 2 - 25
	local var_54_6
	local var_54_7
	local var_54_8
	local var_54_9
	local var_54_10
	local var_54_11
	local var_54_12 = 0
	local var_54_13 = 0
	local var_54_14 = 0
	local var_54_15 = -1

	while true do
		Cls()

		local var_54_16 = var_54_5
		local var_54_17 = var_54_16 + CC.ThingFontSize + 2 * CC.MenuBorderPixel

		DrawBox(var_54_4, var_54_16, var_54_4 + var_54_2, var_54_17, C_WHITE)

		local var_54_18 = var_54_17 + 5
		local var_54_19 = var_54_18 + CC.ThingFontSize + 2 * CC.MenuBorderPixel

		DrawBox(var_54_4, var_54_18, var_54_4 + var_54_2, var_54_19, C_WHITE)

		local var_54_20 = var_54_19 + 5
		local var_54_21 = var_54_20 + var_54_3

		DrawBox(var_54_4, var_54_20, var_54_4 + var_54_2, var_54_21, C_WHITE)

		for iter_54_0 = 0, var_54_1 - 1 do
			for iter_54_1 = 0, var_54_0 - 1 do
				local var_54_22 = iter_54_0 * var_54_0 + iter_54_1 + var_54_0 * var_54_12
				local var_54_23

				if iter_54_1 == var_54_13 and iter_54_0 == var_54_14 then
					var_54_23 = C_WHITE

					if arg_54_0[var_54_22] >= 0 then
						var_54_15 = arg_54_0[var_54_22]

						local var_54_24 = JY.Thing[arg_54_0[var_54_22]].名称

						if (JY.Thing[arg_54_0[var_54_22]].类型 == 1 or JY.Thing[arg_54_0[var_54_22]].类型 == 2) and JY.Thing[arg_54_0[var_54_22]].使用人 >= 0 then
							var_54_24 = var_54_24 .. "(" .. JY.Person[JY.Thing[arg_54_0[var_54_22]].使用人].姓名 .. ")"
						end

						local var_54_25 = string.format("%s X %d", var_54_24, arg_54_1[var_54_22])
						local var_54_26 = JY.Thing[arg_54_0[var_54_22]].物品说明
						local var_54_27 = math.modf(GetS(14, 3, 1, 4) / 100)

						if arg_54_0[var_54_22] == 138 and JY.Base.主角职业 == 3 then
							var_54_26 = var_54_26 .. string.format("(无名刀法等级：%3d级)", var_54_27)
						end

						DrawString(var_54_4 + CC.ThingGapOut, var_54_16 + CC.MenuBorderPixel, var_54_25, C_GOLD, CC.ThingFontSize)
						DrawString(var_54_4 + CC.ThingGapOut, var_54_18 + CC.MenuBorderPixel, var_54_26, C_ORANGE, CC.ThingFontSize)

						local var_54_28 = CC.DefaultFont
						local var_54_29 = var_54_4 + 4 * var_54_28
						local var_54_30 = var_54_21 + 2
						local var_54_31 = 0
						local var_54_32 = JY.Thing[arg_54_0[var_54_22]]

						local function var_54_33(arg_55_0, arg_55_1, arg_55_2)
							local var_55_0

							if arg_55_1 == nil then
								var_55_0 = arg_55_0
							elseif var_54_32[arg_55_0] ~= 0 then
								if arg_55_2 == nil then
									if var_54_31 == 0 then
										var_55_0 = string.format(arg_55_1 .. ":%+d", var_54_32[arg_55_0])
									elseif var_54_31 == 1 then
										var_55_0 = string.format(arg_55_1 .. ":%d", var_54_32[arg_55_0])
									end
								else
									if var_54_32[arg_55_0] < 0 then
										return
									end

									var_55_0 = string.format(arg_55_1 .. ":%s", arg_55_2[var_54_32[arg_55_0]])
								end
							elseif var_54_32[arg_55_0] == 0 and arg_55_0 == "需内力性质" then
								var_55_0 = string.format(arg_55_1 .. ":%s", arg_55_2[var_54_32[arg_55_0]])
							else
								return
							end

							local var_55_1 = C_GOLD

							if arg_55_0 == "需内力性质" then
								if var_54_32[arg_55_0] == 0 then
									var_55_1 = M_DeepSkyBlue
								elseif var_54_32[arg_55_0] == 1 then
									var_55_1 = C_ORANGE
								elseif var_54_32[arg_55_0] == 2 then
									var_55_1 = C_WHITE
								end
							end

							local var_55_2 = var_54_28 * string.len(var_55_0) / 2 + 12

							if CC.ScreenW - var_54_4 < var_54_29 + var_55_2 then
								var_54_30 = var_54_30 + var_54_28 + 10
								var_54_29 = var_54_4 + 4 * var_54_28
							end

							DrawStrBox(var_54_29, var_54_30, var_55_0, var_55_1, var_54_28)

							var_54_29 = var_54_29 + var_55_2
						end

						if var_54_32.练出武功 > 0 then
							local var_54_34 = "习得:" .. JY.Wugong[var_54_32.练出武功].名称

							DrawStrBox(var_54_29, var_54_30, var_54_34, C_GOLD, var_54_28)

							var_54_29 = var_54_29 + var_54_28 * string.len(var_54_34) / 2 + 12

							if JY.Wugong[var_54_32.练出武功].攻击力10 > 0 then
								local var_54_35 = "威力:" .. JY.Wugong[var_54_32.练出武功].攻击力10

								DrawStrBox(var_54_29, var_54_30, var_54_35, C_GOLD, var_54_28)

								var_54_29 = var_54_29 + var_54_28 * string.len(var_54_35) / 2 + 12
							end
						end

						if var_54_32.类型 > 0 then
							var_54_33("加生命", "生命")
							var_54_33("加生命最大值", "生命上限")
							var_54_33("加中毒解毒", "中毒")
							var_54_33("加体力", "体力")

							if var_54_32.改变内力性质 == 2 then
								var_54_33("内力调和")
							end

							var_54_33("加内力", "内力")
							var_54_33("加内力最大值", "内力上限")
							var_54_33("加攻击力", "攻")
							var_54_33("加轻功", "轻")
							var_54_33("加防御力", "防")
							var_54_33("加医疗能力", "医疗")
							var_54_33("加用毒能力", "用毒")
							var_54_33("加解毒能力", "解毒")
							var_54_33("加抗毒能力", "抗毒")
							var_54_33("加拳掌功夫", "拳")
							var_54_33("加御剑能力", "剑")
							var_54_33("加耍刀技巧", "刀")
							var_54_33("加特殊兵器", "特")
							var_54_33("加暗器技巧", "暗器")
							var_54_33("加武学常识", "武常")
							var_54_33("加品德", "品德")
							var_54_33("加攻击次数", "左右互搏", {
								[0] = "否",
								"是"
							})
							var_54_33("加攻击带毒", "带毒")
							var_54_33("加魅力", "魅力")
							var_54_33("加精神", "精神")
							var_54_33("加气运", "气运")
							var_54_33("加冰毒解毒", "去冰毒")
							var_54_33("加火毒解毒", "去火毒")
							var_54_33("止血", "止血")

							if var_54_29 ~= var_54_4 or var_54_30 ~= var_54_21 + 2 then
								DrawStrBox(var_54_4, var_54_21 + 2, " 效果:", C_RED, var_54_28)
							end
						end

						if var_54_32.类型 == 1 and var_54_32.装备类型 == 0 then
							local var_54_36 = {}

							for iter_54_2 = 1, #CC.ExtraOffense do
								if CC.ExtraOffense[iter_54_2][1] == arg_54_0[var_54_22] then
									var_54_36[#var_54_36 + 1] = CC.ExtraOffense[iter_54_2][2]
								end
							end

							if #var_54_36 > 0 then
								local var_54_37 = "加成武功："

								for iter_54_3 = 1, #var_54_36 do
									var_54_37 = var_54_37 .. JY.Wugong[var_54_36[iter_54_3]].名称 .. " "
								end

								var_54_33(var_54_37)
							end
						end

						if var_54_32.类型 == 1 or var_54_32.类型 == 2 then
							if var_54_29 ~= var_54_4 then
								var_54_29 = var_54_4 + 4 * var_54_28
								var_54_30 = var_54_30 + var_54_28 + 10
							end

							var_54_31 = 1

							local var_54_38 = var_54_30

							if var_54_32.仅修炼人物 > -1 then
								var_54_33("仅限:" .. JY.Person[var_54_32.仅修炼人物].姓名)
							end

							var_54_33("需内力性质", "阴阳", {
								[0] = "阴",
								"阳",
								"不限"
							})
							var_54_33("需内力", "内力")
							var_54_33("需攻击力", "攻")
							var_54_33("需轻功", "轻")
							var_54_33("需用毒能力", "用毒")
							var_54_33("需医疗能力", "医疗")
							var_54_33("需解毒能力", "解毒")
							var_54_33("需拳掌功夫", "拳")
							var_54_33("需御剑能力", "剑")
							var_54_33("需耍刀技巧", "刀")
							var_54_33("需特殊兵器", "特")
							var_54_33("需暗器技巧", "暗器")
							var_54_33("需悟性", "悟性")
							var_54_33("需经验", "经验")

							if var_54_29 ~= var_54_4 or var_54_30 ~= var_54_38 then
								DrawStrBox(var_54_4, var_54_38, " 需求:", C_RED, var_54_28)
							end
						end
					else
						var_54_15 = -1
					end
				else
					var_54_23 = C_BLACK
				end

				local var_54_39 = var_54_4 + CC.ThingGapOut + iter_54_1 * (CC.ThingPicWidth * 2.5 + CC.ThingGapIn)
				local var_54_40 = var_54_20 + CC.ThingGapOut + iter_54_0 * (CC.ThingPicHeight * 2.5 + CC.ThingGapIn)

				lib.DrawRect(var_54_39, var_54_40, var_54_39 + CC.ThingPicWidth * 2.5 + 1, var_54_40 + CC.ThingPicHeight * 2.5 + 1, var_54_23)

				if arg_54_0[var_54_22] >= 0 then
					lib.PicLoadCache(2, arg_54_0[var_54_22] * 2, var_54_39 + 1, var_54_40 + 1, 1)
				end
			end
		end

		ShowScreen()

		local var_54_41 = WaitKey(1)

		lib.Delay(100)

		if var_54_41 == VK_ESCAPE then
			var_54_15 = -1

			break
		elseif var_54_41 == VK_RETURN or var_54_41 == VK_SPACE then
			break
		elseif var_54_41 == VK_UP then
			if var_54_14 == 0 then
				if var_54_12 > 0 then
					var_54_12 = var_54_12 - 1
				end
			else
				var_54_14 = var_54_14 - 1
			end
		elseif var_54_41 == VK_DOWN then
			if var_54_14 == var_54_1 - 1 then
				if var_54_12 < math.modf(200 / var_54_0) - var_54_1 then
					var_54_12 = var_54_12 + 1
				end
			else
				var_54_14 = var_54_14 + 1
			end
		elseif var_54_41 == VK_LEFT then
			if var_54_13 > 0 then
				var_54_13 = var_54_13 - 1
			else
				var_54_13 = var_54_0 - 1
			end
		elseif var_54_41 == VK_RIGHT then
			if var_54_13 == var_54_0 - 1 then
				var_54_13 = 0
			else
				var_54_13 = var_54_13 + 1
			end
		end
	end

	Cls()

	return var_54_15
end

function Game_SMap()
	DrawSMap()

	if CC.ShowXY == 1 then
		DrawString(10, CC.ScreenH - 50, string.format("%s %d %d", JY.Scene[JY.SubScene].名称, JY.Base.人X1, JY.Base.人Y1), C_GOLD, CC.FontSmall)
	end

	DrawTimer()
	JYZTB()

	if JY.SubScene == 133 then
		night()
	end

	ShowScreen()
	lib.SetClip(0, 0, 0, 0)

	local var_56_0 = GetS(JY.SubScene, JY.Base.人X1, JY.Base.人Y1, 3)

	if var_56_0 >= 0 then
		if var_56_0 ~= JY.OldDPass then
			EventExecute(var_56_0, 3)

			JY.OldDPass = var_56_0
			JY.oldSMapX = -1
			JY.oldSMapY = -1
			JY.D_Valid = nil
		end

		if JY.Status ~= GAME_SMAP then
			return
		else
			JY.OldDPass = -1
		end
	end

	local var_56_1 = 0

	if JY.Scene[JY.SubScene].出口X1 == JY.Base.人X1 and JY.Scene[JY.SubScene].出口Y1 == JY.Base.人Y1 or JY.Scene[JY.SubScene].出口X2 == JY.Base.人X1 and JY.Scene[JY.SubScene].出口Y2 == JY.Base.人Y1 or JY.Scene[JY.SubScene].出口X3 == JY.Base.人X1 and JY.Scene[JY.SubScene].出口Y3 == JY.Base.人Y1 then
		var_56_1 = 1
	end

	if var_56_1 == 1 then
		JY.Status = GAME_MMAP

		lib.PicInit()
		CleanMemory()

		JY.MmapMusic = JY.Scene[JY.SubScene].出门音乐

		if JY.MmapMusic < 0 then
			JY.MmapMusic = 501
		end

		Init_MMap()

		JY.SubScene = -1
		JY.oldSMapX = -1
		JY.oldSMapY = -1

		lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
		lib.GetKey()
		lib.ShowSlow(50, 0)

		return
	end

	if JY.Scene[JY.SubScene].跳转场景 >= 0 and JY.Base.人X1 == JY.Scene[JY.SubScene].跳转口X1 and JY.Base.人Y1 == JY.Scene[JY.SubScene].跳转口Y1 then
		local var_56_2 = JY.SubScene

		JY.SubScene = JY.Scene[JY.SubScene].跳转场景

		lib.ShowSlow(50, 1)

		if JY.Scene[var_56_2].外景入口X1 ~= 0 then
			JY.Base.人X1 = JY.Scene[JY.SubScene].入口X
			JY.Base.人Y1 = JY.Scene[JY.SubScene].入口Y
		else
			JY.Base.人X1 = JY.Scene[JY.SubScene].跳转口X2
			JY.Base.人Y1 = JY.Scene[JY.SubScene].跳转口Y2
		end

		Init_SMap(1)

		return
	end

	local var_56_3
	local var_56_4
	local var_56_5 = lib.GetKey()
	local var_56_6 = -1

	if var_56_5 ~= -1 then
		JY.Mytick = 0

		if var_56_5 == VK_ESCAPE then
			ShowScreen()
			lib.SetClip(0, 0, 0, 0)
			MMenu()
		elseif var_56_5 == VK_UP then
			var_56_6 = 0
		elseif var_56_5 == VK_DOWN then
			var_56_6 = 3
		elseif var_56_5 == VK_LEFT then
			var_56_6 = 2
		elseif var_56_5 == VK_RIGHT then
			var_56_6 = 1
		elseif var_56_5 == VK_SPACE or var_56_5 == VK_RETURN then
			if JY.Base.人方向 >= 0 then
				local var_56_7 = GetS(JY.SubScene, JY.Base.人X1 + CC.DirectX[JY.Base.人方向 + 1], JY.Base.人Y1 + CC.DirectY[JY.Base.人方向 + 1], 3)

				if var_56_7 >= 0 then
					EventExecute(var_56_7, 1)
				end
			end
		elseif var_56_5 == VK_H then
			return
		elseif var_56_5 == VK_K then
			Menu_FullScreen()

			return
		elseif var_56_5 == VK_Q then
			DrawStrBox(-1, -1, "自动存档中，请稍后...", C_WHITE, CC.DefaultFont)
			ShowScreen()

			JY.Base.存档标识 = -1

			SaveRecord(10)
		elseif var_56_5 == VK_S then
			if JY.SubScene ~= 42 and JY.SubScene ~= 82 and JY.SubScene ~= 13 then
				DrawStrBox(-1, -1, "存档中，请稍后...", C_WHITE, CC.DefaultFont)
				ShowScreen()

				JY.Base.存档标识 = -1

				SaveRecord(1)
				DrawStrBoxWaitKey("存档完毕", C_WHITE, CC.DefaultFont)
			else
				DrawStrBoxWaitKey("特殊场景，禁止存档", C_WHITE, CC.DefaultFont)
			end
		end
	end

	if JY.Status ~= GAME_SMAP then
		return
	end

	if var_56_6 ~= -1 then
		AddMyCurrentPic()

		var_56_3 = JY.Base.人X1 + CC.DirectX[var_56_6 + 1]
		var_56_4 = JY.Base.人Y1 + CC.DirectY[var_56_6 + 1]
		JY.Base.人方向 = var_56_6
	else
		var_56_3 = JY.Base.人X1
		var_56_4 = JY.Base.人Y1
	end

	JY.MyPic = GetMyPic()

	DtoSMap()

	if SceneCanPass(var_56_3, var_56_4) == true then
		JY.Base.人X1 = var_56_3
		JY.Base.人Y1 = var_56_4
	end

	JY.Base.人X1 = limitX(JY.Base.人X1, 1, CC.SWidth - 2)
	JY.Base.人Y1 = limitX(JY.Base.人Y1, 1, CC.SHeight - 2)

	NEvent(var_56_5)
end

function SceneCanPass(arg_57_0, arg_57_1)
	local var_57_0 = true

	if GetS(JY.SubScene, arg_57_0, arg_57_1, 1) > 0 then
		var_57_0 = false
	end

	local var_57_1 = GetS(JY.SubScene, arg_57_0, arg_57_1, 3)

	if var_57_1 >= 0 and GetD(JY.SubScene, var_57_1, 0) ~= 0 then
		var_57_0 = false
	end

	if CC.SceneWater[GetS(JY.SubScene, arg_57_0, arg_57_1, 0)] ~= nil then
		var_57_0 = false
	end

	return var_57_0
end

function DtoSMap()
	for iter_58_0 = 0, CC.DNum - 1 do
		local var_58_0 = GetD(JY.SubScene, iter_58_0, 9)
		local var_58_1 = GetD(JY.SubScene, iter_58_0, 10)

		if var_58_0 > 0 and var_58_1 > 0 then
			SetS(JY.SubScene, var_58_0, var_58_1, 3, iter_58_0)

			local var_58_2 = GetD(JY.SubScene, iter_58_0, 5)

			if var_58_2 >= 0 then
				local var_58_3 = GetD(JY.SubScene, iter_58_0, 6)
				local var_58_4 = GetD(JY.SubScene, iter_58_0, 7)
				local var_58_5 = GetD(JY.SubScene, iter_58_0, 8)

				if var_58_4 <= var_58_2 then
					if var_58_5 < JY.Mytick % 100 then
						var_58_4 = var_58_4 + 1
					end
				elseif JY.Mytick % 4 == 0 then
					var_58_4 = var_58_4 + 1
				end

				if var_58_3 < var_58_4 then
					var_58_4 = var_58_2
				end

				SetD(JY.SubScene, iter_58_0, 7, var_58_4)
			end
		end
	end
end

function DrawSMap()
	local var_59_0 = JY.SubSceneX + JY.Base.人X1 - 1
	local var_59_1 = JY.SubSceneY + JY.Base.人Y1 - 1
	local var_59_2 = limitX(var_59_0, 12, 45) - JY.Base.人X1
	local var_59_3 = limitX(var_59_1, 12, 45) - JY.Base.人Y1

	lib.DrawSMap(JY.SubScene, JY.Base.人X1, JY.Base.人Y1, var_59_2, var_59_3, JY.MyPic)
end

function LoadRecord(arg_60_0)
	if arg_60_0 ~= 0 and (existFile(string.format(CC.R_GRP, arg_60_0)) == false or existFile(string.format(CC.S_GRP, arg_60_0)) == false or existFile(string.format(CC.D_GRP, arg_60_0)) == false) then
		QZXS("此存档数据不全，不能读取。请选择其它存档或重新开始")

		return -1
	end

	if arg_60_0 ~= 0 then
		local var_60_0 = leijia(arg_60_0)
		local var_60_1 = byte10(var_60_0)
		local var_60_2 = read_files(string.format(CC.D_GRP, arg_60_0), 602800 + 12 * arg_60_0, 12)
		local var_60_3 = byte10(var_60_2)

		hzbj(var_60_1, var_60_3)
	end

	local var_60_4 = read_files(string.format(CC.CircleFile, arg_60_0), 2200 + 2 * arg_60_0, 2)
	local var_60_5 = tonumber(var_60_4)

	if var_60_5 ~= nil then
		CC.Frame = var_60_5
	else
		CC.Frame = 30
	end

	local var_60_6 = lib.GetTime()
	local var_60_7 = Byte.create(24)

	Byte.loadfile(var_60_7, CC.R_IDXFilename[0], 0, 24)

	local var_60_8 = {}

	var_60_8[0] = 0

	for iter_60_0 = 1, 6 do
		var_60_8[iter_60_0] = Byte.get32(var_60_7, 4 * (iter_60_0 - 1))
	end

	local var_60_9 = string.format(CC.R_GRP, arg_60_0)
	local var_60_10 = string.format(CC.S_GRP, arg_60_0)
	local var_60_11 = string.format(CC.D_GRP, arg_60_0)

	if arg_60_0 == 0 then
		var_60_9 = CC.R_GRPFilename[arg_60_0]
		var_60_10 = CC.S_Filename[arg_60_0]
		var_60_11 = CC.D_Filename[arg_60_0]
	end

	JY.Data_Base = Byte.create(var_60_8[1] - var_60_8[0])

	Byte.loadfile(JY.Data_Base, var_60_9, var_60_8[0], var_60_8[1] - var_60_8[0])

	local var_60_12 = {
		__index = function (arg_61_0, arg_61_1)
			return GetDataFromStruct(JY.Data_Base, 0, CC.Base_S, arg_61_1)
		end,
		__newindex = function (arg_62_0, arg_62_1, arg_62_2)
			SetDataFromStruct(JY.Data_Base, 0, CC.Base_S, arg_62_1, arg_62_2)
		end
	}

	setmetatable(JY.Base, var_60_12)

	JY.PersonNum = math.floor((var_60_8[2] - var_60_8[1]) / CC.PersonSize)
	JY.Data_Person = Byte.create(CC.PersonSize * JY.PersonNum)

	Byte.loadfile(JY.Data_Person, var_60_9, var_60_8[1], CC.PersonSize * JY.PersonNum)

	for iter_60_1 = 0, JY.PersonNum - 1 do
		JY.Person[iter_60_1] = {}

		local var_60_13 = {
			__index = function (arg_63_0, arg_63_1)
				return GetDataFromStruct(JY.Data_Person, iter_60_1 * CC.PersonSize, CC.Person_S, arg_63_1)
			end,
			__newindex = function (arg_64_0, arg_64_1, arg_64_2)
				SetDataFromStruct(JY.Data_Person, iter_60_1 * CC.PersonSize, CC.Person_S, arg_64_1, arg_64_2)
			end
		}

		setmetatable(JY.Person[iter_60_1], var_60_13)
	end

	JY.ThingNum = math.floor((var_60_8[3] - var_60_8[2]) / CC.ThingSize)
	JY.Data_Thing = Byte.create(CC.ThingSize * JY.ThingNum)

	Byte.loadfile(JY.Data_Thing, var_60_9, var_60_8[2], CC.ThingSize * JY.ThingNum)

	for iter_60_2 = 0, JY.ThingNum - 1 do
		JY.Thing[iter_60_2] = {}

		local var_60_14 = {
			__index = function (arg_65_0, arg_65_1)
				return GetDataFromStruct(JY.Data_Thing, iter_60_2 * CC.ThingSize, CC.Thing_S, arg_65_1)
			end,
			__newindex = function (arg_66_0, arg_66_1, arg_66_2)
				SetDataFromStruct(JY.Data_Thing, iter_60_2 * CC.ThingSize, CC.Thing_S, arg_66_1, arg_66_2)
			end
		}

		setmetatable(JY.Thing[iter_60_2], var_60_14)
	end

	JY.SceneNum = math.floor((var_60_8[4] - var_60_8[3]) / CC.SceneSize)
	JY.Data_Scene = Byte.create(CC.SceneSize * JY.SceneNum)

	Byte.loadfile(JY.Data_Scene, var_60_9, var_60_8[3], CC.SceneSize * JY.SceneNum)

	for iter_60_3 = 0, JY.SceneNum - 1 do
		JY.Scene[iter_60_3] = {}

		local var_60_15 = {
			__index = function (arg_67_0, arg_67_1)
				return GetDataFromStruct(JY.Data_Scene, iter_60_3 * CC.SceneSize, CC.Scene_S, arg_67_1)
			end,
			__newindex = function (arg_68_0, arg_68_1, arg_68_2)
				SetDataFromStruct(JY.Data_Scene, iter_60_3 * CC.SceneSize, CC.Scene_S, arg_68_1, arg_68_2)
			end
		}

		setmetatable(JY.Scene[iter_60_3], var_60_15)
	end

	JY.WugongNum = math.floor((var_60_8[5] - var_60_8[4]) / CC.WugongSize)
	JY.Data_Wugong = Byte.create(CC.WugongSize * JY.WugongNum)

	Byte.loadfile(JY.Data_Wugong, var_60_9, var_60_8[4], CC.WugongSize * JY.WugongNum)

	for iter_60_4 = 0, JY.WugongNum - 1 do
		JY.Wugong[iter_60_4] = {}

		local var_60_16 = {
			__index = function (arg_69_0, arg_69_1)
				return GetDataFromStruct(JY.Data_Wugong, iter_60_4 * CC.WugongSize, CC.Wugong_S, arg_69_1)
			end,
			__newindex = function (arg_70_0, arg_70_1, arg_70_2)
				SetDataFromStruct(JY.Data_Wugong, iter_60_4 * CC.WugongSize, CC.Wugong_S, arg_70_1, arg_70_2)
			end
		}

		setmetatable(JY.Wugong[iter_60_4], var_60_16)
	end

	JY.ShopNum = math.floor((var_60_8[6] - var_60_8[5]) / CC.ShopSize)
	JY.Data_Shop = Byte.create(CC.ShopSize * JY.ShopNum)

	Byte.loadfile(JY.Data_Shop, var_60_9, var_60_8[5], CC.ShopSize * JY.ShopNum)

	for iter_60_5 = 0, JY.ShopNum - 1 do
		JY.Shop[iter_60_5] = {}

		local var_60_17 = {
			__index = function (arg_71_0, arg_71_1)
				return GetDataFromStruct(JY.Data_Shop, iter_60_5 * CC.ShopSize, CC.Shop_S, arg_71_1)
			end,
			__newindex = function (arg_72_0, arg_72_1, arg_72_2)
				SetDataFromStruct(JY.Data_Shop, iter_60_5 * CC.ShopSize, CC.Shop_S, arg_72_1, arg_72_2)
			end
		}

		setmetatable(JY.Shop[iter_60_5], var_60_17)
	end

	lib.LoadSMap(var_60_10, CC.TempS_Filename, JY.SceneNum, CC.SWidth, CC.SHeight, var_60_11, CC.DNum, 11)
	collectgarbage()
	lib.Debug(string.format("Loadrecord time=%d", lib.GetTime() - var_60_6))

	JY.LOADTIME = lib.GetTime()
	JY.YEAR = GetS(14, 2, 1, 1)
	JY.MONTH = GetS(14, 2, 1, 2)
	JY.DAY = GetS(14, 2, 1, 3)
	JY.TL = GetS(14, 2, 1, 0)
	JY.TERM = GetS(14, 2, 1, 4)

	if JY.TL < 0 then
		JY.TL = 100
	end

	if JY.YEAR < 1 then
		JY.YEAR = 1
	end

	if JY.MONTH < 1 then
		JY.MONTH = 1
	end

	if JY.DAY < 1 then
		JY.DAY = 1
	end

	for iter_60_6 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_60_6] < 0 then
			break
		end

		if JY.Base["物品" .. iter_60_6] == 174 then
			JY.GOLD = JY.Base["物品数量" .. iter_60_6]

			break
		end
	end

	FINALWORK2()

	if existFile(CC.CircleFile) then
		local var_60_18 = io.open(CC.CircleFile, "rb")
		local var_60_19 = ""

		CC.CircleNum = 1

		while true do
			local var_60_20 = var_60_18:read(2)

			if not var_60_20 then
				break
			end

			if var_60_20 ~= "0A" then
				var_60_19 = var_60_19 .. var_60_20
			else
				if #var_60_19 > 0 then
					CC.CircleNum = CC.CircleNum + 1
				end

				var_60_19 = ""
			end
		end

		var_60_18:close()
	end

	if arg_60_0 == 0 then
		SetS(53, 0, 1, 5, CC.CircleNum)
	end
end

function SaveRecord(arg_73_0)
	if JY.Status == GAME_SMAP then
		JY.Base.存档标识 = JY.SubScene
	else
		JY.Base.存档标识 = -1
	end

	SetS(14, 2, 1, 1, JY.YEAR)
	SetS(14, 2, 1, 2, JY.MONTH)
	SetS(14, 2, 1, 3, JY.DAY)
	SetS(14, 2, 1, 4, JY.TERM)
	SetS(14, 2, 1, 0, JY.TL)

	local var_73_0 = lib.GetTime()

	JY.SAVETIME = lib.GetTime()
	JY.GTIME = math.modf((JY.SAVETIME - JY.LOADTIME) / 60000)

	SetS(14, 2, 1, 4, GetS(14, 2, 1, 4) + JY.GTIME)

	JY.LOADTIME = lib.GetTime()

	local var_73_1 = Byte.create(24)

	Byte.loadfile(var_73_1, CC.R_IDXFilename[0], 0, 24)

	local var_73_2 = {}

	var_73_2[0] = 0

	for iter_73_0 = 1, 6 do
		var_73_2[iter_73_0] = Byte.get32(var_73_1, 4 * (iter_73_0 - 1))
	end

	os.remove(string.format(CC.R_GRP, arg_73_0))
	Byte.savefile(JY.Data_Base, string.format(CC.R_GRP, arg_73_0), var_73_2[0], var_73_2[1] - var_73_2[0])
	Byte.savefile(JY.Data_Person, string.format(CC.R_GRP, arg_73_0), var_73_2[1], CC.PersonSize * JY.PersonNum)
	Byte.savefile(JY.Data_Thing, string.format(CC.R_GRP, arg_73_0), var_73_2[2], CC.ThingSize * JY.ThingNum)
	Byte.savefile(JY.Data_Scene, string.format(CC.R_GRP, arg_73_0), var_73_2[3], CC.SceneSize * JY.SceneNum)
	Byte.savefile(JY.Data_Wugong, string.format(CC.R_GRP, arg_73_0), var_73_2[4], CC.WugongSize * JY.WugongNum)
	Byte.savefile(JY.Data_Shop, string.format(CC.R_GRP, arg_73_0), var_73_2[5], CC.ShopSize * JY.ShopNum)
	lib.SaveSMap(string.format(CC.S_GRP, arg_73_0), string.format(CC.D_GRP, arg_73_0))
	lib.Debug(string.format("SaveRecord time=%d", lib.GetTime() - var_73_0))

	local var_73_3 = os.date("%Y-%m-%d %H:%M:%S")
	local var_73_4 = "'" .. var_73_3 .. "'"

	write_content(string.format(CC.CircleFile, arg_73_0), 2000 + 20 * arg_73_0, var_73_4)

	local var_73_5 = CC.Frame

	write_content(string.format(CC.CircleFile, arg_73_0), 2200 + 2 * arg_73_0, var_73_5)
	write_content(string.format(CC.D_GRP, arg_73_0), 602800 + 12 * arg_73_0, leijia(arg_73_0))
end

function write_content(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = io.open(arg_74_0, "r+")
	local var_74_1 = var_74_0:seek("set", arg_74_1)

	var_74_0:write(arg_74_2)
	var_74_0:close()
end

function write_content1(arg_75_0, arg_75_1)
	local var_75_0 = assert(io.open(arg_75_0, "a"))

	var_75_0:write(arg_75_1)
	var_75_0:close()
end

function read_files(arg_76_0, arg_76_1, arg_76_2)
	local var_76_0 = io.input(arg_76_0)

	var_76_0:seek("set", arg_76_1)

	local var_76_1 = var_76_0:read(arg_76_2)

	var_76_0:close()

	return var_76_1
end

function read_string(arg_77_0, arg_77_1, arg_77_2)
	return (string.sub(arg_77_0, arg_77_1, arg_77_2))
end

function read_nump(arg_78_0)
	local var_78_0 = JY.Base.瓶颈标记

	return (tonumber(read_string(var_78_0, arg_78_0, arg_78_0)))
end

function change_nump(arg_79_0, arg_79_1)
	local var_79_0 = {}
	local var_79_1 = ""

	for iter_79_0 = 1, 6 do
		var_79_0[iter_79_0] = read_nump(iter_79_0)
	end

	var_79_0[arg_79_0] = arg_79_1

	for iter_79_1 = 1, 6 do
		local var_79_2 = var_79_0[iter_79_1]

		var_79_1 = var_79_1 .. var_79_2
	end

	return var_79_1
end

function write_nump(arg_80_0, arg_80_1)
	local var_80_0 = change_nump(arg_80_0, arg_80_1)

	JY.Base.瓶颈标记 = var_80_0
end

function read_files1(arg_81_0)
	local var_81_0 = assert(io.open(arg_81_0, "rb"))
	local var_81_1 = var_81_0:read("*all")

	var_81_0:close()

	return var_81_1
end

function writefile(arg_82_0, arg_82_1, arg_82_2)
	arg_82_2 = arg_82_2 or "w+b"

	local var_82_0 = io.open(arg_82_0, arg_82_2)

	if var_82_0 then
		if var_82_0:write(arg_82_1) == nil then
			return false
		end

		io.close(var_82_0)

		return true
	else
		return false
	end
end

function encrypt(arg_83_0)
	local var_83_0 = loadstring("return function() return loadstring([[" .. arg_83_0 .. "]])() end")()
	local var_83_1 = string.dump(var_83_0)
	local var_83_2 = "return {"
	local var_83_3 = 1

	while var_83_3 <= #var_83_1 do
		var_83_2 = var_83_2 .. string.byte(var_83_1, var_83_3) + 256 .. ","
		var_83_3 = var_83_3 + 1
	end

	return var_83_2 .. "nil}"
end

function decryptAndExecute(arg_84_0)
	local var_84_0 = loadstring(arg_84_0)()
	local var_84_1 = ""

	for iter_84_0, iter_84_1 in ipairs(var_84_0) do
		var_84_1 = var_84_1 .. string.char(iter_84_1 - 256)
	end

	return loadstring(var_84_1)()
end

function filelength(arg_85_0)
	local var_85_0 = io.open(arg_85_0, "rb")
	local var_85_1 = var_85_0:seek("end")

	var_85_0:close()

	return var_85_1
end

function GetS(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	return lib.GetS(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
end

function SetS(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	lib.SetS(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
end

function GetD(arg_88_0, arg_88_1, arg_88_2)
	return lib.GetD(arg_88_0, arg_88_1, arg_88_2)
end

function SetD(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	lib.SetD(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
end

function GetDataFromStruct(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = arg_90_2[arg_90_3]
	local var_90_1

	if var_90_0[2] == 0 then
		var_90_1 = Byte.get16(arg_90_0, var_90_0[1] + arg_90_1)
	elseif var_90_0[2] == 1 then
		var_90_1 = Byte.getu16(arg_90_0, var_90_0[1] + arg_90_1)
	elseif var_90_0[2] == 2 then
		if CC.SrcCharSet == 0 then
			var_90_1 = lib.CharSet(Byte.getstr(arg_90_0, var_90_0[1] + arg_90_1, var_90_0[3]), 0)
		else
			var_90_1 = Byte.getstr(arg_90_0, var_90_0[1] + arg_90_1, var_90_0[3])
		end
	end

	return var_90_1
end

function SetDataFromStruct(arg_91_0, arg_91_1, arg_91_2, arg_91_3, arg_91_4)
	local var_91_0 = arg_91_2[arg_91_3]

	if var_91_0[2] == 0 then
		Byte.set16(arg_91_0, var_91_0[1] + arg_91_1, arg_91_4)
	elseif var_91_0[2] == 1 then
		Byte.setu16(arg_91_0, var_91_0[1] + arg_91_1, arg_91_4)
	elseif var_91_0[2] == 2 then
		local var_91_1

		if CC.SrcCharSet == 0 then
			var_91_1 = lib.CharSet(arg_91_4, 1)
		else
			var_91_1 = arg_91_4
		end

		Byte.setstr(arg_91_0, var_91_0[1] + arg_91_1, var_91_0[3], var_91_1)
	end
end

function LoadData(arg_92_0, arg_92_1, arg_92_2)
	for iter_92_0, iter_92_1 in pairs(arg_92_1) do
		if iter_92_1[2] == 0 then
			arg_92_0[iter_92_0] = Byte.get16(arg_92_2, iter_92_1[1])
		elseif iter_92_1[2] == 1 then
			arg_92_0[iter_92_0] = Byte.getu16(arg_92_2, iter_92_1[1])
		elseif iter_92_1[2] == 2 then
			if CC.SrcCharSet == 0 then
				arg_92_0[iter_92_0] = lib.CharSet(Byte.getstr(arg_92_2, iter_92_1[1], iter_92_1[3]), 0)
			else
				arg_92_0[iter_92_0] = Byte.getstr(arg_92_2, iter_92_1[1], iter_92_1[3])
			end
		end
	end
end

function SaveData(arg_93_0, arg_93_1, arg_93_2)
	for iter_93_0, iter_93_1 in pairs(arg_93_1) do
		if iter_93_1[2] == 0 then
			Byte.set16(arg_93_2, iter_93_1[1], arg_93_0[iter_93_0])
		elseif iter_93_1[2] == 1 then
			Byte.setu16(arg_93_2, iter_93_1[1], arg_93_0[iter_93_0])
		elseif iter_93_1[2] == 2 then
			local var_93_0

			if CC.SrcCharSet == 0 then
				var_93_0 = lib.CharSet(arg_93_0[iter_93_0], 1)
			else
				var_93_0 = arg_93_0[iter_93_0]
			end

			Byte.setstr(arg_93_2, iter_93_1[1], iter_93_1[3], var_93_0)
		end
	end
end

function byte10(arg_94_0)
	local var_94_0 = ""
	local var_94_1 = string.len(arg_94_0)

	for iter_94_0 = 1, var_94_1 do
		local var_94_2 = tonumber(string.byte(arg_94_0, iter_94_0, iter_94_0))

		var_94_0 = var_94_0 .. var_94_2
	end

	return var_94_0
end

function leijiahe(arg_95_0, arg_95_1)
	local var_95_0 = 0
	local var_95_1 = 0

	for iter_95_0 = 1, arg_95_1 do
		local var_95_2 = string.sub(arg_95_0, iter_95_0, iter_95_0)
		local var_95_3 = tonumber(var_95_2)

		if var_95_3 then
			var_95_2 = var_95_3
		else
			var_95_2 = 1
		end

		var_95_0 = var_95_0 + var_95_2
	end

	return var_95_0
end

function limitX(arg_96_0, arg_96_1, arg_96_2)
	if arg_96_0 < arg_96_1 then
		arg_96_0 = arg_96_1
	end

	if arg_96_2 < arg_96_0 then
		arg_96_0 = arg_96_2
	end

	return arg_96_0
end

function RGB(arg_97_0, arg_97_1, arg_97_2)
	return arg_97_0 * 65536 + arg_97_1 * 256 + arg_97_2
end

function GetRGB(arg_98_0)
	arg_98_0 = arg_98_0 % 16777216

	local var_98_0 = math.floor(arg_98_0 / 65536)

	arg_98_0 = arg_98_0 % 65536

	local var_98_1 = math.floor(arg_98_0 / 256)
	local var_98_2 = arg_98_0 % 256

	return var_98_0, var_98_1, var_98_2
end

function WaitKey()
	local var_99_0 = -1

	while true do
		var_99_0 = lib.GetKey()

		if var_99_0 ~= -1 then
			break
		end

		lib.Delay(CC.Frame / 2)
	end

	return var_99_0
end

function DrawBox(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = 4

	lib.Background(arg_100_0 + 4, arg_100_1, arg_100_2 - 4, arg_100_1 + var_100_0, 128)
	lib.Background(arg_100_0 + 1, arg_100_1 + 1, arg_100_0 + var_100_0, arg_100_1 + var_100_0, 128)
	lib.Background(arg_100_2 - var_100_0, arg_100_1 + 1, arg_100_2 - 1, arg_100_1 + var_100_0, 128)
	lib.Background(arg_100_0, arg_100_1 + 4, arg_100_2, arg_100_3 - 4, 128)
	lib.Background(arg_100_0 + 1, arg_100_3 - var_100_0, arg_100_0 + var_100_0, arg_100_3 - 1, 128)
	lib.Background(arg_100_2 - var_100_0, arg_100_3 - var_100_0 + 1, arg_100_2 - 1, arg_100_3, 128)
	lib.Background(arg_100_0 + 4, arg_100_3 - var_100_0, arg_100_2 - 4, arg_100_3, 128)

	local var_100_1, var_100_2, var_100_3 = GetRGB(arg_100_4)

	DrawBox_1(arg_100_0 + 1, arg_100_1 + 1, arg_100_2, arg_100_3, RGB(math.modf(var_100_1 / 2), math.modf(var_100_2 / 2), math.modf(var_100_3 / 2)))
	DrawBox_1(arg_100_0, arg_100_1, arg_100_2 - 1, arg_100_3 - 1, arg_100_4)
end

function DrawBox_1(arg_101_0, arg_101_1, arg_101_2, arg_101_3, arg_101_4)
	local var_101_0 = 4

	lib.DrawRect(arg_101_0 + var_101_0, arg_101_1, arg_101_2 - var_101_0, arg_101_1, arg_101_4)
	lib.DrawRect(arg_101_0 + var_101_0, arg_101_3, arg_101_2 - var_101_0, arg_101_3, arg_101_4)
	lib.DrawRect(arg_101_0, arg_101_1 + var_101_0, arg_101_0, arg_101_3 - var_101_0, arg_101_4)
	lib.DrawRect(arg_101_2, arg_101_1 + var_101_0, arg_101_2, arg_101_3 - var_101_0, arg_101_4)
	lib.DrawRect(arg_101_0 + 2, arg_101_1 + 1, arg_101_0 + var_101_0 - 1, arg_101_1 + 1, arg_101_4)
	lib.DrawRect(arg_101_0 + 1, arg_101_1 + 2, arg_101_0 + 1, arg_101_1 + var_101_0 - 1, arg_101_4)
	lib.DrawRect(arg_101_2 - var_101_0 + 1, arg_101_1 + 1, arg_101_2 - 2, arg_101_1 + 1, arg_101_4)
	lib.DrawRect(arg_101_2 - 1, arg_101_1 + 2, arg_101_2 - 1, arg_101_1 + var_101_0 - 1, arg_101_4)
	lib.DrawRect(arg_101_0 + 2, arg_101_3 - 1, arg_101_0 + var_101_0 - 1, arg_101_3 - 1, arg_101_4)
	lib.DrawRect(arg_101_0 + 1, arg_101_3 - var_101_0 + 1, arg_101_0 + 1, arg_101_3 - 2, arg_101_4)
	lib.DrawRect(arg_101_2 - var_101_0 + 1, arg_101_3 - 1, arg_101_2 - 2, arg_101_3 - 1, arg_101_4)
	lib.DrawRect(arg_101_2 - 1, arg_101_3 - var_101_0 + 1, arg_101_2 - 1, arg_101_3 - 2, arg_101_4)
end

function DrawString(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4)
	local var_102_0, var_102_1, var_102_2 = GetRGB(arg_102_3)

	lib.DrawStr(arg_102_0, arg_102_1, arg_102_2, arg_102_3, arg_102_4, CC.FontName, CC.SrcCharSet, CC.OSCharSet)
end

function DrawStrBox(arg_103_0, arg_103_1, arg_103_2, arg_103_3, arg_103_4)
	local var_103_0 = #arg_103_2
	local var_103_1 = arg_103_4 * var_103_0 / 2 + 2 * CC.MenuBorderPixel
	local var_103_2 = arg_103_4 + 2 * CC.MenuBorderPixel

	if arg_103_0 == -1 then
		arg_103_0 = (CC.ScreenW - arg_103_4 / 2 * var_103_0 - 2 * CC.MenuBorderPixel) / 2
	end

	if arg_103_1 == -1 then
		arg_103_1 = (CC.ScreenH - arg_103_4 - 2 * CC.MenuBorderPixel) / 2
	end

	DrawBox(arg_103_0, arg_103_1, arg_103_0 + var_103_1 - 1, arg_103_1 + var_103_2 - 1, C_WHITE)
	DrawString(arg_103_0 + CC.MenuBorderPixel, arg_103_1 + CC.MenuBorderPixel, arg_103_2, arg_103_3, arg_103_4)
end

function DrawStrBoxYesNo(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	lib.GetKey()

	local var_104_0 = #arg_104_2
	local var_104_1 = arg_104_4 * var_104_0 / 2 + 2 * CC.MenuBorderPixel
	local var_104_2 = arg_104_4 + 2 * CC.MenuBorderPixel

	if arg_104_0 == -1 then
		arg_104_0 = (CC.ScreenW - arg_104_4 / 2 * var_104_0 - 2 * CC.MenuBorderPixel) / 2
	end

	if arg_104_1 == -1 then
		arg_104_1 = (CC.ScreenH - arg_104_4 - 2 * CC.MenuBorderPixel) / 2
	end

	Cls()
	DrawStrBox(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)

	local var_104_3 = {
		{
			"确定/是",
			nil,
			1
		},
		{
			"取消/否",
			nil,
			2
		}
	}

	if ShowMenu(var_104_3, 2, 0, arg_104_0 + var_104_1 - 4 * arg_104_4 - 2 * CC.MenuBorderPixel, arg_104_1 + var_104_2 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE) == 1 then
		return true
	else
		return false
	end
end

function DrawStrBoxWaitKey(arg_105_0, arg_105_1, arg_105_2)
	lib.GetKey()
	Cls()
	DrawStrBox(-1, -1, arg_105_0, arg_105_1, arg_105_2)
	ShowScreen()
	WaitKey()
end

function Rnd(arg_106_0)
	return math.random(arg_106_0) - 1
end

function AddPersonAttrib(arg_107_0, arg_107_1, arg_107_2)
	local var_107_0 = JY.Person[arg_107_0][arg_107_1]
	local var_107_1 = math.huge

	if arg_107_1 == "生命" then
		var_107_1 = JY.Person[arg_107_0].生命最大值
	elseif arg_107_1 == "生命最大值" then
		var_107_1 = JY.Person[arg_107_0].生命增长 * 100 + Rnd(50)
	elseif arg_107_1 == "内力" then
		var_107_1 = JY.Person[arg_107_0].内力最大值
	elseif arg_107_1 == "内力最大值" then
		var_107_1 = JY.Person[arg_107_0].生命增长 * 1000 + Rnd(50)
	elseif CC.PersonAttribMax[arg_107_1] ~= nil then
		var_107_1 = CC.PersonAttribMax[arg_107_1]
	end

	if arg_107_1 == "内力最大值" then
		var_107_1 = JY.Person[arg_107_0].生命增长 * 1000 + Rnd(50)

		if T1LEQ(arg_107_0) or cxtd(arg_107_0, 53) or cxtd(arg_107_0, 38) or cxtd(arg_107_0, 116) then
			var_107_1 = 10000
		end

		for iter_107_0 = 1, CC.Kungfunum do
			if JY.Person[arg_107_0]["武功" .. iter_107_0] == 85 or JY.Person[arg_107_0]["武功" .. iter_107_0] == 88 then
				var_107_1 = var_107_1 + 750
			end

			for iter_107_1 = 1, CC.Kungfunum do
				if JY.Person[arg_107_0]["武功" .. iter_107_1] == 108 then
					var_107_1 = var_107_1 + 500
				end
			end
		end

		if cxtd(arg_107_0, 103) or cxtd(arg_107_0, 117) or cxtd(arg_107_0, 66) or cxtd(arg_107_0, 118) then
			var_107_1 = var_107_1 + 2500
		end

		if cxtd(arg_107_0, 58) then
			var_107_1 = var_107_1 - JY.Person[300].声望 * 100
		end

		if cxtd(arg_107_0, 5067) then
			var_107_1 = var_107_1 + 750
		end

		if cxtd(arg_107_0, 5068) then
			var_107_1 = var_107_1 + 1500
		end

		if var_107_1 < 500 then
			var_107_1 = 500
		end

		if var_107_1 > 10000 then
			var_107_1 = 10000
		end
	end

	if arg_107_1 == "用毒能力" and cxtd(arg_107_0, 2) then
		var_107_1 = 500
	end

	if arg_107_1 == "用毒能力" and arg_107_0 == 0 and JY.Base.主角职业 == 8 then
		var_107_1 = 500
	end

	if arg_107_1 == "用毒能力" and (cxtd(arg_107_0, 17) or cxtd(arg_107_0, 25) or cxtd(arg_107_0, 83) or cxtd(arg_107_0, 176)) then
		var_107_1 = 400
	end

	if arg_107_1 == "医疗能力" and (cxtd(arg_107_0, 16) or cxtd(arg_107_0, 28) or cxtd(arg_107_0, 45)) then
		var_107_1 = 500
	end

	if arg_107_1 == "医疗能力" and (cxtd(arg_107_0, 85) or cxtd(arg_107_0, 2)) then
		var_107_1 = 400
	end

	if arg_107_1 == "医疗能力" and arg_107_0 == JY.Base.队伍1 and JY.Base.主角职业 == 7 then
		var_107_1 = 400
	end

	if arg_107_1 == "医疗能力" and cxtd(arg_107_0, 5051) then
		var_107_1 = var_107_1 + 100
	end

	if arg_107_1 == "医疗能力" and cxtd(arg_107_0, 5052) then
		var_107_1 = var_107_1 + 200
	end

	if arg_107_1 == "用毒能力" and cxtd(arg_107_0, 5053) then
		var_107_1 = var_107_1 + 100
	end

	if arg_107_1 == "用毒能力" and cxtd(arg_107_0, 5054) then
		var_107_1 = var_107_1 + 200
	end

	local var_107_2 = limitX(var_107_0 + arg_107_2, 0, var_107_1)

	JY.Person[arg_107_0][arg_107_1] = var_107_2

	local var_107_3 = var_107_2 - var_107_0
	local var_107_4 = ""

	if var_107_3 > 0 then
		var_107_4 = string.format("%s 增加 %d", arg_107_1, var_107_3)
	elseif var_107_3 < 0 then
		var_107_4 = string.format("%s 减少 %d", arg_107_1, -var_107_3)
	end

	return var_107_3, var_107_4
end

function PlayMIDI(arg_108_0)
	JY.CurrentMIDI = arg_108_0

	if JY.EnableMusic == 0 then
		return
	end

	if arg_108_0 >= 0 then
		lib.PlayMIDI(string.format(CC.MIDIFile, arg_108_0))
	end
end

function PlayWavAtk(arg_109_0)
	if JY.EnableSound == 0 then
		return
	end

	if arg_109_0 >= 0 then
		lib.PlayWAV(string.format(CC.ATKFile, arg_109_0))
	end
end

function PlayWavE(arg_110_0)
	if JY.EnableSound == 0 then
		return
	end

	if arg_110_0 >= 0 then
		lib.PlayWAV(string.format(CC.EFile, arg_110_0))
	end
end

function ShowScreen(arg_111_0)
	if JY.Darkness == 0 then
		if arg_111_0 == nil then
			arg_111_0 = 0
		end

		lib.ShowSurface(arg_111_0)
	end
end

function ShowMenu(arg_112_0, arg_112_1, arg_112_2, arg_112_3, arg_112_4, arg_112_5, arg_112_6, arg_112_7, arg_112_8, arg_112_9, arg_112_10, arg_112_11)
	local var_112_0 = 0
	local var_112_1 = 0
	local var_112_2 = 0
	local var_112_3 = 0
	local var_112_4 = 0

	lib.GetKey()

	local var_112_5 = {}

	for iter_112_0 = 1, arg_112_1 do
		if arg_112_0[iter_112_0][3] > 0 then
			var_112_4 = var_112_4 + 1
			var_112_5[var_112_4] = {
				arg_112_0[iter_112_0][1],
				arg_112_0[iter_112_0][2],
				arg_112_0[iter_112_0][3],
				iter_112_0
			}
		end
	end

	if var_112_4 == 0 then
		return 0
	end

	if arg_112_2 == 0 or var_112_4 < arg_112_2 then
		var_112_3 = var_112_4
	else
		var_112_3 = arg_112_2
	end

	local var_112_6 = 0

	if arg_112_5 == 0 and arg_112_6 == 0 then
		for iter_112_1 = 1, var_112_4 do
			if var_112_6 < string.len(var_112_5[iter_112_1][1]) then
				var_112_6 = string.len(var_112_5[iter_112_1][1])
			end
		end

		var_112_0 = arg_112_9 * var_112_6 / 2 + 2 * CC.MenuBorderPixel
		var_112_1 = (arg_112_9 + CC.RowPixel) * var_112_3 + CC.MenuBorderPixel
	else
		var_112_0 = arg_112_5 - arg_112_3
		var_112_1 = arg_112_6 - arg_112_4
	end

	local var_112_7 = 1
	local var_112_8 = 1

	for iter_112_2 = 1, var_112_4 do
		if var_112_5[iter_112_2][3] == 2 then
			var_112_8 = iter_112_2
		end
	end

	if arg_112_2 ~= 0 then
		var_112_8 = 1
	end

	local var_112_9 = false

	if JY.Status == GAME_WMAP and arg_112_1 >= 15 and arg_112_0[15][1] == "自动" then
		var_112_9 = true
	end

	if var_112_9 == true then
		var_112_0 = var_112_0 + 15
	end

	local var_112_10 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	local var_112_11 = 0

	if arg_112_7 == 1 then
		DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
	end

	while true do
		if JY.Restart == 1 then
			break
		end

		if var_112_3 ~= 0 then
			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		end

		for iter_112_3 = var_112_7, var_112_7 + var_112_3 - 1 do
			local var_112_12 = arg_112_10

			if iter_112_3 == var_112_8 then
				var_112_12 = arg_112_11

				lib.Background(arg_112_3 + CC.MenuBorderPixel, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel), arg_112_3 - CC.MenuBorderPixel + var_112_0, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + arg_112_9, 128, arg_112_10)
			end

			DrawString(arg_112_3 + CC.MenuBorderPixel, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel), var_112_5[iter_112_3][1], var_112_12, arg_112_9)

			if var_112_9 == true then
				if var_112_5[iter_112_3][1] == "攻击" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "A", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "运功" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "G", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "蓄力" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "P", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "防御" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "D", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "等待" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "W", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "用毒" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "V", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "解毒" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "Q", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "医疗" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "F", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "物品" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "E", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "状态" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "Z", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][1] == "休息" then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "R", LimeGreen, CC.FontSmall)
				elseif var_112_5[iter_112_3][2] == War_TgrtsMenu then
					DrawString(arg_112_3 + CC.MenuBorderPixel + arg_112_9 * 2, arg_112_4 + CC.MenuBorderPixel + (iter_112_3 - var_112_7) * (arg_112_9 + CC.RowPixel) + 2, "T", LimeGreen, CC.FontSmall)
				end
			end
		end

		ShowScreen()

		local var_112_13, var_112_14, var_112_15, var_112_16 = WaitKey(1)

		lib.Delay(CC.Frame)

		if var_112_13 == VK_ESCAPE or var_112_14 == 4 then
			if arg_112_8 == 1 then
				break
			end
		elseif var_112_13 == VK_DOWN or var_112_14 == 7 then
			var_112_8 = var_112_8 + 1

			if var_112_8 > var_112_7 + var_112_3 - 1 then
				var_112_7 = var_112_7 + 1
			end

			if var_112_4 < var_112_8 then
				var_112_7 = 1
				var_112_8 = 1
			end
		elseif var_112_13 == VK_UP or var_112_14 == 6 then
			var_112_8 = var_112_8 - 1

			if var_112_8 < var_112_7 then
				var_112_7 = var_112_7 - 1
			end

			if var_112_8 < 1 then
				var_112_8 = var_112_4
				var_112_7 = var_112_8 - var_112_3 + 1
			end
		elseif var_112_13 == VK_RIGHT then
			var_112_8 = var_112_8 + 10

			if var_112_8 > var_112_7 + var_112_3 - 1 then
				var_112_7 = var_112_7 + 10
			end

			if var_112_4 < var_112_8 + var_112_7 then
				var_112_8 = var_112_4
				var_112_7 = var_112_8 - var_112_3 + 1
			end
		elseif var_112_13 == VK_LEFT then
			var_112_8 = var_112_8 - 10

			if var_112_8 < var_112_7 then
				var_112_7 = var_112_7 - 10
			end

			if var_112_8 < 1 then
				var_112_7 = 1
				var_112_8 = 1
			elseif var_112_8 < var_112_3 then
				var_112_7 = 1
			end
		elseif var_112_9 == true and var_112_13 == VK_A and arg_112_0[2][3] == 1 then
			if War_FightMenu() == 1 then
				var_112_11 = -2

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 >= 49 and var_112_13 <= 57 and arg_112_0[2][3] == 1 then
			if War_FightMenu(nil, nil, var_112_13 - 48) == 1 then
				var_112_11 = -2

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_D then
			if War_DefupMenu() == 1 then
				var_112_11 = -4

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_P then
			if War_ActupMenu() == 1 then
				var_112_11 = -4

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_W then
			if War_WaitMenu() == 1 then
				var_112_11 = -4

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_G then
			local var_112_17 = War_YunGongMenu()

			if var_112_17 == 20 then
				var_112_11 = 20

				break
			elseif var_112_17 == 10 then
				var_112_11 = 10

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_V and arg_112_0[7][3] == 1 then
			if War_PoisonMenu() == 1 then
				var_112_11 = -5

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_Q and arg_112_0[8][3] == 1 then
			if War_DecPoisonMenu() == 1 then
				var_112_11 = -6

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_F and arg_112_0[9][3] == 1 then
			if War_DoctorMenu() == 1 then
				var_112_11 = -7

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_E and arg_112_0[12][3] == 1 then
			if War_ThingMenu() == 1 then
				var_112_11 = -8

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_Z then
			if War_StatusMenu() == 1 then
				var_112_11 = -9

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_R then
			if War_RestMenu() == 1 then
				var_112_11 = -10

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		elseif var_112_9 == true and var_112_13 == VK_T and arg_112_0[11][3] == 1 then
			if War_TgrtsMenu() == 1 then
				var_112_11 = -11

				break
			end

			ClsN()
			lib.LoadSur(var_112_10, 0, 0)

			if arg_112_7 == 1 then
				DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
			end
		else
			local var_112_18 = false

			if (var_112_14 == 2 or var_112_14 == 3) and arg_112_3 <= var_112_15 and var_112_15 <= arg_112_3 + var_112_0 and arg_112_4 <= var_112_16 and var_112_16 <= arg_112_4 + var_112_1 then
				var_112_8 = var_112_7 + math.modf((var_112_16 - arg_112_4 - CC.MenuBorderPixel) / (arg_112_9 + CC.RowPixel))
				var_112_18 = true
			end

			if var_112_13 == VK_SPACE or var_112_13 == VK_RETURN or var_112_14 == 5 or var_112_14 == 3 and var_112_18 then
				if var_112_5[var_112_8][2] == nil then
					var_112_11 = var_112_5[var_112_8][4]

					break
				elseif var_112_5[var_112_8][2] == SelectNeiGongMenu then
					local var_112_19 = WAR.Person[WAR.CurID].人物编号
					local var_112_20 = var_112_5[var_112_8][2](var_112_5, var_112_8)

					if JY.Person[var_112_19].内力 < 500 then
						DrawStrBoxWaitKey("内力不足，无法运功", C_RED, CC.DefaultFont, nil, LimeGreen)
					elseif JY.Person[var_112_19].体力 < 20 then
						DrawStrBoxWaitKey("体力不足，无法运功", C_RED, CC.DefaultFont, nil, LimeGreen)
					else
						if var_112_20 == 20 then
							var_112_11 = 20

							break
						end

						ClsN()
						lib.LoadSur(var_112_10, 0, 0)

						if arg_112_7 == 1 then
							DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
						end
					end
				elseif var_112_5[var_112_8][2] == SelectQingGongMenu then
					local var_112_21 = WAR.Person[WAR.CurID].人物编号

					if JY.Person[var_112_21].体力 < 20 then
						DrawStrBoxWaitKey("体力不足，无法运功", M_DeepSkyBlue, CC.DefaultFont, nil, LimeGreen)
					else
						if var_112_5[var_112_8][2](var_112_5, var_112_8) == 10 then
							var_112_11 = 10

							break
						end

						ClsN()
						lib.LoadSur(var_112_10, 0, 0)

						if arg_112_7 == 1 then
							DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
						end
					end
				else
					local var_112_22 = var_112_5[var_112_8][2](var_112_5, var_112_8)

					if var_112_22 == 1 then
						var_112_11 = -var_112_5[var_112_8][4]

						break
					elseif var_112_9 == true and var_112_22 == 20 then
						var_112_11 = 20

						break
					elseif var_112_9 == true and var_112_22 == 10 then
						var_112_11 = 10

						break
					end

					ClsN()
					lib.LoadSur(var_112_10, 0, 0)

					if arg_112_7 == 1 then
						DrawBox(arg_112_3, arg_112_4, arg_112_3 + var_112_0, arg_112_4 + var_112_1, C_WHITE)
					end
				end
			end
		end
	end

	lib.FreeSur(var_112_10)

	return var_112_11
end

function ShowMenu2(arg_113_0, arg_113_1, arg_113_2, arg_113_3, arg_113_4, arg_113_5, arg_113_6, arg_113_7, arg_113_8, arg_113_9, arg_113_10, arg_113_11, arg_113_12, arg_113_13)
	local var_113_0 = 0
	local var_113_1 = 0
	local var_113_2 = 0
	local var_113_3 = 0
	local var_113_4 = 0
	local var_113_5 = 0

	lib.GetKey()
	Cls()

	local var_113_6 = {}
	local var_113_7 = 0

	for iter_113_0, iter_113_1 in pairs(arg_113_0) do
		if iter_113_1[3] ~= 2 then
			var_113_7 = var_113_7 + 1
			var_113_6[var_113_7] = {
				iter_113_1[1],
				iter_113_1[2],
				iter_113_1[3],
				iter_113_0
			}
		end
	end

	local var_113_8

	if arg_113_2 == 0 or var_113_7 < arg_113_2 then
		var_113_4 = var_113_7
		var_113_8 = 1
	else
		var_113_4 = arg_113_2
		var_113_8 = math.modf((var_113_7 - 1) / var_113_4)
	end

	if arg_113_3 > var_113_8 + 1 then
		arg_113_3 = var_113_8 + 1
	end

	local var_113_9 = 0

	if arg_113_6 == 0 and arg_113_7 == 0 then
		for iter_113_2 = 1, var_113_7 do
			if var_113_9 < string.len(var_113_6[iter_113_2][1]) then
				var_113_9 = string.len(var_113_6[iter_113_2][1])
			end
		end

		var_113_0 = (arg_113_10 * var_113_9 / 2 + CC.RowPixel) * var_113_4 + 2 * CC.MenuBorderPixel
		var_113_1 = arg_113_3 * (arg_113_10 + CC.RowPixel) + 2 * CC.MenuBorderPixel
	else
		var_113_0 = arg_113_6 - arg_113_4
		var_113_1 = arg_113_7 - arg_113_5
	end

	if arg_113_4 == -1 then
		arg_113_4 = (CC.ScreenW - var_113_0) / 2
	end

	if arg_113_5 == -1 then
		arg_113_5 = (CC.ScreenH - var_113_1 + arg_113_10) / 2
	end

	local var_113_10 = 0
	local var_113_11 = 1
	local var_113_12 = 0
	local var_113_13 = var_113_11 + var_113_12 * arg_113_3
	local var_113_14 = -1
	local var_113_15 = 0

	if arg_113_13 ~= nil then
		DrawStrBox(-1, arg_113_5 - arg_113_10 - CC.RowPixel, arg_113_13, arg_113_11, arg_113_10)
	end

	local var_113_16 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)

	if arg_113_8 == 1 then
		DrawBox(arg_113_4, arg_113_5, arg_113_4 + var_113_0, arg_113_5 + var_113_1, C_WHITE)
	end

	while true do
		if var_113_4 ~= 0 then
			lib.LoadSur(var_113_16, 0, 0)

			if arg_113_8 == 1 then
				DrawBox(arg_113_4, arg_113_5, arg_113_4 + var_113_0, arg_113_5 + var_113_1, C_WHITE)
			end
		end

		for iter_113_3 = var_113_10, arg_113_3 + var_113_10 - 1 do
			for iter_113_4 = 1, var_113_4 do
				local var_113_17 = iter_113_3 * var_113_4 + iter_113_4

				if var_113_7 < var_113_17 then
					break
				end

				local var_113_18 = arg_113_11

				if var_113_6[var_113_17][3] == 0 or var_113_6[var_113_17][3] == 3 then
					var_113_18 = M_DimGray
				end

				local var_113_19 = arg_113_4 + (iter_113_4 - 1) * (arg_113_10 * var_113_9 / 2 + CC.RowPixel) + CC.MenuBorderPixel
				local var_113_20 = arg_113_5 + (iter_113_3 - var_113_10) * (arg_113_10 + CC.RowPixel) + CC.MenuBorderPixel

				if var_113_17 == var_113_13 then
					var_113_18 = arg_113_12

					lib.Background(var_113_19, var_113_20, var_113_19 + arg_113_10 * var_113_9 / 2, var_113_20 + arg_113_10, 228, arg_113_11)
				end

				DrawString(var_113_19, var_113_20, var_113_6[var_113_17][1], var_113_18, arg_113_10)
			end
		end

		ShowScreen()

		local var_113_21 = WaitKey()

		lib.Delay(CC.Frame)

		if var_113_21 == VK_ESCAPE then
			if arg_113_9 == 1 then
				break
			end
		elseif var_113_21 == VK_DOWN then
			if var_113_7 >= var_113_11 + (var_113_12 + 1) * var_113_4 then
				var_113_12 = var_113_12 + 1

				if var_113_8 < var_113_12 then
					var_113_12 = var_113_8
				elseif var_113_12 >= arg_113_3 / 2 and var_113_12 <= var_113_8 - arg_113_3 / 2 and var_113_10 <= var_113_8 - arg_113_3 then
					var_113_10 = var_113_10 + 1
				end
			end
		elseif var_113_21 == VK_UP then
			var_113_12 = var_113_12 - 1

			if var_113_12 < 0 then
				var_113_12 = 0
			elseif var_113_12 >= arg_113_3 / 2 - 1 and var_113_12 < var_113_8 - arg_113_3 / 2 and var_113_10 > 0 then
				var_113_10 = var_113_10 - 1
			end
		elseif var_113_21 == VK_RIGHT then
			var_113_11 = var_113_11 + 1

			if var_113_4 < var_113_11 then
				var_113_11 = 1
			elseif var_113_7 < var_113_11 + var_113_12 * var_113_4 then
				var_113_11 = 1
			end
		elseif var_113_21 == VK_LEFT then
			var_113_11 = var_113_11 - 1

			if var_113_11 < 1 then
				var_113_11 = var_113_4

				if var_113_7 < var_113_11 + var_113_12 * var_113_4 then
					var_113_11 = var_113_7 - var_113_12 * var_113_4
				end
			end
		elseif var_113_21 == VK_SPACE or var_113_21 == VK_RETURN then
			var_113_13 = var_113_11 + var_113_12 * var_113_4

			if var_113_6[var_113_13][3] == 3 then
				-- Nothing
			elseif var_113_6[var_113_13][2] == nil then
				var_113_15 = var_113_13

				break
			elseif var_113_6[var_113_13][2](var_113_6, var_113_13) == 1 then
				var_113_15 = -var_113_13

				break
			else
				lib.LoadSur(var_113_16, 0, 0)

				if arg_113_8 == 1 then
					DrawBox(arg_113_4, arg_113_5, arg_113_4 + var_113_0, arg_113_5 + var_113_1, C_WHITE)
				end
			end
		end

		var_113_13 = var_113_11 + var_113_12 * var_113_4
	end

	lib.FreeSur(var_113_16)

	if var_113_15 > 0 then
		return var_113_6[var_113_15][4]
	else
		return var_113_15
	end
end

function UseThing(arg_114_0)
	if JY.ThingUseFunction[arg_114_0] == nil then
		return DefaultUseThing(arg_114_0)
	else
		return JY.ThingUseFunction[arg_114_0](arg_114_0)
	end
end

function DefaultUseThing(arg_115_0)
	if JY.Thing[arg_115_0].类型 == 0 then
		return UseThing_Type0(arg_115_0)
	elseif JY.Thing[arg_115_0].类型 == 1 then
		return UseThing_Type1(arg_115_0)
	elseif JY.Thing[arg_115_0].类型 == 2 then
		return UseThing_Type2(arg_115_0)
	elseif JY.Thing[arg_115_0].类型 == 3 then
		return UseThing_Type3(arg_115_0)
	elseif JY.Thing[arg_115_0].类型 == 4 then
		return UseThing_Type4(arg_115_0)
	end
end

function UseThing_Type0(arg_116_0)
	if JY.SubScene >= 0 then
		local var_116_0 = JY.Base.人X1 + CC.DirectX[JY.Base.人方向 + 1]
		local var_116_1 = JY.Base.人Y1 + CC.DirectY[JY.Base.人方向 + 1]
		local var_116_2 = GetS(JY.SubScene, var_116_0, var_116_1, 3)

		if var_116_2 >= 0 then
			JY.CurrentThing = arg_116_0

			EventExecute(var_116_2, 2)

			JY.CurrentThing = -1

			return 1
		else
			return 0
		end
	end
end

function CanUseThing(arg_117_0, arg_117_1)
	local var_117_0 = ""

	if cxtd(arg_117_1, 76) and arg_117_0 > 63 then
		return true
	elseif JY.Thing[arg_117_0].仅修炼人物 >= 0 and arg_117_1 == 0 and JY.Thing[arg_117_0].仅修炼人物 == JY.Base.畅想编号 then
		return true
	elseif cxtd(arg_117_1, 5089) and arg_117_0 > 35 and arg_117_0 < 64 or arg_117_0 == 230 or arg_117_0 == 236 then
		return true
	elseif cxtd(arg_117_1, 5055) and arg_117_0 > 85 and arg_117_0 < 113 and arg_117_0 ~= 93 then
		return true
	elseif cxtd(arg_117_1, 5056) and (arg_117_0 > 114 and arg_117_0 < 135 and arg_117_0 ~= 118 or arg_117_0 == 237) then
		return true
	elseif cxtd(arg_117_1, 5058) and arg_117_0 > 166 and arg_117_0 < 187 and arg_117_0 ~= 174 and arg_117_0 ~= 182 then
		return true
	elseif cxtd(arg_117_1, 5058) and arg_117_0 > 166 and arg_117_0 < 187 and arg_117_0 ~= 174 and arg_117_0 ~= 182 then
		return true
	elseif cxtd(arg_117_1, 49) and arg_117_0 == 79 then
		return true
	elseif cxtd(arg_117_1, 0) and arg_117_0 == 70 then
		return true
	elseif cxtd(arg_117_1, 5059) and arg_117_0 == 113 then
		return true
	elseif (cxtd(arg_117_1, 102) or cxtd(arg_117_1, 53)) and arg_117_0 == 113 then
		return true
	elseif cxtd(arg_117_1, 5060) and arg_117_0 == 114 then
		return true
	elseif cxtd(arg_117_1, 5061) and arg_117_0 == 118 then
		return true
	elseif cxtd(arg_117_1, 5062) and arg_117_0 == 86 then
		return true
	elseif cxtd(arg_117_1, 171) or cxtd(arg_117_1, 82) and (arg_117_0 == 97 or arg_117_0 == 115) then
		return true
	elseif (cxtd(arg_117_1, 113) or cxtd(arg_117_1, 51)) and arg_117_0 == 118 then
		return true
	elseif (cxtd(arg_117_1, 592) or cxtd(arg_117_1, 140) or cxtd(arg_117_1, 35)) and arg_117_0 == 114 then
		return true
	elseif (cxtd(arg_117_1, 58) or cxtd(arg_117_1, 0)) and JY.Person[arg_117_1].御剑能力 > 119 and arg_117_0 == 114 then
		return true
	elseif (cxtd(arg_117_1, 39) or cxtd(arg_117_1, 40)) and arg_117_0 == 80 then
		return true
	elseif (arg_117_0 == 220 or arg_117_0 == 221) and arg_117_1 == 0 then
		return true
	elseif arg_117_0 > 186 and arg_117_0 < 194 and cxtd(arg_117_1, 44) then
		return true
	elseif arg_117_0 == 114 and arg_117_1 == JY.Base.队伍1 and JY.Base.主角职业 == 2 and JY.Person[JY.Base.队伍1].御剑能力 > 99 then
		return true
	elseif arg_117_0 == 86 and arg_117_1 == JY.Base.队伍1 and JY.Base.主角职业 == 1 and JY.Person[JY.Base.队伍1].拳掌功夫 > 99 then
		return true
	else
		if JY.Thing[arg_117_0].仅修炼人物 >= 0 and JY.Thing[arg_117_0].仅修炼人物 ~= arg_117_1 then
			return false
		end

		if JY.Thing[arg_117_0].需内力性质 ~= 2 and JY.Person[arg_117_1].内力性质 ~= 2 and JY.Thing[arg_117_0].需内力性质 ~= JY.Person[arg_117_1].内力性质 and not cxtd(arg_117_1, 5064) and not cxtd(arg_117_1, 11) and not cxtd(arg_117_1, 102) then
			return false
		end

		if JY.Person[arg_117_1].内力最大值 < JY.Thing[arg_117_0].需内力 then
			return false
		end

		if JY.Person[arg_117_1].攻击力 < JY.Thing[arg_117_0].需攻击力 then
			return false
		end

		if JY.Person[arg_117_1].轻功 < JY.Thing[arg_117_0].需轻功 then
			return false
		end

		if JY.Person[arg_117_1].用毒能力 < JY.Thing[arg_117_0].需用毒能力 then
			return false
		end

		if JY.Person[arg_117_1].医疗能力 < JY.Thing[arg_117_0].需医疗能力 then
			return false
		end

		if JY.Person[arg_117_1].解毒能力 < JY.Thing[arg_117_0].需解毒能力 then
			return false
		end

		local var_117_1 = 0

		for iter_117_0 = 1, CC.Kungfunum do
			if JY.Person[arg_117_1]["武功" .. iter_117_0] == 98 then
				var_117_1 = math.modf(JY.Person[arg_117_1]["武功等级" .. iter_117_0] / 100) + 2

				break
			end
		end

		local var_117_2 = limitX(var_117_1, 0, 20)

		if cxtd(arg_117_1, 5063) then
			var_117_2 = var_117_2 + 10
		end

		if cxtd(arg_117_1, 30) then
			var_117_2 = var_117_2 + 10
		end

		if cxtd(arg_117_1, 172) then
			var_117_2 = var_117_2 + 20
		end

		if cxtd(arg_117_1, 10) then
			var_117_2 = var_117_2 + 200
		end

		if JY.Person[arg_117_1].拳掌功夫 + var_117_2 < JY.Thing[arg_117_0].需拳掌功夫 then
			return false
		end

		if JY.Person[arg_117_1].御剑能力 + var_117_2 < JY.Thing[arg_117_0].需御剑能力 then
			return false
		end

		if JY.Person[arg_117_1].耍刀技巧 + var_117_2 < JY.Thing[arg_117_0].需耍刀技巧 then
			return false
		end

		if JY.Person[arg_117_1].特殊兵器 + var_117_2 < JY.Thing[arg_117_0].需特殊兵器 then
			return false
		end

		if JY.Person[arg_117_1].暗器技巧 < JY.Thing[arg_117_0].需暗器技巧 then
			return false
		end

		if JY.Thing[arg_117_0].需悟性 >= 0 then
			local var_117_3 = 0

			if T3XXM(arg_117_1) then
				var_117_3 = JY.Thing[arg_117_0].需悟性
			end

			if JY.Thing[arg_117_0].需悟性 > JY.Person[arg_117_1].悟性 + var_117_3 then
				return false
			end
		else
			local var_117_4 = 0

			if T3XXM(arg_117_1) then
				var_117_4 = JY.Thing[arg_117_0].需悟性
			end

			if -JY.Thing[arg_117_0].需悟性 < JY.Person[arg_117_1].悟性 + var_117_4 then
				return false
			end
		end
	end

	return true
end

function UseThing_Type1(arg_118_0)
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要配备%s?", JY.Thing[arg_118_0].名称), C_WHITE, CC.DefaultFont)

	local var_118_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_118_1 = SelectTeamMenu(CC.MainSubMenuX, var_118_0)
	local var_118_2 = 0
	local var_118_3 = 0

	if var_118_1 > 0 then
		local var_118_4 = JY.Base["队伍" .. var_118_1]

		if CanUseThing(arg_118_0, var_118_4) or T2SQ(var_118_4) or cxtd(var_118_4, 123) then
			if JY.Thing[arg_118_0].装备类型 == 0 then
				if JY.Thing[arg_118_0].使用人 >= 0 then
					if JY.Person[JY.Thing[arg_118_0].使用人].姓名 == JY.SQ or cxtd(var_118_4, 123) then
						JY.Thing[arg_118_0].加攻击力 = JY.Thing[arg_118_0].加攻击力 / 2
						JY.Thing[arg_118_0].加防御力 = JY.Thing[arg_118_0].加防御力 / 2
						JY.Thing[arg_118_0].加轻功 = JY.Thing[arg_118_0].加轻功 / 2
					end

					JY.Person[JY.Thing[arg_118_0].使用人].武器 = -1
				end

				if JY.Person[var_118_4].武器 >= 0 then
					if T2SQ(var_118_4) or cxtd(var_118_4, 123) then
						JY.Thing[JY.Person[var_118_4].武器].加攻击力 = JY.Thing[JY.Person[var_118_4].武器].加攻击力 / 2
						JY.Thing[JY.Person[var_118_4].武器].加防御力 = JY.Thing[JY.Person[var_118_4].武器].加防御力 / 2
						JY.Thing[JY.Person[var_118_4].武器].加轻功 = JY.Thing[JY.Person[var_118_4].武器].加轻功 / 2
					end

					if JY.Thing[JY.Person[var_118_4].武器].使用人 >= 0 then
						addthing(JY.Person[var_118_4].武器, -1)
					end

					JY.Thing[JY.Person[var_118_4].武器].使用人 = -1

					addthing(JY.Person[var_118_4].武器)
				end

				addthing(arg_118_0, -1)

				JY.Person[var_118_4].武器 = arg_118_0

				if T2SQ(var_118_4) or cxtd(var_118_4, 123) then
					JY.Thing[arg_118_0].加攻击力 = JY.Thing[arg_118_0].加攻击力 * 2
					JY.Thing[arg_118_0].加防御力 = JY.Thing[arg_118_0].加防御力 * 2
					JY.Thing[arg_118_0].加轻功 = JY.Thing[arg_118_0].加轻功 * 2
				end
			elseif JY.Thing[arg_118_0].装备类型 == 1 then
				if JY.Thing[arg_118_0].使用人 >= 0 then
					if JY.Person[JY.Thing[arg_118_0].使用人].姓名 == JY.SQ or cxtd(var_118_4, 123) then
						JY.Thing[arg_118_0].加攻击力 = JY.Thing[arg_118_0].加攻击力 / 2
						JY.Thing[arg_118_0].加防御力 = JY.Thing[arg_118_0].加防御力 / 2
						JY.Thing[arg_118_0].加轻功 = JY.Thing[arg_118_0].加轻功 / 2
					end

					JY.Person[JY.Thing[arg_118_0].使用人].防具 = -1
				end

				if JY.Person[var_118_4].防具 >= 0 then
					if T2SQ(var_118_4) or cxtd(var_118_4, 123) then
						JY.Thing[JY.Person[var_118_4].防具].加攻击力 = JY.Thing[JY.Person[var_118_4].防具].加攻击力 / 2
						JY.Thing[JY.Person[var_118_4].防具].加防御力 = JY.Thing[JY.Person[var_118_4].防具].加防御力 / 2
						JY.Thing[JY.Person[var_118_4].防具].加轻功 = JY.Thing[JY.Person[var_118_4].防具].加轻功 / 2
					end

					if JY.Thing[JY.Person[var_118_4].防具].使用人 >= 0 then
						addthing(JY.Person[var_118_4].防具, -1)
					end

					addthing(JY.Person[var_118_4].防具)

					JY.Thing[JY.Person[var_118_4].防具].使用人 = -1
				end

				addthing(arg_118_0, -1)

				JY.Person[var_118_4].防具 = arg_118_0

				if T2SQ(var_118_4) or cxtd(var_118_4, 123) then
					JY.Thing[arg_118_0].加攻击力 = JY.Thing[arg_118_0].加攻击力 * 2
					JY.Thing[arg_118_0].加防御力 = JY.Thing[arg_118_0].加防御力 * 2
					JY.Thing[arg_118_0].加轻功 = JY.Thing[arg_118_0].加轻功 * 2
				end
			elseif JY.Thing[arg_118_0].装备类型 == 2 then
				if JY.Thing[arg_118_0].使用人 >= 0 then
					JY.Person[JY.Thing[arg_118_0].使用人].饰品 = -1
				end

				if JY.Person[var_118_4].饰品 >= 0 then
					if JY.Thing[JY.Person[var_118_4].饰品].使用人 >= 0 then
						addthing(JY.Person[var_118_4].饰品, -1)
					end

					addthing(JY.Person[var_118_4].饰品)

					JY.Thing[JY.Person[var_118_4].饰品].使用人 = -1
				end

				addthing(arg_118_0, -1)

				JY.Person[var_118_4].饰品 = arg_118_0
			elseif JY.Thing[arg_118_0].装备类型 == 3 then
				if JY.Thing[arg_118_0].使用人 >= 0 then
					JY.Person[JY.Thing[arg_118_0].使用人].坐骑 = -1
				end

				if JY.Person[var_118_4].坐骑 >= 0 then
					if JY.Thing[JY.Person[var_118_4].坐骑].使用人 >= 0 then
						addthing(JY.Person[var_118_4].坐骑, -1)
					end

					addthing(JY.Person[var_118_4].坐骑)

					JY.Thing[JY.Person[var_118_4].坐骑].使用人 = -1
				end

				addthing(arg_118_0, -1)

				JY.Person[var_118_4].坐骑 = arg_118_0
			end
		else
			DrawStrBoxWaitKey("此人不适合配备此物品", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	return 1
end

function UseThing_Type2(arg_119_0)
	if JY.SMKG == 1 then
		local var_119_0 = JY.Thing[arg_119_0].练出武功
		local var_119_1 = string.format("%s%d.txt", CONFIG.WuGongPath, var_119_0)

		if existFile(var_119_1) == false then
			QZXS("此武功未包含任何说明，请自行琢磨")
		else
			Cls()
			DrawTxt(var_119_1)
			Cls()
		end
	end

	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要修炼%s?", JY.Thing[arg_119_0].名称), C_WHITE, CC.DefaultFont)

	local var_119_2 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_119_3 = SelectTeamMenu(CC.MainSubMenuX, var_119_2)

	if var_119_3 > 0 then
		local var_119_4 = JY.Base["队伍" .. var_119_3]
		local var_119_5
		local var_119_6
		local var_119_7 = 0

		if JY.Person[var_119_4].悟性 >= 60 then
			var_119_7 = math.ceil(JY.Person[var_119_4].悟性 / 5) - 12
		end

		local var_119_8 = 12 + var_119_7

		if JY.Thing[arg_119_0].练出武功 >= 0 then
			var_119_5 = 0
			var_119_6 = 1

			for iter_119_0 = 1, var_119_8 do
				if JY.Person[var_119_4]["武功" .. iter_119_0] == JY.Thing[arg_119_0].练出武功 then
					var_119_5 = 1
				elseif JY.Person[var_119_4]["武功" .. iter_119_0] == 0 then
					var_119_6 = 0
				end
			end
		end

		if var_119_5 == 0 and var_119_6 == 1 then
			DrawStrBoxWaitKey("人力有时而穷，你的能力已经不足以学习更多的武功了", C_WHITE, CC.DefaultFont)

			return 0
		end

		if CC.Shemale[arg_119_0] == 1 then
			if T1LEQ(var_119_4) then
				say("欲练神功　挥刀自宫", var_119_4, 0)
				say("这太惨了吧！先看看再说....（翻到下一页）", var_119_4, 0)
				say("若不自宫　也可练功", var_119_4, 0)
				say("哈，原来不自宫也能练啊！太棒了！！！", var_119_4, 0)

				var_119_5 = 2
			elseif cxtd(var_119_4, 29) and GetS(86, 10, 12, 5) == 1 then
				Talk(JY.Thing[arg_119_0].名称 .. " 这玩意不适合我", 29)

				return 0
			elseif JY.Person[var_119_4].性别 == 0 and CanUseThing(arg_119_0, var_119_4) then
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

					JY.Person[var_119_4].性别 = 2
					JY.Person[var_119_4].内力性质 = 0

					if var_119_4 == 19 or var_119_4 == 27 or var_119_4 == 36 then
						-- Nothing
					else
						local var_119_9, var_119_10 = AddPersonAttrib(var_119_4, "攻击力", -20)

						DrawStrBoxWaitKey(JY.Person[var_119_4].姓名 .. var_119_10, C_ORANGE, CC.DefaultFont)

						local var_119_11, var_119_12 = AddPersonAttrib(var_119_4, "防御力", -30)

						DrawStrBoxWaitKey(JY.Person[var_119_4].姓名 .. var_119_12, C_ORANGE, CC.DefaultFont)
					end
				end
			elseif JY.Person[var_119_4].性别 == 1 then
				DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)

				return 0
			end
		end

		if var_119_5 == 1 or CanUseThing(arg_119_0, var_119_4) or var_119_5 == 2 then
			if JY.Thing[arg_119_0].使用人 == var_119_4 then
				return 0
			end

			if JY.Person[var_119_4].修炼物品 >= 0 then
				JY.Thing[JY.Person[var_119_4].修炼物品].使用人 = -1
			end

			if JY.Thing[arg_119_0].使用人 >= 0 then
				JY.Person[JY.Thing[arg_119_0].使用人].修炼物品 = -1
				JY.Person[JY.Thing[arg_119_0].使用人].物品修炼点数 = 0
			end

			JY.Thing[arg_119_0].使用人 = var_119_4
			JY.Person[var_119_4].修炼物品 = arg_119_0
			JY.Person[var_119_4].修炼点数 = 0
			JY.Person[var_119_4].物品修炼点数 = 0

			War_PersonTrainBook(var_119_4)
		else
			DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)

			return 0
		end
	end

	return 1
end

function UseThing_Type3(arg_120_0)
	local var_120_0 = -1

	if JY.Status == GAME_MMAP or JY.Status == GAME_SMAP then
		Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, string.format("谁要使用%s?", JY.Thing[arg_120_0].名称), C_WHITE, CC.DefaultFont)

		local var_120_1 = CC.MainSubMenuY + CC.SingleLineHeight
		local var_120_2 = SelectTeamMenu(CC.MainSubMenuX, var_120_1)

		if var_120_2 > 0 then
			var_120_0 = JY.Base["队伍" .. var_120_2]
		end
	elseif JY.Status == GAME_WMAP then
		local var_120_3 = WAR.Person[WAR.CurID].人物编号

		if cxtd(var_120_3, 16) then
			War_CalMoveStep(WAR.CurID, 8, 1)

			local var_120_4, var_120_5 = War_SelectMove()

			if var_120_4 ~= nil then
				local var_120_6 = GetWarMap(var_120_4, var_120_5, 2)

				if var_120_6 >= 0 and WAR.Person[WAR.CurID].我方 == WAR.Person[var_120_6].我方 then
					var_120_0 = WAR.Person[var_120_6].人物编号
				end
			end
		else
			var_120_0 = WAR.Person[WAR.CurID].人物编号
		end
	end

	if var_120_0 >= 0 then
		local var_120_7 = 0
		local var_120_8 = JY.Person[var_120_0].生命最大值 - JY.Person[var_120_0].生命
		local var_120_9 = JY.Person[var_120_0].内力最大值 - JY.Person[var_120_0].内力
		local var_120_10 = JY.Person[var_120_0].中毒程度
		local var_120_11 = JY.Person[var_120_0].流血值
		local var_120_12 = JY.Person[var_120_0].中火毒
		local var_120_13 = JY.Person[var_120_0].中冰毒

		if JY.Status ~= GAME_WMAP and (arg_120_0 == 1 and has_something(1, 2) and var_120_8 > 600 or arg_120_0 == 2 and has_something(2, 2) and var_120_8 > 1000 or arg_120_0 == 7 and has_something(7, 2) and var_120_8 > 400 or arg_120_0 == 8 and has_something(8, 2) and var_120_8 > 1000 or arg_120_0 == 21 and has_something(21, 2) and var_120_8 > 240 or arg_120_0 == 3 and has_something(3, 2) and var_120_9 > 600 or arg_120_0 == 4 and has_something(4, 2) and var_120_9 > 1000 or arg_120_0 == 5 and has_something(5, 2) and var_120_9 > 1200 or arg_120_0 == 6 and has_something(6, 2) and var_120_9 > 4000 or arg_120_0 == 9 and has_something(9, 2) and var_120_10 > 40 or arg_120_0 == 20 and has_something(20, 2) and var_120_11 > 40 or arg_120_0 == 346 and has_something(346, 2) and var_120_12 > 50 or arg_120_0 == 347 and has_something(347, 2) and var_120_12 > 20 or arg_120_0 == 344 and has_something(344, 2) and var_120_12 > 40 or arg_120_0 == 345 and has_something(345, 2) and var_120_12 > 20) then
			for iter_120_0 = 1, CC.MyThingNum do
				if JY.Base["物品" .. iter_120_0] == arg_120_0 then
					var_120_7 = JY.Base["物品数量" .. iter_120_0]

					break
				end
			end

			local var_120_14 = InputNum("服用数量", 1, var_120_7, 1)

			if var_120_14 ~= nil then
				for iter_120_1 = 1, var_120_14 - 1 do
					UseThingEffect(arg_120_0, var_120_0)
					ShowScreen()
					lib.Delay(500)
					Cls()
					ShowScreen()
				end

				instruct_32(arg_120_0, -var_120_14 + 1)
			end
		end

		if UseThingEffect(arg_120_0, var_120_0) == 1 then
			if arg_120_0 == 19 then
				JY.Person[var_120_0].生命增长 = JY.Person[var_120_0].生命增长 + 1

				DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了少林大还丹，体质提升了一点。身上的旧伤似乎也好了", C_ORANGE, CC.DefaultFont)

				if var_120_0 == 0 then
					AddPersonAttrib(550, "生命增长", 1)
				end

				ShowScreen()
				lib.Delay(1000)
				Cls()
				ShowScreen()
			end

			if arg_120_0 == 194 then
				if var_120_0 == 0 then
					say("你忍住恶心，将冰蚕塞入嘴里，也没有咀嚼，囫囵吞了下去", 0, 2)
				elseif JY.Person[var_120_0].性别 == 1 then
					if var_120_0 == 2 or var_120_0 == 83 then
						say("上古灵物，就这么吃了啊。", var_120_0, 0)
					else
						say("好恶心，这个东西你想吃就自己吃。", var_120_0, 0)

						return
					end
				end

				if var_120_0 == 0 and JY.Base.主角职业 == 5 and JY.Base.畅想编号 == 0 then
					JY.Person[var_120_0].无用2 = JY.Person[var_120_0].无用2 + 5

					AddPersonAttrib(var_120_0, "生命最大值", -50)
					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了冰蚕，攻击附带冰毒,最大生命值降低了50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 2 then
					AddPersonAttrib(var_120_0, "生命最大值", -50)

					JY.Person[var_120_0].中冰毒 = JY.Person[var_120_0].中冰毒 + 30

					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了冰蚕，不慎中毒,最大生命值降低了50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 0 then
					if var_120_0 == 2 or var_120_0 == 83 then
						say("等我再配点药物一起服用才好。", var_120_0, 0)
						dark()
						light()

						JY.Person[var_120_0].无用2 = JY.Person[var_120_0].无用2 + 10
					else
						JY.Person[var_120_0].无用2 = JY.Person[var_120_0].无用2 + 5
					end

					AddPersonAttrib(var_120_0, "生命最大值", -50)
					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了冰蚕，攻击附带冰毒,最大生命值降低了50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 1 then
					AddPersonAttrib(var_120_0, "生命最大值", -100)

					JY.Person[var_120_0].中冰毒 = JY.Person[var_120_0].中冰毒 + 60

					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了冰蚕，不慎中毒,最大生命值降低了100点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				end

				if JY.Person[var_120_0].生命最大值 < 1 then
					JY.Person[var_120_0].生命最大值 = 1
				end
			end

			if arg_120_0 == 231 then
				if var_120_0 == 0 then
					say("你忍住恶心，将火蟾塞入嘴里，也没有咀嚼，囫囵吞了下去", 0, 2)
				elseif JY.Person[var_120_0].性别 == 1 then
					if var_120_0 == 2 or var_120_0 == 83 then
						say("上古灵物，就这么吃了啊。", var_120_0, 0)
					else
						say("好恶心，这个东西你想吃就自己吃。", var_120_0, 0)

						return
					end
				end

				if var_120_0 == 0 and JY.Base.主角职业 == 5 and JY.Base.畅想编号 == 0 then
					JY.Person[var_120_0].无用3 = JY.Person[var_120_0].无用3 + 5

					AddPersonAttrib(var_120_0, "生命最大值", -50)
					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了火蟾，攻击附带火毒,最大生命值降低50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 2 then
					AddPersonAttrib(var_120_0, "生命最大值", -50)

					JY.Person[var_120_0].中火毒 = JY.Person[var_120_0].中火毒 + 30

					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了火蟾，不慎中毒,最大生命值降低了50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 1 then
					if var_120_0 == 2 or var_120_0 == 83 then
						say("等我再配点药物一起服用才好。", var_120_0, 0)
						dark()
						light()

						JY.Person[var_120_0].无用3 = JY.Person[var_120_0].无用3 + 10
					else
						JY.Person[var_120_0].无用3 = JY.Person[var_120_0].无用3 + 5
					end

					AddPersonAttrib(var_120_0, "生命最大值", -50)
					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了火蟾，攻击附带火毒,最大生命值降低50点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				elseif JY.Person[var_120_0].内力性质 == 0 then
					AddPersonAttrib(var_120_0, "生命最大值", -100)

					JY.Person[var_120_0].中火毒 = JY.Person[var_120_0].中火毒 + 60

					DrawStrBox(-1, -1, JY.Person[var_120_0].姓名 .. "服用了火蟾，不慎中毒,最大生命值降低了100点", C_ORANGE, CC.DefaultFont)
					ShowScreen()
					lib.Delay(2000)
					Cls()
					ShowScreen()
				end

				if JY.Person[var_120_0].生命最大值 < 1 then
					JY.Person[var_120_0].生命最大值 = 1
				end
			end

			local var_120_15 = 0

			if arg_120_0 == 325 then
				for iter_120_2 = 1, CC.MyThingNum do
					if JY.Base["物品" .. iter_120_2] == arg_120_0 then
						var_120_15 = JY.Base["物品数量" .. iter_120_2]

						break
					end
				end

				if var_120_15 >= 5 then
					local var_120_16 = InputNum("服用数量", 1, var_120_15, 1)

					if var_120_16 ~= nil then
						instruct_32(arg_120_0, -var_120_16 + 1)
						AddPersonAttrib(var_120_0, "内力最大值", 5 * (var_120_16 - 2))
					end
				end
			end

			instruct_32(arg_120_0, -1)
			WaitKey()
		end
	else
		return 0
	end

	return 1
end

function UseThing_Type4(arg_121_0)
	if JY.Status == GAME_WMAP then
		return War_UseAnqi(arg_121_0)
	end

	return 0
end

function EventExecute(arg_122_0, arg_122_1)
	JY.CurrentD = arg_122_0

	if JY.SceneNewEventFunction[JY.SubScene] == nil then
		oldEventExecute(arg_122_1)
	else
		JY.SceneNewEventFunction[JY.SubScene](arg_122_1)
	end

	JY.CurrentD = -1
end

function oldEventExecute(arg_123_0)
	local var_123_0

	if arg_123_0 == 1 then
		var_123_0 = GetD(JY.SubScene, JY.CurrentD, 2)
	elseif arg_123_0 == 2 then
		var_123_0 = GetD(JY.SubScene, JY.CurrentD, 3)
	elseif arg_123_0 == 3 then
		var_123_0 = GetD(JY.SubScene, JY.CurrentD, 4)
	end

	lib.Debug(var_123_0 .. "")

	if var_123_0 > 0 then
		if CallCEvent(var_123_0) then
			if OEVENTLUA[var_123_0] ~= nil then
				OEVENTLUA[var_123_0]()
			end
		elseif OEVENTLUA[var_123_0] ~= nil then
			OEVENTLUA[var_123_0]()
		else
			oldCallEvent(var_123_0)
		end
	end
end

function existFile(arg_124_0)
	local var_124_0 = io.open(arg_124_0)

	if var_124_0 == nil then
		return false
	end

	io.close(var_124_0)

	return true
end

function CallCEvent(arg_125_0)
	local var_125_0 = string.format("%s%d.lua", CONFIG.CEventPath, arg_125_0)

	if existFile(var_125_0) then
		dofile(var_125_0)

		return true
	else
		return false
	end
end

function ReturnMMap()
	JY.Status = GAME_MMAP

	lib.PicInit()
	CleanMemory()
	Init_MMap()

	JY.SubScene = -1
	JY.oldSMapX = -1
	JY.oldSMapY = -1

	lib.GetKey()
	lib.ShowSlow(50, 0)
end

function ReturnMMap2(arg_127_0, arg_127_1)
	JY.Status = GAME_MMAP

	lib.PicInit()
	CleanMemory()
	Init_MMap()

	JY.SubScene = -1
	JY.oldSMapX = -1
	JY.oldSMapY = -1
	JY.Base.人X = arg_127_0
	JY.Base.人Y = arg_127_1

	lib.GetKey()
	lib.ShowSlow(50, 0)
end

function ChangeMMap(arg_128_0, arg_128_1, arg_128_2)
	JY.Base.人X = arg_128_0
	JY.Base.人Y = arg_128_1
	JY.Base.人方向 = arg_128_2
end

function ChangeSMap(arg_129_0, arg_129_1, arg_129_2, arg_129_3)
	JY.SubScene = arg_129_0
	JY.Base.人X1 = arg_129_1
	JY.Base.人Y1 = arg_129_2
	JY.Base.人方向 = arg_129_3
end

function Cls(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
	if arg_130_0 == nil then
		arg_130_0 = 0
		arg_130_1 = 0
		arg_130_2 = CC.ScreenW
		arg_130_3 = CC.ScreenH
	end

	lib.SetClip(arg_130_0, arg_130_1, arg_130_2, arg_130_3)

	if JY.Status == GAME_START then
		lib.FillColor(0, 0, 0, 0, 0)
	elseif JY.Status == GAME_MMAP then
		lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
	elseif JY.Status == GAME_SMAP then
		DrawSMap()
	elseif JY.Status == GAME_WMAP then
		WarDrawMap(0)
	elseif JY.Status == GAME_DEAD then
		lib.FillColor(0, 0, 0, 0, 0)
		lib.LoadPicture(CC.DeadFile, -1, -1)
	end

	lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
end

function GenTalkString(arg_131_0, arg_131_1)
	local var_131_0 = ""

	for iter_131_0 in string.gmatch(arg_131_0 .. "*", "(.-)%*") do
		var_131_0 = var_131_0 .. iter_131_0
	end

	local var_131_1 = ""

	while #var_131_0 > 0 do
		local var_131_2 = 0

		while var_131_2 < #var_131_0 do
			if string.byte(var_131_0, var_131_2 + 1) >= 128 then
				var_131_2 = var_131_2 + 2
			else
				var_131_2 = var_131_2 + 1
			end

			if var_131_2 >= 2 * arg_131_1 - 1 then
				break
			end
		end

		if var_131_2 < #var_131_0 then
			if var_131_2 == 2 * arg_131_1 - 1 and string.byte(var_131_0, var_131_2 + 1) < 128 then
				var_131_1 = var_131_1 .. string.sub(var_131_0, 1, var_131_2 + 1) .. "*"
				var_131_0 = string.sub(var_131_0, var_131_2 + 2, -1)
			else
				var_131_1 = var_131_1 .. string.sub(var_131_0, 1, var_131_2) .. "*"
				var_131_0 = string.sub(var_131_0, var_131_2 + 1, -1)
			end
		else
			var_131_1 = var_131_1 .. var_131_0

			break
		end
	end

	return var_131_1
end

function Talk(arg_132_0, arg_132_1)
	local var_132_0
	local var_132_1 = arg_132_1 == 0 and 1 or 0

	TalkEx(arg_132_0, JY.Person[arg_132_1].头像代号, var_132_1)
end

function say(arg_133_0, arg_133_1, arg_133_2)
	local var_133_0 = 130
	local var_133_1 = 130
	local var_133_2 = 12
	local var_133_3 = 3
	local var_133_4 = 2
	local var_133_5 = 150
	local var_133_6 = var_133_0 + 10
	local var_133_7 = var_133_1 + 10
	local var_133_8 = 12 * CC.DefaultFont + 10
	local var_133_9 = var_133_7
	local var_133_10 = (var_133_1 - var_133_3 * CC.DefaultFont) / (var_133_3 + 1)
	local var_133_11 = {
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_133_4 - var_133_6,
			heady = CC.ScreenH - var_133_5 - var_133_7,
			talkx = CC.ScreenW - 1 - var_133_4 - var_133_6 - var_133_8 - 2,
			talky = CC.ScreenH - var_133_5 - var_133_7
		},
		{
			showhead = 0,
			headx = var_133_4,
			heady = var_133_5,
			talkx = var_133_4 + var_133_6 + 2,
			talky = var_133_5
		},
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_133_4 - var_133_6,
			heady = CC.ScreenH - var_133_5 - var_133_7,
			talkx = CC.ScreenW - 1 - var_133_4 - var_133_6 - var_133_8 - 2,
			talky = CC.ScreenH - var_133_5 - var_133_7
		},
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_133_4 - var_133_6,
			heady = var_133_5,
			talkx = CC.ScreenW - 1 - var_133_4 - var_133_6 - var_133_8 - 2,
			talky = var_133_5
		},
		{
			showhead = 1,
			headx = var_133_4,
			heady = CC.ScreenH - var_133_5 - var_133_7,
			talkx = var_133_4 + var_133_6 + 2,
			talky = CC.ScreenH - var_133_5 - var_133_7
		},
		[0] = {
			showhead = 1,
			headx = var_133_4,
			heady = var_133_5,
			talkx = var_133_4 + var_133_6 + 2,
			talky = var_133_5
		}
	}

	if arg_133_2 < 0 or arg_133_2 > 5 then
		arg_133_2 = 0
	end

	if var_133_11[arg_133_2].showhead == 0 then
		arg_133_1 = -1
	end

	arg_133_0 = GenTalkString(arg_133_0, 12)

	if CONFIG.KeyRepeat == 0 then
		lib.EnableKeyRepeat(0, CONFIG.KeyRepeatInterval)
	end

	lib.GetKey()

	local var_133_12 = 1
	local var_133_13
	local var_133_14 = 0
	local var_133_15 = 0

	while true do
		if var_133_14 == 0 then
			Cls()

			if arg_133_1 >= 0 then
				if arg_133_1 == 0 then
					if JY.Base.畅想编号 == 0 then
						if JY.Base.主角职业 < 10 then
							if JY.Person[0].性别 == 0 then
								arg_133_1 = 280 + JY.Base.主角职业
							else
								arg_133_1 = 501 + JY.Base.主角职业
							end
						else
							arg_133_1 = 289 + JY.Base.特殊主角
						end
					else
						var_133_15 = JY.Person[JY.Base.畅想编号].头像代号
					end
				end

				DrawBox(var_133_11[arg_133_2].headx, var_133_11[arg_133_2].heady, var_133_11[arg_133_2].headx + var_133_6, var_133_11[arg_133_2].heady + var_133_7, C_WHITE)

				local var_133_16, var_133_17 = lib.GetPNGXY(1, arg_133_1 * 2)
				local var_133_18 = (var_133_0 - var_133_16) / 2
				local var_133_19 = (var_133_1 - var_133_17) / 2

				if arg_133_1 == 0 then
					if JY.Person[JY.Base.畅想编号].头像代号 > 0 then
						lib.LoadPNG(1, var_133_15 * 2, var_133_11[arg_133_2].headx + 5 + var_133_18, var_133_11[arg_133_2].heady + 5 + var_133_19, 1)
					else
						lib.LoadPNG(1, arg_133_1 * 2, var_133_11[arg_133_2].headx + 5 + var_133_18, var_133_11[arg_133_2].heady + 5 + var_133_19, 1)
					end
				else
					lib.LoadPNG(1, arg_133_1 * 2, var_133_11[arg_133_2].headx + 5 + var_133_18, var_133_11[arg_133_2].heady + 5 + var_133_19, 1)
				end

				if arg_133_1 >= 0 and arg_133_1 < 190 or arg_133_1 > 579 and arg_133_1 < 635 then
					if arg_133_1 == 0 then
						DrawString(var_133_11[arg_133_2].headx + 5 + var_133_18, var_133_11[arg_133_2].heady + 2 + var_133_19 + var_133_0 - CC.Fontsmall, JY.Person[0].姓名, C_GOLD, CC.Fontsmall)
					else
						DrawString(var_133_11[arg_133_2].headx + 5 + var_133_18, var_133_11[arg_133_2].heady + 2 + var_133_19 + var_133_0 - CC.Fontsmall, JY.Person[arg_133_1].姓名, C_GOLD, CC.Fontsmall)
					end
				end

				DrawBox(var_133_11[arg_133_2].talkx, var_133_11[arg_133_2].talky, var_133_11[arg_133_2].talkx + var_133_8, var_133_11[arg_133_2].talky + var_133_9, C_WHITE)
			end
		end

		local var_133_20 = string.find(arg_133_0, "*", var_133_12)

		if var_133_20 == nil then
			DrawString(var_133_11[arg_133_2].talkx + 5, var_133_11[arg_133_2].talky + 5 + var_133_10 + var_133_14 * (CC.DefaultFont + var_133_10), string.sub(arg_133_0, var_133_12), C_WHITE, CC.DefaultFont)
			ShowScreen()
			WaitKey()

			break
		else
			DrawString(var_133_11[arg_133_2].talkx + 5, var_133_11[arg_133_2].talky + 5 + var_133_10 + var_133_14 * (CC.DefaultFont + var_133_10), string.sub(arg_133_0, var_133_12, var_133_20 - 1), C_WHITE, CC.DefaultFont)
		end

		var_133_14 = var_133_14 + 1
		var_133_12 = var_133_20 + 1

		if var_133_3 <= var_133_14 then
			ShowScreen()
			WaitKey()

			var_133_14 = 0
		end
	end

	if CONFIG.KeyRepeat == 0 then
		lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRepeatInterval)
	end

	Cls()
end

function say2(arg_134_0, arg_134_1)
	TalkEx(arg_134_0, arg_134_1, 0)
end

function say3(arg_135_0, arg_135_1, arg_135_2)
	if arg_135_2 == nil then
		arg_135_2 = ""
	end

	say(arg_135_0, arg_135_1, 0, arg_135_2)
end

function instruct_test(arg_136_0)
	DrawStrBoxWaitKey(arg_136_0, C_ORANGE, 24)
end

function instruct_0()
	Cls()
end

function ReadTalk(arg_138_0, arg_138_1)
	local var_138_0 = Byte.create(arg_138_0 * 4 + 4)

	Byte.loadfile(var_138_0, CC.TDX, 0, arg_138_0 * 4 + 4)

	local var_138_1
	local var_138_2
	local var_138_3 = arg_138_0 < 1 and 0 or Byte.get32(var_138_0, (arg_138_0 - 1) * 4)
	local var_138_4 = Byte.get32(var_138_0, arg_138_0 * 4) - var_138_3
	local var_138_5 = Byte.create(var_138_4)

	Byte.loadfile(var_138_5, CC.TRP, var_138_3, var_138_4)

	local var_138_6 = ""

	for iter_138_0 = 0, var_138_4 - 2 do
		local var_138_7 = Byte.getu16(var_138_5, iter_138_0)
		local var_138_8 = 255 - math.fmod(var_138_7, 256)

		var_138_6 = var_138_6 .. string.char(var_138_8)
	end

	if arg_138_1 == nil then
		var_138_6 = lib.CharSet(var_138_6, 0)
		var_138_6 = GenTalkString(var_138_6, 12)
	end

	return var_138_6
end

function instruct_1(arg_139_0, arg_139_1, arg_139_2)
	local var_139_0 = ReadTalk(arg_139_0)

	if var_139_0 == nil then
		return
	end

	TalkEx(var_139_0, arg_139_1, arg_139_2)
end

function GenTalkIdx()
	return
end

function instruct_2(arg_141_0, arg_141_1)
	if JY.Thing[arg_141_0] == nil then
		return
	end

	instruct_32(arg_141_0, arg_141_1)

	if arg_141_1 > 0 then
		DrawStrBox(-1, -1, string.format("得到物品:%s %d", JY.Thing[arg_141_0].名称, arg_141_1), C_ORANGE, CC.DefaultFont)
	else
		DrawStrBox(-1, -1, string.format("失去物品:%s %d", JY.Thing[arg_141_0].名称, -arg_141_1), C_ORANGE, CC.DefaultFont)
	end

	ShowScreen()
	lib.Delay(400)
	Cls()
end

function instruct_2_sub()
	if JY.Person[0].声望 < 200 then
		return
	end

	if instruct_18(189) == true then
		return
	end

	local var_142_0 = 0

	for iter_142_0 = 1, CC.BookNum do
		if instruct_18(CC.BookStart + iter_142_0 - 1) == true then
			var_142_0 = var_142_0 + 1
		end
	end

	if var_142_0 == CC.BookNum then
		instruct_3(70, 11, -1, 1, 932, -1, -1, 7968, 7968, 7968, -2, -2, -2)
	end
end

function instruct_3(arg_143_0, arg_143_1, arg_143_2, arg_143_3, arg_143_4, arg_143_5, arg_143_6, arg_143_7, arg_143_8, arg_143_9, arg_143_10, arg_143_11, arg_143_12)
	if arg_143_0 == -2 then
		arg_143_0 = JY.SubScene
	end

	if arg_143_1 == -2 then
		arg_143_1 = JY.CurrentD
	end

	if arg_143_2 ~= -2 then
		SetD(arg_143_0, arg_143_1, 0, arg_143_2)
	end

	if arg_143_3 ~= -2 then
		SetD(arg_143_0, arg_143_1, 1, arg_143_3)
	end

	if arg_143_4 ~= -2 then
		SetD(arg_143_0, arg_143_1, 2, arg_143_4)
	end

	if arg_143_5 ~= -2 then
		SetD(arg_143_0, arg_143_1, 3, arg_143_5)
	end

	if arg_143_6 ~= -2 then
		SetD(arg_143_0, arg_143_1, 4, arg_143_6)
	end

	if arg_143_7 ~= -2 then
		SetD(arg_143_0, arg_143_1, 5, arg_143_7)
	end

	if arg_143_8 ~= -2 then
		SetD(arg_143_0, arg_143_1, 6, arg_143_8)
	end

	if arg_143_9 ~= -2 then
		SetD(arg_143_0, arg_143_1, 7, arg_143_9)
	end

	if arg_143_10 ~= -2 then
		SetD(arg_143_0, arg_143_1, 8, arg_143_10)
	end

	if arg_143_11 ~= -2 and arg_143_12 ~= -2 and arg_143_11 > 0 and arg_143_12 > 0 then
		SetS(arg_143_0, GetD(arg_143_0, arg_143_1, 9), GetD(arg_143_0, arg_143_1, 10), 3, -1)
		SetD(arg_143_0, arg_143_1, 9, arg_143_11)
		SetD(arg_143_0, arg_143_1, 10, arg_143_12)
		SetS(arg_143_0, GetD(arg_143_0, arg_143_1, 9), GetD(arg_143_0, arg_143_1, 10), 3, arg_143_1)
	end
end

function addevent(arg_144_0, arg_144_1, arg_144_2, arg_144_3, arg_144_4, arg_144_5, arg_144_6, arg_144_7)
	if JY.Restart == 1 then
		return
	end

	if arg_144_6 == nil then
		arg_144_6 = -2
	end

	if arg_144_7 == nil then
		arg_144_7 = -2
	end

	if arg_144_5 == nil then
		arg_144_5 = -2
	end

	if arg_144_4 == nil then
		arg_144_4 = 1
	end

	if arg_144_3 == nil then
		arg_144_3 = -2
	end

	if arg_144_2 == nil then
		arg_144_2 = -2
	end

	if arg_144_4 == 1 then
		instruct_3(arg_144_0, arg_144_1, arg_144_2, 0, arg_144_3, 0, 0, arg_144_5, arg_144_5, arg_144_5, -2, arg_144_6, arg_144_7)
	elseif arg_144_4 == 2 then
		instruct_3(arg_144_0, arg_144_1, arg_144_2, 0, 0, arg_144_3, 0, arg_144_5, arg_144_5, arg_144_5, -2, arg_144_6, arg_144_7)
	else
		instruct_3(arg_144_0, arg_144_1, arg_144_2, 0, 0, 0, arg_144_3, arg_144_5, arg_144_5, arg_144_5, -2, arg_144_6, arg_144_7)
	end
end

function null(arg_145_0, arg_145_1)
	addevent(arg_145_0, arg_145_1, 0, 0, 0, 0)
end

function instruct_4(arg_146_0)
	if JY.CurrentThing == arg_146_0 then
		return true
	else
		return false
	end
end

function instruct_5()
	return DrawStrBoxYesNo(-1, -1, "是否与之过招(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_6(arg_148_0, arg_148_1, arg_148_2, arg_148_3)
	return WarMain(arg_148_0, arg_148_3)
end

function instruct_7()
	instruct_test("指令7测试")
end

function instruct_8(arg_150_0)
	JY.MmapMusic = arg_150_0
end

function instruct_9()
	return DrawStrBoxYesNo(-1, -1, "是否要求加入(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_10(arg_152_0)
	if JY.Person[arg_152_0] == nil then
		lib.Debug("instruct_10 error: person id not exist")

		return
	end

	local var_152_0 = 0

	for iter_152_0 = 2, CC.TeamNum do
		if JY.Base["队伍" .. iter_152_0] < 0 then
			JY.Base["队伍" .. iter_152_0] = arg_152_0
			JY.Person[arg_152_0].无用1 = 0
			var_152_0 = 1

			break
		end
	end

	if arg_152_0 == 49 then
		AddPersonAttrib(0, "气运", 2)
	elseif arg_152_0 == 53 then
		AddPersonAttrib(0, "气运", 1)
	elseif arg_152_0 == 48 then
		AddPersonAttrib(0, "气运", 1)
	elseif arg_152_0 == 38 then
		AddPersonAttrib(0, "气运", 1)
	elseif arg_152_0 == 9 then
		AddPersonAttrib(0, "气运", 1)
	elseif arg_152_0 == 600 then
		AddPersonAttrib(0, "气运", 3)
	elseif arg_152_0 == 36 then
		AddPersonAttrib(0, "气运", -2)
	elseif arg_152_0 == 37 then
		AddPersonAttrib(0, "气运", -1)
	elseif arg_152_0 == 86 then
		AddPersonAttrib(0, "气运", -1)
	end

	if JY.Person[0].气运 < 0 then
		JY.Person[0].气运 = 0
	end

	if var_152_0 == 0 then
		lib.Debug("instruct_10 error: 加入队伍已满")

		return
	end
end

function meet_self(arg_153_0)
	if JY.Base.畅想编号 > 0 and JY.Base.畅想编号 == arg_153_0 then
		say("（咦，这个人和我长得好像）", 0, 1)
		say("你感觉似乎冥冥中自己和对方有一些关联", 0, 2)
		say("（果然奇异，不过世界之大，和我长得像的人是有的）", 0, 1)
		say("（和我名字一样的人也是有的，然而我就是我，我是独一无二的）", 0, 1)
		say("你坚定了自己的信念，似乎冥冥中有什么东西改变了", 0, 2)

		JY.Person[0].姓名 = JY.Person[0].姓名 .. ".天命"
	end
end

function fight_self(arg_154_0)
	if JY.Base.畅想编号 > 0 and JY.Base.畅想编号 == arg_154_0 then
		say("打败了这个和你极为相似的人，你只感觉心情愉悦", 0, 2)
		say("似乎冥冥中有什么东西改变了", 0, 2)
		AddPersonAttrib(0, "攻击力", 1)
		AddPersonAttrib(0, "防御力", 1)
		AddPersonAttrib(0, "轻功", 1)
	end
end

function chongwu_choice(arg_155_0)
	lib.GetKey()

	local var_155_0 = 50
	local var_155_1 = 30
	local var_155_2 = var_155_1 * var_155_0 / 2 + 2 * CC.MenuBorderPixel
	local var_155_3 = var_155_1 + 2 * CC.MenuBorderPixel
	local var_155_4 = -1
	local var_155_5 = -1

	if var_155_4 == -1 then
		var_155_4 = (CC.ScreenW - var_155_1 / 2 * var_155_0 - 2 * CC.MenuBorderPixel) / 2
	end

	if var_155_5 == -1 then
		var_155_5 = (CC.ScreenH - var_155_1 - 2 * CC.MenuBorderPixel) / 2
	end

	Cls()

	local var_155_6 = 761
	local var_155_7 = 765
	local var_155_8 = 769

	DrawStrBox(-1, -1, "给你的宠物选一个位置", C_WHITE, var_155_1)

	local var_155_9 = {
		{
			"第一宠物",
			nil,
			1
		},
		{
			"第二宠物",
			nil,
			2
		},
		{
			"第三宠物",
			nil,
			3
		},
		{
			"第四宠物",
			nil,
			4
		}
	}
	local var_155_10 = ShowMenu(var_155_9, 4, 0, var_155_4 + var_155_2 - 4 * var_155_1 - 2 * CC.MenuBorderPixel, var_155_5 + var_155_3 + CC.MenuBorderPixel, 0, 0, 1, 0, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_155_10 == 1 then
		if arg_155_0 == 1 then
			var_155_6 = 761
			JY.Base.宠物1 = var_155_6
		elseif arg_155_0 == 2 then
			var_155_7 = 765
			JY.Base.宠物1 = var_155_7
		elseif arg_155_0 == 3 then
			var_155_8 = 769
			JY.Base.宠物1 = var_155_8
		end
	elseif var_155_10 == 2 then
		if arg_155_0 == 1 then
			var_155_6 = 762
			JY.Base.宠物2 = var_155_6
		elseif arg_155_0 == 2 then
			var_155_7 = 766
			JY.Base.宠物2 = var_155_7
		elseif arg_155_0 == 3 then
			var_155_8 = 770
			JY.Base.宠物2 = var_155_8
		end
	elseif var_155_10 == 3 then
		if arg_155_0 == 1 then
			var_155_6 = 763
			JY.Base.宠物3 = var_155_6
		elseif arg_155_0 == 2 then
			var_155_7 = 767
			JY.Base.宠物3 = var_155_7
		elseif arg_155_0 == 3 then
			var_155_8 = 771
			JY.Base.宠物3 = var_155_8
		end
	elseif var_155_10 == 4 then
		if arg_155_0 == 1 then
			var_155_6 = 764
			JY.Base.宠物4 = var_155_6
		elseif arg_155_0 == 2 then
			var_155_7 = 768
			JY.Base.宠物4 = var_155_7
		elseif arg_155_0 == 3 then
			var_155_8 = 772
			JY.Base.宠物4 = var_155_8
		end
	end

	JY.Person[var_155_6].生命 = 50 + Rnd(20) + JY.Person[0].驱虫术
	JY.Person[var_155_6].生命最大值 = 50 + Rnd(20) + JY.Person[0].驱虫术
	JY.Person[var_155_6].攻击带毒 = 20 + Rnd(50)
	JY.Person[var_155_7].生命 = 400 + Rnd(50) + JY.Person[0].驱虫术
	JY.Person[var_155_7].生命最大值 = 400 + Rnd(50) + JY.Person[0].驱虫术
	JY.Person[var_155_8].生命增长 = 17
	JY.Person[var_155_8].生命 = 600 + Rnd(50) + JY.Person[0].驱虫术
	JY.Person[var_155_8].生命最大值 = 600 + Rnd(50) + JY.Person[0].驱虫术
	JY.Person[var_155_8].攻击带毒 = 20 + Rnd(20)
end

function instruct_11()
	return DrawStrBoxYesNo(-1, -1, "是否(Y/N)?", C_ORANGE, CC.DefaultFont)
end

function instruct_12(arg_157_0)
	for iter_157_0 = 1, CC.TeamNum do
		local var_157_0 = JY.Base["队伍" .. iter_157_0]

		if var_157_0 >= 0 then
			if JY.Person[var_157_0].受伤程度 > 5 then
				AddPersonAttrib(var_157_0, "受伤程度", -5)
			end

			AddPersonAttrib(var_157_0, "体力", math.huge)

			if JY.Person[var_157_0].生命 < JY.Person[var_157_0].生命增长 * 90 then
				AddPersonAttrib(var_157_0, "生命", JY.Person[var_157_0].生命增长 * 10)
			end

			AddPersonAttrib(var_157_0, "内力", 100)
		end
	end
end

function yesno(arg_158_0)
	return DrawStrBoxYesNo(-1, -1, arg_158_0, C_WHITE, 30)
end

function instruct_13()
	Cls()

	JY.Darkness = 0

	lib.ShowSlow(50, 0)
	lib.GetKey()
end

function instruct_14()
	lib.ShowSlow(50, 1)

	JY.Darkness = 1
end

function dark()
	instruct_14()
end

function light()
	instruct_13()
end

function instruct_15()
	JY.Status = GAME_DEAD

	Cls()
	DrawString(CC.GameOverX, CC.GameOverY, JY.Person[JY.Base.队伍1].姓名, RGB(0, 0, 0), CC.DefaultFont)

	local var_163_0 = CC.ScreenW - 9 * CC.DefaultFont

	DrawString(var_163_0, 10, os.date("%Y-%m-%d %H:%M"), RGB(216, 20, 24), CC.DefaultFont)
	DrawString(var_163_0, 10 + CC.DefaultFont + CC.RowPixel, "在地球的某处", RGB(216, 20, 24), CC.DefaultFont)
	DrawString(var_163_0, 10 + (CC.DefaultFont + CC.RowPixel) * 2, "当地人口的失踪数", RGB(216, 20, 24), CC.DefaultFont)
	DrawString(var_163_0, 10 + (CC.DefaultFont + CC.RowPixel) * 3, "又多了一笔。。。", RGB(216, 20, 24), CC.DefaultFont)

	local var_163_1 = {
		{
			"选择读档",
			nil,
			1
		},
		{
			"回家睡觉去",
			nil,
			1
		}
	}
	local var_163_2 = CC.ScreenH - 4 * (CC.DefaultFont + CC.RowPixel) - 10

	if ShowMenu(var_163_1, #var_163_1, 0, var_163_0, var_163_2, 0, 0, 0, 0, CC.DefaultFont, C_ORANGE, C_WHITE) == 1 then
		local var_163_3 = (CC.ScreenW - 25 * CC.FontSmall3 - 2 * CC.MenuBorderPixel) / 3
		local var_163_4 = (CC.ScreenH - 1 * (CC.FontSmall3 + CC.RowPixel)) / 3

		DrawStrBox(var_163_3, var_163_4, string.format("%-6s %-10s %-2s %6s %12s %-6s %-10s", "存档", "姓名", "年龄", "门派", "", "位置", "难度"), C_ORANGE, CC.FontSmall3, C_GOLD)

		local var_163_5 = SaveList()

		if var_163_5 < 1 then
			return instruct_15()
		end

		Cls()
		DrawStrBox(-1, CC.StartMenuY, "请稍候...", C_GOLD, CC.DefaultFont)
		ShowScreen()

		if LoadRecord(var_163_5) ~= nil then
			return 0
		end

		if JY.Base.存档标识 ~= -1 then
			if JY.SubScene < 0 then
				CleanMemory()
				lib.UnloadMMap()
			end

			lib.PicInit()
			lib.ShowSlow(50, 1)

			JY.Status = GAME_SMAP
			JY.SubScene = JY.Base.存档标识
			JY.MmapMusic = -1
			JY.MyPic = GetMyPic()

			Init_SMap(1)
		else
			JY.SubScene = -1
			JY.Status = GAME_FIRSTMMAP
		end
	else
		JY.Status = GAME_END

		return 1
	end
end

function instruct_16(arg_164_0)
	local var_164_0 = false

	for iter_164_0 = 1, CC.TeamNum do
		if arg_164_0 == JY.Base["队伍" .. iter_164_0] then
			var_164_0 = true

			break
		end
	end

	return var_164_0
end

function inteam(arg_165_0)
	local var_165_0 = false

	for iter_165_0 = 1, CC.TeamNum do
		if arg_165_0 == JY.Base["队伍" .. iter_165_0] then
			var_165_0 = true

			break
		end
	end

	return var_165_0
end

function isteam(arg_166_0)
	local var_166_0 = false

	for iter_166_0, iter_166_1 in pairs(CC.PersonExit) do
		if iter_166_1[1] == arg_166_0 then
			var_166_0 = true

			break
		end
	end

	if arg_166_0 == 0 then
		var_166_0 = true
	end

	return var_166_0
end

function PersonKF(arg_167_0, arg_167_1)
	for iter_167_0 = 1, CC.Kungfunum do
		if JY.Person[arg_167_0]["武功" .. iter_167_0] == arg_167_1 then
			return true
		end
	end

	return false
end

function PersonKFJ(arg_168_0, arg_168_1)
	for iter_168_0 = 1, CC.Kungfunum do
		if JY.Person[arg_168_0]["武功" .. iter_168_0] == arg_168_1 and JY.Person[arg_168_0]["武功等级" .. iter_168_0] >= 999 then
			return true
		end
	end

	return false
end

function wgj_num(arg_169_0)
	local var_169_0 = 0

	for iter_169_0 = 1, CC.Kungfunum do
		if JY.Person[arg_169_0]["武功等级" .. iter_169_0] == 999 then
			var_169_0 = var_169_0 + 1
		end
	end

	return var_169_0
end

function PersonKFDJ(arg_170_0, arg_170_1)
	local var_170_0 = 0

	for iter_170_0 = 1, CC.Kungfunum do
		if JY.Person[arg_170_0]["武功" .. iter_170_0] == arg_170_1 then
			var_170_0 = JY.Person[arg_170_0]["武功等级" .. iter_170_0]
		end
	end

	return var_170_0
end

function PersonKFX(arg_171_0, arg_171_1, arg_171_2)
	for iter_171_0 = 1, CC.Kungfunum do
		if JY.Person[arg_171_0]["武功" .. iter_171_0] == arg_171_1 and arg_171_2 >= JY.Person[arg_171_0]["武功等级" .. iter_171_0] then
			return true
		end
	end

	return false
end

function PersonKFD(arg_172_0, arg_172_1, arg_172_2)
	for iter_172_0 = 1, CC.Kungfunum do
		if JY.Person[arg_172_0]["武功" .. iter_172_0] == arg_172_1 and arg_172_2 <= JY.Person[arg_172_0]["武功等级" .. iter_172_0] then
			return true
		end
	end

	return false
end

function PersonKFS(arg_173_0, arg_173_1, arg_173_2)
	for iter_173_0 = 1, CC.Kungfunum do
		if JY.Person[arg_173_0]["武功" .. iter_173_0] == arg_173_1 then
			JY.Person[arg_173_0]["武功等级" .. iter_173_0] = arg_173_2
		end
	end
end

function instruct_17(arg_174_0, arg_174_1, arg_174_2, arg_174_3, arg_174_4)
	if arg_174_0 == -2 then
		arg_174_0 = JY.SubScene
	end

	SetS(arg_174_0, arg_174_2, arg_174_3, arg_174_1, arg_174_4)
end

function instruct_18(arg_175_0)
	for iter_175_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_175_0] == arg_175_0 then
			return true
		end
	end

	return false
end

function has_thing1(arg_176_0)
	for iter_176_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_176_0] == arg_176_0 then
			return true
		end
	end

	return false
end

function has_thing2(arg_177_0)
	local var_177_0 = 0

	for iter_177_0 = 1, CC.TeamNum do
		local var_177_1 = JY.Base["队伍" .. iter_177_0]
		local var_177_2 = JY.Base["队伍" .. iter_177_0]

		if var_177_2 >= 0 and (JY.Person[var_177_2].修炼物品 == arg_177_0 or JY.Person[var_177_2].武器 == arg_177_0 or JY.Person[var_177_2].防具 == arg_177_0 or JY.Person[var_177_2].饰品 == arg_177_0 or JY.Person[var_177_2].坐骑 == arg_177_0) then
			var_177_0 = var_177_0 + 1
		end
	end

	if var_177_0 > 0 then
		return true
	else
		return false
	end
end

function has_thing(arg_178_0)
	if has_thing1(arg_178_0) == true or has_thing2(arg_178_0) == true then
		return true
	else
		return false
	end
end

function has_something(arg_179_0, arg_179_1)
	for iter_179_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_179_0] == arg_179_0 and arg_179_1 <= JY.Base["物品数量" .. iter_179_0] then
			return true
		end
	end

	return false
end

function hav_anything(arg_180_0, arg_180_1)
	for iter_180_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_180_0] == arg_180_0 and JY.Base["物品数量" .. iter_180_0] == arg_180_1 then
			return true
		end
	end

	return false
end

function ts_num()
	local var_181_0 = 0

	for iter_181_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_181_0] > 143 and JY.Base["物品" .. iter_181_0] < 158 then
			var_181_0 = var_181_0 + 1
		end
	end

	return var_181_0
end

function instruct_19(arg_182_0, arg_182_1)
	JY.Base.人X1 = arg_182_0
	JY.Base.人Y1 = arg_182_1
	JY.SubSceneX = 0
	JY.SubSceneY = 0
end

function instruct_20()
	if JY.Base["队伍" .. CC.TeamNum] >= 0 then
		return true
	end

	return false
end

function instruct_21(arg_184_0)
	if JY.Person[arg_184_0] == nil then
		lib.Debug("instruct_21 error: personid not exist")

		return
	end

	local var_184_0 = 0

	for iter_184_0 = 2, CC.TeamNum do
		if arg_184_0 == JY.Base["队伍" .. iter_184_0] then
			var_184_0 = iter_184_0
		end
	end

	if var_184_0 == 0 then
		return
	end

	for iter_184_1 = var_184_0 + 1, CC.TeamNum do
		JY.Base["队伍" .. iter_184_1 - 1] = JY.Base["队伍" .. iter_184_1]
		JY.Person[arg_184_0].无用1 = 1
	end

	JY.Base["队伍" .. CC.TeamNum] = -1

	if JY.Person[arg_184_0].武器 >= 0 then
		if JY.Thing[JY.Person[arg_184_0].武器].使用人 >= 0 then
			addthing(JY.Person[arg_184_0].武器, -1)
		end

		addthing(JY.Person[arg_184_0].武器)

		JY.Thing[JY.Person[arg_184_0].武器].使用人 = -1
		JY.Person[arg_184_0].武器 = -1
	end

	if JY.Person[arg_184_0].防具 >= 0 then
		if JY.Thing[JY.Person[arg_184_0].防具].使用人 >= 0 then
			addthing(JY.Person[arg_184_0].防具, -1)
		end

		addthing(JY.Person[arg_184_0].防具)

		JY.Thing[JY.Person[arg_184_0].防具].使用人 = -1
		JY.Person[arg_184_0].防具 = -1
	end

	if JY.Person[arg_184_0].饰品 >= 0 then
		if JY.Thing[JY.Person[arg_184_0].饰品].使用人 >= 0 then
			addthing(JY.Person[arg_184_0].饰品, -1)
		end

		addthing(JY.Person[arg_184_0].饰品)

		JY.Thing[JY.Person[arg_184_0].饰品].使用人 = -1
		JY.Person[arg_184_0].饰品 = -1
	end

	if JY.Person[arg_184_0].坐骑 >= 0 then
		if JY.Thing[JY.Person[arg_184_0].坐骑].使用人 >= 0 then
			addthing(JY.Person[arg_184_0].坐骑, -1)
		end

		addthing(JY.Person[arg_184_0].坐骑)

		JY.Thing[JY.Person[arg_184_0].坐骑].使用人 = -1
		JY.Person[arg_184_0].坐骑 = -1
	end

	if JY.Person[arg_184_0].修炼物品 >= 0 then
		JY.Thing[JY.Person[arg_184_0].修炼物品].使用人 = -1
	end

	JY.Person[arg_184_0].物品修炼点数 = 0

	if arg_184_0 == 49 then
		AddPersonAttrib(0, "气运", -2)
	elseif arg_184_0 == 53 then
		AddPersonAttrib(0, "气运", -1)
	elseif arg_184_0 == 48 then
		AddPersonAttrib(0, "气运", -1)
	elseif arg_184_0 == 38 then
		AddPersonAttrib(0, "气运", -1)
	elseif arg_184_0 == 9 then
		AddPersonAttrib(0, "气运", -1)
	elseif arg_184_0 == 600 then
		AddPersonAttrib(0, "气运", -3)
	elseif arg_184_0 == 36 then
		AddPersonAttrib(0, "气运", 2)
	elseif arg_184_0 == 37 then
		AddPersonAttrib(0, "气运", 1)
	elseif arg_184_0 == 86 then
		AddPersonAttrib(0, "气运", 1)
	end

	if JY.Person[0].气运 < 0 then
		JY.Person[0].气运 = 0
	end
end

function instruct_22()
	for iter_185_0 = 1, CC.TeamNum do
		if JY.Base["队伍" .. iter_185_0] >= 0 then
			JY.Person[JY.Base["队伍" .. iter_185_0]].内力 = 0
		end
	end
end

function instruct_23(arg_186_0, arg_186_1)
	JY.Person[arg_186_0].用毒能力 = arg_186_1

	AddPersonAttrib(arg_186_0, "用毒能力", 0)
end

function instruct_24()
	instruct_test("指令24测试")
end

function instruct_25(arg_188_0, arg_188_1, arg_188_2, arg_188_3)
	local var_188_0

	if arg_188_1 ~= arg_188_3 then
		local var_188_1 = arg_188_3 < arg_188_1 and -1 or 1

		for iter_188_0 = arg_188_1 + var_188_1, arg_188_3, var_188_1 do
			local var_188_2 = lib.GetTime()

			JY.SubSceneY = JY.SubSceneY + var_188_1

			DrawSMap()
			ShowScreen()

			local var_188_3 = lib.GetTime()

			if var_188_3 - var_188_2 < CC.SceneMoveFrame then
				lib.Delay(CC.SceneMoveFrame - (var_188_3 - var_188_2))
			end
		end
	end

	if arg_188_0 ~= arg_188_2 then
		local var_188_4 = arg_188_2 < arg_188_0 and -1 or 1

		for iter_188_1 = arg_188_0 + var_188_4, arg_188_2, var_188_4 do
			local var_188_5 = lib.GetTime()

			JY.SubSceneX = JY.SubSceneX + var_188_4

			DrawSMap()
			ShowScreen()

			local var_188_6 = lib.GetTime()

			if var_188_6 - var_188_5 < CC.SceneMoveFrame then
				lib.Delay(CC.SceneMoveFrame - (var_188_6 - var_188_5))
			end
		end
	end
end

function instruct_26(arg_189_0, arg_189_1, arg_189_2, arg_189_3, arg_189_4)
	if arg_189_0 == -2 then
		arg_189_0 = JY.SubScene
	end

	local var_189_0 = GetD(arg_189_0, arg_189_1, 2)

	SetD(arg_189_0, arg_189_1, 2, var_189_0 + arg_189_2)

	local var_189_1 = GetD(arg_189_0, arg_189_1, 3)

	SetD(arg_189_0, arg_189_1, 3, var_189_1 + arg_189_3)

	local var_189_2 = GetD(arg_189_0, arg_189_1, 4)

	SetD(arg_189_0, arg_189_1, 4, var_189_2 + arg_189_4)
end

function instruct_27(arg_190_0, arg_190_1, arg_190_2)
	local var_190_0
	local var_190_1
	local var_190_2

	if arg_190_0 ~= -1 then
		var_190_0 = GetD(JY.SubScene, arg_190_0, 5)
		var_190_1 = GetD(JY.SubScene, arg_190_0, 6)
		var_190_2 = GetD(JY.SubScene, arg_190_0, 7)
	end

	for iter_190_0 = arg_190_1, arg_190_2, 2 do
		local var_190_3 = lib.GetTime()

		if arg_190_0 == -1 then
			JY.MyPic = iter_190_0 / 2
		else
			SetD(JY.SubScene, arg_190_0, 5, iter_190_0)
			SetD(JY.SubScene, arg_190_0, 6, iter_190_0)
			SetD(JY.SubScene, arg_190_0, 7, iter_190_0)
		end

		DtoSMap()
		DrawSMap()
		ShowScreen()

		local var_190_4 = lib.GetTime()

		if var_190_4 - var_190_3 < CC.AnimationFrame then
			lib.Delay(CC.AnimationFrame - (var_190_4 - var_190_3))
		end
	end

	if arg_190_0 ~= -1 then
		SetD(JY.SubScene, arg_190_0, 5, var_190_0)
		SetD(JY.SubScene, arg_190_0, 6, var_190_1)
		SetD(JY.SubScene, arg_190_0, 7, var_190_2)
	end
end

function instruct_28(arg_191_0, arg_191_1, arg_191_2)
	local var_191_0 = JY.Person[arg_191_0].品德

	if arg_191_1 <= var_191_0 and var_191_0 <= arg_191_2 then
		return true
	else
		return false
	end
end

function Person_js(arg_192_0)
	local var_192_0 = JY.Person[arg_192_0]
	local var_192_1 = var_192_0.精神
	local var_192_2 = 0
	local var_192_3 = 0
	local var_192_4 = 0

	if var_192_0.武器 > -1 then
		var_192_2 = JY.Thing[var_192_0.武器].加精神
	else
		var_192_2 = 0
	end

	if var_192_0.防具 > -1 then
		var_192_3 = JY.Thing[var_192_0.防具].加精神
	else
		var_192_3 = 0
	end

	if var_192_0.饰品 > -1 then
		var_192_4 = JY.Thing[var_192_0.饰品].加精神
	else
		var_192_4 = 0
	end

	return var_192_1 + var_192_2 + var_192_3 + var_192_4
end

function Person_ml(arg_193_0)
	local var_193_0 = JY.Person[arg_193_0]
	local var_193_1 = var_193_0.魅力
	local var_193_2 = 0
	local var_193_3 = 0
	local var_193_4 = 0

	if var_193_0.武器 > -1 then
		var_193_2 = JY.Thing[var_193_0.武器].加魅力
	else
		var_193_2 = 0
	end

	if var_193_0.防具 > -1 then
		var_193_3 = JY.Thing[var_193_0.防具].加魅力
	else
		var_193_3 = 0
	end

	if var_193_0.饰品 > -1 then
		var_193_4 = JY.Thing[var_193_0.饰品].加魅力
	else
		var_193_4 = 0
	end

	return var_193_1 + var_193_2 + var_193_3 + var_193_4
end

function Person_qy(arg_194_0)
	local var_194_0 = JY.Person[arg_194_0]
	local var_194_1 = var_194_0.气运
	local var_194_2 = 0
	local var_194_3 = 0
	local var_194_4 = 0

	if var_194_0.武器 > -1 then
		var_194_2 = JY.Thing[var_194_0.武器].加气运
	else
		var_194_2 = 0
	end

	if var_194_0.防具 > -1 then
		var_194_3 = JY.Thing[var_194_0.防具].加气运
	else
		var_194_3 = 0
	end

	if var_194_0.饰品 > -1 then
		var_194_4 = JY.Thing[var_194_0.饰品].加气运
	else
		var_194_4 = 0
	end

	return var_194_1 + var_194_2 + var_194_3 + var_194_4
end

function instruct_29(arg_195_0, arg_195_1, arg_195_2)
	local var_195_0 = JY.Person[arg_195_0].攻击力

	if arg_195_1 <= var_195_0 and var_195_0 <= arg_195_2 then
		return true
	else
		return false
	end
end

function instruct_30(arg_196_0, arg_196_1, arg_196_2, arg_196_3)
	if arg_196_0 < arg_196_2 then
		for iter_196_0 = arg_196_0 + 1, arg_196_2 do
			local var_196_0 = lib.GetTime()

			instruct_30_sub1(1)

			local var_196_1 = lib.GetTime()

			if var_196_1 - var_196_0 < CC.PersonMoveFrame then
				lib.Delay(CC.PersonMoveFrame - (var_196_1 - var_196_0))
			end
		end
	elseif arg_196_2 < arg_196_0 then
		for iter_196_1 = arg_196_2 + 1, arg_196_0 do
			local var_196_2 = lib.GetTime()

			instruct_30_sub1(2)

			local var_196_3 = lib.GetTime()

			if var_196_3 - var_196_2 < CC.PersonMoveFrame then
				lib.Delay(CC.PersonMoveFrame - (var_196_3 - var_196_2))
			end
		end
	end

	if arg_196_1 < arg_196_3 then
		for iter_196_2 = arg_196_1 + 1, arg_196_3 do
			local var_196_4 = lib.GetTime()

			instruct_30_sub1(3)

			local var_196_5 = lib.GetTime()

			if var_196_5 - var_196_4 < CC.PersonMoveFrame then
				lib.Delay(CC.PersonMoveFrame - (var_196_5 - var_196_4))
			end
		end
	elseif arg_196_3 < arg_196_1 then
		for iter_196_3 = arg_196_3 + 1, arg_196_1 do
			local var_196_6 = lib.GetTime()

			instruct_30_sub1(0)

			local var_196_7 = lib.GetTime()

			if var_196_7 - var_196_6 < CC.PersonMoveFrame then
				lib.Delay(CC.PersonMoveFrame - (var_196_7 - var_196_6))
			end
		end
	end
end

function instruct_30_sub1(arg_197_0)
	local var_197_0
	local var_197_1

	AddMyCurrentPic()

	local var_197_2 = JY.Base.人X1 + CC.DirectX[arg_197_0 + 1]
	local var_197_3 = JY.Base.人Y1 + CC.DirectY[arg_197_0 + 1]

	JY.Base.人方向 = arg_197_0
	JY.MyPic = GetMyPic()

	DtoSMap()

	if SceneCanPass(var_197_2, var_197_3) == true then
		JY.Base.人X1 = var_197_2
		JY.Base.人Y1 = var_197_3
	end

	JY.Base.人X1 = limitX(JY.Base.人X1, 1, CC.SWidth - 2)
	JY.Base.人Y1 = limitX(JY.Base.人Y1, 1, CC.SHeight - 2)

	DrawSMap()
	ShowScreen()

	return 1
end

function instruct_30_sub(arg_198_0)
	local var_198_0
	local var_198_1
	local var_198_2 = GetS(JY.SubScene, JY.Base.人X1, JY.Base.人Y1, 3)

	if var_198_2 >= 0 and var_198_2 ~= JY.OldDPass then
		EventExecute(var_198_2, 3)

		JY.OldDPass = var_198_2
		JY.oldSMapX = -1
		JY.oldSMapY = -1
		JY.D_Valid = nil
	end

	JY.OldDPass = -1

	local var_198_3 = 0

	if JY.Scene[JY.SubScene].出口X1 == JY.Base.人X1 and JY.Scene[JY.SubScene].出口Y1 == JY.Base.人Y1 or JY.Scene[JY.SubScene].出口X2 ~= JY.Base.人X1 or JY.Scene[JY.SubScene].出口Y2 == JY.Base.人Y1 or JY.Scene[JY.SubScene].出口X3 == JY.Base.人X1 and JY.Scene[JY.SubScene].出口Y3 == JY.Base.人Y1 then
		var_198_3 = 1
	end

	if var_198_3 == 1 then
		JY.Status = GAME_MMAP

		lib.PicInit()
		CleanMemory()
		lib.ShowSlow(50, 1)

		if JY.MmapMusic < 0 then
			JY.MmapMusic = JY.Scene[JY.SubScene].出门音乐
		end

		Init_MMap()

		JY.SubScene = -1
		JY.oldSMapX = -1
		JY.oldSMapY = -1

		lib.DrawMMap(JY.Base.人X, JY.Base.人Y, GetMyPic())
		lib.ShowSlow(50, 0)
		lib.GetKey()

		return
	end

	if JY.Scene[JY.SubScene].跳转场景 >= 0 and JY.Base.人X1 == JY.Scene[JY.SubScene].跳转口X1 and JY.Base.人Y1 == JY.Scene[JY.SubScene].跳转口Y1 then
		JY.SubScene = JY.Scene[JY.SubScene].跳转场景

		lib.ShowSlow(50, 1)

		if JY.Scene[JY.SubScene].外景入口X1 == 0 and JY.Scene[JY.SubScene].外景入口Y1 == 0 then
			JY.Base.人X1 = JY.Scene[JY.SubScene].入口X
			JY.Base.人Y1 = JY.Scene[JY.SubScene].入口Y
		else
			JY.Base.人X1 = JY.Scene[JY.SubScene].跳转口X2
			JY.Base.人Y1 = JY.Scene[JY.SubScene].跳转口Y2
		end

		Init_SMap(1)

		return
	end

	AddMyCurrentPic()

	local var_198_4 = JY.Base.人X1 + CC.DirectX[arg_198_0 + 1]
	local var_198_5 = JY.Base.人Y1 + CC.DirectY[arg_198_0 + 1]

	JY.Base.人方向 = arg_198_0
	JY.MyPic = GetMyPic()

	DtoSMap()

	if SceneCanPass(var_198_4, var_198_5) == true then
		JY.Base.人X1 = var_198_4
		JY.Base.人Y1 = var_198_5
	end

	JY.Base.人X1 = limitX(JY.Base.人X1, 1, CC.SWidth - 2)
	JY.Base.人Y1 = limitX(JY.Base.人Y1, 1, CC.SHeight - 2)

	DrawSMap()
	ShowScreen()

	return 1
end

function instruct_31(arg_199_0)
	local var_199_0 = false

	for iter_199_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_199_0] == CC.MoneyID and arg_199_0 <= JY.Base["物品数量" .. iter_199_0] then
			var_199_0 = true
		end
	end

	return var_199_0
end

function instruct_32(arg_200_0, arg_200_1)
	local var_200_0 = 1

	if arg_200_1 > 32000 then
		arg_200_1 = 32000
	end

	for iter_200_0 = 1, CC.MyThingNum do
		if JY.Base["物品" .. iter_200_0] == arg_200_0 then
			if JY.Base["物品数量" .. iter_200_0] + arg_200_1 > 32000 then
				JY.Base["物品数量" .. iter_200_0] = 32000

				if arg_200_0 == 174 then
					say("身上带的银子太多太重，你已经拿不了更多了", 0, 2)
				end
			else
				JY.Base["物品数量" .. iter_200_0] = JY.Base["物品数量" .. iter_200_0] + arg_200_1
			end

			if arg_200_0 == 174 then
				JY.GOLD = JY.Base["物品数量" .. iter_200_0]
			end

			var_200_0 = iter_200_0

			break
		elseif JY.Base["物品" .. iter_200_0] == -1 then
			JY.Base["物品" .. iter_200_0] = arg_200_0
			JY.Base["物品数量" .. iter_200_0] = arg_200_1

			if arg_200_0 == 174 then
				JY.GOLD = JY.Base["物品数量" .. iter_200_0]
			end

			var_200_0 = iter_200_0

			break
		end
	end

	if JY.Base["物品数量" .. var_200_0] <= 0 then
		for iter_200_1 = var_200_0 + 1, CC.MyThingNum do
			JY.Base["物品" .. iter_200_1 - 1] = JY.Base["物品" .. iter_200_1]
			JY.Base["物品数量" .. iter_200_1 - 1] = JY.Base["物品数量" .. iter_200_1]
		end

		JY.Base["物品" .. CC.MyThingNum] = -1
		JY.Base["物品数量" .. CC.MyThingNum] = 0

		if arg_200_0 == 174 then
			JY.GOLD = JY.Base["物品数量" .. CC.MyThingNum]
		end
	end
end

function addthing(arg_201_0, arg_201_1, arg_201_2)
	if arg_201_1 == nil then
		arg_201_1 = 1
	end

	if arg_201_2 == 1 then
		instruct_32(arg_201_0, arg_201_1)
	else
		instruct_2(arg_201_0, arg_201_1)
	end
end

function instruct_33(arg_202_0, arg_202_1, arg_202_2)
	local var_202_0 = 0

	for iter_202_0 = 1, 11 do
		if JY.Person[arg_202_0]["武功" .. iter_202_0] == 0 then
			JY.Person[arg_202_0]["武功" .. iter_202_0] = arg_202_1
			JY.Person[arg_202_0]["武功等级" .. iter_202_0] = 0
			var_202_0 = 1

			break
		end
	end

	if var_202_0 == 0 then
		JY.Person[arg_202_0].武功10 = arg_202_1
		JY.Person[arg_202_0].武功等级10 = 0
	end

	if arg_202_2 == 0 then
		DrawStrBoxWaitKey(string.format("%s 学会武功 %s", JY.Person[arg_202_0].姓名, JY.Wugong[arg_202_1].名称), C_ORANGE, CC.DefaultFont)
	end
end

function instruct_34(arg_203_0, arg_203_1)
	local var_203_0, var_203_1 = AddPersonAttrib(arg_203_0, "悟性", arg_203_1)

	DrawStrBoxWaitKey(JY.Person[arg_203_0].姓名 .. var_203_1, C_ORANGE, CC.DefaultFont)
end

function instruct_35(arg_204_0, arg_204_1, arg_204_2, arg_204_3)
	if arg_204_1 >= 0 then
		JY.Person[arg_204_0]["武功" .. arg_204_1 + 1] = arg_204_2
		JY.Person[arg_204_0]["武功等级" .. arg_204_1 + 1] = arg_204_3
	else
		local var_204_0 = 0

		for iter_204_0 = 1, CC.Kungfunum do
			if JY.Person[arg_204_0]["武功" .. iter_204_0] == 0 then
				var_204_0 = 1
				JY.Person[arg_204_0]["武功" .. iter_204_0] = arg_204_2
				JY.Person[arg_204_0]["武功等级" .. iter_204_0] = arg_204_3

				return
			end
		end

		if var_204_0 == 0 then
			JY.Person[arg_204_0]["武功" .. 1] = arg_204_2
			JY.Person[arg_204_0]["武功等级" .. 1] = arg_204_3
		end
	end
end

function instruct_36(arg_205_0)
	if JY.Person[JY.Base.队伍1].性别 == arg_205_0 then
		return true
	else
		return false
	end
end

function instruct_37(arg_206_0)
	AddPersonAttrib(0, "品德", arg_206_0)

	local var_206_0 = (CC.ScreenH - 10 - 2 * CC.MenuBorderPixel) / 2

	if arg_206_0 > 0 then
		NewDrawString(-1, var_206_0, "你的品德增加了", TG_Red, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
	elseif arg_206_0 < 0 then
		NewDrawString(-1, var_206_0, "你的品德减少了", LightGreen, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
	end
end

function Show_fly(arg_207_0)
	local var_207_0 = JY.Base.人X1
	local var_207_1 = JY.Base.人Y1
	local var_207_2 = GetS(JY.SubScene, var_207_0, var_207_1, 4)
	local var_207_3 = var_207_0 * CC.DefaultFont / 2 + 1
	local var_207_4 = {
		x1 = CC.ScreenW / 2 - var_207_3 / 2 - CC.XScale / 2,
		y1 = CC.YScale + CC.ScreenH / 2 - var_207_2,
		x2 = CC.XScale + CC.ScreenW / 2 + var_207_3,
		y2 = CC.YScale + CC.ScreenH / 2 + CC.DefaultFont + 1
	}
	local var_207_5 = (var_207_4.x2 - var_207_4.x1) * (var_207_4.y2 - var_207_4.y1) + CC.DefaultFont * 4
	local var_207_6 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	local var_207_7

	for iter_207_0 = 5, 18 do
		local var_207_8 = lib.GetTime()
		local var_207_9 = iter_207_0 * 2

		if var_207_7 == 1 and var_207_5 < CC.ScreenW * CC.ScreenH / 2 then
			local var_207_10 = {
				x1 = var_207_4.x1,
				y1 = var_207_4.y1 - var_207_9,
				x2 = var_207_4.x2,
				y2 = var_207_4.y2 - var_207_9
			}
			local var_207_11 = ClipRect(var_207_10)

			if var_207_11 ~= nil then
				lib.SetClip(var_207_11.x1, var_207_11.y1, var_207_11.x2, var_207_11.y2)
				WarDrawMap(0)

				if arg_207_0 ~= nil then
					DrawString(var_207_4.x1 - #arg_207_0 * CC.Fontsmall / 5, var_207_4.y1 - var_207_9 - CC.DefaultFont * 4, arg_207_0, C_WHITE, CC.Fontsmall)
				end
			end
		else
			lib.SetClip(0, 0, CC.ScreenW, CC.ScreenH)
			lib.LoadSur(var_207_6, 0, 0)
		end

		ShowScreen(1)
		lib.SetClip(0, 0, 0, 0)

		local var_207_12 = lib.GetTime()

		if var_207_12 - var_207_8 < CC.Frame then
			lib.Delay(CC.Frame - (var_207_12 - var_207_8))
		end
	end
end

function add_haogan(arg_208_0, arg_208_1)
	local var_208_0 = 0
	local var_208_1 = JY.Person[arg_208_0].好感度 >= 90 and "觉得可以完全信任你" or JY.Person[arg_208_0].好感度 >= 80 and "认为你值得信任" or JY.Person[arg_208_0].好感度 >= 70 and "对你很有好感" or JY.Person[arg_208_0].好感度 >= 60 and "对你略有好感" or JY.Person[arg_208_0].好感度 >= 53 and "对你略有认识" or JY.Person[arg_208_0].好感度 > 50 and "对你略有印象" or JY.Person[arg_208_0].好感度 < 10 and "和你不可戴天" or JY.Person[arg_208_0].好感度 < 20 and "对你颇为痛恨" or JY.Person[arg_208_0].好感度 < 30 and "对你极为厌恶" or JY.Person[arg_208_0].好感度 < 40 and "对你没有好感" or JY.Person[arg_208_0].好感度 < 50 and "不喜欢你" or "和你还不熟悉"

	AddPersonAttrib(arg_208_0, "好感度", arg_208_1)

	local var_208_2 = (CC.ScreenH - 10 - 2 * CC.MenuBorderPixel) / 2

	if arg_208_1 > 0 then
		NewDrawString(-1, var_208_2, "" .. JY.Person[arg_208_0].姓名 .. "对你的好感加" .. arg_208_1, LightGreen, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
		NewDrawString(-1, var_208_2, "" .. JY.Person[arg_208_0].姓名 .. "" .. var_208_1 .. "", LightGreen, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
	else
		NewDrawString(-1, var_208_2, "" .. JY.Person[arg_208_0].姓名 .. "对你的好感减少了" .. arg_208_1, LightGreen, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
		NewDrawString(-1, var_208_2, "" .. JY.Person[arg_208_0].姓名 .. "" .. var_208_1 .. "", LightGreen, 30)
		ShowScreen()
		lib.Delay(800)
		Cls()
	end
end

function add_mpgx(arg_209_0, arg_209_1)
	AddPersonAttrib(arg_209_0, "门派贡献", arg_209_1)

	local var_209_0 = (CC.ScreenH - 10 - 2 * CC.MenuBorderPixel) / 2

	NewDrawString(-1, var_209_0, "你的门派贡献增加了" .. arg_209_1, Dark_Gold, 30)
	ShowScreen()
	lib.Delay(800)
	Cls()
end

function instruct_38(arg_210_0, arg_210_1, arg_210_2, arg_210_3)
	if arg_210_0 == -2 then
		arg_210_0 = JY.SubScene
	end

	for iter_210_0 = 0, CC.SWidth - 1 do
		for iter_210_1 = 1, CC.SHeight - 1 do
			if GetS(arg_210_0, iter_210_0, iter_210_1, arg_210_1) == arg_210_2 then
				SetS(arg_210_0, iter_210_0, iter_210_1, arg_210_1, arg_210_3)
			end
		end
	end
end

function instruct_39(arg_211_0)
	JY.Scene[arg_211_0].进入条件 = 0
end

function instruct_40(arg_212_0)
	JY.Base.人方向 = arg_212_0
	JY.MyPic = GetMyPic()
end

function instruct_41(arg_213_0, arg_213_1, arg_213_2)
	local var_213_0 = 0

	for iter_213_0 = 1, 4 do
		if JY.Person[arg_213_0]["携带物品" .. iter_213_0] == arg_213_1 then
			JY.Person[arg_213_0]["携带物品数量" .. iter_213_0] = JY.Person[arg_213_0]["携带物品数量" .. iter_213_0] + arg_213_2
			var_213_0 = iter_213_0

			break
		end
	end

	if var_213_0 > 0 and JY.Person[arg_213_0]["携带物品数量" .. var_213_0] <= 0 then
		JY.Person[arg_213_0]["携带物品" .. var_213_0] = -1
	end

	if var_213_0 == 0 then
		for iter_213_1 = 1, 4 do
			if JY.Person[arg_213_0]["携带物品" .. iter_213_1] == -1 then
				JY.Person[arg_213_0]["携带物品" .. iter_213_1] = arg_213_1
				JY.Person[arg_213_0]["携带物品数量" .. iter_213_1] = arg_213_2

				break
			end
		end
	end
end

function instruct_42()
	local var_214_0 = false

	for iter_214_0 = 1, CC.TeamNum do
		if JY.Base["队伍" .. iter_214_0] >= 0 and JY.Person[JY.Base["队伍" .. iter_214_0]].性别 == 1 then
			var_214_0 = true
		end
	end

	return var_214_0
end

function nv_num()
	local var_215_0 = 0

	for iter_215_0 = 1, CC.TeamNum do
		if JY.Base["队伍" .. iter_215_0] >= 0 and JY.Person[JY.Base["队伍" .. iter_215_0]].性别 == 1 then
			var_215_0 = iter_215_0
		end
	end

	return var_215_0
end

function instruct_44(arg_216_0, arg_216_1, arg_216_2, arg_216_3, arg_216_4, arg_216_5)
	local var_216_0 = GetD(JY.SubScene, arg_216_0, 5)
	local var_216_1 = GetD(JY.SubScene, arg_216_0, 6)
	local var_216_2 = GetD(JY.SubScene, arg_216_0, 7)
	local var_216_3 = GetD(JY.SubScene, arg_216_3, 5)
	local var_216_4 = GetD(JY.SubScene, arg_216_3, 6)
	local var_216_5 = GetD(JY.SubScene, arg_216_3, 7)

	for iter_216_0 = arg_216_1, arg_216_2, 2 do
		local var_216_6 = lib.GetTime()

		if arg_216_0 == -1 then
			JY.MyPic = iter_216_0 / 2
		else
			SetD(JY.SubScene, arg_216_0, 5, iter_216_0)
			SetD(JY.SubScene, arg_216_0, 6, iter_216_0)
			SetD(JY.SubScene, arg_216_0, 7, iter_216_0)
		end

		if arg_216_3 == -1 then
			JY.MyPic = iter_216_0 / 2
		else
			SetD(JY.SubScene, arg_216_3, 5, iter_216_0 - arg_216_1 + arg_216_4)
			SetD(JY.SubScene, arg_216_3, 6, iter_216_0 - arg_216_1 + arg_216_4)
			SetD(JY.SubScene, arg_216_3, 7, iter_216_0 - arg_216_1 + arg_216_4)
		end

		DtoSMap()
		DrawSMap()
		ShowScreen()

		local var_216_7 = lib.GetTime()

		if var_216_7 - var_216_6 < CC.AnimationFrame then
			lib.Delay(CC.AnimationFrame - (var_216_7 - var_216_6))
		end
	end

	SetD(JY.SubScene, arg_216_0, 5, var_216_0)
	SetD(JY.SubScene, arg_216_0, 6, var_216_1)
	SetD(JY.SubScene, arg_216_0, 7, var_216_2)
	SetD(JY.SubScene, arg_216_3, 5, var_216_3)
	SetD(JY.SubScene, arg_216_3, 6, var_216_4)
	SetD(JY.SubScene, arg_216_3, 7, var_216_5)
end

function instruct_43(arg_217_0, arg_217_1)
	local var_217_0, var_217_1 = AddPersonAttrib(arg_217_0, "防御力", arg_217_1)
end

function instruct_45(arg_218_0, arg_218_1)
	local var_218_0, var_218_1 = AddPersonAttrib(arg_218_0, "轻功", arg_218_1)
end

function instruct_46(arg_219_0, arg_219_1)
	local var_219_0, var_219_1 = AddPersonAttrib(arg_219_0, "内力最大值", arg_219_1)

	AddPersonAttrib(arg_219_0, "内力", arg_219_1)
end

function instruct_47(arg_220_0, arg_220_1)
	local var_220_0, var_220_1 = AddPersonAttrib(arg_220_0, "攻击力", arg_220_1)
end

function instruct_48(arg_221_0, arg_221_1)
	local var_221_0, var_221_1 = AddPersonAttrib(arg_221_0, "生命最大值", arg_221_1)

	AddPersonAttrib(arg_221_0, "生命", arg_221_1)
end

function instruct_49(arg_222_0, arg_222_1)
	if JY.Base.畅想编号 == arg_222_0 then
		JY.Person[JY.Base.队伍1].内力性质 = arg_222_1
		JY.Person[arg_222_0].内力性质 = arg_222_1
	else
		JY.Person[arg_222_0].内力性质 = arg_222_1
	end
end

function instruct_50(arg_223_0, arg_223_1, arg_223_2, arg_223_3, arg_223_4)
	local var_223_0 = 0

	if instruct_18(arg_223_0) == true then
		var_223_0 = var_223_0 + 1
	end

	if instruct_18(arg_223_1) == true then
		var_223_0 = var_223_0 + 1
	end

	if instruct_18(arg_223_2) == true then
		var_223_0 = var_223_0 + 1
	end

	if instruct_18(arg_223_3) == true then
		var_223_0 = var_223_0 + 1
	end

	if instruct_18(arg_223_4) == true then
		var_223_0 = var_223_0 + 1
	end

	if var_223_0 == 5 then
		return true
	else
		return false
	end
end

function instruct_51()
	instruct_1(2547 + Rnd(18), 114, 0)
end

function instruct_52()
	DrawStrBoxWaitKey(string.format("你现在的品德指数为: %d", JY.Person[0].品德), C_ORANGE, CC.DefaultFont)
end

function instruct_53()
	DrawStrBoxWaitKey(string.format("你现在的声望指数为: %d", JY.Person[0].声望), C_ORANGE, CC.DefaultFont)
end

function instruct_54()
	for iter_227_0 = 0, JY.SceneNum - 1 do
		JY.Scene[iter_227_0].进入条件 = 0
	end

	JY.Scene[2].进入条件 = 2
	JY.Scene[38].进入条件 = 2
	JY.Scene[75].进入条件 = 1
	JY.Scene[80].进入条件 = 1
end

function instruct_55(arg_228_0, arg_228_1)
	if GetD(JY.SubScene, arg_228_0, 2) == arg_228_1 then
		return true
	else
		return false
	end
end

function instruct_56(arg_229_0)
	JY.Person[0].声望 = JY.Person[0].声望 + arg_229_0

	instruct_2_sub()
end

function instruct_57()
	instruct_27(-1, 7664, 7674)

	for iter_230_0 = 0, 56, 2 do
		local var_230_0 = lib.GetTime()

		if JY.MyPic < 3844 then
			JY.MyPic = (7676 + iter_230_0) / 2
		end

		SetD(JY.SubScene, 2, 5, iter_230_0 + 7690)
		SetD(JY.SubScene, 2, 6, iter_230_0 + 7690)
		SetD(JY.SubScene, 2, 7, iter_230_0 + 7690)
		SetD(JY.SubScene, 3, 5, iter_230_0 + 7748)
		SetD(JY.SubScene, 3, 6, iter_230_0 + 7748)
		SetD(JY.SubScene, 3, 7, iter_230_0 + 7748)
		SetD(JY.SubScene, 4, 5, iter_230_0 + 7806)
		SetD(JY.SubScene, 4, 6, iter_230_0 + 7806)
		SetD(JY.SubScene, 4, 7, iter_230_0 + 7806)
		DtoSMap()
		DrawSMap()
		ShowScreen()

		local var_230_1 = lib.GetTime()

		if var_230_1 - var_230_0 < CC.AnimationFrame then
			lib.Delay(CC.AnimationFrame - (var_230_1 - var_230_0))
		end
	end
end

function instruct_58()
	local var_231_0 = 5
	local var_231_1 = 6
	local var_231_2 = 3
	local var_231_3 = 102
	local var_231_4 = {}

	for iter_231_0 = 0, var_231_0 - 1 do
		for iter_231_1 = 0, var_231_1 - 1 do
			var_231_4[iter_231_1] = 0
		end

		for iter_231_2 = 1, var_231_2 do
			local var_231_5

			while true do
				var_231_5 = Rnd(var_231_1)

				if var_231_4[var_231_5] == 0 then
					var_231_4[var_231_5] = 1

					break
				end
			end

			local var_231_6 = var_231_5 + iter_231_0 * var_231_1

			WarLoad(var_231_6 + var_231_3)
			instruct_1(2854 + var_231_6, JY.Person[WAR.Data.敌人1].头像代号, 0)
			instruct_0()

			if WarMain(var_231_6 + var_231_3, 0) == true then
				instruct_0()
				instruct_13()
				TalkEx("还有那位前辈肯赐教？", 0, 1)
				instruct_0()
			else
				instruct_15()

				return
			end
		end

		if iter_231_0 < var_231_0 - 1 then
			TalkEx("少侠已连战三场，*可先休息再战．", 70, 0)
			instruct_0()
			instruct_14()
			lib.Delay(300)

			if JY.Person[0].受伤程度 < 50 and JY.Person[0].中毒程度 <= 0 then
				JY.Person[0].受伤程度 = 0

				AddPersonAttrib(0, "体力", math.huge)
				AddPersonAttrib(0, "内力", math.huge)
				AddPersonAttrib(0, "生命", math.huge)
			end

			instruct_13()
			TalkEx("我已经休息够了，*有谁要再上？", 0, 1)
			instruct_0()
		end
	end

	TalkEx("接下来换谁？**．．．．*．．．．***没有人了吗？", 0, 1)
	instruct_0()
	TalkEx("如果还没有人要出来向这位*少侠挑战，那麽这武功天下*第一之名，武林盟主之位，*就由这位少侠夺得．***．．．．．．*．．．．．．*．．．．．．*好，恭喜少侠，这武林盟主*之位就由少侠获得，而这把*”武林神杖”也由你保管．", 70, 0)
	instruct_0()
	TalkEx("恭喜少侠！", 12, 0)
	instruct_0()
	TalkEx("小兄弟，恭喜你！", 64, 4)
	instruct_0()
	TalkEx("好，今年的武林大会到此已*圆满结束，希望明年各位武*林同道能再到我华山一游．", 19, 0)
	instruct_0()
	instruct_14()

	for iter_231_3 = 24, 72 do
		instruct_3(-2, iter_231_3, 0, 0, -1, -1, -1, -1, -1, -1, -2, -2, -2)
	end

	instruct_0()
	instruct_13()
	TalkEx("历经千辛万苦，我终於打败*群雄，得到这武林盟主之位*及神杖．*但是”圣堂”在那呢？*为什麽没人告诉我，难道大*家都不知道．*这会儿又有的找了．", 0, 1)
	instruct_0()
	instruct_2(143, 1)
end

function instruct_59()
	for iter_232_0 = CC.TeamNum, 2, -1 do
		if JY.Base["队伍" .. iter_232_0] >= 0 then
			instruct_21(JY.Base["队伍" .. iter_232_0])
		end
	end

	for iter_232_1, iter_232_2 in ipairs(CC.AllPersonExit) do
		instruct_3(iter_232_2[1], iter_232_2[2], 0, 0, -1, -1, -1, -1, -1, -1, 0, -2, -2)
	end
end

function instruct_60(arg_233_0, arg_233_1, arg_233_2)
	if arg_233_0 == -2 then
		arg_233_0 = JY.SubScene
	end

	if arg_233_1 == -2 then
		arg_233_1 = JY.CurrentD
	end

	if GetD(arg_233_0, arg_233_1, 5) == arg_233_2 then
		return true
	else
		return false
	end
end

function instruct_61()
	for iter_234_0 = 11, 24 do
		if GetD(JY.SubScene, iter_234_0, 5) ~= 4664 then
			return false
		end
	end

	return true
end

function instruct_62(arg_235_0, arg_235_1, arg_235_2, arg_235_3, arg_235_4, arg_235_5)
	instruct_44(arg_235_0, arg_235_1, arg_235_2, arg_235_3, arg_235_4, arg_235_5)
	ShowScreen()
	lib.Delay(2000)
	say("感谢下载grgame出品的<金庸群侠传：龙启江湖>！选择重新开始可进行下一周目的游戏！", 260, 5, "龙的传人")

	if GetS(53, 0, 1, 5) >= CC.CircleNum - 1 then
		local var_235_0 = string.format("%s&&%d&&%d&&%d\n", JY.Person[JY.Base.队伍1].姓名, JY.Base.主角职业, JY.Base.特殊主角, JY.Base.游戏难度)
		local var_235_1 = io.open(CC.CircleFile, "ab")

		if var_235_1 then
			for iter_235_0 = 1, #var_235_0 do
				var_235_1:write(string.format("%02X", string.byte(string.sub(var_235_0, iter_235_0, iter_235_0))))
			end

			var_235_1:close()
		end
	end

	PlayMIDI(25)
	Cls()
	lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
	ShowScreen()
	lib.Delay(1000)
	DrawStrBoxWaitKey("片尾曲：笑傲江湖", C_WHITE, CC.DefaultFont)
	DrawStrBoxWaitKey("按任意键退出", C_WHITE, CC.DefaultFont)

	JY.Status = GAME_END
end

function gameover()
	Cls()
	PlayMIDI(25)
	lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
	ShowScreen()
	lib.Delay(1000)
	say("感谢下载grgame出品的<金庸群侠传：龙启江湖>！", 260, 5, "龙的传人")
	say("选择重新开始可进行下一周目的游戏！", 1115, 5, "龙的传人")

	if GetS(53, 0, 1, 5) >= CC.CircleNum - 1 then
		local var_236_0 = string.format("%s&&%d&&%d&&%d\n", JY.Person[JY.Base.队伍1].姓名, JY.Base.主角职业, JY.Base.特殊主角, JY.Base.游戏难度)
		local var_236_1 = io.open(CC.CircleFile, "ab")

		if var_236_1 then
			for iter_236_0 = 1, #var_236_0 do
				var_236_1:write(string.format("%02X", string.byte(string.sub(var_236_0, iter_236_0, iter_236_0))))
			end

			var_236_1:close()
		end
	end

	Cls()

	JY.Status = GAME_END
end

function gameover1()
	say("感谢下载grgame出品的<金庸群侠传：龙启江湖>！选择重新开始可进行下一周目的游戏！", 260, 5, "龙的传人")

	if GetS(53, 0, 1, 5) >= CC.CircleNum - 1 then
		local var_237_0 = string.format("%s&&%d&&%d&&%d\n", JY.Person[JY.Base.队伍1].姓名, JY.Base.主角职业, JY.Base.特殊主角, JY.Base.游戏难度)
		local var_237_1 = io.open(CC.CircleFile, "ab")

		if var_237_1 then
			for iter_237_0 = 1, #var_237_0 do
				var_237_1:write(string.format("%02X", string.byte(string.sub(var_237_0, iter_237_0, iter_237_0))))
			end

			var_237_1:close()
		end
	end

	PlayMIDI(25)
	Cls()
	lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
	ShowScreen()
	lib.Delay(1000)
	DrawStrBoxWaitKey("片尾曲：笑傲江湖", C_WHITE, CC.DefaultFont)
	DrawStrBoxWaitKey("按任意键退出", C_WHITE, CC.DefaultFont)

	JY.Status = GAME_END
end

function instruct_63(arg_238_0, arg_238_1)
	JY.Person[arg_238_0].性别 = arg_238_1
end

function instruct_64()
	local var_239_0 = 1040
	local var_239_1 = -1

	for iter_239_0 = 0, JY.ShopNum - 1 do
		if CC.ShopScene[iter_239_0].sceneid == JY.SubScene then
			var_239_1 = iter_239_0
		end
	end

	if var_239_1 < 0 then
		return
	end

	var_239_0 = var_239_1 == 5 and 1007 or var_239_1 == 4 and 1048 or var_239_0

	if var_239_1 == 5 then
		say("这位客人，来看看欧，我这儿卖的可都是好东西。", var_239_0, 0)
	elseif var_239_1 == 4 and inteam(83) then
		say("百药门不欢迎你，赶快离开。", var_239_0, 0)

		return
	else
		say("这位客人，看看有什麽需要*的，小店卖的东西价钱绝*对公道。", var_239_0, 0)
	end

	local var_239_2 = {}

	for iter_239_1 = 1, 6 do
		var_239_2[iter_239_1] = {}

		local var_239_3 = JY.Shop[var_239_1]["物品" .. iter_239_1]

		var_239_2[iter_239_1][1] = string.format("%-12s %5d", JY.Thing[var_239_3].名称, JY.Shop[var_239_1]["物品价格" .. iter_239_1])
		var_239_2[iter_239_1][2] = nil

		if JY.Shop[var_239_1]["物品数量" .. iter_239_1] > 0 then
			var_239_2[iter_239_1][3] = 1
		else
			var_239_2[iter_239_1][3] = 0
		end
	end

	local var_239_4 = (CC.ScreenW - 9 * CC.DefaultFont - 2 * CC.MenuBorderPixel) / 2
	local var_239_5 = (CC.ScreenH - 5 * CC.DefaultFont - 4 * CC.RowPixel - 2 * CC.MenuBorderPixel) / 2
	local var_239_6 = ShowMenu(var_239_2, 6, 0, var_239_4, var_239_5, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_239_6 > 0 then
		Cls()

		local var_239_7 = JY.Shop[var_239_1]["物品数量" .. var_239_6]
		local var_239_8 = InputNum("卖出数量", 1, var_239_7, 1)

		if var_239_8 == nil then
			say("客人，你再多看看，本店都是精选好货。", var_239_0, 0)
		elseif instruct_31(JY.Shop[var_239_1]["物品价格" .. var_239_6] * var_239_8) == false then
			say("非常抱歉，*你身上的钱似乎不够。", var_239_0, 0)
		else
			JY.Shop[var_239_1]["物品数量" .. var_239_6] = JY.Shop[var_239_1]["物品数量" .. var_239_6] - var_239_8

			instruct_32(CC.MoneyID, -JY.Shop[var_239_1]["物品价格" .. var_239_6] * var_239_8)
			instruct_32(JY.Shop[var_239_1]["物品" .. var_239_6], var_239_8)
			say("大爷买了小店的东西，*保证绝不後悔．", var_239_0, 0)
		end
	end

	for iter_239_2, iter_239_3 in ipairs(CC.ShopScene[var_239_1].d_leave) do
		instruct_3(-2, iter_239_3, 0, -2, -1, -1, 939, -1, -1, -1, -2, -2, -2)
	end
end

function wgbook_type(arg_240_0)
	local var_240_0 = JY.Thing[arg_240_0].练出武功
	local var_240_1 = 0

	if var_240_0 > 0 then
		if JY.Wugong[var_240_0].武功类型 == 1 then
			var_240_1 = 1
		end

		if JY.Wugong[var_240_0].武功类型 == 2 then
			var_240_1 = 2
		end

		if JY.Wugong[var_240_0].武功类型 == 3 then
			var_240_1 = 3
		end

		if JY.Wugong[var_240_0].武功类型 == 4 then
			var_240_1 = 4
		end

		if JY.Wugong[var_240_0].武功类型 == 6 then
			var_240_1 = 1
		end

		if JY.Wugong[var_240_0].武功类型 == 7 then
			var_240_1 = 5
		end
	end

	return var_240_1
end

function choice_wp(arg_241_0)
	Cls()
	say("你希望他们学习什么外功？", 514, 0, "护卫")

	local var_241_0 = {
		{
			"武功秘笈",
			nil,
			1
		},
		{
			"放弃",
			nil,
			1
		}
	}
	local var_241_1 = ShowMenu(var_241_0, 2, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_241_1 > 0 then
		local var_241_2 = {}
		local var_241_3 = {}

		for iter_241_0 = 0, CC.MyThingNum - 1 do
			var_241_2[iter_241_0] = -1
			var_241_3[iter_241_0] = 0
		end

		local var_241_4 = 0

		for iter_241_1 = 0, CC.MyThingNum - 1 do
			local var_241_5 = JY.Base["物品" .. iter_241_1 + 1]

			if var_241_5 >= 0 then
				local var_241_6 = 0

				if arg_241_0 == 1 and wgbook_type(var_241_5) > 0 and wgbook_type(var_241_5) < 6 then
					var_241_6 = 1
				end

				if var_241_1 == 1 and var_241_6 == 1 then
					var_241_2[var_241_4] = var_241_5
					var_241_3[var_241_4] = JY.Base["物品数量" .. iter_241_1 + 1]
					var_241_4 = var_241_4 + 1
				end
			end
		end

		local var_241_7 = SelectThing(var_241_2, var_241_3)

		if var_241_7 >= 0 then
			return var_241_7
		end
	end
end

function instruct_65()
	local var_242_0 = -1

	for iter_242_0 = 0, JY.ShopNum - 1 do
		if CC.ShopScene[iter_242_0].sceneid == JY.SubScene then
			var_242_0 = iter_242_0
		end
	end

	if var_242_0 < 0 then
		return
	end

	instruct_3(-2, CC.ShopScene[var_242_0].d_shop, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)

	for iter_242_1, iter_242_2 in ipairs(CC.ShopScene[var_242_0].d_leave) do
		instruct_3(-2, iter_242_2, 0, -2, -1, -1, -1, -1, -1, -1, -2, -2, -2)
	end

	local var_242_1 = var_242_0 + 1

	if var_242_1 >= 5 then
		var_242_1 = 0
	end

	instruct_3(CC.ShopScene[var_242_1].sceneid, CC.ShopScene[var_242_1].d_shop, 1, -2, 938, -1, -1, 8256, 8256, 8256, -2, -2, -2)
end

function instruct_66(arg_243_0)
	PlayMIDI(arg_243_0)
end

function instruct_67(arg_244_0)
	PlayWavAtk(arg_244_0)
end

function JYMsgBox(arg_245_0, arg_245_1, arg_245_2, arg_245_3, arg_245_4, arg_245_5)
	local var_245_0 = {}
	local var_245_1
	local var_245_2
	local var_245_3
	local var_245_4
	local var_245_5 = 0
	local var_245_6 = 0
	local var_245_7
	local var_245_8
	local var_245_9
	local var_245_10
	local var_245_11 = CC.DefaultFont

	if arg_245_4 ~= nil then
		arg_245_4 = arg_245_4 * 2
		var_245_5, var_245_6 = lib.GetPNGXY(1, arg_245_4)
		var_245_5 = var_245_5 + CC.MenuBorderPixel * 2
		var_245_6 = var_245_6 + CC.MenuBorderPixel * 2
	end

	local var_245_12, var_245_13 = Split(arg_245_1, "*")
	local var_245_14 = 0

	for iter_245_0 = 1, var_245_12 do
		local var_245_15 = string.len(var_245_13[iter_245_0])

		if var_245_14 < var_245_15 then
			var_245_14 = var_245_15
		end
	end

	if var_245_14 < 12 then
		var_245_14 = 12
	end

	local var_245_16 = CC.MenuBorderPixel * 2 + math.modf(var_245_11 * var_245_14 / 2) + var_245_5
	local var_245_17 = CC.MenuBorderPixel * 2 + (var_245_11 + CC.MenuBorderPixel) * var_245_12

	if var_245_17 < var_245_6 then
		var_245_17 = var_245_6
	end

	local var_245_18 = var_245_17
	local var_245_19 = var_245_17 + CC.MenuBorderPixel * 2 + var_245_11 * 2
	local var_245_20 = (CC.ScreenW - var_245_16) / 2 + CC.MenuBorderPixel
	local var_245_21 = var_245_20 + var_245_5
	local var_245_22 = (CC.ScreenH - var_245_19) / 2 + CC.MenuBorderPixel + 2 + var_245_11 * 0.7
	local var_245_23 = var_245_18 + var_245_22 - 5
	local var_245_24 = 1

	Cls()
	DrawBoxTitle(var_245_16, var_245_19, arg_245_0, C_GOLD)

	if arg_245_4 ~= nil then
		lib.LoadPNG(1, arg_245_4, var_245_20, var_245_22, 1)
	end

	for iter_245_1 = 1, var_245_12 do
		DrawString(var_245_21, var_245_22 + (CC.MenuBorderPixel + var_245_11) * (iter_245_1 - 1), var_245_13[iter_245_1], C_WHITE, var_245_11)
	end

	local var_245_25 = lib.SaveSur((CC.ScreenW - var_245_16) / 2 - 4, (CC.ScreenH - var_245_19) / 2 - var_245_11, (CC.ScreenW + var_245_16) / 2 + 4, (CC.ScreenH + var_245_19) / 2 + 4)

	while true do
		Cls()
		lib.LoadSur(var_245_25, (CC.ScreenW - var_245_16) / 2 - 4, (CC.ScreenH - var_245_19) / 2 - var_245_11)

		for iter_245_2 = 1, arg_245_3 do
			local var_245_26
			local var_245_27

			if iter_245_2 == var_245_24 then
				var_245_26 = M_Yellow
				var_245_27 = M_DarkOliveGreen
			else
				var_245_26 = M_DarkOliveGreen
			end

			DrawStrBox2((CC.ScreenW - var_245_16) / 2 + var_245_16 * iter_245_2 / (arg_245_3 + 1) - string.len(arg_245_2[iter_245_2]) * var_245_11 / 4, var_245_23, arg_245_2[iter_245_2], var_245_26, var_245_11, var_245_27)
		end

		ShowScreen()

		local var_245_28 = WaitKey(1)

		lib.Delay(CC.Frame)

		if var_245_28 == VK_ESCAPE then
			if arg_245_5 ~= nil and arg_245_5 == 1 then
				var_245_24 = -2

				break
			end
		elseif var_245_28 == VK_LEFT then
			var_245_24 = var_245_24 - 1

			if var_245_24 < 1 then
				var_245_24 = arg_245_3
			end
		elseif var_245_28 == VK_RIGHT then
			var_245_24 = var_245_24 + 1

			if arg_245_3 < var_245_24 then
				var_245_24 = 1
			end
		elseif var_245_28 == VK_RETURN or var_245_28 == VK_SPACE then
			break
		end

		var_245_24 = limitX(var_245_24, 1, arg_245_3)
	end

	lib.FreeSur(var_245_25)

	return var_245_24
end

function JYMsgBox2(arg_246_0, arg_246_1, arg_246_2, arg_246_3, arg_246_4, arg_246_5)
	local var_246_0 = {}
	local var_246_1
	local var_246_2
	local var_246_3
	local var_246_4
	local var_246_5 = 0
	local var_246_6 = 0
	local var_246_7
	local var_246_8
	local var_246_9
	local var_246_10
	local var_246_11 = CC.FontSmall1

	if arg_246_4 ~= nil then
		arg_246_4 = arg_246_4 * 2
		var_246_5, var_246_6 = lib.GetPNGXY(1, arg_246_4)
		var_246_5 = var_246_5 + CC.MenuBorderPixel * 2
		var_246_6 = var_246_6 + CC.MenuBorderPixel * 2
	end

	local var_246_12, var_246_13 = Split(arg_246_1, "*")
	local var_246_14 = 0

	for iter_246_0 = 1, var_246_12 do
		local var_246_15 = string.len(var_246_13[iter_246_0])

		if var_246_14 < var_246_15 then
			var_246_14 = var_246_15
		end
	end

	if var_246_14 < 12 then
		var_246_14 = 12
	end

	local var_246_16 = CC.MenuBorderPixel * 2 + math.modf(var_246_11 * var_246_14 / 2) + var_246_5
	local var_246_17 = CC.MenuBorderPixel * 2 + (var_246_11 + CC.MenuBorderPixel) * var_246_12

	if var_246_17 < var_246_6 then
		var_246_17 = var_246_6
	end

	local var_246_18 = var_246_17
	local var_246_19 = var_246_17 + CC.MenuBorderPixel * 2 + var_246_11 * 2
	local var_246_20 = (CC.ScreenW - var_246_16) / 2 + CC.MenuBorderPixel
	local var_246_21 = var_246_20 + var_246_5
	local var_246_22 = (CC.ScreenH - var_246_19) / 2 + CC.MenuBorderPixel + 2 + var_246_11 * 0.7
	local var_246_23 = var_246_18 + var_246_22 - 5
	local var_246_24 = 1

	Cls()
	DrawBoxTitle(var_246_16, var_246_19, arg_246_0, M_DarkOrange)

	if arg_246_4 ~= nil then
		lib.LoadPNG(1, arg_246_4, var_246_20, var_246_22, 1)
	end

	for iter_246_1 = 1, var_246_12 do
		DrawString(var_246_21, var_246_22 + (CC.MenuBorderPixel + var_246_11) * (iter_246_1 - 1), var_246_13[iter_246_1], C_GOLD, var_246_11)
	end

	local var_246_25 = lib.SaveSur((CC.ScreenW - var_246_16) / 2 - 4, (CC.ScreenH - var_246_19) / 2 - var_246_11, (CC.ScreenW + var_246_16) / 2 + 4, (CC.ScreenH + var_246_19) / 2 + 4)

	while true do
		Cls()
		lib.LoadSur(var_246_25, (CC.ScreenW - var_246_16) / 2 - 4, (CC.ScreenH - var_246_19) / 2 - var_246_11)

		for iter_246_2 = 1, arg_246_3 do
			local var_246_26
			local var_246_27

			if iter_246_2 == var_246_24 then
				local var_246_28 = M_Yellow

				var_246_27 = M_DarkOliveGreen
			else
				local var_246_29 = M_DarkOliveGreen
			end

			DrawStrBox2((CC.ScreenW - var_246_16) / 2 + var_246_16 * iter_246_2 / (arg_246_3 + 1) - string.len(arg_246_2[iter_246_2]) * var_246_11 / 4, var_246_23, arg_246_2[iter_246_2], C_ORANGE, CC.FontSmall3, var_246_27)
		end

		ShowScreen()

		local var_246_30 = WaitKey(1)

		lib.Delay(CC.Frame)

		if var_246_30 == VK_ESCAPE then
			if arg_246_5 ~= nil and arg_246_5 == 1 then
				var_246_24 = -2

				break
			end
		elseif var_246_30 == VK_LEFT then
			var_246_24 = var_246_24 - 1

			if var_246_24 < 1 then
				var_246_24 = arg_246_3
			end
		elseif var_246_30 == VK_RIGHT then
			var_246_24 = var_246_24 + 1

			if arg_246_3 < var_246_24 then
				var_246_24 = 1
			end
		elseif var_246_30 == VK_RETURN or var_246_30 == VK_SPACE then
			break
		end

		var_246_24 = limitX(var_246_24, 1, arg_246_3)
	end

	lib.FreeSur(var_246_25)

	return var_246_24
end

function DrawBoxTitle(arg_247_0, arg_247_1, arg_247_2, arg_247_3)
	local var_247_0 = 4
	local var_247_1
	local var_247_2
	local var_247_3
	local var_247_4
	local var_247_5
	local var_247_6
	local var_247_7 = var_247_0 + CC.DefaultFont
	local var_247_8 = string.len(arg_247_2) * var_247_7 / 2
	local var_247_9 = (CC.ScreenW - arg_247_0) / 2
	local var_247_10 = (CC.ScreenW + arg_247_0) / 2
	local var_247_11 = (CC.ScreenH - arg_247_1) / 2
	local var_247_12 = (CC.ScreenH + arg_247_1) / 2
	local var_247_13 = (CC.ScreenW - var_247_8) / 2
	local var_247_14 = (CC.ScreenW + var_247_8) / 2

	lib.Background(var_247_9, var_247_11 + var_247_0, var_247_9 + var_247_0, var_247_12 - var_247_0, 128)
	lib.Background(var_247_9 + var_247_0, var_247_11, var_247_10 - var_247_0, var_247_12, 128)
	lib.Background(var_247_10 - var_247_0, var_247_11 + var_247_0, var_247_10, var_247_12 - var_247_0, 128)
	lib.Background(var_247_13, var_247_11 - var_247_7 / 2 + var_247_0, var_247_14, var_247_11, 128)
	lib.Background(var_247_13 + var_247_0, var_247_11 - var_247_7 / 2, var_247_14 - var_247_0, var_247_11 - var_247_7 / 2 + var_247_0, 128)

	local var_247_15, var_247_16, var_247_17 = GetRGB(arg_247_3)

	DrawBoxTitle_sub(var_247_9 + 1, var_247_11 + 1, var_247_10, var_247_12, var_247_13 + 1, var_247_11 - var_247_7 / 2 + 1, var_247_14, var_247_11 + var_247_7 / 2, RGB(math.modf(var_247_15 / 2), math.modf(var_247_16 / 2), math.modf(var_247_17 / 2)))
	DrawBoxTitle_sub(var_247_9, var_247_11, var_247_10 - 1, var_247_12 - 1, var_247_13, var_247_11 - var_247_7 / 2, var_247_14 - 1, var_247_11 + var_247_7 / 2 - 1, arg_247_3)
	DrawString(var_247_13 + 2 * var_247_0, var_247_11 - (var_247_7 - var_247_0) / 2, arg_247_2, arg_247_3, CC.DefaultFont)
end

function DrawBoxTitle_sub(arg_248_0, arg_248_1, arg_248_2, arg_248_3, arg_248_4, arg_248_5, arg_248_6, arg_248_7, arg_248_8)
	local var_248_0 = 4

	lib.DrawRect(arg_248_0 + var_248_0, arg_248_1, arg_248_4, arg_248_1, arg_248_8)
	lib.DrawRect(arg_248_6, arg_248_1, arg_248_2 - var_248_0, arg_248_1, arg_248_8)
	lib.DrawRect(arg_248_2 - var_248_0, arg_248_1, arg_248_2 - var_248_0, arg_248_1 + var_248_0, arg_248_8)
	lib.DrawRect(arg_248_2 - var_248_0, arg_248_1 + var_248_0, arg_248_2, arg_248_1 + var_248_0, arg_248_8)
	lib.DrawRect(arg_248_2, arg_248_1 + var_248_0, arg_248_2, arg_248_3 - var_248_0, arg_248_8)
	lib.DrawRect(arg_248_2, arg_248_3 - var_248_0, arg_248_2 - var_248_0, arg_248_3 - var_248_0, arg_248_8)
	lib.DrawRect(arg_248_2 - var_248_0, arg_248_3 - var_248_0, arg_248_2 - var_248_0, arg_248_3, arg_248_8)
	lib.DrawRect(arg_248_2 - var_248_0, arg_248_3, arg_248_0 + var_248_0, arg_248_3, arg_248_8)
	lib.DrawRect(arg_248_0 + var_248_0, arg_248_3, arg_248_0 + var_248_0, arg_248_3 - var_248_0, arg_248_8)
	lib.DrawRect(arg_248_0 + var_248_0, arg_248_3 - var_248_0, arg_248_0, arg_248_3 - var_248_0, arg_248_8)
	lib.DrawRect(arg_248_0, arg_248_3 - var_248_0, arg_248_0, arg_248_1 + var_248_0, arg_248_8)
	lib.DrawRect(arg_248_0, arg_248_1 + var_248_0, arg_248_0 + var_248_0, arg_248_1 + var_248_0, arg_248_8)
	lib.DrawRect(arg_248_0 + var_248_0, arg_248_1 + var_248_0, arg_248_0 + var_248_0, arg_248_1, arg_248_8)
	DrawBox_1(arg_248_4, arg_248_5, arg_248_6, arg_248_7, arg_248_8)
end

function Init_SMap(arg_249_0)
	lib.PicInit()
	lib.PicLoadFile(CC.SMAPPicFile[1], CC.SMAPPicFile[2], 0)
	lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 800 * 100, 0, 100))
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)
	PlayMIDI(JY.Scene[JY.SubScene].进门音乐)

	JY.oldSMapX = -1
	JY.oldSMapY = -1
	JY.SubSceneX = 0
	JY.SubSceneY = 0
	JY.OldDPass = -1
	JY.D_Valid = nil

	DrawSMap()
	lib.GetKey()

	if arg_249_0 == 1 then
		DrawStrBox(-1, 10, JY.Scene[JY.SubScene].名称, C_WHITE, CC.DefaultFont)
		ShowScreen()
		WaitKey()
	end
end

function zj()
	return 0
end

function gethead(arg_251_0, arg_251_1)
	local var_251_0 = arg_251_0

	if arg_251_0 == 0 then
		return JY.Person[0].头像代号
	end

	if arg_251_1 ~= nil and arg_251_1 == 1 then
		return arg_251_0
	end

	if arg_251_0 > 0 and JY.Person[arg_251_0].头像代号 > 0 then
		return JY.Person[arg_251_0].头像代号
	end

	return var_251_0
end

function MyDrawString(arg_252_0, arg_252_1, arg_252_2, arg_252_3, arg_252_4, arg_252_5)
	local var_252_0 = math.modf(string.len(arg_252_3) * arg_252_5 / 4)
	local var_252_1 = math.modf((arg_252_0 + arg_252_1) / 2) - var_252_0

	DrawString(var_252_1, arg_252_2, arg_252_3, arg_252_4, arg_252_5)
end

function Split(arg_253_0, arg_253_1)
	local var_253_0 = 1
	local var_253_1 = 1
	local var_253_2 = {}

	while true do
		local var_253_3 = string.find(arg_253_0, arg_253_1, var_253_0)

		if not var_253_3 then
			var_253_2[var_253_1] = string.sub(arg_253_0, var_253_0, string.len(arg_253_0))

			break
		else
			var_253_2[var_253_1] = string.sub(arg_253_0, var_253_0, var_253_3 - 1)
			var_253_0 = var_253_3 + string.len(arg_253_1)
			var_253_1 = var_253_1 + 1
		end
	end

	return var_253_1, var_253_2
end

function DrawStrBox2(arg_254_0, arg_254_1, arg_254_2, arg_254_3, arg_254_4, arg_254_5)
	local var_254_0 = {}
	local var_254_1
	local var_254_2
	local var_254_3 = 0
	local var_254_4, var_254_5 = Split(arg_254_2, "*")

	for iter_254_0 = 1, var_254_4 do
		local var_254_6 = string.len(var_254_5[iter_254_0])

		if var_254_3 < var_254_6 then
			var_254_3 = var_254_6
		end
	end

	local var_254_7 = arg_254_4 * var_254_3 / 2 + 2 * CC.MenuBorderPixel
	local var_254_8 = 2 * CC.MenuBorderPixel + arg_254_4 * var_254_4

	if arg_254_0 == -1 then
		arg_254_0 = (CC.ScreenW - arg_254_4 / 2 * var_254_3 - 2 * CC.MenuBorderPixel) / 2
	end

	if arg_254_1 == -1 then
		arg_254_1 = (CC.ScreenH - arg_254_4 * var_254_4 - 2 * CC.MenuBorderPixel) / 2
	end

	DrawBox2(arg_254_0, arg_254_1, arg_254_0 + var_254_7 - 1, arg_254_1 + var_254_8 - 1, C_WHITE, arg_254_5)

	for iter_254_1 = 1, var_254_4 do
		DrawString(arg_254_0 + CC.MenuBorderPixel, arg_254_1 + CC.MenuBorderPixel + arg_254_4 * (iter_254_1 - 1), var_254_5[iter_254_1], arg_254_3, arg_254_4)
	end
end

function DrawBox2(arg_255_0, arg_255_1, arg_255_2, arg_255_3, arg_255_4, arg_255_5)
	local var_255_0 = 4

	arg_255_5 = arg_255_5 or 0

	if arg_255_5 >= 0 then
		lib.Background(arg_255_0, arg_255_1 + var_255_0, arg_255_0 + var_255_0, arg_255_3 - var_255_0, 128, arg_255_5)
		lib.Background(arg_255_0 + var_255_0, arg_255_1, arg_255_2 - var_255_0, arg_255_3, 128, arg_255_5)
		lib.Background(arg_255_2 - var_255_0, arg_255_1 + var_255_0, arg_255_2, arg_255_3 - var_255_0, 128, arg_255_5)
	end

	if arg_255_4 >= 0 then
		local var_255_1, var_255_2, var_255_3 = GetRGB(arg_255_4)

		DrawBox_2(arg_255_0 + 1, arg_255_1, arg_255_2, arg_255_3, RGB(math.modf(var_255_1 / 2), math.modf(var_255_2 / 2), math.modf(var_255_3 / 2)))
		DrawBox_2(arg_255_0, arg_255_1, arg_255_2 - 1, arg_255_3 - 1, arg_255_4)
	end
end

function DrawBox_2(arg_256_0, arg_256_1, arg_256_2, arg_256_3, arg_256_4)
	local var_256_0 = 4

	lib.DrawRect(arg_256_0 + var_256_0, arg_256_1, arg_256_2 - var_256_0, arg_256_1, arg_256_4)
	lib.DrawRect(arg_256_2 - var_256_0, arg_256_1, arg_256_2 - var_256_0, arg_256_1 + var_256_0, arg_256_4)
	lib.DrawRect(arg_256_2 - var_256_0, arg_256_1 + var_256_0, arg_256_2, arg_256_1 + var_256_0, arg_256_4)
	lib.DrawRect(arg_256_2, arg_256_1 + var_256_0, arg_256_2, arg_256_3 - var_256_0, arg_256_4)
	lib.DrawRect(arg_256_2, arg_256_3 - var_256_0, arg_256_2 - var_256_0, arg_256_3 - var_256_0, arg_256_4)
	lib.DrawRect(arg_256_2 - var_256_0, arg_256_3 - var_256_0, arg_256_2 - var_256_0, arg_256_3, arg_256_4)
	lib.DrawRect(arg_256_2 - var_256_0, arg_256_3, arg_256_0 + var_256_0, arg_256_3, arg_256_4)
	lib.DrawRect(arg_256_0 + var_256_0, arg_256_3, arg_256_0 + var_256_0, arg_256_3 - var_256_0, arg_256_4)
	lib.DrawRect(arg_256_0 + var_256_0, arg_256_3 - var_256_0, arg_256_0, arg_256_3 - var_256_0, arg_256_4)
	lib.DrawRect(arg_256_0, arg_256_3 - var_256_0, arg_256_0, arg_256_1 + var_256_0, arg_256_4)
	lib.DrawRect(arg_256_0, arg_256_1 + var_256_0, arg_256_0 + var_256_0, arg_256_1 + var_256_0, arg_256_4)
	lib.DrawRect(arg_256_0 + var_256_0, arg_256_1 + var_256_0, arg_256_0 + var_256_0, arg_256_1, arg_256_4)
end

function Init_MMap()
	lib.PicInit()
	lib.LoadMMap(CC.MMapFile[1], CC.MMapFile[2], CC.MMapFile[3], CC.MMapFile[4], CC.MMapFile[5], CC.MWidth, CC.MHeight, JY.Base.人X, JY.Base.人Y)
	lib.PicLoadFile(CC.MMAPPicFile[1], CC.MMAPPicFile[2], 0)
	lib.LoadPNGPath(CC.HeadPath, 1, CC.HeadNum, limitX(CC.ScreenW / 800 * 100, 0, 100))
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 2)

	JY.EnterSceneXY = nil
	JY.oldMMapX = -1
	JY.oldMMapY = -1

	PlayMIDI(JY.MmapMusic)
end

function My_Enter_SubScene(arg_258_0, arg_258_1, arg_258_2, arg_258_3)
	JY.SubScene = arg_258_0

	local var_258_0 = 1

	if arg_258_1 == -1 and arg_258_2 == -1 then
		JY.Base.人X1 = JY.Scene[arg_258_0].入口X
		JY.Base.人Y1 = JY.Scene[arg_258_0].入口Y
	else
		JY.Base.人X1 = arg_258_1
		JY.Base.人Y1 = arg_258_2
		var_258_0 = 0
	end

	if arg_258_3 > -1 then
		JY.Base.人方向 = arg_258_3
	end

	if JY.Status == GAME_MMAP then
		CleanMemory()
		lib.UnloadMMap()
	end

	lib.ShowSlow(20, 1)

	JY.Status = GAME_SMAP
	JY.MmapMusic = -1
	JY.Base.乘船 = 0
	JY.MyPic = GetMyPic()

	local var_258_1 = JY.Scene[arg_258_0].跳转场景

	if var_258_1 < 0 or JY.Scene[var_258_1].外景入口X1 <= 0 and JY.Scene[var_258_1].外景入口Y1 <= 0 then
		JY.Base.人X = JY.Scene[arg_258_0].外景入口X1
		JY.Base.人Y = JY.Scene[arg_258_0].外景入口Y1
	else
		JY.Base.人X = JY.Scene[var_258_1].外景入口X1
		JY.Base.人Y = JY.Scene[var_258_1].外景入口Y1
	end

	Init_SMap(var_258_0)

	if var_258_0 == 0 then
		DrawStrBox(-1, 10, JY.Scene[JY.SubScene].名称, C_WHITE, CC.DefaultFont)
		ShowScreen()
		WaitKey()
	end

	Cls()
end

function JYZTB()
	local var_259_0 = 0
	local var_259_1 = 0
	local var_259_2 = JY.Person[var_259_0].门派 == 1 and "武当" or JY.Person[var_259_0].门派 == 2 and "少林" or JY.Person[var_259_0].门派 == 3 and "丐帮" or JY.Person[var_259_0].门派 == 4 and "华山派" or JY.Person[var_259_0].门派 == 5 and "五岳剑派" or JY.Person[var_259_0].门派 == 6 and "星宿派" or JY.Person[var_259_0].门派 == 7 and "逍遥派" or JY.Person[var_259_0].门派 == 10 and "复天盟" or JY.Person[var_259_0].门派 == 21 and "野狗帮" or "无"
	local var_259_3 = 0
	local var_259_4 = JY.Person[var_259_0].门派等级 == 1 and "初级弟子" or JY.Person[var_259_0].门派等级 == 2 and "内门弟子" or JY.Person[var_259_0].门派等级 == 3 and "精英弟子" or JY.Person[var_259_0].门派等级 == 4 and "长老" or JY.Person[var_259_0].门派等级 == 5 and "掌门" or JY.Person[var_259_0].门派等级 == 6 and "弃徒" or JY.Person[var_259_0].门派等级 == 7 and "俗家弟子" or JY.Person[var_259_0].门派等级 == 8 and "外门执事" or JY.Person[var_259_0].门派等级 == 9 and "外门长老" or JY.Person[var_259_0].门派等级 == 10 and "盟主" or JY.Person[var_259_0].门派等级 == 21 and "小喽啰" or JY.Person[var_259_0].门派等级 == 22 and "红花打手" or JY.Person[var_259_0].门派等级 == 23 and "头目" or JY.Person[var_259_0].门派等级 == 24 and "堂主" or JY.Person[var_259_0].门派等级 == 25 and "帮主" or JY.Person[var_259_0].门派等级 == 26 and "俗家弟子" or ""
	local var_259_5 = 0
	local var_259_6 = JY.Person[var_259_0].官阶 == 1 and "童生" or JY.Person[var_259_0].官阶 == 2 and "秀才" or JY.Person[var_259_0].官阶 == 3 and "举人" or JY.Person[var_259_0].官阶 == 4 and "进士" or JY.Person[var_259_0].官阶 == 5 and "参知" or JY.Person[var_259_0].官阶 == 6 and "知府" or JY.Person[var_259_0].官阶 == 7 and "大理寺寺丞" or JY.Person[var_259_0].官阶 == 8 and "大理寺少卿" or JY.Person[var_259_0].官阶 == 9 and "大理寺卿" or JY.Person[var_259_0].官阶 == 10 and "宰相" or JY.Person[var_259_0].官阶 == 11 and "微服" or JY.Person[var_259_0].官阶 == 12 and "南朝皇帝" or "白衣"
	local var_259_7 = JY.Base.主角职业

	if JY.Base.畅想编号 > 0 then
		local var_259_8 = "畅想"
	end

	if JY.Base.特殊主角 == 2 then
		local var_259_9 = 11
	end

	if JY.Base.特殊主角 == 3 then
		local var_259_10 = 12
	end

	if JY.Base.特殊主角 == 4 then
		local var_259_11 = 13
	end

	if JY.Base.特殊主角 == 5 then
		local var_259_12 = 14
	end

	local var_259_13
	local var_259_14

	var_259_14 = JY.Base.畅想编号 > 0 and "畅想" or JY.Base.特殊主角 > 0 and "特殊" or "标准"

	local var_259_15 = math.modf((lib.GetTime() - JY.LOADTIME) / 60000 + GetS(14, 2, 1, 4))
	local var_259_16 = 0
	local var_259_17 = 0

	while var_259_15 >= 60 do
		var_259_15 = var_259_15 - 60
		var_259_16 = var_259_16 + 1
	end

	local var_259_18 = var_259_15
	local var_259_19 = 0

	DrawBox(10, 10, 10 + 10 * CC.FontSmall2, 15 + 5 * (CC.FontSmall2 + CC.RowPixel), M_SandyBrown)
	DrawString(15, 15, "品德", M_SandyBrown, CC.FontSmall2)
	DrawString(20 + CC.FontSmall2 * 2 + 4, 14, JY.Person[0].品德, Dark_Gold, CC.FontSmall2)
	DrawString(15 + CC.FontSmall2 * 4 + 4, 15, "银", M_SandyBrown, CC.FontSmall2)
	DrawString(15 + CC.FontSmall2 * 5 + 4, 16, "两", M_SandyBrown, CC.FontSmall2)
	DrawString(15 + CC.FontSmall2 * 6 + 8, 15, JY.GOLD, Dark_Gold, CC.FontSmall2)

	local var_259_20 = var_259_19 + 1

	DrawString(15, 15 + var_259_20 * (CC.FontSmall2 + CC.RowPixel), "年龄:" .. 15 + JY.YEAR .. " 声望 " .. JY.Person[0].声望, M_SandyBrown, CC.FontSmall2)

	local var_259_21 = JY.Base.佣兵1
	local var_259_22 = JY.Base.佣兵2
	local var_259_23 = JY.Base.佣兵3

	if var_259_21 > 0 or var_259_22 > 0 or var_259_23 > 0 then
		DrawString(720 + CC.FontSmall2 * 4 + 4, var_259_20 * (CC.FontSmall1 + CC.RowPixel), "随行护卫：", M_SandyBrown, CC.FontSmall2)
	end

	if var_259_21 > 0 then
		DrawString(720 + CC.FontSmall2 * 4 + 4, 25 + var_259_20 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_21].姓名 .. " " .. JY.Person[var_259_21].生命 .. "/" .. JY.Person[var_259_21].生命最大值 .. "  善使-" .. JY.Wugong[JY.Person[var_259_21].武功1].名称, M_Silver, CC.FontSmall1)
	end

	if var_259_22 > 0 then
		DrawString(720 + CC.FontSmall2 * 4 + 4, 45 + var_259_20 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_22].姓名 .. " " .. JY.Person[var_259_22].生命 .. "/" .. JY.Person[var_259_22].生命最大值 .. "  善使-" .. JY.Wugong[JY.Person[var_259_22].武功1].名称, M_Silver, CC.FontSmall1)
	end

	if var_259_23 > 0 then
		DrawString(720 + CC.FontSmall2 * 4 + 4, 65 + var_259_20 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_23].姓名 .. " " .. JY.Person[var_259_23].生命 .. "/" .. JY.Person[var_259_23].生命最大值 .. "  善使-" .. JY.Wugong[JY.Person[var_259_23].武功1].名称, M_Silver, CC.FontSmall1)
	end

	local var_259_24 = var_259_20 + 1

	DrawString(15, 15 + var_259_24 * (CC.FontSmall2 + CC.RowPixel), "时间:天启" .. JY.YEAR .. "年" .. JY.MONTH .. "月" .. JY.DAY .. "日", Violet, CC.FontSmall2)

	local var_259_25 = var_259_24 + 1

	DrawString(15, 15 + var_259_25 * (CC.FontSmall2 + CC.RowPixel), "难度:", M_SandyBrown, CC.FontSmall2)
	DrawString(CC.FontSmall2 * 3, 15 + var_259_25 * (CC.FontSmall2 + CC.RowPixel), MODEXZ2[JY.Base.游戏难度], Dark_Gold, CC.FontSmall2)
	DrawString(50 + CC.FontSmall2 * 4 + 4, 15 + var_259_25 * (CC.FontSmall2 + CC.RowPixel), var_259_6, Dark_Gold, CC.FontSmall2)

	local var_259_26 = var_259_25 + 1

	DrawString(15, 15 + var_259_26 * (CC.FontSmall2 + CC.RowPixel), "门派:", M_SandyBrown, CC.FontSmall2)
	DrawString(CC.FontSmall2 * 3, 15 + var_259_26 * (CC.FontSmall2 + CC.RowPixel), var_259_2, Dark_Gold, CC.FontSmall2)
	DrawString(50 + CC.FontSmall2 * 4 + 8, 15 + var_259_26 * (CC.FontSmall2 + CC.RowPixel), var_259_4, Dark_Gold, CC.FontSmall2)

	local var_259_27 = var_259_26 + 13
	local var_259_28 = JY.Base.宠物1

	if var_259_28 > 0 then
		DrawString(CC.FontSmall1 * 1, var_259_27 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_28].姓名 .. " " .. JY.Person[var_259_28].生命 .. "/" .. JY.Person[var_259_28].生命最大值 .. "  毒性：" .. JY.Person[var_259_28].攻击带毒, green1, CC.FontSmall1)
	end

	local var_259_29 = var_259_27 + 1
	local var_259_30 = JY.Base.宠物2

	if var_259_30 > 0 then
		DrawString(CC.FontSmall1 * 1, var_259_29 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_30].姓名 .. " " .. JY.Person[var_259_30].生命 .. "/" .. JY.Person[var_259_30].生命最大值 .. "  毒性：" .. JY.Person[var_259_30].攻击带毒, green1, CC.FontSmall1)
	end

	local var_259_31 = var_259_29 + 1
	local var_259_32 = JY.Base.宠物3

	if var_259_32 > 0 then
		DrawString(CC.FontSmall1 * 1, var_259_31 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_32].姓名 .. " " .. JY.Person[var_259_32].生命 .. "/" .. JY.Person[var_259_32].生命最大值 .. "  毒性：" .. JY.Person[var_259_32].攻击带毒, green1, CC.FontSmall1)
	end

	local var_259_33 = var_259_31 + 1
	local var_259_34 = JY.Base.宠物4

	if var_259_34 > 0 then
		DrawString(CC.FontSmall1 * 1, var_259_33 * (CC.FontSmall1 + CC.RowPixel), JY.Person[var_259_34].姓名 .. " " .. JY.Person[var_259_34].生命 .. "/" .. JY.Person[var_259_34].生命最大值 .. "  毒性：" .. JY.Person[var_259_34].攻击带毒, green1, CC.FontSmall1)
	end

	local var_259_35 = var_259_33 + 1

	if JY.Base.随从1 == 625 then
		DrawString(CC.FontSmall1 * 1, var_259_35 * (CC.FontSmall1 + CC.RowPixel), "随从:麦小八 使马车时间减少2天", M_Silver, CC.FontSmall1)
	end
end

function night()
	DrawBox(0, 0, CC.ScreenW, CC.ScreenH, M_SandyBrown)
end

function QZXS(arg_261_0)
	DrawStrBoxWaitKey(arg_261_0, C_GOLD, CC.DefaultFont)
end

function KungfuString(arg_262_0, arg_262_1, arg_262_2, arg_262_3, arg_262_4, arg_262_5, arg_262_6)
	if arg_262_0 == nil then
		return
	end

	local var_262_0 = arg_262_4
	local var_262_1 = arg_262_4 + 5

	arg_262_1 = arg_262_1 - string.len(arg_262_0) / 2 * var_262_0 / 2
	arg_262_2 = arg_262_2 - var_262_1 * arg_262_6

	lib.DrawStr(arg_262_1, arg_262_2, arg_262_0, arg_262_3, arg_262_4, arg_262_5, 0, 0)
end

function ClsN(arg_263_0, arg_263_1, arg_263_2, arg_263_3)
	if arg_263_0 == nil then
		arg_263_0 = 0
		arg_263_1 = 0
		arg_263_2 = 0
		arg_263_3 = 0
	end

	lib.SetClip(arg_263_0, arg_263_1, arg_263_2, arg_263_3)
	lib.FillColor(0, 0, 0, 0, 0)
	lib.SetClip(0, 0, 0, 0)
end

function T1LEQ(arg_264_0)
	if arg_264_0 == 0 and JY.Person[arg_264_0].姓名 == JY.LEQ and JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_264_0 == JY.Base.队伍1 and JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_264_0 == 9999 and JY.Person[arg_264_0].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Base.特殊主角 == 1 and JY.Base.主角职业 == 10 then
		return true
	else
		return false
	end
end

function T2SQ(arg_265_0)
	if arg_265_0 == 0 and JY.Person[arg_265_0].姓名 == JY.SQ and JY.Base.特殊主角 == 2 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_265_0 == JY.Base.队伍1 and JY.Base.特殊主角 == 2 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_265_0 == 9999 and JY.Person[arg_265_0].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Base.特殊主角 == 2 and JY.Base.主角职业 == 10 then
		return true
	else
		return false
	end
end

function T3XXM(arg_266_0)
	if arg_266_0 == 0 and JY.Person[arg_266_0].姓名 == JY.XXM and JY.Base.特殊主角 == 3 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_266_0 == JY.Base.队伍1 and JY.Base.特殊主角 == 3 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_266_0 == 9999 and JY.Person[arg_266_0].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Base.特殊主角 == 3 and JY.Base.主角职业 == 10 then
		return true
	else
		return false
	end
end

function T4RM(arg_267_0)
	if arg_267_0 == 0 and JY.Person[arg_267_0].姓名 == JY.RM and JY.Base.特殊主角 == 4 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_267_0 == JY.Base.队伍1 and JY.Base.特殊主角 == 4 and JY.Base.主角职业 == 10 then
		return true
	elseif arg_267_0 == 9999 and JY.Person[arg_267_0].姓名 == JY.Person[JY.Base.队伍1].姓名 and JY.Base.特殊主角 == 4 and JY.Base.主角职业 == 10 then
		return true
	else
		return false
	end
end

function ClipRect(arg_268_0)
	if CC.ScreenW <= arg_268_0.x1 or arg_268_0.x2 <= 0 or CC.ScreenH <= arg_268_0.y1 or arg_268_0.y2 <= 0 then
		return nil
	else
		return {
			x1 = limitX(arg_268_0.x1, 0, CC.ScreenW),
			x2 = limitX(arg_268_0.x2, 0, CC.ScreenW),
			y1 = limitX(arg_268_0.y1, 0, CC.ScreenH),
			y2 = limitX(arg_268_0.y2, 0, CC.ScreenH)
		}
	end
end

function Cal_PicClip(arg_269_0, arg_269_1, arg_269_2, arg_269_3, arg_269_4, arg_269_5, arg_269_6, arg_269_7)
	local var_269_0, var_269_1, var_269_2, var_269_3 = lib.PicGetXY(arg_269_3, arg_269_2 * 2)
	local var_269_4 = {
		x1 = CC.XScale * (arg_269_0 - arg_269_1) + CC.ScreenW / 2 - var_269_2,
		y1 = CC.YScale * (arg_269_0 + arg_269_1) + CC.ScreenH / 2 - var_269_3
	}

	var_269_4.x2 = var_269_4.x1 + var_269_0
	var_269_4.y2 = var_269_4.y1 + var_269_1

	local var_269_5, var_269_6, var_269_7, var_269_8 = lib.PicGetXY(arg_269_7, arg_269_6 * 2)
	local var_269_9 = {
		x1 = CC.XScale * (arg_269_4 - arg_269_5) + CC.ScreenW / 2 - var_269_7,
		y1 = CC.YScale * (arg_269_4 + arg_269_5) + CC.ScreenH / 2 - var_269_8
	}

	var_269_9.x2 = var_269_9.x1 + var_269_5
	var_269_9.y2 = var_269_9.y1 + var_269_6

	return MergeRect(var_269_4, var_269_9)
end

function MergeRect(arg_270_0, arg_270_1)
	return {
		x1 = math.min(arg_270_0.x1, arg_270_1.x1),
		y1 = math.min(arg_270_0.y1, arg_270_1.y1),
		x2 = math.max(arg_270_0.x2, arg_270_1.x2),
		y2 = math.max(arg_270_0.y2, arg_270_1.y2)
	}
end

function TalkEx(arg_271_0, arg_271_1, arg_271_2, arg_271_3, arg_271_4)
	local var_271_0 = 130
	local var_271_1 = 130
	local var_271_2 = 18
	local var_271_3 = 3
	local var_271_4 = 2
	local var_271_5 = 2
	local var_271_6 = var_271_0 + 10
	local var_271_7 = var_271_1 + 10
	local var_271_8 = 18 * CC.DefaultFont + 10
	local var_271_9 = var_271_7
	local var_271_10 = (var_271_1 - var_271_3 * CC.DefaultFont) / (var_271_3 + 1)
	local var_271_11 = {
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_271_4 - var_271_6,
			heady = CC.ScreenH - var_271_5 - var_271_7,
			talkx = CC.ScreenW - 1 - var_271_4 - var_271_6 - var_271_8 - 2,
			talky = CC.ScreenH - var_271_5 - var_271_7
		},
		{
			showhead = 0,
			headx = var_271_4,
			heady = var_271_5,
			talkx = var_271_4 + var_271_6 + 2,
			talky = var_271_5
		},
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_271_4 - var_271_6,
			heady = CC.ScreenH - var_271_5 - var_271_7,
			talkx = CC.ScreenW - 1 - var_271_4 - var_271_6 - var_271_8 - 2,
			talky = CC.ScreenH - var_271_5 - var_271_7
		},
		{
			showhead = 1,
			headx = CC.ScreenW - 1 - var_271_4 - var_271_6,
			heady = var_271_5,
			talkx = CC.ScreenW - 1 - var_271_4 - var_271_6 - var_271_8 - 2,
			talky = var_271_5
		},
		{
			showhead = 1,
			headx = var_271_4,
			heady = CC.ScreenH - var_271_5 - var_271_7,
			talkx = var_271_4 + var_271_6 + 2,
			talky = CC.ScreenH - var_271_5 - var_271_7
		},
		[0] = {
			showhead = 1,
			headx = var_271_4,
			heady = var_271_5,
			talkx = var_271_4 + var_271_6 + 2,
			talky = var_271_5
		}
	}

	if arg_271_2 < 0 or arg_271_2 > 5 then
		arg_271_2 = 0
	end

	arg_271_0 = GenTalkString(arg_271_0, 18)

	if CONFIG.KeyRepeat == 0 then
		lib.EnableKeyRepeat(0, CONFIG.KeyRepeatInterval)
	end

	lib.GetKey()

	local var_271_12 = 1
	local var_271_13
	local var_271_14 = 0
	local var_271_15 = JY.Person[arg_271_1].头像代号

	while true do
		if var_271_14 == 0 then
			Cls()

			if var_271_15 >= 0 then
				if var_271_15 > 243 and var_271_15 < 249 then
					var_271_15 = 0
				end

				if var_271_15 == 0 then
					if JY.Base.畅想编号 == 0 then
						if JY.Base.主角职业 < 10 then
							if JY.Person[0].性别 == 0 then
								var_271_15 = 280 + JY.Base.主角职业
							else
								var_271_15 = 501 + JY.Base.主角职业
							end
						else
							var_271_15 = 289 + JY.Base.特殊主角
						end
					else
						var_271_15 = JY.Person[JY.Base.畅想编号].头像代号
					end
				end

				DrawBox(var_271_11[arg_271_2].headx, var_271_11[arg_271_2].heady, var_271_11[arg_271_2].headx + var_271_6, var_271_11[arg_271_2].heady + var_271_7, C_WHITE)

				local var_271_16, var_271_17 = lib.GetPNGXY(1, var_271_15 * 2)
				local var_271_18 = (var_271_0 - var_271_16) / 2
				local var_271_19 = (var_271_1 - var_271_17) / 2

				lib.LoadPNG(1, var_271_15 * 2, var_271_11[arg_271_2].headx + 5 + var_271_18, var_271_11[arg_271_2].heady + 5 + var_271_19, 1)

				if arg_271_3 ~= nil and arg_271_3 == 1 then
					local var_271_20 = var_271_11[arg_271_2].headx + 5
					local var_271_21 = var_271_11[arg_271_2].heady + 5 + var_271_1 - 20

					if arg_271_4 ~= nil then
						DrawString(var_271_20, var_271_21, arg_271_4, C_GOLD, 20)
					else
						DrawString(var_271_20, var_271_21, JY.Person[arg_271_1].姓名, C_GOLD, 20)
					end
				end

				DrawBox(var_271_11[arg_271_2].talkx, var_271_11[arg_271_2].talky, var_271_11[arg_271_2].talkx + var_271_8, var_271_11[arg_271_2].talky + var_271_9, C_WHITE)
			end
		end

		local var_271_22 = string.find(arg_271_0, "*", var_271_12)

		if var_271_22 == nil then
			DrawString(var_271_11[arg_271_2].talkx + 5, var_271_11[arg_271_2].talky + 5 + var_271_10 + var_271_14 * (CC.DefaultFont + var_271_10), string.sub(arg_271_0, var_271_12), C_WHITE, CC.DefaultFont)
			ShowScreen()
			WaitKey()

			break
		else
			DrawString(var_271_11[arg_271_2].talkx + 5, var_271_11[arg_271_2].talky + 5 + var_271_10 + var_271_14 * (CC.DefaultFont + var_271_10), string.sub(arg_271_0, var_271_12, var_271_22 - 1), C_WHITE, CC.DefaultFont)
		end

		var_271_14 = var_271_14 + 1
		var_271_12 = var_271_22 + 1

		if var_271_3 <= var_271_14 then
			ShowScreen()
			WaitKey()

			var_271_14 = 0
		end
	end

	if CONFIG.KeyRepeat == 0 then
		lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay, CONFIG.KeyRepeatInterval)
	end

	Cls()
end

function NEvent(arg_272_0)
	NEvent2(arg_272_0)
	NEvent3(arg_272_0)
	NEvent4(arg_272_0)
	NEvent5(arg_272_0)
	NEvent6(arg_272_0)
	NEvent7(arg_272_0)
	NEvent8(arg_272_0)
	NEvent10(arg_272_0)
	NEvent11(arg_272_0)
	NEvent12(arg_272_0)
end

function NewDrawString(arg_273_0, arg_273_1, arg_273_2, arg_273_3, arg_273_4)
	local var_273_0 = #arg_273_2
	local var_273_1 = arg_273_4 * var_273_0 / 2 + 2 * CC.MenuBorderPixel
	local var_273_2 = arg_273_4 + 2 * CC.MenuBorderPixel

	if arg_273_0 == -1 then
		arg_273_0 = (CC.ScreenW - arg_273_4 / 2 * var_273_0 - 2 * CC.MenuBorderPixel) / 2
	else
		arg_273_0 = (arg_273_0 - arg_273_4 / 2 * var_273_0 - 2 * CC.MenuBorderPixel) / 2
	end

	if arg_273_1 == -1 then
		arg_273_1 = (CC.ScreenH - arg_273_4 - 2 * CC.MenuBorderPixel) / 2
	else
		arg_273_1 = (arg_273_1 - arg_273_4 - 2 * CC.MenuBorderPixel) / 2
	end

	lib.DrawStr(arg_273_0, arg_273_1, arg_273_2, arg_273_3, arg_273_4, CC.FontName, CC.SrcCharSet, CC.OSCharSet)
end

function InputNum(arg_274_0, arg_274_1, arg_274_2, arg_274_3)
	local var_274_0 = CC.DefaultFont * 1.2
	local var_274_1 = C_WHITE
	local var_274_2 = #arg_274_0
	local var_274_3 = var_274_0 * var_274_2 / 2 + 2 * CC.MenuBorderPixel
	local var_274_4 = var_274_0 + 2 * CC.MenuBorderPixel
	local var_274_5 = (CC.ScreenW - var_274_0 / 2 * var_274_2 - 2 * CC.MenuBorderPixel) / 2
	local var_274_6 = (CC.ScreenH - var_274_0 - 2 * CC.MenuBorderPixel) / 2

	DrawBox(var_274_5, var_274_6, var_274_5 + var_274_3 - 1, var_274_6 + var_274_4 - 1, C_WHITE)
	DrawString(var_274_5 + CC.MenuBorderPixel, var_274_6 + CC.MenuBorderPixel, arg_274_0, var_274_1, var_274_0)

	if arg_274_2 < arg_274_1 then
		arg_274_1, arg_274_2 = arg_274_2, arg_274_1
	end

	local var_274_7 = "上下加减1，左右加减10，HS加减100"

	if arg_274_1 ~= nil then
		var_274_7 = var_274_7 .. " 最小" .. arg_274_1
	end

	if arg_274_1 ~= nil then
		var_274_7 = var_274_7 .. " 最大" .. arg_274_2
	end

	if arg_274_3 ~= nil then
		var_274_7 = var_274_7 .. " ESC取消输入"
	end

	DrawString((CC.ScreenW - var_274_0 * #var_274_7 / 2) / 2, var_274_6 - 2 * var_274_0, var_274_7, var_274_1, var_274_0)

	local var_274_8 = lib.SaveSur(0, 0, CC.ScreenW, CC.ScreenH)
	local var_274_9 = 0

	if arg_274_1 ~= nil then
		var_274_9 = arg_274_1
	end

	while true do
		DrawString(CC.ScreenW / 2, var_274_6 + var_274_4 + var_274_0, var_274_9 .. "", C_GOLD, var_274_0)
		ShowScreen()

		local var_274_10 = WaitKey(1)

		lib.Delay(CC.Frame)

		if var_274_10 == VK_UP then
			if arg_274_2 == nil or var_274_9 < arg_274_2 then
				var_274_9 = var_274_9 + 1
			end
		elseif var_274_10 == VK_DOWN then
			if arg_274_1 == nil or arg_274_1 < var_274_9 then
				var_274_9 = var_274_9 - 1
			end
		elseif var_274_10 == VK_LEFT then
			if arg_274_1 == nil or var_274_9 >= arg_274_1 + 10 then
				var_274_9 = var_274_9 - 10
			else
				var_274_9 = arg_274_1
			end
		elseif var_274_10 == VK_RIGHT then
			if arg_274_2 == nil or var_274_9 <= arg_274_2 - 10 then
				var_274_9 = var_274_9 + 10
			else
				var_274_9 = arg_274_2
			end
		elseif var_274_10 == VK_H then
			if arg_274_1 == nil or var_274_9 >= arg_274_1 + 100 then
				var_274_9 = var_274_9 - 100
			else
				var_274_9 = arg_274_2
			end
		elseif var_274_10 == VK_S then
			if arg_274_2 == nil or var_274_9 <= arg_274_2 - 100 then
				var_274_9 = var_274_9 + 100
			else
				var_274_9 = arg_274_2
			end
		elseif var_274_10 == VK_SPACE or var_274_10 == VK_RETURN then
			break
		elseif var_274_10 == VK_ESCAPE and arg_274_3 ~= nil then
			var_274_9 = nil

			break
		end

		ClsN()
		lib.LoadSur(var_274_8, 0, 0)
	end

	lib.FreeSur(var_274_8)

	return var_274_9
end

function SaveList()
	local var_275_0 = Byte.create(24)

	Byte.loadfile(var_275_0, CC.R_IDXFilename[0], 0, 24)

	local var_275_1 = {}

	var_275_1[0] = 0

	for iter_275_0 = 1, 6 do
		var_275_1[iter_275_0] = Byte.get32(var_275_0, 4 * (iter_275_0 - 1))
	end

	local var_275_2 = {
		姓名 = {
			var_275_1[1] + 0,
			2,
			10
		},
		门派 = {
			var_275_1[1] + 246,
			0,
			2
		},
		门派等级 = {
			var_275_1[1] + 248,
			0,
			2
		},
		存档标识 = {
			var_275_1[0] + 2,
			0,
			2
		},
		游戏难度 = {
			var_275_1[0] + 32,
			0,
			2
		},
		year = {
			var_275_1[0] + 112,
			0,
			2
		},
		场景名称 = {
			var_275_1[3] + 2,
			2,
			10
		},
		等级 = {
			var_275_1[1] + 50,
			0,
			2
		},
		队伍1 = {
			var_275_1[0] + 24,
			0,
			2
		}
	}
	local var_275_3 = filelength(CC.R_GRPFilename[0])
	local var_275_4 = Byte.create(var_275_3)
	local var_275_5 = {}

	for iter_275_1 = 1, CC.SaveNum do
		local var_275_6 = ""
		local var_275_7 = ""
		local var_275_8 = ""
		local var_275_9 = ""
		local var_275_10 = ""
		local var_275_11 = ""
		local var_275_12 = ""

		if existFile(string.format(CC.R_GRP, iter_275_1)) then
			Byte.loadfile(var_275_4, string.format(CC.R_GRP, iter_275_1), 0, var_275_3)

			local var_275_13 = GetDataFromStruct(var_275_4, 0, var_275_2, "队伍1")

			var_275_6 = GetDataFromStruct(var_275_4, var_275_13 * CC.PersonSize, var_275_2, "姓名")
			var_275_11 = GetDataFromStruct(var_275_4, var_275_13 * CC.PersonSize, var_275_2, "门派")
			var_275_12 = GetDataFromStruct(var_275_4, var_275_13 * CC.PersonSize, var_275_2, "门派等级")

			local var_275_14 = GetDataFromStruct(var_275_4, 0, var_275_2, "存档标识")

			if var_275_14 == -1 then
				var_275_8 = "大地图"
			else
				var_275_8 = GetDataFromStruct(var_275_4, var_275_14 * CC.SceneSize, var_275_2, "场景名称") .. ""

				local var_275_15 = #var_275_8

				if var_275_15 < 3 then
					var_275_8 = var_275_8 .. "  "
				elseif var_275_15 < 4 then
					var_275_8 = var_275_8 .. " "
				end
			end

			local var_275_16 = GetDataFromStruct(var_275_4, 0, var_275_2, "游戏难度")

			var_275_9 = MODEXZ2[var_275_16]

			local var_275_17 = GetDataFromStruct(var_275_4, var_275_13 * CC.PersonSize, var_275_2, "等级") .. "级"

			var_275_10 = GetDataFromStruct(var_275_4, 0, var_275_2, "year") + 15
		end

		var_275_11 = var_275_11 == 1 and "武当    " or var_275_11 == 2 and "少林    " or var_275_11 == 3 and "丐帮    " or var_275_11 == 4 and "华山派  " or var_275_11 == 5 and "五岳剑派" or var_275_11 == 6 and "星宿派  " or var_275_11 == 7 and "逍遥派  " or var_275_11 == 10 and "复天盟  " or var_275_11 == 21 and "野狗帮  " or "无      "
		var_275_12 = var_275_12 == 1 and "初级弟子" or var_275_12 == 2 and "内门弟子" or var_275_12 == 3 and "精英弟子" or var_275_12 == 4 and "长老    " or var_275_12 == 5 and "掌门    " or var_275_12 == 6 and "弃徒" or var_275_12 == 7 and "俗家弟子" or var_275_12 == 8 and "外门执事" or var_275_12 == 9 and "外门长老" or var_275_12 == 10 and "盟主    " or var_275_12 == 21 and "小喽啰  " or var_275_12 == 22 and "红花打手" or var_275_12 == 23 and "头目    " or var_275_12 == 24 and "堂主    " or var_275_12 == 25 and "帮主    " or var_275_12 == 26 and "俗家弟子" or "无      "

		local var_275_18 = read_files(string.format(CC.CircleFile, iter_275_1), 2000 + 20 * iter_275_1, 20)

		if var_275_18 ~= nil then
			yxsdate[iter_275_1] = string.gsub(var_275_18, "'", "")  -- [port] see docs/PATCHES.md
		end

		if iter_275_1 == 10 then
			var_275_5[iter_275_1] = {
				string.format("自动档%02d %-9s %-2s %-4s %5s %9s %-6s %-6s   ", iter_275_1, var_275_6, var_275_10, var_275_11, var_275_12, var_275_8, var_275_9, yxsdate[iter_275_1]),  -- [port] see docs/PATCHES.md
				nil,
				1
			}
		else
			var_275_5[iter_275_1] = {
				string.format("  存档%02d %-9s %-2s %-4s %5s %9s %-6s %-6s   ", iter_275_1, var_275_6, var_275_10, var_275_11, var_275_12, var_275_8, var_275_9, yxsdate[iter_275_1]),  -- [port] see docs/PATCHES.md
				nil,
				1
			}
		end
	end

	local var_275_19 = (CC.ScreenW - 38.5 * CC.FontSmall3 - 2 * CC.MenuBorderPixel) / 3
	local var_275_20 = (CC.ScreenH - 4.5 * (CC.FontSmall3 + CC.RowPixel)) / 2
	local var_275_21 = ShowMenu(var_275_5, CC.SaveNum, 10, var_275_19, var_275_20, 0, 0, 1, 1, CC.FontSmall3, C_WHITE, C_GOLD)

	CleanMemory()

	return var_275_21
end

function DrawTimer()
	local var_276_0 = lib.GetTime()

	if CC.Timer.status == 0 then
		if var_276_0 - CC.Timer.stime > 60000 or CC.Timer.stime == 0 then
			CC.Timer.stime = var_276_0
			CC.Timer.status = 1
			CC.Timer.str = CC.RUNSTR[math.random(#CC.RUNSTR)]
			CC.Timer.len = string.len(CC.Timer.str) / 2 + 3
		end
	else
		CC.Timer.fun(var_276_0)
	end
end

function demostr(arg_277_0)
	local var_277_0 = arg_277_0 - CC.Timer.stime
	local var_277_1 = math.modf(var_277_0 / 25) % (CC.ScreenW + CC.Timer.len * CC.Fontsmall)

	if runword(CC.Timer.str, M_Orange, CC.Fontsmall, 1, var_277_1) == 1 and Rnd(2) == 1 then
		CC.Timer.status = 0
		CC.Timer.stime = arg_277_0
	end
end

function runword(arg_278_0, arg_278_1, arg_278_2, arg_278_3, arg_278_4)
	arg_278_4 = CC.ScreenW - arg_278_4

	local var_278_0
	local var_278_1

	if arg_278_3 == 0 then
		var_278_0 = 0
		var_278_1 = arg_278_2
	elseif arg_278_3 == 1 then
		var_278_0 = CC.ScreenH - arg_278_2
		var_278_1 = CC.ScreenH
	end

	lib.Background(0, var_278_0, CC.ScreenW, var_278_1, 128)

	if -arg_278_4 > (CC.Timer.len - 1) * arg_278_2 then
		return 1
	end

	DrawString(arg_278_4, var_278_0, arg_278_0, arg_278_1, arg_278_2)

	return 0
end

function Menu_FullScreen()
	lib.FullScreen()
	lib.Debug("finish fullscreen")
end

function Menu_DDTH()
	Cls()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要换哪位队员的位置", C_WHITE, CC.DefaultFont)

	local var_280_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_280_1 = SelectTeamMenu(CC.MainSubMenuX, var_280_0)

	if var_280_1 == nil or var_280_1 < 1 then
		return
	end

	local var_280_2 = JY.Base["队伍" .. var_280_1]

	if var_280_2 == 0 then
		Cls()
		DrawStrBoxWaitKey("主角不能换位", C_WHITE, 30)

		return
	end

	Cls()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要和哪位队员替换", C_WHITE, CC.DefaultFont)

	local var_280_3 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_280_4 = SelectTeamMenu(CC.MainSubMenuX, var_280_3)

	if var_280_4 == nil or var_280_4 < 1 then
		return
	end

	local var_280_5 = JY.Base["队伍" .. var_280_4]

	if var_280_5 == 0 then
		Cls()
		DrawStrBoxWaitKey("主角不能换位", C_WHITE, 30)

		return
	end

	JY.Base["队伍" .. var_280_1] = var_280_5
	JY.Base["队伍" .. var_280_4] = var_280_2
end

OEVENTLUA = {}

function LLL()
	local var_281_0 = Byte.create(4)

	Byte.loadfile(var_281_0, CC.R_IDXFilename[0], 0, 4)

	local var_281_1 = {}

	var_281_1[0] = 0

	for iter_281_0 = 1, 6 do
		var_281_1[iter_281_0] = Byte.get32(var_281_0, 4 * (iter_281_0 - 1))
	end

	local var_281_2 = {
		船方向 = {
			var_281_1[0] + 26,
			0,
			2
		}
	}
	local var_281_3 = filelength(CC.R_GRPFilename[0])
	local var_281_4 = Byte.create(var_281_3)

	Byte.loadfile(var_281_4, string.format(CC.R_GRP, 0), 0, var_281_3)

	local var_281_5 = GetDataFromStruct(var_281_4, 0, var_281_2, "船方向")

	CleanMemory()

	return var_281_5
end

function SSS()
	local var_282_0 = Byte.create(4)

	Byte.set32(var_282_0, 26, 30000)
	Byte.savefile(var_282_0, CC.R_GRPFilename[0], 26, 2)
end

function stands()
	JY.MyCurrentPic = 0

	if JY.Person[0].官阶 == 12 then
		JY.MyPic = CC.MyStartPicH + JY.Base.人方向 * 7 + JY.MyCurrentPic
	elseif JY.Person[0].性别 == 1 or JY.Base.畅想编号 == 27 then
		JY.MyPic = CC.MyStartPicF + JY.Base.人方向 * 7 + JY.MyCurrentPic
	else
		JY.MyPic = CC.MyStartPicM + JY.Base.人方向 * 7 + JY.MyCurrentPic
	end
end

function addtime(arg_284_0)
	JY.DAY = JY.DAY + arg_284_0

	while JY.DAY > 30 do
		JY.DAY = JY.DAY - 30
		JY.MONTH = JY.MONTH + 1
	end

	while JY.MONTH > 12 do
		JY.MONTH = JY.MONTH - 12
		JY.YEAR = JY.YEAR + 1
	end

	if arg_284_0 >= 2 then
		say("" .. arg_284_0 .. "天后...", 0, 2)
		ShowScreen()
		lib.Delay(1000)
		Cls()
	end

	timeevent()
	timeevent1()
	timeevent2()
	timeevent3()
	timeevent4()
end

function addtimes(arg_285_0)
	local var_285_0 = 0
	local var_285_1 = 0
	local var_285_2 = JY.DAY + arg_285_0

	if var_285_2 > 30 then
		local var_285_3 = var_285_2 - 30

		for iter_285_0 = JY.DAY, 30 do
			addtime(1)
		end

		JY.DAY = 0

		for iter_285_1 = 1, var_285_3 do
			addtime(1)

			var_285_0 = var_285_0 + 1

			if var_285_0 == var_285_3 then
				break
			end
		end
	else
		for iter_285_2 = JY.DAY, JY.DAY + arg_285_0 do
			addtime(1)

			var_285_0 = var_285_0 + 1

			if var_285_0 == arg_285_0 then
				break
			end
		end
	end
end

function leijia(arg_286_0)
	local var_286_0 = string.format(CC.R_GRP, arg_286_0)
	local var_286_1 = 0
	local var_286_2 = 0

	for iter_286_0 = 1, 10 do
		local var_286_3 = read_files(var_286_0, 0, iter_286_0 * 500)
		local var_286_4 = string.len(var_286_3)
		local var_286_5 = byte10(var_286_3)

		var_286_1 = var_286_1 + leijiahe(var_286_5, var_286_4)
	end

	for iter_286_1 = 1, 10 do
		local var_286_6 = read_files(var_286_0, 200, iter_286_1 * 500)
		local var_286_7 = string.len(var_286_6)
		local var_286_8 = byte10(var_286_6)

		var_286_1 = var_286_1 + leijiahe(var_286_8, var_286_7)
	end

	for iter_286_2 = 1, 10 do
		local var_286_9 = read_files(var_286_0, 800, iter_286_2 * 500)
		local var_286_10 = string.len(var_286_9)
		local var_286_11 = byte10(var_286_9)

		var_286_1 = var_286_1 + leijiahe(var_286_11, var_286_10)
	end

	return var_286_1
end

function chenhu()
	if JY.Person[0].性别 == 0 then
		JY.Person[0].称呼 = "小兄弟"
	elseif JY.Person[0].性别 == 1 then
		JY.Person[0].称呼 = "小妹妹"
	elseif JY.Person[0].性别 == 2 then
		JY.Person[0].称呼 = "少侠"
	else
		JY.Person[0].称呼 = "大侠"
	end
end

function Curr_NG(arg_288_0, arg_288_1)
	if JY.Person[arg_288_0].主功体 == arg_288_1 then
		return true
	else
		return false
	end
end

function Curr_QG(arg_289_0, arg_289_1)
	if JY.Person[arg_289_0].主运轻功 == arg_289_1 then
		return true
	else
		return false
	end
end

function YunGongMenu()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要设置谁的功体", C_WHITE, CC.DefaultFont)

	local var_290_0 = CC.MainSubMenuY + CC.SingleLineHeight
	local var_290_1 = SelectTeamMenu(CC.MainSubMenuX, var_290_0)
	local var_290_2
	local var_290_3

	if var_290_1 <= 0 then
		return 0
	end

	local var_290_4 = JY.Base["队伍" .. var_290_1]
	local var_290_5 = {
		{
			"运行内功",
			nil,
			1
		},
		{
			"停运内功",
			nil,
			1
		},
		{
			"运行轻功",
			nil,
			1
		},
		{
			"停运轻功",
			nil,
			1
		}
	}
	local var_290_6 = ShowMenu(var_290_5, #var_290_5, 0, CC.MainSubMenuX + 15, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

	if var_290_6 == 1 then
		local var_290_7 = {}

		for iter_290_0 = 1, CC.Kungfunum do
			var_290_7[iter_290_0] = {
				JY.Wugong[JY.Person[var_290_4]["武功" .. iter_290_0]].名称,
				nil,
				0
			}

			if JY.Wugong[JY.Person[var_290_4]["武功" .. iter_290_0]].武功类型 == 5 then
				var_290_7[iter_290_0][3] = 1
			end
		end

		local var_290_8 = ShowMenu(var_290_7, #var_290_7, 0, CC.MainSubMenuX + 21 + 4 * (CC.Fontsmall + CC.RowPixel), CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

		if JY.Person[var_290_4].主功体 > 0 then
			QZXS("你已经装备了内功在运行")

			return
		end

		if var_290_8 ~= nil and var_290_8 > 0 then
			JY.Person[var_290_4].主功体 = JY.Person[var_290_4]["武功" .. var_290_8]

			local var_290_9 = 0

			for iter_290_1 = 1, CC.Kungfunum do
				if JY.Person[var_290_4]["武功" .. iter_290_1] == JY.Person[var_290_4].主功体 then
					var_290_9 = JY.Person[var_290_4]["武功等级" .. iter_290_1] == 999 and 10 or JY.Person[var_290_4]["武功等级" .. iter_290_1] / 100
				end
			end

			JY.Person[var_290_4].攻击力 = JY.Person[var_290_4].攻击力 + JY.Wugong[JY.Person[var_290_4].主功体].增幅攻击等级 * var_290_9
			JY.Person[var_290_4].防御力 = JY.Person[var_290_4].防御力 + JY.Wugong[JY.Person[var_290_4].主功体].增幅防御等级 * var_290_9
			JY.Person[var_290_4].轻功 = JY.Person[var_290_4].轻功 + JY.Wugong[JY.Person[var_290_4].主功体].增幅轻功等级 * var_290_9

			return 20
		end
	elseif var_290_6 == 2 then
		local var_290_10 = 0

		for iter_290_2 = 1, CC.Kungfunum do
			if JY.Person[var_290_4]["武功" .. iter_290_2] == JY.Person[var_290_4].主功体 then
				var_290_10 = JY.Person[var_290_4]["武功等级" .. iter_290_2] == 999 and 10 or JY.Person[var_290_4]["武功等级" .. iter_290_2] / 100
			end
		end

		JY.Person[var_290_4].攻击力 = JY.Person[var_290_4].攻击力 - JY.Wugong[JY.Person[var_290_4].主功体].增幅攻击等级 * var_290_10
		JY.Person[var_290_4].防御力 = JY.Person[var_290_4].防御力 - JY.Wugong[JY.Person[var_290_4].主功体].增幅防御等级 * var_290_10
		JY.Person[var_290_4].轻功 = JY.Person[var_290_4].轻功 - JY.Wugong[JY.Person[var_290_4].主功体].增幅轻功等级 * var_290_10

		DrawStrBoxWaitKey(JY.Person[var_290_4].姓名 .. "停止了运行主内功", C_RED, CC.DefaultFont, nil, LimeGreen)

		JY.Person[var_290_4].主功体 = 0

		return 20
	elseif var_290_6 == 3 then
		local var_290_11 = {}

		for iter_290_3 = 1, CC.Kungfunum do
			var_290_11[iter_290_3] = {
				JY.Wugong[JY.Person[var_290_4]["武功" .. iter_290_3]].名称,
				nil,
				0
			}

			if JY.Wugong[JY.Person[var_290_4]["武功" .. iter_290_3]].武功类型 == 10 then
				var_290_11[iter_290_3][3] = 1
			end
		end

		local var_290_12 = ShowMenu(var_290_11, #var_290_11, 0, CC.MainSubMenuX + 21 + 4 * (CC.Fontsmall + CC.RowPixel), CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)

		if var_290_12 ~= nil and var_290_12 > 0 then
			JY.Person[var_290_4].主运轻功 = JY.Person[var_290_4]["武功" .. var_290_12]

			local var_290_13 = 0

			for iter_290_4 = 1, CC.Kungfunum do
				if JY.Person[var_290_4]["武功" .. iter_290_4] == JY.Person[var_290_4].主运轻功 then
					local var_290_14

					var_290_14 = JY.Person[var_290_4]["武功等级" .. iter_290_4] == 999 and 10 or JY.Person[var_290_4]["武功等级" .. iter_290_4] / 100
				end
			end

			return 20
		end
	elseif var_290_6 == 4 then
		DrawStrBoxWaitKey(JY.Person[var_290_4].姓名 .. "停止了运行轻功", M_DeepSkyBlue, CC.DefaultFont, nil, LimeGreen)

		local var_290_15 = 0

		for iter_290_5 = 1, CC.Kungfunum do
			if JY.Person[var_290_4]["武功" .. iter_290_5] == JY.Person[var_290_4].主运轻功 then
				local var_290_16

				var_290_16 = JY.Person[var_290_4]["武功等级" .. iter_290_5] == 999 and 10 or JY.Person[var_290_4]["武功等级" .. iter_290_5] / 100
			end
		end

		JY.Person[var_290_4].主运轻功 = 0

		return 20
	elseif var_290_6 == 10 then
		return 10
	end
end

function stop_ng(arg_291_0)
	local var_291_0 = 0

	for iter_291_0 = 1, CC.Kungfunum do
		if JY.Person[arg_291_0]["武功" .. iter_291_0] == JY.Person[arg_291_0].主功体 then
			var_291_0 = JY.Person[arg_291_0]["武功等级" .. iter_291_0] == 999 and 10 or JY.Person[arg_291_0]["武功等级" .. iter_291_0] / 100
		end
	end

	JY.Person[arg_291_0].攻击力 = JY.Person[arg_291_0].攻击力 - JY.Wugong[JY.Person[arg_291_0].主功体].增幅攻击等级 * var_291_0
	JY.Person[arg_291_0].防御力 = JY.Person[arg_291_0].防御力 - JY.Wugong[JY.Person[arg_291_0].主功体].增幅防御等级 * var_291_0
	JY.Person[arg_291_0].轻功 = JY.Person[arg_291_0].轻功 - JY.Wugong[JY.Person[arg_291_0].主功体].增幅轻功等级 * var_291_0
	JY.Person[arg_291_0].主功体 = 0
end

function star_ng(arg_292_0, arg_292_1)
	local var_292_0 = 0

	for iter_292_0 = 1, CC.Kungfunum do
		if JY.Person[arg_292_0]["武功" .. iter_292_0] == arg_292_1 then
			var_292_0 = JY.Person[arg_292_0]["武功等级" .. iter_292_0] == 999 and 10 or JY.Person[arg_292_0]["武功等级" .. iter_292_0] / 100
		end
	end

	JY.Person[arg_292_0].主功体 = arg_292_1
	JY.Person[arg_292_0].攻击力 = JY.Person[arg_292_0].攻击力 + JY.Wugong[JY.Person[arg_292_0].主功体].增幅攻击等级 * var_292_0
	JY.Person[arg_292_0].防御力 = JY.Person[arg_292_0].防御力 + JY.Wugong[JY.Person[arg_292_0].主功体].增幅防御等级 * var_292_0
	JY.Person[arg_292_0].轻功 = JY.Person[arg_292_0].轻功 + JY.Wugong[JY.Person[arg_292_0].主功体].增幅轻功等级 * var_292_0
end

function wjjc(arg_293_0)
	local var_293_0 = string.format(CC.R_GRP, arg_293_0)
	local var_293_1 = "certutil -hashfile " .. var_293_0 .. " MD5"
	local var_293_2 = io.popen(var_293_1)
	local var_293_3 = 0
	local var_293_4

	for iter_293_0 in var_293_2:lines() do
		var_293_3 = var_293_3 + 1

		if var_293_3 == 2 then
			var_293_4 = iter_293_0
		end
	end

	return var_293_4
end

function jcdb(arg_294_0)
	local var_294_0 = (CC.ScreenH - 10 - 2 * CC.MenuBorderPixel) / 2

	if JY.wjjc1[arg_294_0] == JY.wjjc2[arg_294_0] then
		return true
	else
		NewDrawString(-1, var_294_0, "文件结构异常", LightGreen, 30)
	end
end

function hzbj(arg_295_0, arg_295_1)
	local var_295_0 = (CC.ScreenH - 10 - 2 * CC.MenuBorderPixel) / 2

	if arg_295_0 == arg_295_1 then
		return true
	else
		NewDrawString(-1, var_295_0, "文件结构异常", LightGreen, 30)
		JY_Main()
	end
end

function fdti(arg_296_0)
	local var_296_0 = string.format(CC.R_GRP, arg_296_0)
	local var_296_1 = io.popen("dir \"..aa..\" /t:w")
	local var_296_2 = 0
	local var_296_3

	for iter_296_0 in var_296_1:lines() do
		var_296_2 = var_296_2 + 1

		if var_296_2 == 6 then
			var_296_3 = iter_296_0
		end
	end

	if var_296_3 == nil then
		var_296_3 = 123
	end

	return var_296_3
end

function timetmp(arg_297_0)
	local var_297_0, var_297_1, var_297_2, var_297_3, var_297_4, var_297_5, var_297_6, var_297_7 = string.find(arg_297_0, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)")

	return (os.time({
		year = var_297_2,
		month = var_297_3,
		day = var_297_4,
		hour = var_297_5,
		min = var_297_6,
		sec = var_297_7
	}))
end

function leijia_yuan(arg_298_0)
	local var_298_0 = string.format(CC.R_GRP, arg_298_0)
	local var_298_1 = read_files(var_298_0, 0, 3000)
	local var_298_2 = string.len(var_298_1)
	local var_298_3 = byte10(var_298_1)
	local var_298_4 = leijiahe(var_298_3, var_298_2)
	local var_298_5 = read_files(var_298_0, 1856, 5196)
	local var_298_6 = string.len(var_298_5)
	local var_298_7 = byte10(var_298_5)

	return var_298_4 + leijiahe(var_298_7, var_298_6)
end
