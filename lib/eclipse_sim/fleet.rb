module EclipseSim
  class Fleet
    attr_reader :ships
    attr_accessor :description
    def initialize(options = {})
      @ships = []
      @defender = options[:defender]
    end

    def add_ship(ship)
      ships << ship
      if @defender
        ship.add_defender_bonus
      end
    end

    def destroy_ship(ship)
      ships.delete(ship)
    end

    def ship_groups
      ships.group_by(&:initiative)
    end

    def destroyed?
      ships.all?(&:dead?)
    end

    def reset_damage
      ships.each(&:reset_damage)
    end
  end
end
