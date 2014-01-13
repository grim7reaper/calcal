#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent a date in Modified Julian Day.
  class ModifiedJulianDay
    include CalCal::Date

    # Epoch for Modified Julian Day number (Rata Die).
    # Equation (1.6) of Calendrical Calculations, 3rd edition.
    EPOCH = 678576

    # Equation (1.8) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      return ModifiedJulianDay.new(rd - EPOCH)
    end

    # @!attribute [r] modified_julian_day
    #   @return [Integer] the Modified Julian Day.
    attr_reader :modified_julian_day

    # Creates a new Modified Julian Day.
    #
    # @param modified_julian_day [Integer] a Modified Julian Day.
    def initialize(modified_julian_day)
      @modified_julian_day= modified_julian_day
    end
    #
    # Tests the equality between two modified Julian Day.
    #
    # @param other [ModifiedJulianDay] a modified Julian Day.
    def eql?(other)
      return false unless other.class == ModifiedJulianDay
      return @modified_julian_day.eql? other.modified_julian_day
    end

    # Equation (1.7) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      return @modified_julian_day + EPOCH
    end
  end
end
