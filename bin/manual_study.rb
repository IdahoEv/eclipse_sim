$: << 'lib'
require 'eclipse_sim'

study = EclipseSim::Study.new('data/ancient.yaml', :iterations => 1000)
study.run
study.report


