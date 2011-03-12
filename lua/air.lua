-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Air = {}
Air.__index = Air

function Air.create(blockhouse)
	
 	local temp = {}
	setmetatable(temp, Air)
	temp.target = nil
	temp.shoot_time = 0
	temp.blockhouse  = blockhouse

	return temp
end

function Air:update(dt)

	if( self.shoot_time >0) then
		self.shoot_time = self.shoot_time - dt
	else
        self:FindTargetsAndFire()
	end
end

function Air:getShoot_time()
	local weapon = self.blockhouse.weapon
    local level = self.blockhouse.level
    local shoot_time = tower_upgrade[weapon][level].shoot_time
    return shoot_time / 10
end

function Air:FindTargetsAndFire()
	local weapon = self.blockhouse.weapon
    local level = self.blockhouse.level
	local range = tower_upgrade[weapon][level].range*7

	local on_shoot_bullet_count  = tower_upgrade[weapon][level].on_shoot_bullet_count

	local firecount = 0
	local aoff = 0
	--获取一个target

	for i,e in pairs(state.enemys) do
		if (e.number ==6 and firecount < on_shoot_bullet_count and
		(math.abs(e.x - self.blockhouse.x) <= range and math.abs(e.y - self.blockhouse.y) <= range)) then
            firecount = firecount + 1
			e.locked = e.locked + 1
		    love.audio.play(sound["air_fire"], 1)
			ballet = Ballet.create(4, self,self.blockhouse.x ,self.blockhouse.y ,e)
			ballet.angle = aoff
			aoff = aoff + 30
			table.insert(state.ballets , ballet)
		end
	end
	if(firecount > 0) then
		local shoot_time = self:getShoot_time()
		self.blockhouse.fireangle = 720
		self.shoot_time  = shoot_time
	end
end
