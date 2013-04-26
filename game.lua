game = {}

--[[loader.path = "maps/"
map = loader.load "mapfile.tmx"
layer = map.tl("Main")]]

function game.update()
end

--[[
function mapCollide(x, y)
	local checkMap = layer(math.floor(x/player.w) + 1, math.floor(y/player.h) + 1)
	if checkMap.properties.solid then
		return true
	end
end
]]

function game.draw()
	love.graphics.print("Game", 0, 0)
end