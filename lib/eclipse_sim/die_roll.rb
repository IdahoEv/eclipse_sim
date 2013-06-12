module EclipseSim
  class DieRoll
    attr_reader :damage, :computer_power, :value

    def initialize(weapon, ship)
      @damage = weapon.damage
      @computer_power = ship.computer_power
      @value = Kernel.rand(1..6)
    end
  end
end
