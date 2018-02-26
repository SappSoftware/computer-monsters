main_menu_options = {}

local buttons = {}
local labels = {}
local fields = {}

function main_menu_options:init()
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
end

function main_menu_options:enter(from)
  love.graphics.setBackgroundColor(CLR.WHITE)
end

function main_menu_options:update(dt)
  self:handleMouse()
end

function main_menu_options:keypressed(key)
  for pos, field in pairs(fields) do
    field:keypressed(key)
  end
  if key == "escape" then
    Gamestate.pop()
  end
end

function main_menu_options:textinput(text)
  for pos, field in pairs(fields) do
    field:textinput(text)
  end
end

function main_menu_options:mousepressed(mousex, mousey, mouseButton)
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

function main_menu_options:mousereleased(mousex, mousey, mouseButton)
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


function main_menu_options:draw()
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
  
  love.graphics.setColor(CLR.BLACK)
  love.graphics.rectangle("line", 0, 0, SW, SH)
end

function main_menu_options:initializeButtons()
  
end

function main_menu_options:initializeLabels()
  labels.title = Label("Options", .5, .1, "center", CLR.BLACK)
end

function main_menu_options:initializeFields()
  
end

function main_menu_options:handleMouse()
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

function main_menu_options:quit()
  
end