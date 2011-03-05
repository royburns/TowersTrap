-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

EarthQuake = {}
EarthQuake.__index = EarthQuake

function EarthQuake.create(blockhouse)
	
	local temp = {}
	setmetatable(temp, EarthQuake)
	temp.target = nil
	temp.shoot_time = 0
	temp.blockhouse  = blockhouse

	return temp
	
end

function EarthQuake:update(dt)
	
	local weapon = self.blockhouse.weapon
    local level = self.blockhouse.level
	local range = tower_upgrade[weapon][level].range*7
	local shoot_time = tower_upgrade[weapon][level].shoot_time
	
	if(self.shoot_time >=0) then
		self.shoot_time = self.shoot_time - 10 * dt
	end
	
	if (self.target == nil) then --获取一个target
		for i,e in pairs(state.enemys) do

			if (e.hidden~=true and e.number ~=6 -- 不是飞机
			and (math.abs(e.x - self.blockhouse.x) <= range and math.abs(e.y - self.blockhouse.y) <= range) ) then
			    self.target = e
			    e.locked = e.locked + 1
			end
		end
	else
        if(self.target.health <=0 ) then -- 跟踪的目标被击毙了 
			self.target = nil
			return
		end

  		if(self.shoot_time <=0) then -- 制造地震 
   			love.audio.play(sound["earthquake_fire"], 1)
   			self.shoot_time  = shoot_time
   			self.blockhouse.earthquake_action_r = 6
   			ballet =  Ballet.create(5, self,self.blockhouse.x ,self.blockhouse.y ,self.target)
   			ballet.live = 0

   			table.insert(state.ballets , ballet)
   			-- 计算损伤 
  		end


		local e = self.target
		if(math.abs(e.x - self.blockhouse.x) > range or math.abs(e.y - self.blockhouse.y) > range) then
		    self.target = nil
		    e.locked = e.locked - 1
		end
		

	end
	
end

