debug = false

HC = require "hc"
Shape = require "hc.shapes"

Gamestate = require "hump.gamestate"
Class = require "hump.class"
Vector = require "hump.vector"
Camera = require "hump.camera"

local Desktopmouse = require "lib/desktopmousecoords"
globalMouse = Desktopmouse()

require "lib/CLR"
require "lib/FNT"
require "lib/CUR"
require "lib/helper"

require "Tserial"

require "class/Button"
require "class/FillableField"
require "class/Label"

require "class/Creature"
require "class/DNA"

require "state/main_menu"
require "state/main_menu_options"
require "state/new_game"
require "state/load_game"
require "state/home"

sprites = {}

SW = love.graphics.getWidth()
SH = love.graphics.getHeight()

mousePoint = {}

TICK = 0
FPS = 1/60

function love.load(arg)
  if debug then require("mobdebug").start() end
  love.math.setRandomSeed(love.timer.getTime())
  Gamestate.registerEvents()
  love.keyboard.setKeyRepeat(true)
  FNT.DEFAULT = love.graphics.newFont(math.floor(SH/32))
  mousePoint = HC.point(0,0)
  love.graphics.setFont(FNT.DEFAULT)
  love.graphics.setBackgroundColor(CLR.BLACK)
  loadImages()
  fpsCounter = Label("FPS", .015, .03, "left", CLR.BLACK)
  Gamestate.switch(main_menu)
end

function love.update(dt)
  
end

function love.draw(dt)

end

function love.keypressed(key)

end

function loadImages()
  sprites.monster = love.graphics.newImage("images/monster.png")
end

function loadServerData()
  local data = {}
  love.filesystem.setIdentity("Zabutongl_Server")
  if love.filesystem.exists("player_list.lua") then
    local import_string = love.filesystem.read("player_list.lua")
    data = Tserial.unpack(import_string)
  else
    love.filesystem.write("player_list.lua", Tserial.pack(data))
  end
  
  return data
end