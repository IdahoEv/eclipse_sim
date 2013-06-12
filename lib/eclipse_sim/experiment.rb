module EclipseSim
  class Experiment
    attr_accessor :iterations, :fleet_array, :description

    def initialize
      @runner = MatchRunner.new
      @runner.verbose = false
    end

    def run
      reset_experiment
      @runner.set_fleets(fleet_array)
      @iterations.times do
        reset_match
        @runner.run
        accumulate_data
      end
        #pp @data
    end

    def reset_match
      @runner.reset
    end

    def reset_experiment
      @runner.reset
      @data = {
        :wins => 0,
        :no_loss_wins => 0,
        :total_rounds => 0
      }
    end

    def accumulate_data
      outcome = @runner.outcome
      if outcome[:victor] == fleet_array[1]
        @data[:wins] += 1
        @data[:no_loss_wins] += 1 if (outcome[:loss_count][1] == 0)
      end
      @data[:total_rounds] += outcome[:rounds]
    end

    def report
      [self.description,
        percent_results(@data[:wins]),
        percent_results(@data[:no_loss_wins]),
        sprintf("%.2f", @data[:total_rounds].to_f / @iterations.to_f)
      ].join(", ")
    end

    def percent_results(num)
      sprintf("%.2f%", 100.0 * num.to_f / @iterations)
    end
  end
end
