-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Ballet = {}
Ballet.__index = Ballet

function Ballet.create(type,host,x,y,target)
	
	local temp = {}
	setmetatable(temp, Ballet)
	temp.targetX = target.x
	temp.targetY = target.y
	temp.x = x
	temp.y = y
	temp.target = target
	temp.angle = 0
	temp.off_angle = 0
	temp.range_off = 0
	temp.from = 1
	temp.live = 1
	temp.time = 0
	temp.host = host --子弹的宿主
	temp.type = type -- 0 子弹,1 火箭，2 加农炮弹  3 减速弹 4 地对空导弹  5 地震 6 反隐形探测 
	return temp
end

function Ballet:draw()
	
	if self.type == 0 then
		--love.graphics.draw(graphics.rocket_fire, self.x, self.y)
		love.graphics.setColor(color.black)
		love.graphics.circle(love.draw_fill, self.x, self.y, 2, 255) 
	elseif self.type == 1 then --rocket
		love.graphics.draw(graphics.rocket_fire, self.x, self.y, self.angle + 90)
	elseif self.type == 2 then -- cannon
	    love.graphics.draw(graphics.canon_fire, self.x, self.y, self.angle + 90)
	elseif self.type == 3 then -- slowdown
	    love.graphics.draw(graphics.shock_fire, self.x, self.y, self.angle + self.x + self.y)
	elseif self.type == 4 then --aim
		love.graphics.draw(graphics.sa12_fire, self.x, self.y, self.angle)
	elseif self.type == 6 then --radar
		love.graphics.setColor(182, 204, 87)
		love.graphics.setLine(1)
		for i = 3,self.off_angle,3 do
			love.graphics.circle(love.draw_line, self.x, self.y, i , 255)
		end
	end
end

function Ballet:update(dt)
	
	self.time = self.time + dt

	--子弹移动
	--pr(b,"ballet")
	if self.type == 1 then -- rocket
	    self:rocketMove(dt)
	elseif self.type ==4 then --aim
	    self:aimTraceMove(dt)
    elseif self.type ==6 then -- radar
        self:radarMove(dt)
	else
        self:gunTraceMove(dt)
	end
end

function Ballet:radarMove(dt)
    local weapon = self.host.blockhouse.weapon
	local level = self.host.blockhouse.level
	local speed = dt * tower_upgrade[weapon][level].bullet_speed * 10
	local range = tower_upgrade[weapon][level].range
	self.range_off = self.range_off + range * dt / 2
	if(self.range_off >= range) then
	    self = nil
	end
end

function Ballet:rocketMove(dt)

	local weapon = self.host.blockhouse.weapon
	local level = self.host.blockhouse.level
	local speed = dt * tower_upgrade[weapon][level].bullet_speed * 10
	local range = tower_upgrade[weapon][level].range
	local dx = self.targetX - self.x
	local dy = self.targetY - self.y
	local angle = (270 + math.atan2(dy, dx)*180/math.pi)%360

	if(self.off_angle ~= angle) then
		self.off_angle = angle
		return
	end
	if(self.from == 0) then
		self.angle = self.off_angle + 90
	else
		self.angle = self.off_angle - 90 * 3
	end


	if(self.time < range*7 / speed) then --修正轨迹
		self.targetX = self.target.x
		self.targetY = self.target.y
	end

	if(math.abs(dx)>speed or math.abs(dy)>speed) then
		self.x = self.x - speed*math.sin(angle*math.pi/180)
		self.y = self.y + speed*math.cos(angle*math.pi/180)
	else
		self.live = 0 --超过射程
	end
	if self.target.x - self.x < 8 and self.target.y - self.y < 8 then
	    self.live = 0 -- 命中目标
	end
end

function Ballet:gunTraceMove(dt)

	local weapon = self.host.blockhouse.weapon
	local level = self.host.blockhouse.level
    local speed = dt * tower_upgrade[weapon][level].bullet_speed * 10
    local dx = self.targetX - self.x
	local dy = self.targetY - self.y
	local angle = (270 + math.atan2(dy, dx)*180/math.pi)%360
	
	if(math.abs(dx)>speed or math.abs(dy)>speed) then
		self.x = self.x - speed*math.sin(angle*math.pi/180)
		self.y = self.y + speed*math.cos(angle*math.pi/180)
	else
		self.live = 0 --超过射程
	end
	if self.target.x - self.x < 8 and self.target.y - self.y < 8 then
	    self.live = 0 -- 命中目标
	    self.target.slowly = true
	    self.target.slowly_time = 60
	end
end

function Ballet:aimTraceMove(dt)
	local weapon = self.host.blockhouse.weapon
	local level = self.host.blockhouse.level
	local speed = dt * tower_upgrade[weapon][level].bullet_speed * 10
	
	local dx = self.x - self.target.x
	local dy = self.y - self.target.y

	--//角速度
	local omega = 4
--	//目标与y轴的夹角
	local angle = ( 270 + math.atan2(dy, dx)*180/math.pi) % 360
--	//目标与导弹的夹角
	local crtangle = (angle - self.angle + 360) % 360
--	//判断导弹旋转方向
	local dir =  ((crtangle<=180) and 1) or -1
	self.angle = ((crtangle < 180 and crtangle > omega or crtangle > 180 and 360 - crtangle > omega) and self.angle + omega*dir) or angle
--	//移动导弹
 	if(self.time < 2.3) then
		self.x = self.x + speed * math.sin(self.angle * math.pi/180)
		self.y = self.y - speed * math.cos(self.angle * math.pi/180)
	else
	    self.live = 0 --超过射程
	end
	
	if self.target.x - self.x < 8 and self.target.y - self.y < 8 then
	    self.live = 0 -- 命中目标
	end
end