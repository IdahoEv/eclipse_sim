$: << 'lib'
require 'eclipse_sim'

def make_cruiser
  ship = EclipseSim::Cruiser.new
  ship.weapons = [ EclipseSim::PlasmaCannon.new ]
  #ship.add_hull(EclipseSim::Hull.new(1))
  ship.add_shield(EclipseSim::Shield.new(1))
  ship
end

f1 = EclipseSim::Fleet.new(:defender => true)
f1.description = "Ancient"
f1.add_ship(EclipseSim::Ancient.new)

f2 = EclipseSim::Fleet.new()
f2.description = "Player"
f2.add_ship(make_cruiser)

trial = EclipseSim::Experiment.new
trial.iterations = 1000
trial.fleet_array = [f1,f2]

trial.description = "C"
trial.run
puts trial.report

f2.add_ship(make_cruiser)
trial.description = "CC"
trial.run
puts trial.report

f2.add_ship(make_cruiser)
trial.description = "CCC"
trial.run
puts trial.report

f2.add_ship(make_cruiser)
trial.description = "CCCC"
trial.run
puts trial.report

