module EclipseSim
  class MatchRunner

    def initialize
      @rounds = 0
      @fleets = []
    end

    def set_fleets(fleet_array)
      @fleets = fleet_array
    end

    def reset
      @fleets.each(&:reset_damage!)
    end

    def run
      while(true) do
        execute_round
      end
    rescue Victory
    end

    def victor
      if @fleets[0].destroyed?
        @fleets[1]
      elsif @fleets[1].destroyed?
        @fleets[0]
      else
        nil
      end
    end

    def execute_round
      @rounds += 1
      report_round
      fleet_firing_groups = @fleets.map(&:firing_groups)
      require 'pp'
      #pp fleet_firing_groups
      initiatives = fleet_firing_groups.map(&:keys).flatten.sort
      until all_ships_have_fired?(fleet_firing_groups)

        #puts "INITIATIVE LIST: #{initiatives}"
        current_initiative = initiatives.pop

        #puts "CURRENT INITIATIVE: #{current_initiative}"

        firing_group, target_fleet = get_firing_group_and_target(current_initiative, fleet_firing_groups)
        #puts "\n\n FIRING GROUP:"
        #pp firing_group
        report_volley(current_initiative, firing_group)
        volley = dice_for_group(firing_group)
        apply_hits(target_fleet, volley)
      end
    end

    # TODO: A smarter hit application algorithm
    def apply_hits(target_fleet, dice)
      while ( die = dice.pop )
        print "\t\tApplying dieroll: #{die}"
        target_ships = target_fleet.living_ships.sort_by(&:hit_points)
        hittable_ships = target_ships.select{ |ship| die.can_hit?(ship) }
        if hittable_ships == []
          puts "... miss"
          next
        else
          hit_ship = hittable_ships.first
          puts "... hit for #{die.damage} on #{hit_ship}"
          hit_ship.add_damage(die.damage)
          raise Victory if target_fleet.destroyed?
        end
      end
    end

    def dice_for_group(group)
      group.map do |ship|
        next unless ship.alive?  # might have been KOed in a previous volley
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


    def report_round
      puts "\n\nROUND ##{@rounds}:"
      puts "Fleet #1 #{@fleets[0].description} has #{@fleets[0].ships.length} ships remaining"
      puts "Fleet #2 #{@fleets[1].description} has #{@fleets[1].ships.length} ships remaining"
    end

    def report_volley(initiative, group)
      puts "\tBeginning volley: initiative #{initiative}"
      puts "\tFiring group: "+ group.map(&:to_s).join(", ")+"\n"
    end


    def outcome
    end

    class Victory < Exception
      attr_accessor
    end

  end
end
