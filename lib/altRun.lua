function love.run()
 
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
  
	-- Main loop time.
  local frametime = 0
  local accumulator = 0
  local dt = 1/60  --specify the target update frequency here

  while true do
    love.timer.step()
    frametime = love.timer.getDelta()
    accumulator = accumulator + frametime

    while (accumulator >= dt) do
      if love.event then
        love.event.pump()
        for name, a,b,c,d,e,f in love.event.poll() do
          if name == "quit" then
            if not love.quit or not love.quit() then
              return a
            end
          end
          love.handlers[name](a,b,c,d,e,f)
        end
      end
      -- Call update and draw
      love.update(dt)
      accumulator = accumulator - dt
    end

    love.graphics.clear(love.graphics.getBackgroundColor())
    love.graphics.origin()
    if love.draw then love.draw() end
    love.graphics.present()
  end
end