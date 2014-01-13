#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestRataDie < Test::Unit::TestCase
  def test_from_rd
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      t    = prng.rand(range)
      date = RataDie.from_rd(t)
      # Assert.
      assert_equal(t, date.rata_die, 'RataDie::from_rd')
    end
  end

  def test_from_date
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      t    = prng.rand(range)
      date = RataDie.new(t)
      rd   = RataDie.from_date(date)
      # Assert.
      assert_equal(t, rd.rata_die, 'RataDie::from_date')
    end
  end

  def test_to_rd
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      t    = prng.rand(range)
      date = RataDie.new(t)
      rd   = date.to_rd
      # Assert.
      assert_equal(t, rd, 'RataDie#to_rd')
    end
  end

  def test_valid
    # Arrange.
    prng  = Random.new
    range = Range.new(-1_000_000, 1_000_000, exclude_end=false)
    200.times do
      # Act.
      date = RataDie.new(prng.rand(range))
      # Assert.
      assert(date.valid?, 'RataDie#valid?')
    end
  end

  def test_add
    # Arrange.
    prng  = Random.new
    range = Range.new(-50, 50, exclude_end=false)
    date  = RataDie.new(42)
    200.times do
      # Act.
      n = prng.rand(range)
      after = date + n
      # Assert.
      assert_equal(42 + n, after.rata_die, '+ operator')
    end
  end

  def test_subtract
    # Arrange.
    prng  = Random.new
    range = Range.new(-50, 50, exclude_end=false)
    date  = RataDie.new(42)
    200.times do
      # Act.
      n = prng.rand(range)
      after = date - n
      # Assert.
      assert_equal(42 - n, after.rata_die, '- operator')
    end
  end

  def test_eql_equal
    # Arrange.
    base  = RataDie.new(42)
    other = RataDie.new(42)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(true, res, 'RataDie#eql?: equal')
  end

  def test_eql_different
    # Arrange.
    base  = RataDie.new(42)
    other = RataDie.new(77)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'RataDie#eql?: different')
  end

  def test_eql_different_type
    # Arrange.
    base  = RataDie.new(42)
    other = 42
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'RataDie#eql?: different type')
  end

  def test_cmp_equal
    # Arrange.
    base  = RataDie.new(42)
    other = RataDie.new(42)
    # Act.
    res = base <=> other
    # Assert.
    assert_equal(0, res, '<=> operator: equality')
  end

  def test_cmp_lower
    # Arrange.
    base  = RataDie.new(42)
    other = RataDie.new(77)
    # Act.
    res = base <=> other
    # Assert.
    assert_equal(-1, res, '<=> operator: lower')
  end

  def test_cmp_higher
    # Arrange.
    base  = RataDie.new(42)
    other = RataDie.new(3)
    # Act.
    res = base <=> other
    # Assert.
    assert_equal(1, res, '<=> operator: higher')
  end

  def test_cmp_impossible
    # Arrange.
    base  = RataDie.new(42)
    other = 42
    # Assert
    res = base <=> other
    # Assert.
    assert_equal(nil, res, '<=> operator: impossible')
  end
end
