module EclipseSim
  class Weapon
    attr_accessor :damage
    def initialize(damage)
      @damage = damage
    end
  end

  class IonCannon < Weapon
    def initialize
      super(1)
    end
  end
  class PlasmaCannon < Weapon
    def initialize
      super(2)
    end
  end
  class AntimatterCannon < Weapon
    def initialize
      super(4)
    end
  end
end
