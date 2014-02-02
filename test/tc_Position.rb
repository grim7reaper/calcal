#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestPosition < Test::Unit::TestCase

  # Location of Urbana, Illinois.
  # Equation (13.1) of Calendrical Calculations, 3rd edition.
  URBANA = Position.new(40.1, -88.2, 225, Clock.new(-6, 0, 0).to_dayfraction)
  # Location of Mecca.
  # Equation (13.3) of Calendrical Calculations, 3rd edition.
  MECCA = Position.new(Angle.new(21, 25, 24).to_decimal_degree,
                       Angle.new(39, 49, 24).to_decimal_degree,
                       298, Clock.new(3, 0, 0).to_dayfraction)
  # Location of Jerusalem.
  # Equation (13.4) of Calendrical Calculations, 3rd edition.
  JERUSALEM = Position.new(31.8, 35.2, 800, Clock.new(2, 0, 0).to_dayfraction)

  # There is no defined longitude and timezone at the poles, thus we use 0.
  NORTH_POLE = Position.new( 90, 0, -427, Clock.new(0, 0, 0).to_dayfraction)
  SOUTH_POLE = Position.new(-90, 0, 2835, Clock.new(0, 0, 0).to_dayfraction)

  def test_urbana_mecca
    # Arrange.
    # p.174 of Calendrical Calculations, 3rd edition.
    expected = 49
    # Act
    result = URBANA.direction(MECCA)
    # Assert
    assert_in_delta(expected, result, 0.5, "Urbana to Mecca")
  end

  def test_urbana_jerusalem
    # Arrange.
    # p.174 of Calendrical Calculations, 3rd edition.
    expected = 45
    # Act
    result = URBANA.direction(JERUSALEM)
    # Assert
    assert_in_delta(expected, result, 0.5, "Urbana to Jerusalem")
  end

  def test_urbana_urbana
    # Arrange.
    expected = 0.0
    # Act
    result = URBANA.direction(URBANA)
    # Assert
    assert_in_delta(expected, result, 1e-5, "Urbana to Urbana")
  end

  def test_urbana_north_pole
    # Arrange.
    expected = 0.0
    # Act
    result = URBANA.direction(NORTH_POLE)
    # Assert
    assert_in_delta(expected, result, 1e-5, "Urbana to North Pole")
  end


  def test_urbana_south_pole
    # Arrange.
    expected = 180.0
    # Act
    result = URBANA.direction(SOUTH_POLE)
    # Assert
    assert_in_delta(expected, result, 1e-5, "Urbana to South Pole")
  end
end
