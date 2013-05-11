ending = {}

box = {}
box.l = 0
box.t = 160
box.endtimer = 0
tween(8, music, {volume = 0})
tween(5, box, {l = 400, t = 450})
tween(8, box, {endtimer = 255})

function ending.update()
	
	tween.update(dt)
	if box.endtimer == 255 then
		love.event.quit()
	end
	music.path:setVolume(music.volume)
end

function ending.draw()
	love.graphics.draw(painting, 0, 0)
	love.graphics.setColor(25, 45, 95)
	love.graphics.rectangle("fill", box.l, box.t, 34, 34)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(paintingbot, 0, 0)
	love.graphics.setColor(0, 0, 0, box.endtimer)
	love.graphics.rectangle("fill", 0, 0, love.graphics:getWidth(), love.graphics:getHeight())
	love.graphics.setColor(255, 255, 255, 255)
end