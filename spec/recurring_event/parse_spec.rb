require 'lib/recurring_event'

describe "The RecurringEvent.parse method" do
  it "should return an Expression-aware date-like object" do
    RecurringEvent.parse('20060101').should include(Date.new(2006, 01, 01))
    RecurringEvent.parse(Date.new(2006, 02, 02)).should include(Date.new(2006, 02, 02))
  end
end
