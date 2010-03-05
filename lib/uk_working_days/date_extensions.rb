module UkWorkingDays
  # Extensions to the Date and DateTime classes
  module DateExtensions
    # Returns true if this day is in the week
    def weekday?
      ! weekend?
    end

    # Returns true if this day is on the weekend
    def weekend?
      wday == 0 || wday == 6
    end

    # Returns true if this day is a bank holiday
    def public_holiday?
      Date.public_holidays(year).include?(to_date)
    end

    # Returns true if this day is a normal weekday
    def working_day?
      weekday? && ! public_holiday?
    end

    # Returns the next (or count'th) working day
    def next_working_day(count = 1)
      negative = count < 0
      count = count.abs
      date = negative ? yesterday : tomorrow
      
      loop do
        count -= 1 if date.working_day?
        return date if count.zero? 
        
        date += negative ? -1 : 1
      end
    end

    # The previous (or count'th) working day
    def previous_working_day(count = 1)
      next_working_day(-count)
    end

    module ClassMethods
      # New year's day, or the next weekday following if on a weekend
      def new_years_day_holiday(year)
        nyd = new(year, 1, 1)
        nyd.weekday?() ? nyd : nyd.next_week
      end

      # Christmas day, or the next weekday following if on a weekend
      def christmas_day_holiday(year)
        xmas_day = new(year, 12, 25)
        xmas_day.weekday? ? xmas_day : xmas_day.next_week
      end

      # Boxing day, or the next working day following
      def boxing_day_holiday(year)
        ([0,5,6].include? christmas_day_holiday(year).wday) ? christmas_day_holiday(year).next_week : christmas_day_holiday(year).tomorrow
      end

      # The monday after Easter Sunday
      def easter_monday(year)
        easter(year) + 1
      end

      # The friday before Easter Sunday
      def good_friday(year)
        easter(year) - 2
      end

      # The first monday in May
      def may_bank_holiday(year)
        first_day_may = new(year, 5, 1)
        first_day_may.wday == 1 ? first_day_may : first_day_may.next_week
      end 

      # The last monday in May 
      def spring_bank_holiday(year)
        new(year, 5, 31).beginning_of_week
      end

      # The last monday in August
      def summer_bank_holiday(year)
        new(year, 8, 31).beginning_of_week
      end

      # An Array of all public holidays for the given year
      def public_holidays(year)
        [new_years_day_holiday(year),
         good_friday(year),
         easter_monday(year),
         may_bank_holiday(year),
         spring_bank_holiday(year),
         summer_bank_holiday(year),
         christmas_day_holiday(year),
         boxing_day_holiday(year)]
      end
    end
  end
end
