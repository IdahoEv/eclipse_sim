require 'spec_helper'

module EclipseSim
  describe Interceptor do
    let :interceptor do
      Interceptor.new
    end

    subject do interceptor end

    it { should be_a(Ship) }
    its(:hull_strength)   { should == 0 }
    its(:hit_points)      { should == 1 }
    its(:computer_power)  { should == 0 }
    its(:shield_strength) { should == 0 }
    its(:initiative)      { should == 3 }
    its(:description)     { should == "Interceptor" }

    context :weapons do
      subject do interceptor.weapons end
      it          { should have(1).weapon }
      its(:first) { should be_a(IonCannon) }
    end

  end
end

