new_game = {}

function new_game:init()
  
end

function new_game:enter(from)
  
end

function new_game:update(dt)
  
end

function new_game:keypressed(key)
  if key == "escape" then
    Gamestate.pop()
  end
end

function new_game:mousepressed(x, y, mouseButton)
  
end

function new_game:draw()
  love.graphics.print("New Game", SW*.5, SH*.1)
end
