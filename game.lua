Player = require "player"
Pickup = require "pickup"

game = {}

colors = {
	red = {155, 47, 35},
	blue = {25, 45, 95},
	yellow = {210, 184, 110},
	white = {255, 255, 255},
	black = {0, 0, 0}
}
loader.path = "map/"
tilesize = 20
player = Player:new(400, 300)
xlev = 1
ylev = 1

function game.update()
	player:update()
	bump.collide()
	for i, pickup in pairs(pickups) do
		pickup:update()
	end
end

function bump.shouldCollide(i1, i2)
	if instanceOf(Player, i1) or instanceOf(Player,i2) then
		return true
	end
end

function bump.collision(i1, i2, dx, dy)
	if instanceOf(Pickup,i1) then
		if i2.alpha ~= 0 then
			player.color = i1.color
		end
	elseif instanceOf(Pickup,i2) then
		if i2.alpha ~= 0 then
			player.color = i2.color
		end
	end
end

function loadLevel(u, v)
	bump.initialize(40)
	bump.add(player)
	currentMap = loader.load("Map".. v .."_".. u ..".tmx")
	pickups = {}
	for x = 0, 29 do
		for y = 0, 39 do
			local tile = currentMap("Main")(x, y)
			if tile ~= nil and tile.properties.pickup then
				if tile.properties.red then col = 1
				elseif tile.properties.blue then col = 2
				elseif tile.properties.yellow then col = 3 end
				table.insert(pickups, Pickup:new(x*20,y*20,col))
			end
		end
	end
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
	currentMap:draw()
	for i, pickup in pairs(pickups) do
		pickup:draw()
	end
	player:draw()
end