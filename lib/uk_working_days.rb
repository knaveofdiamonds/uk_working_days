require File.dirname(__FILE__) + '/uk_working_days/easter'

Date.send(:extend, UkWorkingDays::Easter)
