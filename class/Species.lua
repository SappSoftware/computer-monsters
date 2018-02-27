Species = Class{
  init = function(self)
    self.name = ""
    self.gene_expressions = {
      hue_1 = Gene("hue1", {1,1}, "normal", 1), 
      hue_2 = Gene("hue1", {4,3}, "normal", 1), 
      hue_4 = Gene("hue1", {2,8}, "normal", 1), 
      hue_8 = Gene("hue1", {15,2}, "normal", 1), 
      hue_16 = Gene("hue1", {16,3}, "normal", 1), 
      hue_32 = Gene("hue1", {4,2}, "normal", 1), 
      hue_64 = Gene("hue1", {8,14}, "normal", 1)  
    }
  end;
  
  
}