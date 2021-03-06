debug = true

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
require "lib/GENE_LIST"

require "Tserial"

require "class/Button"
require "class/FillableField"
require "class/Label"

require "class/Egg"
require "class/Creature"
require "class/DNA"
require "class/Species"
require "class/Gene"

require "state/main_menu"
require "state/main_menu_options"
require "state/new_game"
require "state/load_game"
require "state/quit_game"
require "state/home"
require "state/adoption"
require "state/breeding"

sprites = {}

SW = love.graphics.getWidth()
SH = love.graphics.getHeight()

mousePoint = {}

pets = {}

species_list = {}

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
  species_list = loadSpeciesData()
  generateSpecies("Alpha")
  generateSpecies("Beta")
  --updateSpeciesData()
  loadImages()
  fpsCounter = Label("FPS", .015, .97, "left", CLR.BLACK)
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
  sprites.egg = love.graphics.newImage("images/egg.png")
end

function loadSpeciesData()
  local data = {}
  love.filesystem.setIdentity("computer_monsters")
  if love.filesystem.exists("species_list.lua") then
    local import_string = love.filesystem.read("species_list.lua")
    data = Tserial.unpack(import_string)
  else
    love.filesystem.write("species_list.lua", Tserial.pack(data))
  end
  
  return data
end

function updateSpeciesData()
  love.filesystem.write("species_list.lua", Tserial.pack(species_list))
end

function generateSpecies(name)
  if species_list[name] == nil then
    local newSpecies = Species(name)
    for gene_name, gene_data in pairs(GENE_LIST) do
      local markers = {love.math.random(1,16),love.math.random(1,16)}
      local dominant = love.math.random(0,1)
      local newGene = Gene(gene_name, markers, gene_data.dominance, dominant)
      newGene.expression = gene_data.expression
      if gene_data.dominance == "multifactorial" then
        newGene.multifactorial = gene_data.multifactorial
      end
      newSpecies.genes[gene_name] = newGene
    end
    species_list[name] = newSpecies
  end
end