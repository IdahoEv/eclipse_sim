module EclipseSim
  class MatchRunner

    def set_fleets(fleet_array)
      @fleets = fleet_array
    end

    def reset
      @fleets.each(&:reset_damage!)
    end

    def run
      while(1) do
        execute_round
      end
    rescue Victory
    end

    def execute_round
      fleet_firing_groups = @fleets.map(&:firing_groups)
      initiatives = fleet_firing_groups.map(&:keys).flatten.sort

      until all_ships_have_fired?(fleet_firing_groups)

        current_initiative = initiatives.pop
        firing_group, target_fleet = get_firing_group_and_target(initiatives.pop, fleet_firing_groups)
        dice = dice_for_group(firing_group)


        # roll dice for current ship group
        # apply any hits to enemies
        # check for victory
      end
    end

    def dice_for_group(group)
      group.map do |ship|
        ship.weapons.map do |weapon|
          DieRoll.new(weapon, ship)
        end
      end.flatten
    end

    # return the currently firing ship group, and the fleet they are targeting
    def get_firing_group_and_target(initiative, groups)
      if groups[0].has_key?(initiative)
        return groups[0].delete(initiative), @fleets[1]
      elsif groups[1].has_key?(initiative)
        return groups[1].delete(initiative), @fleets[0]
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
