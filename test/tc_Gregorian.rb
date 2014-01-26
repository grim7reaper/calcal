#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestGregorian < Test::Unit::TestCase
  # Sample of 33 dates [ Gregorian, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  GREGORIAN_AND_RD =
    [
      [ [ -586,  7, 24 ], -214193 ],
      [ [ -168, 12,  5 ],  -61387 ],
      [ [   70,  9, 24 ],   25469 ],
      [ [  135, 10,  2 ],   49217 ],
      [ [  470,  1,  8 ],  171307 ],
      [ [  576,  5, 20 ],  210155 ],
      [ [  694, 11, 10 ],  253427 ],
      [ [ 1013,  4, 25 ],  369740 ],
      [ [ 1096,  5, 24 ],  400085 ],
      [ [ 1190,  3, 23 ],  434355 ],
      [ [ 1240,  3, 10 ],  452605 ],
      [ [ 1288,  4,  2 ],  470160 ],
      [ [ 1298,  4, 27 ],  473837 ],
      [ [ 1391,  6, 12 ],  507850 ],
      [ [ 1436,  2,  3 ],  524156 ],
      [ [ 1492,  4,  9 ],  544676 ],
      [ [ 1553,  9, 19 ],  567118 ],
      [ [ 1560,  3,  5 ],  569477 ],
      [ [ 1648,  6, 10 ],  601716 ],
      [ [ 1680,  6, 30 ],  613424 ],
      [ [ 1716,  7, 24 ],  626596 ],
      [ [ 1768,  6, 19 ],  645554 ],
      [ [ 1819,  8,  2 ],  664224 ],
      [ [ 1839,  3, 27 ],  671401 ],
      [ [ 1903,  4, 19 ],  694799 ],
      [ [ 1929,  8, 25 ],  704424 ],
      [ [ 1941,  9, 29 ],  708842 ],
      [ [ 1943,  4, 19 ],  709409 ],
      [ [ 1943, 10,  7 ],  709580 ],
      [ [ 1992,  3, 17 ],  727274 ],
      [ [ 1996,  2, 25 ],  728714 ],
      [ [ 2038, 11, 10 ],  744313 ],
      [ [ 2094,  7, 18 ],  764652 ],
    ]

  def test_from_rd
    GREGORIAN_AND_RD.each do |gregorian_ref, rd|
      # Act.
      gregorian = Gregorian.from_rd(rd)
      result = [ gregorian.year, gregorian.month, gregorian.day ]
      # Assert.
      assert_equal(gregorian_ref, result, 'Gregorian::from_rd')
    end
  end

  def test_to_rd
    GREGORIAN_AND_RD.each do |gregorian, rd_ref|
      # Act.
      rd = Gregorian.new(*gregorian).to_rd
      # Assert.
      assert_equal(rd_ref, rd, 'Gregorian#to_rd')
    end
  end

  def test_leap_day_leap_year
    # Arrange
    date = Gregorian.new(2000, 2, 29)
    # Act.
    valid = date.valid?
    # Assert.
    assert_equal(true, valid, 'Gregorian#valid?: 2000/02/29')
  end

  def test_leap_day_not_leap_year
    # Arrange
    date = Gregorian.new(1900, 2, 29)
    # Act.
    valid = date.valid?
    # Assert.
    assert_equal(false, valid, 'Gregorian#valid?: 1900/02/29')
  end

  def test_end_leap_year
    # Arrange
    date = Gregorian.new(2000, 12, 31)
    # Act.
    valid = date.valid?
    # Assert.
    assert_equal(true, valid, 'Gregorian#valid?: 2000/12/31')
  end

  def test_end_year
    # Arrange
    date = Gregorian.new(1900, 12, 31)
    # Act.
    valid = date.valid?
    # Assert.
    assert_equal(true, valid, 'Gregorian#valid?: 1900/12/31')
  end
 
  def test_year_multiple_of_4_not_100
    # Arrange
    date = Gregorian.new(2004, 1, 1)
    # Act.
    is_leap_year = date.leap?
    # Assert.
    assert(is_leap_year, 'Year multiple of 4, not multiple of 100')
  end

  def test_year_multiple_of_400
    # Arrange
    date = Gregorian.new(2000, 1, 1)
    # Act.
    is_leap_year = date.leap?
    # Assert.
    assert(is_leap_year, 'Year multiple of 400')
  end

  def test_year_not_multiple_of_4
    # Arrange
    date = Gregorian.new(2002, 1, 1)
    # Act.
    is_leap_year = date.leap?
    # Assert.
    assert(is_leap_year == false, 'Year not multiple of 4')
  end

  def test_year_multiple_of_4_and_100
    # Arrange
    date = Gregorian.new(1900, 1, 1)
    # Act.
    is_leap_year = date.leap?
    # Assert.
    assert(is_leap_year == false, 'Year multiple of 4 and 100')
  end

  def test_against_reference_implementation
    # Arrange.
    prng  = Random.new
    range = Range.new(-5000, 5000, exclude_end=false)
    1000.times do
      # Act.
      year      = prng.rand(range)
      result    = Gregorian.leap_year?(year)
      reference = Date.gregorian_leap?(year)
      # Assert.
      assert_equal(reference, result)
    end
  end

  def test_subtract_date_integer
    # Arrange.
    date     = Gregorian.new(2014,  1, 26)
    expected = Gregorian.new(2013, 12, 31) 
    # Act.
    result = date - 26
    # Assert.
    assert_equal(expected, result, '- operator (date - integer)')
  end

  def test_subtract_date_date
    # Arrange.
    date1 = Gregorian.new(2014,  1, 26)
    date2 = Gregorian.new(2013, 12, 31) 
    expected = 26
    # Act.
    result = date1 - date2
    # Assert.
    assert_equal(expected, result, '- operator (date - date)')
  end

  def test_eql_equal
    # Arrange.
    base  = Gregorian.new(1970, 1,  1)
    other = Gregorian.new(1970, 1,  1)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(true, res, 'Gregorian#eql?: equal')
  end

  def test_eql_different
    # Arrange.
    base  = Gregorian.new(1970, 1,  1)
    other = Gregorian.new(2013, 9, 28)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Gregorian#eql?: different')
  end

  def test_eql_different_type
    # Arrange.
    base  = Gregorian.new(1970, 1,  1)
    other = 42
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Gregorian#eql?: different type')
  end
end
