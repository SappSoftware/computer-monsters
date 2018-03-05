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
    
    self.hue = 0
    self.saturation = 0
    self.lightness = 0
    self.color = CLR.WHITE
    
    self.mask = HC.circle(x,y,self.size/2)
    
    --self:expressGenes()
  end;
  
  draw = function(self)
    love.graphics.setColor(self.color)
    love.graphics.draw(self.sprite, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, self.offset.x, self.offset.y)
    love.graphics.setColor(CLR.BLACK)
    love.graphics.print(self.sex, self.pos.x, self.pos.y)
    love.graphics.setColor(CLR.RED)
    self.mask:draw()
  end;
  
  expressGenes = function(self)
    for gene_name, gene in pairs(self.species.genes) do
      local gene_state = gene:state(self.DNA.chromosome)
      gene.expression(self, gene_state)
    end
  end;
  
  determineColor = function(self)
    
    local color = {}
    color[1], color[2], color[3], color[4] = HSL(self.hue, self.saturation, self.lightness, 255)
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