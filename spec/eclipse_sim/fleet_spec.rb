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

    def living_ship_factory
      mock(Ship, :dead? => false, :alive? => true )
    end
    def dead_ship_factory
      mock(Ship, :dead? => true, :alive? => false )
    end

    describe :destroyed do
      subject do fleet end

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

    describe :living_ships do
      subject do fleet.living_ships end
      let :alive_1 do living_ship_factory end
      let :alive_2 do living_ship_factory end
      let :alive_3 do living_ship_factory end
      let :dead_1 do dead_ship_factory end
      let :dead_2 do dead_ship_factory end
      let :dead_3 do dead_ship_factory end

      before do
        fleet.add_ship(alive_1)
        fleet.add_ship(alive_2)
        fleet.add_ship(alive_3)
        fleet.add_ship(dead_1)
        fleet.add_ship(dead_2)
        fleet.add_ship(dead_3)
      end

      it { should have(3).ships }
      it{ should include(alive_1, alive_2, alive_3) }
      it{ should_not include(dead_1, dead_2, dead_3) }

    end

  end
end
