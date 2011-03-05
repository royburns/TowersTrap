

function love.load() 
    -- Includes
	--[[
	love.filesystem.require("lua/button.lua")
	love.filesystem.require("lua/resources.lua")
	love.filesystem.require("lua/states.lua")
	love.filesystem.require("lua/menu.lua")
	love.filesystem.require("lua/game.lua")
	--]]
	
	love.filesystem.require = require

	love.line_rough = "rough"
	love.line_smooth = "smooth"
	
	love.align_center = "center"
	love.align_left = "left"
	love.align_right = "right"

	love.draw_fill = "fill"
	love.draw_line = "line"
	
	--ColorMode mode
	love.color_modulate = "modulate"
	love.color_replace = "replace"
	
	--
	function love.graphics.newColor(r, g, b, a)
		--return tColor
		tRGBa = {}
		if not r or not g or not b then
			print("There is some argument pass with nil, ues the default instead.")
			tRGBa = {255, 255, 0, 125}
			return tRGBa
		end
		table.insert(tRGBa, r)
		table.insert(tRGBa, g)
		table.insert(tRGBa, b)
		if a then
			table.insert(tRGBa, a)
		end
		return tRGBa
	end
	
	--[[ 
	function love.graphics.getColor()
		tRGBa = {}
		local r, g, b, a = love.graphics.getColor()
		table.insert(tRGBa, r)
		table.insert(tRGBa, g)
		table.insert(tRGBa, b)
		if a then
			table.insert(tRGBa, a)
		end
		return tRGBa
	end
	
	function love.graphics.setColor(tRGBa)
		love.graphics.setColor(tRGBa.r, tRGBa.g, tRGBa.b, tRGBa.a)
	end
	--]] 
	
	--[[ 
	function love.graphics.setColorMode(mode)
		if mode == 0 or mode == nil then
			mode = ""
		end
		if type(mode) == "string" then
			love.graphics.setColorMode(mode)
		else
			mode = "modulate"
			love.graphics.setColorMode(mode)
		end
	end
	--]] 

	function love.audio.newMusic(file)
		return love.audio.newSource(file)
	end

	function love.audio.newSound(file)
		return love.audio.newSource(file)
	end
	
	--[[
	function love.graphics.draw(text, x, y, r, sx, sy)
		--print(type(text))
		--print(text:type())
		 
		if type(text) == "string" then
			love.graphics.print(text, x, y, r, sx, sy)
		elseif type(text) == "number" then
			love.graphics.print(""..text, x, y, r, sx, sy)
		elseif type(text) == "userdata" then
			 
			print(text)
			love.timer.sleep(100)
			text = "error string!"
			love.graphics.print(text, x, y, r, sx, sy)
			
			--love.timer.sleep(100)
			love.graphics.draw(text, x, y)
			--love.graphics.print("what's this userdata??", x, y, r, sx, sy)
		else
			love.graphics.print("what's this??", x, y, r, sx, sy)
		end
	end
	--]] 
	
	--[[test
	text = love.graphics.newImage("img/current_logo.png")
	love.graphics.draw(text)
	love.timer.sleep(10000)
	--]]

	require("lua/button.lua")
	require("lua/resources.lua")
	require("lua/states.lua")
	require("lua/menu.lua")
	require("lua/game.lua")
	
	-- Variables
	debug = false
	audio = true			-- whether audio should be on or off
	state = Menu.create()	-- current game state
	
	-- Setup
	--love.graphics.setBackgroundColor(color["background"])
	love.audio.play(music["menu"], 0)
	--love.audio.setVolume(0.3);

	-- randomize
	math.randomseed(os.time())
end

function love.draw()
	
	state:draw()
end

function love.update(dt)

	--delay(33)
	state:update(dt)
	love.timer.sleep(1)
end

function love.delay(fps)
   if (fps > 50) then
      fps = fps + (fps / 10) - 5
   end
   local toSleep = 2 / fps - love.timer.getDelta()
   if toSleep > 0 then
      love.timer.sleep(toSleep * 1000)
   end
end

function love.mousepressed(x, y, button)

	state:mousepressed(x,y,button)
end

function love.keypressed(key)
	
	if key == love.key_f4 and (love.keyboard.isDown(love.key_ralt) or love.keyboard.isDown(love.key_lalt)) then
		--love.system.exit()
		love.event.push("q")
	end
	
	state:keypressed(key)
end 
