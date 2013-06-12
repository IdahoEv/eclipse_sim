require 'spec_helper'

module EclipseSim
  describe DieRoll do
    let :weapon do Weapon.new(2) end
    let :ship do   Cruiser.new end

    let :die_roll do
      DieRoll.new(weapon, ship)
    end

    describe :initialization do

      it "should get the weapon's damage" do
        weapon.should_receive(:damage).and_return(5)
        die_roll.damage.should == 5
      end

      it "should get the ship's computer power as bonus" do
        ship.should_receive(:computer_power).and_return(3)
        die_roll.computer_power.should == 3
      end

      it "should call rand() and set the value accordingly" do
        Kernel.stub!(:rand).and_return(5)
        die_roll.value.should == 5
      end
    end

    describe :can_hit? do
      let :target_ship do Cruiser.new end
      let :computer_shield_matrix do
        [[0,0], [1,0], [2,0], [3,0],
          [0,1], [1,1], [2,1], [3,1],
          [0,2], [1,2], [2,2], [3,2],
          [0,3], [1,3], [2,3], [3,3]]
      end

      context 'on a natural one' do
        before do Kernel.stub!(:rand).and_return(1) end

        it 'hits on all values of computer and shield' do
          computer_shield_matrix.each do |cs|
            ship       .stub!(:computer_power) .and_return(cs[0])
            target_ship.stub!(:shield_strength).and_return(cs[1])
            DieRoll.new(weapon, ship).can_hit?(target_ship).should be_false
          end
        end
      end

      context 'on a natural four' do
        before do Kernel.stub!(:rand).and_return(4) end

        it 'hits on all values of computer and shield' do
          computer_shield_matrix.map do |cs|
            ship       .stub!(:computer_power) .and_return(cs[0])
            target_ship.stub!(:shield_strength).and_return(cs[1])
            DieRoll.new(weapon, ship).can_hit?(target_ship)
          end.should == [
            false, false, true,  true,
            false, false, false, true,
            false, false, false, false,
            false, false, false, false,
          ]
        end
      end

      context 'on a natural five' do
        before do Kernel.stub!(:rand).and_return(5) end

        it 'hits on all values of computer and shield' do
          computer_shield_matrix.map do |cs|
            ship       .stub!(:computer_power) .and_return(cs[0])
            target_ship.stub!(:shield_strength).and_return(cs[1])
            DieRoll.new(weapon, ship).can_hit?(target_ship)
          end.should == [
            false, true,  true,  true,
            false, false, true,  true,
            false, false, false, true,
            false, false, false, false,
          ]
        end
      end

      context 'on a natural six' do
        before do Kernel.stub!(:rand).and_return(6) end

        it 'hits on all values of computer and shield' do
          computer_shield_matrix.each do |cs|
            ship       .stub!(:computer_power) .and_return(cs[0])
            target_ship.stub!(:shield_strength).and_return(cs[1])
            DieRoll.new(weapon, ship).can_hit?(target_ship).should be_true
          end
        end
      end


    end

  end
end
