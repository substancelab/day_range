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

  def test_days_returns_the_number_of_days_in_the_range
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_equal 3, day_range.days
  end

  def test_previous_returns_a_day_range_with_the_same_length_as_the_original
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    previous = day_range.previous
    assert_equal 3, previous.days
  end

  def test_previous_returns_a_day_range_that_ends_on_the_day_before_the_originals_start
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    previous = day_range.previous
    assert_equal Date.new(2020, 12, 29), previous.first
    assert_equal Date.new(2020, 12, 31), previous.last
  end

  def test_next_returns_a_day_range_with_the_same_length_as_the_original
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    next_range = day_range.next
    assert_equal 3, next_range.days
  end

  def test_next_returns_a_day_range_that_starts_on_the_day_after_the_originals_end
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    next_range = day_range.next
    assert_equal Date.new(2021, 1, 4), next_range.first
    assert_equal Date.new(2021, 1, 6), next_range.last
  end
end
