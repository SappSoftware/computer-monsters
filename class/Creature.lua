Creature = Class{
  init = function(self, x, y, size)
    self.pos = Vector(x,y)
    self.size = size
    self.sprite = sprites.monster
    self.rotation = 0
    self.scale = self.size/self.sprite:getHeight()
    self.offset = Vector(self.sprite:getWidth()/2, self.sprite:getHeight()/2)
  end;
  
  draw = function(self)
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, self.offset.x, self.offset.y)
  end;
}