module EclipseSim
  class Study
    require 'yaml'
    require 'pp'

    def initialize(file, options)
      @params = YAML::load_file(file)
      @iterations = options[:iterations]

      @defender = build_fleet(@params[:defender][:ships], :defender => true)
    end

    def run
      @outcomes = {}
      @params[:attackers].each do |attacker_params|
        ship_string = attacker_params[:ships]
        experiment = Experiment.new
        experiment.iterations = @iterations
        experiment.fleet_array = [@defender, build_fleet(ship_string)]
        experiment.run
        @outcomes[ship_string] = experiment.report
      end
    end

    def report
      pp @outcomes
    end

    def build_fleet(string, options = {})
      fleet = Fleet.new(options)
      string.each_char do |chr|
        fleet.add_ship(
          case chr
          when 'A' then Ancient.new
          when 'I' then Interceptor.new
          when 'C' then Cruiser.new
          when 'D' then Dreadnought.new
          end
        )
      end
      fleet
    end

  end
end

