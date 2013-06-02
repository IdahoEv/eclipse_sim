require 'spec_helper'

module EclipseSim
  describe Cruiser do
    let :cruiser do
      Cruiser.new
    end

    subject do cruiser end

    it { should be_a(Ship) }
    its(:hull_strength)   { should == 1 }
    its(:hit_points)      { should == 2 }
    its(:computer_power)  { should == 1 }
    its(:shield_strength) { should == 0 }
    its(:initiative)      { should == 2 }
    its(:description)     { should == "Cruiser" }

    context :weapons do
      subject do cruiser.weapons end
      it          { should have(1).weapon }
      its(:first) { should be_a(IonCannon) }
    end

  end
end

