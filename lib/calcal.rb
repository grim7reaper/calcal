#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

# A Ruby implementation of several calendrical calculations algorithms.
# Most of the algorithms are based on the book "Calendrical Calculations",
# 3rd edition written by Edward M. Reingold and Nachum Dershowitz.
#
# @author Sylvain Laperche <sylvain.laperche@gmx.fr>
module CalCal
  # An array containing the version number.
  # The numbers in the array are the major, minor, and patch versions,
  # respectively.
  VERSION = [ 0, 0, 8 ]

  require 'calcal/clock'
  require 'calcal/functions'
  require 'calcal/gregorian'
  require 'calcal/julian_day'
  require 'calcal/modified_julian_day'
  require 'calcal/moment'
  require 'calcal/rata_die'
end
