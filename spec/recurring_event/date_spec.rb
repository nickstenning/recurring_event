require 'lib/recurring_event'

describe "Having required RecurringEvent, a normal ruby Date" do
  before(:each) do
    @d = Date.new(2006, 10, 20)
  end
  it "should #include? itself" do
    @d.should include(@d)
  end
  it "should not #include? other dates" do
    @d.should_not include(Date.new(2006, 10, 24))
  end
  it "should set its rule to :union when unioned" do
    @d |= Date.new( 2030, 12, 13 )
    @d.rule.should == :union
  end
  it "should include a date that it's unioned with" do
    @d |= Date.new( 2030, 12, 13 )
    @d.should include(Date.new( 2030, 12, 13))
  end
  it "should set its rule to :intersect when intersected" do
    @d &= Date.new( 2030, 12, 13 )
    @d.rule.should == :intersect
  end
  it "should not include a date that it's intersected with" do
    @d &= Date.new( 2030, 12, 13 )
    @d.should_not include(Date.new( 2030, 12, 13))
  end
end

