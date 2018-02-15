home = {}

local buttons = {}
local labels = {}
local fields = {}

local camera = {}

local monster = {}
local desktopDimensions = {}
local screenPosition = {}
local activeScreen = nil

local center = {}

local mouseLock = {}

function home:init()
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
  screenPosition.x, screenPosition.y, activeScreen = love.window.getPosition()
  desktopDimensions.x, desktopDimensions.y = love.window.getDesktopDimensions(activeScreen)
  
  camera = Camera(screenPosition.x+SW/2, screenPosition.y+SH/2)
  
  monster = Creature(desktopDimensions.x/2, desktopDimensions.y/2, 80)
  center = {desktopDimensions.x/2, desktopDimensions.y/2}
end

function home:enter(from)
  love.graphics.setBackgroundColor(CLR.WHITE)
end

function home:update(dt)
  self:handleMouse()
  if buttons.dragWindow.isSelected and love.mouse.isDown(1) then
    local gx, gy = globalMouse:getGlobalMousePosition() -- global mouse position
    --local lx, ly = globalMouse:toScreenPosition(gx,gy) -- local mouse position
    if type(gx) == "number" and type(gy) == "number" then
      screenPosition.x, screenPosition.y = gx - mouseLock.x, gy - mouseLock.y
      camera:lookAt(screenPosition.x+SW/2, screenPosition.y+SH/2)
      love.window.setPosition(screenPosition.x, screenPosition.y, activeScreen)
    end
  end
end

function home:keypressed(key)
  for pos, field in pairs(fields) do
    field:keypressed(key)
  end
  if key == "escape" then
    love.event.quit()
  end
end

function home:textinput(text)
  for pos, field in pairs(fields) do
    field:textinput(text)
  end
end

function home:mousepressed(mousex, mousey, mouseButton)
  mousePoint:moveTo(mousex, mousey)
  mouseLock = {x = mousex, y = mousey}
  
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

function home:mousereleased(mousex, mousey, mouseButton)
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

function home:mousemoved(mousex, mousey, dx, dy)
  
end

function home:draw()
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
  
  camera:draw(self.draw_scene)
end

function home:draw_scene()
  monster:draw()
  love.graphics.points(center[1],center[2])
end

function home:initializeButtons()
  buttons.dragWindow = Button(.974, .025, .05, .05, "", CLR.BLACK)
end

function home:initializeLabels()
  labels.title = Label("Home", .5, .1, "center", CLR.BLACK)
end

function home:initializeFields()
  
end

function home:handleMouse()
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

function home:quit()
  
end