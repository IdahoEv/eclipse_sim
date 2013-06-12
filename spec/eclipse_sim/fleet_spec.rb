require 'spec_helper'
require 'eclipse_sim/fleet'
require 'eclipse_sim/interceptor'

module EclipseSim
  describe Fleet do
    let :fleet do Fleet.new  end

    describe :ships do

      let :interceptor do Interceptor.new end
      let :cruiser     do Cruiser.new end

      it "should add ships" do
        fleet.ships.should == []
        fleet.add_ship(interceptor)
        fleet.ships.should include(interceptor)
      end

      it "should destroy ships" do
        fleet.ships.should == []
        fleet.add_ship(interceptor)
        fleet.add_ship(cruiser)
        fleet.ships.should include(interceptor)
        fleet.ships.should include(cruiser)
        fleet.destroy_ship(cruiser)
        fleet.ships.should include(interceptor)
        fleet.ships.should_not include(cruiser)
      end

    end

    describe :firing_groups do
      let :interceptor_1 do Interceptor.new end
      let :interceptor_2 do
        int = Interceptor.new
        int.stub(:dead?){ true }
        int
      end
      let :interceptor_3 do Interceptor.new end
      let :cruiser       do Cruiser.new     end

      before do
        fleet.add_ship(cruiser)
        fleet.add_ship(interceptor_1)
        fleet.add_ship(interceptor_2)
        fleet.add_ship(interceptor_3)
      end

      subject do fleet.firing_groups end

      it { should be_a(Hash) }
      it do
        should == {
          2 => [ cruiser ],
          3 => [ interceptor_1, interceptor_3 ]
        }
      end
    end

    describe "a fleet with defender status" do
      let :fleet do Fleet.new( :defender => true ) end
      let :interceptor do Interceptor.new end
      let :cruiser     do Cruiser.new end

      it "should add defender bonus to ship initiative" do
        interceptor.should_receive(:add_defender_bonus)
        fleet.add_ship(interceptor)

        cruiser.should_receive(:add_defender_bonus)
        fleet.add_ship(cruiser)
      end
    end

    describe :destroyed do
      subject do fleet end

      def living_ship_factory
        mock(Ship, :dead? => false)
      end
      def dead_ship_factory
        mock(Ship, :dead? => true)
      end

      context "when no ships are dead" do
        before do
          fleet.add_ship(living_ship_factory)
          fleet.add_ship(living_ship_factory)
          fleet.add_ship(living_ship_factory)
        end
        it { should_not be_destroyed }
      end

      context "when some ships are dead" do
        before do
          fleet.add_ship(living_ship_factory)
          fleet.add_ship(dead_ship_factory)
          fleet.add_ship(dead_ship_factory)
        end
        it { should_not be_destroyed }
      end

      context "when all ships are dead" do
        before do
          fleet.add_ship(dead_ship_factory)
          fleet.add_ship(dead_ship_factory)
          fleet.add_ship(dead_ship_factory)
        end
        it { should be_destroyed }
      end

    end

  end
end
