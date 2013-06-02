require 'eclipse_sim/ship'

module EclipseSim
  class Cruiser < Ship
    def initialize
      super
      @description = "Cruiser"
      @base_initiative = 1
      add_engine Engine.new(1)
      add_weapon IonCannon.new
      add_hull   Hull.new(1)
      add_computer Computer.new(1)
    end
  end
end
