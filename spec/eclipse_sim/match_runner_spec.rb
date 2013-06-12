require 'spec_helper'

module EclipseSim

  describe MatchRunner do
    let :match_runner do  MatchRunner.new  end
    let :fleet_a do Fleet.new end
    let :fleet_b do Fleet.new end

    describe :get_firing_group do
      before do
        match_runner.set_fleets(fleet_a, fleet_b)
      end
      let :group_a do
        { 1 => [ :foo ],
          2 => [ :bar, :baz ]
        }
      end
      let :group_b do
        { 2.5 => [ :ancient ] }
      end

      context "when the initiative is found in group_a" do
        subject do match_runner.get_firing_group_and_target(2, group_a, group_b) end
        it { should ==  [ [:bar, :baz], fleet_b] }
        it "should remove the found group from the groups hash" do
          subject
          group_a.should_not include( 2 => [ :bar, :baz] )
          group_a.should     include( 1 => [ :foo] )
        end
        it "should not change group_b" do
          expect { subject }.not_to change{ group_b }
        end
      end
      context "when the initiative is found in group_b" do
        subject do match_runner.get_firing_group_and_target(2.5, group_a, group_b) end
        it { should ==  [ [:ancient], fleet_a] }
        it "should remove the found group from the groups hash" do
          subject
          group_b.should == {}
        end
        it "should not change group_a" do
          expect { subject }.not_to change{ group_a }
        end
      end

    end

    describe :all_ships_have_fired? do

      subject do
        match_runner.all_ships_have_fired?(groups_a, groups_b)
      end

      context "when given enpty hashes" do
        let :groups_a do {} end
        let :groups_b do {} end
        it { should be_true }
      end
      context "when given one hash with ships" do
        let :groups_a do { 1 => [ Interceptor.new ]} end
        let :groups_b do {} end
        it { should be_false }
      end
      context "when given two hashes with ships" do
        let :groups_a do { 1 => [ mock(Interceptor) ]} end
        let :groups_b do { 2 => [ mock(Ancient) ] } end
        it { should be_false }
      end

    end

  end
end
