file = File.expand_path("../**/*.rb", __FILE__)
Dir[file].each {|f| require f unless f =~ /manual/}

module EclipseSim


end

