require 'spec_helper'

module EclipseSim
  describe Dreadnought do
    let :dreadnought do
      Dreadnought.new
    end

    subject do dreadnought end

    it { should be_a(Ship) }
    its(:hull_strength)   { should == 2 }
    its(:hit_points)      { should == 3 }
    its(:computer_power)  { should == 1 }
    its(:shield_strength) { should == 0 }
    its(:initiative)      { should == 1 }
    its(:description)     { should == "Dreadnought" }

    context :weapons do
      subject do dreadnought.weapons end
      it          { should have(2).weapons }
      its(:first) { should be_an(IonCannon) }
      its(:last)  { should be_an(IonCannon) }
    end

  end
end

