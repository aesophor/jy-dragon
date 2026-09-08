function initAstar()
	WAR.WarMap = {
		n = CC.WarWidth * CC.WarHeight
	}

	for iter_1_0 = 0, Map.n - 1 do
		Map[iter_1_0] = CMapNode:new(iter_1_0)
		Map[iter_1_0].iCanPass = false
	end

	WAR.CMapNode = {
		iIsInCloseList = false,
		iIsInOpenList = false,
		iCanPass = true,
		iX = 0,
		iY = 0,
		iFCost = 0,
		iIndex = 0
	}
	WAR.NodeList = {}
end

CMapNode.new = function (arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		lib.Debug(" the Index Can't be nil ")
	end

	ret = object or {}
	arg_2_0.__index = arg_2_0

	setmetatable(ret, arg_2_0)

	ret.iX = arg_2_1 - math.floor(arg_2_1 / CC.WarWidth) * CC.WarWidth
	ret.iY = (arg_2_1 - ret.iX) / CC.WarWidth
	ret.iIndex = arg_2_1

	return ret
end

NodeList.new = function (arg_3_0)
	ret = {}
	arg_3_0.__index = arg_3_0

	setmetatable(ret, arg_3_0)

	return ret
end

NodeList.AddNode = function (arg_4_0, arg_4_1)
	if arg_4_0.iRoot == nil then
		arg_4_0.iRoot = arg_4_1

		return
	end

	local var_4_0 = arg_4_0.iRoot
	local var_4_1

	while var_4_0 do
		if var_4_0.iFCost >= arg_4_1.iFCost then
			arg_4_1.iNext = var_4_0

			if var_4_0 == arg_4_0.iRoot then
				arg_4_0.iRoot = arg_4_1
			else
				var_4_1.iNext = arg_4_1
			end

			return
		end

		var_4_1 = var_4_0
		var_4_0 = var_4_0.iNext
	end

	var_4_1.iNext = arg_4_1
end

NodeList.DeleteNode = function (arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.iRoot
	local var_5_1

	while var_5_0 do
		if var_5_0 == arg_5_1 then
			if var_5_1 then
				var_5_1.iNext = arg_5_1.iNext
			end

			if var_5_0 == arg_5_0.iRoot then
				arg_5_0.iRoot = arg_5_0.iRoot.iNext
			end

			arg_5_1.iNext = nil

			return
		end

		var_5_1 = var_5_0
		var_5_0 = var_5_0.iNext
	end

	lib.Debug("The Node you deleted is not in the list !")
end

openList = NodeList:new()

openList.Add = function (arg_6_0, arg_6_1)
	arg_6_1.iIsInOpenList = true

	arg_6_0:AddNode(arg_6_1)
end

openList.Remove = function (arg_7_0, arg_7_1)
	arg_7_1.iIsInOpenList = false

	arg_7_0:DeleteNode(arg_7_1)
end

closeList = NodeList:new()

closeList.Add = function (arg_8_0, arg_8_1)
	arg_8_1.iIsInCloseList = true

	arg_8_0:AddNode(arg_8_1)
end

function AStarPathFind(arg_9_0, arg_9_1)
	if arg_9_0 < 0 and arg_9_0 > Map.n then
		lib.Debug("StartIndex Out Off bound ")
	end

	if arg_9_1 < 0 and arg_9_1 > Map.n then
		lib.Debug("EndIndex Out Off bound ")
	end

	local var_9_0 = HDistance(arg_9_0, arg_9_1)
	local var_9_1 = 1

	Map[arg_9_0].iFCost = var_9_0 + var_9_1

	openList:AddNode(Map[arg_9_0])

	repeat
		leaseFNode = openList.iRoot

		if leaseFNode == nil then
			break
		end

		openList:Remove(leaseFNode)
		closeList:Add(leaseFNode)
	until AddNeighborToOpenList(leaseFNode, arg_9_1)
end

function HDistance(arg_10_0, arg_10_1)
	local var_10_0 = Map[arg_10_0].iX - Map[arg_10_1].iX
	local var_10_1 = Map[arg_10_0].iY - Map[arg_10_1].iY

	if var_10_0 <= 0 then
		var_10_0 = -var_10_0
	end

	if var_10_1 <= 0 then
		var_10_1 = -var_10_1
	end

	return (var_10_0^2 + var_10_1^2)^0.5
end

function AddNeighborToOpenList(arg_11_0, arg_11_1)
	ret = false

	local var_11_0
	local var_11_1

	for iter_11_0 = arg_11_0.iY - 1, arg_11_0.iY + 1 do
		for iter_11_1 = arg_11_0.iX - 1, arg_11_0.iX + 1 do
			if iter_11_1 >= 0 and iter_11_1 < CC.WarWidth and iter_11_0 >= 0 and iter_11_0 <= CC.WarHeight then
				local var_11_2 = iter_11_1 + iter_11_0 * CC.WarWidth
				local var_11_3 = Map[var_11_2]

				if var_11_2 == arg_11_1 then
					ret = true
					var_11_3.iParent = arg_11_0

					break
				end

				if var_11_3.iCanPass and var_11_3.iIsInCloseList == false then
					local var_11_4 = HDistance(var_11_3.iIndex, arg_11_1) + 1

					if var_11_3.iIsInOpenList == true then
						if var_11_4 < var_11_3.iFCost then
							var_11_3.iFCost = var_11_4
							var_11_3.iParent = arg_11_0
						end
					else
						var_11_3.iFCost = var_11_4
						var_11_3.iParent = arg_11_0

						openList:Add(var_11_3)
					end
				end
			end
		end
	end

	return ret
end

function main()
	startIndex = 0
	endIndex = 214
	drawMap = {
		n = CC.WarWidth * CC.WarHeight
	}

	for iter_12_0 = 30, 37 do
		Map[iter_12_0].iCanPass = false
		drawMap[iter_12_0] = 1
	end

	for iter_12_1 = 65, 77 do
		Map[iter_12_1].iCanPass = false
		drawMap[iter_12_1] = 1
	end

	print(" Path Finding ")
	AStarPathFind(startIndex, endIndex)

	node = Map[endIndex]

	while node.iParent do
		drawMap[node.iIndex] = 2
		node = node.iParent
	end

	local var_12_0 = ""

	for iter_12_2 = 0, drawMap.n - 1 do
		if Map[iter_12_2].iX == 0 then
			print(var_12_0)

			var_12_0 = ""
		end

		if drawMap[iter_12_2] == 1 then
			var_12_0 = var_12_0 .. "X "
		elseif drawMap[iter_12_2] == 2 then
			var_12_0 = var_12_0 .. "K "
		else
			var_12_0 = var_12_0 .. "O "
		end
	end

	local var_12_1 = closeList.iRoot
	local var_12_2 = 0

	while var_12_1 do
		print(var_12_1.iIndex)

		var_12_1 = var_12_1.iNext
		var_12_2 = var_12_2 + 1
	end

	print("closeNodeCount is", var_12_2)
end

main()
