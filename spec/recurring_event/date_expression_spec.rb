require 'lib/recurring_event'

describe "A new RecurringEvent::DateExpression" do
  before(:each) do
    @d = RecurringEvent::DateExpression.new
  end
  it "should be a kind of RecurringEvent::Expression" do
    @d.should be_kind_of(RecurringEvent::Expression)
  end
  it "shouldn't include any dates" do
    10.times do
      @d.should_not include(Date.new(1970+rand(130), 1+rand(12), 1+rand(28)))
    end
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
  it "should not include a dated that it's intersected with" do
    @d &= Date.new( 2030, 12, 13 )
    @d.should_not include(Date.new( 2030, 12, 13))
  end
end

describe "The #include? method of a new subclass of RecurringEvent::DateExpression" do
  before(:each) do
    class MyClass < RecurringEvent::DateExpression; end
    @m = MyClass.new
    @p = proc { |t| t }
    @m.condition = @p
  end
  it "should have its output determined by a proc set by #condition=" do
    @m.condition.should == @p
  end
  it "should return true when called with params that cause the proc to return true" do
    @m.should include(true)
    @m.should include("hello")
  end
  it "should return false called with params that cause the proc to return false" do
    @m.should_not include(false)
    @m.should_not include(nil)
  end
end

describe "The #include? method of a unioned subclass of RecurringEvent::DateExpression" do
  before(:each) do
    class MyClass < RecurringEvent::DateExpression; end
    @m = MyClass.new
    @m |= Date.new( 2003, 1, 23 )
  end
  it "should return true if either the proc or the unioned expression returns true" do
    @m.condition = proc { |t| t > 2499999 } # this returns false for the date
    @m.should include(2500000)
    @m.should include(Date.new( 2003, 1, 23))
    @m.condition = proc { |t| t > 10 } # this returns true for the date
    @m.should include(11)
    @m.should include(Date.new( 2003, 1, 23))
  end
  it "should return false if both the proc nor the unioned expression returns false" do
    @m.condition = proc { |t| t > 2500000 }
    @m.should_not include(2499999)
    @m.should_not include(Date.new( 2003, 1, 12))
  end
end

describe "The #include? method of an intersected subclass of RecurringEvent::DateExpression" do
  before(:each) do
    class MyClass < RecurringEvent::DateExpression; end
    @m = MyClass.new
    @m &= Date.new( 2003, 1, 13 )
  end
  it "should return true if both the proc and the intersected expression return true" do
    @m.condition = proc { |t| t > 100 } # this returns true for the date
    @m.should include(Date.new( 2003, 1, 13))
  end
  it "should return false if either the proc or the intersected expression returns false" do
    @m.condition = proc { |t| t > 100 }
    @m.should_not include(101)
  end
end

