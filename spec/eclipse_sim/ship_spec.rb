require 'spec_helper'

module EclipseSim

  describe Ship do
    let :empty_ship do Ship.new end

    describe :initiative do
      subject do ship.initiative end

      context "with 1 base initiative and a 1-initiative engine" do
        let :ship do
          ship = empty_ship
          ship.base_initiative = 1
          ship.add_engine(Engine.new(1))
          ship
        end
        it {should == 2}
      end
      context "with 1 base initiative and a 2-initiative engine" do
        let :ship do
          ship = empty_ship
          ship.base_initiative = 1
          ship.add_engine(Engine.new(2))
          ship
        end
        it {should == 3}
      end
      context "with default initiative and a 2-initiative engine" do
        let :ship do
          ship = empty_ship
          ship.add_engine(Engine.new(2))
          ship
        end
        it {should == 2}
      end

      context :add_defender_bonus do
        it "should increase initiative by 0.5" do
          expect do
            empty_ship.add_defender_bonus
          end.to change{ empty_ship.initiative }.by(0.5)
        end

      end
    end

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

    describe :hull_strength do
      subject do
        ship.hull_strength
      end

      context "with a single 1-strength hull" do
        let :ship do
          ship = empty_ship
          ship.add_hull(Hull.new(1))
          ship
        end

        it { should == 1}
      end

      context "with two 1-strength hulls" do
        let :ship do
          ship = empty_ship
          ship.add_hull(Hull.new(1))
          ship.add_hull(Hull.new(1))
          ship
        end

        it { should == 2 }
      end
      context "with one 3-strength hull" do
        let :ship do
          ship = empty_ship
          ship.add_hull(Hull.new(3))
          ship
        end

        it { should == 3 }
      end
    end

    describe "hit_points and death" do
      subject do ship end

      context "with a single 1-strength hull" do
        let :ship do
          ship = empty_ship
          ship.add_hull(Hull.new(1))
          ship
        end

        its(:hit_points) { should == 2}
        it { should_not be_dead }

        context "after one point of damage" do
          before do ship.add_damage(1) end
          its(:hit_points) { should == 1}
          it { should_not be_dead }
        end

        context "after two points of damage" do
          before do ship.add_damage(2) end
          its(:hit_points) { should == 0}
          it { should be_dead }
        end
      end
    end


  end
end
