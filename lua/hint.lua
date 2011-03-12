-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Hint = {}
Hint.__index = Hint

function Hint.create(type,text,x,y)
	
	local temp = {}
	setmetatable(temp, Hint)
	temp.text = text
	temp.width = font["large"]:getWidth(text)
	temp.height = font["large"]:getHeight()
	temp.x = x - (temp.width / 2)
	temp.y = y - (temp.height / 2)
	temp._x = x
	temp._y = y
	temp.ori_y = y
	temp.type = type
	temp.alpha = 255
	temp._dt = 0
	if(type == "fly") then
		temp.delay = 1
	elseif (type == "fadeout" or type =="fadeout2") then
		temp.delay = 3
	end
	return temp
end

function Hint:draw()
	if(self.type == "fly") then
		love.graphics.setFont(font.impact_1)
		love.graphics.setColor(0, 0, 0)
		love.graphics.print(self.text, self.x, self.y)
		love.graphics.setColor(255, 255, 0, self.alpha)
		love.graphics.print(self.text, self.x+1, self.y+1)
	elseif(self.type == "fadeout") then
		love.graphics.setFont(font.impact_0)
    	love.graphics.setColor(229,127,211, self.alpha)
		love.graphics.rectangle( love.draw_fill, self._x, self._y, 173, 43)
		love.graphics.setColor(0,0,0, self.alpha)
		love.graphics.printf(self.text, self._x, self._y + self.height, 173, love.align_center)
	elseif(self.type == "fadeout2") then
	    love.graphics.setFont(font.impact_1)
		love.graphics.setColor(200, 210, 187, self.alpha)
		love.graphics.rectangle(love.draw_fill, self._x, self._y , 173, 43)
		love.graphics.setColor(0, 0, 0, self.alpha)
		love.graphics.printf(self.text, self._x, self._y + 30, 173, love.align_center)
	end
end

function Hint:update(dt)
	
	if(self.delay > 0) then
		if(self.type == "fly") then
			self.delay = self.delay - dt
			self.y = self.ori_y - (1 - self.delay) * 10
		elseif(self.type == "fadeout" or self.type == "fadeout2") then
			self.delay = self.delay - dt
			self._dt = self._dt + dt
			self.alpha = 255 - self._dt * 85
		end
	else
		--self = nil
	end
end