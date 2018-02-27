CreatureStats = Class{
  init = function(self)
    self.name = ""
    self.sex = ""
    self.color = CLR.WHITE
    
    self.propensities = {
      brawn = 0, 
      constitution = 0, 
      quickness = 0,
      intellect = 0,
      perception = 0,
      willpower = 0,
      stamina = 0
    }
    
    self.brawn = 0
    self.constitution = 0
    self.quickness = 0
    self.intellect = 0
    self.perception = 0
    self.willpower = 0
    self.stamina = 0
    
  end;
}