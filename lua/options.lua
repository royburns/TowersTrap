-- Options State
-- Shows the options
Options = {}
Options.__index = Options

function Options.create()
	local temp = {}
	setmetatable(temp, Options)
	temp.button = {	on = Button.create("On", 425/2, 300),
					off = Button.create("Off", 550/2, 300),
					--five = Button.create(" 5 ", 375/2, 375),
					--six = Button.create(" 6 ", 425/2, 375),
					--seven = Button.create(" 7 ", 475/2, 375),
					--eight = Button.create(" 8 ", 525/2, 375),
					--nine = Button.create(" 9 ", 575, 375),
					back = Button.create("Back", 400/2, 550) }
	return temp
end

function Options:draw()

	
	love.graphics.draw(graphics["logo"], love.graphics.getWidth( )/2, love.graphics.getHeight( ) /2)
	
	love.graphics.setColor(color["text"])
	love.graphics.setFont(font["large"])
	love.graphics.draw("Audio:", 60, 300)
	--love.graphics.draw("Level:", 60, 375)
	
	love.graphics.setColor(color["main"])
	love.graphics.setLine(4, love.line_rough)
	
	if audio then
		love.graphics.line(400/2,305,450/2,305)
	else
		love.graphics.line(525/2,305,575/2,305)
	end
	
	--love.graphics.line((360+((size-5)*50))/2,380,(390+((size-5)*50))/2,380)
	
	for n,b in pairs(self.button) do
		b:draw()
	end

end

function Options:update(dt)
	
	for n,b in pairs(self.button) do
		b:update(dt)
	end
	
end

function Options:mousepressed(x,y,button)
	
	for n,b in pairs(self.button) do
		if b:mousepressed(x,y,button) then
			if n == "on" then
				audio = true
				love.audio.resume()
			elseif n == "off" then
				audio = false
				love.audio.pause()
			elseif n == "five" then
				size = 5
			elseif n == "six" then
				size = 6
			elseif n == "seven" then
				size = 7
			elseif n == "eight" then
				size = 8
			elseif n == "nine" then
				size = 9
			elseif n == "back" then
				state = Menu.create()
			end
		end
	end
	
end

function Options:keypressed(key)
	
	if key == love.key_escape then
		state = Menu.create()
	end
	
end