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

    describe :ship_groups do
      let :interceptor_1 do Interceptor.new end
      let :interceptor_2 do Interceptor.new end
      let :cruiser     do Cruiser.new end

      before do
        fleet.add_ship(cruiser)
        fleet.add_ship(interceptor_1)
        fleet.add_ship(interceptor_2)
      end

      subject do fleet.ship_groups end

      it { should be_a(Hash) }
      it do
        should == {
          2 => [ cruiser ],
          3 => [ interceptor_1, interceptor_2 ]
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

  end
end
