module EclipseSim
  class Ship
    attr_accessor :weapons, :computers, :shields, :hulls, :engines, :base_initiative

    def initialize
      @weapons   = []
      @computers = []
      @shields   = []
      @hulls     = []
      @engines   = []
      @base_initiative = 0
    end

    def add_computer(computer)
      @computers << computer
    end

    def computer_power
      computers.reduce(0){ |sum,c| sum += c.power }
    end

    def add_shield(shield)
      @shields << shield
    end

    def shield_strength
      shields.reduce(0){ |sum,c| sum += c.strength }
    end

    def add_weapon(weapon)
      @weapons << weapon
    end

    def add_engine(engine)
      @engines << engine
    end

    def initiative
      base_initiative + engines.reduce(0){ |sum,c| sum += c.initiative }
    end

  end
end
