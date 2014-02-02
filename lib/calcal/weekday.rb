#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This module defines days of week (considering that the first day of the week
  # is Sunday) and useful functions to deal with them.
  #
  # Reference: section (1.10) of Calendrical Calculations, 3rd edition.
  module Weekday
    # Constant for Sunday.
    SUNDAY    = 0
    # Constant for Monday.
    MONDAY    = 1
    # Constant for Tuesday.
    TUESDAY   = 2
    # Constant for Wednesday.
    WEDNESDAY = 3
    # Constant for Thursday.
    THURSDAY  = 4
    # Constant for Friday.
    FRIDAY    = 5
    # Constant for Saturday.
    SATURDAY  = 6

    # Determines the weekday of the date.
    #
    # Equation (1.51) in Calendrical Calculations, 3rd edition.
    #
    # @param rd [RataDie] a date (in Rata Die).
    # @return [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday corresponding to this date.
    def self.day_of_week(rd)
      return (rd - SUNDAY) % 7
    end

    # Determines the date of the first given weekday on or before the given
    # date.
    #
    # Equation (1.53) in Calendrical Calculations, 3rd edition.
    #
    # @param day [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday we want.
    # @param rd  [RataDie] the date where we begin backward search.
    # @return [RataDie] the date corresponding to given day of the week that we
    #                   found on or before the specified date.
    def self.on_or_before(day, rd)
      return rd - day_of_week(rd - day)
    end

    # Determines the date of the first given weekday on or after the given date.
    #
    # Equation (1.58) in Calendrical Calculations, 3rd edition.
    #
    # @param day [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday we want.
    # @param rd  [RataDie] the date where we begin forward search.
    # @return [RataDie] the date corresponding to given day of the week that we
    #                   found on or after the specified date.
    def self.on_or_after(day, rd)
      return on_or_before(day, rd + 6)
    end

    # Determines the date of the nearest given weekday before, on or after the
    # given date.
    #
    # Equation (1.59) in Calendrical Calculations, 3rd edition.
    #
    # @param day [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday we want.
    # @param rd  [RataDie] the date where we begin search.
    # @return [RataDie] the date corresponding to given day of the week that we
    #                   found before, on or after the specified date.
    def self.nearest(day, rd)
      return on_or_before(day, rd + 3)
    end

    # Determines the date of the first given weekday before the given date.
    #
    # Equation (1.60) in Calendrical Calculations, 3rd edition.
    #
    # @param day [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday we want.
    # @param rd  [RataDie] the date where we begin backward search.
    # @return [RataDie] the date corresponding to given day of the week that we
    #                   found before the specified date.
    def self.before(day, rd)
      return on_or_before(day, rd - 1)
    end

    # Determines the date of the first given weekday after the given date.
    #
    # Equation (1.61) in Calendrical Calculations, 3rd edition.
    #
    # @param day [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] the weekday we want.
    # @param rd  [RataDie] the date where we begin forward search.
    # @return [RataDie] the date corresponding to given day of the week that we
    #                   found after the specified date.
    def self.after(day, rd)
      return on_or_before(day, rd + 7)
    end
  end
end
