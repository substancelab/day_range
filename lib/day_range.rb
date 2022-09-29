# frozen_string_literal: true

require_relative "day_range/version"

class DayRange < Range
  class Error < StandardError; end

  # Returns the number of days in the timeframe.
  def days
    last - first + 1
  end
end
