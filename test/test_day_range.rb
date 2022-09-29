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
    assert_equal Date.new(2021, 1, 1), day_range.begin
  end

  def test_it_responds_to_end
    assert_equal Date.new(2021, 1, 3), day_range.end
  end

  def test_it_responds_to_first
    assert_equal Date.new(2021, 1, 1), day_range.first
  end

  def test_it_responds_to_last
    assert_equal Date.new(2021, 1, 3), day_range.last
  end

  def test_it_generates_an_array_of_dates
    dates = day_range.to_a
    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 1, 2),
      Date.new(2021, 1, 3)
    ], dates
  end

  def test_days_returns_the_number_of_days_in_the_range
    assert_equal 3, day_range.days
  end

  def test_previous_returns_a_day_range_with_the_same_length_as_the_original
    previous = day_range.previous
    assert_equal 3, previous.days
  end

  def test_previous_returns_a_day_range_that_ends_on_the_day_before_the_originals_start
    previous = day_range.previous
    assert_equal Date.new(2020, 12, 29), previous.first
    assert_equal Date.new(2020, 12, 31), previous.last
  end

  def test_next_returns_a_day_range_with_the_same_length_as_the_original
    next_range = day_range.next
    assert_equal 3, next_range.days
  end

  def test_next_returns_a_day_range_that_starts_on_the_day_after_the_originals_end
    next_range = day_range.next
    assert_equal Date.new(2021, 1, 4), next_range.first
    assert_equal Date.new(2021, 1, 6), next_range.last
  end

  def test_every_returns_an_array
    day_range = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 1, 3))
    assert_kind_of Array, day_range.every(days: 42)
  end

  def test_every_steps_through_days
    dates = day_range.every(days: 1)

    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 1, 2),
      Date.new(2021, 1, 3)
    ], dates
  end

  def test_every_steps_through_every_other_day
    dates = day_range.every(days: 2)

    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 1, 3)
    ], dates
  end

  def test_every_steps_through_weeks
    month = DayRange.new(Date.new(2022, 6, 1), Date.new(2022, 6, 30))
    dates = month.every(weeks: 1)

    assert_equal [
      Date.new(2022, 6, 1),
      Date.new(2022, 6, 8),
      Date.new(2022, 6, 15),
      Date.new(2022, 6, 22),
      Date.new(2022, 6, 29)
    ], dates
  end

  def test_every_steps_through_months
    quarter = DayRange.new(Date.new(2021, 1, 1), Date.new(2021, 3, 31))
    dates = quarter.every(months: 1)

    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 2, 1),
      Date.new(2021, 3, 1)
    ], dates
  end

  def test_every_steps_through_complex_steps
    decade = DayRange.new(Date.new(2000, 1, 1), Date.new(2009, 12, 31))
    dates = decade.every(days: 1, months: 2, years: 3)

    assert_equal [
      Date.new(2000, 1, 1),
      Date.new(2003, 3, 2),
      Date.new(2006, 5, 3),
      Date.new(2009, 7, 4)
    ], dates
  end

  def test_every_yields_each_date_to_a_block
    dates = []
    day_range.every(days: 1) do |date|
      dates << date
    end

    assert_equal [
      Date.new(2021, 1, 1),
      Date.new(2021, 1, 2),
      Date.new(2021, 1, 3)
    ], dates
  end

  private

  def day_range(first: Date.new(2021, 1, 1), last: Date.new(2021, 1, 3))
    DayRange.new(first, last)
  end
end
