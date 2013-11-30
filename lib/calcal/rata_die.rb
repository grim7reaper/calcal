#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent a date in a way that is independent of any calendar.
  #
  # Similar to Julian Day, except that the Epoch is different and that Rata Die
  # is relative to a timezone.
  class RataDie
    include CalCal::Date

    # Epoch for Rata Die (Rata Die).
    # From page 11 of Calendrical Calculations, 3rd edition.
    EPOCH = 0

    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      return RataDie.new(rd)
    end

    # @!attribute [r] rata_die
    #   @return [Integer] the Rata Die.
    attr_reader :rata_die

    # Creates a new Rata Die.
    #
    # @param rata_die [Integer] a Rata Die.
    def initialize(rata_die)
      @rata_die = rata_die
    end

    # Tests the equality between two Rata Die.
    #
    # @param other [RataDie] a Rata Die.
    def eql?(other)
      return false unless other.class == RataDie
      return @rata_die.eql? other.rata_die
    end

    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      return @rata_die
    end
  end
end
