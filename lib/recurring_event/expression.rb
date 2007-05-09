module RecurringEvent
  module Expression
    attr_reader :rule, :conditions
    def initialize(rule=nil, conditions=[])
      @rule = rule
      @conditions = conditions
    end
    def include?( date )
      case @rule
      when :intersect
        @conditions.inject(true) { |result, cond| result and cond.include?(date) }
      when :union
        @conditions.inject(false) { |result, cond| result or cond.include?(date) }
      end
    end
    def and( expression )
      @conditions ||= []
      if @rule == :intersect or @rule.nil?
        @conditions << expression
        @rule ||= :intersect
        self
      else
        self.class.new(:intersect, [self]).and(expression)
      end
    end
    alias_method :&, :and
    def or( expression )
      @conditions ||= []
      if @rule == :union or @rule.nil?
        @conditions << expression
        @rule ||= :union
        self
      else
        self.class.new(:union, [self]).or(expression)
      end
    end
    alias_method :|, :or
    def dates_in_range( range )
      range.map do |date|
        date if include? date
      end.compact
    end
  end
end
