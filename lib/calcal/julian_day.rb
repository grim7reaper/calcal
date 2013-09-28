#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal

  # This class represent a date in Julian Day.
  class JulianDay

    include CalCal::Date

    # Epoch for Julian Day number.
    # From equation (1.3) of Calendrical Calculations, 3rd edition.
    EPOCH = -1721424.5

    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      JulianDay.new(rd - EPOCH)
    end

    # @!attribute [r] julian_day
    #   @return [Float] the Julian Day.
    attr_reader :julian_day

    # Creates a new Julian Day.
    #
    # @param julian_day [Float] a Julian Day.
    def initialize(julian_day)
      @julian_day = julian_day
    end

    # Tests the equality between two Julian Day.
    #
    # @param other [JulianDay] a Julian Day.
    def eql?(other)
      return false unless other.class == JulianDay
      return @julian_day.eql? other.julian_day
    end

    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      return (@julian_day + EPOCH).floor
    end

  end
end
