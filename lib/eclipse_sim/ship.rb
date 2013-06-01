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

  end
end
