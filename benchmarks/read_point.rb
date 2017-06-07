require 'benchmark'
require 'csv'

class ReadPointTests
  def initialize(repeat_times)
    @repeat_times = repeat_times
    @times = Array.new(6, 0)
    @counts = Array.new(6, nil)
    @file_name = "./roda_read_points_model_#{@repeat_times}.csv"
    @selectors = [
      [51.093806456838884, 17.021598815917972, 51.10620311082015, 17.045052051544193],
      [51.08759340505135, 17.00988292694092, 51.11238672031782, 17.056789398193363],
      [51.075218724732665, 16.98640823364258, 51.124805326982795, 17.080221176147464],
      [51.05035152049235, 16.93954467773438, 51.149524845587585, 17.127170562744144],
      [51.00079308917475, 16.845817565917972, 51.199139316696126, 17.221069335937504],
      [50.90130070888041, 16.658020019531254, 51.29799348237416, 17.408523559570316]
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
      @entities = Point.in_area(selector[0], selector[1], selector[2], selector[3], Point::OBJECT_TYPES.keys)
  end
end
