require 'vendor/metaid'

module RecurringEvent
  class Week
    include DateExpression
    %w[month year].each do |t|
      meta_def("in_#{t}") { |*args| self.new.send("in_#{t}", *args) }
      meta_def("range_each_#{t}") { |*args| self.new.send("range_each_#{t}", *args) }
    end

    def in_month( week_number )
      @condition = proc { |date| date.mweek == week_number }
      self
    end
    def in_year( week_number )
      @condition = proc { |date| date.yweek == week_number }
      self
    end
    def range_each_month( week_range )
      @condition = proc { |date| week_range.include? date.mweek }
      self
    end
    def range_each_year( week_range )
      @condition = proc { |date| week_range.include? date.yweek }
      self
    end
  end
end
