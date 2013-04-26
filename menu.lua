menu = {}

local keystate = 1
menustring = "Press Enter."

function menu.update()
	if love.keyboard.isDown("return") then gamestate = game end
end

function menu.keypressed(key)
	if keystate == 1 and key == "up" then keystate = keystate + 1
	elseif keystate == 2 and key == "up" then keystate = keystate + 1
	elseif keystate == 3 and key == "down" then keystate = keystate + 1
	elseif keystate == 4 and key == "down" then keystate = keystate + 1
	elseif keystate == 5 and key == "left" then keystate = keystate + 1
	elseif keystate == 6 and key == "right" then keystate = keystate + 1
	elseif keystate == 7 and key == "left" then keystate = keystate + 1
	elseif keystate == 8 and key == "right" then keystate = keystate + 1
	elseif keystate == 9 and key == "b" then keystate = keystate + 1
	elseif keystate == 10 and key == "a" then menustring = "SECRET ACHIEVED"
	else keystate = 1 end
end

function menu.draw()
	love.graphics.print(menustring, 0, 0)
end