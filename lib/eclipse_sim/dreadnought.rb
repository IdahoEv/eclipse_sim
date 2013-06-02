require 'eclipse_sim/ship'

module EclipseSim
  class Dreadnought < Ship
    def initialize
      super
      @description = "Dreadnought"
      @base_initiative = 0
      add_engine Engine.new(1)
      add_weapon IonCannon.new
      add_weapon IonCannon.new
      add_hull   Hull.new(1)
      add_hull   Hull.new(1)
      add_computer Computer.new(1)
    end
  end
end
