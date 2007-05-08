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
end
