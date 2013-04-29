loader = require "AdvTiledLoader.Loader"
bump = require "lib.bump"
tween = require "lib.tween"
require "lib.middleclass"

music = {volume = 1, path = love.audio.newSource("img/#.ogg", "stream")}
music.path:setLooping(true)
ding = love.audio.newSource("img/pickup.ogg", "static")

painting = love.graphics.newImage("img/painting.png")
paintingbot = love.graphics.newImage("img/paintingbottom.png")
menuscreen = love.graphics.newImage("img/#.png")