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
player = Player:new(383, 283)
xlev = 4
ylev = 1
playpushed = 0

function game.update()
	player:update()
	bump.collide()
	for i, ent in pairs(ents) do
		if ent.update then
			ent:update()
		end
	end
	playpushed = playpushed - 1
end

function bump.collision(i1, i2, dx, dy)
	if instanceOf(Pickup,i1) and instanceOf(Player,i2) then
		if i1.alpha ~= 0 then
			player.color = i1.color
			love.audio.play(ding)
		end
	elseif instanceOf(Pickup,i2) and instanceOf(Player,i1) then
		if i2.alpha ~= 0 then
			player.color = i2.color
			love.audio.play(ding)
		end
	elseif instanceOf(Bumper,i1) or instanceOf(Bumper,i2) then
		if instanceOf(Player,i1) or instanceOf(Player,i2) then
			restartLevel()
		end
		if instanceOf(Crate,i1) or instanceOf(Crate,i2) then
			if instanceOf(Crate,i1) then
				if instanceOf(BumperV,i2) then
					if dx ~= 0 then
						i1.l = i1.l + dx
						if playpushed > 0 then player.l = player.l + dx end
					else i2.v = -i2.v end
				elseif instanceOf(BumperH,i2) then
					if dy ~= 0 then
						i1.t = i1.t + dy
						if playpushed > 0 then player.t = player.t + dy end
					else i2.v = -i2.v end
				end
			elseif instanceOf(Crate,i2) then
				if instanceOf(BumperV,i1) then
					if dx ~= 0 then
						i2.l = i2.l - dx
						if playpushed > 0 then player.l = player.l - dx end
					else i1.v = -i1.v end
				elseif instanceOf(BumperH,i1) then
					if dy ~= 0 then
						i2.t = i2.t - dy
						if playpushed > 0 then player.t = player.t - dy end
					else i1.v = -i1.v end
				end
			end
		end
	elseif instanceOf(Crate,i1) and instanceOf(Player,i2) then
		if player.color == colors.red then
			i1:move(dx, dy, i2)
			playpushed = 5
		else
			player.l = player.l - dx
			player.t = player.t - dy
		end
	elseif instanceOf(Crate,i2) and instanceOf(Player, i1) then
		if player.color == colors.red then
			i2:move(-dx, -dy, i1)
			playpushed = 5
		else
			player.l = player.l + dx
			player.t = player.t + dy
		end
	elseif instanceOf(Crate,i1) or instanceOf(Crate,i2) then
		if instanceOf(Crate,i1) then
			i1:move(dx,dy,i2)
			if playpushed > 0 then
				player.l = player.l + dx
				player.t = player.t + dy
			end
		else
			i2:move(-dx,-dy,i1)
			if playpushed > 0 then
				player.l = player.l - dx
				player.t = player.t - dy
			end
		end
	elseif instanceOf(Zombie,i1) or instanceOf(Zombie,i2) then
		if instanceOf(Player,i1) or instanceOf(Player,i2) then
			restartLevel()
		end
	end
end

function loadLevel(u, v)
	ents = {}
	if u == 7 and v == 5 then
		gamestate = ending
	end
	restartx = player.l
	restarty = player.t
	bump.initialize(40)
	bump.add(player)
	restartcol = player.color
	currentMap = loader.load("Map".. u .."_".. v ..".tmx")
	currentMap("Designer").visible = false
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
	loadLevel(xlev, ylev)
end

function game.keypressed(key)
	if key == "r" then restartLevel()
	elseif key == "1" then player.color = colors.red
	elseif key == "2" then player.color = colors.yellow
	elseif key == "3" then player.color = colors.blue
	elseif key == "4" then player.color = colors.white
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