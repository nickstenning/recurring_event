require 'lib/recurring_event'

class SimpleExpression
  include RecurringEvent::Expression
end

describe "A new expression" do
  before(:each) do
    @e = SimpleExpression.new
  end
  it "should have no conditions defined" do
    @e.conditions.should be_empty
  end
  it "should have no expression rule defined" do
    @e.rule.should be_nil
  end
  it "should become an intersect expression when intersected" do
    @f = @e & RecurringEvent::Day.in_month(1)
    @f.rule.should == :intersect
    @g = @e.and(RecurringEvent::Day.in_month(1))
    @g.rule.should == :intersect
  end
  it "should become a union expression when unioned" do
    @f = @e | RecurringEvent::Day.in_month(1)
    @f.rule.should == :union
    @g = @e.or(RecurringEvent::Day.in_month(1))
    @g.rule.should == :union
  end
  it "should not match any dates in a given range" do
    @r = @e.dates_in_range Date.new(2000, 1, 1)..Date.new(2001, 1, 1)
    @r.should be_empty
  end
end

describe "An expression with one simple condition" do
  before(:each) do
    @e = SimpleExpression.new
    @e &= RecurringEvent::Day.in_month(1)
  end
  it "should include the time points when that condition is matched" do
    10.times do
      @e.should include(Date.new(1970+rand(130), 1+rand(12), 1))
    end
  end
  it "should not include any time point when that condition is not matched" do
    10.times do
      @e.should_not include(Date.new(1970+rand(130), 1+rand(12), 2+rand(27)))
    end
  end
  it "should return an array of dates on which the condition is matched within a given range" do
    @r = @e.dates_in_range Date.new( 2000, 1, 1 )..Date.new( 2001, 1, 1 )
    @r.size.should == 13
    @r.each { |d| d.mday.should == 1 }
  end
  it "should become an intersect expression when intersected" do
    @f = @e & RecurringEvent::Day.in_month(1)
    @f.rule.should == :intersect
    @g = @e.and(RecurringEvent::Day.in_month(1))
    @g.rule.should == :intersect
  end
  it "should become a union expression when unioned" do
    @f = @e | RecurringEvent::Day.in_month(1)
    @f.rule.should == :union
    @g = @e.or(RecurringEvent::Day.in_month(1))
    @g.rule.should == :union
  end
end

describe "An expression with an intersect rule and n conditions" do
  before(:each) do
    @e = SimpleExpression.new & \
         RecurringEvent::Day.in_month(1) & \
         RecurringEvent::Month.in_year(3) & \
         RecurringEvent::Week.in_month(1)
    @f = SimpleExpression.new & \
         RecurringEvent::Day.in_month(1)
  end
  it "should have its rule set to :intersect" do
    @e.rule.should == :intersect
    @f.rule.should == :intersect
  end
  it "should have n conditions" do
    @e.should have(3).conditions
    @f.should have(1).conditions
  end 
  it "should have conditions with rules set to nil" do
    @e.conditions.each { |c| c.rule.should be_nil }
    @f.conditions.each { |c| c.rule.should be_nil }
  end
  it "should include time points that match all of the conditions" do
    10.times do
      @e.should include(Date.new(1970+rand(130), 3, 1))
      @f.should include(Date.new(1970+rand(130), 1+rand(12), 1))
    end
  end
  it "should not include time points that match only one of the conditions" do
    10.times do
      @e.should_not include(Date.new(1970+rand(130), 4+rand(8), 3))
      @e.should_not include(Date.new(1970+rand(130), 3, 4+rand(24)))
      @f.should_not include(Date.new(1970+rand(130), 1+rand(12), 2+rand(26)))
    end
  end
  it "should not include time points that match none of the conditions" do
    10.times do
      @e.should_not include(Date.new(1970+rand(130), 1+rand(12), 3))
      @f.should_not include(Date.new(1970+rand(130), 1+rand(12), 3))
    end
  end
  it "should return an array of dates on which the condition is matched within a given range" do
    @r = @e.dates_in_range Date.new( 2000, 1, 1 )..Date.new( 2001, 1, 1 )
    @r.size.should == 1
    @r.each do |d| 
      d.mday.should == 1
      d.ymonth.should == 3
      d.mweek.should == 1
    end
    @s = @f.dates_in_range Date.new( 2000, 1, 1 )..Date.new( 2001, 1, 1 )
    @s.size.should == 13
    @s.each { |d| d.mday.should == 1 }
  end
  it "should form a union expression when unioned" do
    @g = @e | RecurringEvent::Month.range_each_year(1..6)
    @h = @e.or(RecurringEvent::Month.range_each_year(1..6))
    @i = @f | RecurringEvent::Month.range_each_year(1..6)
    @j = @f.or(RecurringEvent::Month.range_each_year(1..6))
    [@g, @h, @i, @j].each do |x|
      x.rule.should == :union
      x.should have(2).conditions
      x.conditions.first.rule.should == :intersect
    end
  end
end

describe "An expression with a union rule and n conditions" do
  before(:each) do
    @e = SimpleExpression.new | \
         RecurringEvent::Day.in_month(1) | \
         RecurringEvent::Day.in_month(2) | \
         RecurringEvent::Day.in_month(3)
    @f = SimpleExpression.new | \
         RecurringEvent::Day.in_month(4)
  end
  it "should have its rule set to :union" do
    @e.rule.should == :union
    @f.rule.should == :union
  end
  it "should have n conditions" do
    @e.should have(3).conditions
    @f.should have(1).conditions
  end
  it "should have conditions with rules set to nil" do
    @e.conditions.each { |c| c.rule.should be_nil }
    @f.conditions.each { |c| c.rule.should be_nil }
  end
  it "should include time points that match one or other of the conditions" do
    10.times do
      @e.should include(Date.new(1970+rand(130), 1+rand(12), 1))
      @e.should include(Date.new(1970+rand(130), 1+rand(12), 2))
      @e.should include(Date.new(1970+rand(130), 1+rand(12), 3))
      @f.should include(Date.new(1970+rand(130), 1+rand(12), 4))
    end
  end
  it "should not include time points that match neither of the conditions" do
    10.times do
      @e.should_not include(Date.new(1970+rand(130), 1+rand(12), 4))
      @f.should_not include(Date.new(1970+rand(130), 1+rand(12), 1))
      @f.should_not include(Date.new(1970+rand(130), 1+rand(12), 2))
      @f.should_not include(Date.new(1970+rand(130), 1+rand(12), 3))
    end
  end
  it "should return an array of dates on which the condition is matched within a given range" do
    @r = @e.dates_in_range Date.new( 2000, 1, 1 )..Date.new( 2001, 1, 1 )
    @r.size.should == 37
    @r.each { |d| [1, 2, 3].should include(d.mday) }
    @s = @f.dates_in_range Date.new( 2000, 1, 1 )..Date.new( 2001, 1, 1 )
    @s.size.should == 12
    @s.each { |d| d.mday.should == 4 }
  end
  it "should form an intersect expression when intersected" do
    @g = @e & RecurringEvent::Month.range_each_year(1..6)
    @h = @e.and(RecurringEvent::Month.range_each_year(1..6))
    @i = @f & RecurringEvent::Month.range_each_year(1..6)
    @j = @f.and(RecurringEvent::Month.range_each_year(1..6))
    [@g, @h, @i, @j].each do |x|
      x.rule.should == :intersect
      x.should have(2).conditions
      x.conditions.first.rule.should == :union
    end
  end
end

