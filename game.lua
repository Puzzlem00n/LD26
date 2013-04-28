Player = require "player"
Pickup = require "pickup"
BumperH = require "bumperHoriz"
BumperV = require "bumperVert"
Crate = require "crate"
Zombie = require "zombie"

game = {}

colors = {
	red = {155, 47, 35},
	blue = {25, 45, 95},
	yellow = {210, 184, 110},
	white = {230, 225, 206},
	black = {16, 15, 21}
}
loader.path = "map/"
tilesize = 20
player = Player:new(443, 303)
xlev = 1
ylev = 1

function game.update()
	player:update()
	bump.collide()
	for i, ent in pairs(ents) do
		if ent.update then
			ent:update()
		end
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
	elseif instanceOf(Bumper,i1) or instanceOf(Bumper,i2) then
		if instanceOf(Player,i1) or instanceOf(Player,i2) then
			restartLevel()
		end
		if instanceOf(Crate,i1) then
			i2.v = -i2.v
		elseif instanceOf(Crate,i2) then
			i1.v = -i1.v
		end
	elseif instanceOf(Crate,i1) and instanceOf(Player,i2) then
		if player.color == colors.red then
			i1:move(dx, dy, i2)
		else
			player.l = player.l - dx
			player.t = player.t - dy
		end
	elseif instanceOf(Crate,i2) and instanceOf (Player, i1) then
		if player.color == colors.red then
			i2:move(-dx, -dy, i1)
		else
			player.l = player.l + dx
			player.t = player.t + dy
		end
	elseif instanceOf(Crate,i1) or instanceOf(Crate,i2) then
		if instanceOf(Crate,i1) then i1:move(dx,dy,i2)
		else i2:move(-dx,-dy,i1) end
	elseif instanceOf(Zombie,i1) or instanceOf(Zombie,i2) then
		if instanceOf(Player,i1) or instanceOf(Player,i2) then
			restartLevel()
		end
	end
end

function loadLevel(u, v)
	bump.initialize(40)
	bump.add(player)
	restartcol = player.color
	currentMap = loader.load("Map".. v .."_".. u ..".tmx")
	currentMap("Designer").visible = false
	ents = {}
	for y = 0, 29 do
		for x = 0, 39 do
			local tile = currentMap("Designer")(x, y)
			if tile ~= nil then
				if tile.properties.pickup then
					if tile.properties.red then col = 1 end
					if tile.properties.blue then col = 2 end
					if tile.properties.yellow then col = 3 end
					table.insert(ents, Pickup:new(x*20,y*20,col))
				elseif tile.properties.hbumper then
					table.insert(ents, BumperH:new(x*20,y*20))
				elseif tile.properties.vbumper then
					table.insert(ents, BumperV:new(x*20,y*20))
				elseif tile.properties.crate then
					table.insert(ents, Crate:new(x*20,y*20))
				elseif tile.properties.zombie then
					table.insert(ents, Zombie:new(x*20,y*20))
				elseif tile.properties.player then
					restartx = x*20 + 3
					restarty = y*20 + 3
				end
			end
		end
	end
end

loadLevel(xlev,ylev)

function restartLevel()
	player.l = restartx
	player.t = restarty
	player.color = restartcol
	for i, ent in pairs(ents) do
		if ent.reset then
			ent:reset()
		end
	end
end

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
	for i, ent in pairs(ents) do
		ent:draw()
	end
	player:draw()
end