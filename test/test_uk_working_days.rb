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

  context "Date#new_years_day_holiday" do
    should "return new year's day if it is a weekday" do
      assert_equal Date.new(2010, 1, 1), Date.new_years_day_holiday(2010)
    end

    should "return the next monday after new year's day if on a weekend" do
      assert_equal Date.new(2011, 1, 3), Date.new_years_day_holiday(2011)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime, DateTime.new_years_day_holiday(2011)
    end
  end

  context "Date#christmas_day_holiday" do
    should "return christmas day if it is a weekday" do
      assert_equal Date.new(2009, 12, 25), Date.christmas_day_holiday(2009)
    end

    should "return the next monday after new year's day if on a weekend" do
      assert_equal Date.new(2010, 12, 27), Date.christmas_day_holiday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime, DateTime.christmas_day_holiday(2010)
    end
  end

  context "Date#boxing_day_holiday" do
    should "return following monday if boxing day is on saturday" do
      assert_equal Date.new(2009, 12, 28), Date.boxing_day_holiday(2009)
    end

    should "return the following tuesday if boxing day is on sunday" do
      assert_equal Date.new(2010, 12, 28), Date.boxing_day_holiday(2010)
    end

    should "return the following tuesday if boxing day is on monday" do
      assert_equal Date.new(2011, 12, 27), Date.boxing_day_holiday(2011)
    end

    should "return boxing day itself in other cases" do
      assert_equal Date.new(2008, 12, 26), Date.boxing_day_holiday(2008)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime, DateTime.boxing_day_holiday(2010)
    end
  end

  context "Date#easter_monday" do
    should "return the monday after easter" do
      assert_equal Date.new(2010, 4, 5), Date.easter_monday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime, DateTime.easter_monday(2010)
    end
  end

  context "Date#good_friday" do
    should "return the friday before easter sunday" do
      assert_equal Date.new(2010, 4, 2), Date.good_friday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime,  DateTime.good_friday(2010)
    end
  end

  context "Date#may_bank_holiday" do
    should "return the first monday in may" do
      assert_equal Date.new(2010, 5, 3), Date.may_bank_holiday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime,  DateTime.may_bank_holiday(2010)
    end
  end

  context "Date#spring_bank_holiday" do
    should "return the last monday in may" do
      assert_equal Date.new(2010, 5, 31), Date.spring_bank_holiday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime,  DateTime.spring_bank_holiday(2010)
    end
  end

  context "Date#summer_bank_holiday" do
    should "return the last monday in august" do
      assert_equal Date.new(2010, 8, 30), Date.summer_bank_holiday(2010)
    end

    should "return a DateTime if called from DateTime" do
      assert_kind_of DateTime,  DateTime.summer_bank_holiday(2010)
    end
  end

  context "Date#public_holidays" do
    should "return the eight public holidays in the year" do
      assert_equal 8, Date.public_holidays(2010).uniq.size 
    end

    should "return datetimes if called from DateTime" do
      assert DateTime.public_holidays(2010).all? {|d| d.kind_of? DateTime }
    end
  end
end
