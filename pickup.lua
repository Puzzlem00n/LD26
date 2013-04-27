local Pickup = class('Pickup')

function Pickup:initialize(x, y, col)
	self.name = "pickup"
	self.l = x + 5
	self.t = y + 5
	self.w = 10
	self.h = 10
	self.alpha = 255
	bump.add(self)
	if col == 1 then
		self.color = colors.red
	elseif col == 2 then
		self.color = colors.blue
	elseif col == 3 then
		self.color = colors.yellow
	end
end

function Pickup:update()
	if player.color == self.color then
		self.alpha = 0
	else
		self.alpha = 255
	end
end

function Pickup:draw()
	love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.alpha)
	love.graphics.draw(imgPickup, self.l - 5, self.t - 5)
	love.graphics.setColor(255, 255, 255)
end

return Pickup