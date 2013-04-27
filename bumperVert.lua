Bumper = require "bumper"
local BumperV = class("BumperV", Bumper)

function BumperV:initialize(x, y)
	Bumper.initialize(self, x, y, 30, 40)
end

function BumperV:update()
	if self.v < 0 then
		if mapCollide(self.l + self.v, self.t + 1) or mapCollide(self.l + self.v, self.t + self.h - 1) then
			self.l = math.floor(self.l / tilesize) * tilesize
			self.v = -self.v
		end
	elseif self.v > 0 then
		if mapCollide(self.l + self.v + self.h, self.t + 1) or mapCollide(self.l + self.v + self.h, self.t + self.h - 1) then
			self.l = (math.floor((self.l + self.h + self.speed) / tilesize) * tilesize) - self.h
			self.v = -self.v
		end
	end
	
	self.t = self.t + self.v
end

function BumperV:draw()
	Bumper.draw(self)
end

return BumperV