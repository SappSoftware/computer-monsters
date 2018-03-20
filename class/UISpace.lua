UISpace = Class{
  init = function(self, x, y, w, h, transparent, bgcolor)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.buttons = {}
    self.labels = {}
    self.fields = {}
    self.transparent = transparent or false
    self.bgcolor = bgcolor or CLR.WHITE
    self.mask = HC.rectangle(self.x, self.y, self.w, self.h)
  end;
  
  contains = function(self, mousePos)
    if self.mask:collidesWith(mousePos) then
      return true
    else
      return false
    end
  end;
  
  draw = function(self)
    if ~self.transparent then 
      love.graphics.setColor(self.bgcolor)
      self.mask:draw("fill")
    end
    
    for i, button in pairs(self.buttons) do
      button:draw()
    end
    for i, field in pairs(self.fields) do
      field:draw()
    end
    for i, label in pairs(self.labels) do
      label:draw()
    end
  end;
}