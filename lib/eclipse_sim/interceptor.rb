require 'eclipse_sim/ship'

module EclipseSim
  class Interceptor < Ship
    def initialize
      super
      @description = "Interceptor"
      @base_initiative = 2
      add_engine Engine.new(1)
      add_weapon IonCannon.new
    end
  end
end
