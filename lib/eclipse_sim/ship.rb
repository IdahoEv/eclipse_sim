module EclipseSim
  class Ship
    attr_accessor :weapons, :computers, :shields,
      :hulls, :engines, :base_initiative

    attr_reader :description

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

    def to_s
      self.class.name.split('::').last + " " + ('-' * @damage) + ('*' * self.hit_points)
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

    def reset_damage!
      @damage = 0
    end

    def add_defender_bonus
      @base_initiative += 0.5
    end

    def dead?
      hit_points <= 0
    end

    def alive?
      !dead?
    end

    [:computer, :shield, :weapon, :engine, :hull].each do |component|
      define_method("add_#{component}") do |arg|
        instance_variable_get("@#{component}s") << arg
      end
    end

  end
end
