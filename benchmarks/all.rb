require_relative "./crud_point.rb"
require_relative "./crud_line.rb"
require_relative "./crud_polygon.rb"

require_relative "./read_point.rb"
require_relative "./read_line.rb"
require_relative "./read_polygon.rb"


class All
  def initialize(repeat_times)
    CrudPointTests.new(repeat_times).run_tests
    CrudLineTests.new(repeat_times).run_tests
    CrudPolygonTests.new(repeat_times).run_tests

    ReadPointTests.new(repeat_times).run_tests
    ReadLineTests.new(repeat_times).run_tests
    ReadPolygonTests.new(repeat_times).run_tests
  end
end
