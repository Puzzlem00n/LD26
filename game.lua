Player = require "player"

game = {}

loader.path = "map/"
map = loader.load "Map.tmx"
layer = map("Main")
player = Player:new(400, 300)

function game.update()
	player:update()
end

function mapCollide(x, y)
	local checkMap = layer(math.floor(x/tilesize), math.floor(y/tilesize))
	if checkMap ~= nil then
		if checkMap.properties.solid then
			return true
		end
	end
end

function game.draw()
	player.draw()
	map:draw()
end