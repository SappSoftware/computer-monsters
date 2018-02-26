DNA = Class{
  init = function(self, fatherDNA, motherDNA, numChromosomePairs, numAlleles)
    --chromosome[1] is the chromatids inherited from the father, chromosome[2] is the chromatids inherited from the mother
    --there are 15 chromosome pairs, plus a sex pair
    --males only have one sex chromosome, inherited from their mother, while females have both
    --each chromatid contains 16 alleles
    --each allele has a value of 0 or 1 which determines the allele's state
    self.numChromosomePairs = numChromosomePairs or 16
    self.numAlleles = numAlleles or 16
    if fatherDNA == nil then
      if motherDNA == nil then
        self.chromosome = self:generateRandomDNA()
      else
        local chromosome = self:generateRandomDNA()
        self.chromosome = {{},{}}
        self.chromosome[1] = chromosome[1]
        local mother_gametes = self:meiosis(motherDNA)
        chromosome[2] = deepCopy(mother_gametes[love.math.random(1,2)][love.math.random(1,2)])
      end
    elseif motherDNA == nil then
      local chromosome = self:generateRandomDNA()
      self.chromosome = {{},{}}
      self.chromosome[2] = chromosome[2]
      local father_gametes = self:meiosis(fatherDNA)
      chromosome[1] = deepCopy(father_gametes[love.math.random(1,2)][love.math.random(1,2)])
    else
      self.chromosome = self:generateDNAFromParents(fatherDNA, motherDNA)
    end
  end;
  
  generateRandomDNA = function(self, sex)
    local chromosome = {{},{}}
    for parent_index, chromatid in ipairs(chromosome) do
      for chromosome_index=1, self.numChromosomePairs do
        if sex == "female" or chromosome_index < self.numChromosomePairs or parent_index == 2 then
          chromatid[chromosome_index] = {}
          for allele_index=1, self.numAlleles do
            table.insert(chromatid[chromosome_index], love.math.random(0,1))
          end
        end
      end
    end
    
    return chromosome
  end;
  
  generateDNAFromParents = function(self, father_dna, mother_dna)
    local father_gametes = self:meiosis(father_dna)
    local mother_gametes = self:meiosis(mother_dna)
    local chromosome = {{},{}}
    chromosome[1] = deepCopy(father_gametes[love.math.random(1,2)][love.math.random(1,2)])
    chromosome[2] = deepCopy(mother_gametes[love.math.random(1,2)][love.math.random(1,2)])
    
    return chromosome
  end;
  
  meiosis = function(self, dna)
    local p_crossover = 0.9
    local p_doublecrossover = 0.2
    --chromosomes[1][1] and chromosomes[1][2] are initially duplicate, as are chromosomes[2][1] and chromosomes[2][2]
    --first, swap chromosomes randomly for independent assortment
    --second, duplicate chromosomes so there are two sets
    --third, 
    local chromosomes = {{},{}}
    
    --randomly swap chromosomes according to independent assortment
    for i=1, dna.numChromosomePairs do
      local swap = love.math.random(1,2)
      if swap == 1 then
        chromosomes[1][i] = deepCopy(dna.chromosome[1][i])
        chromosomes[2][i] = deepCopy(dna.chromosome[2][i])
      else
        chromosomes[1][i] = deepCopy(dna.chromosome[2][i])
        chromosomes[2][i] = deepCopy(dna.chromosome[1][i])
      end
    end
    
    local gametes = {{{},{}},{{},{}}}
    
    for chromosome_index=1, math.min(#chromosomes[1], #chromosomes[2]) do
      for pair_index=1,2 do
        gametes[1][pair_index][chromosome_index] = {}
        gametes[2][pair_index][chromosome_index] = {}
        if love.math.random() < p_crossover then
          if love.math.random() < p_doublecrossover then
            --double crossover in chromosome, generate lower and upper bound, swap values inclusively
            local rand1, rand2 = love.math.random(2,dna.numAlleles-1), love.math.random(2,dna.numAlleles-1)
            local lowerBound, upperBound = math.min(rand1,rand2), math.max(rand1,rand2)
            for allele_index=1, lowerBound-1 do
              gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
              gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
            end
            for allele_index=lowerBound, upperBound do
              gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
              gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
            end
            for allele_index=upperBound+1, dna.numAlleles do
              gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
              gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
            end
          else
            --single crossover in chromosome, generate change point, determine if upper or lower, swap values
            local halfwayPoint = (1+dna.numAlleles)/2
            local changePoint = love.math.random(1,dna.numAlleles)
            local direction = love.math.random()
            if direction < 0.5 then
              if changePoint == dna.numAlleles then
                for allele_index=1, dna.numAlleles do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                end
              else
                for allele_index=1, changePoint do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                end
                for allele_index=changePoint+1, dna.numAlleles do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                end
              end
            else
              if changePoint == 1 then
                for allele_index=1, dna.numAlleles do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                end
              else
                for allele_index=1, changePoint-1 do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                end
                for allele_index=changePoint, dna.numAlleles do
                  gametes[1][pair_index][chromosome_index][allele_index] = chromosomes[2][chromosome_index][allele_index]
                  gametes[2][pair_index][chromosome_index][allele_index] = chromosomes[1][chromosome_index][allele_index]
                end
              end
            end
          end
        else
          --no crossovers in chromosome, just copy without alteration
          gametes[1][pair_index][chromosome_index] = deepCopy(chromosomes[1][chromosome_index])
          gametes[2][pair_index][chromosome_index] = deepCopy(chromosomes[2][chromosome_index])
        end
      end
    end
    
    return gametes
  end;
}