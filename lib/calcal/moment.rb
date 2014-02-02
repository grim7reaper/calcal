#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class is a Rata Die with a fractional part giving the time of day.
  #
  # Reference: section (1.6) and (1.8) of Calendrical Calculations, 3rd edition.
  class Moment
    include CalCal::Date

    # @see CalCal::Date::ClassMethods#from_rd
    def self.from_rd(rd)
      return Moment.new(rd)
    end

    # @!attribute [r] moment
    #   @return [Float] the moment.
    attr_reader :moment

    # Creates a new moment.
    #
    # @param moment [Float] a moment.
    def initialize(moment)
      @moment = moment
    end

    # Tests the equality between two Moment.
    #
    # @param other [Moment] a moment.
    def eql?(other)
      return false unless other.class == Moment
      return @moment.eql? other.moment
    end

    # Equation (1.9) of Calendrical Calculations, 3rd edition.
    # @see CalCal::Date::InstanceMethods#to_rd
    def to_rd
      return @moment.floor
    end

    # Returns the time of day, as a fraction (0.5 is noon).
    #
    # Equation (1.16) in Calendrical Calculations, 3rd edition.
    #
    # @return [Float] time of day.
    def time_of_day
      return @moment%1
    end

    # Convert the fractional part of the moment into clock time (hh:mm:ss).
    #
    # Equation (1.35) in Calendrical Calculations, 3rd edition.
    #
    # @return [Array] the clock time.
    def to_clock
      # Round to the nearest second.
      time   = (self.time_of_day*24*60*60).round.fdiv(24*60*60)
      hour   = (time*24).floor
      minute = (time*24*60 % 60).floor
      second = (time*24*60*60 % 60).floor
      return Clock.new(hour, minute, second)
    end
  end
end
