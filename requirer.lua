loader = require "AdvTiledLoader.Loader"
--require "LoveFrames.init"
bump = require "lib.bump"
anim8 = require "lib.anim8"
camera = require "lib.camera"
tween = require "lib.tween"
Tserial = require "lib.Tserial"
require "lib.middleclass"
arc_path = 'Navi.arc.'
require(arc_path .. 'arc')
navi = require(arc_path .. 'navi')

imgPickup = love.graphics.newImage("img/Pickup.png")