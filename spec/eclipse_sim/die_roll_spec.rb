require 'spec_helper'

module EclipseSim
  describe DieRoll do

    let :weapon do Weapon.new(2) end
    let :ship do   Cruiser.new end

    let :die_roll do
      DieRoll.new(weapon, ship)
    end

    it "should get the weapon's damage" do
      weapon.should_receive(:damage).and_return(5)
      die_roll.damage.should == 5
    end

    it "should get the ship's computer power as bonus" do
      ship.should_receive(:computer_power).and_return(3)
      die_roll.computer_power.should == 3
    end

    it "should call rand() and set the value accordingly" do
      Kernel.stub!(:rand).and_return(4)
      die_roll.value.should == 5
    end
  end
end
