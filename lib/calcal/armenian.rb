#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent a date in the Armenian calendar.
  #
  # A simple solar calendar with 365 days each year (and no leap-year rule) and
  # 30 days each month (12 months + 5 epagomenal days).
  #
  # The rules of the Armenian calendar are identical to those of the Egyptian
  # calendar. The only difference is the Epoch.
  class Armenian 
    include CalCal::Date

    # Epoch for the Armenian calendar (Rata Die).
    # Equation (1.41) of Calendrical Calculations, 3rd edition.
    EPOCH = 201_443

    # Equation (1.43) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      date = Egyptian.from_rd(rd + Egyptian::EPOCH - EPOCH)
      return Armenian.new(date.year, date.month, date.day)
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

    # Creates a new armenian date.
    #
    # @param year  [Integer] the year.
    # @param month [Integer] the month.
    # @param day   [Integer] the day of the month.
    def initialize(year, month, day)
      @year  = year
      @month = month
      @day   = day
    end

    # Tests the equality between two date of of the Armenian calendar.
    #
    # @param other [Armenian] a date in the Armenian calendar.
    def eql?(other)
      return false unless other.class == Armenian 
      return (@year.eql?  other.year)  &&
             (@month.eql? other.month) &&
             (@day.eql?   other.day)
    end

    # Equation (1.42) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      date = Egyptian.new(@year, @month, @day)
      return EPOCH + date.to_rd - Egyptian::EPOCH
    end
  end
end
