local Zombie = class("Zombie")

function Zombie:initialize(x, y)
	self.name = "zombie"
	self.l = x - 6
	self.t = y - 6
	self.w = 32
	self.h = 32
	bump.add(self)
	self.xSpeed = 0
	self.ySpeed = 0
	self.maxSpeed = 8
	self.vx = 0
	self.vy = 0
	self.rl = x
	self.rt = y
	self.xDir = 0
	self.yDir = 0
	self.accel = 5.0 / 30
	self.color = colors.blue
	framecount = 0
end

function Zombie:update()
	local ox = player.l - self.l
	local oy = player.t - self.t
	local totalDist = math.sqrt(ox^2 + oy^2)
	self.xDir = ox/totalDist
	self.yDir = oy/totalDist

	if math.abs(self.xSpeed) > self.maxSpeed then
		self.xSpeed = self.maxSpeed
	else
		if player.l ~= self.l then
			self.xSpeed = self.xSpeed + self.accel
		else
			self.xSpeed = 0
		end
	end
	self.vx = self.xSpeed * self.xDir
	if player.color == colors.blue then self.vx = -self.vx end
	if self.vx < 0 then
		if mapCollide(self.l + self.vx, self.t + 1) or mapCollide(self.l + self.vx, self.t + self.h - 1) then
			self.l = math.floor(self.l / tilesize) * tilesize
			self.vx = 0
			self.xSpeed = 0
		end
	elseif self.vx > 0 then
		if mapCollide(self.l + self.vx + self.w, self.t + 1) or mapCollide(self.l + self.vx + self.w, self.t + self.h - 1) then
			self.l = (math.floor((self.l + self.w + self.vx) / tilesize) * tilesize) - self.w
			self.vx = 0
			self.xSpeed = 0
		end
	else
	end

	if math.abs(self.ySpeed) > self.maxSpeed then
		self.ySpeed = self.maxSpeed
	else
		if player.t ~= self.t then
			self.ySpeed = self.ySpeed + self.accel
		else
			self.ySpeed = 0
		end
	end
	self.vy = self.ySpeed * self.yDir
	if player.color == colors.blue then self.vy = -self.vy end
	if self.vy > 0 then
		if mapCollide(self.l + 1, self.t + self.h + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.h + self.vy) then
			self.t = (math.floor((self.t + self.h + self.vy) / tilesize) * tilesize) - self.h
			self.vy = 0
			self.ySpeed = 0
		end
	elseif self.vy < 0 then
		if mapCollide(self.l + 1, self.t + self.vy) or mapCollide(self.l + self.w - 1, self.t + self.vy) then
			self.t = math.floor(self.t / tilesize) * tilesize
			self.vy = 0
			self.ySpeed = 0
		end
	else
	end

	self.l = self.l + self.vx
	self.t = self.t + self.vy
end

function Zombie:reset()
	self.l = self.rl
	self.t = self.rt
end

function Zombie:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])
	love.graphics.rectangle("fill", self.l, self.t, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

return Zombie