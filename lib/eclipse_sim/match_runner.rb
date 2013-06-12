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
      firing_groups = [ @fleet_a.firing_groups, @fleet_b.firing_groups ]

      initiatives = firing_groups.map(&:keys).flatten.sort

      until all_ships_have_fired?(groups_a, groups_b)

        current_initiative = initiatives.pop
        firing_group, target = get_firing_group_and_target(initiatives.pop, groups)



        # roll dice for current ship group
        # apply any hits to enemies
        # check for victory
      end
    end


    # return the currently firing ship group, and the fleet they are targeting
    def get_firing_group_and_target(initiative, groups)
      if groups[0].has_key?(initiative)
        return groups[0].delete(initiative), @fleet_b
      elsif groups[1].has_key?(initiative)
        return groups[1].delete(initiative), @fleet_a
      end
    end

    def all_ships_have_fired?(groups)
      groups.all?(&:empty?)
    end


    def outcome
    end

    class Victory < Exception
      attr_accessor
    end

  end
end
