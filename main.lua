require "requirer"
require "game"
require "menu"

local watch = 0
dt = 1.0 / 30
local skip = dt * 2

function love.load()
	gamestate = menu
	pausedopac = 0
	love.graphics.setBackgroundColor(colors.black[1],colors.black[2],colors.black[3])
	paused = false
end

function love.update(actualdt)
	if not paused then
		if actualdt > skip then actualdt = skip end
		watch = watch + actualdt
		while watch > dt do
			watch = watch - dt
			gamestate.update()
		end
		arc.check_keys(dt)
		--loveframes.update(dt)
		if love.keyboard.isDown("escape") then
			love.event.quit()
		end
	end
end

function love.draw()
	gamestate.draw()
	--loveframes.draw()
	arc.clear_key()
	love.graphics.setColor(0,0,0,pausedopac)
	love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth(), love.graphics:getHeight())
	love.graphics.setColor(255,255,255,255)
end

function love.mousepressed(x, y, button)
	if gamestate.mousepressed then
		gamestate.mousepressed(x, y, button)
	end
	--loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	if gamestate.mousereleased then
		gamestate.mousereleased(x, y, button)
	end
	--loveframes.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	if gamestate.keypressed then
		gamestate.keypressed(key)
	end
	--loveframes.keypressed(key, unicode)
	arc.set_key(k)
end

function love.keyreleased(key)
	if gamestate.keyreleased then
		gamestate.keyreleased(key)
	end
	--loveframes.keyreleased(key)
end

function love.focus(f)
  if not f then
    pausedopac = 170
	love.audio.pause()
	paused = true
  else
    pausedopac = 0
	love.audio.resume()
	paused = false
  end
end

function sign(x)
	return x < 0 and -1 or (x > 0 and 1 or 0)
end