#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

module CalCal
  # This module contains functions used to do various conversions.
  module Convert
    # Converts angle `x` from radians to degrees.
    #
    # @param x [Numeric] angle (radian).
    # @return [Numeric] angle (degree).
    def self.rad2deg(x)
      return (x*180)/Math::PI
    end

    # Converts a clock time (hh:mm:ss) into a fraction of day.
    #
    # @param hour   [Fixnum] hour.
    # @param minute [Fixnum] minute.
    # @param second [Fixnum] second.
    # @return [Numeric] fraction of day.
    def self.clock2dayfraction(hour, minute, second)
      return 1.fdiv(24) * (hour + (minute + second.fdiv(60)).fdiv(60))
    end
  end
end
