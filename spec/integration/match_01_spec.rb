require 'spec_helper'

module EclipseSim
  describe "Full matches between one ancient and two cruisers" do

    let :ancient_fleet do
      Fleet.new(:defender => true).tap do |fleet|
        fleet.add_ship(Ancient.new)
      end
    end
    let :player_fleet do
      Fleet.new.tap do |fleet|
        fleet.add_ship(Cruiser.new)
        fleet.add_ship(Cruiser.new)
      end
    end
    let :match_runner do
      MatchRunner.new.tap do |mr|
        mr.set_fleets([ancient_fleet, player_fleet])
      end
    end
    subject do
      match_runner.run
      match_runner
    end

    #A 1m, 3m
    #CC 5h, 2m   (A-*)
    #A 4m, 5h   (C-* C**)
    #CC 1m, 2m
    #A 1m, 1m
    #CC 3m, 5h (A-- win)
    context "dice profile #1" do
      before do
        DieRoll.set_roller(DieRoll::FixedRoller.new([1,3,5,2,4,5,1,2,1]))
      end
      its(:victor) { should == player_fleet }
      its(:outcome) do
         should == {
          :victor => player_fleet,
          :rounds => 3,
          :loss_count => [1, 0]
        }
      end
    end


    #A 1m. 1m
    #CC 5h, 2m   (A-*)
    #A 6h 6h (C-- C**)
    #C 1m
    #A 1m 5h (C-- C-*)
    #C 2m
    #
    #A 6h    (C-- C-- )
    context "dice profile #2" do
      before do
        DieRoll.set_roller(DieRoll::FixedRoller.new([1,1,5,2,6,6]))
      end
      its(:victor) { should == ancient_fleet }
      its(:outcome) do should == {
          :victor => ancient_fleet,
          :rounds => 4,
          :loss_count => [0, 2]
        }
      end
    end

  end
end





