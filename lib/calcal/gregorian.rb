#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'set'

require 'calcal/base'

module CalCal
  # This class represent a date in the Gregorian calendar.
  #
  # The Gregorian calendar is the calendar in use today in most of the world. It
  # is a solar calendar with 365 days each year (except for leap-year: 366 days,
  # the extra day is added to the second month). A year is divided in 12 months
  # with respectively 31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, and 31 days.
  #
  # Reference: Chapter (2) of Calendrical Calculations, 3rd edition.
  class Gregorian
    include CalCal::Date

    # Epoch for the Gregorian calendar (Rata Die).
    # Equation (2.3) of Calendrical Calculations, 3rd edition.
    EPOCH = 1

    # List of multiples of 100, lower than 400 (used in the leap year test).
    MULTIPLE_OF_100 = Set.new([ 100, 200, 300 ])

    # Tests if 'year' is a leap year.
    #
    # Equation (2.16) of Calendrical Calculations, 3rd edition.
    # A year is a leap year if its number is divisible by 4 but not 100 or if it
    # is a multiple of 400.
    #
    # @param year [Integer] the year to test.
    # @return true if `year` is a leap year, otherwise false.
    def self.leap_year?(year)
      return year%4 == 0 && !(MULTIPLE_OF_100.include? year%400)
    end

    # Equation (2.23) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      year = year_from_rd(rd)

      prior_days = rd - Gregorian.new(year, 1, 1).to_rd
      correction = nil
      if rd < Gregorian.new(year, 3, 1).to_rd
          correction = 0
      elsif leap_year? year
          correction = 1
      else
          correction = 2
      end

      month = ((12 * (prior_days + correction) + 373) / 367.0).floor
      day   = 1 + rd - Gregorian.new(year, month, 1).to_rd

      return Gregorian.new(year, month, day)
    end

    # @!attribute [r] year
    #   @return [Integer] the year.
    attr_reader :year

    # @!attribute [r] month
    #   @return [Fixnum] the month.
    attr_reader :month

    # @!attribute [r] day
    #   @return [Fixnum] the day of the month.
    attr_reader :day

    # Creates a new gregorian date.
    #
    # @param year  [Integer] the year.
    # @param month [Fixnum] the month.
    # @param day   [Fixnum] the day of the month.
    def initialize(year, month, day)
      @year  = year
      @month = month
      @day   = day
    end

    # Tests it it is a leap year.
    #
    # Equation (2.16) of Calendrical Calculations, 3rd edition.
    # A year is a leap year if its number is divisible by 4 but not 100 or if it
    # is a multiple of 400.
    #
    # @return true if `year` is a leap year, otherwise false.
    def leap?
      return Gregorian.leap_year? @year
    end

    # Tests the equality between two date of of the Gregorian calendar.
    #
    # @param other [Gregorian] a date in the Gregorian calendar.
    def eql?(other)
      return false unless other.class == Gregorian
      return (@year.eql?  other.year)  &&
             (@month.eql? other.month) &&
             (@day.eql?   other.day)
    end

    # Equation (2.17) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      normal_days = 365 * (@year - 1)
      leap_days = (((@year - 1) /   4).floor -
                   ((@year - 1) / 100).floor +
                   ((@year - 1) / 400).floor)
      # The following formula assumes that February has 30 days.
      previous_days = ((367 * @month - 362) / 12).floor
      # Correction for the previous formula.
      correction = nil
      # We are before February, no correction needed.
      if @month <= 2
          correction = 0
      # Leap year => February has 29 days - 30 = -1.
      elsif leap?
          correction = -1
      # Normal year => February has 28 days - 30 = -2.
      else
          correction = -2
      end
      return (EPOCH - 1 + normal_days + leap_days + previous_days +
              correction + @day)
    end

  private
    # Computes the year in the Gregorian calendar corresponding to the date in
    # Rata Die.
    #
    # Equation (2.21) in Calendrical Calculations, 3rd edition.
    #
    # @param rd [Integer] Rata Die.
    def self.year_from_rd(rd)
      d0    = rd - EPOCH
      # Number of groups of 400 years.
      nb400 = (d0 / 146_097.0).floor # 400 * 365.2425 =~ 146 097.
      d1    = d0 % 146_097
      # Number of groups of 100 years in the remaining years.
      nb100 = (d1 / 36_524.0).floor # 100 * 365.2425 =~ 36 524.
      d2    = d1 % 36_524
      # Number of groups of 4 years in the remaining years.
      nb4   = (d2 / 1_461.0).floor # 4 * 365.2425 =~ 1 461.
      d3    = d2 % 1_461
      # Number of remaining years.
      nb1   = (d3 / 365.0).floor # 1 * 365.2425 =~ 365
      year  = 400 * nb400 + 100 * nb100 + 4 * nb4 + nb1

      if nb100 == 4 || nb1 == 4
        return year     # `rd` is the last day of a leap year.
      else
        return year + 1 # `rd` is a day in the year + 1.
      end
    end
  end
end
