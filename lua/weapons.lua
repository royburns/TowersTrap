-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- Handles buttons and such.
-----------------------

Weapons = {}
Weapons.__index = Weapons

function Weapons.create(x,y)
	
	local temp = {}
	setmetatable(temp, Weapons)
	temp.hover = false -- whether the mouse is hovering over the button
	temp.click = false -- whether the mouse has been clicked on the button
	temp.name = "" -- the text in the button
	temp.width = 40*7
	temp.height = 40
	temp.selected = -1
	temp.x = x
	temp.y = y
	temp._x = x - 40*7 /2
	temp._y = y - (40 /2)
	return temp
	
end
function Weapons:getSelected()
	return self.selected;
end
function Weapons:draw()
	if not self.hover then
		love.graphics.setColor(color["menu_bg"])
		love.graphics.setLine(1)
		love.graphics.rectangle( love.draw_fill, self._x, self._y , self.width, self.height) 
		if(debug) then
			love.graphics.draw("weapons leave", 100, 120) 
		end
	else
		if(debug) then
		love.graphics.setColor(color["menu_bg"])
		love.graphics.draw("weapons hover", 100, 120) 
		end
	end
	love.graphics.draw(graphics["weapons"], self.x , self.y)
	if(debug) then
		love.graphics.setColor(color["menu_bg"])
		love.graphics.draw("weapons selected: " .. self.selected, 100, 100) 
	end
	if self.selected > 0 then
		love.graphics.setColor(color["white"])
		--love.graphics.setFont(font["large"])
		love.graphics.setFont(font["impact"])
		if self.selected == 1 then
			love.graphics.draw("SNIPER",197,589)
		elseif self.selected == 2 then
			love.graphics.draw("ROCKET LUNCHER",197,589)
		elseif self.selected == 3 then
			love.graphics.draw("CANNON",197,589)
		elseif self.selected == 4 then
			love.graphics.draw("SHOCK",197,589)
		elseif self.selected == 5 then
			love.graphics.draw("AIR",197,589)
		elseif self.selected == 6 then
			love.graphics.draw("EARTHQUAKE",197,589)
		elseif self.selected == 7 then
			love.graphics.draw("RADAR",197,589)
		end
		
		love.graphics.setColor(color["obj_selected"])
		love.graphics.setLine(2)
		love.graphics.rectangle( love.draw_line, self._x  + (self.selected - 1) * 40, self._y , 40, 40)
	end	
end

function Weapons:update(dt)
	
	self.hover = false
	
	local x = love.mouse.getX()
	local y = love.mouse.getY()
	
	if x > self._x
		and x < self._x + self.width
		and y > self._y
		and y < self._y + self.height then
		self.hover = true
	end
	
end

function Weapons:mousepressed(x, y, button)
	
	if self.hover then
		self.selected = math.floor((x - self._x) / 40) + 1
		if(self.selected > 7) then
		    self.selected = 7
		end
		state.gselectedBlockhouse = nil
		if audio then
			love.audio.play(sound["click"])
		end
		return true
	end
	
	return false
	
end

function Weapons:unSelected()
  self.selected = -1
end
