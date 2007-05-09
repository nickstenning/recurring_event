require 'lib/recurring_event/expression'

module RecurringEvent
  module DateExpression
    include Expression
    attr_accessor :condition
    def initialize( *args )
      @condition = proc { false }
      super(*args)
    end
    def include?( date )
      case @rule
      when :intersect
        @condition.call(date) and super(date)
      when :union
        @condition.call(date) or super(date)
      else
        @condition.call(date)
      end
    end
  end
end
    
