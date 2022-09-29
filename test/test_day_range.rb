# frozen_string_literal: true

require "test_helper"

require "day_range"

class TestDayRange < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DayRange::VERSION
  end
end
