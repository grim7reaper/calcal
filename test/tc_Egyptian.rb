#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestEgyptian < Test::Unit::TestCase
  # Sample of 33 dates [ Egyptian, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  EGYPTIAN_AND_RD =
    [
      [ [  161,  7, 15 ],  -214193 ],
      [ [  580,  3,  6 ],   -61387 ],
      [ [  818,  2, 22 ],    25469 ],
      [ [  883,  3, 15 ],    49217 ],
      [ [ 1217,  9, 15 ],   171307 ],
      [ [ 1324,  2, 18 ],   210155 ],
      [ [ 1442,  9, 10 ],   253427 ],
      [ [ 1761,  5,  8 ],   369740 ],
      [ [ 1844,  6, 28 ],   400085 ],
      [ [ 1938,  5, 18 ],   434355 ],
      [ [ 1988,  5, 18 ],   452605 ],
      [ [ 2036,  6, 23 ],   470160 ],
      [ [ 2046,  7, 20 ],   473837 ],
      [ [ 2139,  9, 28 ],   507850 ],
      [ [ 2184,  5, 29 ],   524156 ],
      [ [ 2240,  8, 19 ],   544676 ],
      [ [ 2302,  2, 11 ],   567118 ],
      [ [ 2308,  7, 30 ],   569477 ],
      [ [ 2396, 11, 29 ],   601716 ],
      [ [ 2428, 12, 27 ],   613424 ],
      [ [ 2465,  1, 24 ],   626596 ],
      [ [ 2517,  1,  2 ],   645554 ],
      [ [ 2568,  2, 27 ],   664224 ],
      [ [ 2587, 10, 29 ],   671401 ],
      [ [ 2651, 12,  7 ],   694799 ],
      [ [ 2678,  4, 17 ],   704424 ],
      [ [ 2690,  5, 25 ],   708842 ],
      [ [ 2691, 12, 17 ],   709409 ],
      [ [ 2692,  6,  3 ],   709580 ],
      [ [ 2740, 11, 27 ],   727274 ],
      [ [ 2744, 11,  7 ],   728714 ],
      [ [ 2787,  8,  1 ],   744313 ],
      [ [ 2843,  4, 20 ],   764652 ],
    ]

  def test_from_rd
    EGYPTIAN_AND_RD.each do |egyptian_ref, rd|
      # Act.
      egyptian = Egyptian.from_rd(rd)
      result = [ egyptian.year, egyptian.month, egyptian.day ]
      # Assert.
      assert_equal(egyptian_ref, result, 'Egyptian::from_rd')
    end
  end

  def test_to_rd
    EGYPTIAN_AND_RD.each do |egyptian, rd_ref|
      # Act.
      rd = Egyptian.new(*egyptian).to_rd
      # Assert.
      assert_equal(rd_ref, rd, 'Egyptian#to_rd')
    end
  end

  def test_eql_equal
    # Arrange.
    base  = Egyptian.new(1970, 1,  1)
    other = Egyptian.new(1970, 1,  1)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(true, res, 'Egyptian#eql?: equal')
  end

  def test_eql_different
    # Arrange.
    base  = Egyptian.new(1970, 1,  1)
    other = Egyptian.new(2013, 9, 28)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Egyptian#eql?: different')
  end

  def test_eql_different_type
    # Arrange.
    base  = Egyptian.new(1970, 1,  1)
    other = 42
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Egyptian#eql?: different type')
  end
end
