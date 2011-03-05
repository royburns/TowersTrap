-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Explosion = {}
Explosion.__index = Explosion

function Explosion.create(text,x,y)
	
	local temp = {}
	setmetatable(temp, Explosion)
	temp.text = text
	temp.width = font["large"]:getWidth(text)
	temp.height = font["large"]:getHeight()
	temp.x = x - (temp.width / 2)
	temp.y = y
	temp._y = y
	temp.delay = 1
	return temp
	
end

function Explosion:draw()
	love.graphics.setFont(font.impact_1)
	--love.graphics.setColor(0,0,0,100*(self.delay/0.5))
	love.graphics.setColor(0,0,0)
	love.graphics.draw(self.text, self.x, self.y)
	love.graphics.setFont(font.impact_1)
	--love.graphics.setColor(255,255,0,100*(self.delay/0.5))
	love.graphics.setColor(255,255,0)
	love.graphics.draw(self.text, self.x+1, self.y+1)
end

function Explosion:update(dt)
	
	if(self.delay > 0) then
		self.delay = self.delay - dt
		self.y = self._y - (1 - self.delay) * 10
	end
	
end