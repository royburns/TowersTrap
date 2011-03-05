function load() 
    -- Includes
	love.filesystem.require("lua/button.lua")
	love.filesystem.require("lua/resources.lua")
	love.filesystem.require("lua/states.lua")
	love.filesystem.require("lua/menu.lua")
	love.filesystem.require("lua/game.lua")
	
	
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
function draw()
	
	state:draw()

end

function update(dt)

	--delay(33)
	state:update(dt)
	love.timer.sleep(1)

end

function delay(fps)
   if (fps > 50) then
      fps = fps + (fps / 10) - 5
   end
   local toSleep = 2 / fps - love.timer.getDelta()
   if toSleep > 0 then
      love.timer.sleep(toSleep * 1000)
   end
end

function mousepressed(x, y, button)

	state:mousepressed(x,y,button)

end

function keypressed(key)
	
	if key == love.key_f4 and (love.keyboard.isDown(love.key_ralt) or love.keyboard.isDown(love.key_lalt)) then
		love.system.exit()
	end
	
	state:keypressed(key)

end 
