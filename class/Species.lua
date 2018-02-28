Species = Class{
  init = function(self, name)
    self.name = name
    self.gene_expressions = {
      hue_1 = Gene("hue1", {1,1}, "normal", 0), 
      hue_2 = Gene("hue2", {4,3}, "normal", 0), 
      hue_4 = Gene("hue4", {2,8}, "normal", 0), 
      hue_8 = Gene("hue8", {15,2}, "normal", 0), 
      hue_16 = Gene("hue16", {16,3}, "normal", 0), 
      hue_32 = Gene("hue32", {4,2}, "normal", 0), 
      hue_64 = Gene("hue64", {8,14}, "normal", 0),
      hue_128 = Gene("hue128", {16,10}, "normal", 1)
    }
  end;
}