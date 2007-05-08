describe "A new RecurringEvent::Month object" do
  before(:each) do
    @m = RecurringEvent::Month.new
  end
  it "should respond to a full range of relevant temporal expression methods" do
    @m.should respond_to(:in_year)
    @m.should respond_to(:range_each_year)
  end
end

describe "RecurringEvent::Month class method ::in_year" do
  before(:each) do
    @m = RecurringEvent::Month.in_year(1)
  end
  it "should return an instance of RecurringEvent::Month" do
    @m.should be_kind_of(RecurringEvent::Month)
  end
end

describe "An instance of RecurringEvent::Month called with #in_year(n)" do
  before(:each) do
    @m = RecurringEvent::Month.in_year(10)
  end
  it "should include dates which fall in the nth month of the year" do
    @m.should include(Date.new( 2005, 10, 20))
  end
  it "should not include dates which fall in any other month of the year" do
    @m.should_not include(Date.new( 2008, 06, 30))
  end
end

describe "RecurringEvent::Month class method ::range_each_year" do
  before(:each) do
    @m = RecurringEvent::Month.range_each_year(4..10)
  end
  it "should return an instance of RecurringEvent::Month" do
    @m.should be_kind_of(RecurringEvent::Month)
  end
end

describe "An instance of RecurringEvent::Month called with #range_each_year(a..b)" do
  before(:each) do
    @m = RecurringEvent::Month.range_each_year(4..10)
  end
  it "should include dates which fall in the ath to bth months of the year" do
    @m.should include(Date.new( 2005, 4, 11))
    @m.should include(Date.new( 2005, 5, 5))
    @m.should include(Date.new( 2005, 6, 12))
  end
  it "should not include dates which fall in any other months of the year" do
    @m.should_not include(Date.new( 2008, 11, 9))
    @m.should_not include(Date.new( 2008, 12, 15))
    @m.should_not include(Date.new( 2009, 12, 5))
  end
end
