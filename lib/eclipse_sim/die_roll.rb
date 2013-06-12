module EclipseSim
  class DieRoll
    attr_reader :damage, :computer_power, :value

    def initialize(weapon, ship)
      @damage = weapon.damage
      @computer_power = ship.computer_power
      @value = Kernel.rand(6) + 1
    end
  end
end
