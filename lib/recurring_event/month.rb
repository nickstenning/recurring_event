require 'vendor/metaid'

module RecurringEvent
  class Month
    include DateExpression
    %w[year].each do |t|
      meta_def("in_#{t}") { |*args| self.new.send("in_#{t}", *args) }
      meta_def("range_each_#{t}") { |*args| self.new.send("range_each_#{t}", *args) }
    end

    def in_year( month_number )
      @condition = proc { |date| date.ymonth == month_number }
      self
    end
    def range_each_year( month_range )
      @condition = proc { |date| month_range.include? date.ymonth }
      self
    end
  end
end
