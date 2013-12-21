#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestClock < Test::Unit::TestCase

  def test_clock2dayfraction
    # Arrange.
    clock2dayfraction = [ # 1 h = 1/24th day
                          [ Clock.new(1,  0, 0), 1.0/24 ],
                          # 30 min = 1/48th day
                          [ Clock.new(0, 30, 0), 1.0/48 ],
                          # 1 min = 1/60th day
                          [ Clock.new(0,  1, 0), 1.0/(24*60) ],
                          # 1s = 1/3600th day
                          [ Clock.new(0,  0, 1), 1.0/(24*60*60) ],
                          # 1/5th day
                          [ Clock.new(4, 48, 0), 1.0/5 ] ]
    clock2dayfraction.each do |clock, dayfrac_ref|
      # Act.
      dayfrac = clock.to_dayfraction
      # Assert.
      assert_in_delta(dayfrac_ref, dayfrac, 1e-5, 'clock to fraction of day')
      end
  end
end
