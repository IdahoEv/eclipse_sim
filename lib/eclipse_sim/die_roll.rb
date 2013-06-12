module EclipseSim
  class DieRoll
    attr_reader :damage, :computer_power, :value

    def initialize(weapon, ship)

      @damage = weapon.damage
      @computer_power = ship.computer_power
      @value = @@roller.next  #Kernel.rand(1..6)
    end

    def can_hit?(target)
      @value == 6 or
      (@value + computer_power - target.shield_strength >= 6)
    end

    def to_s
      "#{@value}(+#{@computer_power})" + '*' * damage
    end

    def self.set_roller(roller)
      @roller = roller
    end

    class RandRoller
      def next
        Kernel.rand(1..6)
      end
    end

    class FixedRoller
      def initialize(sequence = nil)
        @sequence = sequence or [1,2,3,4,5,6]
        @position = 0
      end
      def next
        val = @sequence[@position]
        @position += 1
        @position = @position % @sequence.length
        val
      end
    end

    @@roller = RandRoller.new
  end
end
