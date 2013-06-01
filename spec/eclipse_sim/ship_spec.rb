require 'spec_helper'

module EclipseSim

  describe Ship do
    let :empty_ship do Ship.new end


    describe :computer_power do
      subject do
        ship.computer_power
      end

      context "with a single 1-power computer" do
        let :ship do
          ship = empty_ship
          ship.add_computer(Computer.new(1))
          ship
        end

        it { should == 1}
      end

      context "with two 1-power computers" do
        let :ship do
          ship = empty_ship
          ship.add_computer(Computer.new(1))
          ship.add_computer(Computer.new(1))
          ship
        end

        it { should == 2 }
      end
      context "with one 3-power computer" do
        let :ship do
          ship = empty_ship
          ship.add_computer(Computer.new(3))
          ship
        end

        it { should == 3 }
      end
    end

    describe :shield_strength do
      subject do
        ship.shield_strength
      end

      context "with a single 1-strength shield" do
        let :ship do
          ship = empty_ship
          ship.add_shield(Shield.new(1))
          ship
        end

        it { should == 1}
      end

      context "with two 1-strength shields" do
        let :ship do
          ship = empty_ship
          ship.add_shield(Shield.new(1))
          ship.add_shield(Shield.new(1))
          ship
        end

        it { should == 2 }
      end
      context "with one 3-strength shield" do
        let :ship do
          ship = empty_ship
          ship.add_shield(Shield.new(3))
          ship
        end

        it { should == 3 }
      end
    end
  end
end
