Egg = Class{
  init = function(self, x, y, species, father, mother)
    self.pos = Vector(x,y)
    self.father = father or {}
    self.mother = mother or {}
    self.DNA = {}
    
    self.species = species
    
    self.sex = ""
    
    self.size = 80
    self.sprite = sprites.egg
    self.rotation = 0
    self.scale = self.size/self.sprite:getHeight()
    self.offset = Vector(self.sprite:getWidth()/2, self.sprite:getHeight()/2)
    
    self.color = CLR.WHITE
    
    self.mask = HC.circle(x,y,self.size/2)
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color)
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, self.offset.x, self.offset.y)
    love.graphics.setColor(CLR.BLACK)
    love.graphics.print(self.sex, self.pos.x, self.pos.y)
    love.graphics.setColor(CLR.RED)
    self.mask:draw()
  end;
  
  determineColor = function(self)
    local hue = 0
    local saturation = 255
    local lightness = 128
    
    hue = self.species.gene_expressions.hue_1:state(self.DNA.chromosome)*1 + self.species.gene_expressions.hue_2:state(self.DNA.chromosome)*2 + self.species.gene_expressions.hue_4:state(self.DNA.chromosome)*4 + self.species.gene_expressions.hue_8:state(self.DNA.chromosome)*8 + self.species.gene_expressions.hue_16:state(self.DNA.chromosome)*16 + self.species.gene_expressions.hue_32:state(self.DNA.chromosome)*32 + self.species.gene_expressions.hue_64:state(self.DNA.chromosome)*64 + self.species.gene_expressions.hue_128:state(self.DNA.chromosome)*128
    
    local color = {}
    color[1], color[2], color[3], color[4] = HSL(hue, saturation, lightness, 255)
    self.color = color
  end;
  
  determineSex = function(self)
    if self.DNA.chromosome[1][16] == nil then
      self.sex = "female"
    else
      self.sex = "male"
    end
  end;
}