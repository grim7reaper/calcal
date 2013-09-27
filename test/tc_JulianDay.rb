#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestJulianDay < Test::Unit::TestCase
  # Sample of 33 dates [ Julian Day, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  JD_AND_RD =
    [ 
      [ 1507231.5, -214193 ], [ 1660037.5,  -61387 ], [ 1746893.5,   25469 ], 
      [ 1770641.5,   49217 ], [ 1892731.5,  171307 ], [ 1931579.5,  210155 ],
      [ 1974851.5,  253427 ], [ 2091164.5,  369740 ], [ 2121509.5,  400085 ],
      [ 2155779.5,  434355 ], [ 2174029.5,  452605 ], [ 2191584.5,  470160 ],
      [ 2195261.5,  473837 ], [ 2229274.5,  507850 ], [ 2245580.5,  524156 ],
      [ 2266100.5,  544676 ], [ 2288542.5,  567118 ], [ 2290901.5,  569477 ],
      [ 2323140.5,  601716 ], [ 2334848.5,  613424 ], [ 2348020.5,  626596 ],
      [ 2366978.5,  645554 ], [ 2385648.5,  664224 ], [ 2392825.5,  671401 ],
      [ 2416223.5,  694799 ], [ 2425848.5,  704424 ], [ 2430266.5,  708842 ],
      [ 2430833.5,  709409 ], [ 2431004.5,  709580 ], [ 2448698.5,  727274 ],
      [ 2450138.5,  728714 ], [ 2465737.5,  744313 ], [ 2486076.5,  764652 ],
    ]

  def test_from_rd
    JD_AND_RD.each do |jd_ref, rd|
      # Act.
      jd = JulianDay.from_rd(rd)
      # Assert.
      assert_equal(jd_ref, jd.julian_day, 'JulianDay::from_rd')
    end
  end

  def test_to_rd
    JD_AND_RD.each do |jd, rd_ref|
      # Act.
      rd = JulianDay.new(jd).to_rd
      # Assert.
      assert_equal(rd_ref, rd, 'JulianDay#to_rd')
    end
  end
end
