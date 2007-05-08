require 'lib/recurring_event'

describe "A new RecurringEvent::Week object" do
  before(:each) do
    @w = RecurringEvent::Week.new
  end
  it "should respond to a full range of relevant temporal expression methods" do
    @w.should respond_to(:in_month)
    @w.should respond_to(:in_year)
    @w.should respond_to(:range_each_month)
    @w.should respond_to(:range_each_year)
  end
end

describe "RecurringEvent::Week class methods ::in_month, ::in_year" do
  before(:each) do
    @w = RecurringEvent::Week.in_month(1)
    @x = RecurringEvent::Week.in_year(1)
  end
  it "should return an instance of RecurringEvent::Week" do
    [@w, @x].each { |x| x.should be_kind_of(RecurringEvent::Week) }
  end
end

describe "An instance of RecurringEvent::Week called with #in_month(n)" do
  before(:each) do
    @w = RecurringEvent::Week.in_month(3)
  end
  it "should include dates which fall in the nth week of the month" do
    @w.should include(Date.new( 1982, 3, 17))
  end
  it "should not include dates which fall in any other week of the month" do
    @w.should_not include(Date.new( 1982, 6, 7))
  end
end

describe "An instance of RecurringEvent::Week called with #in_year(n)" do
  before(:each) do
    @w = RecurringEvent::Week.in_year(42)
  end
  it "should include dates which fall in the nth week of the year" do
    @w.should include(Date.new( 2005, 10, 20))
  end
  it "should not include dates which fall in any other week of the year" do
    @w.should_not include(Date.new( 2008, 06, 30))
  end
end

describe "RecurringEvent::Week class methods ::range_each_month, ::range_each_year" do
  before(:each) do
    @w = RecurringEvent::Week.range_each_month(14..28)
    @x = RecurringEvent::Week.range_each_year(290..360)
  end
  it "should return an instance of RecurringEvent::Week" do
    [@w, @x].each { |x| x.should be_kind_of(RecurringEvent::Week) }
  end
end

describe "An instance of RecurringEvent::Week called with #range_each_month(a..b)" do
  before(:each) do
    @w = RecurringEvent::Week.range_each_month(1..2)
  end
  it "should include dates which fall in the ath to bth weeks of the month" do
    (1..14).each { |d| @w.should include(Date.new( 2038, 3, d)) }
  end
  it "should not include dates which fall in any other weeks of the month" do
    (15..28).each { |d| @w.should_not include(Date.new( 2038, 7, d)) }
  end
end

describe "An instance of RecurringEvent::Week called with #range_each_year(a..b)" do
  before(:each) do
    @w = RecurringEvent::Week.range_each_year(15..23)
  end
  it "should include dates which fall in the ath to bth weeks of the year" do
    @w.should include(Date.new( 2005, 4, 11))
    @w.should include(Date.new( 2005, 5, 5))
    @w.should include(Date.new( 2005, 6, 12))
  end
  it "should not include dates which fall in any other weeks of the year" do
    @w.should_not include(Date.new( 2008, 6, 9))
    @w.should_not include(Date.new( 2008, 10, 15))
    @w.should_not include(Date.new( 2009, 4, 5))
  end
end
