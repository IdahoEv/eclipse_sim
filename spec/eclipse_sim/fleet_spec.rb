require 'spec_helper'
require 'eclipse_sim/fleet'
require 'eclipse_sim/interceptor'

module EclipseSim
  describe Fleet do

    describe :ships do

      let :fleet do Fleet.new  end
      let :interceptor do Interceptor.new end

      it "should add ships" do
        fleet.ships.should == []
        fleet.add_ship(interceptor)
        fleet.ships.should include(interceptor)
      end

    end

  end
end
