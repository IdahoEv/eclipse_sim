$: << 'lib'
require 'eclipse_sim'

def make_interceptor
  ship = EclipseSim::Interceptor.new
  #ship.weapons = [ EclipseSim::PlasmaCannon.new ]
  #ship.add_hull(EclipseSim::Hull.new(3))
  #ship.add_shield(EclipseSim::Shield.new(1))
  ship
end
def make_cruiser
  ship = EclipseSim::Cruiser.new
  ship.add_weapon  EclipseSim::PlasmaCannon.new
  ship.computers = [ EclipseSim::Computer.new(2) ]
  ship
end
def make_dreadnought
  ship = EclipseSim::Dreadnought.new
  #ship.weapons = [ EclipseSim::PlasmaCannon.new ]
  #ship.add_hull(EclipseSim::Hull.new(1))
  ship.add_shield(EclipseSim::Shield.new(3))
  ship.engines = [ EclipseSim::Engine.new(2) ]
  ship.weapons = []
  ship.add_weapon(EclipseSim::PlasmaCannon.new)
  ship.add_weapon(EclipseSim::PlasmaCannon.new)
  ship
end

trial = EclipseSim::Experiment.new
trial.iterations = 10000

f1 = EclipseSim::Fleet.new(:defender => true)
f1.description = "DM"
f1.add_ship(make_dreadnought)

f2 = EclipseSim::Fleet.new()
f2.description = "2C"
f2.add_ship(make_cruiser)
f2.add_ship(make_cruiser)
f2.add_ship(make_cruiser)
f2.add_ship(make_cruiser)


trial.fleet_array = [f1,f2]

trial.run
puts trial.report
#trial.description = "I"
#trial.run
#puts trial.report

#f2.add_ship(make_interceptor)
#trial.description = "II"
#trial.run
#puts trial.report

#f2.add_ship(make_interceptor)
#trial.description = "III"
#trial.run
#puts trial.report

#f2.add_ship(make_interceptor)
#trial.description = "IIII"
#trial.run
#puts trial.report

#f2 = EclipseSim::Fleet.new()
#f2.description = "Player"
#f2.add_ship(make_cruiser)

#trial.fleet_array = [f1,f2]

#trial.description = "C"
#trial.run
#puts trial.report

#f2.add_ship(make_cruiser)
#trial.description = "CC"
#trial.run
#puts trial.report

#f2.add_ship(make_cruiser)
#trial.description = "CCC"
#trial.run
#puts trial.report

#f2.add_ship(make_cruiser)
#trial.description = "CCCC"
#trial.run
#puts trial.report


#f2 = EclipseSim::Fleet.new()
#f2.description = "Player"
#f2.add_ship(make_dreadnought)

#trial.fleet_array = [f1,f2]

#trial.description = "D"
#trial.run
#puts trial.report

#f2.add_ship(make_dreadnought)
#trial.description = "DD"
#trial.run
#puts trial.report

