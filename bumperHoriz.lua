Bumper = require "bumper"
local BumperH = class("BumperH", Bumper)

function BumperH:initialize(x, y)
	Bumper.initialize(self, x, y, 40, 30)
end

function BumperH:update()
	if mapCollide(self.l + self.v, self.t) or mapCollide(self.l + self.v, self.t + self.h - 1) or mapCollide (self.l + self.v, self.t + self.h / 2) then
		self.l = math.floor(self.l / tilesize) * tilesize
		self.v = -self.v
	elseif mapCollide(self.l + self.v + self.w, self.t) or mapCollide(self.l + self.v + self.w, self.t + self.h - 1) or mapCollide (self.l + self.v + self.w, self.t + self.h / 2) then
		self.l = (math.floor((self.l + self.w + self.speed) / tilesize) * tilesize) - self.w
		self.v = -self.v
	end
	
	self.l = self.l + self.v
end

function BumperH:draw()
	Bumper.draw(self)
end

return BumperH