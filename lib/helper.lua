roundTo = function(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  if Vector.isvector(num) == true then
    local tempx, tempy = 0,0
    if num.x >= 0 then
      tempx = math.floor(num.x * mult + 0.5) / mult
    else
      tempx = math.ceil(num.x * mult - 0.5) / mult
    end
    if num.y >= 0 then
      tempy = math.floor(num.y * mult + 0.5) / mult
    else
      tempy = math.ceil(num.y * mult - 0.5) / mult
    end
    return Vector(tempx, tempy)
  else
    if num >= 0 then 
      return math.floor(num * mult + 0.5) / mult
    else 
      return math.ceil(num * mult - 0.5) / mult 
    end
  end
end

deepCopy = function(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

toSeed = function(seed)
  --todo: maybe find way of generating more diverse numberset?
  local returnSeed = 0
  
  temp = tostring(seed)
  for i = 1, temp:len(), 1 do
    if i % 2 == 0 then
      returnSeed = returnSeed * temp:byte(i)
    elseif i % 2 == 1 then
      returnSeed = returnSeed + temp:byte(i)
    end
  end
  
  return returnSeed
end

drawFPS = function(fpsLabel)
  
  fpsLabel:settext(love.timer:getFPS())
  fpsLabel:draw()
end

function HSL(h, s, l, a) --Hue, Saturation, Lightness, Alpha
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255,a
end