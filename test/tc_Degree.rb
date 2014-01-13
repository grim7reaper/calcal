#encoding: utf-8

# Copyright (c) 2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestDegree < Test::Unit::TestCase
  RAD_AND_DEG = [ [  0            ,   0 ], [    Math::PI/12,  15 ],
                  [    Math::PI/6 ,  30 ], [    Math::PI/5 ,  36 ],
                  [    Math::PI/4 ,  45 ], [    Math::PI/3 ,  60 ],
                  [ (2*Math::PI)/5,  72 ], [    Math::PI/2 ,  90 ],
                  [ (2*Math::PI)/3, 120 ], [ (4*Math::PI)/5, 144 ],
                  [    Math::PI   , 180 ], [ (3*Math::PI)/2, 270 ],
                  [  2*Math::PI   , 360 ] ]

  def test_from_radian
    RAD_AND_DEG.each do |radian, degree_ref|
      # Act.
      degree = Degree.from_radian(radian)
      # Assert.
      assert_in_delta(degree_ref, degree, 1e-5, 'radian to degree')
    end
  end

  def test_to_radian
    RAD_AND_DEG.each do |radian_ref, degree|
      # Act.
      radian = Degree.to_radian(degree)
      # Assert.
      assert_in_delta(radian_ref, radian, 1e-5, 'degree to radian')
    end
  end

  def test_sin
    RAD_AND_DEG.each do |radian, degree|
      # Arrange.
      expected = Math.sin(radian)
      # Act.
      result = Degree.sin(degree)
      # Assert.
      assert_in_delta(expected, result, 1e-5, 'Degree::sin')
    end
  end

  def test_cos
    RAD_AND_DEG.each do |radian, degree|
      # Arrange.
      expected = Math.cos(radian)
      # Act.
      result = Degree.cos(degree)
      # Assert.
      assert_in_delta(expected, result, 1e-5, 'Degree::cos')
    end
  end

  def test_tan
    RAD_AND_DEG.each do |radian, degree|
      # Arrange.
      expected = Math.tan(radian)
      # Act.
      result = Degree.tan(degree)
      # Assert.
      assert_in_delta(expected, result, 1e-5, 'Degree::tan')
    end
  end

  def test_asin
    # Arrange.
    deg_and_sin = [ [   0 , Degree.sin(  0) ], [  15, Degree.sin( 15) ],
                    [  30 , Degree.sin( 30) ], [  36, Degree.sin( 36) ],
                    [  45 , Degree.sin( 45) ], [  60, Degree.sin( 60) ],
                    [  72 , Degree.sin( 72) ], [  90, Degree.sin( 90) ] ]
    deg_and_sin.each do |degree_ref, x|
      # Act.
      degree = Degree.asin(x)
      # Assert.
      assert_in_delta(degree_ref, degree, 1e-5, 'Degree::asin')
    end
  end

  def test_acos
    # Arrange.
    deg_and_cos = [ [   0 , Degree.cos(  0) ], [  15, Degree.cos( 15) ],
                    [  30 , Degree.cos( 30) ], [  36, Degree.cos( 36) ],
                    [  45 , Degree.cos( 45) ], [  60, Degree.cos( 60) ],
                    [  72 , Degree.cos( 72) ], [  90, Degree.cos( 90) ] ]
    deg_and_cos.each do |degree_ref, x|
      # Act.
      degree = Degree.acos(x)
      # Assert.
      assert_in_delta(degree_ref, degree, 1e-5, 'Degree::acos')
    end
  end

  def test_atan2_0_0
    # Act.
    result = Degree.atan2(0, 0)
    # Assert.
    assert(result.nan?, 'Degree::atan2(0, 0)')
  end

  def test_atan2_1_0
    # Arrange.
    expected = 90
    # Act.
    result = Degree.atan2(1, 0)
    # Assert.
    assert_in_delta(expected, result, 1e-5, 'Degree::atan2(1, 0)')
  end

  def test_atan2_1_1
    # Arrange.
    expected = 45
    # Act.
    result = Degree.atan2(1, 1)
    # Assert.
    assert_in_delta(expected, result, 1e-5, 'Degree::atan2(1, 1)')
  end

  def test_atan2_neg1_1
    # Arrange.
    expected = 315
    # Act.
    result = Degree.atan2(-1, 1)
    # Assert.
    assert_in_delta(expected, result, 1e-5, 'Degree::atan2(-1, 1)')
  end

  def test_atan2_1_neg1
    # Arrange.
    expected = 135
    # Act.
    result = Degree.atan2(1, -1)
    # Assert.
    assert_in_delta(expected, result, 1e-5, 'Degree::atan2(1, -1)')
  end

  def test_atan2_neg1_neg1
    # Arrange.
    expected = 225
    # Act.
    result = Degree.atan2(-1, -1)
    # Assert.
    assert_in_delta(expected, result, 1e-5, 'Degree::atan2(-1, -1)')
  end
end
