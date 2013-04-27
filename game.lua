Player = require "player"

game = {}

loader.path = "map/"
player = Player:new(400, 300)
xlev = 1
ylev = 1

function game.update()
	player:update()
end

function loadLevel(u, v)
	currentMap = loader.load("Map".. v .."_".. u ..".tmx")
end

loadLevel(xlev,ylev)

function mapCollide(x, y)
	local checkMap = currentMap("Main")(math.floor(x/tilesize), math.floor(y/tilesize))
	if checkMap ~= nil then
		if checkMap.properties.solid then
			return true
		end
	end
end

function game.draw()
	player.draw()
	currentMap:draw()
end