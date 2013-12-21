#encoding: utf-8

# Copyright (c) 2013, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

# TODO: more tests.

class TestAngle < Test::Unit::TestCase
  def test_from_decimal_degree
    # Arrange.
    decimal_degree = 12.76389
    expected = Angle.new(12, 45, 50)
    # Act
    result = Angle.from_decimal_degree(decimal_degree)
    # Assert
    assert(expected == result, "Angle::from_decimal_degree")
  end

  def test_from_decimal_degree_negative
    # Arrange.
    decimal_degree = -12.76389
    expected = Angle.new(-12, -45, -50)
    # Act
    result = Angle.from_decimal_degree(decimal_degree)
    # Assert
    assert(expected == result, "Angle::from_decimal_degree with negative value")
  end


  def test_to_decimal_degree
    # Arrange.
    angle = Angle.new(12, 45, 50)
    expected = 12.76389
    # Act
    result = angle.to_decimal_degree()
    # Assert
    assert_in_delta(expected, result, 1e-5, "Angle#to_decimal_degree")
  end
end
