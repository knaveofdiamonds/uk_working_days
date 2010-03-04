# The easter calculation is largely derived from
# reusablecode.blogspot.com under the following license
#
# Copyright (c) 2008, reusablecode.blogspot.com; some rights reserved.
#
# This work is licensed under the Creative Commons Attribution License. To view
# a copy of this license, visit http://creativecommons.org/licenses/by/3.0/ or
# send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California
# 94305, USA.
#

module UkWorkingDays
  module Easter
    extend self

    # Calculate easter sunday for the given year
    def easter(year)
      golden_number = (year % 19) + 1
      
      if year <= 1752 then
        # Julian calendar
        dominical_number = (year + (year / 4) + 5) % 7
        paschal_full_moon = (3 - (11 * golden_number) - 7) % 30
      else
        # Gregorian calendar
        dominical_number = (year + (year / 4) - (year / 100) + (year / 400)) % 7
        solar_correction = (year - 1600) / 100 - (year - 1600) / 400
        lunar_correction = (((year - 1400) / 100) * 8) / 25
        paschal_full_moon = (3 - 11 * golden_number + solar_correction - lunar_correction) % 30
      end

      dominical_number += 7 until dominical_number > 0 
      
      paschal_full_moon += 30 until paschal_full_moon > 0 
      paschal_full_moon -= 1 if paschal_full_moon == 29 or (paschal_full_moon == 28 and golden_number > 11)
      
      difference = (4 - paschal_full_moon - dominical_number) % 7
      difference += 7 if difference < 0 
      
      day_easter = paschal_full_moon + difference + 1
      
      day_easter < 11 ? Date.new(year, 3, day_easter + 21) : Date.new(year, 4, day_easter - 10)
    end
  end
end
