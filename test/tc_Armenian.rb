#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestArmenian < Test::Unit::TestCase
  # Sample of 33 dates [ Armenian, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  ARMENIAN_AND_RD =
    [
      [ [ -1138,  4, 10 ], -214193 ],
      [ [  -720, 12,  6 ],  -61387 ],
      [ [  -482, 11, 22 ],   25469 ],
      [ [  -417, 12, 15 ],   49217 ],
      [ [   -82,  6, 10 ],  171307 ],
      [ [    24, 11, 18 ],  210155 ],
      [ [   143,  6,  5 ],  253427 ],
      [ [   462,  2,  3 ],  369740 ],
      [ [   545,  3, 23 ],  400085 ],
      [ [   639,  2, 13 ],  434355 ],
      [ [   689,  2, 13 ],  452605 ],
      [ [   737,  3, 18 ],  470160 ],
      [ [   747,  4, 15 ],  473837 ],
      [ [   840,  6, 23 ],  507850 ],
      [ [   885,  2, 24 ],  524156 ],
      [ [   941,  5, 14 ],  544676 ],
      [ [  1002, 11, 11 ],  567118 ],
      [ [  1009,  4, 25 ],  569477 ],
      [ [  1097,  8, 24 ],  601716 ],
      [ [  1129,  9, 22 ],  613424 ],
      [ [  1165, 10, 24 ],  626596 ],
      [ [  1217, 10,  2 ],  645554 ],
      [ [  1268, 11, 27 ],  664224 ],
      [ [  1288,  7, 24 ],  671401 ],
      [ [  1352,  9,  2 ],  694799 ],
      [ [  1379,  1, 12 ],  704424 ],
      [ [  1391,  2, 20 ],  708842 ],
      [ [  1392,  9, 12 ],  709409 ],
      [ [  1393,  2, 28 ],  709580 ],
      [ [  1441,  8, 22 ],  727274 ],
      [ [  1445,  8,  2 ],  728714 ],
      [ [  1488,  4, 26 ],  744313 ],
      [ [  1544,  1, 15 ],  764652 ],
    ]

  def test_from_rd
    ARMENIAN_AND_RD.each do |armenian_ref, rd|
      # Act.
      armenian = Armenian.from_rd(rd)
      result = [ armenian.year, armenian.month, armenian.day ]
      # Assert.
      assert_equal(armenian_ref, result, 'Armenian::from_rd')
    end
  end

  def test_to_rd
    ARMENIAN_AND_RD.each do |armenian, rd_ref|
      # Act.
      rd = Armenian.new(*armenian).to_rd
      # Assert.
      assert_equal(rd_ref, rd, 'Armenian#to_rd')
    end
  end

  def test_eql_equal
    # Arrange.
    base  = Armenian.new(1970, 1,  1)
    other = Armenian.new(1970, 1,  1)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(true, res, 'Armenian#eql?: equal')
  end

  def test_eql_different
    # Arrange.
    base  = Armenian.new(1970,  1,  1)
    other = Armenian.new(2013, 12, 22)
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Armenian#eql?: different')
  end

  def test_eql_different_type
    # Arrange.
    base  = Armenian.new(1970, 1,  1)
    other = 42
    # Act.
    res = base.eql? other
    # Assert.
    assert_equal(false, res, 'Armenian#eql?: different type')
  end
end

