main_menu = {}

local buttons = {}

function main_menu:init()
  mousePointer = HC.point(love.mouse.getX(), love.mouse.getY())
  self:initializeButtons()
end

function main_menu:enter(from)
  
end

function main_menu:update(dt)
  mousePointer:moveTo(love.mouse.getX(), love.mouse.getY())
  local highlightButton = false
  local highlightField = false
  
  for key, button in pairs(buttons) do
    if button:highlight(mousePointer) then
      highlightButton = true
    end
  end
  
  if highlightButton then
    love.mouse.setCursor(cur_highlight)
  elseif highlightField then
    love.mouse.setCursor(cur_field)
  else
    love.mouse.setCursor()
  end
end

function main_menu:keypressed(key)
  
end

function main_menu:mousepressed(x, y, mouseButton)
  if mouseButton == 1 then
    for key, button in pairs(buttons) do
      if button:highlight(mousePointer) then
        button:action()
      end
    end
  end
end

function main_menu:draw()
  for key, button in pairs(buttons) do
    button:draw()
  end
  
  love.graphics.print("Main Menu", SW*.5, SH*.1)
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
  buttons.play = Button(.2, .2, .15, .06, "Game Test")
  buttons.newGame = Button(.5, .5, .15, .06, "New Game")
  buttons.loadGame = Button(.5, .6, .15, .06, "Load Game")
  buttons.options = Button(.5, .7, .15, .06, "Options")
  buttons.quitGame = Button(.5, .8, .15, .06, "Quit Game")
  
  buttons.play.action = function()
    love.mouse.setCursor()
    Gamestate.switch(game)
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


