require 'benchmark'
require 'csv'

class ReadLineTests
  def initialize(repeat_times)
    @repeat_times = repeat_times
    @times = Array.new(5, 0)
    @counts = Array.new(5, nil)
    @file_name = "./roda_read_lines_model_#{@repeat_times}.csv"
    @selectors = [
      [51.098448854082285, 17.03039646148682, 51.10154801802621, 17.036259770393375],
      [51.09689919420231, 17.027467489242557, 51.10309752209134, 17.039194107055668],
      [51.093806456838884, 17.021598815917972, 51.10620311082015, 17.045052051544193],
      [51.08759340505135, 17.00988292694092, 51.11238672031782, 17.056789398193363],
      [51.075218724732665, 16.98640823364258, 51.124805326982795, 17.080221176147464]
    ]
    @entities = nil
  end

  def run_tests
    @repeat_times.times do
      @selectors.each_with_index do |selector, index|
        @times[index] += Benchmark.realtime { read(selector) }
        @counts[index] ||= @entities.size
      end
    end
    CSV.open(@file_name, "wb") do |csv|
      csv << ['count', 'time']
      @times.each_with_index do |time, index|
        csv << [@counts[index], time/@repeat_times*1000]
      end
    end
  end

  private
  
  def read(selector)
    @entities = Line.in_area(selector[0], selector[1], selector[2], selector[3],
      ["residential", "secondary", "secondary_link", "primary", "primary_link",
      "tertiary", "tertiary_link", "living_street"])
  end
end
