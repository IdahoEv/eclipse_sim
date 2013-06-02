require 'spec_helper'

module EclipseSim
  describe Ancient do
    let :ancient do
      Ancient.new
    end

    subject do ancient end

    it { should be_a(Ship) }
    its(:hull_strength)   { should == 1 }
    its(:hit_points)      { should == 2 }
    its(:computer_power)  { should == 1 }
    its(:shield_strength) { should == 0 }
    its(:initiative)      { should == 2 }
    its(:description)     { should == "Ancient" }

    context :weapons do
      subject do ancient.weapons end
      it          { should have(2).weapons }
      its(:first) { should be_an(IonCannon) }
      its(:last)  { should be_an(IonCannon) }
    end

  end
end

