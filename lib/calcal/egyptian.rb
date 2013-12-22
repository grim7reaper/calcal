#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent a date in the Egyptian calendar.
  #
  # A simple solar calendar with 365 days each year (and no leap-year rule) and
  # 30 days each month (12 months + 5 epagomenal days).
  class Egyptian
    include CalCal::Date

    # Epoch for the Egyptian calendar (Rata Die).
    # Equation (1.38) of Calendrical Calculations, 3rd edition.
    EPOCH = -272_787

    # Equation (1.40) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      days  = rd - EPOCH
      year  = days.fdiv(365).floor + 1
      month = (1.fdiv(30) * (days % 365)).floor + 1
      day   = days - 365*(year-1) - 30*(month-1) + 1
      return Egyptian.new(year, month, day)
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

    # Creates a new egyptian date.
    #
    # @param year  [Integer] the year.
    # @param month [Integer] the month.
    # @param day   [Integer] the day of the month.
    def initialize(year, month, day)
      @year  = year
      @month = month
      @day   = day
    end

    # Tests the equality between two date of of the Egyptian calendar.
    #
    # @param other [Egyptian] a date in the Egyptian calendar.
    def eql?(other)
      return false unless other.class == Egyptian
      return (@year.eql?  other.year)  &&
             (@month.eql? other.month) &&
             (@day.eql?   other.day)
    end

    # Equation (1.39) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      return EPOCH + 365*(@year-1) + 30*(@month-1) + @day - 1
    end
  end
end
