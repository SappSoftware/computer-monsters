main_menu_options = {}

function main_menu_options:init()
  
end

function main_menu_options:enter(from)
  
end

function main_menu_options:update(dt)
  
end

function main_menu_options:keypressed(key)
  if key == "escape" then
    Gamestate.pop()
  end
end

function main_menu_options:mousepressed(x, y, mouseButton)
  
end

function main_menu_options:draw()
  love.graphics.print("Options", SW*.5, SH*.1)
end
