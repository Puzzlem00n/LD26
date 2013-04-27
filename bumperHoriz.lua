Bumper = require "bumper"
local BumperH = class("BumperH", Bumper)

function BumperH:initialize(x, y)
	Bumper.initialize(self, x, y, 40, 30)
end

function BumperH:update()
	if self.v < 0 then
		if mapCollide(self.l + self.v, self.t + 1) or mapCollide(self.l + self.v, self.t + self.h - 1) then
			self.l = math.floor(self.l / tilesize) * tilesize
			self.v = -self.v
		end
	elseif self.v > 0 then
		if mapCollide(self.l + self.v + self.w, self.t + 1) or mapCollide(self.l + self.v + self.w, self.t + self.h - 1) then
			self.l = (math.floor((self.l + self.w + self.speed) / tilesize) * tilesize) - self.w
			self.v = -self.v
		end
	end
	
	self.l = self.l + self.v
end

function BumperH:draw()
	Bumper.draw(self)
end

return BumperH