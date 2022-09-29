# frozen_string_literal: true

require "test_helper"

require "date"
require "day_range"

class TestDayRange < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DayRange::VERSION
  end

  def test_it_is_a_range
    assert DayRange < Range
  end

  def test_it_responds_to_begin
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_equal Date.new(2021, 1, 1), day_range.begin
  end

  def test_it_responds_to_end
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_equal Date.new(2021, 1, 3), day_range.end
  end

  def test_it_responds_to_first
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_equal Date.new(2021, 1, 1), day_range.first
  end

  def test_it_responds_to_last
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_equal Date.new(2021, 1, 3), day_range.last
  end

  def test_it_generates_an_array_of_dates
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    dates = day_range.to_a
    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 1, 2),
      Date.new(2021, 1, 3)
    ], dates
  end
end
