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
    # @return [Fixnum] -1 when `x` is negative, +1 when `x` is positive, 0 when
    #                  `x` is 0.
    def self.signum(x)
      return x <=> 0
    end

    # Adjusted remainder function.
    #
    # Equation (1.22) in Calendrical Calculations, 3rd edition.
    #
    # @param x [Numeric] the dividend.
    # @param y [Numeric] the divisor.
    # @return [Numeric] the same as `x` % `y`, but with `x` instead of 0.
    def self.amod(x, y)
      return y + x % (-y)
    end

    # Converts angle `x` from radians to degrees.
    #
    # @param x [Numeric] angle (radian).
    # @return [Numeric] angle (degree).
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
    # @return [Integer] the sum of f(i) from i=k, k+1, ... till p(i) holds true.
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
    # @return [Integer] the first integer greater or equal to `d` such that p(i)
    #                   holds true.
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
    # @return [Integer] the last integer greater or equal to `d` such that p(i)
    #                   holds true.
    def self.maxp(p, d)
      i = d
      i += 1 while p.call(i)
      return i-1
    end

    # Binary search of a value `x` (with a given precision criteria) for a
    # function `f(x) = y` knowing `y`.
    #
    # The search is done in the interval [lo, hi].
    #
    # Equation (1.31) in Calendrical Calculations, 3rd edition.
    #
    # @param lo [Numeric] lower bound of the search interval.
    # @param hi [Numeric] upper bound of the search interval.
    # @param prec_ok [Proc] precision criteria.
    # @param go_left [Proc] predicate used to determine when to go left.
    # @return [Numeric] the value `x`.
    def self.binary_search(lo, hi, prec_ok, go_left)
      x = (lo + hi) / 2.0
      until prec_ok.call(lo, hi)
        if go_left.call(x)
          hi = x
        else
          lo = x
        end
        x = (lo + hi) / 2.0
      end
      return x
    end

    # Find inverse of the astronomical function `fun` within the interval
    # [lo, # hi].
    #
    # Precision is 1e-5.
    #
    # Equation (1.31) in Calendrical Calculations, 3rd edition.
    #
    # @param fun [Proc]    astronomical function to invert.
    # @param y   [Numeric] desired value (in degree).
    # @param lo  [Numeric] lower bound of the search interval.
    # @param hi  [Numeric] upper bound of the search interval.
    # @return a moment `x` such  that fun(x) = y.
    def self.invert_astronomical(fun, y, lo, hi)
      precision = 1e-5
      prec_ok = Proc.new { |lo, hi| (hi - lo) <= precision }
      go_left = Proc.new { |x| (fun.call(x) - y) % 360 < 180 }
      return binary_search(lo, hi, prec_ok, go_left)
    end
  end
end
