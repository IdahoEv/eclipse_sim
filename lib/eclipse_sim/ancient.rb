require 'eclipse_sim/ship'

module EclipseSim
  class Ancient < Ship
    def initialize
      super
      @description = "Ancient"
      @base_initiative = 2
      add_weapon IonCannon.new
      add_weapon IonCannon.new
      add_hull   Hull.new(1)
      add_computer Computer.new(1)
    end
  end
end
