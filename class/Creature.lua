Creature = Class{
  init = function(self, x, y, size, father, mother)
    self.pos = Vector(x,y)
    self.size = size
    self.sprite = sprites.monster
    self.rotation = 0
    self.scale = self.size/self.sprite:getHeight()
    self.offset = Vector(self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    self.mother = mother or {}
    self.father = father or {}
    
    self.DNA = {}
    self.sex = {}
    self.mask = HC.circle(x,y,size/2)
    --self.cage = cage
  end;
  
  update = function(self, dt)
    --local velocity = Vector.randomDirection(200*dt)
    --self.pos = self.pos + velocity
    --self.mask:moveTo(self.pos:unpack())
  end;
  
  draw = function(self)
    love.graphics.setColor(CLR.WHITE)
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, self.offset.x, self.offset.y)
    love.graphics.setColor(CLR.RED)
    self.mask:draw()
  end;
  
  determineSex = function(self)
    if #self.DNA.chromosome[1] == self.DNA.numChromosomePairs then
      return "female"
    else
      return "male"
    end
  end;
}