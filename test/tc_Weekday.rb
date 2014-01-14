#encoding: utf-8

# Copyright (c) 2013-2014, Sylvain LAPERCHE
# All rights reserved.
# License: BSD 3-Clause (http://opensource.org/licenses/BSD-3-Clause)

require 'test/unit'

require 'calcal'
include CalCal

class TestWeekday < Test::Unit::TestCase
  DATE = 734452 # 11/11/2011, a Friday

  # Sample of 33 dates [ Weekday, Rata Die ]
  # from Appendix C of Calendrical Calculations 3rd edition.
  WEEKDAY_AND_RD =
    [
      [ Weekday::SUNDAY   , -214193 ],
      [ Weekday::WEDNESDAY,  -61387 ],
      [ Weekday::WEDNESDAY,   25469 ],
      [ Weekday::SUNDAY   ,   49217 ],
      [ Weekday::WEDNESDAY,  171307 ],
      [ Weekday::MONDAY   ,  210155 ],
      [ Weekday::SATURDAY ,  253427 ],
      [ Weekday::SUNDAY   ,  369740 ],
      [ Weekday::SUNDAY   ,  400085 ],
      [ Weekday::FRIDAY   ,  434355 ],
      [ Weekday::SATURDAY ,  452605 ],
      [ Weekday::FRIDAY   ,  470160 ],
      [ Weekday::SUNDAY   ,  473837 ],
      [ Weekday::SUNDAY   ,  507850 ],
      [ Weekday::WEDNESDAY,  524156 ],
      [ Weekday::SATURDAY ,  544676 ],
      [ Weekday::SATURDAY ,  567118 ],
      [ Weekday::SATURDAY ,  569477 ],
      [ Weekday::WEDNESDAY,  601716 ],
      [ Weekday::SUNDAY   ,  613424 ],
      [ Weekday::FRIDAY   ,  626596 ],
      [ Weekday::SUNDAY   ,  645554 ],
      [ Weekday::MONDAY   ,  664224 ],
      [ Weekday::WEDNESDAY,  671401 ],
      [ Weekday::SUNDAY   ,  694799 ],
      [ Weekday::SUNDAY   ,  704424 ],
      [ Weekday::MONDAY   ,  708842 ],
      [ Weekday::MONDAY   ,  709409 ],
      [ Weekday::THURSDAY ,  709580 ],
      [ Weekday::TUESDAY  ,  727274 ],
      [ Weekday::SUNDAY   ,  728714 ],
      [ Weekday::WEDNESDAY,  744313 ],
      [ Weekday::SUNDAY   ,  764652 ],
    ]

  def test_from_rd
    WEEKDAY_AND_RD.each do |weekday_ref, rd|
      # Act.
      result = Weekday.day_of_week(rd)
      # Assert.
      assert_equal(weekday_ref, result, 'Weekday::day_of_week')
    end
  end

  def test_on_or_before
    # Arrange.
    sunday_ref    = DATE - 5
    monday_ref    = DATE - 4
    tuesday_ref   = DATE - 3
    wednesday_ref = DATE - 2
    thursday_ref  = DATE - 1
    friday_ref    = DATE - 0
    saturday_ref  = DATE - 6
    # Act.
    sunday    = Weekday.on_or_before(Weekday::SUNDAY   , DATE)
    monday    = Weekday.on_or_before(Weekday::MONDAY   , DATE)
    tuesday   = Weekday.on_or_before(Weekday::TUESDAY  , DATE)
    wednesday = Weekday.on_or_before(Weekday::WEDNESDAY, DATE)
    thursday  = Weekday.on_or_before(Weekday::THURSDAY , DATE)
    friday    = Weekday.on_or_before(Weekday::FRIDAY   , DATE)
    saturday  = Weekday.on_or_before(Weekday::SATURDAY , DATE)
    # Assert.
    assert_equal(sunday_ref   , sunday   , 'Weekday::on_or_before: Sunday')
    assert_equal(monday_ref   , monday   , 'Weekday::on_or_before: Monday')
    assert_equal(tuesday_ref  , tuesday  , 'Weekday::on_or_before: Tuesday')
    assert_equal(wednesday_ref, wednesday, 'Weekday::on_or_before: Wednesday')
    assert_equal(thursday_ref , thursday , 'Weekday::on_or_before: Thursday')
    assert_equal(friday_ref   , friday   , 'Weekday::on_or_before: Friday')
    assert_equal(saturday_ref , saturday , 'Weekday::on_or_before: Saturday')
  end

  def test_on_or_after
    # Arrange.
    sunday_ref    = DATE + 2
    monday_ref    = DATE + 3
    tuesday_ref   = DATE + 4
    wednesday_ref = DATE + 5
    thursday_ref  = DATE + 6
    friday_ref    = DATE + 0
    saturday_ref  = DATE + 1
    # Act.
    sunday    = Weekday.on_or_after(Weekday::SUNDAY   , DATE)
    monday    = Weekday.on_or_after(Weekday::MONDAY   , DATE)
    tuesday   = Weekday.on_or_after(Weekday::TUESDAY  , DATE)
    wednesday = Weekday.on_or_after(Weekday::WEDNESDAY, DATE)
    thursday  = Weekday.on_or_after(Weekday::THURSDAY , DATE)
    friday    = Weekday.on_or_after(Weekday::FRIDAY   , DATE)
    saturday  = Weekday.on_or_after(Weekday::SATURDAY , DATE)
    # Assert.
    assert_equal(sunday_ref   , sunday   , 'Weekday::on_or_before: Sunday')
    assert_equal(monday_ref   , monday   , 'Weekday::on_or_before: Monday')
    assert_equal(tuesday_ref  , tuesday  , 'Weekday::on_or_before: Tuesday')
    assert_equal(wednesday_ref, wednesday, 'Weekday::on_or_before: Wednesday')
    assert_equal(thursday_ref , thursday , 'Weekday::on_or_before: Thursday')
    assert_equal(friday_ref   , friday   , 'Weekday::on_or_before: Friday')
    assert_equal(saturday_ref , saturday , 'Weekday::on_or_before: Saturday')
  end

  def test_nearest
    # Arrange.
    sunday_ref    = DATE + 2
    monday_ref    = DATE + 3
    tuesday_ref   = DATE - 3
    wednesday_ref = DATE - 2
    thursday_ref  = DATE - 1
    friday_ref    = DATE + 0
    saturday_ref  = DATE + 1
    # Act.
    sunday    = Weekday.nearest(Weekday::SUNDAY   , DATE)
    monday    = Weekday.nearest(Weekday::MONDAY   , DATE)
    tuesday   = Weekday.nearest(Weekday::TUESDAY  , DATE)
    wednesday = Weekday.nearest(Weekday::WEDNESDAY, DATE)
    thursday  = Weekday.nearest(Weekday::THURSDAY , DATE)
    friday    = Weekday.nearest(Weekday::FRIDAY   , DATE)
    saturday  = Weekday.nearest(Weekday::SATURDAY , DATE)
    # Assert.
    assert_equal(sunday_ref   , sunday   , 'Weekday::on_or_before: Sunday')
    assert_equal(monday_ref   , monday   , 'Weekday::on_or_before: Monday')
    assert_equal(tuesday_ref  , tuesday  , 'Weekday::on_or_before: Tuesday')
    assert_equal(wednesday_ref, wednesday, 'Weekday::on_or_before: Wednesday')
    assert_equal(thursday_ref , thursday , 'Weekday::on_or_before: Thursday')
    assert_equal(friday_ref   , friday   , 'Weekday::on_or_before: Friday')
    assert_equal(saturday_ref , saturday , 'Weekday::on_or_before: Saturday')
  end

  def test_before
    # Arrange.
    sunday_ref    = DATE - 5
    monday_ref    = DATE - 4
    tuesday_ref   = DATE - 3
    wednesday_ref = DATE - 2
    thursday_ref  = DATE - 1
    friday_ref    = DATE - 7
    saturday_ref  = DATE - 6
    # Act.
    sunday    = Weekday.before(Weekday::SUNDAY   , DATE)
    monday    = Weekday.before(Weekday::MONDAY   , DATE)
    tuesday   = Weekday.before(Weekday::TUESDAY  , DATE)
    wednesday = Weekday.before(Weekday::WEDNESDAY, DATE)
    thursday  = Weekday.before(Weekday::THURSDAY , DATE)
    friday    = Weekday.before(Weekday::FRIDAY   , DATE)
    saturday  = Weekday.before(Weekday::SATURDAY , DATE)
    # Assert.
    assert_equal(sunday_ref   , sunday   , 'Weekday::on_or_before: Sunday')
    assert_equal(monday_ref   , monday   , 'Weekday::on_or_before: Monday')
    assert_equal(tuesday_ref  , tuesday  , 'Weekday::on_or_before: Tuesday')
    assert_equal(wednesday_ref, wednesday, 'Weekday::on_or_before: Wednesday')
    assert_equal(thursday_ref , thursday , 'Weekday::on_or_before: Thursday')
    assert_equal(friday_ref   , friday   , 'Weekday::on_or_before: Friday')
    assert_equal(saturday_ref , saturday , 'Weekday::on_or_before: Saturday')
  end

  def test_after
    # Arrange.
    sunday_ref    = DATE + 2
    monday_ref    = DATE + 3
    tuesday_ref   = DATE + 4
    wednesday_ref = DATE + 5
    thursday_ref  = DATE + 6
    friday_ref    = DATE + 7
    saturday_ref  = DATE + 1
    # Act.
    sunday    = Weekday.after(Weekday::SUNDAY   , DATE)
    monday    = Weekday.after(Weekday::MONDAY   , DATE)
    tuesday   = Weekday.after(Weekday::TUESDAY  , DATE)
    wednesday = Weekday.after(Weekday::WEDNESDAY, DATE)
    thursday  = Weekday.after(Weekday::THURSDAY , DATE)
    friday    = Weekday.after(Weekday::FRIDAY   , DATE)
    saturday  = Weekday.after(Weekday::SATURDAY , DATE)
    # Assert.
    assert_equal(sunday_ref   , sunday   , 'Weekday::on_or_before: Sunday')
    assert_equal(monday_ref   , monday   , 'Weekday::on_or_before: Monday')
    assert_equal(tuesday_ref  , tuesday  , 'Weekday::on_or_before: Tuesday')
    assert_equal(wednesday_ref, wednesday, 'Weekday::on_or_before: Wednesday')
    assert_equal(thursday_ref , thursday , 'Weekday::on_or_before: Thursday')
    assert_equal(friday_ref   , friday   , 'Weekday::on_or_before: Friday')
    assert_equal(saturday_ref , saturday , 'Weekday::on_or_before: Saturday')

  end
end
