#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestModifiedJulianDay < Test::Unit::TestCase
  # Sample of 33 dates [ Modified Julian Day, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  MJD_AND_RD =
    [
      [ -892769, -214193 ], [ -739963,  -61387 ], [ -653107,   25469 ],
      [ -629359,   49217 ], [ -507269,  171307 ], [ -468421,  210155 ],
      [ -425149,  253427 ], [ -308836,  369740 ], [ -278491,  400085 ],
      [ -244221,  434355 ], [ -225971,  452605 ], [ -208416,  470160 ],
      [ -204739,  473837 ], [ -170726,  507850 ], [ -154420,  524156 ],
      [ -133900,  544676 ], [ -111458,  567118 ], [ -109099,  569477 ],
      [  -76860,  601716 ], [  -65152,  613424 ], [  -51980,  626596 ],
      [  -33022,  645554 ], [  -14352,  664224 ], [   -7175,  671401 ],
      [   16223,  694799 ], [   25848,  704424 ], [   30266,  708842 ],
      [   30833,  709409 ], [   31004,  709580 ], [   48698,  727274 ],
      [   50138,  728714 ], [   65737,  744313 ], [   86076,  764652 ],
    ]

  def test_from_rd
    MJD_AND_RD.each do |mjd_ref, rd|
      # Act.
      mjd = ModifiedJulianDay.from_rd(rd)
      # Assert.
      assert_equal(mjd_ref, mjd.modified_julian_day,
                   'ModifiedJulianDay::from_rd')
    end
  end

  def test_to_rd
    MJD_AND_RD.each do |mjd, rd_ref|
      # Act.
      rd = ModifiedJulianDay.new(mjd).to_rd
      # Assert.
      assert_equal(rd_ref, rd, 'ModifiedJulianDay#to_rd')
    end
  end
end

