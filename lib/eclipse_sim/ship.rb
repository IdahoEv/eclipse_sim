module EclipseSim
  class Ship
    attr_accessor :weapons, :computers, :shields,
      :hulls, :engines, :base_initiative

    def initialize
      @weapons   = []
      @computers = []
      @shields   = []
      @hulls     = []
      @engines   = []
      @type      = :interceptor
      @damage    = 0
      @base_initiative = 0
    end


    def computer_power
      computers.reduce(0){ |sum,c| sum + c.power }
    end


    def shield_strength
      shields.reduce(0){ |sum,c| sum + c.strength }
    end


    def initiative
      base_initiative + engines.reduce(0){ |sum,c| sum + c.initiative }
    end

    def hull_strength
      hulls.reduce(0){ |sum, h| sum += h.strength }
    end

    def hit_points
      hull_strength + 1 - @damage
    end

    def add_damage(damage)
      @damage += damage
    end

    [:computer, :shield, :weapon, :engine, :hull].each do |component|
      define_method("add_#{component}") do |arg|
        instance_variable_get("@#{component}s") << arg
      end
    end

  end
end
