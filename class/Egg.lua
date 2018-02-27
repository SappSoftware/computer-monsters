Egg = Class{
  init = function(self, x, y, species, father, mother)
    self.pos = Vector(x,y)
    self.father = father or {}
    self.mother = mother or {}
    self.DNA = {}
    
    self.species = species
    
    self.size = 80
    self.sprite = sprites.egg
    self.rotation = 0
    self.scale = self.size/self.sprite:getHeight()
    self.offset = Vector(self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    
    self.color = CLR.WHITE
    
    self.mask = HC.circle(x,y,self.size/2)
  end;
  
  draw = function(self)
    love.graphics.setColor(CLR.RED)
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, self.offset.x, self.offset.y)
    love.graphics.setColor(CLR.RED)
    self.mask:draw()
  end;
}