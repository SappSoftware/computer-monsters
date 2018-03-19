Creature = Class{
  init = function(self, x, y, species, father, mother)
    self.pos = Vector(x,y)
    self.size = 80
    
    self.sprite = {}
    self.sprite["egg"] = sprites.egg
    self.sprite["adult"] = sprites.monster
    
    self.rotation = 0
    
    self.scale = {}
    self.scale["egg"] = self.size/self.sprite["egg"]:getHeight()
    self.scale["adult"] = self.size/self.sprite["adult"]:getHeight()
    
    self.offset = {}
    self.offset["egg"] = Vector(self.sprite["egg"]:getWidth()/2, self.sprite["egg"]:getHeight()/2)
    self.offset["adult"] = Vector(self.sprite["adult"]:getWidth()/2, self.sprite["adult"]:getHeight()/2)
    
    self.mother = mother or {}
    self.father = father or {}
    
    self.state = "egg"
    
    self.species = species
    
    self.DNA = {}
    
    self.hue = 0
    self.saturation = 0
    self.lightness = 0
    self.color = CLR.WHITE
    self.sex = ""
    self.mask = HC.polygon(self.pos.x+0.35*self.size*math.cos(0),self.pos.y+self.size/2*math.sin(0), 
                           self.pos.x+0.35*self.size*math.cos(math.pi/4),self.pos.y+self.size/2*math.sin(math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(2*math.pi/4),self.pos.y+self.size/2*math.sin(2*math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(3*math.pi/4),self.pos.y+self.size/2*math.sin(3*math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(4*math.pi/4),self.pos.y+self.size/2*math.sin(4*math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(5*math.pi/4),self.pos.y+self.size/2*math.sin(5*math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(6*math.pi/4),self.pos.y+self.size/2*math.sin(6*math.pi/4),
                           self.pos.x+0.35*self.size*math.cos(7*math.pi/4),self.pos.y+self.size/2*math.sin(7*math.pi/4))
    --self.cage = cage
    
    self.selectedCircle = HC.circle(self.pos.x, self.pos.y, self.size/2)
    
    self.isHighlighted = false
    self.isSelectable = true
    self.isSelected = false
  end;
  
  update = function(self, dt)
    --local velocity = Vector.randomDirection(200*dt)
    --self.pos = self.pos + velocity
    --self.mask:moveTo(self.pos:unpack())
  end;
  
  update_egg = function(self, dt)
    
  end;
  
  update_adult = function(self, dt)
    
  end;
  
  draw = function(self)
    if self.state == "egg" then
      self:draw_egg()
    elseif self.state == "adult" then
      self:draw_adult()
    end
    --love.graphics.setColor(CLR.RED)
    --self.mask:draw()
    love.graphics.setColor(CLR.BLACK)
    love.graphics.print(self.sex, self.pos.x, self.pos.y)
  end;
  
  draw_egg = function(self)
    if self.isSelected then
      love.graphics.setColor(CLR.RED)
      self.selectedCircle:draw("line")
    end
    love.graphics.setColor(self.color)
    love.graphics.draw(self.sprite["egg"], self.pos.x, self.pos.y, self.rotation, self.scale["egg"], self.scale["egg"], self.offset["egg"].x, self.offset["egg"].y)
  end;
  
  draw_adult = function(self)
    love.graphics.setColor(self.color)
    love.graphics.draw(self.sprite["adult"], self.pos.x, self.pos.y, self.rotation, self.scale["adult"], self.scale["adult"], self.offset["adult"].x, self.offset["adult"].y)
  end;
  
  highlight = function(self, mousePos)
    if not self.isSelectable then self.isHighlighted = false return false end
    local test = mousePos:collidesWith(self.mask)
    if test then
      self.isHighlighted = true
    else 
      self.isHighlighted = false
    end
    return test
  end;
  
  mousepressed = function(self, mouseButton)
    if self.isHighlighted and mouseButton == 1 then
      self.isSelected = true
    else
      self.isSelected = false
    end
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