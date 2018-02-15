main_menu = {}

local buttons = {}
local labels = {}
local fields = {}

function main_menu:init()
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
end

function main_menu:enter(from)
  love.graphics.setBackgroundColor(CLR.WHITE)
end

function main_menu:update(dt)
  self:handleMouse()
end

function main_menu:keypressed(key)
  
end

function main_menu:mousepressed(mousex, mousey, mouseButton)
  mousePoint:moveTo(mousex, mousey)
  
  if mouseButton == 1 then
    for i, field in pairs(fields) do
      field:highlight(mousePoint)
      field:mousepressed(mouseButton)
    end
    
    for i, button in pairs(buttons) do
      button:highlight(mousePoint)
      button:mousepressed(mouseButton)
    end
  end
end

function main_menu:mousereleased(mousex, mousey, mouseButton)
  mousePoint:moveTo(mousex, mousey)
  
  if mouseButton == 1 then
    for pos, field in pairs(fields) do
      field:highlight(mousePoint)
      field:mousereleased(mouseButton)
    end
    
    for pos, button in pairs(buttons) do
      button:highlight(mousePoint)
      button:mousereleased(mouseButton)
    end
  end
end


function main_menu:draw()
  drawFPS(fpsCounter)
  for key, button in pairs(buttons) do
    button:draw()
  end
  for pos, field in pairs(fields) do
    field:draw()
  end
  for pos, label in pairs(labels) do
    label:draw()
  end
end

function main_menu:resize(w,h)
  love.graphics.setFont(love.graphics.newFont(math.floor(h/64)))
  
  for key, button in pairs(buttons) do
    button:resize(SW, SH, w, h)
  end
  
  SW = w
  SH = h
end

function main_menu:initializeButtons()
  buttons.play = Button(.2, .2, .3, .1, "Game Test", CLR.BLACK)
  buttons.newGame = Button(.5, .35, .3, .1, "New Game", CLR.BLACK)
  buttons.loadGame = Button(.5, .5, .3, .1, "Load Game", CLR.BLACK)
  buttons.options = Button(.5, .65, .3, .1, "Options", CLR.BLACK)
  buttons.quitGame = Button(.5, .8, .3, .1, "Quit Game", CLR.BLACK)
  
  buttons.play.action = function()
    love.mouse.setCursor()
    Gamestate.switch(home)
  end
  
  buttons.newGame.action = function()
    love.mouse.setCursor()
    Gamestate.push(new_game)
  end
  
  buttons.loadGame.action = function()
    love.mouse.setCursor()
    Gamestate.push(load_game)
  end
  
  buttons.options.action = function()
    love.mouse.setCursor()
    Gamestate.push(main_menu_options)
  end
  
  buttons.quitGame.action = function()
    love.event.quit()
  end
end

function main_menu:initializeLabels()
  labels.title = Label("Main Menu", .5, .1, "center", CLR.BLACK)
end

function main_menu:initializeFields()
  --fields.genericField = FillableField(.5, .4, .15, .03, "Field Text", false, true, 16)
end

function main_menu:handleMouse()
  mousePoint:moveTo(love.mouse.getX(), love.mouse.getY())
  local highlightButton = false
  local highlightField = false
  
  for key, button in pairs(buttons) do
    if button:highlight(mousePoint) then
      highlightButton = true
    end
  end
  
  for key, field in pairs(fields) do
    if field:highlight(mousePoint) then
      highlightField = true
    end
  end
  
  if highlightButton then
    love.mouse.setCursor(CUR.H)
  elseif highlightField then
    love.mouse.setCursor(CUR.I)
  else
    love.mouse.setCursor()
  end
end

function main_menu:quit()
  
end