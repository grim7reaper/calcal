#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestMoment < Test::Unit::TestCase
  def test_from_rd
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      t    = prng.rand(range)
      date = Moment.from_rd(t)
      # Assert.
      assert_equal(t, date.moment, 'Moment::from_rd')
    end
  end

  def test_to_rd
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      t    = prng.rand(range)
      t   += 0.5 if t.odd?
      date = Moment.new(t)
      rd   = date.to_rd
      # Assert.
      assert_equal(t.floor, rd, 'Moment#to_rd')
    end
  end

  def test_eql_equal
    # Arrange.
    base  = Moment.new(42)
    other = Moment.new(42)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(true, res, 'Moment#eql?: equal')
  end

  def test_eql_different
    # Arrange.
    base  = Moment.new(42)
    other = Moment.new(77)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Moment#eql?: different')
  end

  def test_eql_different_type
    # Arrange.
    base  = Moment.new(42)
    other = 42
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Moment#eql?: different type')
  end

  def test_time_of_day
    # Arrange.
    date = Moment.new(42)
    # Act.
    res = date.time_of_day
    # Assert.
    assert_equal(0, res, 'Moment#time_of_day: 0')
  end

  def test_time_of_day_noon
    # Arrange.
    date = Moment.new(42.5)
    # Act.
    res = date.time_of_day
    # Assert.
    assert_equal(0.5, res, 'Moment#time_of_day: noon')
  end
end
