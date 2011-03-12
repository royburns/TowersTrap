--
--   A* Lua 实现
--   By Jian
--   Version 1.0
--

-- 常量 --
KMapWidth =  28              -- 地图的宽度（节点数）
KMapHeight =  32             -- 地图的高度（节点数）

--[[地图节点
]]
CMapNode =
{
	iX = 0 ,                 -- 在地图中的 X 坐标
	iY = 0 ,                 -- 在地图中的 Y 坐标
	iIndex = 0 ,             -- 在一维地图数组中的下标

	iFCost = 0 ,             -- A Star 算法中的 F 耗费
	-- iGCost = 0 ,             -- A Star 算法中的 G 耗费
	-- iHCost = 0 ,             -- A Star 算法中的 H 耗费

	iIsInOpenList = false ,  -- 该节点是否在 开放列表 中
	iIsInCloseList = false , -- 该节点是否在 关闭列表 中

	iParent = nil ,          -- 使用A Star 求路径过程中存储父节点
	iNext = nil ,            -- 在openList 和 closeList 中指向下一个元素

	iCanPass = true          -- 该节点是否是可通过节点
}

-- 构造函数 --
function CMapNode:new(aIndex)
	if (aIndex == nil) then
		error(" the Index Can't be nil ") 
	end

	ret = object or {}
	self.__index = self
	setmetatable(ret, self)
	
	-- ######## Line too long (106 chars) ######## :
	--ret.iX = aIndex - math.floor(aIndex / KMapWidth) * KMapWidth  -- 求余、未知 % 为什么报错，数学库也打开了
	--ret.iY = math.floor((aIndex - ret.iX) / KMapWidth)    -- Lua 得出的商是浮点数
	ret.iX = math.floor(aIndex % KMapWidth)
	ret.iY = math.floor(aIndex / KMapWidth)
	ret.iIndex = aIndex
	
	return ret
end


-- 绘制函数 --
function CMapNode:DrawChar()
	drawChar = nil

	if ( self.iCanPass ) then
		if ( self.iIsInOpenList ) then
			drawChar = "1 "
		else 
			drawChar = "◎ "
		end
	else 
		drawChar = "■" 
	end

	return drawChar
end

-- 绘制表
drawMap = {n = KMapWidth *  KMapHeight}

-- 初始化地图表 --
Map = {n = KMapWidth *  KMapHeight}
for x = 0 , Map.n - 1 do
	Map[x] = CMapNode:new(x)
end

--[[地图表
]]

--绘制函数 --
function Map:Draw()
	local drawString = ""
	for x = 0, KMapWidth * KMapHeight do
		if (self[x].iX == 0) then
			print("\n")
			print(drawString)
			drawString = ""
		end -- end if

		drawString = drawString .. self[x]:DrawChar()
	end -- end for
end


--[[地图节点列表（链表结构）
]]

NodeList =
{
	iRoot = nil        -- 根节点
}

-- 构造函数 --
function NodeList:new()
	ret = {}
	self.__index = self
	setmetatable(ret, self)
	
	return ret
end

-- 销毁链表
function NodeList:Clear()
	self.iRoot = nil
end

-- 增加一个Node到列表 --
function NodeList:AddNode(aMapNode)
	if (self.iRoot == nil) then
		self.iRoot = aMapNode
		return
	end

	-- 找出第一个 iFCost 比它大的Node，插在它的前面
	local curNode = self.iRoot    -- 当前节点
	local lastNode = nil          -- 前一节点
	while (curNode) do
		if (curNode.iFCost >= aMapNode.iFCost) then
			aMapNode.iNext = curNode
			if (curNode == self.iRoot) then 
				self.iRoot = aMapNode
			else 
				lastNode.iNext = aMapNode  
			end
			return
		end -- end if
		lastNode = curNode
		curNode = curNode.iNext
	end -- end while

	lastNode.iNext = aMapNode
end

-- 在列表中删除一个Node --
function NodeList:DeleteNode(aMapNode)
	local curNode = self.iRoot    -- 当前节点
	local lastNode = nil          -- 前一节点

	while (curNode) do
		if (curNode == aMapNode) then
			if (lastNode) then 
				lastNode.iNext = aMapNode.iNext 
			end
			if (curNode == self.iRoot) then 
				self.iRoot = self.iRoot.iNext 
			end
			aMapNode.iNext = nil
			return
		end
		lastNode = curNode
		curNode = curNode.iNext
	end -- end while

	error( "The Node you deleted is not in the list !")
end

-- 开启列表
openList = NodeList:new()

-- 添加一个Node到开发列表
function openList:Add( aMapNode )
	aMapNode.iIsInOpenList = true
	self:AddNode( aMapNode )
end

-- 从开发列表中移除一个Node
function openList:Remove( aMapNode )
	aMapNode.iIsInOpenList = false
	self:DeleteNode( aMapNode )
end

-- 关闭列表
closeList = NodeList:new()

-- 添加一个Node到关闭列表
function closeList:Add( aMapNode )
	aMapNode.iIsInCloseList = true
	self:AddNode( aMapNode )
end

--[[A Star 寻路主函数
]]
function AStarInit()
	print(" AStarInit() ")
	openList:Clear()
	closeList:Clear()
	
	-- 初始化地图表 --
	for x = 0 , Map.n - 1 do
		Map[x].iIsInOpenList = false   -- 该节点是否在 开放列表 中
		Map[x].iIsInCloseList = false  -- 该节点是否在 开放列表 中
		Map[x].iParent = nil
		Map[x].iNext = nil
	end
end

-- 
function AStarPathFind(aStartIndex, aEndIndex)
	print(string.format("AStarPathFind(%d,%d)", aStartIndex, aEndIndex))
	
	-- ######## Line too long (94 chars) ######## :
	if (aStartIndex < 0 and aStartIndex > Map.n) then error("StartIndex Out Off bound ")  end
	-- ######## Line too long (88 chars) ######## :
	if (aEndIndex < 0 and aEndIndex > Map.n) then error("EndIndex Out Off bound ")  end

	-- 首先把起始节点添加到开启列表
	local H = HDistance(aStartIndex, aEndIndex)
	local G = 1
	Map[aStartIndex].iFCost = H + G

	openList:AddNode(Map[aStartIndex])

	while (true) do
		-- 取出openList中的F最少值
		-- 并判断openList是否为空
		leaseFNode = openList.iRoot
		if (leaseFNode == nil) then break end

		-- 从开放列表中移除该节点
		openList:Remove(leaseFNode)

		-- 添加到关闭列表
		closeList:Add(leaseFNode)

		-- 把该节点附近的节点添加到 开放列表
		-- 并根据函数返回值判断是否已经找到路径
		if (AddNeighborToOpenList(leaseFNode, aEndIndex)) then break end
	end -- end while
end

-- 获取H 估算值
function HDistance(aStartIndex, aEndIndex)
	local tmp1 = math.abs(Map[aStartIndex].iX - Map[aEndIndex].iX)
	local tmp2 = math.abs(Map[aStartIndex].iY - Map[aEndIndex].iY)

	--local tmp1 = Map[aStartIndex].iX - Map[aEndIndex].iX
	--local tmp2 = Map[aStartIndex].iY - Map[aEndIndex].iY
	
	--if ( tmp1 <= 0 ) then tmp1 = -tmp1 end
	--if ( tmp2 <= 0 ) then tmp2 = -tmp2 end

	return ( ( tmp1^2 + tmp2^2 )^0.5 )
end

-- 把指定节点附近的节点添加到 开放列表
-- 返回是否已经到达目标节点
function AddNeighborToOpenList(aMapNode, aEndIndex)
	ret = false   -- 返回值

	local tmpNode = nil
	local aIndex = nil

	for aY = aMapNode.iY-1, aMapNode.iY+1  do
		for aX = aMapNode.iX-1, aMapNode.iX+1  do
			-- 边界检查
			if ( aX >= 0 and aX < KMapWidth and aY >= 0 and aY < KMapHeight ) then
				aIndex = aX + aY * KMapWidth
				tmpNode = Map[aIndex]

				-- 判断是否是结束节点
				if ( aIndex == aEndIndex ) then
					ret = true
					tmpNode.iParent = aMapNode
					break
				end
				if tmpNode == nil then
					print(string.format("ERROR:tempNode(%d) is nil!",aIndex))
				end
				-- 判断该节点是否可通过
				if ( tmpNode.iCanPass ) then
					-- 是否已经在关闭列表中
					if ( tmpNode.iIsInCloseList == false ) then
						local H = HDistance( tmpNode.iIndex , aEndIndex )
						local G = 1     -- 简单的定为1
						local F = H + G

						-- 是否在开发列表中
						if ( tmpNode.iIsInOpenList == true ) then
							-- 判断是否现在的路径更好
							if( F < tmpNode.iFCost ) then
								tmpNode.iFCost = F
								tmpNode.iParent = aMapNode
							end
						else
							tmpNode.iFCost = F
							tmpNode.iParent = aMapNode

							-- 添加到开发列表中
							openList:Add( tmpNode )
						end  -- end 是否在开发列表中

					end   -- end 是否已经在关闭列表中
				end  -- end 判断该节点是否可通过

			end -- end 边界检查

		end -- end for
	end -- end for

	return ret
end

-- 
function setblock(i)
	if(i == 0) then
		for x = 30, 37 do
			Map[x].iCanPass = false
			drawMap[x] = 1
		end
	else
		for x = 65 , 77 do
			Map[x].iCanPass = false
			drawMap[x] = 1
		end
	end
end

-- 
function AStarDrawPath(endIndex)
	node = Map[endIndex]

	while( node.iParent ) do
		drawMap[node.iIndex] = 2
		node = node.iParent
	end
	-- 绘制
	local drawString = ""
	for x = 0 , drawMap.n - 1 do
		if ( Map[x].iX == 0 ) then
			print( drawString )
			drawString = ""
		end -- end if

		if ( drawMap[x] == 1 ) then
			drawString = drawString .. "◆"     -- 代表不可通行点
		elseif ( drawMap[x] == 2 )  then
			drawString = drawString .. "★"     -- 代表找到的路径点
		else
			drawString = drawString .. "※"     -- 其他可通行点
		end
	end
end
 

--[[ Test main函数
]]
function main()
	startIndex = 0
	endIndex = 214

	-- 绘制表
	drawMap = { n = KMapWidth *  KMapHeight }

	local x = os.clock()
	print(" Path Finding ")

	local l = 3
	for i=1,l do
		AStarInit()
		setblock(i-1)
		--setblock(1)
		AStarPathFind( startIndex , endIndex )
		--AStarOutString()
		AStarDrawPath(endIndex)
	end
	print(" Path Finding done , loop  " .. l)
	print(string.format("elapsed time: %.6f\n", os.clock() - x))
	
	--[[ 
	local closeNode = closeList.iRoot

	local closeNodeCount = 0
	while( closeNode ) do
		print( closeNode.iIndex )
		closeNode = closeNode.iNext
		closeNodeCount = closeNodeCount + 1
	end
	print( "closeNodeCount is" , closeNodeCount )
	--]] 
end

--[[ for test
main() 
--]] 
