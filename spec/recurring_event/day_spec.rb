require 'lib/recurring_event'

describe "A new RecurringEvent::Day object" do
  before(:each) do
    @d = RecurringEvent::Day.new
  end
  it "should respond to a full range of relevant temporal expression methods" do
    @d.should respond_to(:in_week)
    @d.should respond_to(:in_month)
    @d.should respond_to(:in_year)
    @d.should respond_to(:range_each_week)
    @d.should respond_to(:range_each_month)
    @d.should respond_to(:range_each_year)
  end
end

describe "RecurringEvent::Day class methods ::in_week, ::in_month, ::in_year" do
  before(:each) do
    @d = RecurringEvent::Day.in_week(1)
    @e = RecurringEvent::Day.in_month(1)
    @f = RecurringEvent::Day.in_year(1)
  end
  it "should return an instance of RecurringEvent::Day" do
    [@d, @e, @f].each { |x| x.should be_kind_of(RecurringEvent::Day) }
  end
end

describe "An instance of RecurringEvent::Day called with #in_week(n)" do
  before(:each) do
    @d = RecurringEvent::Day.in_week(2)
  end
  it "should include dates which fall on the nth day of the week" do
    @d.should include(Date.new( 1993, 3, 30))
  end
  it "should not include dates which fall on any other day of the week" do
    @d.should_not include(Date.new( 1996, 2, 15))
  end
end

describe "An instance of RecurringEvent::Day called with #in_month(n)" do
  before(:each) do
    @d = RecurringEvent::Day.in_month(14)
  end
  it "should include dates which fall on the nth day of the month" do
    @d.should include(Date.new( 1999, 1, 14))
  end
  it "should not include dates which fall on any other day of the month" do
    @d.should_not include(Date.new( 2002, 4, 25))
  end
end

describe "An instance of RecurringEvent::Day called with #in_year(n)" do
  before(:each) do
    @d = RecurringEvent::Day.in_year(333)
  end
  it "should include dates which fall on the nth day of the year" do
    @d.should include(Date.new( 2005, 11, 29))
  end
  it "should not include dates which fall on any other day of the year" do
    @d.should_not include(Date.new( 2008, 06, 30))
  end
end

describe "RecurringEvent::Day class methods ::range_each_week, ::range_each_month, ::range_each_year" do
  before(:each) do
    @d = RecurringEvent::Day.range_each_week(3..5)
    @e = RecurringEvent::Day.range_each_month(14..28)
    @f = RecurringEvent::Day.range_each_year(290..360)
  end
  it "should return an instance of RecurringEvent::Day" do
    [@d, @e, @f].each { |x| x.should be_kind_of(RecurringEvent::Day) }
  end
end

describe "An instance of RecurringEvent::Day called with #range_each_week(a..b)" do
  before(:each) do
    @d = RecurringEvent::Day.range_each_week(2..4)
  end
  it "should include dates which fall on the ath to bth day of the week" do
    (23..25).each { |d| @d.should include(Date.new( 1993, 3, d)) }
  end
  it "should not include dates which fall on any other day of the week" do
    (16..19).each { |d| @d.should_not include(Date.new( 1996, 2, d)) }
  end
end


describe "An instance of RecurringEvent::Day called with #range_each_month(a..b)" do
  before(:each) do
    @d = RecurringEvent::Day.range_each_month(14..28)
  end
  it "should include dates which fall on the ath to bth day of the month" do
    (14..28).each { |d| @d.should include(Date.new( 2038, 3, d)) }
  end
  it "should not include dates which fall on any other day of the month" do
    (01..13).each { |d| @d.should_not include(Date.new( 2038, 7, d)) }
  end
end

describe "An instance of RecurringEvent::Day called with #range_each_year(a..b)" do
  before(:each) do
    @d = RecurringEvent::Day.range_each_year(290..360)
  end
  it "should include dates which fall on the ath to bth day of the year" do
    @d.should include(Date.new( 2002, 10, 17))
    @d.should include(Date.new( 2002, 11, 15))
    @d.should include(Date.new( 2002, 12, 26))
  end
  it "should not include dates which fall on any other day of the year" do
    @d.should_not include(Date.new( 2008, 12, 27))
    @d.should_not include(Date.new( 2008, 07, 15))
    @d.should_not include(Date.new( 2008, 10, 15))
  end
end
