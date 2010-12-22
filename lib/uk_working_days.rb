require 'date'
require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/time/calculations'
require File.dirname(__FILE__) + '/uk_working_days/easter'
require File.dirname(__FILE__) + '/uk_working_days/date_extensions'

class Date #:nodoc:
  extend UkWorkingDays::Easter
  extend UkWorkingDays::DateExtensions::ClassMethods
  include UkWorkingDays::DateExtensions
end

class Time #:nodoc:
  include UkWorkingDays::DateExtensions
end
