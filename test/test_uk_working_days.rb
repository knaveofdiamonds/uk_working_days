require 'helper'

class TestUkWorkingDays < Test::Unit::TestCase
  should "return true for #weekend? if day is a Saturday or Sunday" do
    assert Date.new(2010, 2, 27).weekend?
    assert Date.new(2010, 2, 28).weekend?
    assert Time.local(2010, 2, 28).weekend?
  end

  should "return true for #weekday? if day is not on the Weekend" do
    assert Date.new(2010, 2, 26).weekday?
    assert Time.local(2010, 2, 26).weekday?
  end

  should "return true for #public_holiday? if day is a public holiday" do
    assert Date.new(2010, 4, 5).public_holiday?
    assert DateTime.new(2010, 4, 5).public_holiday?
    assert Time.local(2010, 4, 5).public_holiday?
  end

  should "return false for #public_holiday? if day not a public holiday" do
    assert ! Date.new(2010, 4, 6).public_holiday?
    assert ! DateTime.new(2010, 4, 6).public_holiday?
  end

  should "return true for #working_day? on a normal weekday" do
    assert Date.new(2010, 4, 1).working_day?
    assert Time.local(2010, 4, 1).working_day?
  end

  should "return false for #working_day? if day is a public holiday or on the weekend" do
    assert ! Date.new(2010, 4, 5).working_day?
    assert ! Date.new(2010, 4, 4).working_day?
    assert ! Time.local(2010, 4, 4).working_day?
  end

  should "return the next working day for #next_working_day" do
    assert_equal Date.new(2010, 4, 6), Date.new(2010, 4, 2).next_working_day
    assert_equal Date.new(2010, 4, 7), Date.new(2010, 4, 6).next_working_day
    assert_equal Time.local(2010, 4, 7), Time.local(2010, 4, 6).next_working_day
  end

  should "return the previous working day for #previous_working_day" do
    assert_equal Date.new(2010, 4, 1), Date.new(2010, 4, 6).previous_working_day
    assert_equal Date.new(2010, 3, 31), Date.new(2010, 4, 1).previous_working_day
    assert_equal Time.local(2010, 3, 31), Time.local(2010, 4, 1).previous_working_day
  end

  should "return self when passing 0 to #next_working_day or #previous_working_day" do
    date, time = Date.today, Time.now

    assert_equal date, date.next_working_day(0)
    assert_equal time, time.next_working_day(0)

    assert_equal date, date.previous_working_day(0)
    assert_equal time, time.previous_working_day(0)
  end

  context "Date#public_holidays" do
    should "return the eight public holidays in the year" do
      assert_equal 8, Date.public_holidays(2010).uniq.size
    end

    should "return datetimes if called from DateTime" do
      assert DateTime.public_holidays(2010).all? {|d| d.class == DateTime }
    end

    should "return dates if called from Date" do
      assert Date.public_holidays(2010).all? {|d| d.class == Date }
    end
  end
end
