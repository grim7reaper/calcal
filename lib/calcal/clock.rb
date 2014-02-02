#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent a clock time as hh:mm:ss.
  class Clock
    include Comparable

    # @!attribute [r] moment
    #   @return [Fixnum] the moment.
    attr_reader :hour

    # @!attribute [r] moment
    #   @return [Fixnum] the moment.
    attr_reader :minute

    # @!attribute [r] moment
    #   @return [Fixnum] the moment.
    attr_reader :second

    # Creates a new moment.
    #
    # @param hour   [Fixnum] hour [0; 23].
    # @param minute [Fixnum] minute [0; 59].
    # @param second [Fixnum] second [0; 59].
    def initialize(hour, minute, second)
      @hour   = hour
      @minute = minute
      @second = second
    end

    # Converts into a fraction of a day.
    #
    # Equation (1.34) in Calendrical Calculations, 3rd edition.
    #
    # @return [Float] fraction of a day.
    def to_dayfraction
      return 1.fdiv(24) * (@hour + (@minute + @second.fdiv(60)).fdiv(60))
    end

    # Compares self against `other`.
    #
    # @param other [Clock] a Clock object.
    # @return -1, 0, or +1 depending on whether self is less than, equal to,
    #   or greater than `other`.
    def <=>(other)
      return nil unless other.class == Clock
      return ([ @hour     , @minute     , @second ] <=>
              [ other.hour, other.minute, other.second ])
    end
  end
end
