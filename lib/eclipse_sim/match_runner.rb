module EclipseSim
  class MatchRunner

    def set_fleets(fleet_a, fleet_b)
      @fleet_a = fleet_a
      @fleet_b = fleet_b
    end

    def reset
      @fleet_a.reset_damage
      @fleet_b.reset_damage
    end

    def run
      while(1) do
        execute_round
      end
    rescue Victory
    end

    def execute_round
      firing_groups_a = @fleet_a.ship_groups
      firing_groups_b = @fleet_b.ship_groups

      until all_ships_have_fired?(groups_a, groups_b)
        # iterate all ship groups by initiative
        # roll dice for current ship group
        # apply any hits to enemies
        # check for victory
      end
    end



    def all_ships_have_fired?(a, b)
      a.empty? and b.empty?
    end


    def outcome
    end

    class Victory < Exception
    end

  end
end
