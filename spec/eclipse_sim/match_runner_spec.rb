require 'spec_helper'

module EclipseSim

  describe MatchRunner do
    let :match_runner do
      MatchRunner.new
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
