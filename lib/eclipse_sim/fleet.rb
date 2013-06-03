module EclipseSim
  class Fleet
    attr_reader :ships
    attr_accessor :description, :opponent
    def initialize
      @ships = []
    end

    def add_ship(ship)
      ships << ship
    end

    def destroy_ship(ship)
      ships.delete(ship)
    end

    def ship_groups
      ships.group_by(&:initiative)
    end
  end
end
