-- Instructions State
-- Shows the instructions

Instructions = {}
Instructions.__index = Instructions

function Instructions.create()
	local temp = {}
	setmetatable(temp, Instructions)
	temp.button = {	back = Button.create("Back", love.graphics.getWidth( ) /2, 550) }
	return temp
end

function Instructions:draw()

	love.graphics.draw(graphics["logo"], love.graphics.getWidth( ) /2, love.graphics.getHeight( )/2)
	love.graphics.setColor(color["menu_border"])
	love.graphics.setLine(4,love.line_rough)
	love.graphics.rectangle( love.draw_line, 100, 0, love.graphics.getWidth( ) -200,  love.graphics.getHeight( ) ) 
	love.graphics.setColor(color["menu_bg"])
	love.graphics.setLine(1)
	love.graphics.rectangle( love.draw_fill, 102, 2, love.graphics.getWidth( ) -204,  love.graphics.getHeight( )-4 ) 	
	love.graphics.setColor(color["menu_text"])
	love.graphics.setFont(font["intruduc"])
	intruducStr = [[In Towers Trap you protect the front line from many intruders of your land and you should give everything from yourself to stop them passing through the barricade. As many intrusive fellows you omit as many positions you loose, until you get ran over from the crowd of invaders. To your regret, the intruders are so many that your fate seems to be doomed, you will lose the battle... or probably win?! 
	Show us what you are made of and prove that you are the best strategist from all, by not letting any intruder fellow to pass by you trap...
	The rules are simple - no one intruder should exit from you back door. You have limit of 50 lives (omitted intruders), and be careful that you can't get them back. There is 8 different species of intruders and everyone of them has special abilities and power. To stop the intrusive fellows to pass by you have 7 different kinds of towers with various ways to affect the intruders and destroy them. However you should arrange them in the most appropriate way to increase their path and meantime to damage them most. More details about the intruders are explained bellow. Towers Trap has 3 difficulty levels, plus one experimental level, where you can test different strategies without warring about the price of the towers
]]
	love.graphics.setColor(color["menu_border"])
	love.graphics.printf(intruducStr, 101, 31, love.graphics.getWidth( )-200, love.align_center)
	love.graphics.setColor(color["menu_text"])
	love.graphics.printf(intruducStr, 100, 30, love.graphics.getWidth( )-200, love.align_center)
	
	for n,b in pairs(self.button) do
		b:draw()
	end
end

function Instructions:update(dt)
	
	for n,b in pairs(self.button) do
		b:update(dt)
	end
end

function Instructions:mousepressed(x,y,button)
	
	for n,b in pairs(self.button) do
		if b:mousepressed(x,y,button) then
			if n == "back" then
				state = Menu.create()
			end
		end
	end
end

function Instructions:keypressed(key)
	
	if key == love.key_escape then
		state = Menu.create()
	end
end