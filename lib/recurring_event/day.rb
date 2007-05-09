require 'vendor/metaid'

module RecurringEvent
  class Day
    include DateExpression
    %w[week month year].each do |t|
      meta_def("in_#{t}") { |*args| self.new.send("in_#{t}", *args) }
      meta_def("range_each_#{t}") { |*args| self.new.send("range_each_#{t}", *args) }
    end
    
    def in_week( day_number )
      @condition = proc { |date| date.wday == day_number }
      self
    end
    def in_month( day_number )
      @condition = proc { |date| date.mday == day_number }
      self
    end
    def in_year( day_number )
      @condition = proc { |date| date.yday == day_number }
      self
    end
    def range_each_week( day_range )
      @condition = proc { |date| day_range.include? date.wday }
      self
    end
    def range_each_month( day_range )
      @condition = proc { |date| day_range.include? date.mday }
      self
    end
    def range_each_year( day_range )
      @condition = proc { |date| day_range.include? date.yday }
      self
    end
  end
end
