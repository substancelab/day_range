# frozen_string_literal: true

require_relative "day_range/version"

class DayRange < Range
  class Error < StandardError; end

  # Returns the number of days in the timeframe.
  def days
    last - first + 1
  end

  # Returns a DayRange with the same length as this one, starting on the day
  # after this one ends.
  def next
    self.class.new(
      last.next_day,
      last + days
    )
  end

  # Returns a DayRange with the same length as this one, ending on the day
  # before this one starts.
  def previous
    self.class.new(
      first - days,
      first.prev_day
    )
  end
end
