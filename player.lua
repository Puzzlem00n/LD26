local Player = class('Player')

function Player:initialize(x, y)
	self.name = "player"
	self.l = x
	self.t = y
	self.w = 10
	self.h = 10
	self.vx = 0
	self.vy = 0
	self.speed = 5
end

function Player:update()
	--[[
	signvx = sign(player.vy)
	if math.abs(player.vy) < tilesize then player.vy = signvx*tilesize end
	if player.vx < 0 then
		if mapCollide(player.x + player.vx, player.y + 1) or mapCollide(player.x + player.vx, player.y + player.h - 1) then
			player.x = math.floor(player.x / tilesize) * tilesize
			player.vx = 0
		end
	elseif player.vx > 0 then
		if mapCollide(player.x + player.vx + player.w, player.y + 1) or mapCollide(player.x + player.vx + player.w, player.y + player.h - 1) then
			player.x = (math.floor((player.x + player.w + speed) / tilesize) * tilesize) - player.w
			player.vx = 0
		end
	else
	end
	
	signvy = sign(player.vy)
	if math.abs(player.vy) < tilesize then player.vy = signvy*tilesize end
	if player.vy > 0 then
		if mapCollide(player.x + 1, player.y + player.h + player.vy) or mapCollide(player.x + player.w - 1, player.y + player.h + player.vy) then
			player.y =(math.floor((player.y + player.h + player.vy) / tilesize) * tilesize) - player.h
			player.vy = 0
		end
	elseif player.vy < 0 then
		if mapCollide(player.x + 1, player.y + player.vy) or mapCollide(player.x + player.w - 1, player.y + player.vy) then
			player.y = math.floor(player.y / tilesize) * tilesize
			player.vy = 0
		end
	else
	end
	
	player.x = player.x + player.vx
	player.y = player.y + player.vy
	]]
end

return Player