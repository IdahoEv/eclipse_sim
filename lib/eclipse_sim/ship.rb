module EclipseSim
  class Ship
    attr_accessor :weapons, :computers, :shields, :hulls, :engines

    def initialize
      @weapons   = []
      @computers = []
      @shields   = []
      @hulls     = []
      @engines   = []
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


  end
end
