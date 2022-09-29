# frozen_string_literal: true

require_relative "day_range/version"

class DayRange < Range
  class Error < StandardError; end

  # Returns the number of days in the timeframe.
  def days
    last - first + 1
  end

  # Returns an enumerator that steps over the days in the range with specific
  # intervals.
  #
  # step can be specified similarily to DateTime#advance argument
  #
  # Usage examples
  #
  #     day_range.every(days: 42)
  #     day_range.every(weeks: 1)
  #     day_range.every(months: 1)
  #     day_range.every(days: 1, months: 2, years: 3)
  #
  def every(step)
    c_date = first
    finish_date = last
    comparison_operator = exclude_end? ? :< : :<=

    result = []
    while c_date.send(comparison_operator, finish_date)
      result << c_date
      yield c_date if block_given?
      c_date = advance(c_date, step)
    end
    result
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

  private

  # File activesupport/lib/active_support/core_ext/date/calculations.rb, line 112
  def advance(date, options)
    d = date

    d = d >> options[:years] * 12 if options[:years]
    d = d >> options[:months] if options[:months]
    d += options[:weeks] * 7 if options[:weeks]
    d += options[:days] if options[:days]

    d
  end
end
