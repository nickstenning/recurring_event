require 'date'
require 'lib/recurring_event/date_expression'

class Date
  include RecurringEvent::DateExpression
  alias_method :upstream_init, :initialize
  def initialize(*args)
    upstream_init(*args)
    @condition = proc { |date| self == date }
  end
  def mweek
    ((mday - 1) / 7) + 1
  end
  alias_method :yweek, :cweek
  alias_method :ymonth, :month
end
