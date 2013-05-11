require "requirer"
require "game"
require "menu"
require "ending"

local watch = 0
dt = 1.0 / 30
local skip = dt * 2

function love.load()
	love.mouse.setVisible(false)
	gamestate = menu
	pausedopac = 0
	love.graphics.setBackgroundColor(colors.black[1],colors.black[2],colors.black[3])
	paused = false
	love.audio.play(music.path)
end

function love.update(actualdt)
	if not paused then
		if actualdt > skip then actualdt = skip end
		watch = watch + actualdt
		while watch > dt do
			watch = watch - dt
			gamestate.update()
		end
		if love.keyboard.isDown("escape") then
			love.event.quit()
		end
	end
end

function love.draw()
	gamestate.draw()
	love.graphics.setBlendMode("multiplicative")
	love.graphics.setColor(255,255,255,200)
	love.graphics.draw(overlay, 0, 0)
	love.graphics.setBlendMode("alpha")
	love.graphics.setColor(0,0,0,pausedopac)
	love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth(), love.graphics:getHeight())
	love.graphics.setColor(255,255,255,255)
end

function love.mousepressed(x, y, button)
	if gamestate.mousepressed then
		gamestate.mousepressed(x, y, button)
	end
end

function love.mousereleased(x, y, button)
	if gamestate.mousereleased then
		gamestate.mousereleased(x, y, button)
	end
end

function love.keypressed(key, unicode)
	if gamestate.keypressed then
		gamestate.keypressed(key)
	end
end

function love.keyreleased(key)
	if gamestate.keyreleased then
		gamestate.keyreleased(key)
	end
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