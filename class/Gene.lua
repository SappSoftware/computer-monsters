Gene = Class{
  init = function(self, name, markers, dominance_type, dominant)
    --[[
    name is the name of the gene
    markers is a table of chromosome positions that are used to determine the function of the gene
    dominance_type determines the interaction of the markers. 
      "normal" means two-state: rr, Rr/rR/RR
      "codominant" means three-state: rr, Rr/rR, and RR
      "multifactorial" means multiple markers that have varying effects on the gene's expression
    don't know if I care to have dominant and recessive. don't know what to do with them
    for now:
    dominant is the expected value of the marker that represents a dominant allele
    recessive is the expected value of the marker that represents a recessive allele
    ]]--
    self.name = name
    self.markers = markers
    self.dominance_type = dominance_type
    self.dominant = dominant or 1
    self.recessive = math.abs(self.dominant-1)
  end;
  
  expression = function(self)
    
  end;
}