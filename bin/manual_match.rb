$: << 'lib'
require 'eclipse_sim'

puts "\n" * 5
f1 = EclipseSim::Fleet.new(:defender => true)
f1.description = "Ancient"
f1.add_ship(EclipseSim::Ancient.new)

f2 = EclipseSim::Fleet.new()
f2.description = "Player"
f2.add_ship(EclipseSim::Cruiser.new)
f2.add_ship(EclipseSim::Cruiser.new)

runner = EclipseSim::MatchRunner.new
runner.verbose = true
runner.set_fleets([f1,f2])
runner.run

puts "\n\nVictory by #{runner.victor}"
