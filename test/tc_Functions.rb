#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestFunctions < Test::Unit::TestCase
  def test_signum_negative
    # Arrange.
    x = -42
    # Act.
    res = Functions.signum(x)
    # Assert.
    assert_equal(-1, res, 'signum: negative value')
  end

  def test_signum_zero
    # Arrange.
    x = 0
    # Act.
    res = Functions.signum(x)
    # Assert.
    assert_equal(0, res, 'signum: zero')
  end

  def test_signum_positive
    # Arrange.
    x = 42
    # Act.
    res = Functions.signum(x)
    # Assert.
    assert_equal(1, res, 'signum: positive value')
  end

  def test_remainder_both_positive
    # Arrange.
    x = 9
    y = 5
    # Act.
    res = x%y
    # Assert.
    assert_equal(4, res, 'mod: dividend and divisor positive')
  end

  def test_remainder_negative_dividend
    # Arrange.
    x = -9
    y =  5
    # Act.
    res = x%y
    # Assert.
    assert_equal(1, res, 'mod: negative dividend')
  end

  def test_remainder_negative_divisor
    # Arrange.
    x =  9
    y = -5
    # Act.
    res = x%y
    # Assert.
    assert_equal(-1, res, 'mod: negative divisor')
  end

  def test_remainder_both_negative
    # Arrange.
    x = -9
    y = -5
    # Act.
    res = x%y
    # Assert.
    assert_equal(-4, res, 'mod: negative dividend and divisor')
  end

  def test_remainder_non_integer
    # Arrange.
    x = 5/3.0
    y = 3/4.0
    # Act.
    res = x%y
    # Assert.
    assert_in_delta(1/6.0, res, 1e-5, 'mod: non integer')
  end

  def test_amod
    # Arrange.
    prng  = Random.new
    range = Range.new(-5000, 5000, exclude_end=false)
    1000.times do
      # Act.
      x = prng.rand(range)
      y = prng.rand(range)
      y = prng.rand(range) while (y == 0)
      ref = x - y*((x/y.to_f).ceil - 1)
      res = Functions.amod(x, y)
      # Assert.
      assert_equal(ref, res)
    end
  end

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
      degree = Functions.rad2deg(radian)
      # Assert.
      assert_in_delta(degree_ref, degree, 1e-5, 'radian to degree')
      end
  end

  def test_sump_ok
    # Arrange.
    square = Proc.new { |n| n*n }
    lower_than_5 = Proc.new { |i| i < 5 }
    start = 0
    # Act.
    sum = Functions.sump(square, start, lower_than_5)
    # Assert
    assert_equal(30, sum, 'sump: sum of square in [0, 5[')
  end

  def test_sump_ok_at_start
    # Arrange.
    square = Proc.new { |n| n*n }
    lower_than_5 = Proc.new { |i| i < 5 }
    start = 4
    # Act.
    sum = Functions.sump(square, start, lower_than_5)
    # Assert
    assert_equal(16, sum, 'sump: sum of square in [4, 5[')
  end

  def test_sump_false
    # Arrange.
    square = Proc.new { |n| n*n }
    lower_than_5 = Proc.new { |i| i < 5 }
    start = 5
    # Act.
    sum = Functions.sump(square, start, lower_than_5)
    # Assert
    assert_equal(0, sum, 'sump: predicate false from the start')
  end

  def test_minp
    # Arrange.
    predicate = Proc.new { |i| i.between?(10, 25) }
    start = 0
    # Act.
    res = Functions.minp(predicate, start)
    # Assert.
    assert_equal(10, res, 'minp: first number between in [10, 25]')
  end

  def test_minp_ok_at_start
    # Arrange.
    predicate = Proc.new { |i| i.between?(10, 25) }
    start = 10
    # Act.
    res = Functions.minp(predicate, start)
    # Assert.
    assert_equal(start, res,
                 'minp: first number between in [10, 25], start at 10')
  end

  def test_maxp
    # Arrange.
    predicate = Proc.new { |i| i.between?(10, 25) }
    start = 10
    # Act.
    res = Functions.maxp(predicate, start)
    # Assert.
    assert_equal(25, res, 'maxp: first number between in [10, 25]')
  end

  def test_maxp_ok_at_start
    # Arrange.
    predicate = Proc.new { |i| i.between?(10, 25) }
    start = 25
    # Act.
    res = Functions.maxp(predicate, start)
    # Assert.
    assert_equal(start, res,
                 'maxp: first number between in [10, 25], start at 25')
  end

  def test_maxp_start_false
    # Arrange.
    predicate = Proc.new { |i| i.between?(10, 25) }
    start = 0
    # Act.
    res = Functions.maxp(predicate, start)
    # Assert.
    assert_equal(start-1, res, 'maxp: start with false')
  end

  def test_binary_search
    # Arrange.
    expected = Math::PI
    fun = Proc.new { |x| x**2 }
    y = fun.call(expected)
    precision = 1e-5
    prec_ok = Proc.new { |lo, hi| (fun.call((lo+hi)/2.0) - y).abs <= precision }
    go_left = Proc.new { |x| fun.call(x) - y > 0 }
    # Act.
    res = Functions.binary_search(3, 4, prec_ok, go_left)
    # Assert.
    assert_in_delta(expected, res, precision, 'binary search')
  end

  def test_invert_astronomical
    # Arrange.
    expected = Math::PI/6
    fun = Proc.new { |x| Math.sin(x) }
    y = fun.call(expected)
    precision = 1e-5
    # Act.
    res = Functions.invert_astronomical(fun, y, 0, Math::PI/2)
    # Assert.
    assert_in_delta(expected, res, precision, 'invert_astronomical')
  end
end
