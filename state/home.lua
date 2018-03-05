home = {}

local buttons = {}
local labels = {}
local fields = {}

local camera = {}

local desktopDimensions = {}
local screenPosition = {}
local activeScreen = nil
local monster = {}

local mouseLock = {}

function home:init()
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
  --mother = Creature(desktopDimensions.x/3, desktopDimensions.y/2, 100)
  --father = Creature(desktopDimensions.x/2, desktopDimensions.y/3, 100)
  
end

function home:enter(from)
  love.graphics.setBackgroundColor(CLR.BLACK)
  screenPosition.x, screenPosition.y, activeScreen = love.window.getPosition()
  desktopDimensions.x, desktopDimensions.y = love.window.getDesktopDimensions(activeScreen)
  
  camera = Camera(screenPosition.x+SW/2, screenPosition.y+SH/2)
  
  monster = Creature(desktopDimensions.x/2, desktopDimensions.y/2, 80)
end

function home:update(dt)
  
  TICK = TICK + dt
  
  --monster:update(dt)
  --mother:update(dt)
  --father:update(dt)
  if TICK >= FPS then
    self:handleMouse()
    if buttons.dragWindow.isSelected and love.mouse.isDown(1) then
      local gx, gy = globalMouse:getGlobalMousePosition() -- global mouse position
      --local lx, ly = globalMouse:toScreenPosition(gx,gy) -- local mouse position
      if type(gx) == "number" and type(gy) == "number" then
        local newScreenX, newScreenY = self:confineToDesktop(gx - mouseLock.x, gy - mouseLock.y)
        camera:lookAt(newScreenX+SW/2, newScreenY+SH/2)
        love.window.setPosition(newScreenX, newScreenY, activeScreen)
        screenPosition.x, screenPosition.y = newScreenX, newScreenY
        
      end
    end
    
    TICK = TICK - FPS
  end
end

function home:keypressed(key)
  for pos, field in pairs(fields) do
    field:keypressed(key)
  end
  if key == "escape" then
    Gamestate.push(quit_game)
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

  camera:draw(self.draw_scene)
  
  self:draw_UI()
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

function home:draw_scene()
  monster:draw()
end

function home:draw_UI()
  love.graphics.setColor(CLR.WHITE)
  love.graphics.rectangle("fill", 0, 0, SW, SH*.082)
  love.graphics.setColor(CLR.BLACK)
  love.graphics.rectangle("line", 0, 0, SW, SH)
  
end

function home:initializeButtons()
  buttons.dragWindow = Button(.974, .025, .05, .05, "", CLR.BLACK)
  buttons.home = Button(.15, .04, .1, .08, "H", CLR.BLACK)
  buttons.adoption = Button(.25, .04, .1, .08, "A", CLR.BLACK)
  buttons.breeding = Button(.35, .04, .1, .08, "B", CLR.BLACK)
  
  buttons.home.isSelectable = false
  
  buttons.adoption.action = function()
    love.mouse.setCursor()
    Gamestate.switch(adoption)
  end
  
  buttons.breeding.action = function()
    love.mouse.setCursor()
    Gamestate.switch(breeding)
  end
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

function home:confineToDesktop(newScreenX, newScreenY)
  local newX = math.min(desktopDimensions.x-SW, math.max(0, newScreenX))
  local newY = math.min(desktopDimensions.y-SH, math.max(0, newScreenY))
  return newX, newY
end

function home:quit()
  
end