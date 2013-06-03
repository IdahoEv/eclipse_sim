require 'spec_helper'
require 'eclipse_sim/fleet'
require 'eclipse_sim/interceptor'

module EclipseSim
  describe Fleet do

    describe :ships do

      let :fleet do Fleet.new  end
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

  end
end
