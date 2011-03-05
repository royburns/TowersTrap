
-- Game State
-- Where the actual playing takes place

Game = {}
Game.__index = Game

grid_col = 28
grid_row = 32

battlearea = {top = 0,left = 0}

size = 8

time_UpdateCapiton = 0

function Game.create()
	
	love.audio.play(music["game"], 1)
	
	local temp = {}
	setmetatable(temp, Game)
	
	math.randomseed(os.time()) -- randomize (for good measure)

	--[[
  	地图表
	]]
	--temp.maps = {} -- 地图
	temp.maps = {1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 -1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1,
			 1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1
			}

	for i = 0, grid_col * grid_row - 1 do
		if temp.maps[i+1] <= 0 then
		   	Map[i].iCanPass = true
	   	else
		   	Map[i].iCanPass = false
	   	end
	end
	
    temp.stages ={ --关卡设计
				{ time = 20, creature = 0, number = 10 },
				{ time = 20, creature = 1, number = 20 }, 
				{ time = 20, creature = 2, number = 20 }, 
				{ time = 15, creature = 3, number = 15 }, 
				{ time = 15, creature = 4, number = 15 }, 
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 }, 
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },

				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 1, number = 15 },
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 6, number = 15 },
				{ time = 15, creature = 7, number = 2 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 15 },
				
				{ time = 15, creature = 2, number = 15 },
				{ time = 15, creature = 3, number = 15 },
				{ time = 15, creature = 4, number = 15 },
				{ time = 15, creature = 5, number = 15 },
				{ time = 15, creature = 6, number = 18 },
				{ time = 15, creature = 3, number = 14 },
				{ time = 15, creature = 0, number = 15 },
				{ time = 15, creature = 1, number = 16 },
				{ time = 15, creature = 2, number = 14 },
				{ time = 15, creature = 7, number = 2 }
				
				}
	
	temp.scope = 0 --分数
	temp.money = 8000 --钱
	temp.health = 50 --生命
	temp.time = temp.stages[1].time --时间
	temp.stage = 0 -- 关卡
	temp.blockhouses = {} -- 碉堡
	temp.hints = {} --提示
	temp.gselectedBlockhouse = nil;
	
	temp.enemys = {} --敌人
	temp.ballets = {} -- 子弹 
	-- 鼠标绝对位置
	temp.mousepointer = {x = 0,
	                    y = 0}
	-- 鼠标网格位置					
	temp.gridpointer = {x = 0,
	                    y = 0}

	-- Setup the randomized grid
--	temp.grid = {}
--	for x = 1,size do
--		temp.grid[x] = {}
--		for y = 1, size do
--			num = math.random(1,3)
--			if num == 1 then
--				temp.grid[x][y] = false
--			else
--				temp.grid[x][y] = true
--			end
--		end
--	end
--	
	-- Create the text along the top
--	local count = 0
--	temp.horizontal = {}
--	for x = 1,size do
--		temp.horizontal[x] = ""
--		for y = 1,size do
--			if temp.grid[x][y] then
--				count = count + 1
--			elseif count ~= 0 then
--				temp.horizontal[x] = temp.horizontal[x] .. count .. "\n"
--				count = 0
--			end
--		end
--		
--		if count ~= 0 then
--			temp.horizontal[x] = temp.horizontal[x] .. count .. "\n"
--		end
--		
--		count = 0
--	end
--	
--	-- Create the text along the side
--	temp.vertical = {}
--	for y = 1,size do
--		temp.vertical[y] = ""
--		for x = 1,size do
--			if temp.grid[x][y] then
--				count = count + 1
--			elseif count ~= 0 then
--				temp.vertical[y] = temp.vertical[y] .. count .. " "
--				count = 0
--			end
--		end
--		
--		if count ~= 0 then
--			temp.vertical[y] = temp.vertical[y] .. count .. " "
--		end
--		
--		count = 0
--	end
--	
--	-- Setup the user-entered grid
--	temp.grid = {}
--	for x = 1,size do
--		temp.grid[x] = {}
--		for y = 1, size do
--			temp.grid[x][y] = 0
--		end
--	end
	
	-- Other variables
	--temp.time = 0 -- the time for this game
	temp.win = -999 -- if the game is won and timer for fadein
	temp.pause = false -- if the game is paused
	temp.button = {	new = Button.create("New Game", 150, 400),
					resume = Button.create("Resume", 160, 400),
					quit = Button.create("Quit", 300, 400) }
	temp.weapons = Weapons.create(335,617)
	return temp
end

function Game:getSelectWepons()
	return self.weapons:getSelected()
end

function Game:draw()
	--draw 背景
	--love.graphics.draw(graphics["battle_bg"], 480/2, 640/2)
	--love.graphics.draw(graphics["battle_bg"], love.graphics.getWidth()/2, love.graphics.getHeight()/2)
	love.graphics.draw(graphics["battle_bg"])
	
	-- Draw the current FPS.
	if(time_UpdateCapiton <=0) then
    	love.graphics.setCaption("Towers Trap - [FPS: " .. love.timer.getFPS() .."]")
    end

	if(debug) then	
		love.graphics.setFont(font["tiny"])
		love.graphics.setColor(color["text"])	
		--love.graphics.draw("mousepoint(x: " .. self.mousepointer.x .. ",y:" .. self.mousepointer.y,100, 180)
		love.graphics.print("mousepoint(x: " .. self.mousepointer.x .. ",y:" .. self.mousepointer.y,100, 180)
		--love.graphics.draw(string.format("gridpoint(x:%d,y:%d-%d)",self.gridpointer.x,self.gridpointer.y,self.gridpointer.y * grid_col + self.gridpointer.x),100, 200)
		love.graphics.print(string.format("gridpoint(x:%d,y:%d-%d)",self.gridpointer.x,self.gridpointer.y,self.gridpointer.y * grid_col + self.gridpointer.x),100, 200)
	
		-- draw grid
		love.graphics.setLine( 1 )
	    love.graphics.setLineStyle( love.line_smooth )
		-- unit grid = 17*17
	
	    for i = 0, grid_row, 1 do	-- draw h line
	
	        love.graphics.setColor(color["grid"])
			love.graphics.line( battlearea.left, battlearea.top + i*17, battlearea.top + grid_col*17, battlearea.left + i*17 )
	        love.graphics.setColor(color["menu_text"])
			--love.graphics.draw( i, battlearea.left + 5, battlearea.top + i*17 + 10  )
			love.graphics.print( i, battlearea.left + 5, battlearea.top + i*17 + 10  )
	    end
	    for i = 0, grid_col, 1 do -- draw v line
			love.graphics.setColor(color["grid"])
			love.graphics.line( battlearea.left + i*17, battlearea.top, battlearea.left + i*17, battlearea.top + 17*grid_row)
	        love.graphics.setColor(color["menu_text"])
			--love.graphics.draw( i, battlearea.left + i*17 + 5, battlearea.top + 10  )
			love.graphics.print( i, battlearea.left + i*17 + 5, battlearea.top + 10  )
	    end  
	end
	local selectWeapon = self:getSelectWepons()
	-- draw 预备放置方框
	if (selectWeapon >=0) then
		local gx = self.gridpointer.x
		local gy = self.gridpointer.y
		local cx = battlearea.top + gx *17
		local cy = battlearea.left + gy * 17
		local i = self:getSelectWepons()
			
		love.graphics.setColor(color["grid_hover"])
		love.graphics.rectangle( love.draw_line, cx, cy , 17*2, 17*2) 
		
		-- 选择了碉堡武器
		if i >0 then
			if self.money >= tower_upgrade[i][1].buy_cost and 
			(self.maps[grid_col*gy + gx+1] == 0) and
			(self.maps[grid_col*gy + gx +2] == 0)	and
			(self.maps[grid_col*(gy+1) + gx +1] == 0) and
			(self.maps[grid_col*(gy+1) + gx+2] == 0) then
				love.graphics.setColor(color["grid_open"])
			else 
				love.graphics.setColor(color["grid_close"])
			end
			love.graphics.rectangle( love.draw_fill, cx + 1, cy + 1 , 17*2 -2, 17*2 -2)
			love.graphics.setColor(color["shadow"])
			local range = tower_upgrade[i][1].range;
			love.graphics.circle( love.draw_fill, cx + 17, cy + 17, range*7,255 )

   			-- 画选择的武器的性能

			local damage  = tower_upgrade[i][1].damage
			local buy_cost = tower_upgrade[i][1].buy_cost
			local shoot_time = tower_upgrade[i][1].shoot_time

   			love.graphics.setColor(color["text"])
			love.graphics.setFont(font["tiny"])
			love.graphics.draw(graphics.power,74,570)
			--love.graphics.draw(damage,94,570)
			love.graphics.print(damage,94,570)
			love.graphics.draw(graphics.coast,120,570)
			--love.graphics.draw(buy_cost,144,570)
			love.graphics.print(buy_cost,144,570)
			love.graphics.draw(graphics.update,74,604)
			--love.graphics.draw(shoot_time,94,604)
			love.graphics.print(shoot_time,94,604)
		end
	end
	-- draw Time
	love.graphics.setColor(color["text"])
	love.graphics.setFont(font["medium"])
	--love.graphics.draw(string.format("%d", self.time), 135, 522)
	love.graphics.print(string.format("%d", self.time), 135, 522)
	-- draw health
	--love.graphics.draw(self.health, 350, 522)
	love.graphics.print(self.health, 350, 522)
	-- draw money
	--love.graphics.draw(self.money,115,50)
	love.graphics.print(self.money,115,50)
	-- draw scope
	--love.graphics.draw(self.scope,350,50)
	love.graphics.print(self.scope,350,50)
	-- draw stage level
    if(self.stage < #self.stages) then
		--love.graphics.draw(self.stage,26,576)
		love.graphics.print(self.stage,26,576)
		
		for i = 1,5 do
		   local draw_stage = self.stage + i;
		   
		   if(draw_stage > #self.stages) then
		   	break
		   end
		    
		   local creature_number = self.stages[draw_stage].creature + 1

		   if(draw_stage <= #self.stages) then
				--local oldcolor = love.graphics.getColor()
				local r, g, b, a = love.graphics.getColor()
				love.graphics.setColorMode(love.color_modulate)
				love.graphics.setColor(255, 255, 255, 255 - 150 * i / 5)
				love.graphics.draw(graphics["creature"][creature_number],14,566 - (i-1) * 30 )
				--love.graphics.setColor(oldcolor)
				love.graphics.setColor(r, g, b, a)
				--love.graphics.setColorMode(0)
				love.graphics.setColorMode(love.color_replace)
		   end
		end
	end
	-- draw weapons
	self.weapons:draw()

	for n,e in pairs(self.enemys) do
		e:draw()
	end
    for n,b in pairs(self.ballets) do
		b:draw()
	end
	
	for o,s in pairs(self.hints) do
		s:draw()
	end
	-- draw blockhouse
	for n,bh in pairs(self.blockhouses) do
		if (bh.live == 1) then
			bh:draw()
		end
	end
	
	-- 画选择的武器的性能
	if(self.gselectedBlockhouse ~=nil) then
		local level = self.gselectedBlockhouse.level
	 	local index = self.gselectedBlockhouse.weapon
	 	local damage  = tower_upgrade[index][level].damage

	 	local damage_next = nil
	 	local shoot_time_next = nil
		if( level < 4) then
			damage_next = tower_upgrade[index][level+1].damage
			shoot_time_next = tower_upgrade[index][level+1].shoot_time
		end
		local buy_cost = tower_upgrade[index][level].buy_cost
		local shoot_time = tower_upgrade[index][level].shoot_time

		love.graphics.setColor(color["text"])
		love.graphics.setFont(font["tiny"])
		love.graphics.draw(graphics.power,74,570)
		--love.graphics.draw(damage,94,570)
		love.graphics.print(damage,94,570)

		love.graphics.draw(graphics.update,74,604)
		--love.graphics.draw(shoot_time,94,604)
		love.graphics.print(shoot_time,94,604)

		love.graphics.setColor(225,85,32)
		if(damage_next~=nil) then
			--love.graphics.draw(damage_next,144,570)
			love.graphics.print(damage_next,144,570)
		end
		if(shoot_time_next ~= nil) then
		    --love.graphics.draw(shoot_time_next,144,604)
			love.graphics.print(shoot_time_next,144,604)
		end
	end
	--画选择的碉堡边框
	if self.gselectedBlockhouse ~= nil and self.gselectedBlockhouse.live == 1 then
     	self.gselectedBlockhouse:drawselector()
	end

	if self.win ~= -999 then
		-- You won!
		if self.win > 0 then
			love.graphics.setColor(255,255,255,235-(100*(self.win/0.5)))
			love.graphics.rectangle(love.draw_fill,0,0,love.graphics.getWidth(),love.graphics.getHeight())
		else
			love.graphics.setColor(color["overlay"])
			love.graphics.rectangle(love.draw_fill,0,0,love.graphics.getWidth(),love.graphics.getHeight())
			love.graphics.setColor(color["main"])
			love.graphics.setFont(font["huge"])
			--love.graphics.drawf("CONGRATULATIONS", 0, 150, love.graphics.getWidth(), love.align_center)
			love.graphics.printf("CONGRATULATIONS", 0, 150, love.graphics.getWidth(), love.align_center)
			love.graphics.setColor(color["text"])
			love.graphics.setFont(font["default"])
			--love.graphics.drawf("You completed a level " .. self.stage .. " ,Scope is: \n" .. self.scope, 0, 200, love.graphics.getWidth(), love.align_center)
			love.graphics.printf("You completed a level " .. self.stage .. " ,Scope is: \n" .. self.scope, 0, 200, love.graphics.getWidth(), love.align_center)
			-- Buttons
			self.button["new"]:draw()
			self.button["quit"]:draw()
		end
	elseif self.pause then
		love.graphics.setColor(color["overlay"])
		love.graphics.rectangle(love.draw_fill,0,0,love.graphics.getWidth(),love.graphics.getHeight())
		love.graphics.setColor(color["main"])
		love.graphics.setFont(font["huge"])
		--love.graphics.drawf("PAUSED", 0, 150, love.graphics.getWidth(), love.align_center)
		love.graphics.printf("PAUSED", 0, 150, love.graphics.getWidth(), love.align_center)
		love.graphics.setColor(color["text"])
		love.graphics.setFont(font["default"])
		-- Buttons
		self.button["resume"]:draw()
		self.button["quit"]:draw()
	end
	
	if self.health <= 0 then
		love.graphics.setColor(color["overlay"])
		love.graphics.rectangle(love.draw_fill,0,0,love.graphics.getWidth(),love.graphics.getHeight())
		love.graphics.setColor(color["blood"])
		love.graphics.setFont(font["huge"])
		--love.graphics.drawf("YOU LOST", 0, 150, love.graphics.getWidth(), love.align_center)
		love.graphics.printf("YOU LOST", 0, 150, love.graphics.getWidth(), love.align_center)
		love.graphics.setColor(color["text"])
		love.graphics.setFont(font["default"])
		--love.graphics.drawf("You completed a level " .. self.stage .. "/80 ,Scope is: \n" .. self.scope, 0, 200, love.graphics.getWidth(), love.align_center)
		love.graphics.printf("You completed a level " .. self.stage .. "/80 ,Scope is: \n" .. self.scope, 0, 200, love.graphics.getWidth(), love.align_center)
		-- Buttons
		self.button["new"]:draw()
		self.button["quit"]:draw()
	end
end

function Game:update(dt)

	if(time_UpdateCapiton < 1) then
		time_UpdateCapiton = time_UpdateCapiton + dt
	else
	    time_UpdateCapiton = 0
	end
	if self.win == -999 and self.stage >= table.getn(self.stages) then
		self.win = 1
	end

	if self.win ~= -999 then
		if self.win > 0 then -- 胜利
			self.win = self.win - dt
		end
		self.button["new"]:update(dt)
		self.button["quit"]:update(dt)
	elseif self.pause then -- 暂停
		self.button["resume"]:update(dt)
		self.button["quit"]:update(dt)
	elseif self.health <= 0 then
		self.button["new"]:update(dt)
		self.button["quit"]:update(dt)
	else -- 游戏中
		
		local x = love.mouse.getX()
		local y = love.mouse.getY()
		self.mousepointer.x = x
		self.mousepointer.y = y
		local gx = math.floor((x - battlearea.left -17/2) / 17)
		local gy = math.floor((y - battlearea.top -17/2 ) / 17)
		
		if(gy <= 30) then
		self.gridpointer.x = gx
		self.gridpointer.y = gy
		end

		for n,bh in pairs(self.blockhouses) do
			if(bh.live == 0) then
				-- 设置地图位置为可以通过
				local gx = bh.gridpointer.x
				local gy = bh.gridpointer.y
				Map[grid_col*gy + gx ].iCanPass = true
				Map[grid_col*gy + gx + 1].iCanPass = true
				Map[grid_col*(gy+1) + gx ].iCanPass = true
				Map[grid_col*(gy+1) + gx + 1].iCanPass = true
				table.remove(self.blockhouses,n)

				self.maps[grid_col*gy + gx + 1] = 0
				self.maps[grid_col*gy + gx + 2] = 0
				self.maps[grid_col*(gy+1) + gx + 1] = 0
				self.maps[grid_col*(gy+1) + gx + 2] = 0
   			else
				bh:update(dt)
			end
		end

		for m,b in pairs(self.ballets) do
		
			if (b.live == 0) then -- 爆炸
				local weapon = b.host.blockhouse.weapon
				local level = b.host.blockhouse.level
				--pr(b,"ballet")
				local damage = tower_upgrade[weapon][level].damage
				
				if(weapon == 1) then --sniper
					local e = b.target 
					if(math.abs(e.x - b.x) < 16 and math.abs(e.y - b.y) < 16) then
						e.health = e.health - damage
						if(e.health <=0) then
							b.host.target = nil
							love.audio.play(sound["creature_die"], 1)
							self.scope = self.scope + e.award
							self.money = self.money + e.money
							table.insert(self.hints,Hint.create("fly",e.award,e.x,e.y))
						end
					end
				elseif (weapon == 2) then-- rocket
					for n,e in pairs(self.enemys) do
						if(e.number ~= 6 and math.abs(e.x - b.x) < 16 and math.abs(e.y - b.y) < 16) then
							e.health = e.health - damage
							if(e.health <=0) then
								b.host.target = nil
								love.audio.play(sound["creature_die"], 1)
								self.scope = self.scope + e.award
								self.money = self.money + e.money
								table.insert(self.hints,Hint.create("fly",e.award,e.x,e.y))
							end
						end
					end
    			elseif(weapon == 3) then --range
					local e = b.target
					if(math.abs(e.x - b.x) < 16 and math.abs(e.y - b.y) < 16) then
						e.health = e.health - damage
						if(e.health <=0) then
							b.host.target = nil
							love.audio.play(sound["creature_die"], 1)
							self.scope = self.scope + e.award
							self.money = self.money + e.money
							table.insert(self.hints,Hint.create("fly",e.award,e.x,e.y))
						end
					end
				elseif (weapon == 5) then -- air
				    local e = b.target
					if(e.number == 6 and math.abs(e.x - b.x) < 16 and math.abs(e.y - b.y) < 16) then
						e.health = e.health - damage
						if(e.health <=0) then
							b.host.target = nil
							love.audio.play(sound["creature_die"], 1)
							self.scope = self.scope + e.award
							self.money = self.money + e.money
							table.insert(self.hints,Hint.create("fly",e.award,e.x,e.y))
						end
					end
				elseif (weapon == 6) then -- earthquake
					local rangle = 6*7
					for n,e in pairs(self.enemys) do
						if(e.number ~= 6 and math.abs(e.x - b.x) < rangle and math.abs(e.y - b.y) < rangle) then
							e.health = e.health - damage
							if(e.health <=0) then
								b.host.target = nil
								love.audio.play(sound["creature_die"], 1)
								self.scope = self.scope + e.award
								self.money = self.money + e.money
								table.insert(self.hints,Hint.create("fly",e.award,e.x,e.y))
							end
						end
					end
				end  
				table.remove(self.ballets,m)
			else
				b:update(dt)
			end
		end

		self:switchStage(dt)
		
		self.weapons:update(dt)
		for n,e in pairs(self.enemys) do
			if(e.health <=0 ) then
				table.remove(self.enemys,n)
			elseif(e.pass) then
				self.health = self.health - 1
				table.remove(self.enemys,n)
			else
				e:update(dt)
			end
			
		end
		
		for o,s in pairs(self.hints) do
			if(s.delay >0) then
				s:update(dt)
			else
			    table.remove(self.hints,o)
			end
		end
	end
end

-- 切换关卡
function Game:switchStage(dt)

	if self.time <= 0 then
		
		self.stage = self.stage + 1
		self.time = self.stages[self.stage].time --时间
		-- 敌人进入场景
		if(self.stage >= 1 and self.stage <= #self.stages) then
		
			for i = 1,self.stages[self.stage].number /2 do
				local x = math.random(10,17)
				local y = math.random(0,3)
				local creature =  Creature.create(self, self.stages[self.stage].creature,x,y,true)
    			table.insert(self.enemys,creature)
			
			end
			for i = 1,self.stages[self.stage].number / 2 do
				local x = math.random(0,3)
				local y = math.random(12,20)
				local creature =  Creature.create(self, self.stages[self.stage].creature,x,y,true)
				table.insert(self.enemys,creature)
			end
			love.audio.play(sound["next_level"], 1)
		end
	end
	self.time = self.time - dt
end

function Game:IsBlocked(from)
	local isBlocked = true
	local startIndex,endIndex
	AStarInit()
	if(from == 1) then
		startIndex = 422
		endIndex = 426
	else
		startIndex = 68
		endIndex = 796
	end
	
	AStarPathFind( startIndex , endIndex )
	--AStarDrawPath(self.endIndex)

	local node = Map[endIndex]
	if(node.iParent) then
		isBlocked = false
	end

	return isBlocked
end

function Game:mousepressed(x, y, button)
	self.weapons:mousepressed(x, y, button)
	
    if(self.gselectedBlockhouse~=nil) then
        local i = self.gselectedBlockhouse:mousepressed(x, y, button)
        if(i == false) then
			return
		end
    end
	for n,bh in pairs(self.blockhouses) do
	    if(bh ~= self.gselectedBlockhouse) then
			local i = bh:mousepressed(x, y, button)
			if(i == false) then
				return
			end
		end
	end
	
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	self.mousepointer.x = x
	self.mousepointer.y = y
	local gx = math.floor((x - battlearea.left -17/2) / 17)
	local gy = math.floor((y - battlearea.top -17/2 ) / 17)
	
	-- 下一关 
	if(x > 3 and x < 50 and y > 555 and y < 590) then
	    self.time = 0
		local bonus
		if self.stages[self.stage] then
			bonus = self.stages[self.stage].number
		else
			bonus = 15
		end
	    self.scope = self.scope + bonus
		table.insert(self.hints,Hint.create("fadeout2","TIME BONUS!" .. bonus,300,550))
	end
	
	-- 按home键 
	if(x > 3 and x < 50 and y > 600 and y < 634) then
		if self.win ~= -999 or self.health <=0 then
			state = Menu.create()
		elseif self.pause then
			self.pause = false
		else
			self.pause = true
		end
	end 
	local i = self:getSelectWepons()
	if i >= 0 and self.money >= tower_upgrade[i][1].buy_cost and 
			(self.maps[grid_col*gy + gx+1] == 0) and
			(self.maps[grid_col*gy + gx +2] == 0)	and
			(self.maps[grid_col*(gy+1) + gx +1] == 0) and
			(self.maps[grid_col*(gy+1) + gx+2] == 0) then
		-- 增加一个碉堡
		Map[grid_col*gy + gx ].iCanPass = false
		Map[grid_col*gy + gx + 1].iCanPass = false
		Map[grid_col*(gy+1) + gx ].iCanPass = false
		Map[grid_col*(gy+1) + gx + 1].iCanPass = false
		
		self.maps[grid_col*gy + gx + 1] = 1
		self.maps[grid_col*gy + gx + 2] = 1
		self.maps[grid_col*(gy+1) + gx + 1] = 1
		self.maps[grid_col*(gy+1) + gx + 2] = 1
		
		if(self:IsBlocked(0) or self:IsBlocked(1)) then
			Map[grid_col*gy + gx ].iCanPass = true
			Map[grid_col*gy + gx + 1].iCanPass = true
			Map[grid_col*(gy+1) + gx ].iCanPass = true
			Map[grid_col*(gy+1) + gx + 1].iCanPass = true
			
			self.maps[grid_col*gy + gx + 1] = 0
			self.maps[grid_col*gy + gx + 2] = 0
			self.maps[grid_col*(gy+1) + gx + 1] = 0
			self.maps[grid_col*(gy+1) + gx + 2] = 0
			
			table.insert(self.hints,Hint.create("fadeout","BLOCK!",300,550))
		else
			local blockhouse = Blockhouse.create(i,self.gridpointer)
	
			self.blockhouses[20*gy + gx	] = blockhouse
			-- 设置地图位置为不可以通过

			love.audio.play(sound["create_tower"])
			self.money = self.money - tower_upgrade[i][1].buy_cost
		end
		--self.weapons:unSelected()
	end
	if self.win ~= -999 then
		if self.button["new"]:mousepressed(x, y, button) then
			state = Game.create()
		elseif self.button["quit"]:mousepressed(x, y, button) then
			state = Menu.create()
		end
	elseif self.pause then
		if self.button["resume"]:mousepressed(x, y, button) then
			self.pause = false
		elseif self.button["quit"]:mousepressed(x, y, button) then
			state = Menu.create()
		end
	elseif self.health <=0 then
		if self.button["new"]:mousepressed(x, y, button) then
			state = Game.create()
		elseif self.button["quit"]:mousepressed(x, y, button) then
			state = Menu.create()
		end
	end
end

function Game:keypressed(key)
	
	if key == love.key_escape then
		if self.win ~= -999 or self.health <=0 then
			state = Menu.create()
		elseif self.pause then
			self.pause = false
		else
			self.pause = true
		end
	end
end