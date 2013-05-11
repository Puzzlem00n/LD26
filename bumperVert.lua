Bumper = require "bumper"
local BumperV = class("BumperV", Bumper)

function BumperV:initialize(x, y)
	Bumper.initialize(self, x, y, 30, 40)
end

function BumperV:update()
	if mapCollide(self.l, self.t + self.h + self.v) or mapCollide(self.l + self.w - 1, self.t + self.h + self.v) or mapCollide (self.l + self.w / 2, self.t + self.h + self.v) then
		self.t = (math.floor((self.t + self.h + self.speed) / tilesize) * tilesize) - self.h
		self.v = -self.v
	elseif mapCollide(self.l, self.t + self.v) or mapCollide(self.l + self.w - 1, self.t + self.v) or mapCollide (self.l + self.w / 2, self.t + self.v) then
		self.t = math.floor(self.t / tilesize) * tilesize
		self.v = -self.v
	end
	
	self.t = self.t + self.v
end

function BumperV:draw()
	Bumper.draw(self)
end

return BumperV