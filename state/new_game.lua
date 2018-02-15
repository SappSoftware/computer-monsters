new_game = {}

local buttons = {}
local labels = {}
local fields = {}

function new_game:init()
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
end

function new_game:enter(from)
  love.graphics.setBackgroundColor(CLR.WHITE)
end

function new_game:update(dt)
  self:handleMouse()
end

function new_game:keypressed(key)
  for pos, field in pairs(fields) do
    field:keypressed(key)
  end
  if key == "escape" then
    Gamestate.pop()
  end
end

function new_game:textinput(text)
  for pos, field in pairs(fields) do
    field:textinput(text)
  end
end

function new_game:mousepressed(mousex, mousey, mouseButton)
  mousePoint:moveTo(mousex, mousey)
  
  if mouseButton == 1 then
    for pos, field in pairs(fields) do
      field:highlight(mousePoint)
      field:mousepressed(mouseButton)
    end
    
    for pos, button in pairs(buttons) do
      button:highlight(mousePoint)
      button:mousepressed(mouseButton)
    end
  end
end

function new_game:mousereleased(mousex, mousey, mouseButton)
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


function new_game:draw()
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

function new_game:initializeButtons()
  
end

function new_game:initializeLabels()
  labels.title = Label("New Game", .5, .1, "center", CLR.BLACK)
end

function new_game:initializeFields()
  
end

function new_game:handleMouse()
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

function new_game:quit()
  
end