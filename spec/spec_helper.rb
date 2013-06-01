file = File.expand_path("../../lib/**/*.rb", __FILE__)
Dir[file].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
