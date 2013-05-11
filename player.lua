local Player = class("Player")

function Player:initialize(x, y)
	self.name = "player"
	self.l = x
	self.t = y
	self.w = 34
	self.h = 34
	self.vx = 0
	self.vy = 0
	self.speed = 6
	self.color = colors.white
end

function Player:update()
	if love.keyboard.isDown("left") then
		self.vx = -self.speed
	end
	if love.keyboard.isDown("right") then
		self.vx = self.speed
	end
	if love.keyboard.isDown("up") then
		self.vy = -self.speed
	end
	if love.keyboard.isDown("down") then
		self.vy = self.speed
	end
	
	if self.vx ~= 0 and self.vy ~= 0 then
		self.vx = (self.vx * math.sqrt(2))/2
		self.vy = (self.vy * math.sqrt(2))/2
	end
	
	if not love.keyboard.isDown("left","right") then
		self.vx = 0
	end
	if not love.keyboard.isDown("up","down") then
		self.vy = 0
	end
	
	signvx = sign(self.vx)
	if math.abs(self.vx) > tilesize then self.vx = signvx*tilesize end
	if mapCollide(self.l + self.vx, self.t) or mapCollide(self.l + self.vx, self.t + self.h - 1) or mapCollide (self.l + self.vx, self.t + self.h / 2) then
		self.l = math.floor(self.l / tilesize) * tilesize
		self.vx = 0
		print("LEFT!")
	elseif mapCollide(self.l + self.vx + self.w, self.t) or mapCollide(self.l + self.vx + self.w, self.t + self.h - 1) or mapCollide (self.l + self.vx + self.w, self.t + self.h / 2) then
		self.l = (math.floor((self.l + self.w + self.speed) / tilesize) * tilesize) - self.w
		self.vx = 0
		print("RIGHT!")
	end
	
	signvy = sign(self.vy)
	if math.abs(self.vy) > tilesize then self.vy = signvy*tilesize end
	if mapCollide(self.l, self.t + self.h + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.h + self.vy) or mapCollide (self.l + self.w / 2, self.t + self.h + self.vy) then
		self.t = (math.floor((self.t + self.h + self.speed) / tilesize) * tilesize) - self.h
		self.vy = 0
		print("DOWN!")
	elseif mapCollide(self.l, self.t + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.vy) or mapCollide (self.l + self.w / 2, self.t + self.vy) then
		self.t = math.floor(self.t / tilesize) * tilesize
		self.vy = 0
		print("UP!")
	end
	
	self.l = self.l + self.vx
	self.t = self.t + self.vy
	
	if self.color == colors.yellow then
		self.speed = 12
	else
		self.speed = 6
	end
	
	if self.l < 0 - self.w then
		xlev = xlev - 1
		self.l = love.graphics:getWidth() - self.w
		loadLevel(xlev, ylev)
	elseif self.l > love.graphics:getWidth() then
		xlev = xlev + 1
		self.l = 0
		loadLevel(xlev, ylev)
	elseif self.t < 0 - self.h then
		ylev = ylev - 1
		self.t = love.graphics:getHeight() - self.h
		loadLevel(xlev, ylev)
	elseif self.t > love.graphics:getHeight() then
		ylev = ylev + 1
		self.t = 0
		loadLevel(xlev, ylev)
	end
end

function Player:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])
	love.graphics.rectangle('fill', self.l, self.t, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

return Player