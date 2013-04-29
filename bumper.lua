local Bumper = class("Bumper")

function Bumper:initialize(x, y, w, h)
	self.name = "player"
	if w == 40 then
		self.l = x
		self.t = y + 5
	else
		self.l = x + 5
		self.t = y
	end
	self.w = w
	self.h = h
	bump.add(self)
	self.rx = x
	self.ry = y
	self.v = 8
	self.speed = 6
	self.color = colors.yellow
end

function Bumper:reset()
	self.l = self.rx
	self.t = self.ry
end

function Bumper:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3])
	love.graphics.rectangle("fill", self.l, self.t, self.w, self.h)
	love.graphics.setColor(255, 255, 255)
end

return Bumper