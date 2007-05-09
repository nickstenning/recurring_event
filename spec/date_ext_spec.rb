require 'lib/date_ext'

describe "A normal Date object" do
  before(:each) do
    @d = Date.new(2006, 10, 28)
    @e = Date.new(2006, 5, 17)
    @f = Date.new(2045, 3, 31)
  end
  it "should return the week of the month with #mweek" do
    @d.mweek.should == 4
    @e.mweek.should == 3
    @f.mweek.should == 5
  end
  it "should return the week of the year with #yweek" do
    @d.yweek.should == 43
    @e.yweek.should == 20
    @f.yweek.should == 13
  end
  it "should return the month of the year with #ymonth" do
    @d.ymonth.should == 10
    @e.ymonth.should == 5
    @f.ymonth.should == 3
  end
  it "should #include? itself" do
    @d.should include(Date.new(2006, 10, 28))
    @e.should include(Date.new(2006, 5, 17))
    @f.should include(Date.new(2045, 3, 31))
  end
  it "should be the one date in a range in which it occurs" do
    @d.dates_in_range(Date.new(2006, 10, 20)..Date.new(2006, 11, 01)).should == [@d]
    @d.dates_in_range(Date.new(2006, 5, 10)..Date.new(2006, 5, 20)).should be_empty
    @e.dates_in_range(Date.new(2006, 5, 10)..Date.new(2006, 5, 20)).should == [@e]
    @e.dates_in_range(Date.new(2045, 3, 30)..Date.new(2045, 4, 01)).should be_empty
    @f.dates_in_range(Date.new(2045, 3, 30)..Date.new(2045, 4, 01)).should == [@f]
    @f.dates_in_range(Date.new(2006, 10, 20)..Date.new(2006, 11, 01)).should be_empty
  end
end
