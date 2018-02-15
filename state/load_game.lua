load_game = {}

function load_game:init()
  
end

function load_game:enter(from)
  
end

function load_game:update(dt)
  
end

function load_game:keypressed(key)
  if key == "escape" then
    Gamestate.pop()
  end
end

function load_game:mousepressed(x, y, mouseButton)
  
end

function load_game:draw()
  love.graphics.print("Load Game", SW*.5, SH*.1)
end
