-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Radar = {}
Radar.__index = Radar

function Radar.create(blockhouse)
	
 	local temp = {}
	setmetatable(temp, Radar)
	temp.target = nil
	temp.shoot_time = 0
	temp.blockhouse  = blockhouse
	temp.ballet = nil
	return temp
	
end


function Radar:update(dt)

    local weapon = self.blockhouse.weapon
    local level = self.blockhouse.level
	local range = tower_upgrade[weapon][level].range*7
	local shoot_time = tower_upgrade[weapon][level].shoot_time
	if(self.shoot_time >0) then
		self.shoot_time = self.shoot_time - 10 * dt
	end

	local foundenemyscount = 0
	for i,e in pairs(state.enemys) do

		if(e.type == 4) then
			foundenemyscount = foundenemyscount + 1
		end
		if(e.hidden ==true and math.abs(e.x - self.blockhouse.x) <= range and math.abs(e.y - self.blockhouse.y) <= range) then
      		e.hidden = false
		    e.antihidden_time = 2
		end
	end


	if(self.ballet == false and self.shoot_time <=0 and foundenemyscount > 0) then -- œ‘ æ¿◊¥Ô…®√Ë
		love.audio.play(sound["radar_fire"], 1)
		self.shoot_time = shoot_time
		ballet = Ballet.create(6, self,self.blockhouse.x ,self.blockhouse.y ,self)
   		table.insert(state.ballets , ballet)
   		self.blockhouse.sniffereangle = 360
   		self.ballet = ballet
	end



end
