#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/base'

module CalCal
  # This class represent an angle using the sexagesimal system.
  class Angle
    include Comparable

    # @!attribute [r] degree
    #   @return [Fixnum] Degrees.
    attr_reader :degree

    # @!attribute [r] arcminute
    #   @return [Fixnum] Arc minutes.
    attr_reader :arcminute

    # @!attribute [r] arcsecond
    #   @return [Fixnum] Arc seconds.
    attr_reader :arcsecond

    # Creates an angle using the sexagesimal system from an angle in decimal
    # degree.
    #
    # Equation (1.37) in Calendrical Calculations, 3rd edition.
    # Corrected by the errata 23 in Notes and Errata for Calendrical
    # Calculations: Third Edition.
    #
    # @param alpha [Float] an angle (in decimal degree).
    # @return [Angle] an angle using the sexagesimal system.
    def self.from_decimal_degree(alpha)
      angle  = alpha.abs
      degree = angle.floor
      arcminute = (60 * (angle % 1)).floor
      arcsecond = ((60*60*angle) % 60).floor
      if alpha < 0
        return Angle.new(-degree, -arcminute, -arcsecond)
      else
        return Angle.new(degree, arcminute, arcsecond)
      end
    end

    # Creates a new angle using the sexagesimal system.
    #
    # @param degree    [Fixnum] degree.
    # @param arcminute [Fixnum] arcminutes [0; 59].
    # @param arcsecond [Fixnum] arcseconds [0; 59].
    def initialize(degree, arcminute=0, arcsecond=0)
      @degree    = degree
      @arcminute = arcminute
      @arcsecond = arcsecond
    end

    # Converts to an angle in decimal degree.
    #
    # Equation (1.36) in Calendrical Calculations, 3rd edition.
    #
    # @return [Float] an angle (in decimal degree)
    def to_decimal_degree
        return @degree + (@arcminute + (@arcsecond.fdiv(60))).fdiv(60)
    end

    # Compares self against `other`.
    #
    # @param other [Angle] an Angle object.
    # @return -1, 0, or +1 depending on whether self is less than, equal to,
    #   or greater than `other`.
    def <=>(other)
      return nil unless other.class == Angle
      return ([ @degree     , @arcminute     , @arcsecond ] <=>
              [ other.degree, other.arcminute, other.arcsecond ])
    end
  end
end
