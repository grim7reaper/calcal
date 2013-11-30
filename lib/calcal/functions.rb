#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

module CalCal

  # This module contains some useful functions.
  module Functions
    # Returns the sign of `x`.
    #
    # Equation (1.14) in Calendrical Calculations, 3rd edition.
    #
    # @param x [Numeric] a number.
    # @return -1 when `x` is negative, +1 when `x` is positive, 0 when `x` is 0.
    def self.signum(x)
      return x <=> 0
    end

    # Adjusted remainder function.
    #
    # Equation (1.22) in Calendrical Calculations, 3rd edition.
    #
    # @param x [Numeric] the dividend.
    # @param y [Numeric] the divisor.
    # @return the same as `x` % `y`, but with `x` instead of 0.
    def self.amod(x, y)
      return y + x % (-y)
    end

    # Converts angle `x` from radians to degrees.
    #
    # @param x [Numeric] angle (radian).
    # @return angle (degree).
    def self.rad2deg(x)
      return (x*180)/Math::PI
    end

    # Return the sum of f(i) from i=k, k+1, ... till p(i) holds true.
    #
    # Equation (1.27) in Calendrical Calculations, 3rd edition.
    #
    # @param f [Proc]    function to apply.
    # @param k [Integer] starting value.
    # @param p [Proc]    predicate.
    # @return the sum of f(i) from i=k, k+1, ... till p(i) holds true.
    def self.sump(f, k, p)
      acc = 0
      i   = k
      while p.call(i)
        acc += f.call(i)
        i += 1
      end
      return acc
    end

    # Return the first integer greater or equal to `d` such that p(i) holds
    # true.
    #
    # Equation (1.28) in Calendrical Calculations, 3rd edition.
    #
    # @param p [Proc]    predicate.
    # @param d [Integer] starting value.
    # @return the first integer greater or equal to `d` such that p(i) holds
    # true.
    def self.minp(p, d)
      i = d
      i += 1 until p.call(i)
      return i
    end

    # Return the last integer greater or equal to `d` such that p(i) holds true.
    #
    # Equation (1.29) in Calendrical Calculations, 3rd edition.
    #
    # @param p [Proc]    predicate.
    # @param d [Integer] starting value.
    # @return the last integer greater or equal to `d` such that p(i) holds
    # true.
    def self.maxp(p, d)
      i = d
      i += 1 while p.call(i)
      return i-1
    end
  end
end
