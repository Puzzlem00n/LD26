local Crate = class("Crate")

function Crate:initialize(x, y, rx, ry)
	self.name = "crate"
	self.l = x
	self.t = y
	self.w = 40
	self.h = 40
	bump.add(self)
	self.rl = x
	self.rt = y
	self.color = colors.red
end

function Crate:move(dx, dy, other)
	self.dx, self.dy = dx, dy
	signvx = sign(self.dx)
	if math.abs(self.dx) > tilesize then self.dx = signvx*tilesize end
	if self.dx < 0 then
		if mapCollide(self.l + self.dx, self.t + 1) or mapCollide(self.l + self.dx, self.t + self.h - 1) then
			self.l = math.floor(self.l / tilesize) * tilesize
			self.dx = 0
		end
	elseif self.dx > 0 then
		if mapCollide(self.l + self.dx + self.w, self.t + 1) or mapCollide(self.l + self.dx + self.w, self.t + self.h - 1) then
			self.l = (math.floor((self.l + self.w + self.dx) / tilesize) * tilesize) - self.w
			self.dx = 0
		end
	end
	
	signvy = sign(self.dy)
	if math.abs(self.dy) > tilesize then self.dy = signvy*tilesize end
	if self.dy > 0 then
		if mapCollide(self.l + 1, self.t + self.h + self.dy) or mapCollide(self.l + self.w - 1, self.t + self.h + self.dy) then
			self.t = (math.floor((self.t + self.h + self.dy) / tilesize) * tilesize) - self.h
			self.dy = 0
		end
	elseif self.dy < 0 then
		if mapCollide(self.l + 1, self.t + self.dy) or mapCollide(self.l + self.w - 1, self.t + self.dy) then
			self.t = math.floor(self.t / tilesize) * tilesize
			self.dy = 0
		end
	end
		
	if self.dx == 0 and dx ~= 0 then
		other.l = other.l - dx
	end
	if self.dy == 0 and dy ~= 0 then
		other.t = other.t - dy
	end
	
	self.l = self.l + self.dx
	self.t = self.t + self.dy
end

function Crate:reset()
	self.l = self.rl
	self.t = self.rt
end

function Crate:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])
	love.graphics.rectangle("fill", self.l, self.t, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

return Crate