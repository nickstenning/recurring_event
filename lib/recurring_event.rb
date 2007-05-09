$: << File.dirname(__FILE__) + '/..'

require 'lib/date_ext'
require 'lib/recurring_event/expression'
require 'lib/recurring_event/date_expression'
require 'lib/recurring_event/day'
require 'lib/recurring_event/week'
require 'lib/recurring_event/month'

module RecurringEvent
  VERSION = '0.0.1'
  def self.parse(expr)
    case expr
    when String, Symbol
      Date.parse(expr.to_s)
    when Expression, DateExpression, Day, Week, Month
      expr
    end
  end
end

