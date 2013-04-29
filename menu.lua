menu = {}


function menu.update()
end

function menu.keypressed(key)
	gamestate = game
end

function menu.draw()
	love.graphics.draw(menuscreen, 0, 0)
end