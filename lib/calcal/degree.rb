#encoding: utf-8

# Copyright (c) 2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'calcal/functions'

module CalCal
  # This module contains trigonometric functions that works with degrees.
  module Degree
    # Converts angle `x` from radians to degrees.
    #
    # @param x [Float] angle (radian).
    # @return [Float] angle (degree).
    def self.from_radian(x)
      return (x*180)/Math::PI
    end

    # Converts angle `x` from degrees to radians.
    #
    # @param x [Float] angle (degree).
    # @return [Float] angle (radian).
    def self.to_radian(x)
      return (x*Math::PI)/180
    end

    # Computes the sine of `x`.
    #
    # @param x [Float] angle (degree).
    # @return [Float] sine of `x`.
    def self.sin(x)
      return Math.sin(to_radian(x))
    end

    # Computes the cosine of `x`.
    #
    # @param x [Float] angle (degree).
    # @return [Float] cosine of `x`.
    def self.cos(x)
      return Math.cos(to_radian(x))
    end

    # Computes the tangent of `x`.
    #
    # @param x [Float] angle (degree).
    # @return [Float] tangent of `x`.
    def self.tan(x)
      return Math.tan(to_radian(x))
    end

    # Computes the arc sine of `x`.
    #
    # @param x [Float] x.
    # @return [Float] arc sine of `x` (degree).
    def self.asin(x)
      return from_radian(Math.asin(x))
    end

    # Computes the arc cosine of `x`.
    #
    # @param x [Float] x.
    # @return [Float] arc cosine of `x` (degree).
    def self.acos(x)
      return from_radian(Math.acos(x))
    end

    # Computes the arc tangent given `y` and `x`.
    #
    # Equation (13.6) of Calendrical Calculations, 3rd edition.
    # Corrected by the errata 23 in Notes and Errata for Calendrical
    # Calculations: Third Edition.
    #
    # @note When both parameters are 0, return Float::NAN.
    #
    # @param x [Float] x.
    # @param y [Float] y.
    # @return [Float] arc tangent of `x`/`y` (degree).
    def self.atan2(y, x)
      if x == 0 && y != 0
        res = Functions.signum(y)*90
      elsif x >= 0
        res = from_radian(Math.atan(y.fdiv(x)))
      else
        res = from_radian(Math.atan(y.fdiv(x))) + 180
      end
      return res % 360
    end
  end
end
