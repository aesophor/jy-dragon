function SetGlobalConst()
	VK_ESCAPE = 27
	VK_SPACE = 32
	VK_RETURN = 13
	VK_F1 = 1073741882
	VK_F2 = 1073741883
	VK_F3 = 1073741884
	VK_F4 = 1073741885
	VK_A = 97
	VK_B = 98
	VK_C = 99
	VK_D = 100
	VK_E = 101
	VK_F = 102
	VK_G = 103
	VK_H = 104
	VK_I = 105
	VK_J = 106
	VK_K = 107
	VK_L = 108
	VK_M = 109
	VK_N = 110
	VK_O = 111
	VK_P = 112
	VK_Q = 113
	VK_R = 114
	VK_S = 115
	VK_T = 116
	VK_U = 117
	VK_V = 118
	VK_W = 119
	VK_X = 120
	VK_Y = 121
	VK_Z = 122
	VK_BACKSPACE = 8

	if CONFIG.Operation == 1 then
		VK_UP = 1073741906
		VK_DOWN = 1073741905
		VK_LEFT = 1073741904
		VK_RIGHT = 1073741903
		VK_SPACE = VK_RETURN
	else
		VK_UP = 273
		VK_DOWN = 274
		VK_LEFT = 276
		VK_RIGHT = 275
	end

	C_STARTMENU = RGB(132, 0, 4)
	C_RED = RGB(216, 20, 24)
	C_WHITE = RGB(236, 236, 236)
	C_ORANGE = RGB(252, 148, 16)
	C_GOLD = RGB(236, 200, 40)
	C_BLACK = RGB(0, 0, 0)
	M_Black = RGB(0, 0, 0)
	M_Sienna = RGB(160, 82, 45)
	M_DarkOliveGreen = RGB(85, 107, 47)
	M_DarkGreen = RGB(0, 100, 0)
	M_DarkSlateBlue = RGB(72, 61, 139)
	M_Navy = RGB(0, 0, 128)
	M_Indigo = RGB(75, 0, 130)
	M_DarkSlateGray = RGB(47, 79, 79)
	M_DarkRed = RGB(139, 0, 0)
	M_DarkOrange = RGB(255, 140, 0)
	M_Olive = RGB(128, 128, 0)
	M_Green = RGB(0, 128, 0)
	M_Teal = RGB(0, 128, 128)
	M_Blue = RGB(0, 0, 255)
	M_SlateGray = RGB(112, 128, 144)
	M_DimGray = RGB(105, 105, 105)
	M_Red = RGB(255, 0, 0)
	M_SandyBrown = RGB(244, 164, 96)
	M_YellowGreen = RGB(154, 205, 50)
	M_SeaGreen = RGB(46, 139, 87)
	M_MediumTurquoise = RGB(72, 209, 204)
	M_RoyalBlue = RGB(65, 105, 225)
	M_Purple = RGB(128, 0, 128)
	M_Gray = RGB(128, 128, 128)
	M_Magenta = RGB(255, 0, 255)
	M_Orange = RGB(255, 165, 0)
	M_Yellow = RGB(255, 255, 0)
	M_Lime = RGB(0, 255, 0)
	M_Cyan = RGB(0, 255, 255)
	M_DeepSkyBlue = RGB(0, 191, 255)
	M_DarkOrchid = RGB(153, 50, 204)
	M_Silver = RGB(192, 192, 192)
	M_Pink = RGB(255, 192, 203)
	M_Wheat = RGB(245, 222, 179)
	M_LemonChiffon = RGB(255, 250, 205)
	M_PaleGreen = RGB(152, 251, 152)
	M_PaleTurquoise = RGB(175, 238, 238)
	M_LightBlue = RGB(173, 216, 230)
	M_Plum = RGB(221, 160, 221)
	M_White = RGB(255, 255, 255)
	MilkWhite = RGB(255, 255, 204)
	LimeGreen = RGB(100, 200, 90)
	Lime = RGB(0, 255, 0)
	LightGreen = RGB(144, 238, 144)
	LightSkyBlue = RGB(135, 206, 250)
	green1 = RGB(145, 235, 45)
	OliveDrab = RGB(107, 142, 35)
	Snow3 = RGB(205, 201, 201)
	grey21 = RGB(54, 54, 54)
	LightSlateBlue = RGB(132, 112, 255)
	Violet = RGB(208, 152, 208)
	PinkRed = RGB(255, 102, 102)
	LightPurple = RGB(165, 28, 218)
	Color_Hurt1 = RGB(255, 215, 0)
	TG_Red = RGB(216, 20, 24)
	TG_Red_Bright = RGB(248, 40, 44)
	Dark_Gold = RGB(216, 180, 20)
	S_Yellow = RGB(245, 215, 15)
	GAME_START = 0
	GAME_FIRSTMMAP = 1
	GAME_MMAP = 2
	GAME_FIRSTSMAP = 3
	GAME_SMAP = 4
	GAME_WMAP = 5
	GAME_DEAD = 6
	GAME_END = 7
	CC = {}
	CC.ScreenW = lib.GetScreenW()
	CC.ScreenH = lib.GetScreenH()
	CC.SrcCharSet = CONFIG.CharSet
	CC.OSCharSet = 0
	CC.FontName = CONFIG.FontName
	CC.R_IDXFilename = {
		[0] = CONFIG.DataPath .. "ranger.idx"
	}
	CC.R_GRPFilename = {
		[0] = CONFIG.DataPath .. "ranger.grp"
	}
	CC.S_Filename = {
		[0] = CONFIG.DataPath .. "allsin.grp"
	}
	CC.D_Filename = {
		[0] = CONFIG.DataPath .. "alldef.grp"
	}
	CC.SavePath = CONFIG.DataPath .. "../save/"
	CC.R_GRP = CC.SavePath .. "r%d.grp"
	CC.S_GRP = CC.SavePath .. "s%d.grp"
	CC.D_GRP = CC.SavePath .. "d%d.grp"
	CC.SaveNum = 10
	CC.TempS_Filename = CONFIG.DataPath .. "allsinbk.grp"
	CC.Tempa_Filename = CONFIG.DataPath .. "alldefbk.grp"
	CC.PaletteFile = CONFIG.DataPath .. "mmap.col"
	CC.FirstFile1 = CONFIG.PicturePath .. "title1.png"
	CC.FirstFile2 = CONFIG.PicturePath .. "title2.png"
	CC.FirstFile3 = CONFIG.PicturePath .. "title3.png"
	CC.FirstFile4 = CONFIG.PicturePath .. "title4.png"
	CC.DeadFile = CONFIG.PicturePath .. "dead.png"
	CC.zhanFile = CONFIG.PicturePath .. "zhan.png"
	CC.weiFile = CONFIG.PicturePath .. "weixin.png"
	CC.zhuFile = CONFIG.PicturePath .. "zhanzhu.png"
	CC.MMapFile = {
		CONFIG.DataPath .. "earth.002",
		CONFIG.DataPath .. "surface.002",
		CONFIG.DataPath .. "building.002",
		CONFIG.DataPath .. "buildx.002",
		CONFIG.DataPath .. "buildy.002"
	}
	CC.MMAPPicFile = {
		CONFIG.DataPath .. "mmap.idx",
		CONFIG.DataPath .. "mmap.grp"
	}
	CC.SMAPPicFile = {
		CONFIG.DataPath .. "smap.idx",
		CONFIG.DataPath .. "smap.grp"
	}
	CC.WMAPPicFile = {
		CONFIG.DataPath .. "wmap.idx",
		CONFIG.DataPath .. "wmap.grp"
	}
	CC.EffectFile = {
		CONFIG.DataPath .. "eft/%d.idx",
		CONFIG.DataPath .. "eft/%d.grp"
	}
	CC.FightPicFile = {
		CONFIG.DataPath .. "fight/fight%03d.idx",
		CONFIG.DataPath .. "fight/fight%03d.grp"
	}
	CC.HeadPicFile = {
		CONFIG.DataPath .. "hdgrp.idx",
		CONFIG.DataPath .. "hdgrp.grp"
	}
	CC.HeadPath = CONFIG.DataPath .. "head/"
	CC.MHeadPath = CONFIG.DataPath .. "mhead/"
	CC.HeadNum = 1500
	CC.ThingPicFile = {
		CONFIG.DataPath .. "thing.idx",
		CONFIG.DataPath .. "thing.grp"
	}
	CC.DzPath = CONFIG.DataPath .. "dz/"
	CC.DzNum = 9

	if CONFIG.MP3 == 0 then
		CC.MIDIFile = CONFIG.SoundPath .. "game%02d.mid"
	else
		CC.MIDIFile = CONFIG.SoundPath .. "game%02d.mp3"
	end

	CC.OGGFile = CONFIG.SoundPath .. "game%02d.ogg"
	CC.ATKFile = CONFIG.SoundPath .. "atk%02d.wav"
	CC.EFile = CONFIG.SoundPath .. "e%02d.wav"
	CC.WarFile = CONFIG.DataPath .. "war.sta"
	CC.WarMapFile = {
		CONFIG.DataPath .. "warfld.idx",
		CONFIG.DataPath .. "warfld.grp"
	}
	CC.KRP = CONFIG.DataPath .. "kdef.grp"
	CC.KDX = CONFIG.DataPath .. "kdef.idx"
	CC.TRP = CONFIG.DataPath .. "talk.grp"
	CC.TDX = CONFIG.DataPath .. "talk.idx"
	CC.CircleFile = CONFIG.DataPath .. "CircleNum"
	CC.CircleNum = 1
	CC.dengdai = 1
	CC.TeamNum = 6
	CC.YbNum = 3
	CC.MyThingNum = 400
	CC.Base_S = {}
	CC.Base_S.乘船 = {
		0,
		0,
		2
	}
	CC.Base_S.存档标识 = {
		2,
		0,
		2
	}
	CC.Base_S.人X = {
		4,
		0,
		2
	}
	CC.Base_S.人Y = {
		6,
		0,
		2
	}
	CC.Base_S.人X1 = {
		8,
		0,
		2
	}
	CC.Base_S.人Y1 = {
		10,
		0,
		2
	}
	CC.Base_S.人方向 = {
		12,
		0,
		2
	}
	CC.Base_S.船X = {
		14,
		0,
		2
	}
	CC.Base_S.船Y = {
		16,
		0,
		2
	}
	CC.Base_S.船X1 = {
		18,
		0,
		2
	}
	CC.Base_S.船Y1 = {
		20,
		0,
		2
	}
	CC.Base_S.船方向 = {
		22,
		0,
		2
	}
	CC.Base_S.队友控制 = {
		24,
		0,
		2
	}
	CC.Base_S.金库 = {
		26,
		0,
		2
	}
	CC.Base_S.畅想编号 = {
		28,
		0,
		2
	}
	CC.Base_S.佣兵出战 = {
		30,
		0,
		2
	}
	CC.Base_S.游戏难度 = {
		32,
		0,
		2
	}
	CC.Base_S.主角职业 = {
		34,
		0,
		2
	}
	CC.Base_S.特殊主角 = {
		36,
		0,
		2
	}
	CC.Base_S.觉醒 = {
		38,
		0,
		2
	}
	CC.Base_S.二次觉醒 = {
		40,
		0,
		2
	}
	CC.Base_S.可领悟六如 = {
		42,
		0,
		2
	}
	CC.Base_S.自定义战斗 = {
		44,
		0,
		2
	}
	CC.Base_S.自定义我方人数 = {
		46,
		0,
		2
	}
	CC.Base_S.自定义敌方人数 = {
		48,
		0,
		2
	}
	CC.Base_S.暂存队伍 = {
		50,
		0,
		2
	}
	CC.Base_S.自定义我方 = {
		52,
		0,
		2
	}
	CC.Base_S.自定义敌方 = {
		54,
		0,
		2
	}
	CC.Base_S.血量显示 = {
		56,
		0,
		2
	}
	CC.Base_S.名字显示 = {
		58,
		0,
		2
	}

	for iter_1_0 = 1, CC.TeamNum do
		CC.Base_S["队伍" .. iter_1_0] = {
			60 + 2 * (iter_1_0 - 1),
			0,
			2
		}
	end

	for iter_1_1 = 1, CC.YbNum do
		CC.Base_S["佣兵" .. iter_1_1] = {
			72 + 2 * (iter_1_1 - 1),
			0,
			2
		}
	end

	CC.Base_S.宠物1 = {
		78,
		0,
		2
	}
	CC.Base_S.宠物2 = {
		80,
		0,
		2
	}
	CC.Base_S.宠物3 = {
		82,
		0,
		2
	}
	CC.Base_S.宠物4 = {
		84,
		0,
		2
	}
	CC.Base_S.随从1 = {
		86,
		0,
		2
	}
	CC.Base_S.随从2 = {
		88,
		0,
		2
	}
	CC.Base_S.随从3 = {
		90,
		0,
		2
	}
	CC.Base_S.随从4 = {
		92,
		0,
		2
	}
	CC.Base_S.轮回数1 = {
		94,
		0,
		2
	}
	CC.Base_S.轮回数2 = {
		96,
		0,
		2
	}
	CC.Base_S.电池数 = {
		98,
		0,
		2
	}
	CC.Base_S.百年标记 = {
		100,
		0,
		2
	}
	CC.Base_S.瓶颈标记 = {
		102,
		2,
		10
	}
	CC.Base_S.year = {
		112,
		0,
		2
	}
	CC.Base_S.无用2 = {
		114,
		0,
		2
	}
	CC.Base_S.无用3 = {
		116,
		0,
		2
	}
	CC.Base_S.无用4 = {
		118,
		0,
		2
	}
	CC.Base_S.无用5 = {
		120,
		0,
		2
	}
	CC.Base_S.无用6 = {
		122,
		0,
		2
	}

	for iter_1_2 = 1, 63 do
		CC.Base_S["无用" .. iter_1_2] = {
			124 + 2 * (iter_1_2 - 1),
			0,
			2
		}
	end

	for iter_1_3 = 1, CC.MyThingNum do
		CC.Base_S["物品" .. iter_1_3] = {
			250 + 4 * (iter_1_3 - 1),
			0,
			2
		}
		CC.Base_S["物品数量" .. iter_1_3] = {
			250 + 4 * (iter_1_3 - 1) + 2,
			0,
			2
		}
	end

	CC.PersonSize = 342
	CC.Person_S = {}
	CC.Person_S.姓名 = {
		0,
		2,
		10
	}
	CC.Person_S.天赋 = {
		10,
		0,
		2
	}
	CC.Person_S.天赋2 = {
		12,
		0,
		2
	}
	CC.Person_S.天赋3 = {
		14,
		0,
		2
	}
	CC.Person_S.天赋4 = {
		16,
		0,
		2
	}
	CC.Person_S.天赋5 = {
		18,
		0,
		2
	}
	CC.Person_S.头像代号 = {
		20,
		0,
		2
	}
	CC.Person_S.生命增长 = {
		22,
		0,
		2
	}
	CC.Person_S.称呼 = {
		24,
		2,
		10
	}
	CC.Person_S.根骨 = {
		34,
		0,
		2
	}
	CC.Person_S.气运 = {
		36,
		0,
		2
	}
	CC.Person_S.好感度 = {
		38,
		0,
		2
	}
	CC.Person_S.身世 = {
		40,
		0,
		2
	}
	CC.Person_S.主功体 = {
		42,
		0,
		2
	}
	CC.Person_S.副功体 = {
		44,
		0,
		2
	}
	CC.Person_S.主运轻功 = {
		46,
		0,
		2
	}
	CC.Person_S.性别 = {
		48,
		0,
		2
	}
	CC.Person_S.等级 = {
		50,
		0,
		2
	}
	CC.Person_S.经验 = {
		52,
		1,
		2
	}
	CC.Person_S.生命 = {
		54,
		0,
		2
	}
	CC.Person_S.生命最大值 = {
		56,
		0,
		2
	}
	CC.Person_S.受伤程度 = {
		58,
		0,
		2
	}
	CC.Person_S.中毒程度 = {
		60,
		0,
		2
	}
	CC.Person_S.体力 = {
		62,
		0,
		2
	}
	CC.Person_S.物品修炼点数 = {
		64,
		0,
		2
	}
	CC.Person_S.武器 = {
		66,
		0,
		2
	}
	CC.Person_S.防具 = {
		68,
		0,
		2
	}

	for iter_1_4 = 1, 5 do
		CC.Person_S["出招动画帧数" .. iter_1_4] = {
			70 + 2 * (iter_1_4 - 1),
			0,
			2
		}
		CC.Person_S["出招动画延迟" .. iter_1_4] = {
			80 + 2 * (iter_1_4 - 1),
			0,
			2
		}
		CC.Person_S["武功音效延迟" .. iter_1_4] = {
			90 + 2 * (iter_1_4 - 1),
			0,
			2
		}
	end

	CC.Person_S.内力性质 = {
		100,
		0,
		2
	}
	CC.Person_S.内力 = {
		102,
		0,
		2
	}
	CC.Person_S.内力最大值 = {
		104,
		0,
		2
	}
	CC.Person_S.攻击力 = {
		106,
		0,
		2
	}
	CC.Person_S.轻功 = {
		108,
		0,
		2
	}
	CC.Person_S.防御力 = {
		110,
		0,
		2
	}
	CC.Person_S.医疗能力 = {
		112,
		0,
		2
	}
	CC.Person_S.用毒能力 = {
		114,
		0,
		2
	}
	CC.Person_S.解毒能力 = {
		116,
		0,
		2
	}
	CC.Person_S.抗毒能力 = {
		118,
		0,
		2
	}
	CC.Person_S.拳掌功夫 = {
		120,
		0,
		2
	}
	CC.Person_S.御剑能力 = {
		122,
		0,
		2
	}
	CC.Person_S.耍刀技巧 = {
		124,
		0,
		2
	}
	CC.Person_S.特殊兵器 = {
		126,
		0,
		2
	}
	CC.Person_S.暗器技巧 = {
		128,
		0,
		2
	}
	CC.Person_S.武学常识 = {
		130,
		0,
		2
	}
	CC.Person_S.品德 = {
		132,
		0,
		2
	}
	CC.Person_S.攻击带毒 = {
		134,
		0,
		2
	}
	CC.Person_S.左右互搏 = {
		136,
		0,
		2
	}
	CC.Person_S.声望 = {
		138,
		0,
		2
	}
	CC.Person_S.悟性 = {
		140,
		0,
		2
	}
	CC.Person_S.修炼物品 = {
		142,
		0,
		2
	}
	CC.Person_S.修炼点数 = {
		144,
		0,
		2
	}

	for iter_1_5 = 1, 20 do
		CC.Person_S["武功" .. iter_1_5] = {
			146 + 2 * (iter_1_5 - 1),
			0,
			2
		}
		CC.Person_S["武功等级" .. iter_1_5] = {
			186 + 2 * (iter_1_5 - 1),
			0,
			2
		}
	end

	for iter_1_6 = 1, 4 do
		CC.Person_S["携带物品" .. iter_1_6] = {
			226 + 2 * (iter_1_6 - 1),
			0,
			2
		}
		CC.Person_S["携带物品数量" .. iter_1_6] = {
			234 + 2 * (iter_1_6 - 1),
			0,
			2
		}
	end

	CC.Person_S.连击率 = {
		242,
		0,
		2
	}
	CC.Person_S.暴击率 = {
		244,
		0,
		2
	}
	CC.Person_S.门派 = {
		246,
		0,
		2
	}
	CC.Person_S.门派等级 = {
		248,
		0,
		2
	}
	CC.Person_S.佛学修为 = {
		250,
		0,
		2
	}
	CC.Person_S.阵法知识 = {
		252,
		0,
		2
	}
	CC.Person_S.性格 = {
		254,
		0,
		2
	}
	CC.Person_S.江湖经验 = {
		256,
		0,
		2
	}
	CC.Person_S.盗贼技巧 = {
		258,
		0,
		2
	}
	CC.Person_S.魅力 = {
		260,
		0,
		2
	}
	CC.Person_S.初始天赋级别 = {
		262,
		2,
		10
	}
	CC.Person_S.副功体显示 = {
		272,
		2,
		10
	}
	CC.Person_S.畅想级别 = {
		282,
		0,
		2
	}
	CC.Person_S.官阶 = {
		284,
		0,
		2
	}
	CC.Person_S.精神 = {
		286,
		0,
		2
	}
	CC.Person_S.天赋外功1 = {
		288,
		0,
		2
	}
	CC.Person_S.天赋外功2 = {
		290,
		0,
		2
	}
	CC.Person_S.天赋内功 = {
		292,
		0,
		2
	}
	CC.Person_S.天赋轻功 = {
		294,
		0,
		2
	}
	CC.Person_S.儒学修为 = {
		296,
		0,
		2
	}
	CC.Person_S.罪恶值 = {
		298,
		0,
		2
	}
	CC.Person_S.功德值 = {
		300,
		0,
		2
	}
	CC.Person_S.门派贡献 = {
		302,
		0,
		2
	}
	CC.Person_S.实战 = {
		304,
		0,
		2
	}
	CC.Person_S.驱虫术 = {
		306,
		0,
		2
	}
	CC.Person_S.中火毒 = {
		308,
		0,
		2
	}
	CC.Person_S.中冰毒 = {
		310,
		0,
		2
	}
	CC.Person_S.中封穴 = {
		312,
		0,
		2
	}
	CC.Person_S.流血值 = {
		314,
		0,
		2
	}
	CC.Person_S.中原罪恶值 = {
		316,
		0,
		2
	}
	CC.Person_S.宋罪恶值 = {
		318,
		0,
		2
	}
	CC.Person_S.清罪恶值 = {
		320,
		0,
		2
	}
	CC.Person_S.战斗控制 = {
		322,
		0,
		2
	}
	CC.Person_S.战斗模式 = {
		324,
		0,
		2
	}
	CC.Person_S.喜使武功 = {
		326,
		0,
		2
	}
	CC.Person_S.饰品 = {
		328,
		0,
		2
	}
	CC.Person_S.坐骑 = {
		330,
		0,
		2
	}
	CC.Person_S.无用1 = {
		332,
		0,
		2
	}
	CC.Person_S.无用2 = {
		334,
		0,
		2
	}
	CC.Person_S.无用3 = {
		336,
		0,
		2
	}
	CC.Person_S.无用4 = {
		338,
		0,
		2
	}
	CC.Person_S.无用5 = {
		340,
		0,
		2
	}
	CC.ThingSize = 378
	CC.Thing_S = {}
	CC.Thing_S.代号 = {
		0,
		0,
		2
	}
	CC.Thing_S.名称 = {
		2,
		2,
		20
	}
	CC.Thing_S.名称2 = {
		22,
		2,
		20
	}
	CC.Thing_S.物品说明 = {
		42,
		2,
		100
	}
	CC.Thing_S.练出武功 = {
		142,
		0,
		2
	}
	CC.Thing_S.暗器动画编号 = {
		144,
		0,
		2
	}
	CC.Thing_S.使用人 = {
		146,
		0,
		2
	}
	CC.Thing_S.显示物品说明 = {
		148,
		0,
		2
	}
	CC.Thing_S.类型 = {
		150,
		0,
		2
	}
	CC.Thing_S.物品等级 = {
		152,
		0,
		2
	}
	CC.Thing_S.装备类型 = {
		154,
		0,
		2
	}
	CC.Thing_S.物品价值 = {
		156,
		0,
		2
	}
	CC.Thing_S.未知7 = {
		158,
		0,
		2
	}
	CC.Thing_S.加生命 = {
		160,
		0,
		2
	}
	CC.Thing_S.加生命最大值 = {
		162,
		0,
		2
	}
	CC.Thing_S.加中毒解毒 = {
		164,
		0,
		2
	}
	CC.Thing_S.加体力 = {
		166,
		0,
		2
	}
	CC.Thing_S.改变内力性质 = {
		168,
		0,
		2
	}
	CC.Thing_S.加内力 = {
		170,
		0,
		2
	}
	CC.Thing_S.加内力最大值 = {
		172,
		0,
		2
	}
	CC.Thing_S.加攻击力 = {
		174,
		0,
		2
	}
	CC.Thing_S.加轻功 = {
		176,
		0,
		2
	}
	CC.Thing_S.加防御力 = {
		178,
		0,
		2
	}
	CC.Thing_S.加医疗能力 = {
		180,
		0,
		2
	}
	CC.Thing_S.加用毒能力 = {
		182,
		0,
		2
	}
	CC.Thing_S.加解毒能力 = {
		184,
		0,
		2
	}
	CC.Thing_S.加抗毒能力 = {
		186,
		0,
		2
	}
	CC.Thing_S.加拳掌功夫 = {
		188,
		0,
		2
	}
	CC.Thing_S.加御剑能力 = {
		190,
		0,
		2
	}
	CC.Thing_S.加耍刀技巧 = {
		192,
		0,
		2
	}
	CC.Thing_S.加特殊兵器 = {
		194,
		0,
		2
	}
	CC.Thing_S.加暗器技巧 = {
		196,
		0,
		2
	}
	CC.Thing_S.加武学常识 = {
		198,
		0,
		2
	}
	CC.Thing_S.加品德 = {
		200,
		0,
		2
	}
	CC.Thing_S.加攻击次数 = {
		202,
		0,
		2
	}
	CC.Thing_S.加攻击带毒 = {
		204,
		0,
		2
	}
	CC.Thing_S.仅修炼人物 = {
		206,
		0,
		2
	}
	CC.Thing_S.需内力性质 = {
		208,
		0,
		2
	}
	CC.Thing_S.需内力 = {
		210,
		0,
		2
	}
	CC.Thing_S.需攻击力 = {
		212,
		0,
		2
	}
	CC.Thing_S.需轻功 = {
		214,
		0,
		2
	}
	CC.Thing_S.需用毒能力 = {
		216,
		0,
		2
	}
	CC.Thing_S.需医疗能力 = {
		218,
		0,
		2
	}
	CC.Thing_S.需解毒能力 = {
		220,
		0,
		2
	}
	CC.Thing_S.需拳掌功夫 = {
		222,
		0,
		2
	}
	CC.Thing_S.需御剑能力 = {
		224,
		0,
		2
	}
	CC.Thing_S.需耍刀技巧 = {
		226,
		0,
		2
	}
	CC.Thing_S.需特殊兵器 = {
		228,
		0,
		2
	}
	CC.Thing_S.需暗器技巧 = {
		230,
		0,
		2
	}
	CC.Thing_S.需悟性 = {
		232,
		0,
		2
	}
	CC.Thing_S.需经验 = {
		234,
		0,
		2
	}
	CC.Thing_S.练出物品需经验 = {
		236,
		0,
		2
	}
	CC.Thing_S.需材料 = {
		238,
		0,
		2
	}

	for iter_1_7 = 1, 5 do
		CC.Thing_S["练出物品" .. iter_1_7] = {
			240 + 2 * (iter_1_7 - 1),
			0,
			2
		}
		CC.Thing_S["需要物品数量" .. iter_1_7] = {
			250 + 2 * (iter_1_7 - 1),
			0,
			2
		}
	end

	CC.Thing_S.加魅力 = {
		260,
		0,
		2
	}
	CC.Thing_S.加精神 = {
		262,
		0,
		2
	}
	CC.Thing_S.加气运 = {
		264,
		0,
		2
	}
	CC.Thing_S.无用 = {
		266,
		0,
		2
	}
	CC.Thing_S.无用 = {
		268,
		0,
		2
	}
	CC.Thing_S.无用 = {
		270,
		0,
		2
	}
	CC.Thing_S.加冰毒解毒 = {
		272,
		0,
		2
	}
	CC.Thing_S.加火毒解毒 = {
		274,
		0,
		2
	}
	CC.Thing_S.止血 = {
		276,
		0,
		2
	}
	CC.Thing_S.无用46 = {
		278,
		2,
		100
	}
	CC.SceneSize = 58
	CC.Scene_S = {}
	CC.Scene_S.代号 = {
		0,
		0,
		2
	}
	CC.Scene_S.名称 = {
		2,
		2,
		10
	}
	CC.Scene_S.出门音乐 = {
		12,
		0,
		2
	}
	CC.Scene_S.进门音乐 = {
		14,
		0,
		2
	}
	CC.Scene_S.跳转场景 = {
		16,
		0,
		2
	}
	CC.Scene_S.进入条件 = {
		18,
		0,
		2
	}
	CC.Scene_S.外景入口X1 = {
		20,
		0,
		2
	}
	CC.Scene_S.外景入口Y1 = {
		22,
		0,
		2
	}
	CC.Scene_S.外景入口X2 = {
		24,
		0,
		2
	}
	CC.Scene_S.外景入口Y2 = {
		26,
		0,
		2
	}
	CC.Scene_S.入口X = {
		28,
		0,
		2
	}
	CC.Scene_S.入口Y = {
		30,
		0,
		2
	}
	CC.Scene_S.出口X1 = {
		32,
		0,
		2
	}
	CC.Scene_S.出口X2 = {
		34,
		0,
		2
	}
	CC.Scene_S.出口X3 = {
		36,
		0,
		2
	}
	CC.Scene_S.出口Y1 = {
		38,
		0,
		2
	}
	CC.Scene_S.出口Y2 = {
		40,
		0,
		2
	}
	CC.Scene_S.出口Y3 = {
		42,
		0,
		2
	}
	CC.Scene_S.跳转口X1 = {
		44,
		0,
		2
	}
	CC.Scene_S.跳转口Y1 = {
		46,
		0,
		2
	}
	CC.Scene_S.跳转口X2 = {
		48,
		0,
		2
	}
	CC.Scene_S.跳转口Y2 = {
		50,
		0,
		2
	}
	CC.Scene_S.场景大小 = {
		52,
		0,
		2
	}
	CC.Scene_S.场景类型 = {
		54,
		0,
		2
	}
	CC.Scene_S.马车开通 = {
		56,
		0,
		2
	}
	CC.WugongSize = 186
	CC.Wugong_S = {}
	CC.Wugong_S.代号 = {
		0,
		0,
		2
	}
	CC.Wugong_S.名称 = {
		2,
		2,
		10
	}
	CC.Wugong_S.武功等级 = {
		12,
		0,
		2
	}
	CC.Wugong_S.武功属性 = {
		14,
		0,
		2
	}
	CC.Wugong_S.增幅攻击等级 = {
		16,
		0,
		2
	}
	CC.Wugong_S.增幅防御等级 = {
		18,
		0,
		2
	}
	CC.Wugong_S.增幅轻功等级 = {
		20,
		0,
		2
	}
	CC.Wugong_S.出招音效 = {
		22,
		0,
		2
	}
	CC.Wugong_S.武功类型 = {
		24,
		0,
		2
	}
	CC.Wugong_S["武功动画&音效"] = {
		26,
		0,
		2
	}
	CC.Wugong_S.伤害类型 = {
		28,
		0,
		2
	}
	CC.Wugong_S.攻击范围 = {
		30,
		0,
		2
	}
	CC.Wugong_S.消耗内力点数 = {
		32,
		0,
		2
	}
	CC.Wugong_S.敌人中毒点数 = {
		34,
		0,
		2
	}

	for iter_1_8 = 1, 10 do
		CC.Wugong_S["攻击力" .. iter_1_8] = {
			36 + 2 * (iter_1_8 - 1),
			0,
			2
		}
		CC.Wugong_S["移动范围" .. iter_1_8] = {
			56 + 2 * (iter_1_8 - 1),
			0,
			2
		}
		CC.Wugong_S["杀伤范围" .. iter_1_8] = {
			76 + 2 * (iter_1_8 - 1),
			0,
			2
		}
		CC.Wugong_S["加内力" .. iter_1_8] = {
			96 + 2 * (iter_1_8 - 1),
			0,
			2
		}
		CC.Wugong_S["杀内力" .. iter_1_8] = {
			116 + 2 * (iter_1_8 - 1),
			0,
			2
		}
	end

	CC.Wugong_S.内伤 = {
		136,
		0,
		2
	}
	CC.Wugong_S.迟缓 = {
		138,
		0,
		2
	}
	CC.Wugong_S.流血 = {
		140,
		0,
		2
	}
	CC.Wugong_S.火毒 = {
		142,
		0,
		2
	}
	CC.Wugong_S.冰冻 = {
		144,
		0,
		2
	}
	CC.Wugong_S.封穴 = {
		146,
		0,
		2
	}
	CC.Wugong_S.连击率 = {
		148,
		0,
		2
	}
	CC.Wugong_S["3连击率"] = {
		150,
		0,
		2
	}
	CC.Wugong_S.暴击率 = {
		152,
		0,
		2
	}
	CC.Wugong_S.增加集气速度 = {
		154,
		0,
		2
	}
	CC.Wugong_S.恢复集气 = {
		156,
		0,
		2
	}
	CC.Wugong_S.时序回复生命 = {
		158,
		0,
		2
	}
	CC.Wugong_S.时序回复内力 = {
		160,
		0,
		2
	}
	CC.Wugong_S.时序解毒 = {
		162,
		0,
		2
	}
	CC.Wugong_S.时序回内伤 = {
		164,
		0,
		2
	}
	CC.Wugong_S.时序回迟缓 = {
		166,
		0,
		2
	}
	CC.Wugong_S.时序回流血 = {
		168,
		0,
		2
	}
	CC.Wugong_S.时序解火毒 = {
		170,
		0,
		2
	}
	CC.Wugong_S.时序解冰冻 = {
		172,
		0,
		2
	}
	CC.Wugong_S.时序解封穴 = {
		174,
		0,
		2
	}
	CC.Wugong_S.无用 = {
		176,
		0,
		2
	}
	CC.Wugong_S.无用 = {
		178,
		0,
		2
	}
	CC.Wugong_S.无用 = {
		180,
		0,
		2
	}
	CC.Wugong_S.无用 = {
		182,
		0,
		2
	}
	CC.Wugong_S.无用 = {
		184,
		0,
		2
	}
	CC.ShopSize = 36
	CC.Shop_S = {}

	for iter_1_9 = 1, 6 do
		CC.Shop_S["物品" .. iter_1_9] = {
			0 + 2 * (iter_1_9 - 1),
			0,
			2
		}
		CC.Shop_S["物品数量" .. iter_1_9] = {
			12 + 2 * (iter_1_9 - 1),
			0,
			2
		}
		CC.Shop_S["物品价格" .. iter_1_9] = {
			24 + 2 * (iter_1_9 - 1),
			0,
			2
		}
	end

	CC.ShopScene = {}
	CC.ShopScene[0] = {
		d_shop = 16,
		sceneid = 1,
		d_leave = {
			17,
			18
		}
	}
	CC.ShopScene[1] = {
		d_shop = 14,
		sceneid = 3,
		d_leave = {
			15,
			16
		}
	}
	CC.ShopScene[2] = {
		d_shop = 20,
		sceneid = 40,
		d_leave = {
			21,
			22
		}
	}
	CC.ShopScene[3] = {
		d_shop = 9,
		sceneid = 61,
		d_leave = {
			10,
			11
		}
	}
	CC.ShopScene[4] = {
		d_shop = 20,
		sceneid = 96,
		d_leave = {
			17,
			18
		}
	}
	CC.ShopScene[5] = {
		d_shop = 0,
		sceneid = 121,
		d_leave = {
			17,
			18
		}
	}
	CC.MWidth = 480
	CC.MHeight = 480
	CC.SWidth = 64
	CC.SHeight = 64
	CC.DNum = 200
	CC.XScale = CONFIG.XScale
	CC.YScale = CONFIG.YScale
	CC.Base_S.血量显示 = CONFIG.Blood
	CC.Base_S.名字显示 = CONFIG.NameXS
	CC.Frame = 30
	CC.SceneMoveFrame = CC.Frame * 2
	CC.PersonMoveFrame = CC.Frame * 2
	CC.AnimationFrame = CC.Frame * 3
	CC.WarAutoDelay = 300
	-- [port] ms to hold each battle effect-text frame; see jywar.lua.
	CC.EffectTextMS = tonumber(os.getenv('JY_EFFECT_TEXT_MS')) or 40
	CC.DirectX = {
		0,
		1,
		-1,
		0
	}
	CC.DirectY = {
		-1,
		0,
		0,
		1
	}
	CC.MyStartPicM = 2501
	CC.MyStartPicF = 5001
	CC.MyStartPicH = 5340
	CC.BoatStartPic = 3715
	CC.Level = 30
	CC.Exp = {
		[0] = 0,
		50,
		150,
		300,
		500,
		750,
		1050,
		1400,
		1800,
		2250,
		2750,
		3850,
		5050,
		6350,
		7750,
		9250,
		10850,
		12550,
		14350,
		16750,
		18250,
		21400,
		24700,
		28150,
		31750,
		35500,
		39400,
		43450,
		47650,
		52000,
		60000
	}
	CC.MMapBoat = {}

	local var_1_0 = {
		{
			358,
			362
		},
		{
			374,
			380
		},
		{
			458,
			464
		},
		{
			506,
			610
		},
		{
			1016,
			1022
		}
	}

	for iter_1_10, iter_1_11 in ipairs(var_1_0) do
		for iter_1_12 = iter_1_11[1], iter_1_11[2], 2 do
			CC.MMapBoat[iter_1_12] = 1
		end
	end

	CC.SceneWater = {}

	local var_1_1 = {
		{
			358,
			362
		},
		{
			374,
			380
		},
		{
			458,
			464
		},
		{
			506,
			610
		},
		{
			818,
			824
		},
		{
			838,
			838
		},
		{
			934,
			936
		},
		{
			1016,
			1022
		},
		{
			1324,
			1348
		}
	}

	for iter_1_13, iter_1_14 in ipairs(var_1_1) do
		for iter_1_15 = iter_1_14[1], iter_1_14[2], 2 do
			CC.SceneWater[iter_1_15] = 1
		end
	end

	CC.WarWater = {}

	local var_1_2 = {
		{
			358,
			362
		},
		{
			374,
			380
		},
		{
			458,
			464
		},
		{
			506,
			610
		},
		{
			818,
			824
		},
		{
			838,
			838
		},
		{
			934,
			936
		},
		{
			1016,
			1022
		},
		{
			1324,
			1348
		}
	}

	for iter_1_16, iter_1_17 in ipairs(var_1_2) do
		for iter_1_18 = iter_1_17[1], iter_1_17[2], 2 do
			CC.WarWater[iter_1_18] = 1
		end
	end

	CC.PersonExit = {
		{
			1,
			1250
		},
		{
			2,
			1252
		},
		{
			4,
			1254
		},
		{
			9,
			2680
		},
		{
			16,
			2686
		},
		{
			17,
			110
		},
		{
			25,
			112
		},
		{
			27,
			2218
		},
		{
			28,
			2220
		},
		{
			29,
			116
		},
		{
			30,
			2380
		},
		{
			35,
			2210
		},
		{
			36,
			2214
		},
		{
			37,
			1892
		},
		{
			38,
			2202
		},
		{
			44,
			128
		},
		{
			45,
			3204
		},
		{
			47,
			3210
		},
		{
			48,
			3208
		},
		{
			49,
			3206
		},
		{
			51,
			138
		},
		{
			52,
			1890
		},
		{
			53,
			3202
		},
		{
			54,
			1780
		},
		{
			55,
			146
		},
		{
			56,
			148
		},
		{
			58,
			150
		},
		{
			59,
			152
		},
		{
			61,
			2382
		},
		{
			63,
			154
		},
		{
			66,
			156
		},
		{
			72,
			158
		},
		{
			73,
			2212
		},
		{
			74,
			1450
		},
		{
			75,
			1452
		},
		{
			76,
			166
		},
		{
			77,
			1684
		},
		{
			78,
			170
		},
		{
			79,
			2216
		},
		{
			80,
			1454
		},
		{
			81,
			2682
		},
		{
			82,
			178
		},
		{
			83,
			1782
		},
		{
			84,
			182
		},
		{
			85,
			2204
		},
		{
			86,
			1686
		},
		{
			87,
			2684
		},
		{
			88,
			190
		},
		{
			89,
			192
		},
		{
			90,
			194
		},
		{
			91,
			1784
		},
		{
			92,
			198
		},
		{
			632,
			1256
		},
		{
			633,
			1258
		},
		{
			587,
			1688
		},
		{
			588,
			1680
		},
		{
			589,
			1894
		},
		{
			590,
			1456
		},
		{
			600,
			1682
		}
	}
	CC.AllPersonExit = {
		{
			1,
			5
		},
		{
			2,
			6
		},
		{
			4,
			21
		},
		{
			9,
			17
		},
		{
			16,
			31
		},
		{
			17,
			32
		},
		{
			25,
			28
		},
		{
			28,
			29
		},
		{
			29,
			26
		},
		{
			30,
			13
		},
		{
			35,
			15
		},
		{
			36,
			25
		},
		{
			37,
			{
				7,
				8
			}
		},
		{
			38,
			{
				16,
				58
			}
		},
		{
			44,
			33
		},
		{
			45,
			12
		},
		{
			47,
			23
		},
		{
			48,
			24
		},
		{
			49,
			{
				10,
				11
			}
		},
		{
			51,
			22
		},
		{
			52,
			41
		},
		{
			53,
			9
		},
		{
			54,
			18
		},
		{
			55,
			13
		},
		{
			56,
			14
		},
		{
			58,
			19
		},
		{
			59,
			20
		},
		{
			63,
			30
		},
		{
			66,
			38
		},
		{
			72,
			40
		},
		{
			73,
			35
		},
		{
			74,
			36
		},
		{
			75,
			37
		},
		{
			76,
			27
		},
		{
			77,
			39
		},
		{
			78,
			59
		},
		{
			79,
			42
		},
		{
			80,
			52
		},
		{
			81,
			46
		},
		{
			82,
			54
		},
		{
			83,
			55
		},
		{
			84,
			34
		},
		{
			85,
			47
		},
		{
			86,
			49
		},
		{
			87,
			50
		},
		{
			88,
			43
		},
		{
			89,
			44
		},
		{
			90,
			53
		},
		{
			91,
			51
		},
		{
			92,
			1
		},
		{
			589,
			80
		},
		{
			590,
			86
		},
		{
			591,
			47
		}
	}
	CC.BookNum = 14
	CC.BookStart = 144
	CC.MoneyID = 174
	CC.Shemale = {
		[78] = 1,
		[93] = 1
	}
	CC.Effect = {
		[0] = 9,
		14,
		17,
		9,
		13,
		17,
		17,
		17,
		18,
		19,
		19,
		15,
		13,
		10,
		10,
		15,
		21,
		16,
		9,
		11,
		8,
		9,
		8,
		8,
		7,
		8,
		8,
		9,
		12,
		19,
		11,
		14,
		12,
		17,
		8,
		11,
		10,
		13,
		10,
		19,
		14,
		17,
		19,
		14,
		21,
		16,
		13,
		18,
		14,
		17,
		17,
		16,
		7,
		12,
		40,
		16,
		9,
		15,
		15,
		31,
		38,
		24,
		26,
		24,
		20,
		12,
		17,
		14,
		14,
		10,
		10,
		18,
		31,
		12,
		7,
		6,
		7,
		28,
		16,
		7,
		16,
		20,
		15,
		13,
		15,
		11,
		11,
		11,
		20,
		20,
		20,
		17,
		17,
		17,
		9,
		8,
		8,
		17,
		10,
		11,
		8,
		9,
		24,
		18,
		27
	}
	CC.ExtraOffense = {
		{
			52,
			75,
			200
		},
		{
			53,
			84,
			100
		},
		{
			50,
			86,
			150
		},
		{
			45,
			67,
			100
		},
		{
			54,
			175,
			200
		},
		{
			54,
			68,
			250
		},
		{
			51,
			69,
			300
		},
		{
			37,
			41,
			150
		},
		{
			49,
			80,
			200
		},
		{
			44,
			63,
			150
		},
		{
			47,
			59,
			200
		},
		{
			40,
			40,
			250
		},
		{
			36,
			45,
			150
		}
	}
	CC.NewPersonName = CONFIG.PlayName

	if CC.NewPersonName == nil then
		CC.NewPersonName = "grgame"
	end

	CC.NewGameSceneID = 70
	CC.NewGameSceneX = 16
	CC.NewGameSceneY = 31
	CC.NewPersonPicM = 2515
	CC.NewPersonPicF = 5015
	CC.PersonAttribMax = {}
	CC.PersonAttribMax.经验 = 60000
	CC.PersonAttribMax.物品修炼点数 = 30000
	CC.PersonAttribMax.修炼点数 = 30000
	CC.PersonAttribMax.生命增长 = 18
	CC.PersonAttribMax.生命最大值 = 1800
	CC.PersonAttribMax.受伤程度 = 100
	CC.PersonAttribMax.中毒程度 = 200
	CC.PersonAttribMax.流血值 = 100
	CC.PersonAttribMax.中火毒 = 100
	CC.PersonAttribMax.中冰毒 = 100
	CC.PersonAttribMax.中封穴 = 100
	CC.PersonAttribMax.内力最大值 = 10000
	CC.PersonAttribMax.体力 = 100
	CC.PersonAttribMax.攻击力 = 999
	CC.PersonAttribMax.防御力 = 999
	CC.PersonAttribMax.轻功 = 999
	CC.PersonAttribMax.医疗能力 = 250
	CC.PersonAttribMax.用毒能力 = 250
	CC.PersonAttribMax.解毒能力 = 200
	CC.PersonAttribMax.抗毒能力 = 99
	CC.PersonAttribMax.拳掌功夫 = 500
	CC.PersonAttribMax.御剑能力 = 500
	CC.PersonAttribMax.耍刀技巧 = 500
	CC.PersonAttribMax.特殊兵器 = 500
	CC.PersonAttribMax.暗器技巧 = 500
	CC.PersonAttribMax.武学常识 = 200
	CC.PersonAttribMax.盗贼技巧 = 200
	CC.PersonAttribMax.阵法知识 = 200
	CC.PersonAttribMax.儒学修为 = 200
	CC.PersonAttribMax.佛学修为 = 200
	CC.PersonAttribMax.品德 = 200
	CC.PersonAttribMax.声望 = 500
	CC.PersonAttribMax.悟性 = 100
	CC.PersonAttribMax.好感度 = 100
	CC.PersonAttribMax.门派贡献 = 10000
	CC.PersonAttribMax.攻击带毒 = 100
	CC.PersonAttribMax.实战 = 2000
	CC.WarDataSize = 186
	CC.WarData_S = {}
	CC.WarData_S.代号 = {
		0,
		0,
		2
	}
	CC.WarData_S.名称 = {
		2,
		2,
		10
	}
	CC.WarData_S.地图 = {
		12,
		0,
		2
	}
	CC.WarData_S.经验 = {
		14,
		0,
		2
	}
	CC.WarData_S.音乐 = {
		16,
		0,
		2
	}

	for iter_1_19 = 1, 6 do
		CC.WarData_S["手动选择参战人" .. iter_1_19] = {
			18 + (iter_1_19 - 1) * 2,
			0,
			2
		}
		CC.WarData_S["自动选择参战人" .. iter_1_19] = {
			30 + (iter_1_19 - 1) * 2,
			0,
			2
		}
		CC.WarData_S["我方X" .. iter_1_19] = {
			42 + (iter_1_19 - 1) * 2,
			0,
			2
		}
		CC.WarData_S["我方Y" .. iter_1_19] = {
			54 + (iter_1_19 - 1) * 2,
			0,
			2
		}
	end

	for iter_1_20 = 1, 20 do
		CC.WarData_S["敌人" .. iter_1_20] = {
			66 + (iter_1_20 - 1) * 2,
			0,
			2
		}
		CC.WarData_S["敌方X" .. iter_1_20] = {
			106 + (iter_1_20 - 1) * 2,
			0,
			2
		}
		CC.WarData_S["敌方Y" .. iter_1_20] = {
			146 + (iter_1_20 - 1) * 2,
			0,
			2
		}
	end

	CC.WarWidth = 64
	CC.WarHeight = 64
	CC.ShowXY = 1
	CC.MenuBorderPixel = 5
	CC.DefaultFont = math.modf(math.min(CC.ScreenW, CC.ScreenH) / 320 * 16)
	CC.SmallFont = CC.DefaultFont * 3 / 4
	CC.FontBIGBIG = math.modf(CC.DefaultFont * 10)
	CC.FontBIG = math.modf(CC.DefaultFont * 1.6)
	CC.FontBig = math.modf(CC.DefaultFont * 1.4)
	CC.Fontbig = math.modf(CC.DefaultFont * 1.2)
	CC.Fontsmall = math.modf(CC.DefaultFont * 0.8)
	CC.FontSmall = math.modf(CC.DefaultFont * 0.6)
	CC.FontSmall1 = math.modf(CC.DefaultFont * 0.65)
	CC.FontSmall2 = math.modf(CC.DefaultFont * 0.75)
	CC.FontSmall3 = math.modf(CC.DefaultFont * 0.85)
	CC.FontSmall4 = math.modf(CC.DefaultFont * 0.9)
	CC.FontSmall5 = math.modf(CC.DefaultFont * 0.92)
	CC.FontSMALL = math.modf(CC.DefaultFont * 0.4)
	CC.RowPixel = math.modf(math.min(CC.ScreenW, CC.ScreenH) / 100)
	CC.StartMenuFontSize = CC.DefaultFont
	CC.NewGameFontSize = CC.DefaultFont
	CC.MainMenuX = 10
	CC.MainMenuY = 10
	CC.GameOverX = 90
	CC.GameOverY = 65
	CC.PersonStateRowPixel = 1
	CC.ThingFontSize = CC.Fontsmall
	CC.ThingPicWidth = math.modf(40 * CONFIG.Zoom / 100)
	CC.ThingPicHeight = CC.ThingPicWidth

	if math.modf(CC.ScreenW / CC.ThingPicWidth - 2) < 10 then
		CC.MenuThingXnum = 8
	else
		CC.MenuThingXnum = 8
	end

	if math.modf(CC.ScreenH / CC.ThingPicHeight - 2) < 5 then
		CC.MenuThingYnum = 3
	else
		CC.MenuThingYnum = 3
	end

	CC.ThingGapOut = 10
	CC.ThingGapIn = 10
	CC.StartMenuY = CC.ScreenH - 5 * (CC.StartMenuFontSize + CC.RowPixel) - 20  -- [port] was 3; too close to the bottom edge
	CC.NewGameY = CC.ScreenH - 4 * (CC.NewGameFontSize + CC.RowPixel) - 10
	CC.MainSubMenuX = CC.MainMenuX + 2 * CC.MenuBorderPixel + 2 * CC.DefaultFont + 5
	CC.MainSubMenuY = CC.MainMenuY
	CC.MainSubMenuX2 = CC.MainSubMenuX + 2 * CC.MenuBorderPixel + 4 * CC.DefaultFont + 5
	CC.SingleLineHeight = CC.DefaultFont + 2 * CC.MenuBorderPixel + 5
	CC.StartThingPic = 0
	CC.TeamNum = 6
	CC.MyThingNum = 400
	CC.Kungfunum = 20
	CC.MyTeamNum = 57
	CC.PersonWs = {
		{
			113,
			43
		},
		{
			58,
			45
		},
		{
			58,
			25
		},
		{
			589,
			114
		},
		{
			115,
			72
		},
		{
			1,
			67
		},
		{
			2,
			3
		},
		{
			3,
			44
		},
		{
			4,
			67
		},
		{
			5,
			16
		},
		{
			5,
			46
		},
		{
			6,
			41
		},
		{
			7,
			37
		},
		{
			8,
			23
		},
		{
			9,
			106
		},
		{
			10,
			38
		},
		{
			11,
			18
		},
		{
			12,
			4
		},
		{
			13,
			92
		},
		{
			13,
			23
		},
		{
			14,
			5
		},
		{
			15,
			83
		},
		{
			16,
			1
		},
		{
			17,
			1
		},
		{
			18,
			19
		},
		{
			19,
			34
		},
		{
			19,
			48
		},
		{
			20,
			32
		},
		{
			21,
			30
		},
		{
			22,
			33
		},
		{
			23,
			31
		},
		{
			24,
			27
		},
		{
			25,
			69
		},
		{
			26,
			21
		},
		{
			27,
			105
		},
		{
			28,
			1
		},
		{
			29,
			55
		},
		{
			30,
			53
		},
		{
			31,
			38
		},
		{
			32,
			71
		},
		{
			33,
			72
		},
		{
			34,
			73
		},
		{
			35,
			47
		},
		{
			36,
			48
		},
		{
			37,
			94
		},
		{
			37,
			114
		},
		{
			38,
			102
		},
		{
			39,
			102
		},
		{
			40,
			102
		},
		{
			38,
			96
		},
		{
			39,
			103
		},
		{
			40,
			101
		},
		{
			41,
			103
		},
		{
			42,
			103
		},
		{
			43,
			35
		},
		{
			44,
			75
		},
		{
			45,
			1
		},
		{
			46,
			21
		},
		{
			47,
			5
		},
		{
			48,
			21
		},
		{
			49,
			8
		},
		{
			50,
			26
		},
		{
			51,
			43
		},
		{
			52,
			70
		},
		{
			53,
			49
		},
		{
			54,
			40
		},
		{
			55,
			26
		},
		{
			56,
			80
		},
		{
			57,
			18
		},
		{
			57,
			12
		},
		{
			57,
			38
		},
		{
			59,
			42
		},
		{
			60,
			104
		},
		{
			61,
			9
		},
		{
			62,
			103
		},
		{
			63,
			38
		},
		{
			64,
			15
		},
		{
			65,
			17
		},
		{
			66,
			97
		},
		{
			67,
			13
		},
		{
			68,
			39
		},
		{
			69,
			26
		},
		{
			70,
			22
		},
		{
			71,
			86
		},
		{
			72,
			28
		},
		{
			73,
			73
		},
		{
			74,
			29
		},
		{
			75,
			10
		},
		{
			76,
			1
		},
		{
			78,
			11
		},
		{
			79,
			34
		},
		{
			80,
			36
		},
		{
			81,
			17
		},
		{
			82,
			7
		},
		{
			83,
			3
		},
		{
			84,
			103
		},
		{
			85,
			3
		},
		{
			86,
			30
		},
		{
			87,
			78
		},
		{
			88,
			3
		},
		{
			89,
			56
		},
		{
			90,
			51
		},
		{
			91,
			28
		},
		{
			77,
			62
		},
		{
			77,
			54
		},
		{
			92,
			62
		},
		{
			93,
			45
		},
		{
			97,
			63
		},
		{
			98,
			17
		},
		{
			99,
			33
		},
		{
			100,
			5
		},
		{
			102,
			49
		},
		{
			103,
			66
		},
		{
			106,
			59
		},
		{
			107,
			60
		},
		{
			108,
			60
		},
		{
			109,
			34
		},
		{
			112,
			24
		},
		{
			113,
			43
		},
		{
			114,
			108
		},
		{
			116,
			8
		},
		{
			117,
			101
		},
		{
			117,
			8
		},
		{
			118,
			98
		},
		{
			118,
			14
		},
		{
			123,
			39
		},
		{
			124,
			39
		},
		{
			125,
			39
		},
		{
			126,
			39
		},
		{
			127,
			39
		},
		{
			128,
			39
		},
		{
			129,
			39
		},
		{
			129,
			100
		},
		{
			130,
			86
		},
		{
			131,
			7
		},
		{
			132,
			78
		},
		{
			133,
			53
		},
		{
			134,
			10
		},
		{
			135,
			41
		},
		{
			136,
			29
		},
		{
			137,
			167
		},
		{
			138,
			78
		},
		{
			139,
			28
		},
		{
			140,
			47
		},
		{
			141,
			34
		},
		{
			142,
			34
		},
		{
			143,
			69
		},
		{
			144,
			69
		},
		{
			145,
			69
		},
		{
			146,
			69
		},
		{
			147,
			69
		},
		{
			148,
			69
		},
		{
			149,
			108
		},
		{
			150,
			37
		},
		{
			151,
			90
		},
		{
			152,
			38
		},
		{
			153,
			16
		},
		{
			154,
			54
		},
		{
			155,
			69
		},
		{
			156,
			69
		},
		{
			157,
			74
		},
		{
			158,
			78
		},
		{
			159,
			86
		},
		{
			160,
			86
		},
		{
			161,
			3
		},
		{
			162,
			13
		},
		{
			163,
			78
		},
		{
			164,
			18
		},
		{
			165,
			17
		},
		{
			166,
			37
		},
		{
			167,
			23
		},
		{
			168,
			23
		},
		{
			169,
			22
		},
		{
			170,
			20
		},
		{
			171,
			46
		},
		{
			172,
			36
		},
		{
			173,
			93
		},
		{
			174,
			93
		},
		{
			175,
			93
		},
		{
			176,
			69
		},
		{
			184,
			44
		},
		{
			185,
			44
		},
		{
			186,
			13
		},
		{
			187,
			13
		},
		{
			188,
			41
		},
		{
			189,
			90
		},
		{
			400,
			65
		},
		{
			401,
			20
		},
		{
			440,
			95
		},
		{
			458,
			80
		},
		{
			459,
			26
		},
		{
			451,
			56
		},
		{
			452,
			74
		},
		{
			453,
			55
		},
		{
			454,
			69
		},
		{
			506,
			160
		},
		{
			507,
			189
		},
		{
			588,
			59
		},
		{
			589,
			168
		},
		{
			591,
			35
		},
		{
			593,
			86
		},
		{
			598,
			63
		},
		{
			599,
			114
		},
		{
			601,
			20
		},
		{
			610,
			21
		},
		{
			611,
			21
		},
		{
			612,
			22
		},
		{
			613,
			82
		},
		{
			614,
			82
		},
		{
			615,
			82
		},
		{
			616,
			77
		}
	}
	CC.PersonWg = {
		{
			1,
			67
		},
		{
			2,
			3
		},
		{
			3,
			44
		},
		{
			4,
			67
		},
		{
			5,
			16
		},
		{
			6,
			41
		},
		{
			7,
			37
		},
		{
			8,
			23
		},
		{
			9,
			106
		},
		{
			10,
			38
		},
		{
			11,
			18
		},
		{
			12,
			4
		},
		{
			13,
			92
		},
		{
			14,
			5
		},
		{
			15,
			83
		},
		{
			16,
			1
		},
		{
			17,
			1
		},
		{
			18,
			19
		},
		{
			19,
			48
		},
		{
			20,
			32
		},
		{
			21,
			30
		},
		{
			22,
			33
		},
		{
			23,
			31
		},
		{
			24,
			27
		},
		{
			25,
			69
		},
		{
			26,
			21
		},
		{
			27,
			105
		},
		{
			28,
			1
		},
		{
			29,
			55
		},
		{
			30,
			53
		},
		{
			31,
			38
		},
		{
			32,
			71
		},
		{
			33,
			72
		},
		{
			34,
			73
		},
		{
			35,
			47
		},
		{
			36,
			48
		},
		{
			37,
			94
		},
		{
			38,
			102
		},
		{
			39,
			102
		},
		{
			40,
			102
		},
		{
			41,
			103
		},
		{
			42,
			103
		},
		{
			43,
			35
		},
		{
			44,
			75
		},
		{
			45,
			1
		},
		{
			46,
			21
		},
		{
			47,
			5
		},
		{
			48,
			21
		},
		{
			49,
			8
		},
		{
			50,
			26
		},
		{
			51,
			43
		},
		{
			52,
			70
		},
		{
			53,
			49
		},
		{
			54,
			40
		},
		{
			55,
			26
		},
		{
			56,
			80
		},
		{
			57,
			18
		},
		{
			58,
			45
		},
		{
			59,
			42
		},
		{
			60,
			104
		},
		{
			61,
			9
		},
		{
			62,
			103
		},
		{
			63,
			38
		},
		{
			64,
			15
		},
		{
			65,
			17
		},
		{
			66,
			97
		},
		{
			67,
			13
		},
		{
			68,
			39
		},
		{
			69,
			26
		},
		{
			70,
			22
		},
		{
			71,
			86
		},
		{
			72,
			28
		},
		{
			73,
			73
		},
		{
			74,
			29
		},
		{
			75,
			10
		},
		{
			76,
			1
		},
		{
			78,
			11
		},
		{
			79,
			34
		},
		{
			80,
			36
		},
		{
			81,
			17
		},
		{
			82,
			7
		},
		{
			83,
			3
		},
		{
			84,
			103
		},
		{
			85,
			3
		},
		{
			86,
			30
		},
		{
			87,
			78
		},
		{
			88,
			3
		},
		{
			89,
			56
		},
		{
			90,
			51
		},
		{
			91,
			28
		},
		{
			77,
			62
		},
		{
			92,
			62
		},
		{
			97,
			63
		},
		{
			98,
			17
		},
		{
			99,
			33
		},
		{
			100,
			5
		},
		{
			102,
			49
		},
		{
			103,
			66
		},
		{
			106,
			59
		},
		{
			107,
			60
		},
		{
			108,
			60
		},
		{
			109,
			34
		},
		{
			112,
			24
		},
		{
			113,
			43
		},
		{
			114,
			108
		},
		{
			116,
			8
		},
		{
			117,
			101
		},
		{
			118,
			98
		},
		{
			123,
			39
		},
		{
			124,
			39
		},
		{
			125,
			39
		},
		{
			126,
			39
		},
		{
			127,
			39
		},
		{
			128,
			39
		},
		{
			129,
			100
		},
		{
			130,
			86
		},
		{
			131,
			7
		},
		{
			132,
			78
		},
		{
			133,
			53
		},
		{
			134,
			10
		},
		{
			135,
			41
		},
		{
			136,
			29
		},
		{
			137,
			167
		},
		{
			138,
			78
		},
		{
			139,
			28
		},
		{
			140,
			47
		},
		{
			141,
			34
		},
		{
			142,
			34
		},
		{
			143,
			69
		},
		{
			144,
			69
		},
		{
			145,
			69
		},
		{
			146,
			69
		},
		{
			147,
			69
		},
		{
			148,
			69
		},
		{
			149,
			108
		},
		{
			150,
			37
		},
		{
			151,
			90
		},
		{
			152,
			38
		},
		{
			153,
			16
		},
		{
			154,
			54
		},
		{
			155,
			69
		},
		{
			156,
			69
		},
		{
			157,
			74
		},
		{
			158,
			78
		},
		{
			159,
			86
		},
		{
			160,
			86
		},
		{
			161,
			3
		},
		{
			162,
			13
		},
		{
			163,
			78
		},
		{
			164,
			18
		},
		{
			165,
			17
		},
		{
			166,
			37
		},
		{
			167,
			23
		},
		{
			168,
			23
		},
		{
			169,
			22
		},
		{
			170,
			20
		},
		{
			171,
			46
		},
		{
			172,
			36
		},
		{
			173,
			93
		},
		{
			174,
			93
		},
		{
			175,
			93
		},
		{
			176,
			69
		},
		{
			184,
			44
		},
		{
			185,
			44
		},
		{
			186,
			13
		},
		{
			187,
			13
		},
		{
			188,
			41
		},
		{
			189,
			90
		},
		{
			589,
			114
		},
		{
			590,
			1
		},
		{
			591,
			35
		},
		{
			593,
			86
		},
		{
			598,
			63
		},
		{
			599,
			36
		}
	}
	CC.PersonTf = {
		{
			5001,
			"身轻如燕",
			"集气速度+5"
		},
		{
			5002,
			"风驰电骋",
			"集气速度+10"
		},
		{
			5003,
			"心想事成",
			"特效几率+5"
		},
		{
			5004,
			"天命加身",
			"特效几率+10"
		},
		{
			5005,
			"料敌先机",
			"初始集气+200"
		},
		{
			5006,
			"神出鬼没",
			"初始集气+400"
		},
		{
			5007,
			"身若清风",
			"行动后集气+50"
		},
		{
			5008,
			"攻若奔雷",
			"行动后集气+100"
		},
		{
			5009,
			"心若猛虎",
			"行动后集气+150"
		},
		{
			5010,
			"奔若狂龙",
			"行动后集气+200"
		},
		{
			5011,
			"护体罡气",
			"内功护体机率+15"
		},
		{
			5012,
			"气若坚壁",
			"内功护体机率+30"
		},
		{
			5013,
			"神力加身",
			"内功加力机率+15"
		},
		{
			5014,
			"气若悬河",
			"内功加力机率+30"
		},
		{
			5015,
			"拳法初成",
			"拳法伤害+5%"
		},
		{
			5016,
			"拳法小成",
			"拳法伤害+10%"
		},
		{
			5017,
			"拳法大成",
			"拳法伤害+15%"
		},
		{
			5018,
			"拳法通灵",
			"拳法伤害+20%"
		},
		{
			5019,
			"剑法初成",
			"剑法伤害+5%"
		},
		{
			5020,
			"剑法小成",
			"剑法伤害+10%"
		},
		{
			5021,
			"剑法大成",
			"剑法伤害+15%"
		},
		{
			5022,
			"剑法通灵",
			"剑法伤害+20%"
		},
		{
			5023,
			"刀法初成",
			"刀法伤害+5%"
		},
		{
			5024,
			"刀法小成",
			"刀法伤害+10%"
		},
		{
			5025,
			"刀法大成",
			"刀法伤害+15%"
		},
		{
			5026,
			"刀法通灵",
			"刀法伤害+20%"
		},
		{
			5027,
			"奇兵初成",
			"特殊伤害+5%"
		},
		{
			5028,
			"奇兵小成",
			"特殊伤害+10%"
		},
		{
			5029,
			"奇兵大成",
			"特殊伤害+15%"
		},
		{
			5030,
			"奇兵通灵",
			"特殊伤害+20%"
		},
		{
			5031,
			"内力小成",
			"每内功到十级减少伤害2%"
		},
		{
			5032,
			"内力大成",
			"每内功到十级减少伤害3%"
		},
		{
			5033,
			"拳意初成",
			"拳法集气伤害+10%"
		},
		{
			5034,
			"拳意小成",
			"拳法集气伤害+20%"
		},
		{
			5035,
			"拳意大成",
			"拳法集气伤害+30%"
		},
		{
			5036,
			"拳意通神",
			"拳法集气伤害+40%"
		},
		{
			5037,
			"剑意初成",
			"剑法集气伤害+10%"
		},
		{
			5038,
			"剑意小成",
			"剑法集气伤害+20%"
		},
		{
			5039,
			"剑意大成",
			"剑法集气伤害+30%"
		},
		{
			5040,
			"剑意通神",
			"剑法集气伤害+40%"
		},
		{
			5041,
			"刀意初成",
			"刀法集气伤害+10%"
		},
		{
			5042,
			"刀意小成",
			"刀法集气伤害+20%"
		},
		{
			5043,
			"刀意大成",
			"刀法集气伤害+30%"
		},
		{
			5044,
			"刀意通神",
			"刀法集气伤害+40%"
		},
		{
			5045,
			"百兵初成",
			"特殊集气伤害+10%"
		},
		{
			5046,
			"百兵小成",
			"特殊集气伤害+20%"
		},
		{
			5047,
			"百兵大成",
			"特殊集气伤害+30%"
		},
		{
			5048,
			"百兵通神",
			"特殊集气伤害+40%"
		},
		{
			5049,
			"气贯双臂",
			"每内功到十级，使用内功攻击增加集气伤害25"
		},
		{
			5050,
			"气随意动",
			"每内功到十级，使用内功攻击增加集气伤害50"
		},
		{
			5051,
			"杏林好手",
			"医疗能力上限+100"
		},
		{
			5052,
			"悬壶济世",
			"医疗能力上限+200"
		},
		{
			5053,
			"毒名远播",
			"用毒能力上限+100"
		},
		{
			5054,
			"寸草不生",
			"用毒能力上限+200"
		},
		{
			5055,
			"天生拳者",
			"可无条件学习拳法秘籍（除六脉、降龙）"
		},
		{
			5056,
			"天生剑士",
			"可无条件学习剑法秘籍（除独孤）"
		},
		{
			5057,
			"天生刀客",
			"可无条件学习刀法秘籍"
		},
		{
			5058,
			"天生百兵",
			"可无条件学习特殊秘籍"
		},
		{
			5059,
			"六脉齐发",
			"可无条件学习六脉神剑秘籍，提高招式机率"
		},
		{
			5060,
			"独孤真传",
			"可无条件学习独孤九剑秘籍，可触发极意"
		},
		{
			5061,
			"星移斗转",
			"可无条件学习斗转星移秘籍，提高触发机率"
		},
		{
			5062,
			"降龙盖世",
			"可无条件学习降龙十八掌秘籍，可触发极意"
		},
		{
			5063,
			"天资充盈",
			"学习秘籍四系系数要求降低10"
		},
		{
			5064,
			"二脉贯通",
			"可无视内力性质学习武功秘籍"
		},
		{
			5065,
			"气血旺盛",
			"生命最大值上限+100"
		},
		{
			5066,
			"超凡体质",
			"生命最大值上限+200"
		},
		{
			5067,
			"内力雄厚",
			"内力最大值上限+750"
		},
		{
			5068,
			"经脉贯通",
			"内力最大值上限+1500"
		},
		{
			5069,
			"吞天噬地",
			"大幅提高吸功触发几率"
		},
		{
			5070,
			"面红耳赤",
			"怒气上升额外增加2"
		},
		{
			5071,
			"怒气勃发",
			"怒气上升额外增加3"
		},
		{
			5072,
			"怒发冲冠",
			"怒气上升额外增加4"
		},
		{
			5073,
			"众志成城",
			"我方伤害增加10%"
		},
		{
			5074,
			"万众一心",
			"我方伤害减少10%"
		},
		{
			5075,
			"勇往直前",
			"我方集气速度增加10%"
		},
		{
			5076,
			"凶神恶煞",
			"敌方集气速度减少10%"
		},
		{
			5077,
			"辩脉忍穴",
			"封穴机率+30"
		},
		{
			5078,
			"千疮百孔",
			"流血几率+30"
		},
		{
			5079,
			"攻敌必救",
			"可对敌人造成冰封"
		},
		{
			5080,
			"以力破巧",
			"暴击伤害为双倍"
		},
		{
			5081,
			"暴烈一击",
			"暴击几率+10"
		},
		{
			5082,
			"暴烈强击",
			"暴击几率+15"
		},
		{
			5083,
			"暴击灭魂",
			"暴击几率+20"
		},
		{
			5084,
			"飞燕连击",
			"连击几率+10"
		},
		{
			5085,
			"连绵不绝",
			"连击几率+15"
		},
		{
			5086,
			"一瞬千击",
			"连击几率+20"
		},
		{
			5087,
			"妙手连环",
			"连击伤害不减"
		},
		{
			5088,
			"战神附体",
			"连击时必暴击"
		},
		{
			5089,
			"兵器精通",
			"无视条件装备兵器"
		},
		{
			5090,
			"偷奸耍滑",
			"消耗体力-2"
		},
		{
			5091,
			"审时度势",
			"消耗体力-3"
		},
		{
			5092,
			"养精蓄锐",
			"消耗体力-4"
		},
		{
			5093,
			"劈空",
			"内功加力时伤害增加50%"
		},
		{
			5094,
			"流转",
			"内功护体时伤害减少30%"
		},
		{
			5095,
			"天生武痴",
			"每回合增加伤害5%"
		},
		{
			5096,
			"财运滚滚",
			"战场上10%机率捡到钱，可重复捡"
		},
		{
			5097,
			"追魂夺命",
			"机率造成小兵即死，非小兵额外伤害100"
		},
		{
			5098,
			"化元归一",
			"被攻击机率恢复生命80"
		},
		{
			5099,
			"本性卑劣",
			"攻击时无视毒抗上毒"
		},
		{
			5100,
			"移花接木",
			"攻击者受到伤害"
		},
		{
			5101,
			"重若泰山",
			"攻击造成内伤翻倍"
		},
		{
			5102,
			"轻若鸿毛",
			"被攻击所受内伤减半"
		},
		{
			5103,
			"死而复生",
			"死亡后半血重生"
		},
		{
			5104,
			"武中无相",
			"提高普通招式触发几率，普通招式集气杀伤力翻倍"
		},
		{
			5105,
			"七步断肠",
			"使用知名毒药，使全场敌人中毒"
		},
		{
			5106,
			"悲酥清风",
			"使用知名毒药，使全场敌人减少内力"
		},
		{
			5107,
			"三笑逍遥",
			"使用知名毒药，使全场敌人减少生命"
		},
		{
			5108,
			"观海听涛",
			"被攻击时几率触发敌方集气全体后退"
		},
		{
			5109,
			"碧海潮生",
			"攻击时几率触发敌方集气全体后退"
		},
		{
			5110,
			"怒海争锋",
			"被攻击时几率触发我方集气全体前进"
		},
		{
			5111,
			"断肢重生",
			"每回合恢复生命"
		},
		{
			5112,
			"聚气归还",
			"每回合恢复内力"
		},
		{
			5113,
			"风起云涌",
			"被攻击后有几率提高集气速度"
		},
		{
			5114,
			"云龙三现",
			"被攻击有几率使集气不减反增，可与太玄叠加"
		},
		{
			5115,
			"血战到底",
			"生命越低伤害越高"
		},
		{
			5116,
			"铜皮铁骨",
			"被攻击时几率触发，伤害减少五十点"
		},
		{
			5117,
			"踏雪无痕",
			"移动距离+2"
		},
		{
			5118,
			"身似游龙",
			"移动距离最小值固定为5格"
		},
		{
			5119,
			"博览群书【攻】",
			"学习秘籍攻击力成长翻倍"
		},
		{
			5120,
			"博览群书【轻】",
			"学习秘籍轻功成长翻倍"
		},
		{
			5121,
			"博览群书【防】",
			"学习秘籍防御力成长翻倍"
		},
		{
			5122,
			"博览群书【拳】",
			"学习秘籍拳掌功夫成长翻倍"
		},
		{
			5123,
			"博览群书【剑】",
			"学习秘籍御剑能力成长翻倍"
		},
		{
			5124,
			"博览群书【刀】",
			"学习秘籍耍刀技巧成长翻倍"
		},
		{
			5125,
			"博览群书【特】",
			"学习秘籍特殊兵器成长翻倍"
		},
		{
			5126,
			"天赋异禀",
			"升级时额外增加四系系数"
		},
		{
			5127,
			"天降鸿福",
			"升级时额外增加属性"
		},
		{
			5128,
			"笨鸟先飞",
			"左右互搏机率+10"
		},
		{
			5129,
			"傻人傻福",
			"左右互搏机率+20"
		},
		{
			5130,
			"风云变幻",
			"当连击时低几率变为三连击"
		},
		{
			5131,
			"截血断脉",
			"几率触发定身攻击"
		},
		{
			5132,
			"蓄势待发",
			"蓄力效果增强"
		},
		{
			5133,
			"铜墙铁壁",
			"防御效果增强"
		}
	}
	CC.AddAtk = {
		{
			10,
			15,
			50
		},
		{
			11,
			15,
			50
		},
		{
			12,
			15,
			50
		},
		{
			13,
			15,
			50
		},
		{
			14,
			15,
			50
		},
		{
			48,
			47,
			100
		},
		{
			47,
			50,
			100
		},
		{
			53,
			76,
			100
		},
		{
			90,
			53,
			100
		},
		{
			79,
			36,
			60
		},
		{
			74,
			75,
			50
		},
		{
			59,
			58,
			100
		},
		{
			54,
			91,
			100
		},
		{
			99,
			70,
			100
		},
		{
			119,
			65,
			50
		},
		{
			120,
			65,
			50
		},
		{
			121,
			65,
			50
		},
		{
			122,
			65,
			50
		},
		{
			68,
			129,
			50
		},
		{
			123,
			129,
			50
		},
		{
			124,
			129,
			50
		},
		{
			125,
			129,
			50
		},
		{
			126,
			129,
			50
		},
		{
			127,
			129,
			50
		},
		{
			128,
			129,
			50
		},
		{
			143,
			144,
			30
		},
		{
			143,
			145,
			30
		},
		{
			143,
			146,
			30
		},
		{
			143,
			147,
			30
		},
		{
			143,
			148,
			30
		},
		{
			144,
			145,
			30
		},
		{
			144,
			146,
			30
		},
		{
			144,
			147,
			30
		},
		{
			144,
			148,
			30
		},
		{
			145,
			146,
			30
		},
		{
			145,
			147,
			30
		},
		{
			145,
			148,
			30
		},
		{
			146,
			147,
			30
		},
		{
			146,
			148,
			30
		},
		{
			147,
			148,
			30
		},
		{
			130,
			131,
			30
		},
		{
			130,
			132,
			30
		},
		{
			130,
			133,
			30
		},
		{
			130,
			134,
			30
		},
		{
			130,
			135,
			30
		},
		{
			130,
			136,
			30
		},
		{
			131,
			130,
			30
		},
		{
			131,
			132,
			30
		},
		{
			131,
			133,
			30
		},
		{
			131,
			134,
			30
		},
		{
			131,
			135,
			30
		},
		{
			131,
			136,
			30
		},
		{
			132,
			130,
			30
		},
		{
			132,
			131,
			30
		},
		{
			132,
			133,
			30
		},
		{
			132,
			134,
			30
		},
		{
			132,
			135,
			30
		},
		{
			132,
			136,
			30
		},
		{
			133,
			130,
			30
		},
		{
			133,
			131,
			30
		},
		{
			133,
			132,
			30
		},
		{
			133,
			134,
			30
		},
		{
			133,
			135,
			30
		},
		{
			133,
			136,
			30
		},
		{
			134,
			130,
			30
		},
		{
			134,
			131,
			30
		},
		{
			134,
			132,
			30
		},
		{
			134,
			133,
			30
		},
		{
			134,
			135,
			30
		},
		{
			134,
			136,
			30
		},
		{
			135,
			130,
			30
		},
		{
			135,
			131,
			30
		},
		{
			135,
			132,
			30
		},
		{
			135,
			133,
			30
		},
		{
			135,
			134,
			30
		},
		{
			135,
			136,
			30
		},
		{
			136,
			130,
			30
		},
		{
			136,
			131,
			30
		},
		{
			136,
			132,
			30
		},
		{
			136,
			133,
			30
		},
		{
			136,
			134,
			30
		},
		{
			136,
			135,
			30
		},
		{
			162,
			163,
			100
		},
		{
			163,
			162,
			100
		},
		{
			72,
			4,
			100
		},
		{
			4,
			72,
			100
		},
		{
			37,
			589,
			50
		},
		{
			589,
			37,
			50
		}
	}
	CC.AddDef = {
		{
			76,
			51,
			100
		},
		{
			55,
			56,
			50
		},
		{
			56,
			55,
			100
		},
		{
			35,
			73,
			100
		},
		{
			79,
			36,
			60
		},
		{
			73,
			35,
			50
		},
		{
			74,
			75,
			50
		},
		{
			58,
			59,
			50
		},
		{
			59,
			58,
			50
		},
		{
			66,
			9,
			50
		},
		{
			91,
			54,
			100
		},
		{
			90,
			53,
			50
		},
		{
			53,
			90,
			100
		},
		{
			53,
			90,
			50
		},
		{
			119,
			65,
			50
		},
		{
			120,
			65,
			50
		},
		{
			121,
			65,
			50
		},
		{
			122,
			65,
			50
		},
		{
			68,
			129,
			50
		},
		{
			143,
			144,
			30
		},
		{
			143,
			145,
			30
		},
		{
			143,
			146,
			30
		},
		{
			143,
			147,
			30
		},
		{
			143,
			148,
			30
		},
		{
			144,
			145,
			30
		},
		{
			144,
			146,
			30
		},
		{
			144,
			147,
			30
		},
		{
			144,
			148,
			30
		},
		{
			145,
			146,
			30
		},
		{
			145,
			147,
			30
		},
		{
			145,
			148,
			30
		},
		{
			146,
			147,
			30
		},
		{
			146,
			148,
			30
		},
		{
			147,
			148,
			30
		},
		{
			130,
			131,
			30
		},
		{
			130,
			132,
			30
		},
		{
			130,
			133,
			30
		},
		{
			130,
			134,
			30
		},
		{
			130,
			135,
			30
		},
		{
			130,
			136,
			30
		},
		{
			131,
			130,
			30
		},
		{
			131,
			132,
			30
		},
		{
			131,
			133,
			30
		},
		{
			131,
			134,
			30
		},
		{
			131,
			135,
			30
		},
		{
			131,
			136,
			30
		},
		{
			132,
			130,
			30
		},
		{
			132,
			131,
			30
		},
		{
			132,
			133,
			30
		},
		{
			132,
			134,
			30
		},
		{
			132,
			135,
			30
		},
		{
			132,
			136,
			30
		},
		{
			133,
			130,
			30
		},
		{
			133,
			131,
			30
		},
		{
			133,
			132,
			30
		},
		{
			133,
			134,
			30
		},
		{
			133,
			135,
			30
		},
		{
			133,
			136,
			30
		},
		{
			134,
			130,
			30
		},
		{
			134,
			131,
			30
		},
		{
			134,
			132,
			30
		},
		{
			134,
			133,
			30
		},
		{
			134,
			135,
			30
		},
		{
			134,
			136,
			30
		},
		{
			135,
			130,
			30
		},
		{
			135,
			131,
			30
		},
		{
			135,
			132,
			30
		},
		{
			135,
			133,
			30
		},
		{
			135,
			134,
			30
		},
		{
			135,
			136,
			30
		},
		{
			136,
			130,
			30
		},
		{
			136,
			131,
			30
		},
		{
			136,
			132,
			30
		},
		{
			136,
			133,
			30
		},
		{
			136,
			134,
			30
		},
		{
			136,
			135,
			30
		},
		{
			123,
			129,
			50
		},
		{
			124,
			129,
			50
		},
		{
			125,
			129,
			50
		},
		{
			126,
			129,
			50
		},
		{
			127,
			129,
			50
		},
		{
			128,
			129,
			50
		},
		{
			162,
			163,
			100
		},
		{
			163,
			162,
			100
		},
		{
			72,
			4,
			100
		},
		{
			4,
			72,
			100
		},
		{
			37,
			589,
			50
		},
		{
			589,
			37,
			50
		}
	}
	CC.AddSpd = {
		{
			25,
			35,
			50
		},
		{
			90,
			53,
			50
		},
		{
			55,
			56,
			100
		},
		{
			90,
			53,
			100
		},
		{
			56,
			55,
			50
		},
		{
			72,
			4,
			100
		},
		{
			4,
			72,
			100
		},
		{
			35,
			79,
			100
		},
		{
			73,
			35,
			50
		},
		{
			74,
			75,
			50
		},
		{
			162,
			163,
			100
		},
		{
			163,
			162,
			100
		},
		{
			143,
			144,
			30
		},
		{
			143,
			145,
			30
		},
		{
			143,
			146,
			30
		},
		{
			143,
			147,
			30
		},
		{
			143,
			148,
			30
		},
		{
			144,
			145,
			30
		},
		{
			144,
			146,
			30
		},
		{
			144,
			147,
			30
		},
		{
			144,
			148,
			30
		},
		{
			145,
			146,
			30
		},
		{
			145,
			147,
			30
		},
		{
			145,
			148,
			30
		},
		{
			146,
			147,
			30
		},
		{
			146,
			148,
			30
		},
		{
			147,
			148,
			30
		},
		{
			130,
			131,
			30
		},
		{
			130,
			132,
			30
		},
		{
			130,
			133,
			30
		},
		{
			130,
			134,
			30
		},
		{
			130,
			135,
			30
		},
		{
			130,
			136,
			30
		},
		{
			131,
			130,
			30
		},
		{
			131,
			132,
			30
		},
		{
			131,
			133,
			30
		},
		{
			131,
			134,
			30
		},
		{
			131,
			135,
			30
		},
		{
			131,
			136,
			30
		},
		{
			132,
			130,
			30
		},
		{
			132,
			131,
			30
		},
		{
			132,
			133,
			30
		},
		{
			132,
			134,
			30
		},
		{
			132,
			135,
			30
		},
		{
			132,
			136,
			30
		},
		{
			133,
			130,
			30
		},
		{
			133,
			131,
			30
		},
		{
			133,
			132,
			30
		},
		{
			133,
			134,
			30
		},
		{
			133,
			135,
			30
		},
		{
			133,
			136,
			30
		},
		{
			134,
			130,
			30
		},
		{
			134,
			131,
			30
		},
		{
			134,
			132,
			30
		},
		{
			134,
			133,
			30
		},
		{
			134,
			135,
			30
		},
		{
			134,
			136,
			30
		},
		{
			135,
			130,
			30
		},
		{
			135,
			131,
			30
		},
		{
			135,
			132,
			30
		},
		{
			135,
			133,
			30
		},
		{
			135,
			134,
			30
		},
		{
			135,
			136,
			30
		},
		{
			136,
			130,
			30
		},
		{
			136,
			131,
			30
		},
		{
			136,
			132,
			30
		},
		{
			136,
			133,
			30
		},
		{
			136,
			134,
			30
		},
		{
			136,
			135,
			30
		},
		{
			58,
			59,
			100
		},
		{
			63,
			58,
			60
		},
		{
			83,
			54,
			50
		},
		{
			589,
			37,
			50
		}
	}
	CC.AddDoc = {
		{
			2,
			1,
			120
		},
		{
			16,
			17,
			50
		}
	}
	CC.AddPoi = {
		{
			17,
			16,
			50
		}
	}
	CC.Color = {
		R = C_RED,
		G = M_Green,
		B = M_Blue
	}

	require("MyOEvent")

	WZ = "未知"
	WZ1 = "未知1"
	WZ2 = "未知2"
	WZ3 = "未知3"
	WZ4 = "未知4"
	WZ5 = "未知5"
	WZ6 = "未知6"
	WZ7 = "未知7"
	GZM = {
		"二",
		"三",
		"四",
		"五",
		"六",
		"七",
		"八",
		"九",
		"十"
	}
	GZMYZM = {
		0,
		3185,
		7293
	}
	SZB = {
		[0] = "零",
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
		"十一",
		"十二",
		"十三",
		"十四",
		"十五",
		"十六",
		"十七",
		"十八",
		"十九",
		"二十"
	}
	LMSJ = {
		"少商剑",
		"商阳剑",
		"中冲剑",
		"关冲剑",
		"少冲剑",
		"少泽剑"
	}
	XL18 = {
		"亢龙有悔",
		"见龙在田",
		"飞龙在天",
		"双龙出水",
		"神龙摆尾",
		"潜龙勿用"
	}
	XL18JY = {
		"极意--亢龙·鸿渐於陆",
		"极意--飞龙·或跃在渊",
		"极意--潜龙·密雨不云",
		"极意--神龙·震惊百里",
		"极意--见龙·利涉大川",
		"极意--双龙·突如其来",
		"极意--六龙·履霜冰至",
		"极意--龙战·损则有孚"
	}
	HDZC = {
		"真传·云龙三现",
		"秘技·上步摘星刀",
		"秘技·鹞子翻身刀"
	}
	TFSSJ = {
		"·『天道惊雷憾』",
		"·『一剑镇神洲』",
		"·『羽葬煌炎斩』",
		"·『千机龙绝闪』",
		"·『斗焰罡霸体』",
		"·『侠行天下』",
		"·『八门聚万象』",
		"·『荼毒天下』",
		"·『幽暗地狱』"
	}
	ZJTF = {
		"灵犀真拳",
		"剑神一笑",
		"傲世狂刀",
		"奇门英才",
		"绝世天罡",
		"仁者无敌",
		"回天圣手",
		"乱世毒王",
		"幽暗之主"
	}
	TFE = {
		"拳",
		"剑",
		"刀",
		"特",
		"罡",
		"仁",
		"医",
		"毒",
		"暗"
	}
	TFE2 = {
		[0] = "畅想",
		"拳",
		"剑",
		"刀",
		"特",
		"罡",
		"仁",
		"医",
		"毒",
		"暗",
		"零",
		"水",
		"小",
		"冉"
	}
	KJDYSAVE = {
		"存档一",
		"存档二",
		"存档三",
		"不存档"
	}
	KJDYLOAD = {
		"存档一",
		"存档二",
		"存档三",
		"不读档"
	}
	WARSZJY = {
		3,
		2,
		5,
		2,
		40,
		15,
		5,
		5,
		5,
		5,
		5,
		5,
		5,
		5,
		3,
		2,
		2,
		10,
		5,
		4,
		4,
		5,
		4,
		2,
		2,
		20,
		40,
		2,
		3,
		3,
		3,
		3,
		3,
		3,
		5,
		3,
		4,
		4,
		8,
		8,
		4,
		4,
		4,
		4,
		2,
		5,
		3,
		4,
		3,
		30,
		4,
		2,
		3,
		3,
		4,
		4,
		15,
		5,
		5,
		15,
		3,
		15,
		3,
		15,
		10,
		2,
		8,
		3,
		15,
		7,
		8,
		3,
		3,
		3,
		4,
		2,
		2,
		2,
		2,
		4,
		2,
		2,
		2,
		3,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		7,
		7,
		4,
		4,
		2,
		2,
		12,
		2,
		2,
		2,
		3,
		3,
		3,
		3,
		3,
		7,
		7,
		50,
		3,
		3,
		5,
		6,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		20,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		2,
		3,
		2,
		35,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		3,
		4,
		3,
		4,
		4,
		4,
		2,
		2,
		2,
		2,
		2,
		2,
		2,
		3,
		7,
		7,
		4,
		3,
		5,
		5,
		3
	}
	PSX = {
		"天赋",
		"头像代号",
		"生命增长",
		"根骨",
		"气运",
		"主功体",
		"副功体",
		"初始天赋级别",
		"副功体显示",
		"性别",
		"等级",
		"经验",
		"生命",
		"生命最大值",
		"受伤程度",
		"中毒程度",
		"体力",
		"物品修炼点数",
		"武器",
		"防具",
		"出招动画帧数1",
		"出招动画帧数2",
		"出招动画帧数3",
		"出招动画帧数4",
		"出招动画帧数5",
		"出招动画延迟1",
		"出招动画延迟2",
		"出招动画延迟3",
		"出招动画延迟4",
		"出招动画延迟5",
		"武功音效延迟1",
		"武功音效延迟2",
		"武功音效延迟3",
		"武功音效延迟4",
		"武功音效延迟5",
		"内力性质",
		"内力",
		"内力最大值",
		"攻击力",
		"轻功",
		"防御力",
		"医疗能力",
		"用毒能力",
		"解毒能力",
		"抗毒能力",
		"拳掌功夫",
		"御剑能力",
		"耍刀技巧",
		"特殊兵器",
		"暗器技巧",
		"武学常识",
		"品德",
		"攻击带毒",
		"左右互搏",
		"声望",
		"悟性",
		"修炼物品",
		"修炼点数",
		"武功1",
		"武功2",
		"武功3",
		"武功4",
		"武功5",
		"武功6",
		"武功7",
		"武功8",
		"武功9",
		"武功10",
		"武功11",
		"武功12",
		"武功13",
		"武功14",
		"武功15",
		"武功16",
		"武功17",
		"武功18",
		"武功19",
		"武功20",
		"武功等级1",
		"武功等级2",
		"武功等级3",
		"武功等级4",
		"武功等级5",
		"武功等级6",
		"武功等级7",
		"武功等级8",
		"武功等级9",
		"武功等级10",
		"武功等级11",
		"武功等级12",
		"武功等级13",
		"武功等级14",
		"武功等级15",
		"武功等级16",
		"武功等级17",
		"武功等级18",
		"武功等级19",
		"武功等级20",
		"携带物品1",
		"携带物品2",
		"携带物品3",
		"携带物品4",
		"携带物品数量1",
		"携带物品数量2",
		"携带物品数量3",
		"携带物品数量4",
		"连击率",
		"暴击率",
		"魅力",
		"精神"
	}
	WPSX = {
		"代号",
		"练出武功",
		"暗器动画编号",
		"使用人",
		"装备类型",
		"显示物品说明",
		"类型",
		"加生命",
		"加生命最大值",
		"加中毒解毒",
		"加体力",
		"改变内力性质",
		"加内力",
		"加内力最大值",
		"加攻击力",
		"加轻功",
		"加防御力",
		"加医疗能力",
		"加用毒能力",
		"加解毒能力",
		"加抗毒能力",
		"加拳掌功夫",
		"加御剑能力",
		"加耍刀技巧",
		"加特殊兵器",
		"加暗器技巧",
		"加武学常识",
		"加品德",
		"加攻击次数",
		"加攻击带毒",
		"仅修炼人物",
		"需内力性质",
		"需内力",
		"需攻击力",
		"需轻功",
		"需用毒能力",
		"需医疗能力",
		"需解毒能力",
		"需拳掌功夫",
		"需御剑能力",
		"需耍刀技巧",
		"需特殊兵器",
		"需暗器技巧",
		"需悟性",
		"需经验",
		"练出物品需经验",
		"需材料",
		"练出物品1",
		"练出物品2",
		"练出物品3",
		"练出物品4",
		"练出物品5",
		"需要物品数量1",
		"需要物品数量2",
		"需要物品数量3",
		"需要物品数量4",
		"需要物品数量5",
		"练出武功",
		"使用人",
		"装备类型"
	}
	CJSX = {
		"代号",
		"跳转场景",
		"进入条件",
		"跳转口X1",
		"跳转口Y1",
		"跳转口X2",
		"跳转口Y2"
	}
	WGSX = {
		"攻击力1",
		"攻击力2",
		"攻击力3",
		"攻击力4",
		"攻击力5",
		"攻击力6",
		"攻击力7",
		"攻击力8",
		"攻击力9",
		"攻击力10",
		"移动范围1",
		"移动范围2",
		"移动范围3",
		"移动范围4",
		"移动范围5",
		"移动范围6",
		"移动范围7",
		"移动范围8",
		"移动范围9",
		"移动范围10",
		"杀伤范围1",
		"杀伤范围2",
		"杀伤范围3",
		"杀伤范围4",
		"杀伤范围5",
		"杀伤范围6",
		"杀伤范围7",
		"杀伤范围8",
		"杀伤范围9",
		"杀伤范围10",
		"加内力1",
		"加内力2",
		"加内力3",
		"加内力4",
		"加内力5",
		"加内力6",
		"加内力7",
		"加内力8",
		"加内力9",
		"加内力10",
		"杀内力1",
		"杀内力2",
		"杀内力3",
		"杀内力4",
		"杀内力5",
		"杀内力6",
		"杀内力7",
		"杀内力8",
		"杀内力9",
		"杀内力10",
		"代号",
		"武功类型",
		"伤害类型",
		"攻击范围",
		"消耗内力点数",
		"敌人中毒点数",
		"攻击力10",
		"移动范围10",
		"杀伤范围10",
		"加内力9"
	}
	SDSX = {
		"物品1",
		"物品2",
		"物品3",
		"物品4",
		"物品5",
		"物品数量1",
		"物品数量2",
		"物品数量3",
		"物品数量4",
		"物品数量5",
		"物品价格1",
		"物品价格2",
		"物品价格3",
		"物品价格4",
		"物品价格5",
		"物品1",
		"物品2",
		"物品3",
		"物品4",
		"物品5"
	}
	PSXJL = {
		"代号",
		"头像代号",
		"生命增长",
		"性别",
		"等级",
		"生命",
		"生命最大值",
		"武器",
		"防具",
		"内力性质",
		"内力",
		"内力最大值",
		"攻击力",
		"轻功",
		"防御力",
		"医疗能力",
		"用毒能力",
		"解毒能力",
		"抗毒能力",
		"拳掌功夫",
		"御剑能力",
		"耍刀技巧",
		"特殊兵器",
		"暗器技巧",
		"武学常识",
		"品德",
		"攻击带毒",
		"左右互搏",
		"悟性",
		"修炼物品",
		"武功1",
		"武功2",
		"武功3",
		"武功4",
		"武功5",
		"武功6",
		"武功7",
		"武功8",
		"武功9",
		"武功10",
		"携带物品1",
		"携带物品2",
		"携带物品3",
		"携带物品4",
		"携带物品数量1",
		"携带物品数量2",
		"携带物品数量3",
		"携带物品数量4"
	}
	TeamP = {
		0,
		1,
		2,
		4,
		9,
		16,
		17,
		25,
		28,
		29,
		30,
		35,
		36,
		37,
		38,
		44,
		45,
		47,
		48,
		49,
		51,
		52,
		53,
		54,
		55,
		56,
		58,
		59,
		63,
		66,
		72,
		73,
		74,
		75,
		76,
		77,
		78,
		79,
		80,
		81,
		82,
		83,
		84,
		85,
		86,
		87,
		88,
		89,
		90,
		91,
		92,
		589,
		590,
		591,
		594,
		595,
		596
	}
	FLHSYL = {
		"其疾如风",
		"其徐如林",
		"侵略如火",
		"不动如山",
		"难知如阴",
		"动如雷震",
		"六如苍龙诀"
	}
	YYGZT = {
		"风林火山功",
		"六如苍龙诀"
	}
	TSXMLB = {
		"零二七",
		"水镜四奇",
		"小虾米",
		"冉闵"
	}
	MODEXZ = {
		"初次接触本作和不擅长玩游戏者",
		"请选择『新人』模式"
	}
	MODEXZ2 = {
		"新人",
		"散人",
		"侠客",
		"大侠",
		"宗师",
		"大宗师"
	}
	TZSAY1 = " 体质=1：你时刻处于快要咽气的状态 * 体质=2：你比蠕虫还是强一点的 * 体质=3：你勉强能打赢一只小鸡 * 体质=4：你和隔壁8岁的孩子打架还可耻的输了 * 体质=5：这是普通妇女的平均体质 * 体质=6：现代大学生的平均体质 * 体质=6：强壮的体力工人 * 体质=7：武术家和专业的体育家 * 体质=8：一流的武术家和体育家 * 体质=9：世界级的冠军 * 体质=10：很肯定的是，泰森的体质也比不上你 "
	TZX = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10"
	}
	TFXZSAY1 = " 壮志饥餐胡虏肉 * 笑谈渴饮匈奴血 * 剑气纵横三万里 * 一剑光寒十九洲 "
	TFXZSAY2 = " 【灵犀真拳】 * 【剑神一笑】 * 【傲世狂刀】 * 【奇门英才】 * 【绝世天罡】 * 【仁者无敌】 * 【回天圣手】* 【乱世毒王】* 【幽暗之主】 "
	XKXSJ = {
		"赵客缦胡缨 吴钩霜雪明",
		"十步杀一人 千里不留行",
		"纵死侠骨香 不惭世上英",
		"谁能书阁下 白首太玄经"
	}
	CC.KfName = {
		{
			1,
			"黑虎偷心",
			300
		},
		{
			1,
			"拗步拉弓",
			300
		},
		{
			1,
			"单凤朝阳",
			300
		},
		{
			2,
			"饭来张口",
			600
		},
		{
			2,
			"沿门托钵",
			600
		},
		{
			2,
			"见人伸手",
			600
		},
		{
			3,
			"五毒摧心",
			700
		},
		{
			4,
			"锁喉",
			700
		},
		{
			4,
			"探目",
			700
		},
		{
			5,
			"寒冰封体",
			700
		},
		{
			6,
			"柔网势",
			500
		},
		{
			6,
			"夭矫空碧势",
			500
		},
		{
			6,
			"捕雀势",
			500
		},
		{
			7,
			"绵绵不绝",
			700
		},
		{
			7,
			"绵里藏针",
			700
		},
		{
			7,
			"花开并蒂",
			700
		},
		{
			8,
			"阳歌天钧",
			900
		},
		{
			8,
			"阳春白雪",
			1000
		},
		{
			8,
			"阳关三叠",
			1100
		},
		{
			9,
			"灵蛇西来",
			800
		},
		{
			9,
			"毒牙交错",
			800
		},
		{
			10,
			"一错",
			800
		},
		{
			10,
			"再错",
			800
		},
		{
			11,
			"旋",
			800
		},
		{
			11,
			"钻",
			800
		},
		{
			12,
			"珞樱缤纷",
			900
		},
		{
			12,
			"雨急风狂",
			900
		},
		{
			12,
			"江城飞花",
			900
		},
		{
			13,
			"铁砂掌",
			1000
		},
		{
			13,
			"黑砂掌",
			1000
		},
		{
			14,
			"踏雪寻梅",
			1000
		},
		{
			14,
			"天山灵鹫",
			1000
		},
		{
			15,
			"妙手空空",
			1000
		},
		{
			15,
			"空碗盛饭",
			1000
		},
		{
			15,
			"深藏若虚",
			1000
		},
		{
			15,
			"空屋住人",
			1000
		},
		{
			16,
			"上步野马分鬃",
			1000
		},
		{
			16,
			"提步高探马",
			1000
		},
		{
			16,
			"左右玉女穿梭",
			1000
		},
		{
			16,
			"如封似闭",
			1000
		},
		{
			16,
			"搂膝拗步",
			1000
		},
		{
			16,
			"白鹤晾翅",
			1000
		},
		{
			16,
			"十字手",
			1000
		},
		{
			16,
			"弯弓射虎",
			1000
		},
		{
			16,
			"揽雀尾",
			1000
		},
		{
			17,
			"一阳定乾坤",
			1100
		},
		{
			18,
			"弹指一瞬",
			1100
		},
		{
			18,
			"白驹过隙",
			1100
		},
		{
			17,
			"一阳定乾坤",
			1200
		},
		{
			18,
			"弹指·一瞬",
			1200
		},
		{
			19,
			"魔幻天阴",
			1000
		},
		{
			20,
			"拿云式",
			1100
		},
		{
			20,
			"捕风式",
			1100
		},
		{
			20,
			"捉影式",
			1100
		},
		{
			20,
			"抚琴式",
			1100
		},
		{
			20,
			"鼓瑟式",
			1100
		},
		{
			21,
			"玄冥侵体",
			1000
		},
		{
			21,
			"冰毒缭绕",
			1000
		},
		{
			22,
			"金刚大手印",
			1000
		},
		{
			23,
			"损心诀",
			1300
		},
		{
			23,
			"伤肺诀",
			1300
		},
		{
			23,
			"摧肝肠诀",
			1300
		},
		{
			23,
			"藏离诀",
			1300
		},
		{
			23,
			"精失诀",
			1300
		},
		{
			24,
			"色空四显",
			1200
		},
		{
			24,
			"无色无相",
			1200
		},
		{
			24,
			"慑伏外道",
			1200
		},
		{
			25,
			"拖泥带水",
			1300
		},
		{
			25,
			"倒行逆施",
			1300
		},
		{
			25,
			"行尸走肉",
			1300
		},
		{
			25,
			"魂不守舍",
			1300
		},
		{
			25,
			"心惊肉跳",
			1300
		},
		{
			25,
			"六神不安",
			1300
		},
		{
			27,
			"平沙落雁式",
			300
		},
		{
			27,
			"鸿飞冥冥",
			300
		},
		{
			27,
			"碧渊腾蛟",
			300
		},
		{
			28,
			"轰雷掣电",
			300
		},
		{
			28,
			"雷霆万钧",
			300
		},
		{
			28,
			"驱雷掣电",
			300
		},
		{
			29,
			"冰河倒泻",
			400
		},
		{
			29,
			"雪中奇莲",
			400
		},
		{
			29,
			"冰河开冻",
			400
		},
		{
			30,
			"万花齐放",
			500
		},
		{
			30,
			"万卉争艳",
			500
		},
		{
			30,
			"清澈梅花",
			500
		},
		{
			31,
			"五大夫剑",
			700
		},
		{
			31,
			"岱宗如何",
			700
		},
		{
			31,
			"快活三",
			700
		},
		{
			31,
			"七星落长空",
			700
		},
		{
			32,
			"泉鸣芙蓉",
			700
		},
		{
			32,
			"鹤翔紫盖",
			700
		},
		{
			32,
			"雁回祝融",
			700
		},
		{
			32,
			"石廪书声",
			700
		},
		{
			32,
			"天柱云气",
			700
		},
		{
			33,
			"叠翠浮青",
			600
		},
		{
			33,
			"玉进天池",
			600
		},
		{
			33,
			"天外玉龙",
			600
		},
		{
			34,
			"苍松迎客",
			600
		},
		{
			34,
			"金雁横空",
			600
		},
		{
			34,
			"天坤倒悬",
			600
		},
		{
			35,
			"老枝横斜",
			500
		},
		{
			35,
			"梅雪争春",
			500
		},
		{
			35,
			"风沙莽莽",
			500
		},
		{
			35,
			"明月羌笛",
			500
		},
		{
			35,
			"暗香疏影",
			500
		},
		{
			36,
			"杏花春雨",
			700
		},
		{
			36,
			"满天花雨",
			700
		},
		{
			36,
			"玉带围腰",
			700
		},
		{
			38,
			"山外清音",
			800
		},
		{
			38,
			"金声玉振",
			800
		},
		{
			38,
			"凤曲长鸣",
			800
		},
		{
			38,
			"响隔楼台",
			800
		},
		{
			38,
			"棹歌中流",
			800
		},
		{
			39,
			"关河梦断",
			1000
		},
		{
			39,
			"醉里贪欢",
			1000
		},
		{
			39,
			"暮云合璧",
			1000
		},
		{
			39,
			"明河共影",
			1000
		},
		{
			39,
			"细斟北斗",
			1000
		},
		{
			39,
			"寒烟衰草",
			1000
		},
		{
			40,
			"金蛇万道",
			900
		},
		{
			40,
			"金蛇狂舞",
			900
		},
		{
			40,
			"金光蛇影",
			900
		},
		{
			40,
			"蛇影万馈",
			900
		},
		{
			40,
			"灵蛇电闪",
			900
		},
		{
			40,
			"蛇困愁城",
			900
		},
		{
			40,
			"金蛇化龙",
			900
		},
		{
			41,
			"灭",
			1000
		},
		{
			41,
			"绝",
			1000
		},
		{
			42,
			"清饮小酌",
			1000
		},
		{
			42,
			"浪迹天涯",
			1000
		},
		{
			42,
			"举案齐眉",
			1000
		},
		{
			42,
			"皓腕玉镯",
			1000
		},
		{
			42,
			"冷月窥人",
			1000
		},
		{
			42,
			"竹帘临池",
			1000
		},
		{
			44,
			"冲天掌苏秦背剑",
			1000
		},
		{
			44,
			"黄龙转身吐须势",
			1100
		},
		{
			44,
			"迎门腿反劈华山",
			1200
		},
		{
			44,
			"洗剑怀中抱月",
			1200
		},
		{
			44,
			"上步云边摘月",
			1200
		},
		{
			44,
			"提撩剑白鹤舒翅",
			1300
		},
		{
			45,
			"重剑无锋",
			1200
		},
		{
			45,
			"大巧不工",
			1200
		},
		{
			45,
			"破尽天下",
			1300
		},
		{
			46,
			"仙人指路",
			1200
		},
		{
			46,
			"三环套月",
			1200
		},
		{
			46,
			"云麾三舞",
			1200
		},
		{
			46,
			"犀牛望月",
			1300
		},
		{
			46,
			"野马跳涧",
			1300
		},
		{
			46,
			"魁星势",
			1300
		},
		{
			46,
			"金针指南",
			1400
		},
		{
			46,
			"摘星换斗",
			1400
		},
		{
			46,
			"金针倒挂",
			1400
		},
		{
			47,
			"总决式",
			1600
		},
		{
			47,
			"破剑式",
			1200
		},
		{
			47,
			"破枪式",
			1200
		},
		{
			47,
			"破刀式",
			1200
		},
		{
			47,
			"破鞭式",
			1200
		},
		{
			47,
			"破索式",
			1200
		},
		{
			47,
			"破掌式",
			1200
		},
		{
			47,
			"破箭式",
			1200
		},
		{
			47,
			"破气式",
			1400
		},
		{
			48,
			"扫荡群魔",
			1200
		},
		{
			48,
			"紫气东来",
			1200
		},
		{
			48,
			"锺馗抉目",
			1200
		},
		{
			48,
			"花开见佛",
			1200
		},
		{
			48,
			"直捣黄龙",
			1200
		},
		{
			48,
			"指打奸邪",
			1200
		},
		{
			48,
			"锺馗抉目",
			1200
		},
		{
			48,
			"流星飞堕",
			1200
		},
		{
			48,
			"飞燕穿柳",
			1200
		},
		{
			48,
			"江上弄笛",
			1200
		},
		{
			50,
			"砍",
			500
		},
		{
			50,
			"劈",
			500
		},
		{
			52,
			"鬼见愁",
			600
		},
		{
			53,
			"铁锁横江",
			600
		},
		{
			53,
			"燕子入巢",
			600
		},
		{
			54,
			"大青",
			700
		},
		{
			54,
			"小青",
			700
		},
		{
			55,
			"狂风大作",
			700
		},
		{
			55,
			"飞沙走石",
			700
		},
		{
			56,
			"带醉脱靴",
			700
		},
		{
			56,
			"奇刀单鞭式",
			700
		},
		{
			57,
			"放下屠刀",
			600
		},
		{
			57,
			"立地成佛",
			600
		},
		{
			57,
			"苦海无边",
			600
		},
		{
			57,
			"回头是岸",
			600
		},
		{
			58,
			"恨意绵绵",
			700
		},
		{
			59,
			"白虎跳涧",
			600
		},
		{
			59,
			"剪扑自如",
			600
		},
		{
			60,
			"重节守义",
			700
		},
		{
			60,
			"万劫不复",
			700
		},
		{
			61,
			"梅雪逢夏",
			800
		},
		{
			61,
			"赤日炎炎",
			800
		},
		{
			61,
			"千钧压驼",
			800
		},
		{
			61,
			"大海沉沙",
			800
		},
		{
			61,
			"开门揖盗",
			800
		},
		{
			62,
			"女貌郎才珠万斛",
			1000
		},
		{
			62,
			"天教丽质为眷属",
			1000
		},
		{
			62,
			"清风引佩下瑶台",
			1000
		},
		{
			62,
			"明月照妆成金屋",
			1000
		},
		{
			62,
			"刀光掩映孔雀屏",
			1000
		},
		{
			62,
			"喜结丝萝在乔木",
			1000
		},
		{
			62,
			"英雄无双风流婿",
			1000
		},
		{
			62,
			"却扇洞房燃花烛",
			1000
		},
		{
			63,
			"呕心沥血",
			800
		},
		{
			63,
			"批纸削腐",
			800
		},
		{
			63,
			"流星经天",
			800
		},
		{
			64,
			"风抚山岚",
			1300
		},
		{
			64,
			"拨云见日",
			1400
		},
		{
			64,
			"满天飞雪",
			1300
		},
		{
			64,
			"太虚揽月",
			1400
		},
		{
			64,
			"虚中有无",
			1300
		},
		{
			64,
			"玄机暗藏",
			1400
		},
		{
			64,
			"故弄玄虚",
			1300
		},
		{
			64,
			"虚实莫辨",
			1400
		},
		{
			65,
			"钻木取火",
			900
		},
		{
			65,
			"无名孽火",
			1200
		},
		{
			66,
			"烈火燎原",
			1300
		},
		{
			66,
			"举火烧天",
			1400
		},
		{
			67,
			"穿手藏刀式",
			1100
		},
		{
			67,
			"八方藏刀式",
			1200
		},
		{
			67,
			"进步连环刀",
			1100
		},
		{
			67,
			"缠身摘心刀",
			1200
		},
		{
			67,
			"闭门铁扇刀",
			1200
		},
		{
			68,
			"回马枪",
			600
		},
		{
			68,
			"春雷震怒",
			500
		},
		{
			68,
			"凤点头",
			500
		},
		{
			70,
			"中正锁喉",
			600
		},
		{
			70,
			"枪平九洲",
			600
		},
		{
			71,
			"大君制六合",
			600
		},
		{
			71,
			"猛将清九垓",
			700
		},
		{
			71,
			"战马若龙虎",
			700
		},
		{
			71,
			"腾陵何壮哉",
			700
		},
		{
			74,
			"灵蛇吐信",
			700
		},
		{
			74,
			"冲天一鹤",
			700
		},
		{
			75,
			"咔嚓",
			800
		},
		{
			75,
			"我剪",
			800
		},
		{
			77,
			"金刀黑剑",
			600
		},
		{
			77,
			"假刀非刀",
			600
		},
		{
			77,
			"假剑非剑",
			600
		},
		{
			78,
			"血染黄沙",
			600
		},
		{
			78,
			"飞沙万里",
			600
		},
		{
			79,
			"银索缠身",
			900
		},
		{
			79,
			"锁穴金铃",
			900
		},
		{
			80,
			"棒打狗头",
			1200
		},
		{
			80,
			"反截狗臀",
			1200
		},
		{
			80,
			"獒口夺杖",
			1200
		},
		{
			80,
			"棒打双犬",
			1200
		},
		{
			80,
			"獒口夺杖",
			1300
		},
		{
			81,
			"书化丹心",
			1000
		},
		{
			81,
			"玄天一阳",
			1000
		},
		{
			82,
			"祗园精舍",
			1100
		},
		{
			82,
			"诸行无常",
			1100
		},
		{
			82,
			"娑罗双树",
			1100
		},
		{
			82,
			"幻梦一场",
			1100
		},
		{
			83,
			"灵蛇出洞",
			1200
		},
		{
			83,
			"摇头摆尾",
			1200
		},
		{
			83,
			"灵蛇下涧",
			1200
		},
		{
			83,
			"灵蛇挺身",
			1200
		},
		{
			83,
			"蛇游蟒走",
			1200
		},
		{
			83,
			"蛇形雷电",
			1200
		},
		{
			84,
			"宝刀屠龙",
			1000
		},
		{
			84,
			"号令天下",
			1100
		},
		{
			84,
			"莫敢不从",
			1100
		},
		{
			84,
			"倚天不出",
			1200
		},
		{
			84,
			"谁与争锋",
			1200
		},
		{
			86,
			"天魔降伏",
			1300
		},
		{
			86,
			"降龙伏虎",
			1300
		},
		{
			86,
			"拨云见日",
			1300
		},
		{
			86,
			"金刚护法",
			1300
		},
		{
			191,
			"石头",
			1300
		},
		{
			191,
			"剪子",
			1200
		},
		{
			191,
			"布",
			1200
		},
		{
			192,
			"神洲移山剑",
			1200
		},
		{
			192,
			"神洲镇山剑",
			1200
		},
		{
			192,
			"神洲擎山剑",
			1200
		},
		{
			193,
			"切瓜",
			1200
		},
		{
			193,
			"剁瓜",
			1200
		},
		{
			193,
			"砍瓜",
			1200
		},
		{
			194,
			"一闪",
			1200
		},
		{
			194,
			"连一闪",
			1200
		},
		{
			194,
			"真一闪",
			1200
		},
		{
			168,
			"床前明月光",
			900
		},
		{
			168,
			"疑是地上霜",
			900
		},
		{
			168,
			"举头望明月",
			900
		},
		{
			168,
			"低头思故乡",
			1100
		}
	}
	GRTS = {}
	GRTSSAY = {}
	GRTS[999] = "驱蛇"
	GRTSSAY[999] = "效果：驱使毒蛇出战*其他：：每场战斗限用1次"
	GRTS[1] = "飞狐"
	GRTSSAY[1] = "效果：无视战场阻碍，强行冲*　　　破敌方封锁*消耗：体力5点*其他：本回合可继续行动"
	GRTS[2] = "引毒"
	GRTSSAY[2] = "效果：以秘法引发敌人体内的*　　　毒素，造成的伤害与中*　　　毒程度相关*消耗：体力20点"
	GRTS[4] = "千金"
	GRTSSAY[4] = "效果：窃取敌人金钱*消耗：体力10点"
	GRTS[9] = "挪移"
	GRTSSAY[9] = "效果：以乾坤秘法将八格范围*　　　内的我方一个队友挪移*　　　到指定位置*消耗：体力10点　内力500点"
	GRTS[16] = "群疗"
	GRTSSAY[16] = "效果：以妙手施展群疗，使周*　　　围四格范围内的队友20*　　　时序内按时序回内伤并*　　　以比例回复生命*消耗：体力15点　内力300点"
	GRTS[17] = "施毒"
	GRTSSAY[17] = "效果：以秘法施毒，使周围五*　　　格范围内的敌人50内按*　　　时序中毒并以比例减血*消耗：体力15点　内力300点"
	GRTS[25] = "引毒"
	GRTSSAY[25] = "效果：引发敌人体内毒素*消耗：体力2点"
	GRTS[28] = "疗伤"
	GRTSSAY[28] = "效果：以妙手施展群疗，使我*　　　方全体回复一些生命和*　　　内伤*消耗：体力10点　内力250点 "
	GRTS[35] = "九破"
	GRTSSAY[35] = "效果：受到攻击时发动九剑秘传*　　　伤害减半并免疫杀气*　　　终止敌方后续攻击*　　　恢复集气四百点*消耗：体力15点　内力500点"
	GRTS[37] = "神照"
	GRTSSAY[37] = "效果：使用后提升集气速度10*消耗：每时序消耗20内力*其他：本回合可继续行动"
	GRTS[38] = "飒行"
	GRTSSAY[38] = "效果：发动后首次击退敌人时有效*　　　集气恢复300点/每人*消耗：体力10点*其他：本回合可继续行动"
	GRTS[47] = "引毒"
	GRTSSAY[47] = "效果：引发敌人体内毒素*消耗：体力2点"
	GRTS[49] = "催符"
	GRTSSAY[49] = "效果：催动敌人身上的生死符*　　　使其封穴25时序*消耗：体力5点　内力500点"
	GRTS[51] = "幻梦"
	GRTSSAY[51] = "效果：斗转星移强化为第四重境界*　　　可触发三次*　　　以幻梦星辰反击敌全体*消耗：体力5点　内力500点"
	GRTS[53] = "凌波"
	GRTSSAY[53] = "效果：在下次自己行动之前*　　　闪避机率大幅提升*消耗：体力10点"
	GRTS[54] = "虎乱"
	GRTSSAY[54] = "效果：100时序内受到攻击时*　　　怒气增长速度提升100%*消耗：无"
	GRTS[55] = "灵罡"
	GRTSSAY[55] = "效果：战场上可转换内力属性*　　　每回合只能转换一次*消耗：无*其他：本回合可继续行动"
	GRTS[56] = "奇阵"
	GRTSSAY[56] = "效果：以奇门八阵困锁敌方*　　　使其下回合无法移动*　　　打退其当前集气*消耗：体力15"
	GRTS[58] = "神雕"
	GRTSSAY[58] = "效果：招唤神雕助战*消耗：体力10点*其他：每场战斗限用1次"
	GRTS[59] = "御蜂"
	GRTSSAY[59] = "效果：驱蜂群攻击敌方全体*　　　敌全体减血200点*　　　敌全体中毒20点*消耗：体力10点*其他：每场战斗限用3次"
	GRTS[63] = "青箫"
	GRTSSAY[63] = "效果：恢复全员内伤35点*消耗：体力10点内力350点"
	GRTS[72] = "谗言"
	GRTSSAY[72] = "效果：以犀利的话语迷惑敌方*　　　减少指定敌方怒气30点*消耗：体力5点"
	GRTS[74] = "统率"
	GRTSSAY[74] = "效果：我方全体集气加300点*消耗：体力10点 内力150点"
	GRTS[76] = "点破"
	GRTSSAY[76] = "效果：在敌方攻击之前道破其意*　　　使其在下次自己行动之前*　　　降低攻击和杀气效果30%*消耗：体力5点"
	GRTS[77] = "慧心"
	GRTSSAY[77] = "效果：以话语激励主角*　　　使其生命回复满值*　　　清除内伤并解除封穴*　　　怒气爆发且满集气*效果：使用后自己将奄奄一息"
	GRTS[81] = "魅惑"
	GRTSSAY[81] = "效果：控制指定敌方100时序*　　　非杂兵只能控制50时序*　　　第一次必成功，之后成*　　　功率极低*消耗：体力20点"
	GRTS[88] = "传功"
	GRTSSAY[88] = "效果：将五格范围内我方任一队友*　　　当前集气提升500点*消耗：体力10点 内力700点"
	GRTS[89] = "气补"
	GRTSSAY[89] = "效果：回复指定邻接队友体力50点*消耗：体力25点 内力300点"
	GRTS[90] = "灵貂"
	GRTSSAY[90] = "效果：放闪电貂攻击五格内的*　　　敌人使之中毒30点*　　　并可盗取对方所持物品一件*消耗：无"
	GRTS[91] = "大暴"
	GRTSSAY[91] = "效果：本次攻击必连击*消耗：体力15点*其他：本回合可继续行动"
	GRTS[92] = "夙缘"
	GRTSSAY[92] = "效果：除自身外我方全体怒气加满*消耗：内力700点 怒气100点"
	GRTS[590] = "天铃"
	GRTSSAY[590] = "效果：所有队友回复一定状态*消耗：使用后自己将奄奄一息*其他：一次战斗仅限1次"
	RWTFLB = {}
	RWTFLB["01"] = "颖悟绝伦"
	RWTFLB["02"] = "万般皆通"
	RWTFLB["03"] = "笨鸟先飞"
	RWTFLB["04"] = "攻战无前"
	RWTFLB[1] = "魂系一刀"
	RWTFLB[2] = "七心海棠"
	RWTFLB[3] = "胡刀苗剑"
	RWTFLB[4] = "临阵淬毒"
	RWTFLB[5] = "化朽为奇"
	RWTFLB[6] = "除恶务尽"
	RWTFLB[7] = "三圣传人"
	RWTFLB[8] = "一练七伤"
	RWTFLB[9] = "谁与争峰"
	RWTFLB[10] = "忍辱负重"
	RWTFLB[11] = "狂放羁傲"
	RWTFLB[12] = "老当益壮"
	RWTFLB[13] = "怒发冲冠"
	RWTFLB[14] = "血冷冰魄"
	RWTFLB[15] = "风华绝代"
	RWTFLB[16] = "妙手回春"
	RWTFLB[17] = "与毒为生"
	RWTFLB[18] = "魔相幻阴"
	RWTFLB[19] = "虚仁假义"
	RWTFLB[20] = "潇湘夜雨"
	RWTFLB[21] = "气定神闲"
	RWTFLB[22] = "冰魄寒光"
	RWTFLB[23] = "坚若磐石"
	RWTFLB[24] = "机关算尽"
	RWTFLB[25] = "凤舞九天"
	RWTFLB[26] = "日月魔帝"
	RWTFLB[27] = "日出东方"
	RWTFLB[28] = "妙手回春"
	RWTFLB[29] = "飞沙走石"
	RWTFLB[30] = "大器晚成"
	RWTFLB[31] = "妙笔丹青"
	RWTFLB[32] = "三杯草圣"
	RWTFLB[33] = "呕血楸枰"
	RWTFLB[34] = "七弦无形"
	RWTFLB[35] = "灵奇洒脱"
	RWTFLB[36] = "葵花传人"
	RWTFLB[37] = "赤心连城"
	RWTFLB[38] = "质朴刚健"
	RWTFLB[39] = "白首太玄"
	RWTFLB[40] = "白首太玄"
	RWTFLB[41] = "烈火至阳"
	RWTFLB[42] = "玄水至阴"
	RWTFLB[43] = "气寒西北"
	RWTFLB[44] = "愚者千虑"
	RWTFLB[45] = "妙手回春"
	RWTFLB[46] = "三笑逍遥"
	RWTFLB[47] = "阴狠毒辣"
	RWTFLB[48] = "心无所住"
	RWTFLB[49] = "福缘深厚"
	RWTFLB[50] = "奋英雄怒"
	RWTFLB[51] = "离合参商"
	RWTFLB[52] = "彼尸可餐"
	RWTFLB[53] = "磊落仁心"
	RWTFLB[54] = "志垂日月"
	RWTFLB[55] = "大器晚成"
	RWTFLB[56] = "兰心慧质"
	RWTFLB[57] = "奇门奥义"
	RWTFLB[58] = "逆流勇进"
	RWTFLB[59] = "冷剑冰花"
	RWTFLB[60] = "倒行逆施"
	RWTFLB[61] = "风流成性"
	RWTFLB[62] = "五轮映心"
	RWTFLB[63] = "外和内刚"
	RWTFLB[64] = "童真永留"
	RWTFLB[65] = "先天一阳"
	RWTFLB[66] = "聪慧"
	RWTFLB[67] = "水上漂"
	RWTFLB[68] = "一言止杀"
	RWTFLB[69] = "无坚不摧"
	RWTFLB[70] = "金刚达摩"
	RWTFLB[71] = "豹胎易筋"
	RWTFLB[72] = "雷震天龙"
	RWTFLB[73] = "琴铮盈盈"
	RWTFLB[74] = "巾帼之才"
	RWTFLB[75] = "庖丁解牛"
	RWTFLB[76] = "博闻强记"
	RWTFLB[77] = "万仞刀魂"
	RWTFLB[78] = "九阴神爪"
	RWTFLB[79] = "慧中灵剑"
	RWTFLB[80] = "勇猛精进"
	RWTFLB[81] = "雪岭毒姝"
	RWTFLB[82] = "太极传人"
	RWTFLB[83] = "铁袖拂风"
	RWTFLB[84] = "钉骨扇"
	RWTFLB[85] = "无"
	RWTFLB[86] = "倾国倾城"
	RWTFLB[87] = "媚眼如丝"
	RWTFLB[88] = "聚气归还"
	RWTFLB[89] = "身体强健"
	RWTFLB[90] = "身轻如燕"
	RWTFLB[91] = "妙手连环"
	RWTFLB[92] = "国色天香"
	RWTFLB[93] = "无"
	RWTFLB[94] = "四奇魁首"
	RWTFLB[95] = "柔劲传人"
	RWTFLB[96] = "流水行云"
	RWTFLB[97] = "攻心之术"
	RWTFLB[98] = "一阳魔手"
	RWTFLB[99] = "哭儿唤女"
	RWTFLB[100] = "辣手摧花"
	RWTFLB[101] = "无"
	RWTFLB[102] = "枯荣寂灭"
	RWTFLB[103] = "无我无相"
	RWTFLB[104] = "无"
	RWTFLB[105] = "无"
	RWTFLB[106] = "五虎宗师"
	RWTFLB[107] = "两仪刀客"
	RWTFLB[108] = "两仪刀客"
	RWTFLB[109] = "卑鄙无耻"
	RWTFLB[110] = "盾亡人亡"
	RWTFLB[111] = "盾在人在"
	RWTFLB[112] = "血海深仇"
	RWTFLB[113] = "参合密技"
	RWTFLB[114] = "天地独尊"
	RWTFLB[115] = "六艺皆通"
	RWTFLB[116] = "逍遥御风"
	RWTFLB[117] = "唯我独尊"
	RWTFLB[118] = "无相天成"
	RWTFLB[119] = "拦江起鳌，"
	RWTFLB[120] = "开山劈林"
	RWTFLB[121] = "爆火似癫"
	RWTFLB[122] = "哀牢奇剑"
	RWTFLB[123] = "金玉洞玄"
	RWTFLB[124] = "云水蕴真"
	RWTFLB[125] = "三花聚顶"
	RWTFLB[126] = "五气归元"
	RWTFLB[127] = "太古真如"
	RWTFLB[128] = "清净无为"
	RWTFLB[129] = "气返先天"
	RWTFLB[130] = "听风辩形"
	RWTFLB[131] = "错骨分筋"
	RWTFLB[132] = "性如烈火"
	RWTFLB[133] = "南山孤胆"
	RWTFLB[134] = "浑元铁布衫"
	RWTFLB[135] = "成算在心"
	RWTFLB[136] = "越女慈心"
	RWTFLB[137] = "身若清风"
	RWTFLB[138] = "截血断脉"
	RWTFLB[139] = "白面小生"
	RWTFLB[140] = "剑术通神"
	RWTFLB[141] = "夺命三仙"
	RWTFLB[142] = "狂风快剑"
	RWTFLB[143] = "精神错乱"
	RWTFLB[144] = "精神错乱"
	RWTFLB[145] = "精神错乱"
	RWTFLB[146] = "精神错乱"
	RWTFLB[147] = "精神错乱"
	RWTFLB[148] = "精神错乱"
	RWTFLB[149] = "佛法精深"
	RWTFLB[150] = "专打死穴"
	RWTFLB[151] = "否极泰来"
	RWTFLB[152] = "迷踪连环"
	RWTFLB[153] = "春风拂太极"
	RWTFLB[154] = "韩王青刀"
	RWTFLB[155] = "销魂噬魄"
	RWTFLB[156] = "勾魂夺魄"
	RWTFLB[157] = "湘西尸王"
	RWTFLB[158] = "金龙鞭王"
	RWTFLB[159] = "瑜伽鬼王"
	RWTFLB[160] = "巨象之力"
	RWTFLB[161] = "黯然情伤"
	RWTFLB[162] = "玄冰碧火善恶心"
	RWTFLB[163] = "黄金龙头九节鞭"
	RWTFLB[164] = "一言九鼎"
	RWTFLB[165] = "惊天一笔"
	RWTFLB[166] = "狠心辣手"
	RWTFLB[167] = "五痨七伤"
	RWTFLB[168] = "七伤八痨"
	RWTFLB[169] = "慈悲为怀"
	RWTFLB[170] = "少林龙爪"
	RWTFLB[171] = "太极真传"
	RWTFLB[172] = "绕指柔剑"
	RWTFLB[173] = "乾坤精要·秒风"
	RWTFLB[174] = "乾坤精要·流云"
	RWTFLB[175] = "乾坤精要·辉夜"
	RWTFLB[176] = "红颜毒面"
	RWTFLB[177] = "见利忘义"
	RWTFLB[178] = "唯利是图"
	RWTFLB[179] = "利欲熏心"
	RWTFLB[180] = "冷暖自知"
	RWTFLB[181] = "善恶自明"
	RWTFLB[182] = "大巧若拙"
	RWTFLB[183] = "目中无人"
	RWTFLB[184] = "神行百变"
	RWTFLB[185] = "拳剑双修"
	RWTFLB[186] = "质朴归真"
	RWTFLB[187] = "嫉恶如仇"
	RWTFLB[188] = "临阵乱心"
	RWTFLB[189] = "净身出身"
	RWTFLB[553] = "赤胆忠魂"
	RWTFLB[587] = "善谋军师"
	RWTFLB[588] = "虎狼之姿"
	RWTFLB[589] = "似水柔情"
	RWTFLB[590] = "心秀天铃"
	RWTFLB[591] = "心灵感应"
	RWTFLB[592] = "惊才绝艳"
	RWTFLB[593] = "就是不戒"
	RWTFLB[594] = "飞蝗刀"
	RWTFLB[595] = "辽东鹤"
	RWTFLB[596] = "紫金刀"
	RWTFLB[597] = "青龙软鞭"
	RWTFLB[598] = "杀人如麻"
	RWTFLB[599] = "死里逃生"
	RWTFLB[600] = "无敌幸运星"
	RWTFLB[626] = "义重为先"
	RWTFLB[627] = "降龙十二掌"
	RWTFLB[632] = "尘世业火"
	RWTFLB[633] = "四季春心"
	RWWH = {}
	RWWH["0"] = "龙的传人"
	RWWH["1"] = "觉醒之苍龙"
	RWWH["01"] = "苍半无双"
	RWWH["01b"] = "真苍半无双"
	RWWH["02"] = "百花谷主"
	RWWH["03"] = "武林至尊"
	RWWH["04"] = "武悼天王"
	RWWH[1] = "雪山飞狐"
	RWWH[2] = "毒手药仙"
	RWWH[3] = "金面佛"
	RWWH[4] = "江南恶霸"
	RWWH[5] = "太极宗师"
	RWWH[6] = "嫉恶如仇"
	RWWH[7] = "铁琴先生"
	RWWH[8] = "崆峒五老·飞龙"
	RWWH[9] = "九阳明尊"
	RWWH[10] = "光明右使"
	RWWH[11] = "光明左使"
	RWWH[12] = "白眉鹰王"
	RWWH[13] = "金毛狮王"
	RWWH[14] = "青翼蝠王"
	RWWH[15] = "紫衫龙王"
	RWWH[16] = "蝶谷医仙"
	RWWH[17] = "毒手姑婆"
	RWWH[18] = "混元霹雳"
	RWWH[19] = "气宗传人"
	RWWH[20] = "衡山掌门"
	RWWH[21] = "恒山掌门"
	RWWH[22] = "嵩山掌门"
	RWWH[23] = "泰山掌门"
	RWWH[24] = "松风观主"
	RWWH[25] = "五毒教主"
	RWWH[26] = "日月同辉"
	RWWH[27] = "唯我不败"
	RWWH[28] = "杀人名医"
	RWWH[29] = "万里独行"
	RWWH[30] = "大智若愚"
	RWWH[31] = "梅庄四友"
	RWWH[32] = "梅庄四友"
	RWWH[33] = "梅庄四友"
	RWWH[34] = "梅庄四友"
	RWWH[35] = "九剑传人"
	RWWH["35"] = "剑魔再临"
	RWWH[36] = "辟邪剑客"
	RWWH[37] = "真名神照"
	RWWH[38] = "白首太玄"
	RWWH[39] = "侠客岛主"
	RWWH[40] = "侠客岛主"
	RWWH[41] = "赏善使者"
	RWWH[42] = "罚恶使者"
	RWWH[43] = "凌霄城主"
	RWWH[44] = "凶神恶煞"
	RWWH[45] = "阎王敌"
	RWWH[46] = "星宿老怪"
	RWWH[47] = "铁丑之主"
	RWWH[48] = "冰毒怪客"
	RWWH[49] = "无"
	RWWH["49"] = "逍遥掌门"
	RWWH[50] = "狂龙天征"
	RWWH[51] = "姑苏慕容"
	RWWH[52] = "中平神枪"
	RWWH[53] = "六脉真传"
	RWWH[54] = "气侠风雷"
	RWWH[55] = "侠之大者"
	RWWH[56] = "奇术无双"
	RWWH[57] = "碧海潮生"
	RWWH[58] = "西狂"
	RWWH[59] = "联心素女"
	RWWH[60] = "西毒"
	RWWH[61] = "白驼少主"
	RWWH[62] = "元蒙帝师"
	RWWH[63] = "青萧落瑛"
	RWWH[64] = "顽童武痴"
	RWWH[65] = "南僧"
	RWWH[66] = "波斯圣女"
	RWWH[67] = "铁掌帮主"
	RWWH[68] = "长春子"
	RWWH[69] = "北丐"
	RWWH[70] = "少林掌门"
	RWWH[71] = "神龙教主"
	RWWH[72] = "天龙掌门"
	RWWH[73] = "日月圣姑"
	RWWH[74] = "翠羽黄衫"
	RWWH[75] = "天池红花"
	RWWH[76] = "琅嬛仙子"
	RWWH[77] = "鸳鸯刀客"
	RWWH[78] = "铁尸魔煞"
	RWWH[79] = "慧剑无双"
	RWWH[80] = "火手判官"
	RWWH[81] = "一阳传人"
	RWWH[82] = "玉面孟尝"
	RWWH[83] = "五仙教主"
	RWWH[84] = "吾乃蛮夷"
	RWWH[85] = "老谋深算"
	RWWH[86] = "无"
	RWWH[87] = "无"
	RWWH[88] = "酒神"
	RWWH[89] = "食神"
	RWWH[90] = "毓秀灵姝"
	RWWH[91] = "青青子衿"
	RWWH[92] = "我本佳人"
	RWWH[93] = "无"
	RWWH[94] = "仁义大刀"
	RWWH[95] = "柔云剑"
	RWWH[96] = "水月剑"
	RWWH[97] = "茹毛饮血"
	RWWH[98] = "恶贯满盈"
	RWWH[99] = "无恶不做"
	RWWH[100] = "穷凶极恶"
	RWWH[101] = "无"
	RWWH[102] = "天龙主持"
	RWWH[103] = "大轮明王"
	RWWH[104] = "无"
	RWWH[105] = "无"
	RWWH[106] = "金刀无敌"
	RWWH[107] = "华山矮叟"
	RWWH[108] = "华山高叟"
	RWWH[109] = "华山掌门"
	RWWH[110] = "游氏双雄"
	RWWH[111] = "游氏双雄"
	RWWH[112] = "大漠苍狼"
	RWWH[113] = "慕容家主"
	RWWH[114] = "达摩再世"
	RWWH[115] = "逍遥门人"
	RWWH[116] = "逍遥老祖"
	RWWH[117] = "灵鹫宫主"
	RWWH[118] = "西夏之主"
	RWWH[119] = "无"
	RWWH[120] = "无"
	RWWH[121] = "无"
	RWWH[122] = "无"
	RWWH[123] = "丹阳子"
	RWWH[124] = "长真子"
	RWWH[125] = "长生子"
	RWWH[126] = "玉阳子"
	RWWH[127] = "广宁子"
	RWWH[128] = "清净散人"
	RWWH[129] = "中神通"
	RWWH[130] = "飞天蝙蝠"
	RWWH[131] = "妙手书生"
	RWWH[132] = "马王神"
	RWWH[133] = "南山樵子"
	RWWH[134] = "笑弥勒"
	RWWH[135] = "闹市侠隐"
	RWWH[136] = "越女剑"
	RWWH[137] = "青蟒剑"
	RWWH[138] = "一指震江南"
	RWWH[139] = "郑府少主"
	RWWH[140] = "独孤传人"
	RWWH[141] = "剑宗弟子"
	RWWH[142] = "剑宗弟子"
	RWWH[143] = "温氏六老"
	RWWH[144] = "温氏六老"
	RWWH[145] = "温氏六老"
	RWWH[146] = "温氏六老"
	RWWH[147] = "温氏六老"
	RWWH[148] = "桃谷六仙"
	RWWH[149] = "少林首座"
	RWWH[150] = "一剑无血"
	RWWH[151] = "奔雷手"
	RWWH[152] = "追魂夺命"
	RWWH[153] = "千臂如来"
	RWWH[154] = "鸳鸯刀客"
	RWWH[155] = "黑无常"
	RWWH[156] = "白无常"
	RWWH[157] = "蒙古三杰"
	RWWH[158] = "蒙古三杰"
	RWWH[159] = "蒙古三杰"
	RWWH[160] = "金轮首徒"
	RWWH[161] = "赤练仙子"
	RWWH[162] = "一日不过三"
	RWWH[163] = "一日不过四"
	RWWH[164] = "摩天居士"
	RWWH[165] = "朱武庄主"
	RWWH[166] = "昆仑太上"
	RWWH[167] = "崆峒五老·追魂"
	RWWH[168] = "崆峒五老·夺命"
	RWWH[169] = "四大神僧"
	RWWH[170] = "四大神僧"
	RWWH[171] = "武当首座"
	RWWH[172] = "武当六侠"
	RWWH[173] = "波斯三使"
	RWWH[174] = "波斯三使"
	RWWH[175] = "波斯三使"
	RWWH[176] = "五仙长老"
	RWWH[177] = "太白三英"
	RWWH[178] = "太白三英"
	RWWH[179] = "太白三英"
	RWWH[180] = "仙都传人"
	RWWH[181] = "仙都传人"
	RWWH[182] = "五丁手"
	RWWH[183] = "沒影子"
	RWWH[184] = "铁剑逆徒"
	RWWH[185] = "神剑仙猿"
	RWWH[186] = "神拳无敌"
	RWWH[187] = "八面威风"
	RWWH[188] = "铜笔铁算"
	RWWH[189] = "晋阳大侠"
	RWWH[451] = "万马庄主"
	RWWH[452] = "鹤笔掌门"
	RWWH[453] = "快刀掌门"
	RWWH[454] = "青龙掌门"
	RWWH[553] = "真田一之兵"
	RWWH[587] = "绿林领袖"
	RWWH[588] = "市景豪雄"
	RWWH[589] = "冰山侠女"
	RWWH[590] = "白马之女"
	RWWH[591] = "无行浪子"
	RWWH[592] = "震古烁今"
	RWWH[593] = "酒肉罗汉"
	RWWH[594] = "万马庄主"
	RWWH[595] = "鹤笔掌门"
	RWWH[596] = "快刀掌门"
	RWWH[597] = "青龙掌门"
	RWWH[598] = "血刀恶僧"
	RWWH[599] = "铁索横江"
	RWWH[600] = "机灵小宝"
	RWWH[626] = "丐帮长老"
	RWWH[627] = "金银掌"
	RWWH[632] = "天池传人"
	RWWH[633] = "锦毛貂"
	TFJS = {}
	TFNLJS = {}
	TFNLJS["001"] = "Ｇ【天赋：颖悟绝伦】ＨＷ连击率大幅提升，无视悟性对内力上限的影响，自带北冥真气；华山觉醒后初始战意为一百二十，初始怒气为五十。ＰＧ【称号：苍半无双】ＨＷ升级时能力大幅提升；战意增长提升速度为两倍；不受自宫惩罚"
	TFNLJS["002"] = "Ｇ【天赋：万般皆通】ＨＷ自带左右互搏，无视任何条件装备任意武器防具ＰＧ【称号：百花谷主】ＨＷ装备武器防具效果加倍，左右互搏发动率提升"
	TFNLJS["004a"] = "Ｇ【天赋：攻战无前】ＨＷ集气速度增加十点ＰＧ【称号：武悼天王】ＨＷ内功加力增加伤害，受攻击时必发动血戮天威护体，额外增加气防，集气速度随生命值得下降而提升。"
	TFNLJS["004b"] = "Ｇ【天赋：攻战无前】ＨＷ暴击时必触发杀胡令，造成双倍伤害ＰＧ【称号：武悼天王】ＨＷ内功加力增加伤害，受攻击时必发动血戮天威护体，额外增加气防，集气速度随生命值得下降而提升。"
	TFNLJS["004c"] = "Ｇ【天赋：攻战无前】ＨＷ攻击时必触发杀胡令，无视任何条件，破防杀集气二百点ＰＧ【称号：武悼天王】ＨＷ内功加力增加伤害，受攻击时必发动血戮天威护体，额外增加气防，集气速度随生命值得下降而提升。"
	TFJS[290] = {
		"Ｌ【天赋：颖悟绝伦】",
		"Ｗ连击率大幅提升",
		"Ｗ自带北冥真气",
		"Ｗ觉醒后初始战意为一百二十，初始怒气为五十",
		"Ｎ",
		"Ｌ【称号：苍半无双】",
		"Ｗ升级时能力大幅提升",
		"Ｗ不受自宫惩罚",
		"Ｗ二次觉醒后战意增长速度为两倍"
	}
	TFJS[291] = {
		"Ｌ【天赋：万般皆通】",
		"Ｗ自带左右互搏",
		"Ｗ无视任何条件装备任意武器防具",
		"Ｎ",
		"Ｌ【称号：百花谷主】",
		"Ｗ装备武器防具效果加倍",
		"Ｗ二次觉醒后左右互搏发动率70%"
	}
	TFJS[292] = {
		"Ｌ【天赋：笨鸟先飞】",
		"Ｗ修炼秘籍无视悟性需求",
		"Ｗ自带野球拳",
		"Ｎ",
		"Ｌ【称号：武林至尊】",
		"Ｗ自带左右互搏",
		"Ｗ觉醒后领悟森罗特效",
		"Ｗ二次觉醒后攻击增加杀集气300点"
	}
	TFJS[293] = {
		"Ｌ【天赋：攻战无前】",
		"Ｗ集气速度增加十点",
		"Ｗ暴击时必触发杀胡令，造成双倍伤害",
		"Ｗ攻击时必触发杀胡令，无视任何条件杀集气二百点",
		"Ｗ觉醒后杀胡令增加杀集气翻倍",
		"Ｗ二次觉醒后杀胡令增加杀集气再翻倍",
		"Ｎ",
		"Ｌ【称号：武悼天王】",
		"Ｗ内功加力增加伤害",
		"Ｗ受攻击时必发动血戮天威护体，额外增加气防",
		"Ｗ集气速度随生命值下降而提升"
	}
	TFNLJS["01"] = "Ｇ【天赋：灵犀真拳】ＨＷ初始拳掌四十；每修炼一个拳法到极，攻击伤害增加；修炼降龙十八掌到极，可领悟降龙极意；终极技：天道惊雷憾。大量气攻、封穴机率大幅提升、最终攻击效果提升三分之一"
	TFNLJS["02"] = "Ｇ【天赋：剑神一笑】ＨＷ初始御剑四十；每修习一种剑法并练至极，人物集气速度提升5%；特殊武技：可无视修炼条件习得独孤九剑；终极技：一剑镇神洲。终极全屏攻击定点锁定、附加气攻值"
	TFNLJS["03"] = "Ｇ【天赋：傲世狂刀】ＨＷ初始耍刀四十；每修习一种刀法并练至极，最终防御效果提升4%；特殊武技：无名刀法，每次攻击敌人升级，最后可挥刀二十，大量杀气；终极技：羽葬煌炎斩。附加超量气攻值、无视对手气防和任何特效必定破防、被攻击者怒气值归零"
	TFNLJS["04"] = "Ｇ【天赋：奇门英才】ＨＷ初始特殊四十；初始自带天机身法，战斗中可回避敌人攻击；每修习一种特系武功并练至极，天机身法发动机率提升5%(最多提升35%)；特殊武技：使用打狗棒法高机率发动天下无狗；终极技：机龙绝闪。被攻击者必定会进入封穴和流血状态"
	TFNLJS["05"] = "Ｇ【天赋：绝世天罡】ＨＷ初始内力值五百；内力属性为天罡，包含阴，阳，调和三种性质的所有特性；战斗中可使用内功攻击并额外增加内伤，如使用的攻击内功等级为极，则有一定机率可用天罡真气催动；终极技：斗焰霸罡体。出现斗焰霸罡体就会有护体，第二次被攻击无效"
	TFNLJS["06"] = "Ｇ【天赋：仁者无敌】ＨＷ初始拳剑刀特四系值均为四十；初始道德值一百；大幅度提升特效发动机率，与道德无关；终极技：侠行天下。先手以风林或六如攻击敌方"
	TFNLJS["07"] = "Ｇ【天赋：回天圣手】ＨＷ初始医毒为二百，医毒上限值为四百；战斗中依时序自动回复生命，内伤，中毒；使用医疗时范围为七乘七范围的方阵；终极技：八门回天。立刻获得满集气，再次行动"
	TFJS[281] = {
		"Ｌ【天赋：灵犀真拳】",
		"Ｗ初始拳掌三十+",
		"Ｗ每修炼一个拳法到极，攻击伤害增加",
		"Ｗ修炼降龙十八掌到极，可领悟降龙极意",
		"Ｎ",
		"Ｌ【终极技：天道惊雷憾】",
		"Ｗ二次觉醒后领悟终极技，气攻大幅提升",
		"Ｗ封穴机率大幅提升，最终攻击效果提升三分之一"
	}
	TFJS[282] = {
		"Ｌ【天赋：剑神一笑】",
		"Ｗ初始御剑三十+",
		"Ｗ每修习一种剑法并练至极，人物集气速度提升5%",
		"Ｎ",
		"Ｌ【特殊武技】",
		"Ｗ可无视特殊限制条件习得独孤九剑",
		"Ｎ",
		"Ｚ【终极技：一剑镇神州】",
		"Ｗ二次觉醒后领悟终极技",
		"Ｗ全屏攻击定点锁定、附加气攻值"
	}
	TFJS[283] = {
		"Ｌ【天赋：傲世狂刀】",
		"Ｗ初始耍刀三十+",
		"Ｗ每修习一种刀法并练至极，最终攻击效果提升5%，防御降低2%",
		"Ｎ",
		"Ｌ【特殊武技】",
		"Ｗ无名刀法，每次攻击敌人升级",
		"Ｗ最后可挥刀二十，大量杀气",
		"Ｎ",
		"Ｚ【终极技：羽葬煌炎斩】",
		"Ｗ二次觉醒后领悟终极技，攻击附加超量气攻值",
		"Ｗ无视对手气防和任何特效必定破防",
		"Ｗ被攻击者怒气值归零"
	}
	TFJS[284] = {
		"Ｌ【天赋：奇门无双】",
		"Ｗ初始特殊三十+",
		"Ｗ初始自带天机身法，战斗中可回避敌人攻击",
		"Ｗ每修炼一个奇门武功到极，闪避率提高5%",
		"Ｗ最多可提升35%",
		"Ｎ",
		"Ｌ【特殊武技】",
		"Ｗ使用打狗棒法高机率发动天下无狗",
		"Ｎ",
		"Ｚ【终极技：千机龙绝闪】",
		"Ｗ二次觉醒后领悟终极技",
		"Ｗ被攻击者必定会进入封穴和流血状态"
	}
	TFJS[285] = {
		"Ｌ绝世天罡",
		"Ｗ内力同时拥有阴、阳、调和三种内力特性",
		"Ｗ使用内功攻击额外增加内伤",
		"Ｎ",
		"Ｄ天罡真气",
		"Ｗ使用攻击内功为极，几率触发天罡真气，提升气攻",
		"Ｎ",
		"Ｚ绝技：斗焰霸罡劲",
		"Ｗ基础内功到极自动运行为副功体，领悟斗焰霸罡体",
		"Ｗ如无内功护体，必触发斗焰霸罡体加力护体",
		"Ｗ二次觉醒后，系数不会劣势"
	}
	TFJS[286] = {
		"Ｌ仁者无敌",
		"Ｗ初始拳剑刀特四系值均为二十+；初始道德值一百，",
		"Ｗ大幅度提升特效发动机率",
		"Ｎ",
		"Ｚ绝技：侠行天下",
		"Ｗ二次觉醒后领悟终极技，先手以六如攻击敌方"
	}
	TFJS[287] = {
		"Ｌ回天圣手",
		"Ｗ初始医为一百，医疗上限值为四百",
		"Ｗ战斗中依时序自动回复生命，内伤，中毒，",
		"Ｗ使用医疗时范围为七乘七范围的方阵",
		"Ｎ",
		"Ｚ绝技：八门回天",
		"Ｗ二次觉醒后领悟终极技，立刻获得满集气，再次行动"
	}
	TFJS[288] = {
		"Ｌ乱世毒王",
		"Ｗ初始毒为一百，用毒上限值为五百",
		"Ｗ攻击时自动附加毒素",
		"Ｗ给自己上毒后，被攻击时弹出毒气",
		"Ｗ使毒时范围为七乘七范围的方阵",
		"Ｎ",
		"Ｚ绝技：荼毒天下",
		"Ｗ一次觉醒后领悟终极技，攻击时全场加毒",
		"Ｗ二次觉醒后，中毒越深，攻击和集气越高",
		"Ｗ二次觉醒后，攻击随机附带火毒或冰毒"
	}
	TFJS[289] = {
		"Ｌ幽暗之主",
		"Ｗ初始暗器三十+",
		"Ｗ暗器攻击距离增加2",
		"Ｗ攻击时附加10点毒素攻击",
		"Ｎ",
		"Ｗ一次觉醒后,被攻击者必定会进入封穴和流血状态",
		"Ｚ绝技：暗之地域",
		"Ｗ二次觉醒后领悟终极技，暗器全屏攻击"
	}
	TFNLJS[1] = "Ｇ【天赋：魂系一刀】ＨＷ使用胡家刀法极意几率和刀剑归真几率上升ＰＧ【称号：雪山飞狐】ＨＷ集气速度增加十点"
	TFNLJS[2] = "Ｇ【天赋：七心海棠】ＨＷ攻击时敌全体中毒二十点ＰＧ【称号：毒手药仙】ＨＷ用毒上限五百，医疗上限四百，攻击几率降低敌人内力"
	TFNLJS[3] = "Ｇ【天赋：胡刀苗剑】ＨＷ单独使用苗剑可发动刀剑归真，剑法伤害提示10%ＰＧ【称号：金面佛】ＨＷ使用苗家剑法连击率百分之五十，生命百分之二十五以下暴击率百分之八十"
	TFNLJS[4] = "Ｇ【天赋：临阵淬毒】ＨＷ攻击时使敌人中毒至少十点ＰＧ【称号：江南恶霸】ＨＷ攻击时额外增加伤害十点"
	TFNLJS[5] = "Ｇ【天赋：化朽为奇】ＨＷ攻击时低机率发动化朽为奇，增加伤害百分之四十，额外增加气攻；机率发动万法自然，下回合集气从一半处开始ＰＧ【称号：太极宗师】ＨＷ受攻击时机率发动无根无形，发动后高机率减少一半伤害"
	TFNLJS[6] = "Ｇ【天赋：除恶务尽】ＨＷ攻击时必暴击ＰＧ【称号：嫉恶如仇】ＨＷ连击率额外增加百分之二十"
	TFNLJS[7] = "Ｇ【天赋：三圣传人】ＨＷ被攻击时发动云龙三现有机率把一半杀集气转为集气值；使用剑法时伤害增加百分之十五且几率三连ＰＧ【称号：铁琴先生】ＨＷ被攻击时降低相当于自身道德数值伤害；两仪剑法伤害增加50%且必暴击"
	TFNLJS[8] = "Ｇ【天赋：一练七伤】ＨＷ无视内力不足时，七伤拳反噬效果；七伤拳伤害增加30%特效增强ＰＧ【称号：崆峒五老·飞龙】ＨＷ使用七伤拳低几率3连"
	TFNLJS[9] = "Ｇ【天赋：谁与争峰】ＨＷ内功加力及护体发动机率百分之百ＰＧ【称号：九阳明尊】ＨＷ无视内力差距必发动乾坤大挪移且反弹伤害百分之八十；或受到攻击以九阳神功反震攻击者百分之二十伤害"
	TFNLJS[10] = "Ｇ【天赋：忍辱负重】ＨＷ攻击时消耗体力减半ＰＧ【称号：光明右使】ＨＷ无视兵器值需求修炼秘籍"
	TFJS[1] = {
		"Ｌ【天赋：魂系一刀】",
		"Ｗ使用胡家刀法极意几率和刀剑归真几率上升",
		"Ｎ",
		"Ｌ【称号：雪山飞狐】",
		"Ｗ集气速度增加十点"
	}
	TFJS[2] = {
		"Ｌ【天赋：七心海棠】",
		"Ｗ攻击时敌全体中毒二十点",
		"Ｎ",
		"Ｌ【称号：毒手药仙】",
		"Ｗ用毒上限五百",
		"Ｗ医疗上限四百",
		"Ｗ攻击几率降低敌人内力"
	}
	TFJS[3] = {
		"Ｌ【天赋：胡刀苗剑】",
		"Ｗ使用剑法伤害提升10%",
		"Ｗ单独使用苗剑可发动刀剑归真",
		"Ｎ",
		"Ｌ【称号：金面佛】",
		"Ｗ使用苗家剑法连击率百分之五十",
		"Ｗ生命百分之二十五以下暴击率百分之八十"
	}
	TFJS[4] = {
		"Ｌ【天赋：临阵淬毒】",
		"Ｗ攻击时使敌人中毒至少十点",
		"Ｎ",
		"Ｌ【称号：江南恶霸】",
		"Ｗ攻击时额外增加伤害十点"
	}
	TFJS[5] = {
		"Ｌ【天赋：化朽为奇】",
		"Ｗ攻击时低机率发动化朽为奇，",
		"Ｗ增加伤害百分之四十，额外增加气攻。",
		"Ｗ机率发动万法自然，下回合集气从一半处开始。",
		"Ｎ",
		"Ｌ【称号：太极宗师】",
		"Ｗ受攻击时机率发动无根无形，",
		"Ｗ发动后高机率减少一半伤害"
	}
	TFJS[6] = {
		"Ｌ【天赋：除恶务尽】",
		"Ｗ攻击时必暴击",
		"Ｎ",
		"Ｌ【称号：嫉恶如仇】",
		"Ｗ连击率额外增加百分之二十"
	}
	TFJS[7] = {
		"Ｌ【天赋：三圣传人】",
		"Ｗ被攻击时发动云龙三现有机率把一半杀集气转为集气值",
		"Ｗ使用剑法时伤害增加百分之十五且几率三连",
		"Ｎ",
		"Ｌ【称号：铁琴先生】",
		"Ｗ被攻击时降低相当于自身道德数值/2伤害",
		"Ｗ两仪剑法伤害增加50%且必暴击"
	}
	TFJS[8] = {
		"Ｌ【天赋：一练七伤】",
		"Ｗ无视内力不足时，七伤拳反噬效果",
		"Ｗ七伤拳伤害增加30%特效增强",
		"Ｎ",
		"Ｌ【称号：崆峒五老】",
		"Ｗ使用七伤拳低几率3连"
	}
	TFJS[9] = {
		"Ｌ【天赋：谁与争峰】",
		"Ｗ内功加力及护体发动机率百分之百",
		"Ｎ",
		"Ｌ【称号：九阳明尊】",
		"Ｗ无视内力差距必发动乾坤大挪移且反弹伤害百分之八十",
		"Ｗ或受到攻击以九阳神功反震攻击者百分之二十伤害"
	}
	TFJS[10] = {
		"Ｌ【天赋：忍辱负重】",
		"Ｗ攻击时消耗体力减半",
		"Ｎ",
		"Ｌ【称号：光明右使】",
		"Ｗ无视兵器值需求修炼秘籍"
	}
	TFNLJS[11] = "Ｇ【天赋：狂放羁傲】ＨＷ乾坤大挪移发动率提升ＰＧ【称号：光明左使】ＨＷ无视内力属性需求修炼秘籍"
	TFNLJS[12] = "Ｇ【天赋：老当益壮】ＨＷ实战经验越高能力加成越多ＰＧ【称号：白眉鹰王】ＨＷ使用鹰爪功攻击时必连击"
	TFNLJS[13] = "Ｇ【天赋：怒发冲冠】ＨＷ使用狮子吼攻击时，杀敌全体集气二百点；使用七伤拳攻击时，强制增加内伤二十点ＰＧ【称号：金毛狮王】ＨＷ免疫葵花刺目，受攻击时无条件减伤百分之四十，没有触发内功时必以狮王金身护体，额外增加气防"
	TFNLJS[14] = "Ｇ【天赋：血冷冰魄】ＨＷ华山觉醒前初始冰封值为五十。使用任意拳类武功攻击时高机率造成冰封ＰＧ【称号：青翼蝠王】ＨＷ增加初始集气二百，集气速度增加五点，攻击几率吸血百分之二十五"
	TFNLJS[15] = "Ｇ【天赋：风华绝代】ＨＷ战斗时我方受到的伤害减少百分之二十。乾坤大挪移效果增强。ＰＧ【称号：紫衫龙王】ＨＷ敌全体移动减四格。使用灵蛇杖法百分之四十几率出极意。"
	TFNLJS[16] = "Ｇ【天赋：妙手回春】ＨＷ医疗上限五百点ＰＧ【称号：蝶谷医仙】ＨＷ可向队友用药；我方全体使用药品效果提升"
	TFNLJS[17] = "Ｇ【天赋：与毒为生】ＨＷ根据中毒程度增加集气速度ＰＧ【称号：毒手姑婆】ＨＷ用毒上限四百点"
	TFNLJS[18] = "Ｇ【天赋：魔相幻阴】ＨＷ集气速度额外增加十点；攻击时高机率发动连击ＰＧ【称号：混元霹雳】ＨＷ没有触发内功时必以混元霹雳功加力和护体，增加额外气攻和气防"
	TFNLJS[19] = "Ｇ【天赋：虚仁假义】ＨＷ修炼辟邪、葵花无惩罚ＰＧ【称号：气宗传人】ＨＷ紫霞神功恢复内力加倍，使用太岳三青峰攻击直接触发五岳剑法必连击"
	TFNLJS[20] = "Ｇ【天赋：潇湘夜雨】ＨＷ攻击时机率发动潇湘夜雨，额外增加敌方内伤,攻击时几率无视破绽区直接击中敌人破绽ＰＧ【称号：衡山掌门】ＨＷ使用云雾十三式攻击直接触发五岳剑法必流血"
	TFJS[11] = {
		"Ｌ【天赋：狂放羁傲】",
		"Ｗ乾坤大挪移发动率提升",
		"Ｎ",
		"Ｌ【称号：光明左使】",
		"Ｗ无视内力属性需求修炼秘籍"
	}
	TFJS[12] = {
		"Ｌ【天赋：老当益壮】",
		"Ｗ实战经验越高能力加成越多",
		"Ｎ",
		"Ｌ【称号：白眉鹰王】",
		"Ｗ使用鹰爪功攻击时必连击"
	}
	TFJS[13] = {
		"Ｌ【天赋：怒发冲冠】",
		"Ｗ使用狮子吼攻击时，杀敌全体集气二百点",
		"Ｗ使用七伤拳攻击时，强制增加内伤二十点",
		"Ｎ",
		"Ｌ【称号：金毛狮王】",
		"Ｗ免疫葵花刺目，受攻击时无条件减伤百分之四十",
		"Ｗ免疫头昏眼花",
		"Ｗ没有触发内功时必以狮王金身护体，额外增加气防"
	}
	TFJS[14] = {
		"Ｌ【天赋：血冷冰魄】",
		"Ｗ使用任意拳类武功攻击时高机率造成冰封",
		"Ｎ",
		"Ｌ【称号：青翼蝠王】",
		"Ｗ增加初始集气二百，集气速度增加五点",
		"Ｗ攻击几率吸血"
	}
	TFJS[15] = {
		"Ｌ【天赋：风华绝代】",
		"Ｗ战斗时我方受到的伤害减少百分之二十",
		"Ｗ乾坤大挪移效果增强",
		"Ｎ",
		"Ｌ【称号：紫衫龙王】",
		"Ｗ敌全体移动减四格",
		"Ｗ使用灵蛇杖法百分之四十几率出极意"
	}
	TFJS[16] = {
		"Ｌ【天赋：妙手回春】",
		"Ｗ医疗上限五百点",
		"Ｎ",
		"Ｌ【称号：蝶谷医仙】",
		"Ｗ可向队友用药",
		"Ｗ我方全体使用药品效果提升"
	}
	TFJS[17] = {
		"Ｌ【天赋：与毒为生】",
		"Ｗ根据中毒程度增加集气速度",
		"Ｎ",
		"Ｌ【称号：毒手姑婆】",
		"Ｗ用毒上限四百点"
	}
	TFJS[18] = {
		"Ｌ【天赋：魔相幻阴】",
		"Ｗ集气速度额外增加十点",
		"Ｗ攻击时高机率发动连击",
		"Ｎ",
		"Ｌ【称号：混元霹雳】",
		"Ｗ没有触发内功时必以混元霹雳功加力和护体",
		"Ｗ增加额外气攻和气防"
	}
	TFJS[19] = {
		"Ｌ【天赋：虚仁假义】",
		"Ｗ修炼辟邪、葵花无惩罚",
		"Ｎ",
		"Ｌ【称号：气宗传人】",
		"Ｗ紫霞神功恢复内力加倍",
		"Ｗ使用太岳三青峰攻击直接触发五岳剑法必连击"
	}
	TFJS[20] = {
		"Ｌ【天赋：潇湘夜雨】",
		"Ｗ攻击时机率发动潇湘夜雨，额外增加敌方内伤",
		"Ｗ攻击时几率无视破绽区直接击中敌人破绽",
		"Ｎ",
		"Ｌ【称号：衡山掌门】",
		"Ｗ使用云雾十三式攻击直接触发五岳剑法必流血"
	}
	TFJS[21] = {
		"Ｌ【天赋：气定神闲】",
		"Ｗ攻击时机率发动气定神闲，不会增加敌方怒气",
		"Ｎ",
		"Ｌ【称号：恒山掌门】",
		"Ｗ使用万花剑法攻击直接触发五岳剑法必灼烧"
	}
	TFJS[22] = {
		"Ｌ【天赋：冰魄寒光】",
		"Ｗ攻击时机率发动冰魄寒光，造成敌方冰封",
		"Ｗ被攻击时增加敌人冰封值",
		"Ｎ",
		"Ｌ【称号：嵩山掌门】",
		"Ｗ使用万岳朝宗攻击直接触发五岳剑法必暴击"
	}
	TFJS[23] = {
		"Ｌ【天赋：坚若磐石】",
		"Ｗ被攻击时机率发动坚若磐石，减少伤害三十点",
		"Ｎ",
		"Ｌ【称号：泰山掌门】",
		"Ｗ使用泰山十八盘攻击直接触发五岳剑法必冰封"
	}
	TFJS[24] = {
		"Ｌ【天赋：机关算尽】",
		"Ｗ攻击时机率发动伪·辟邪剑法，增加固定伤害五十点",
		"Ｎ",
		"Ｌ【称号：松风观主】",
		"Ｗ松风剑法追加额外杀集气八百点"
	}
	TFJS[25] = {
		"Ｌ【天赋：凤舞九天】",
		"Ｗ攻击威力提升百分之十",
		"Ｎ",
		"Ｌ【称号：五毒教主】",
		"Ｗ用毒上限四百点"
	}
	TFNLJS[21] = "Ｇ【天赋：气定神闲】ＨＷ攻击时机率发动气定神闲，不会增加敌方怒气ＰＧ【称号：恒山掌门】ＨＷ使用万花剑法攻击直接触发五岳剑法必灼烧"
	TFNLJS[22] = "Ｇ【天赋：冰魄寒光】ＨＷ攻击时机率发动冰魄寒光，造成敌方冰封，被攻击时增加敌人冰封值ＰＧ【称号：嵩山掌门】ＨＷ使用万岳朝宗攻击直接触发五岳剑法必暴击"
	TFNLJS[23] = "Ｇ【天赋：坚若磐石】ＨＷ被攻击时机率发动坚若磐石，减少伤害三十点ＰＧ【称号：泰山掌门】ＨＷ使用泰山十八盘攻击直接触发五岳剑法必冰封"
	TFNLJS[24] = "Ｇ【天赋：机关算尽】ＨＷ攻击时机率发动伪·辟邪剑法，增加固定伤害五十点ＰＧ【称号：松风观主】ＨＷ松风剑法追加额外杀集气八百点"
	TFNLJS[25] = "Ｇ【天赋：凤舞九天】ＨＷ攻击威力提升百分之十ＰＧ【称号：五毒教主】ＨＷ用毒上限四百点"
	TFNLJS[26] = "Ｇ【天赋：日月魔帝】ＨＷ必触发吸星大法，并额外吸取敌方体力，没有触发内功时必以魔帝·吸星加力，额外吸取体力并增加额外气攻ＰＧ【称号：日月同辉】ＨＷ没有触发内功时必以日月·同辉护体，额外增加气防；攻击时高机率发动暴击"
	TFNLJS[28] = "Ｇ【天赋：妙手回春】ＨＷ医疗上限五百点ＰＧ【称号：杀人名医】ＨＷ战斗中集气速度和医疗效果随杀敌数上升"
	TFNLJS[29] = "Ｇ【天赋：飞沙走石】ＨＷ使用狂风刀法攻击必连击，受攻击几率增加集气速度ＰＧ【称号：万里独行】ＨＷ集气速度提升，战场上已方人员越少提升越多"
	TFNLJS[30] = "Ｇ【天赋：大器晚成】ＨＷ最后十级成长时，每级能力加成点数增加六点ＰＧ【称号：大智若愚】ＨＷ修炼四系武功所需兵器值限制额外减少十点"
	TFJS[26] = {
		"Ｌ【天赋：日月魔帝】",
		"Ｗ必触发吸星大法，并额外吸取敌方体力",
		"Ｗ没有触发内功时必以魔帝·吸星加力",
		"Ｗ额外吸取体力并增加额外气攻",
		"Ｎ",
		"Ｌ【称号：日月同辉】",
		"Ｗ未触发内功必以日月·同辉护体，额外增加气防",
		"Ｗ攻击时高机率发动暴击"
	}
	TFJS[27] = {
		"Ｌ【天赋：日出东方】",
		"Ｗ攻击无误伤",
		"Ｗ攻击时机率触发葵花点穴手",
		"Ｗ攻击时30%机率击中破绽",
		"Ｗ闪避几率增加20%",
		"Ｗ额外增加气攻",
		"Ｎ",
		"Ｗ机率触发葵花刺目",
		"Ｗ敌方下回合攻击时百分之四十机率攻击落空",
		"Ｌ【称号：唯我不败】",
		"Ｗ集气速度增加二十点",
		"Ｗ使用葵花神功攻击必二连，攻击时低几率三连，",
		"Ｗ连击时伤害不减",
		"Ｎ",
		"Ｗ受攻击时机率触发移花接木反弹部分伤害"
	}
	TFJS[28] = {
		"Ｌ【天赋：妙手回春】",
		"Ｗ医疗上限五百点",
		"Ｎ",
		"Ｌ【称号：杀人名医】",
		"Ｗ战斗中集气速度和医疗效果随杀敌数上升"
	}
	TFJS[29] = {
		"Ｌ【天赋：飞沙走石】",
		"Ｗ使用狂风刀法攻击必连击",
		"Ｗ受攻击几率增加集气速度",
		"Ｎ",
		"Ｌ【称号：万里独行】",
		"Ｗ集气速度提升，战场上已方人员越少提升越多"
	}
	TFJS[30] = {
		"Ｌ【天赋：大器晚成】",
		"Ｗ最后十级成长时，每级能力加成点数增加四点",
		"Ｎ",
		"Ｌ【称号：大智若愚】",
		"Ｗ修炼四系武功所需兵器值限制额外减少十点"
	}
	TFJS[31] = {
		"Ｌ【天赋：妙笔丹青】",
		"Ｗ攻击时机率发动妙笔丹青，攻击必流血",
		"Ｎ",
		"Ｌ【称号：梅庄四友】",
		"Ｗ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	}
	TFJS[32] = {
		"Ｌ【天赋：三杯草圣】",
		"Ｗ攻击时机率发动三杯草圣，攻击必封穴",
		"Ｎ",
		"Ｌ【称号：梅庄四友】",
		"Ｗ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	}
	TFJS[33] = {
		"Ｌ【天赋：呕血楸枰】",
		"Ｗ攻击时机率发动呕血楸枰，额外增加内伤十点",
		"Ｎ",
		"Ｌ【称号：梅庄四友】",
		"Ｗ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	}
	TFJS[34] = {
		"Ｌ【天赋：七弦无形】",
		"Ｗ攻击时机率发动七弦无形剑气，额外杀内力五百点",
		"Ｎ",
		"Ｌ【称号：梅庄四友】",
		"Ｗ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	}
	TFJS[35] = {
		"Ｌ【天赋：灵奇洒脱】",
		"Ｗ战斗中移动力提升三格",
		"Ｗ连击时必暴",
		"Ｎ",
		"Ｌ【称号：九剑传人】",
		"Ｗ进入战斗立即行动"
	}
	TFJS[36] = {
		"Ｌ【天赋：葵花传人】",
		"Ｗ初始集气七百",
		"Ｎ",
		"Ｌ【称号：辟邪剑客】",
		"Ｗ不受自宫的惩罚影响",
		"Ｗ辟邪剑法连击几率增加"
	}
	TFJS[37] = {
		"Ｌ【天赋：赤心连城】",
		"Ｗ攻击效果受主角品德影响，越高加成越多",
		"Ｎ",
		"Ｌ【称号：真名神照】",
		"Ｗ神照功满血复活，复活后立即行动",
		"Ｗ领悟神照经真髓后时序回血、回内、减内伤、清毒"
	}
	TFJS[38] = {
		"Ｌ【天赋：质朴刚健】",
		"Ｗ个人特效发动率增加十点",
		"Ｗ回合结束战意加一",
		"Ｎ",
		"Ｌ【称号：白首太玄】",
		"Ｗ太玄神功提升特效发动机率效果为两倍"
	}
	TFJS[39] = {
		"Ｌ【天赋：白首太玄】",
		"Ｗ使用太玄神功攻击时不会增加敌方怒气",
		"Ｎ",
		"Ｌ【称号：侠客岛主】",
		"Ｗ攻击时额外增加百分之二十伤害"
	}
	TFJS[40] = {
		"Ｌ【天赋：白首太玄】",
		"Ｗ使用太玄神功攻击时不会增加敌方怒气",
		"Ｎ",
		"Ｌ【称号：侠客岛主】",
		"Ｗ受攻击时额外减少百分之二十伤害"
	}
	TFNLJS[31] = "Ｇ【天赋：妙笔丹青】ＨＷ攻击时机率发动妙笔丹青，攻击必流血ＰＧ【称号：梅庄四友】ＨＷ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	TFNLJS[32] = "Ｇ【天赋：三杯草圣】ＨＷ攻击时机率发动三杯草圣，攻击必封穴ＰＧ【称号：梅庄四友】ＨＷ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	TFNLJS[33] = "Ｇ【天赋：呕血楸枰】ＨＷ攻击时机率发动呕血楸枰，额外增加内伤十点ＰＧ【称号：梅庄四友】ＨＷ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	TFNLJS[34] = "Ｇ【天赋：七弦无形】ＨＷ攻击时机率发动七弦无形剑气，额外杀内力五百点ＰＧ【称号：梅庄四友】ＨＷ使用琴棋书画类武功攻击时，固定增加伤害五十点"
	TFNLJS[35] = "Ｇ【天赋：灵奇洒脱】ＨＷ战斗中移动力提升三格，连击时必暴ＰＧ【称号：九剑传人】ＨＷ进入战斗立即行动"
	TFNLJS[36] = "Ｇ【天赋：葵花传人】ＨＷ初始集气七百；葵花神功可攻击ＰＧ【称号：辟邪剑客】ＨＷ不受自宫的惩罚影响；辟邪剑法连击几率增加"
	TFNLJS[37] = "Ｇ【天赋：赤心连城】ＨＷ攻击效果受主角品德影响，越高加成越多ＰＧ【称号：真名神照】ＨＷ神照功满血复活，复活后立即行动。领悟神照经真髓后时序回血、回内、减内伤、清毒"
	TFNLJS[38] = "Ｇ【天赋：质朴刚健】ＨＷ个人特效发动率增加十点;回合结束战意加一。ＰＧ【称号：白首太玄】ＨＷ太玄神功提升特效发动机率效果为两倍"
	TFNLJS[39] = "Ｇ【天赋：白首太玄】ＨＷ使用太玄神功攻击时不会增加敌方怒气ＰＧ【称号：侠客岛主】ＨＷ攻击时额外增加百分之二十伤害"
	TFNLJS[40] = "Ｇ【天赋：白首太玄】ＨＷ使用太玄神功攻击时不会增加敌方怒气ＰＧ【称号：侠客岛主】ＨＷ受攻击时额外减少百分之二十伤害"
	TFJS[41] = {
		"Ｌ【天赋：烈火至阳】",
		"Ｗ攻击阴性内力的敌人时，伤害增加百分之三十",
		"Ｎ",
		"Ｌ【称号：赏善使者】",
		"Ｗ攻击时必造成灼烧"
	}
	TFJS[42] = {
		"Ｌ【天赋：玄水至阴】",
		"Ｗ攻击阳性内力的敌人时，伤害增加百分之三十",
		"Ｎ",
		"Ｌ【称号：罚恶使者】",
		"Ｗ攻击时必造成冰封"
	}
	TFJS[43] = {
		"Ｌ【天赋：气寒西北】",
		"Ｗ攻击时若造成的冰封值加倍",
		"Ｎ",
		"Ｌ【称号：凌霄城主】",
		"Ｗ使用雪山剑法攻击必连击"
	}
	TFJS[44] = {
		"Ｌ【天赋：愚者千虑】",
		"Ｗ无视限制修炼所有医书",
		"Ｎ",
		"Ｌ【称号：凶神恶煞】",
		"Ｗ道德越低防御越高",
		"Ｗ暴击时伤害效果两倍"
	}
	TFJS[45] = {
		"Ｌ【天赋：妙手回春】",
		"Ｗ医疗上限五百点",
		"Ｎ",
		"Ｌ【称号：阎王敌】",
		"Ｗ战斗中可复活队友一次"
	}
	TFJS[46] = {
		"Ｌ【天赋：三笑逍遥】",
		"Ｗ攻击时机率发动三笑逍遥散，",
		"Ｗ全场敌人大幅度降低生命",
		"Ｎ",
		"Ｌ【称号：星宿老怪】",
		"Ｗ自带化功大法，攻击必定发动"
	}
	TFJS[47] = {
		"Ｌ【天赋：阴狠毒辣】",
		"Ｗ化功大法必触发",
		"Ｎ",
		"Ｌ【称号：铁丑之主】",
		"Ｗ与游坦之同在战场时，游坦之攻击必暴击"
	}
	TFJS[48] = {
		"Ｌ【天赋：心无所住】",
		"Ｗ使用内功攻击增加集气伤害",
		"Ｎ",
		"Ｌ【称号：冰毒怪客】",
		"Ｗ所有攻击带毒兩百四十点"
	}
	TFJS[49] = {
		"Ｌ【天赋：福缘深厚】",
		"Ｗ攻击后五十机率从集气槽五分之一处开始集气",
		"Ｎ",
		"Ｌ【称号：逍遥掌门】",
		"Ｗ无条件学习八荒六合功",
		"Ｗ天山六阳掌机率出生死符，大幅杀集气"
	}
	TFJS[50] = {
		"Ｌ【天赋：奋英雄怒】",
		"Ｗ集气速度加十点",
		"Ｗ攻击时必暴击",
		"Ｗ二连击机率百分之六十",
		"Ｗ降龙三叠浪机率百分之二十",
		"Ｎ",
		"Ｗ攻击伤害额外提升百分之五十",
		"Ｗ免疫封穴",
		"Ｗ内力濒临枯竭时攻击后会自动回复一定量的内力",
		"Ｎ",
		"Ｌ【称号：狂龙天征】",
		"Ｗ没有触发内功时必以擒龙功加力护体，",
		"Ｗ额外增加大量气攻气防",
		"Ｗ受攻击时额外减伤百分之十",
		"Ｗ生命越低防御越高",
		"Ｗ降龙十八掌极意发动率百分之百",
		"Ｗ怒气爆发时必出降龙三叠浪"
	}
	TFNLJS[41] = "Ｇ【天赋：烈火至阳】ＨＷ攻击阴性内力的敌人时，伤害增加百分之三十ＰＧ【称号：赏善使者】ＨＷ攻击时必造成灼烧"
	TFNLJS[42] = "Ｇ【天赋：玄水至阴】ＨＷ攻击阳性内力的敌人时，伤害增加百分之三十ＰＧ【称号：罚恶使者】ＨＷ攻击时必造成冰封"
	TFNLJS[43] = "Ｇ【天赋：气寒西北】ＨＷ攻击时若造成的冰封值加倍ＰＧ【称号：凌霄城主】ＨＷ使用雪山剑法攻击必连击"
	TFNLJS[44] = "Ｇ【天赋：愚者千虑】ＨＷ无视限制修炼所有医书ＰＧ【称号：凶神恶煞】ＨＷ道德越低防御越高，暴击时伤害效果两倍"
	TFNLJS[45] = "Ｇ【天赋：妙手回春】ＨＷ医疗上限五百点ＰＧ【称号：阎王敌】ＨＷ战斗中可复活队友一次"
	TFNLJS[46] = "Ｇ【天赋：三笑逍遥】ＨＷ攻击时机率发动三笑逍遥散，全场敌人大幅度降低生命ＰＧ【称号：星宿老怪】ＨＷ自带化功大法，攻击必定发动"
	TFNLJS[47] = "Ｇ【天赋：阴狠毒辣】ＨＷ化功大法必触发ＰＧ【称号：铁丑之主】ＨＷ与游坦之同在战场时，游坦之攻击必暴击"
	TFNLJS[48] = "Ｇ【天赋：心无所住】ＨＷ能使用任意内功攻击并增加集气伤害ＰＧ【称号：冰毒怪客】ＨＷ所有攻击带毒兩百四十点"
	TFNLJS[49] = "Ｇ【天赋：福缘深厚】ＨＷ攻击后百分之五十机率从集气槽五分之一处开始集气ＰＧ【称号：逍遥掌门】ＨＷ无条件学习八荒六合功，使用天山六阳掌威力双倍并一定机率打出生死符，大幅杀集气"
	TFNLJS[50] = "Ｇ【天赋：奋英雄怒】ＨＷ集气速度加二十点；攻击时必暴击；二连击机率百分之六十；降龙三叠浪机率百分之二十；攻击伤害额外提升百分之五十；受攻击时额外减伤百分之十；免疫封穴；内力濒临枯竭时攻击后会自动回复一定量的内力ＰＧ【称号：狂龙天征】ＨＷ没有触发内功时必以擒龙功加力护体，额外增加大量气攻气防；降龙十八掌极意发动率百分之百；怒气爆发时必出降龙三叠浪"
	TFJS[51] = {
		"Ｌ【天赋：离合参商】",
		"Ｗ斗转发动机率大幅提升",
		"Ｗ斗转反击时无视兵器值限制，必出离合参商",
		"Ｎ",
		"Ｌ【称号：姑苏慕容】",
		"Ｗ斗转星移耗内力值减少",
		"Ｗ斗转反击可自控"
	}
	TFJS[52] = {
		"Ｌ【天赋：彼尸可餐】",
		"Ｗ攻击每杀死一人，自动恢复一百五十点生命",
		"Ｎ",
		"Ｌ【称号：中平神枪】",
		"Ｗ中平枪法攻击额外追加杀集气能力"
	}
	TFJS[53] = {
		"Ｌ【天赋：磊落仁心】",
		"Ｗ吸功发动几率上升并可同时触发",
		"Ｗ和王语嫣同时在场时必连",
		"Ｎ",
		"Ｌ【称号：六脉真传】",
		"Ｗ六脉神剑大招发动率百分之六十"
	}
	TFJS[54] = {
		"Ｌ【天赋：志垂日月】",
		"Ｗ自动恢复内伤",
		"Ｗ被攻击时几率发动神行百变，伤害和杀气减半",
		"Ｎ",
		"Ｌ【称号：气侠风雷】",
		"Ｗ暴击率提升百分之三十",
		"Ｗ使用拳剑额外增加连击几率",
		"Ｗ内功加力几率提升百分之十五"
	}
	TFJS[55] = {
		"Ｌ【天赋：大器晚成】",
		"Ｗ最后十级成长时，每级能力加成点数为四点",
		"Ｎ",
		"Ｌ【称号：侠之大者】",
		"Ｗ左右几率百分之八十",
		"Ｗ队友死亡时增加集气速度"
	}
	TFJS[56] = {
		"Ｌ【天赋：兰心慧质】",
		"Ｗ修炼秘籍成功时兵器值成长两倍",
		"Ｎ",
		"Ｌ【称号：奇术无双】",
		"Ｗ使用打狗棒法几率发动极意",
		"Ｗ战前可进行布阵"
	}
	TFJS[57] = {
		"Ｌ【天赋：奇门奥义】",
		"Ｗ集气速度加十点",
		"Ｗ攻击增加封穴10点",
		"Ｗ未触发内功必以奇门奥义加力护体，额外增加气攻气防",
		"Ｎ",
		"Ｌ【称号：碧海潮生】",
		"Ｗ攻击时低几率发动落英缤纷敌全体内力减少八百，",
		"Ｗ如内力不足时，内力变为零，再减生命一百",
		"Ｗ碧海潮生几率减敌集气1000",
		"Ｗ使用弹指神通必封穴,使用落英神剑掌必三连"
	}
	TFJS[58] = {
		"Ｌ【天赋：逆流勇进】",
		"Ｗ随内伤加重额外提升集气速度",
		"Ｗ生命百分之五十以下暴击率两倍",
		"Ｗ百分之二十五以下暴击率三倍",
		"Ｎ",
		"Ｌ【称号：西狂】",
		"Ｗ攻击时必发动西狂之怒啸，敌全员集气减一百",
		"Ｗ御剑能力一百二十时可学习独孤九剑"
	}
	TFJS[59] = {
		"Ｌ【天赋：冷剑冰霜】",
		"Ｗ左右发动机率50%",
		"Ｎ",
		"Ｌ【称号：联心素女】",
		"Ｗ使用玉女素心剑攻击必连击"
	}
	TFJS[60] = {
		"Ｌ【天赋：倒行逆施】",
		"Ｗ被攻击必定进入走火入魔状态",
		"Ｎ",
		"Ｌ【称号：西毒】",
		"Ｗ攻击无误伤",
		"Ｗ攻击时无视对方抗毒能力追加三十点中毒"
	}
	TFNLJS[51] = "Ｇ【天赋：离合参商】ＨＷ斗转发动机率大幅提升；斗转反击时无视兵器值限制，必出离合参商ＰＧ【称号：姑苏慕容】ＨＷ斗转星移耗内力值减少；斗转反击可自控"
	TFNLJS[52] = "Ｇ【天赋：彼尸可餐】ＨＷ攻击每杀死一人，自动恢复一百五十点生命ＰＧ【称号：中平神枪】ＨＷ中平枪法攻击额外追加杀集气能力"
	TFNLJS[53] = "Ｇ【天赋：磊落仁心】ＨＷ无视悟性对内力上限的影响，吸功发动几率上升并可同时触发，和王语嫣同时在场时必连ＰＧ【称号：六脉真传】ＨＷ六脉神剑大招发动率百分之六十"
	TFNLJS[54] = "Ｇ【天赋：志垂日月】ＨＷ自动恢复内伤,被攻击时几率发动神行百变 伤害和杀气减半ＰＧ【称号：气侠风雷】ＨＷ暴击率提升百分之三十；使用拳剑额外增加连击几率；内功加力几率提升百分之十五"
	TFNLJS[55] = "Ｇ【天赋：大器晚成】ＨＷ最后十级成长时，每级能力加成点数为六点ＰＧ【称号：侠之大者】ＨＷ左右几率百分之八十，队友死亡时增加集气速度。"
	TFNLJS[56] = "Ｇ【天赋：兰心慧质】ＨＷ修炼秘籍成功时兵器值成长两倍ＰＧ【称号：奇术无双】ＨＷ使用打狗棒法几率发动极意。战前可进行布阵"
	TFNLJS[57] = "Ｇ【天赋：奇门奥义】ＨＷ集气速度加十点；没有触发内功时必以奇门奥义加力护体，额外增加气攻气防ＰＧ【称号：碧海潮生】ＨＷ使用使用玉箫剑法第一次攻击时敌全体内力减少八百，如内力不足时，内力变为零，再减生命一百。使用弹指神通必封穴,使用落英神剑掌必三连"
	TFNLJS[58] = "Ｇ【天赋：逆流勇进】ＨＷ随内伤加重额外提升集气速度；生命百分之五十以下暴击率两倍；百分之二十五以下暴击率三倍ＰＧ【称号：西狂】ＨＷ攻击时必发动西狂之怒啸，敌全员集气减一百；御剑能力一百二十时可学习独孤九剑"
	TFNLJS[59] = "Ｇ【天赋：冷剑冰霜】ＨＷ左右发动机率50%ＰＧ【称号：联心素女】ＨＷ使用玉女素心剑攻击必连击"
	TFNLJS[60] = "Ｇ【天赋：倒行逆施】ＨＷ被攻击必定进入走火入魔状态ＰＧ【称号：西毒】ＨＷ攻击无误伤。攻击时无视对方抗毒能力追加三十点中毒"
	TFJS[61] = {
		"Ｌ【天赋：风流成性】",
		"Ｗ对女性伤害减少百分之十",
		"Ｗ对除女性外伤害增加百分之十",
		"Ｎ",
		"Ｌ【称号：白驼少主】",
		"Ｗ使用灵蛇拳随机一到两倍伤害",
		"Ｗ学会逆运速度额外加成"
	}
	TFJS[62] = {
		"Ｌ【天赋：五轮映心】",
		"Ｗ未触发内功必以五轮映心护体，额外增加气防蓄力效果",
		"Ｎ",
		"Ｌ【称号：元蒙帝师】",
		"Ｗ任何攻击大幅追加杀集气能力"
	}
	TFJS[63] = {
		"Ｌ【天赋：外和内刚】",
		"Ｗ生命百分之五十以下伤害上升百分之三十",
		"Ｎ",
		"Ｌ【称号：青萧落瑛】",
		"Ｗ使用玉萧剑法攻击杀敌内力六百点",
		"Ｗ华山觉醒后被攻击机率敌方全体集气减两百点"
	}
	TFJS[64] = {
		"Ｌ【天赋：童真永留】",
		"Ｗ左右互搏必发动",
		"Ｎ",
		"Ｌ【称号：顽童武痴】",
		"Ｗ每行动一次攻击效果提升百分之十",
		"Ｗ未触发内功必以九阴神功加力护体，额外增加气攻气防"
	}
	TFJS[65] = {
		"Ｌ【天赋：先天一阳】",
		"Ｗ战败后可满血复活一次，复活后立即行动，",
		"Ｗ所有负面状态清零",
		"Ｗ使用一阳指威力翻倍",
		"Ｎ",
		"Ｌ【称号：南僧】",
		"Ｗ集气速度加五点"
	}
	TFJS[66] = {
		"Ｌ【天赋：先天聪慧】",
		"Ｗ同练乾坤与圣火增加集气速度十点",
		"Ｎ",
		"Ｌ【称号：波斯圣女】",
		"Ｗ敌全体移动减四格",
		"Ｗ乾坤效果增强"
	}
	TFJS[67] = {
		"Ｌ【天赋：水上漂】",
		"Ｗ集气速度加五，移动步数加二",
		"Ｎ",
		"Ｌ【称号：铁掌帮主】",
		"Ｗ使用铁掌暴击伤害翻倍，高几率连击"
	}
	TFJS[68] = {
		"Ｌ【天赋：一言止杀】",
		"Ｗ敌人战意每回合额外下降二点",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻且必连击",
		"Ｗ七星剑法伤害增加30%且必暴",
		"Ｎ",
		"Ｌ【称号：长春子】",
		"Ｗ免疫连击的最后一击",
		"Ｗ若攻击为第二击时几率触发气返先天吸取一定生命值"
	}
	TFJS[69] = {
		"Ｌ【天赋：无坚不摧】",
		"Ｗ降龙十八掌伤害提升百分之二十",
		"Ｎ",
		"Ｌ【称号：北丐】",
		"Ｗ降龙十八掌极意发动率百分之五十",
		"Ｗ几率触发打狗极意",
		"Ｗ攻击内伤加倍"
	}
	TFJS[70] = {
		"Ｌ【天赋：金刚达摩】",
		"Ｗ大金刚掌攻击必发动达摩掌",
		"Ｗ攻击触发灼烧时追加十分之一拳掌功夫的灼烧值",
		"Ｎ",
		"Ｌ【称号：伏虎罗汉】",
		"Ｗ易筋神功加力时必发动“袈裟伏魔”增加杀气",
		"Ｗ若加力时使用大金刚掌必灼烧",
		"Ｗ伤害随生命减少而递增"
	}
	TFJS[71] = {
		"Ｌ【天赋：豹胎易筋】",
		"Ｗ攻击时超低机率发动豹胎易筋，",
		"Ｗ使敌方狂乱100时序后死亡，",
		"Ｗ只对杂兵有效",
		"Ｎ",
		"Ｌ【称号：神龙教主】",
		"Ｗ攻击时连击、暴击机率额外提升",
		"Ｗ受内伤攻防不降反升",
		"Ｗ己方每多一人集气速度加一"
	}
	TFJS[72] = {
		"Ｌ【天赋：雷震天龙】",
		"Ｗ使用雷震剑法攻击时必连击",
		"Ｎ",
		"Ｌ【称号：天龙掌门】",
		"Ｗ攻击苗人凤后，攻，防，轻各增长二十点，",
		"Ｗ雷震剑法换为苗剑一级"
	}
	TFJS[73] = {
		"Ｌ【天赋：琴铮盈盈】",
		"Ｗ使用扶瑶琴攻击时机率发动七弦无形剑气，",
		"Ｗ敌全体减生命八十点",
		"Ｎ",
		"Ｌ【称号：日月圣姑】",
		"Ｗ与令狐冲在战场时使用扶瑶琴攻击机率发动笑傲江湖：",
		"Ｗ两人体力受伤全回复"
	}
	TFJS[74] = {
		"Ｌ【天赋：巾帼之才】",
		"Ｗ我方全体防御效果上升百分之二十",
		"Ｎ",
		"Ｌ【称号：翠羽黄衫】",
		"Ｗ使用三分剑术攻击杀敌体力十点"
	}
	TFJS[75] = {
		"Ｌ【天赋：忧国忧民】",
		"Ｗ攻击时机率触发忧国忧民，伤害增加百分之二十",
		"Ｎ",
		"Ｌ【称号：天池红花】",
		"Ｗ升级时兵器值高成长"
	}
	TFNLJS[62] = "Ｇ【天赋：五轮映心】ＨＷ没有触发内功时必以五轮映心护体，额外增加气防蓄力效果增加ＰＧ【称号：元蒙帝师】ＨＷ任何攻击大幅追加杀集气能力"
	TFNLJS[63] = "Ｇ【天赋：外和内刚】ＨＷ生命百分之五十以下伤害上升百分之三十ＰＧ【称号：青萧落瑛】ＨＷ使用玉萧剑法攻击杀敌内力六百点。华山觉醒后被攻击机率敌方全体集气减两百点。"
	TFNLJS[64] = "Ｇ【天赋：童真永留】ＨＷ左右互搏必发动ＰＧ【称号：顽童武痴】ＨＷ每行动一次攻击效果提升百分之十；没有触发内功时必以九阴神功加力护体，额外增加气攻气防"
	TFNLJS[65] = "Ｇ【天赋：先天一阳】ＨＷ战败后可满血复活一次，复活后立即行动，所有负面状态清零ＰＧ【称号：南僧】ＨＷ集气速度加五点"
	TFNLJS[66] = "Ｇ【天赋：聪慧】ＨＷ同练乾坤与圣火增加集气速度十点;内力上限增加两千五百ＰＧ【称号：波斯圣女】ＨＷ敌全体移动减四格;乾坤效果增强"
	TFNLJS[67] = "Ｇ【天赋：水上漂】ＨＷ集气速度加五，移动步数加二ＰＧ【称号：铁掌帮主】ＨＷ使用铁掌暴击伤害翻倍，使用铁掌高几率连击"
	TFNLJS[68] = "Ｇ【天赋：一言止杀】ＨＷ敌人战意每回合额外下降二点;攻击几率发动“七星汇聚”大量增加气攻且必连击；七星剑法伤害增加30%且必暴ＰＧ【称号：长春子】ＨＷ免疫连击的最后一击；若攻击为第二击时几率触发气返先天吸取一定生命值"
	TFNLJS[69] = "Ｇ【天赋：无坚不摧】ＨＷ降龙十八掌伤害提升百分之二十ＰＧ【称号：北丐】ＨＷ降龙十八掌极意发动率百分之五十，几率触发打狗极意"
	TFNLJS[70] = "Ｇ【天赋：金刚达摩】ＨＷ大金刚掌攻击必发动达摩掌；攻击触发灼烧时追加十分之一拳掌功夫的灼烧值ＰＧ【称号：伏虎罗汉】ＨＷ易筋神功加力时必发动“袈裟伏魔”增加杀气，若加力时使用大金刚掌必灼烧；伤害随生命减少而递增"
	TFNLJS[71] = "Ｇ【天赋：豹胎易筋】ＨＷ攻击时超低机率发动豹胎易筋，使敌方狂乱100时序后死亡，只对杂兵有效ＰＧ【称号：神龙教主】ＨＷ攻击时连击、暴击机率额外提升，受内伤攻防不降反升；己方每多一人集气速度加一"
	TFNLJS[72] = "Ｇ【天赋：雷震天龙】ＨＷ雷震剑法攻击时必连击ＰＧ【称号：天龙掌门】ＨＷ攻击苗人凤后，攻，防，轻各增长二十点，雷震剑法换为苗剑一级"
	TFNLJS[73] = "Ｇ【天赋：琴铮盈盈】ＨＷ使用扶瑶琴攻击时机率发动七弦无形剑气：敌全体减生命一百五十点ＰＧ【称号：日月圣姑】ＨＷ与令狐冲在战场时使用扶瑶琴攻击机率发动笑傲江湖：两人体力受伤全回复"
	TFNLJS[74] = "Ｇ【天赋：巾帼之才】ＨＷ我方全体防御效果上升百分之二十ＰＧ【称号：翠羽黄衫】ＨＷ使用三分剑术攻击杀敌体力十点"
	TFNLJS[75] = "Ｇ【天赋：庖丁解牛】ＨＷ攻击时机率触发庖丁解牛，伤害增加百分之二十ＰＧ【称号：天池红花】ＨＷ升级时兵器值高成长"
	TFJS[76] = {
		"Ｌ【天赋：博闻强记】",
		"Ｗ无视任何限制条件修炼任何秘籍",
		"Ｎ",
		"Ｌ【称号：琅嬛仙子】",
		"Ｗ提升队伍武常及队伍特效发动机率"
	}
	TFJS[77] = {
		"Ｌ【天赋：万仞刀魂】",
		"Ｗ学习刀法时按增加的刀法值，额外增加攻防轻",
		"Ｎ",
		"Ｌ【称号：鸳鸯刀客】",
		"Ｗ暴气时必连且使用鸳鸯刀法大幅杀气",
		"Ｗ使用夫妻刀法攻击必暴击"
	}
	TFJS[78] = {
		"Ｌ【天赋：九阴神爪】",
		"Ｗ学习九阴真经后增加集气速度五点",
		"Ｗ九阴白骨爪威力两倍",
		"Ｎ",
		"Ｌ【称号：铁尸魔煞】",
		"Ｗ受攻击时减伤百分之十",
		"Ｗ免疫葵花刺目"
	}
	TFJS[79] = {
		"Ｌ【天赋：慧中灵剑】",
		"Ｗ每修习一种剑法并且等级达到极之后，",
		"Ｗ自身攻击伤害效果提升百分之五",
		"Ｎ",
		"Ｌ【称号：慧剑无双】",
		"Ｗ使用太岳三青峰攻击额外追加杀集气"
	}
	TFJS[80] = {
		"Ｌ【天赋：勇猛精进】",
		"Ｗ我方全体攻击效果上升百分之二十",
		"Ｎ",
		"Ｌ【称号：火手判官】",
		"Ｗ攻击时使对手降低体力八点，受伤程度翻倍"
	}
	TFJS[81] = {
		"Ｌ【天赋：雪岭毒姝】",
		"Ｗ冰封值时序恢复速度加倍",
		"Ｗ在战场上低机率发现珍贵药材",
		"Ｎ",
		"Ｌ【称号：一阳传人】",
		"Ｗ一阳指攻击必暴击",
		"Ｗ不受内力属性影响，高几率封穴"
	}
	TFJS[82] = {
		"Ｌ【天赋：太极传人】",
		"Ｗ无条件学习太极套装",
		"Ｗ被攻击一定几率将杀集气转换为一半加集气",
		"Ｗ太奥发动几率额外增加",
		"Ｎ",
		"Ｌ【称号：玉面孟尝】",
		"Ｗ战场上我方女性角色越多，攻击越高，集气越快",
		"Ｗ被女性攻击时伤害降低百分之二十"
	}
	TFJS[83] = {
		"Ｌ【天赋：铁袖拂风】",
		"Ｗ攻击威力提升百分之十",
		"Ｗ使用五毒神掌威力随机一至三倍",
		"Ｎ",
		"Ｌ【称号：五仙教主】",
		"Ｗ用毒上限四百点",
		"Ｗ攻击带毒被攻击使敌人中毒"
	}
	TFJS[84] = {
		"Ｌ【天赋：钉骨铁扇】",
		"Ｗ攻击几率发动钉骨扇，增加伤害且使敌人中毒",
		"Ｎ",
		"Ｌ【称号：吾乃蛮夷】",
		"Ｗ任何攻击追加杀集气能力"
	}
	TFJS[85] = {
		"Ｌ【天赋：阴谋小人】",
		"Ｗ攻击几率发动阴谋小人，增加伤害且使敌人中毒",
		"Ｎ",
		"Ｌ【称号：老谋深算】",
		"Ｗ每次受到攻击自动回血五十点",
		"Ｗ医疗上限四百点"
	}
	TFNLJS[76] = "Ｇ【天赋：博闻强记】ＨＷ无视任何限制条件修炼任何秘籍ＰＧ【称号：琅嬛仙子】ＨＷ提升队伍武常及队伍特效发动机率"
	TFNLJS[77] = "Ｇ【天赋：万仞刀魂】ＨＷ学习刀法时按增加的刀法值，额外增加攻防轻ＰＧ【称号：鸳鸯刀客】ＨＷ暴气时必连且使用鸳鸯刀法大幅杀气，使用夫妻刀法攻击必暴击"
	TFNLJS[78] = "Ｇ【天赋：九阴神爪】ＨＷ学习九阴真经后增加集气速度五点，九阴白骨爪威力两倍ＰＧ【称号：铁尸魔煞】ＨＷ受攻击时减伤百分之十；免疫葵花刺目"
	TFNLJS[79] = "Ｇ【天赋：慧中灵剑】ＨＷ每修习一种剑法并且等级达到极之后，自身攻击伤害效果提升百分之五ＰＧ【称号：慧剑无双】ＨＷ使用太岳三青峰攻击额外追加杀集气"
	TFNLJS[80] = "Ｇ【天赋：勇猛精进】ＨＷ我方全体攻击效果上升百分之二十ＰＧ【称号：火手判官】ＨＷ攻击时使对手降低体力八点，受伤程度翻倍"
	TFNLJS[81] = "Ｇ【天赋：雪岭毒姝】ＨＷ冰封值时序恢复速度加倍；若使敌人战意值下降时，下降数值为双倍；在战场上低机率发现食材ＰＧ【称号：一阳传人】ＨＷ一阳指攻击必暴击；不受内力属性影响，高几率封穴"
	TFNLJS[82] = "Ｇ【天赋：太极传人】ＨＷ无条件学习太极套装；被攻击一定几率将杀集气转换为一半加集气；太奥发动几率额外增加ＰＧ【称号：玉面孟尝】ＨＷ战场上我方女性角色越多，攻击效果越高，集气速度越快；被女性攻击时伤害降低百分之二十"
	TFNLJS[83] = "Ｇ【天赋：铁袖拂风】ＨＷ攻击威力提升百分之十；使用五毒神掌威力随机一至三倍ＰＧ【称号：五仙教主】ＨＷ用毒上限四百点;攻击带毒被攻击使敌人中毒"
	TFNLJS[84] = "Ｇ【天赋：钉骨扇】ＨＷ攻击几率发动钉骨扇，增加伤害且使敌人中毒ＰＧ【称号：吾乃蛮夷】ＨＷ任何攻击追加杀集气能力"
	TFNLJS[85] = "Ｇ【天赋：未完成】ＨＷＰＧ【称号：老谋深算】ＨＷ每次受到攻击自动回血五十点，医疗上限四百点"
	TFJS[86] = {
		"Ｌ【天赋：倾国倾城】",
		"Ｗ敌全体防御效果降百分之二十"
	}
	TFJS[87] = {
		"Ｌ【天赋：媚眼如丝】",
		"Ｗ敌全体攻击效果降百分之二十"
	}
	TFJS[88] = {
		"Ｌ【天赋：聚气归还】",
		"Ｗ每回合恢复内力",
		"Ｎ",
		"Ｌ【称号：酒神】",
		"Ｗ被攻击时机率发动酒神秘踪步，闪躲攻击",
		"Ｗ若人厨子在场，攻击必暴"
	}
	TFJS[89] = {
		"Ｌ【天赋：身体强健】",
		"Ｗ攻击连击必暴",
		"Ｗ每回合恢复一百生命,生命上限增加五百",
		"Ｎ",
		"Ｌ【称号：食神】",
		"Ｗ攻击不减体力",
		"Ｗ若祖千秋在场，攻击必连"
	}
	TFJS[90] = {
		"Ｌ【天赋：身轻如燕】",
		"Ｗ修炼武功时轻功双倍成长",
		"Ｎ",
		"Ｌ【称号：毓秀灵姝】",
		"Ｗ用闪电貂攻击时，一定机率可偷窃对方的物品"
	}
	TFJS[91] = {
		"Ｌ【天赋：妙手连环】",
		"Ｗ连击伤害不减",
		"Ｗ使用雷震剑法攻击随机一至三倍威力",
		"Ｎ",
		"Ｌ【称号：青青女王】",
		"Ｗ金蛇剑法必爆",
		"Ｗ使用任何剑法武功高流血"
	}
	TFJS[92] = {
		"Ｌ【天赋：国色天香】",
		"Ｗ我方攻击伤害提高百分之十",
		"Ｎ",
		"Ｌ【称号：我本佳人】",
		"Ｗ和主角在战场时主角集气速度提升五点"
	}
	TFJS[94] = {
		"Ｌ【天赋：四奇魁首】",
		"Ｗ使我方暴击率提升",
		"Ｎ",
		"Ｌ【称号：仁义大刀】",
		"Ｗ使用鬼头刀法攻击时必连击几率三连",
		"Ｗ道德值越高，受到伤害减轻越多"
	}
	TFJS[95] = {
		"Ｌ【天赋：柔劲传人】",
		"Ｗ被攻击时使用柔劲反击敌人造成固定50点伤害，",
		"Ｗ并降低伤害30",
		"Ｎ",
		"Ｌ【称号：柔云秘剑】",
		"Ｗ使用柔云剑法威力倍增"
	}
	TFJS[96] = {
		"Ｌ【天赋：流水行云】",
		"Ｗ连击伤害不减",
		"Ｎ",
		"Ｌ【称号：水月剑】",
		"Ｗ使用剑法必冰封"
	}
	TFJS[97] = {
		"Ｌ【天赋：攻心之术】",
		"Ｗ集气速度增加十",
		"Ｗ使用血刀大法攻击时机率魅惑对方反叛",
		"Ｎ",
		"Ｌ【称号：茹毛饮血】",
		"Ｗ攻击时，吸取被攻击方百分之十的血量"
	}
	TFJS[98] = {
		"Ｌ【天赋：一阳魔手】",
		"Ｗ使用一阳指攻击必封穴",
		"Ｗ使用一阳指威力翻倍",
		"Ｎ",
		"Ｌ【称号：恶贯满盈】",
		"Ｗ道德越低伤害越高",
		"Ｗ暴击时伤害效果两倍"
	}
	TFJS[99] = {
		"Ｌ【天赋：哭儿魔音】",
		"Ｗ连击伤害不减",
		"Ｎ",
		"Ｌ【称号：无恶不做】",
		"Ｗ道德越低伤害越高",
		"Ｗ暴击时伤害效果两倍"
	}
	TFJS[100] = {
		"Ｌ【天赋：性别歧视】",
		"Ｗ对女性伤害增加百分之二十",
		"Ｗ对男性伤害减少百分之二十",
		"Ｎ",
		"Ｌ【称号：穷凶极恶】",
		"Ｗ道德越低伤害越高",
		"Ｗ暴击时伤害效果两倍"
	}
	TFNLJS[86] = "Ｇ【天赋：倾国倾城】ＨＷ敌全体防御效果降百分之二十"
	TFNLJS[87] = "Ｇ【天赋：媚眼如丝】ＨＷ敌全体攻击效果降百分之二十"
	TFNLJS[88] = "Ｇ【天赋：聚气归还】ＨＷ每回合恢复内力ＰＧ【称号：酒神】ＨＷ被攻击时机率发动酒神秘踪步，闪躲攻击;若人厨子在场，攻击必暴。"
	TFNLJS[89] = "Ｇ【天赋：身体强健】ＨＷ攻击连击必暴，每回合恢复一百生命,生命上限增加五百ＰＧ【称号：食神】ＨＷ攻击不减体力；若祖千秋在场，攻击必连。"
	TFNLJS[90] = "Ｇ【天赋：身轻如燕】ＨＷ修炼武功时轻功二倍成长ＰＧ【称号：毓秀灵姝】ＨＷ用闪电貂攻击时，一定机率可偷窃对方的物品"
	TFNLJS[91] = "Ｇ【天赋：妙手连环】ＨＷ连击伤害不减ＰＧ【称号：青青子衿】ＨＷ使用雷震剑法攻击随机一至三倍威力"
	TFNLJS[92] = "Ｇ【天赋：国色天香】ＨＷ我方攻击伤害提高百分之十ＰＧ【称号：我本佳人】ＨＷ和主角在战场时主角集气速度提升五点"
	TFNLJS[93] = "Ｇ【天赋：未完成】ＨＷＰＧ【称号：未完成】ＨＷ"
	TFNLJS[94] = "Ｇ【天赋：四奇魁首】ＨＷ使我方暴击率提升ＰＧ【称号：仁义陆大刀】Ｈ使用鬼头刀法攻击时必连击几率三连，道德值越高，受到伤害减轻越多Ｗ"
	TFNLJS[95] = "Ｇ【天赋：柔劲传人】ＨＷ被攻击时使用柔劲反击敌人造成固定50点伤害并降低伤害30ＰＧ【称号：柔云剑】Ｈ使用柔云剑法威力倍增Ｗ"
	TFNLJS[96] = "Ｇ【天赋：流水行云】ＨＷ连击伤害不减ＰＧ【称号：水月剑】Ｈ使用剑法必冰封Ｗ"
	TFNLJS[97] = "Ｇ【天赋：攻心之术】ＨＷ集气速度增加十。战斗时使用血刀大法攻击时机率魅惑对方反叛，加入己方阵营ＰＧ【称号：茹毛饮血】ＨＷ攻击时，吸取被攻击方百分之十的血量"
	TFNLJS[98] = "Ｇ【天赋：一阳魔手】ＨＷ使用一阳指攻击必封穴ＰＧ【称号：恶贯满盈】ＨＷ道德越低伤害越高，暴击时伤害效果两倍"
	TFNLJS[99] = "Ｇ【天赋：哭儿唤女】ＨＷ连击伤害不减ＰＧ【称号：无恶不做】ＨＷ道德越低伤害越高，暴击时伤害效果两倍"
	TFNLJS[100] = "Ｇ【天赋：辣手摧花】ＨＷ对女性伤害增加百分之三十ＰＧ【称号：穷凶极恶】ＨＷ道德越低伤害越高，暴击时伤害效果两倍"
	TFNLJS[101] = "Ｇ【天赋：未完成】ＨＷＰＧ【称号：大理家臣未完成】ＨＷ"
	TFNLJS[102] = "Ｇ【天赋：枯荣寂灭】ＨＷ无视内力属性需求修炼秘籍，被攻击时低几率将伤害转化为内力伤害ＰＧ【称号：天龙主持】ＨＷ无条件学习六脉神剑，额外几率触发招式"
	TFNLJS[103] = "Ｇ【天赋：无我无相】ＨＷ攻防时若没有触发内功加力、护体则必以小无相功加力、护体，同时发动无我无相降低敌人怒气ＰＧ【称号：大轮明王】ＨＷ使用火焰刀攻击时使全部敌人附加内伤三十点"
	TFNLJS[104] = "Ｇ【天赋：未完成】ＨＷＰＧ【称号：未完成】ＨＷ"
	TFNLJS[105] = "Ｇ【天赋：未完成】ＨＷＰＧ【称号：未完成】ＨＷ"
	TFJS[101] = {
		"Ｌ【天赋：铁笔丹心】",
		"Ｗ攻击时机率发动三杯草圣，攻击必封穴",
		"Ｎ",
		"Ｌ【称号：大理一脉】",
		"Ｗ攻击使用一阳指书必暴击"
	}
	TFJS[102] = {
		"Ｌ【天赋：枯荣寂灭】",
		"Ｗ无视内力属性需求修炼秘籍",
		"Ｗ被攻击时低几率将伤害转化为内力伤害",
		"Ｎ",
		"Ｌ【称号：天龙主持】",
		"Ｗ无条件学习六脉神剑，额外几率触发招式"
	}
	TFJS[103] = {
		"Ｌ【天赋：无我无相】",
		"Ｗ攻防时若无内功加力、护体则必小无相功加力、护体，",
		"Ｗ同时发动无我无相降低敌人怒气",
		"Ｎ",
		"Ｌ【称号：大轮明王】",
		"Ｗ使用火焰刀攻击时使全部敌人附加内伤三十点"
	}
	TFJS[104] = {
		"Ｌ【天赋：易容圣手】",
		"Ｗ几率完全闪避敌人攻击",
		"Ｎ",
		"Ｌ【称号：温柔贤妻】",
		"Ｗ和乔峰同在战场则乔峰战意高昂"
	}
	TFJS[105] = {
		"Ｌ【天赋：身轻如燕】",
		"Ｗ修炼武功时轻功双倍成长"
	}
	TFJS[106] = {
		"Ｌ【天赋：五虎断门】",
		"Ｗ使用五虎断门刀时伤害翻倍且发动极意全场内伤增加",
		"Ｎ",
		"Ｌ【称号：金刀无敌】",
		"Ｗ装备金刀后伤害增加五十"
	}
	TFJS[107] = {
		"Ｌ【天赋：两仪刀客】",
		"Ｗ攻击后集气增加一百",
		"Ｎ",
		"Ｌ【称号：华山矮叟】",
		"Ｗ使用反两仪刀法必暴击"
	}
	TFJS[108] = {
		"Ｌ【天赋：两仪刀客】",
		"Ｗ攻击后集气增加一百",
		"Ｎ",
		"Ｌ【称号：华山高叟】",
		"Ｗ使用反两仪刀法必连击"
	}
	TFJS[109] = {
		"Ｌ【天赋：卑鄙无耻】",
		"Ｗ额外增加流血几率",
		"Ｎ",
		"Ｌ【称号：华山掌门】",
		"Ｗ使用太岳三青峰必连击"
	}
	TFJS[110] = {
		"Ｌ【天赋：盾亡人亡】",
		"Ｗ敌人难以击中破绽"
	}
	TFJS[111] = {
		"Ｌ【天赋：盾在人在】",
		"Ｗ敌人难以击中破绽"
	}
	TFJS[112] = {
		"Ｌ【天赋：血海深仇】",
		"Ｗ初始战意120",
		"Ｗ被攻击后怒气上升增加",
		"Ｎ",
		"Ｌ【称号：大漠苍狼】",
		"Ｗ攻击必暴击，百分之二十五几率三连击"
	}
	TFJS[113] = {
		"Ｌ【天赋：参合密技】",
		"Ｗ攻击时必发动参合指增加集气伤害",
		"Ｗ高几率封穴",
		"Ｎ",
		"Ｌ【称号：慕容家主】",
		"Ｗ必发动斗转反击，斗转反击时无视兵器值限制",
		"Ｗ必出离合参商，同时必连击"
	}
	TFJS[114] = {
		"Ｌ【天赋：天地独尊】",
		"Ｗ大幅度增加攻防效果",
		"Ｗ攻击时对方怒气归零",
		"Ｗ攻击时几率度化敌人",
		"Ｎ",
		"Ｌ【称号：达摩再世】",
		"Ｗ受攻击几率降低伤害40",
		"Ｗ免疫杀气",
		"Ｗ免疫内伤"
	}
	TFJS[115] = {
		"Ｌ【天赋：六艺皆通】",
		"Ｗ单独使用琴棋书画可触发特效",
		"Ｎ",
		"Ｌ【称号：逍遥门人】",
		"Ｗ自带北冥神功"
	}
	TFJS[116] = {
		"Ｌ【天赋：逍遥御风】",
		"Ｗ集气速度+20",
		"Ｗ被攻击时高几率发动真·凌波微步",
		"Ｎ",
		"Ｌ【称号：逍遥老祖】",
		"Ｗ自带北冥神功，必发动效果",
		"Ｗ可触发真·天山六阳掌"
	}
	TFJS[117] = {
		"Ｌ【天赋：唯我独尊】",
		"Ｗ攻击时必发动生死符，增加集气伤害，",
		"Ｗ必冰封，冰封值增加",
		"Ｗ被攻击时几率发动真·凌波微步",
		"Ｎ",
		"Ｌ【称号：灵鹫宫主】",
		"Ｗ自带北冥神功",
		"Ｗ高封穴"
	}
	TFJS[118] = {
		"Ｌ【天赋：无相天成】",
		"Ｗ内功护体几率提升百分之十五",
		"Ｗ攻击必出招式，招式杀气值翻倍",
		"Ｗ被攻击时几率发动真·凌波微步",
		"Ｗ难以被击中破绽",
		"Ｎ",
		"Ｌ【称号：西夏之主】",
		"Ｗ自带北冥神功",
		"Ｗ攻防效果增加百分之十",
		"Ｗ被攻击几率发动见招拆招，减少伤害"
	}
	TFJS[119] = {
		"Ｌ【天赋：拦江起鳌】",
		"Ｗ攻击时杀气强化百分之五十"
	}
	TFJS[120] = {
		"Ｌ【天赋：开山劈林】",
		"Ｗ攻击时几率不增加敌人怒气"
	}
	TFJS[121] = {
		"Ｌ【天赋：爆火似癫】",
		"Ｗ怒气爆发时伤害增加百分之五十",
		"Ｗ怒气上涨速度双倍"
	}
	TFJS[122] = {
		"Ｌ【天赋：哀牢奇剑】",
		"Ｗ使用任意武功攻击时几率追加“哀牢卅六剑”追加三十六点伤害"
	}
	TFNLJS[106] = "Ｇ【天赋：五虎宗师】ＨＷ使用五虎断门刀时伤害翻倍且发动极意全场内伤增加ＰＧ【称号：金刀无敌】ＨＷ装备金刀后伤害增加五十"
	TFNLJS[107] = "Ｇ【天赋：两仪刀客】ＨＷ使用反两仪刀法必连击ＰＧ【称号：华山矮叟】ＨＷ攻击后集气增加一百"
	TFNLJS[108] = "Ｇ【天赋：两仪刀客】ＨＷ使用反两仪刀法必连击ＰＧ【称号：华山高叟】ＨＷ攻击后集气增加一百"
	TFNLJS[109] = "Ｇ【天赋：卑鄙无耻】ＨＷ额外增加流血几率ＰＧ【称号：华山掌门】ＨＷ使用太岳三青峰必连击"
	TFNLJS[110] = "Ｇ【天赋：盾亡人亡】ＨＷ难以被击中破绽ＰＧ【称号：游氏双雄】ＨＷ"
	TFNLJS[111] = "Ｇ【天赋：盾在人在】ＨＷ难以被击中破绽ＰＧ【称号：游氏双雄】ＨＷ"
	TFNLJS[112] = "Ｇ【天赋：血海深仇】ＨＷ初始战意120，被攻击后怒气上升增加ＰＧ【称号：大漠苍狼】ＨＷ攻击必暴击，百分之二十五几率三连击"
	TFNLJS[113] = "Ｇ【天赋：参合密技】ＨＷ攻击时必发动参合指增加集气伤害，高几率封穴ＰＧ【称号：慕容家主】ＨＷ必发动斗转反击，斗转反击时无视兵器值限制，必出离合参商，同时必连击"
	TFNLJS[114] = "Ｇ【天赋：天地独尊】ＨＷ大幅度增加攻防效果，攻击时对方怒气归零ＰＧ【称号：达摩再世】ＨＷ受攻击几率降低伤害40，免疫杀气，免疫内伤"
	TFNLJS[115] = "Ｇ【天赋：六艺皆通】ＨＷ单独使用琴棋书画可触发特效ＰＧ【称号：逍遥门人】ＨW自带北冥神功"
	TFNLJS[116] = "Ｇ【天赋：逍遥御风】ＨＷ被攻击时几率发动真·凌波微步ＰＧ【称号：逍遥老祖】ＨＷ自带北冥神功，必发动效果,可触发真·天山六阳掌"
	TFNLJS[117] = "Ｇ【天赋：唯我独尊】ＨＷ攻击时必发动生死符，增加集气伤害，必冰封，冰封值增加ＰＧ【称号：灵鹫宫主】ＨＷ自带北冥神功，高封穴"
	TFNLJS[118] = "Ｇ【天赋：无相天成】ＨＷ内功护体几率提升百分之十五，攻击必出招式，招式杀气值翻倍ＰＧ【称号：西夏之主】ＨＷ自带北冥神功，攻防效果增加百分之十，被攻击几率发动见招拆招，减少伤害"
	TFNLJS[119] = "Ｇ【天赋：拦江起鳌】ＨＷ攻击时杀气强化百分之五十ＰＧ【称号：未完成】ＨＷ"
	TFNLJS[120] = "Ｇ【天赋：开山劈林】ＨＷ攻击时几率不增加敌人怒气ＰＧ【称号：未完成】ＨＷ"
	TFNLJS[121] = "Ｇ【天赋：爆火似癫，】ＨＷ天赋：怒气爆发时伤害增加百分之五十，怒气上涨速度双倍ＰＧ【称号：未完成】ＨＷ"
	TFNLJS[122] = "Ｇ【天赋：哀牢奇剑】ＨＷ使用任意武功攻击时几率追加“哀牢卅六剑”追加三十六点伤害ＰＧ【称号：未完成】ＨＷ"
	TFJS[123] = {
		"Ｌ【天赋：金玉洞玄】",
		"Ｗ免疫兵器值压制，可使用所有武器和防具且装备属性加倍",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：丹阳子】",
		"Ｗ先天功效果翻倍",
		"Ｗ免疫灼烧，流血、封穴效果减半"
	}
	TFJS[124] = {
		"Ｌ【天赋：云水蕴真】",
		"Ｗ被攻击灼烧值减半转化为冰封值，冰封越高集气速度越快",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：长真子】",
		"Ｗ先天功效果翻倍",
		"Ｗ冰封时的降低内力变为恢复内力"
	}
	TFJS[125] = {
		"Ｌ【天赋：三花聚顶】",
		"Ｗ被攻击追加气防五百，免疫暴击伤害",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：长生子】",
		"Ｗ先天功效果翻倍",
		"Ｗ时序恢复内伤"
	}
	TFJS[126] = {
		"Ｌ【天赋：五气归元】",
		"Ｗ任何攻击追加气攻五百",
		"Ｗ暴击伤害两倍",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：玉阳子】",
		"Ｗ先天功效果翻倍",
		"Ｗ免疫冰封，免疫头昏眼花",
		"Ｗ攻击时高几率灼烧；自身灼烧值越高伤害越高"
	}
	TFJS[127] = {
		"Ｌ【天赋：太古真如】",
		"Ｗ内伤越高攻防效果越高",
		"Ｗ受伤害低几率转化为加生命",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：广宁子】",
		"Ｗ先天功效果翻倍",
		"Ｗ免疫封穴，冰封",
		"Ｗ灼烧效果减半"
	}
	TFJS[128] = {
		"Ｌ【天赋：清净无为】",
		"Ｗ计算兵器值时额外增加100",
		"Ｗ不会被命中破绽",
		"Ｗ攻击几率发动“七星汇聚”大量增加气攻，必连击",
		"Ｗ七星剑法伤害增加30%",
		"Ｎ",
		"Ｌ【称号：清净散人】",
		"Ｗ封穴、流血效果减半",
		"Ｗ忽视暴怒时被攻击造成的额外伤害"
	}
	TFJS[129] = {
		"Ｌ【天赋：气返先天】",
		"Ｗ被攻击时恢复生命八十点",
		"Ｗ免疫中毒",
		"Ｎ",
		"Ｌ【称号：中神通】",
		"Ｗ使用七星剑法伤害翻倍",
		"Ｗ战败后可满血复活一次，复活后立即行动"
	}
	TFJS[130] = {
		"Ｌ【天赋：听风辩形】",
		"Ｗ攻击必命中，免疫一切攻击丢失",
		"Ｗ攻击高几率附加“至毒蒺藜”增加固定伤害七十点，强制上毒三十点",
		"Ｎ",
		"Ｌ【称号：飞天蝙蝠】",
		"Ｗ学习武功轻功两倍成长",
		"Ｗ集气速度加五",
		"Ｗ轻功高于敌人一百五时几率闪躲攻击"
	}
	TFJS[131] = {
		"Ｌ【天赋：错骨分筋】",
		"Ｗ攻击几率发动分筋错骨手敌人必定身",
		"Ｗ攻击定身状态敌人，伤害增加百分之三十",
		"Ｎ",
		"Ｌ【称号：妙手书生】",
		"Ｗ攻击几率发动妙手空空盗取敌人物品",
		"Ｗ增加连击率百分之三十"
	}
	TFJS[132] = {
		"Ｌ【天赋：性如烈火】",
		"Ｗ怒气增长加倍",
		"Ｗ暴击时必灼烧且附加5点灼烧值",
		"Ｎ",
		"Ｌ【称号：马王神】",
		"Ｗ被攻击高几率发动“三眼马王神”蓄力化劲，",
		"Ｗ减伤20%，且进入蓄力状态",
		"Ｗ装备白马增加集气速度，初始集气，行动后集气"
	}
	TFJS[133] = {
		"Ｌ【天赋：南山孤胆】",
		"Ｗ自身怒气增长速度减慢，暴怒时必三连",
		"Ｗ初始战意一百一十，每攻击一次增加战意两点",
		"Ｎ",
		"Ｌ【称号：南山樵子】",
		"Ｗ南山刀法威力二到三倍",
		"Ｗ南山刀法攻击必触发“单刀破枪”"
	}
	TFJS[134] = {
		"Ｌ【天赋：浑元铁布衫】",
		"Ｗ被攻击几率发动铁布衫免流血且流血值清空，",
		"Ｗ减少百分之四十的伤害，额外增加气防八百",
		"Ｎ",
		"Ｌ【称号：笑弥勒】",
		"Ｗ暴击率额外增加20%",
		"Ｗ敌人怒气增长速度下降"
	}
	TFJS[135] = {
		"Ｌ【天赋：成算在心】",
		"Ｗ攻击无误伤",
		"Ｗ攻击时敌人无法触发八荒六合、乾坤、葵花移行特效防护",
		"Ｎ",
		"Ｌ【称号：闹市侠隐】",
		"Ｗ特效发动机率提高",
		"Ｗ内功加力几率提高",
		"Ｗ加力时伤害额外增加百分之二十"
	}
	TFJS[136] = {
		"Ｌ【天赋：越女慈心】",
		"Ｗ每修炼一项剑法到极，被攻击时伤害降低五，攻击时增加固定杀气一百五十",
		"Ｗ和郭靖同时在场，郭靖攻击消耗内力减半、韩小莹攻击伤害提升百分之五十",
		"Ｎ",
		"Ｌ【称号：越女剑】",
		"Ｗ连击率额外增加二十，连击伤害不减",
		"Ｗ剑法伤害增加百分之十",
		"Ｗ剑法攻击时根据武功威力额外增加杀气"
	}
	TFJS[137] = {
		"Ｌ【天赋：剑法小成】",
		"Ｗ剑法攻击增加固定伤害一百点",
		"Ｗ三才剑法威力二倍",
		"Ｗ剑法杀气增加百分之二十",
		"Ｎ",
		"Ｌ【称号：身若清风】",
		"Ｗ集气速度加五",
		"Ｗ行动后集气增加两百点"
	}
	TFJS[138] = {
		"Ｌ【天赋：截血断脉】",
		"Ｗ攻击几率使人定身",
		"Ｗ攻击强制上毒三十点",
		"Ｗ增加固定伤害五十点",
		"Ｎ",
		"Ｌ【称号：一指震江南】",
		"Ｗ攻击时高几率封穴，封穴额外增加五点",
		"Ｗ额外增加气攻八百点"
	}
	TFJS[139] = {
		"Ｌ【天赋：白面小生】",
		"Ｗ被男性敌人攻击伤害增加20%",
		"Ｗ被其他敌人攻击伤害减少20%",
		"Ｎ",
		"Ｌ【称号：郑府少主】",
		"Ｗ战斗胜利获得1000两银子"
	}
	TFJS[140] = {
		"Ｌ【天赋：剑术通神】",
		"Ｗ集气速度增加十",
		"Ｗ被攻击时机率打断对方连击",
		"Ｎ",
		"Ｌ【称号：独孤传人】",
		"Ｗ使用独孤九剑必连击，机率三连击",
		"Ｗ被攻击必发动九剑奥义降低伤害"
	}
	TFNLJS[123] = "Ｇ【天赋：金玉洞玄】ＨＷ免疫兵器值压制，可使用所有武器和防具且装备属性加倍；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：丹阳子】ＨＷ先天功效果翻倍；免疫灼烧，流血、封穴效果减半"
	TFNLJS[124] = "Ｇ【天赋：云水蕴真】ＨＷ被攻击灼烧值减半转化为冰封值，冰封越高集气速度越快；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：长真子】ＨＷ先天功效果翻倍；冰封时的降低内力变为恢复内力，华山觉醒后初始冰封值一百"
	TFNLJS[125] = "Ｇ【天赋：三花聚顶】ＨＷ被攻击追加气防五百，免疫暴击伤害；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：长生子】ＨＷ先天功效果翻倍；时序恢复内伤；华山觉醒后生命上限为四千"
	TFNLJS[126] = "Ｇ【天赋：五气归元】ＨＷ任何攻击追加气攻五百；暴击伤害两倍；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：玉阳子】ＨＷ先天功效果翻倍；免疫冰封；攻击时无视内力性质高几率灼烧；攻击不会出现头昏眼花；自身灼烧值越高伤害越高(满灼烧值伤害增加百分之五十)"
	TFNLJS[127] = "Ｇ【天赋：太古真如】ＨＷ内伤越高攻防效果越高；低几率伤害转化为加生命；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：广宁子】ＨＷ先天功效果翻倍；免疫封穴，冰封、灼烧效果减半"
	TFNLJS[128] = "Ｇ【天赋：清净无为】ＨＷ计算兵器值时额外增加100；不会被命中破绽；攻击几率发动“七星汇聚”大量增加气攻，必连击；七星剑法伤害增加30%ＰＧ【称号：清净散人】ＨＷ封穴、流血效果减半;忽视暴怒时被攻击造成的额外伤害"
	TFNLJS[129] = "Ｇ【天赋：气返先天】ＨＷ被攻击时恢复生命八十点，免疫中毒ＰＧ【称号：中神通】ＨＷ使用七星剑法伤害翻倍，战败后可满血复活一次，复活后立即行动"
	TFNLJS[130] = "Ｇ【天赋：听风辩形】ＨＷ攻击必命中，免疫一切攻击丢失；攻击高几率附加“至毒蒺藜”增加固定伤害七十点，强制上毒三十点ＰＧ【称号：飞天蝙蝠】ＨＷ学习武功轻功两倍成长；集气速度加五；轻功高于敌人一百五时几率闪躲攻击"
	TFNLJS[131] = "Ｇ【天赋：错骨分筋】ＨＷ攻击几率发动分筋错骨手敌人必定身；攻击定身状态敌人，伤害增加百分之三十ＰＧ【称号：妙手书生】ＨＷ攻击几率发动妙手空空盗取敌人物品；增加连击率百分之三十"
	TFNLJS[132] = "Ｇ【天赋：性如烈火】ＨＷ怒气增长加倍；暴击时必灼烧且附加十五点灼烧值ＰＧ【称号：马王神】ＨＷ被攻击高几率发动“三眼马王神”蓄力化劲，减伤20%，且进入蓄力状态；装备白马增加集气速度，初始集气，行动后集气"
	TFNLJS[133] = "Ｇ【天赋：南山孤胆】ＨＷ自身怒气增长速度减慢，暴怒时必三连；初始战意一百一十，每攻击一次增加战意两点ＰＧ【称号：南山樵子】ＨＷ南山刀法威力二到三倍；南山刀法攻击必触发“单刀破枪”"
	TFNLJS[134] = "Ｇ【天赋：浑元铁布衫】ＨＷ被攻击几率发动铁布衫免流血且流血值清空，减少百分之四十的伤害，额外增加气防八百ＰＧ【称号：笑弥勒】ＨＷ暴击率额外增加20%;敌人怒气增长速度下降"
	TFNLJS[135] = "Ｇ【天赋：成算在心】ＨＷ攻击无误伤，攻击时敌人无法触发八荒六合、乾坤、葵花移行特效防护ＰＧ【称号：闹市侠隐】ＨＷ特效发动机率提高；内功加力几率提高；加力时伤害额外增加百分之二十"
	TFNLJS[136] = "Ｇ【天赋：越女慈心】ＨＷ每修炼一项剑法到极，被攻击时伤害降低二十，攻击时增加固定杀气一百五十；行动结束回血五十点；和郭靖同时在场，郭靖攻击消耗内力减半、韩小莹攻击伤害提升百分之五十ＰＧ【称号：越女剑】ＨＷ连击率额外增加二十，连击伤害不减；剑法伤害增加百分之三十；剑法攻击时根据武功威力额外增加杀气"
	TFNLJS[137] = "Ｇ【天赋：剑法小成】ＨＷ剑法攻击增加固定伤害一百点；松风剑法威力二倍；剑法杀气增加百分之二十ＰＧ【称号：身若清风】ＨＷ集气速度加五；行动后集气增加两百点"
	TFNLJS[138] = "Ｇ【天赋：截血断脉】ＨＷ攻击几率使人定身；攻击强制上毒三十点；增加固定伤害八十点ＰＧ【称号：一指震江南】ＨＷ攻击时高几率封穴，封穴额外增加五点；额外增加气攻八百点"
	TFNLJS[139] = "Ｇ【天赋：白面小生】ＨＷ被男性敌人攻击伤害增加20%被其他敌人攻击伤害减少20%ＰＧ【称号：郑府少主】ＨＷ无视悟性可学12格武功；战斗胜利获得1000两银子"
	TFNLJS[140] = "Ｇ【天赋：剑术通神】ＨＷ集气速度增加十，被攻击时机率可打断对方连击ＰＧ【称号：独孤传人】ＨＷ使用独孤九剑必连击，机率三连击，被攻击必发动九剑奥义降低伤害"
	TFJS[141] = {
		"Ｌ【天赋：夺命三仙】",
		"Ｗ太岳三青峰攻击时变为夺命三仙剑必三连，剑法伤害增加100",
		"Ｗ被敌人攻击时怒气上涨翻倍",
		"Ｎ",
		"Ｌ【称号：剑宗弟子】",
		"Ｗ连击率增加20%",
		"Ｗ剑法伤害额外增加20%"
	}
	TFJS[142] = {
		"Ｌ【天赋：狂风快剑】",
		"Ｗ集气速度加5",
		"Ｗ剑法兵器值大于100点时，兵器值每增加十五点，集气速度加一",
		"Ｗ攻击后集气增加两百点",
		"Ｗ觉醒后暴怒时发动狂风快剑必四连",
		"Ｎ",
		"Ｌ【称号：剑宗弟子】",
		"Ｗ连击率增加20%",
		"Ｗ剑法伤害额外增加20%"
	}
	TFJS[143] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[144] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[145] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[146] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[147] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[148] = {
		"Ｌ【天赋：精神错乱】",
		"Ｗ解穴速度加快",
		"Ｎ",
		"Ｌ【称号：家氏六老】",
		"Ｗ暴击率增加"
	}
	TFJS[149] = {
		"Ｌ【天赋：佛法精深】",
		"Ｗ易筋神功必加力、护体",
		"Ｗ内力加力时伤害增加，护体时所受内伤减半",
		"Ｗ免疫北冥神功,吸星大法",
		"Ｗ学会狮子吼后，几率发动“ 金刚禅·狮子吼”，",
		"Ｗ全体额外强制杀气一百加自身道德数值，生命降低一百",
		"Ｎ",
		"Ｌ【称号：千手如来】",
		"Ｗ华山觉醒后使用掌法必连击，",
		"Ｗ小几率发动千手如来掌攻击三连"
	}
	TFJS[150] = {
		"Ｌ【天赋：专打死穴】",
		"Ｗ攻击时30%几率直接命中破绽",
		"Ｗ攻击时额外增加伤害，伤害由内力决定",
		"Ｎ",
		"Ｌ【称号：一剑无血】",
		"Ｗ攻击时额外增加连击几率和集气伤害",
		"Ｗ使用剑法几率使敌人封穴"
	}
	TFNLJS[141] = "Ｇ【天赋：夺命三仙】ＨＷ太岳三青峰攻击时变为夺命三仙剑必三连，伤害增加100ＰＧ【称号：剑宗弟子】ＨＷ连击率增加20%；剑法伤害额外增加20%；被敌人时怒气上涨翻倍"
	TFNLJS[142] = "Ｇ【天赋：狂风快剑】ＨＷ集气速度加5，剑法兵器值大于100点时，兵器值每增加十五点，集气速度加一；华山觉醒后暴怒时发动狂风快剑必四连ＰＧ【称号：剑宗弟子】ＨＷ连击率增加百分之二十；剑法伤害额外增加百分之二十；攻击后集气增加两百点"
	TFNLJS[143] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：温氏六老】ＨＷ暴击率增加"
	TFNLJS[144] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：温氏六老】ＨＷ暴击率增加"
	TFNLJS[145] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：温氏六老】ＨＷ暴击率增加"
	TFNLJS[146] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：温氏六老】ＨＷ暴击率增加"
	TFNLJS[147] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：温氏六老】ＨＷ暴击率增加"
	TFNLJS[148] = "Ｇ【天赋：精神错乱】ＨＷ解穴速度加快ＰＧ【称号：桃谷六仙】ＨＷ暴击率增加"
	TFNLJS[149] = "Ｇ【天赋：佛法精深】ＨＷ易筋神功必加力、护体；内力加力时伤害增加，护体时所受内伤减半；免疫北冥神功,吸星大法；学会狮子吼后，改狮子吼特效为几率发动“ 金刚禅·狮子吼”全体额外强制杀气一百加自身道德数值，生命降低一百ＰＧ【称号：千手如来】ＨＷ华山觉醒后使用掌法必连击，小几率发动千手如来掌攻击三连"
	TFNLJS[150] = "Ｇ【天赋：专打死穴】ＨＷ攻击时30%几率直接命中破绽；攻击时额外增加伤害，伤害由内力决定ＰＧ【称号：一剑无血】ＨＷ攻击时额外增加连击几率和集气伤害；使用剑法几率使敌人封穴"
	TFJS[151] = {
		"Ｌ【天赋：否极泰来】",
		"Ｗ生命低于一半时，攻击伤害额外增加百分之五十",
		"Ｗ生命低于四分之一，免杀气",
		"Ｎ",
		"Ｌ【称号：奔雷手】",
		"Ｗ若轻功高于敌人一百则发动霹雳奔雷攻击必破招"
	}
	TFJS[152] = {
		"Ｌ【天赋：迷踪连环】",
		"Ｗ连击有第二次判定几率，连击伤害不减",
		"Ｗ苗家剑法攻击额外增加内伤二十，流血二十",
		"Ｎ",
		"Ｌ【称号：追魂夺命】",
		"Ｗ攻击后集气增加一百五十",
		"Ｗ集气速度增加五"
	}
	TFJS[153] = {
		"Ｌ【天赋：春风拂太极】",
		"Ｗ被攻击敌人怒气归零",
		"Ｗ冰封，灼烧，恢复速度加倍",
		"Ｗ太极拳必连击",
		"Ｎ",
		"Ｌ【称号：千臂如来】",
		"Ｗ使用暗器威力增加，可使对象周围成方阵造成伤害暗器",
		"Ｗ战斗胜利后获得10个暗器"
	}
	TFJS[154] = {
		"Ｌ【天赋：韩王青刀】",
		"Ｗ在战场时我方造成的怒气减少百分之五十",
		"Ｗ每修炼一项刀法到极，攻防各增加二十点",
		"Ｗ攻击几率发动“刀影重重”低几率三连",
		"Ｎ",
		"Ｌ【称号：鸳鸯刀客】",
		"Ｗ使用鸳鸯刀法攻击必连击且暴怒时有极意"
	}
	TFJS[155] = {
		"Ｌ【天赋：销魂噬魄】",
		"Ｗ攻击几率发动“黑沙掌”内伤加二十，伤害增加百分之三十",
		"Ｗ攻击高几率冰封，冰封值额外增加十点",
		"Ｎ",
		"Ｌ【称号：黑无常】",
		"Ｗ集气速度加十",
		"Ｗ免疫暴击伤害"
	}
	TFJS[156] = {
		"Ｌ【天赋：勾魂夺魄】",
		"Ｗ攻击几率发动“飞爪勾魂”流血加二十，伤害增加百分之三十",
		"Ｗ攻击高几率冰封，冰封值额外增加十点",
		"Ｎ",
		"Ｌ【称号：白无常】",
		"Ｗ集气速度加十",
		"Ｗ免疫暴击伤害"
	}
	TFJS[157] = {
		"Ｌ【天赋：湘西尸王】",
		"Ｗ封穴大于十点立刻解穴",
		"Ｗ攻击强制上毒20点且增加对方中毒程度两倍的伤害值",
		"Ｎ",
		"Ｌ【称号：蒙古三杰】",
		"Ｗ被攻击时内伤增加不超过五"
	}
	TFJS[158] = {
		"Ｌ【天赋：金龙鞭王】",
		"Ｗ装备金龙鞭后降低30%的伤害",
		"Ｗ黄沙万里鞭武功威力增加百分之五十，且变为无误伤大范围攻击",
		"Ｎ",
		"Ｌ【称号：蒙古三杰】",
		"Ｗ集气速度加五",
		"Ｗ被攻击时内伤增加不超过五"
	}
	TFJS[159] = {
		"Ｌ【天赋：瑜伽鬼王】",
		"Ｗ被攻击大幅度降低伤害，几率增加集气速度两点",
		"Ｗ免疫流血",
		"Ｎ",
		"Ｌ【称号：蒙古三杰】",
		"Ｗ集气速度加五",
		"Ｗ被攻击时内伤增加不超过五"
	}
	TFJS[160] = {
		"Ｌ【天赋：巨象之力】",
		"Ｗ攻击增加固定伤害五十点，装备伏魔杵额外增加五十点",
		"Ｗ受到致命攻击时四分之一几率复活恢复100血",
		"Ｎ",
		"Ｌ【称号：金轮首徒】",
		"Ｗ没有触发内功时必以龙象般若功加力护体",
		"Ｗ攻击暴击几率增加30%"
	}
	TFNLJS[151] = "Ｇ【天赋：否极泰来】ＨＷ生命低于一半时，攻击伤害额外增加百分之五十；生命低于四分之一，免杀气ＰＧ【称号：奔雷手】ＨＷ若轻功高于敌人一百则发动霹雳奔雷攻击必破招"
	TFNLJS[152] = "Ｇ【天赋：迷踪连环】ＨＷ连击有第二次判定几率，连击伤害不减；苗家剑法攻击额外增加内伤二十，流血二十ＰＧ【称号：追魂夺命】ＨＷ攻击后集气增加一百五十；集气速度增加五"
	TFNLJS[153] = "Ｇ【天赋：春风拂太极】ＨＷ被攻击敌人怒气归零；冰封，灼烧，恢复速度加倍；太极拳必连击ＰＧ【称号：千臂如来】ＨＷ使用暗器威力增加，可使对象周围成方阵造成伤害暗器；战斗胜利后获得10个暗器"
	TFNLJS[154] = "Ｇ【天赋：韩王青刀】ＨＷ在战场时我方造成的怒气减少百分之五十；每修炼一项刀法到极，攻防各增加二十点；攻击几率发动“刀影重重”低几率三连ＰＧ【称号：鸳鸯刀客】ＨＷ使用鸳鸯刀法攻击必连击且暴怒时有极意"
	TFNLJS[155] = "Ｇ【天赋：销魂噬魄】ＨＷ攻击几率发动“黑沙掌”内伤加二十，伤害增加百分之三十；攻击高几率冰封，冰封值额外增加十点ＰＧ【称号：黑无常】ＨＷ集气速度加十，免疫暴击伤害"
	TFNLJS[156] = "Ｇ【天赋：勾魂夺魄】ＨＷ攻击几率发动“飞爪勾魂”流血加二十，伤害增加百分之三十；攻击高几率冰封，冰封值额外增加十点ＰＧ【称号：白无常】ＨＷ集气速度加十，免疫暴击伤害"
	TFNLJS[157] = "Ｇ【天赋：湘西尸王】ＨＷ封穴大于十点立刻解穴；攻击强制上毒20点且增加对方中毒程度两倍的伤害值ＰＧ【称号：蒙古三杰】ＨＷ被攻击时内伤增加不超过五"
	TFNLJS[158] = "Ｇ【天赋：金龙鞭王】ＨＷ装备金龙鞭后降低30%的伤害黄沙万里鞭武功威力增加百分之五十，且变为无误伤大范围攻击ＰＧ【称号：蒙古三杰】ＨＷ集气速度加五；被攻击时内伤增加不超过五"
	TFNLJS[159] = "Ｇ【天赋：瑜伽鬼王】ＨＷ被攻击大幅度降低伤害，几率增加集气速度两点；免疫流血ＰＧ【称号：蒙古三杰】ＨＷ集气速度加五；被攻击时内伤增加不超过五"
	TFNLJS[160] = "Ｇ【天赋：巨象之力】ＨＷ攻击增加固定伤害五十点，装备伏魔杵额外增加五十点；受到致命攻击时四分之一几率复活恢复100血ＰＧ【称号：金轮首徒】ＨＷ没有触发内功时必以龙象般若功加力护体；攻击暴击几率增加30%"
	TFJS[161] = {
		"Ｌ【天赋：黯然情伤】",
		"Ｗ对男性伤害增加百分之三十，额外增加连击率三十",
		"Ｎ",
		"Ｌ【称号：赤练仙子】",
		"Ｗ攻击时机率带出冰魄银针，无视毒抗上毒"
	}
	TFJS[162] = {
		"Ｌ【天赋：玄冰碧火善恶心】",
		"Ｗ攻击时几率附带冰封，灼烧",
		"Ｗ道德越高灼烧值越高，当道德大于七十时灼烧值最大",
		"Ｗ道德越低冰封值越高，当道德小于三十时冰封值最大",
		"Ｎ",
		"Ｌ【称号：一日不过三】",
		"Ｗ攻击时伤害随机强化为一到三倍"
	}
	TFJS[163] = {
		"Ｌ【天赋：黄金龙头九节鞭】",
		"Ｗ攻击时大几率发动金龙九节鞭，附带封穴，流血，内伤，定身效果",
		"Ｎ",
		"Ｌ【称号：一日不过四】",
		"Ｗ被攻击时随机减少伤害百分之二十五到百分之七十五"
	}
	TFJS[164] = {
		"Ｌ【天赋：一言九鼎】",
		"Ｗ集气速度增加五",
		"Ｗ当无内功加力、护体时，额外增加杀气、气防",
		"Ｎ",
		"Ｌ【称号：摩天居士】",
		"Ｗ攻击几率发出碧针青掌追加中毒十五点，内伤十点",
		"Ｗ封穴几率增加30%"
	}
	TFJS[165] = {
		"Ｌ【天赋：惊天一笔】",
		"Ｗ攻击低几率发动“惊天一笔”必命中破绽",
		"Ｗ攻击时附加自己等同自身特殊兵器值的伤害(最大两百)",
		"Ｎ",
		"Ｌ【称号：朱武庄主】",
		"Ｗ一阳指书攻击必暴击",
		"Ｗ不受内力属性影响，高几率灼烧"
	}
	TFJS[166] = {
		"Ｌ【天赋：辣手毒颜】",
		"Ｗ剑法攻击必流血，",
		"Ｗ且增加两百五十减去自身道德值的固定伤害",
		"Ｎ",
		"Ｌ【称号：昆仑太上】",
		"Ｗ两仪剑法伤害增加百分之五十且必连击"
	}
	TFJS[167] = {
		"Ｌ【天赋：五痨七伤】",
		"Ｗ攻击时附带自身战意值的伤害值",
		"Ｗ七伤拳伤害增加30%且特效增强",
		"Ｎ",
		"Ｌ【称号：崆峒五老·夺命】",
		"Ｗ七伤拳必暴击"
	}
	TFJS[168] = {
		"Ｌ【天赋：七伤八痨】",
		"Ｗ若被攻击时伤害大于一百五十点则降低相当于自身战意值的伤害",
		"Ｗ七伤拳伤害增加30%且特效增强",
		"Ｎ",
		"Ｌ【称号：崆峒五老·追魂】",
		"Ｗ七伤拳必连击"
	}
	TFJS[169] = {
		"Ｌ【天赋：慈悲为怀】",
		"Ｗ在战场时敌我双方都不增加怒气",
		"Ｗ攻击时敌人战意减五",
		"Ｗ几率发动“金刚一指禅”必封穴且必破招",
		"Ｎ",
		"Ｌ【称号：四大神僧】",
		"Ｗ内力加力时伤害增加",
		"Ｗ被攻击低几率发动“金刚不坏”极大降低伤害",
		"Ｗ时序回内力五点"
	}
	TFJS[170] = {
		"Ｌ【天赋：少林龙爪】",
		"Ｗ龙爪手变为范围攻击且攻击必暴击",
		"Ｗ当爆气时龙爪手必连击",
		"Ｎ",
		"Ｌ【称号：四大神僧】",
		"Ｗ内力加力时伤害增加",
		"Ｗ被攻击低几率发动“金刚不坏”极大降低伤害",
		"Ｗ攻击几率发动“少林九阳功”伤害增加20%，必灼烧，内伤加10"
	}
	TFNLJS[161] = "Ｇ【天赋：黯然情伤】ＨＷ对男性伤害增加百分之三十，额外增加连击率三十，ＰＧ【称号：赤练仙子】ＨＷ攻击时机率带出冰魄银针，无视毒抗上毒"
	TFNLJS[162] = "Ｇ【天赋：玄冰碧火善恶心】ＨＷ攻击时几率附带冰封，灼烧。道德越高灼烧值越高当道德大于七十时灼烧值最大，道德越低冰封值越高当道德小于三十时冰封值最大（最多增加二十，五十道德为中线，附带冰封十灼烧十）ＰＧ【称号：一日不过三】ＨＷ攻击时伤害随机强化为一到三倍"
	TFNLJS[163] = "Ｇ【天赋：黄金龙头九节鞭】ＨＷ攻击时大几率发动金龙九节鞭，附带封穴，流血，内伤，定身效果ＰＧ【称号：一日不过四】ＨＷ被攻击时随机减少伤害百分之二十五到百分之七十五"
	TFNLJS[164] = "Ｇ【天赋：一言九鼎】ＨＷ集气速度增加五，当未触发内功加力、护体时，额外发挥特效增加杀气、气防ＰＧ【称号：摩天居士】ＨＷ攻击几率发出碧针青掌追加中毒十五点内伤十点，封穴几率增加30%"
	TFNLJS[165] = "Ｇ【天赋：惊天一笔】ＨＷ攻击低几率发动“惊天一笔”必命中破绽；攻击时附加自己等同自身特殊兵器值的伤害(最大两百)ＰＧ【称号：朱武庄主】ＨＷ一阳指书攻击必暴击；不受内力属性影响，高几率灼烧"
	TFNLJS[166] = "Ｇ【天赋：辣手毒颜】ＨＷ剑法攻击必流血且增加一百五十减去自身道德值的固定伤害ＰＧ【称号：昆仑太上】ＨＷ两仪剑法伤害增加百分之五十且必连击"
	TFNLJS[167] = "Ｇ【天赋：五痨七伤】ＨＷ攻击时附带自身战意值的伤害值；七伤拳伤害增加30%且特效增强ＰＧ【称号：崆峒五老·夺命】ＨＷ七伤拳必暴击"
	TFNLJS[168] = "Ｇ【天赋：七伤八痨】ＨＷ若被攻击时伤害大于一百五十点则降低相当于自身战意值的伤害；七伤拳伤害增加30%且特效增强ＰＧ【称号：崆峒五老·追魂】ＨＷ七伤拳必连击"
	TFNLJS[169] = "Ｇ【天赋：慈悲为怀】ＨＷ在战场时敌我双方都不增加怒气；攻击时敌人战意减五；几率发动“金刚一指禅”必封穴且必破招ＰＧ【称号：四大神僧】ＨＷ内力加力时伤害增加；被攻击低几率发动“金刚不坏”极大降低伤害；时序回内力五点"
	TFNLJS[170] = "Ｇ【天赋：少林龙爪】ＨＷ龙爪手变为范围攻击且攻击必暴击，当爆气时龙爪手必连击ＰＧ【称号：四大神僧】ＨＷ内力加力时伤害增加；被攻击低几率发动“金刚不坏”极大降低伤害；攻击几率发动“少林九阳功”伤害增加20%，必灼烧，内伤加10"
	TFJS[171] = {
		"Ｌ【天赋：太极真传】",
		"Ｗ使用太极剑法必暴击、使用太极拳法必连击",
		"Ｗ无条件学习太极套装",
		"Ｎ",
		"Ｌ【称号：武当首座】",
		"Ｗ太奥发动几率不受悟性限制，固定为80%",
		"Ｗ太奥效果增强，发动免杀气"
	}
	TFJS[172] = {
		"Ｌ【天赋：绕指柔剑】",
		"Ｗ使用柔云剑法必连击",
		"Ｗ几率发动“百鸟朝凤”柔云剑法三连",
		"Ｎ",
		"Ｌ【称号：武当六侠】",
		"Ｗ降低学习武功所需系数二十",
		"Ｗ太奥发动几率不受悟性限制，固定为80%"
	}
	TFJS[173] = {
		"Ｌ【天赋：乾坤精要·秒风】",
		"Ｗ乾坤大挪移增加发动几率且反伤效果增强",
		"Ｗ攻击无误伤",
		"Ｎ",
		"Ｌ【称号：波斯三使】",
		"Ｗ同时学会圣火神功和乾坤大挪移，额外增加集气速度十",
		"Ｗ被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	}
	TFJS[174] = {
		"Ｌ【天赋：乾坤精要·流云】",
		"Ｗ乾坤大挪移增加发动几率且反伤效果增强",
		"Ｗ攻击连击率额外增加三十",
		"Ｎ",
		"Ｌ【称号：波斯三使】",
		"Ｗ同时学会圣火神功和乾坤大挪移，额外增加集气速度十",
		"Ｗ被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	}
	TFJS[175] = {
		"Ｌ【天赋：乾坤精要·辉月】",
		"Ｗ乾坤大挪移增加发动几率且反伤效果增强",
		"Ｗ攻击暴击率额外增加三十",
		"Ｎ",
		"Ｌ【称号：波斯三使】",
		"Ｗ同时学会圣火神功和乾坤大挪移，额外增加集气速度十",
		"Ｗ被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	}
	TFJS[176] = {
		"Ｌ【天赋：红颜毒面】",
		"Ｗ怒气积攒加倍",
		"Ｗ被攻击时几率发动“红颜已改爱难消”免伤40%，降低一半杀气",
		"Ｎ",
		"Ｌ【称号：五仙长老】",
		"Ｗ用毒上限四百",
		"Ｗ攻击时无视毒抗上毒二十五点",
		"Ｗ攻击几率发动“鸟啼花怨恨难平”杀气1.5倍，伤害增加40%"
	}
	TFJS[177] = {
		"Ｌ【天赋：见利忘义】",
		"Ｗ自身内伤越高，暴击率越大",
		"Ｗ暴击伤害为200%",
		"Ｎ",
		"Ｌ【称号：太白三英】",
		"Ｗ格挡效果增强20%",
		"Ｗ被攻击时若被击中破绽，无视条件必触发格挡"
	}
	TFJS[178] = {
		"Ｌ【天赋：唯利是图】",
		"Ｗ自身内伤越高，连击率越大",
		"Ｗ暴击伤害为200%",
		"Ｎ",
		"Ｌ【称号：太白三英】",
		"Ｗ破招效果增强20%",
		"Ｗ攻击时若击中破绽，无视条件必触发破招"
	}
	TFJS[179] = {
		"Ｌ【天赋：利欲熏心】",
		"Ｗ随自身内伤增加连击率,暴击率，",
		"Ｗ自身攻击伤害上升百分之三十，自身防御力下降百分之二十(华山觉醒后去除防御力下降)",
		"Ｎ",
		"Ｌ【称号：太白三英】",
		"Ｗ攻击格挡和攻击破招可无视条件触发"
	}
	TFJS[180] = {
		"Ｌ【天赋：冷暖自知】",
		"Ｗ若触发冰封，攻击敌人时附带等同自身两倍冰封值的数值",
		"Ｗ若触发灼烧，攻击敌人时附带等同自身两倍灼烧值的数值",
		"Ｗ不被冰封减速，灼烧增加伤害效果影响",
		"Ｎ",
		"Ｌ【称号：仙都传人】",
		"Ｗ两仪剑法威力二倍且必暴"
	}
	TFNLJS[171] = "Ｇ【天赋：太极真传】ＨＷ使用太极剑法必暴击、使用太极拳法必连击；无条件学习太极套装ＰＧ【称号：武当首座】ＨＷ太奥发动几率不受悟性限制，固定为80%;太奥效果增强，发动免杀气"
	TFNLJS[172] = "Ｇ【天赋：绕指柔剑】ＨＷ使用柔云剑法必连击；几率发动“百鸟朝凤”柔云剑法三连ＰＧ【称号：武当六侠】ＨＷ降低学习武功所需系数二十；太奥发动几率不受悟性限制，固定为80%"
	TFNLJS[173] = "Ｇ【天赋：乾坤精要·秒风】ＨＷ乾坤大挪移增加发动几率且反伤效果增强;攻击无误伤ＰＧ【称号：波斯三使】ＨＷ同时学会圣火神功和乾坤大挪移，额外增加集气速度十;被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	TFNLJS[174] = "Ｇ【天赋：乾坤精要·流云】ＨＷ乾坤大挪移增加发动几率且反伤效果增强;攻击连击率额外增加三十ＰＧ【称号：波斯三使】ＨＷ同时学会圣火神功和乾坤大挪移，额外增加集气速度十;被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	TFNLJS[175] = "Ｇ【天赋：乾坤精要·辉月】ＨＷ乾坤大挪移增加发动几率且反伤效果增强;攻击暴击率额外增加三十ＰＧ【称号：波斯三使】ＨＷ同时学会圣火神功和乾坤大挪移，额外增加集气速度十;被攻击几率发动“乾坤圣火令”伤害降低40%集气恢复200点"
	TFNLJS[176] = "Ｇ【天赋：红颜毒面】ＨＷ怒气积攒加倍；被攻击时几率发动“红颜已改爱难消”免伤40%，降低一半杀气ＰＧ【称号：五仙长老】ＨＷ用毒上限四百;攻击时无视毒抗上毒二十五点;攻击几率发动“鸟啼花怨恨难平”杀气1.5倍，伤害增加40%"
	TFNLJS[177] = "Ｇ【天赋：见利忘义】ＨＷ自身内伤越高，暴击率越大（内伤三十点以上时，每增加一点内伤，暴击率加百分之一）；暴击伤害为200%ＰＧ【称号：太白三英】ＨW格挡效果增强20%;被攻击时若被击中破绽，无视条件必触发格挡"
	TFNLJS[178] = "Ｇ【天赋：唯利是图】ＨＷ自身内伤越高，连击率越大（内伤三十点以上时，每增加一点内伤，连击率加百分之一）；暴击伤害为200%ＰＧ【称号：太白三英】ＨW破招效果增强20%；攻击时若击中破绽，无视条件必触发破招"
	TFNLJS[179] = "Ｇ【天赋：利欲熏心】ＨＷ随自身内伤增加连击率,暴击率（内伤四十点以上时，每增加二点内伤，几率加百分之一）自身攻击伤害上升百分之三十，自身防御力下降百分之二十(华山觉醒后去除防御力下降)ＰＧ【称号：太白三英】ＨＷ攻击格挡和攻击破招可无视条件触发"
	TFNLJS[180] = "Ｇ【天赋：冷暖自知】ＨＷ若触发冰封，攻击敌人时附带等同自身两倍冰封值的数值；若触发灼烧，攻击敌人时附带等同自身两倍灼烧值的数值；不被冰封减速，灼烧增加伤害效果影响ＰＧ【称号：仙都传人】ＨＷ两仪剑法威力二倍且必暴"
	TFJS[181] = {
		"Ｌ【天赋：善恶自明】",
		"Ｗ道德低于四十时随道德降低伤害增加",
		"Ｗ道德大于六十时随道德升高而降低伤害",
		"Ｗ不被冰封减速，灼烧增加伤害效果影响",
		"Ｎ",
		"Ｌ【称号：仙都传人】",
		"Ｗ两仪剑法威力二倍且必连击"
	}
	TFJS[182] = {
		"Ｌ【天赋：大巧若拙】",
		"Ｗ修炼拳法武功三围随拳掌功夫数值上升",
		"Ｗ修炼拳法武功秘籍兵器值二倍成长",
		"Ｎ",
		"Ｌ【称号：五丁手】",
		"Ｗ拳法武功攻击增加固定伤害五点",
		"Ｗ几率发动“五丁开山掌”增加杀气一千点"
	}
	TFJS[183] = {
		"Ｌ【天赋：目中无人】",
		"Ｗ使用剑法武功必暴",
		"Ｗ被击中破绽时伤害大幅增加",
		"Ｎ",
		"Ｌ【称号：沒影子】",
		"Ｗ攻击后恢复集气200",
		"Ｗ修炼武功秘籍三围二倍成长(不与低资兼容)"
	}
	TFJS[184] = {
		"Ｌ【天赋：神行百变】",
		"Ｗ被攻击几率发动“神行百变”减伤百分之四十，百分之二十几率闪躲攻击",
		"Ｗ集气速度加五",
		"Ｎ",
		"Ｌ【称号：铁剑逆徒】",
		"Ｗ使用剑法武功伤害增加百分之二十，流血效果双倍",
		"Ｗ额外增加暴击率"
	}
	TFJS[185] = {
		"Ｌ【天赋：拳剑双修】",
		"Ｗ使用拳法，剑法伤害增加20%",
		"Ｗ攻击必发动招式",
		"Ｎ",
		"Ｌ【称号：神剑仙猿】",
		"Ｗ使用拳法武功必连击",
		"Ｗ使用剑法武功必暴击",
		"Ｗ装备剑类后额外增加固定伤害三十点和集气伤害"
	}
	TFJS[186] = {
		"Ｌ【天赋：质朴归真】",
		"Ｗ行动后战意不减",
		"Ｗ被攻击时流血，封穴，冰封，灼烧效果减半",
		"Ｎ",
		"Ｌ【称号：神拳无敌】",
		"Ｗ拳法类武功增加固定伤害五十点且必暴"
	}
	TFJS[187] = {
		"Ｌ【天赋：嫉恶如仇】",
		"Ｗ攻击时几率发动“除恶务尽”增加杀气值一千点",
		"Ｗ攻击时增加破招几率且无视发动条件",
		"Ｎ",
		"Ｌ【称号：八面威风】",
		"Ｗ额外增加暴击，连击率20%"
	}
	TFJS[188] = {
		"Ｌ【天赋：临阵乱心】",
		"Ｗ全场敌人集气速度减五",
		"Ｗ击中破绽时伤害为300%",
		"Ｎ",
		"Ｌ【称号：铜笔铁算】",
		"Ｗ内力消耗减少百分之二十五"
	}
	TFJS[189] = {
		"Ｌ【天赋：净身出身】",
		"Ｗ性别为太监，免受负集气惩罚",
		"Ｎ",
		"Ｌ【称号：晋阳大侠】",
		"Ｗ攻防效果增加百分之十",
		"Ｗ集气速度增加十"
	}
	TFNLJS[181] = "Ｇ【天赋：善恶自明】ＨＷ道德低于四十时随道德降低伤害增加(最高增加百分之三十)；道德大于六十时随道德升高而降低伤害(最高降低百分之四十)ＰＧ【称号：仙都传人】ＨＷ两仪剑法威力2倍且必连击"
	TFNLJS[182] = "Ｇ【天赋：大巧若拙】ＨＷ修炼拳法武功三围随拳掌功夫数值上升；修炼拳法武功秘籍兵器值二倍成长ＰＧ【称号：五丁手】ＨW拳法武功攻击增加固定伤害五点；几率发动“五丁开山掌”增加杀气一千点"
	TFNLJS[183] = "Ｇ【天赋：目中无人】ＨＷ使用剑法武功必暴；被击中破绽时伤害大幅增加ＰＧ【称号：沒影子】ＨW攻击后恢复集气200；修炼武功秘籍三围二倍成长(不与低资兼容)"
	TFNLJS[184] = "Ｇ【天赋：神行百变】ＨＷ被攻击几率发动“神行百变”减伤百分之四十，百分之二十几率闪躲攻击；集气速度加五ＰＧ【称号：铁剑逆徒】ＨＷ使用剑法武功伤害增加百分之二十，流血效果双倍；额外增加暴击率"
	TFNLJS[185] = "Ｇ【天赋：拳剑双修】ＨＷ使用拳法，剑法伤害增加20%，攻击必发动招式ＰＧ【称号：神剑仙猿】ＨＷ使用拳法武功必连击；剑法武功必暴击；装备剑类后额外增加固定伤害三十点和集气伤害"
	TFNLJS[186] = "Ｇ【天赋：质朴归真】ＨＷ行动后战意不减；被攻击时流血，封穴，冰封，灼烧效果减半ＰＧ【称号：神拳无敌】ＨＷ拳法类武功增加固定伤害五十点且必暴"
	TFNLJS[187] = "Ｇ【天赋：嫉恶如仇】ＨＷ攻击时几率发动“除恶务尽”增加杀气值一千点；攻击时增加破招几率且无视发动条件ＰＧ【称号：八面威风】ＨＷ额外增加暴击，连击率20%"
	TFNLJS[188] = "Ｇ【天赋：临阵乱心】ＨＷ全场敌人集气速度减十；击中破绽时伤害为300%ＰＧ【称号：铜笔铁算】ＨＷ内力消耗减少百分之二十五"
	TFNLJS[189] = "Ｇ【天赋：净身出身】ＨＷ性别为太监，免受负集气惩罚ＰＧ【称号：晋阳大侠】ＨＷ攻防效果增加百分之十，集气速度增加十"
	TFJS[587] = {
		"Ｌ【天赋：善谋军师】",
		"Ｗ我方攻击增加10%，受攻击伤害减少5%",
		"Ｎ",
		"Ｌ【称号：绿林领袖】",
		"Ｗ我方人越多集气越快"
	}
	TFJS[588] = {
		"Ｌ【天赋：虎狼之姿】",
		"Ｗ使用五虎断门刀必暴击",
		"Ｎ",
		"Ｌ【称号：市景豪雄】",
		"Ｗ怒气增长加倍"
	}
	TFJS[589] = {
		"Ｌ【天赋：似水柔情】",
		"Ｗ在战场时敌人集气速度减五点",
		"Ｗ攻击时不会使敌人怒气值上涨",
		"Ｎ",
		"Ｌ【称号：冰山侠女】",
		"Ｗ攻击时有机率造成敌人冰封"
	}
	TFJS[590] = {
		"Ｌ【天赋：心秀天铃】",
		"Ｗ特系两倍成长",
		"Ｗ特系伤害提高15%",
		"Ｎ",
		"Ｌ【称号：白马之女】",
		"Ｗ集气增加五点",
		"Ｗ随修炼武功数增加行动后初始集气",
		"Ｗ装备白马有额外五点集气速度加成"
	}
	TFJS[591] = {
		"Ｌ【天赋：心灵感应】",
		"Ｗ与石破天相互攻击不会误伤，受伤时共同分担伤害",
		"Ｎ",
		"Ｌ【称号：无行浪子】",
		"Ｗ攻击造成双倍流血",
		"Ｗ被攻击时女性敌人伤害减40%",
		"Ｗ几率发动无行浪子，所有伤害减30%"
	}
	TFJS[592] = {
		"Ｌ【天赋：惊才绝艳】",
		"Ｗ进入战斗立即行动",
		"Ｗ攻击时按九剑意境连击，无视范围攻击",
		"Ｗ被攻击随九剑意境累加，九剑终结时发动九剑极意，",
		"Ｗ——无招胜有招，",
		"Ｎ",
		"Ｌ【称号：震古烁今】",
		"Ｗ受攻击时必发动九剑破招减少伤害，必打断敌方连击",
		"Ｗ连续受到同一类型的武功攻击时，完全破招减伤"
	}
	TFJS[593] = {
		"Ｌ【天赋：就是不戒】",
		"Ｗ攻击时额外杀集气四百点",
		"Ｎ",
		"Ｌ【称号：酒肉罗汉】",
		"Ｗ未暴击时百分之五十几率二次判定"
	}
	TFNLJS[589] = "Ｇ【天赋：似水柔情】ＨＷ在战场时敌人集气速度减五点；攻击时不会使敌人怒气值上涨ＰＧ【称号：冰山侠女】ＨＷ攻击时有机率造成敌人冰封且根据双方当前内力差值增加冰封值(随当前内力增加而增加最高为五十)"
	TFNLJS[590] = "Ｇ【天赋：心秀天铃】ＨＷ特系两倍成长，特系伤害提高15%ＰＧ【称号：白马之女】ＨＷ集气增加五点；随修炼武功数增加行动后初始集气二十五点，最大额外增加二百五十；装备白马有额外五点集气速度加成"
	TFNLJS[591] = "Ｇ【天赋：心灵感应】ＨＷ与石破天相互攻击不会误伤，受伤时共同分担伤害ＰＧ【称号：无行浪子】ＨW攻击造成双倍流血；被攻击时女性敌人伤害减40%,几率发动无行浪子，所有伤害减30%"
	TFNLJS[592] = "Ｇ【天赋：惊才绝艳】ＨＷ进入战斗立即行动；攻击时按九剑意境依次连击，无视范围攻击，被攻击人数随九剑意境累加，九剑终结时发动九剑极意——无招胜有招，范围全屏，被攻击者陷入频死状态，自身回复部分状态ＰＧ【称号：震古烁今】ＨＷ受攻击时必发动九剑破招减少伤害，必打断敌方连击，连续受到同一类型的武功攻击时，完全破招免伤"
	TFNLJS[593] = "Ｇ【天赋：就是不戒】ＨＷ攻击时额外杀集气四百点ＰＧ【称号：酒肉罗汉】ＨＷ未暴击时百分之五十几率二次判定"
	TFNLJS[594] = "Ｇ【天赋：飞蝗刀】ＨＷ刀法武功连击率加30；攻击几率发动飞蝗刀 直接减少敌人生命两百点ＰＧ【称号：万马庄主】ＨＷ集气速度加五；装备白马时降低被攻击伤害30%，攻击伤害增加20%"
	TFNLJS[595] = "Ｇ【天赋：辽东鹤】ＨＷ集气速度加五，攻击时几率发动辽东鹤，增加35%伤害ＰＧ【称号：鹤笔掌门】ＨＷ特殊类武功高几率"
	TFNLJS[596] = "Ｇ【天赋：紫金刀】ＨＷ攻击时几率发动紫金刀，全体强制杀气200点ＰＧ【称号：快刀掌门】ＨＷ刀法兵器值大于100时，集气速度加10，每增加刀法兵器值二十点，集气速度加一"
	TFNLJS[597] = "Ｇ【天赋：青龙软鞭】ＨＷ毒龙鞭法伤害二到三倍ＰＧ【称号：青龙掌门】ＨＷ攻击强制上毒十五点,伤害增加五十，敌人中毒越深，伤害越高"
	TFJS[594] = {
		"Ｌ【天赋：飞蝗刀】",
		"Ｗ刀法武功连击率加30",
		"Ｗ攻击几率发动飞蝗刀，减少敌人生命八十点",
		"Ｎ",
		"Ｌ【称号：万马庄主】",
		"Ｗ装备白马时集气速度加5"
	}
	TFJS[595] = {
		"Ｌ【天赋：辽东鹤】",
		"Ｗ集气速度加五",
		"Ｗ攻击时几率发动辽东鹤，增加35%伤害",
		"Ｎ",
		"Ｌ【称号：鹤笔掌门】",
		"Ｗ被特殊类武功攻击，伤害减少30%"
	}
	TFJS[596] = {
		"Ｌ【天赋：紫金刀】",
		"Ｗ攻击时几率发动紫金刀，全体强制杀气200点",
		"Ｎ",
		"Ｌ【称号：快刀掌门】",
		"Ｗ刀法兵器值大于100时，集气速度加10，",
		"Ｗ每增加刀法兵器值二十点，集气速度加一"
	}
	TFJS[597] = {
		"Ｌ【天赋：青龙软鞭】",
		"Ｗ毒龙鞭法伤害二到三倍",
		"Ｎ",
		"Ｌ【称号：青龙掌门】",
		"Ｗ敌人中毒越深，伤害越高"
	}
	TFJS[598] = {
		"Ｌ【天赋：杀人如麻】",
		"Ｗ每杀一人，战意额外加五",
		"Ｗ道德低于五十时，道德越低，连击几率和暴击几率越高",
		"Ｎ",
		"Ｌ【称号：血刀恶僧】",
		"Ｗ使用血刀大法攻击伤害增加二十五，",
		"Ｗ装备血刀时额外增加伤害二十五"
	}
	TFJS[599] = {
		"Ｌ【天赋：死里逃生】",
		"Ｗ当生命小于百分之二十五时被攻击必恢复生命一百点",
		"Ｗ生命值为0后装死并半血复活",
		"Ｎ",
		"Ｌ【称号：铁索横江】",
		"Ｗ使用连城剑法必连击、必暴击"
	}
	TFJS[600] = {
		"Ｌ【天赋：无敌幸运星】",
		"Ｗ战场上几率逃脱敌人攻击",
		"Ｎ",
		"Ｌ【称号：机灵小宝】",
		"Ｗ战斗中抛撒石灰，使敌人短暂失明"
	}
	TFJS[626] = {
		"Ｌ【天赋：义重为先】",
		"Ｗ全员集气速度加五",
		"Ｗ血越少，内伤越高连击，暴击率增加",
		"Ｎ",
		"Ｌ【称号：丐帮长老】",
		"Ｗ打狗棒法极意无视兵器值发动"
	}
	TFJS[627] = {
		"Ｌ【天赋：降龙十二掌】",
		"Ｗ降龙十八掌极意招式发动要求降低兵器值60点",
		"Ｎ",
		"Ｌ【称号：金银掌】",
		"Ｗ攻击时几率发动金掌，拳掌类武功必暴击",
		"Ｗ攻击时几率发动银掌，拳掌类武功必连击"
	}
	TFJS[632] = {
		"Ｌ【天赋：尘世业火】",
		"Ｗ使用特殊武功攻击额外增加连击几率",
		"Ｗ使用剑法攻击额外增加连击几率",
		"Ｎ",
		"Ｌ【称号：天池传人】",
		"Ｗ特系两倍成长",
		"Ｗ剑系两倍成长"
	}
	TFJS[633] = {
		"Ｌ【天赋：四季春心】",
		"Ｗ对异性伤害增加30%",
		"Ｎ",
		"Ｌ【称号：锦毛貂】",
		"Ｗ攻击时使敌人中毒至少十点"
	}
	TFNLJS[626] = "Ｇ【天赋：义重为先】ＨＷ全员集气速度加五；我方攻击伤害增加15%受攻击伤害减少15%ＰＧ【称号：英染碧竹】ＨＷ血越少，内伤越高连击，暴击率增加；打狗棒法极意无视兵器值发动"
	TFNLJS[627] = "Ｇ【天赋：降龙十二掌】ＨＷ降龙十八掌极意招式发动要求降低兵器值60点ＰＧ【称号：金银掌】ＨW攻击时几率发动金掌，拳掌类武功必暴击；银掌，拳掌类武功必连击"
	TFNLJS[598] = "Ｇ【天赋：杀人如麻】ＨＷ每杀一人，战意额外加五；道德低于五十时，道德越低，连击几率和暴击几率越高(最高加50%)ＰＧ【称号：血刀恶僧】ＨＷ使用血刀大法攻击伤害增加二十五，装备血刀时额外增加伤害二十五"
	TFNLJS[599] = "Ｇ【天赋：死里逃生】ＨＷ当生命小于百分之二十五时被攻击必恢复生命一百点，死后半血复活ＰＧ【称号：铁索横江】ＨＷ使用连城剑法必连击、必暴击"
	CC.Timer = {
		len = 0,
		status = 0,
		str = "",
		stime = 0,
		fun = demostr
	}
	CC.RUNSTR = {
		"如果是对本游戏世界不熟悉，则强烈建议选新手难度",
		"S键可快速存盘；PC上玩的话，按K键可以切换全屏/窗口",
		"任务中如果失去人物消息，进酒馆打听或许是个好主意",
		"内功是个好东西，能大幅增加你的能力，还能打人",
		"战斗时按键1-9可以快捷调用对应武功",
		"本游戏是随时间推进开始事件，但是天书类事件开始后都会等着你去触发，所以不用着急，你可以慢慢游历这个江湖世界",
		"战场类的武功，如果配上战马，威力会大大增加",
		"星宿派入门要求最低，加入门派后也自由自在，你可以考虑加入下",
		"体质属性很重要，它决定你的最大生命值，一些特殊的武功可以提升体质",
		"隐藏属性气运，不单影响基础概率，在战斗中也会发生微妙的作用",
		"开始时一定要和小村的护卫打一场，他会开阔你的眼界",
		"遇到随机任务，不要反复调取进度，会降低你的气运，得不赏失",
		"珍惜每一个加入的队友，能够自始至终跟随你，并拼命战斗的人是有限的。记得，每个人都有他必须要做的事，不是每个人都会围着你转",
		"悟性越高，能学习的武功就越多",
		"武功修炼到跨越层次之时通常会遇到瓶颈，武功瓶颈除了师父和前辈或友人指导之外，还可以在一些特殊之地或和高手对战中突破",
		"轻易不要进入天书里的战斗现场，每一个在书中有名姓的人物可都不是好惹的",
		"队友加入后默认为自行控制战斗，如果你要自己亲自指挥，可以在个人状态中的AI设置中修改",
		"少林的武功需要佛法镇压，否则容易走火入魔",
		"如果你选了悟性普通的角色，那么他有一个隐藏天赋兔子急了也会咬人，所谓匹夫一怒，血溅五步",
		"在这个武侠世界，你不是永生的，体质决定寿命长短。强大的内力可以延长寿命",
		"战斗中的快捷键 P 蓄力 W 等待 D 防御",
		"善用蓄力、防御和等待指令，能让你的战斗变得更轻松",
		"一些队友拥有独一无二的特色指令，把握好释放这些特技的时机，可以使你事半功倍的达到预定目的",
		"在状态栏显示里，外功为黄色，内功为红色，白色的则是各队友的得意武功，不会造成误伤",
		"如果你什么武功也不会，特别是不会内功，那么你在家练到老死也仍然是一个普通人",
		"本游戏参考了《龙的传人》《龙的传人之畅想江湖》《山寨江湖》等很多的金庸群侠传MOD游戏，感谢各位前辈为武侠文化所做的努力",
		"您目前使用的是《金庸群侠传之龙起江湖》是由 grgame 做的绿色免费游戏，属武侠爱好者自娱自乐"
	}
end
