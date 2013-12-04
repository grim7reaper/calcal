#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestConvert < Test::Unit::TestCase
  def test_rad2deg
    # Arrange.
    rad2deg = [ [  0           ,    0 ], [    Math::PI/12,  15 ],
                [    Math::PI/6,   30 ], [    Math::PI/5 ,  36 ],
                [    Math::PI/4,   45 ], [    Math::PI/3 ,  60 ],
                [ (2*Math::PI)/5,  72 ], [    Math::PI/2 ,  90 ],
                [ (2*Math::PI)/3, 120 ], [ (4*Math::PI)/5, 144 ],
                [    Math::PI   , 180 ], [ (3*Math::PI)/2, 270 ],
                [  2*Math::PI   , 360 ] ]
    rad2deg.each do |radian, degree_ref|
      # Act.
      degree = Convert.rad2deg(radian)
      # Assert.
      assert_in_delta(degree_ref, degree, 1e-5, 'radian to degree')
      end
  end

  def test_clock2dayfraction
    # Arrange.
    clock2dayfraction = [ [ [ 1,  0, 0 ], 1.0/24 ],      #  1 h   = 1/24th   day
                          [ [ 0, 30, 0 ], 1.0/48 ],      # 30 min = 1/48th   day
                          [ [ 0,  1, 0 ], 1.0/(24*60) ], #  1 min = 1/60th   day
                          [ [ 0,  0, 1 ], 1.0/(24*60*60) ], # 1s  = 1/3600th day
                          [ [ 4, 48, 0 ], 1.0/5 ] ]      #          1/5th    day
    clock2dayfraction.each do |clock, dayfrac_ref|
      # Act.
      dayfrac = Convert.clock2dayfraction(*clock)
      # Assert.
      assert_in_delta(dayfrac_ref, dayfrac, 1e-5, 'clock to fraction of day')
      end

  end
end
