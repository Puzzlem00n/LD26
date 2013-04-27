local Player = class("Player")

function Player:initialize(x, y)
	self.name = "player"
	self.l = x
	self.t = y
	self.w = 35
	self.h = 35
	self.vx = 0
	self.vy = 0
	self.speed = 6
	tilesize = 20
end

function Player:update()
	if love.keyboard.isDown("left") and not love.keyboard.isDown("right","up","down") then
		self.vx = -self.speed
	elseif love.keyboard.isDown("right") and not love.keyboard.isDown("up","down","left") then
		self.vx = self.speed
	elseif love.keyboard.isDown("up") and not love.keyboard.isDown("down","right","left") then
		self.vy = -self.speed
	elseif love.keyboard.isDown("down") and not love.keyboard.isDown("left","right","up") then
		self.vy = self.speed
	end
	
	if not love.keyboard.isDown("left","right") then
		self.vx = 0
	end
	if not love.keyboard.isDown("up","down") then
		self.vy = 0
	end
	
	signvx = sign(self.vx)
	if math.abs(self.vx) > tilesize then self.vx = signvx*tilesize end
	if self.vx < 0 then
		if mapCollide(self.l + self.vx, self.t + 1) or mapCollide(self.l + self.vx, self.t + self.h - 1) then
			self.l = math.floor(self.l / tilesize) * tilesize
			self.vx = 0
		end
	elseif self.vx > 0 then
		if mapCollide(self.l + self.vx + self.w, self.t + 1) or mapCollide(self.l + self.vx + self.w, self.t + self.h - 1) then
			self.l = (math.floor((self.l + self.w + self.speed) / tilesize) * tilesize) - self.w
			print(self.l)
			self.vx = 0
		end
	else
	end
	
	signvy = sign(self.vy)
	if math.abs(self.vy) > tilesize then self.vy = signvy*tilesize end
	if self.vy > 0 then
		if mapCollide(self.l + 1, self.t + self.h + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.h + self.vy) then
			self.t = (math.floor((self.t + self.h + self.speed) / tilesize) * tilesize) - self.h
			self.vy = 0
		end
	elseif self.vy < 0 then
		if mapCollide(self.l + 1, self.t + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.vy) then
			self.t = math.floor(self.t / tilesize) * tilesize 
			self.vy = 0
		end
	else
	end
	
	self.l = self.l + self.vx
	self.t = self.t + self.vy
	
	if self.l < 0 - self.w then
		xlev = xlev - 1
		loadLevel(xlev, ylev)
		self.l = love.graphics:getWidth() - self.w
	elseif self.l > love.graphics:getWidth() then
		xlev = xlev + 1
		loadLevel(xlev, ylev)
		self.l = 0
	elseif self.t < 0 - self.h then
		ylev = ylev - 1
		loadLevel(xlev, ylev)
		self.l = love.graphics:getWidth() - self.h
	elseif self.t > love.graphics:getHeight() then
		ylev = ylev + 1
		loadLevel(xlev, ylev)
		self.t = 0
	end
end

function Player:draw()
	--FIX LATER
	love.graphics.rectangle('fill', player.l, player.t, player.w, player.h)
end

return Player