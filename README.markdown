# RecurringEvent - An(other) implementation of Fowler's recurring event pattern.

RecurringEvent is an attempt to make a more rubyish version of Martin Fowler's 
Recurring Event pattern, a la Runt. Where Runt has DIMonth, REYear, and so on, 
RecurringEvent has the following:

    include RecurringEvent
    expr = ( Day.in_month(1) | Day.range_each_month(21..28) )
    expr &= Month.range_each_year(1..6)

    expr.include? Date.new( 2006, 01, 01 ) # => true
    expr.include? Date.new( 2006, 01, 02 ) # => false
    expr.include? Date.new( 2006, 04, 23 ) # => true
    expr.include? Date.new( 2006, 07, 01 ) # => false
    expr.include? Date.new( 2006, 07, 23 ) # => false

In case you didn't catch that, those two lines at the top set up a conditional 
expression which will only #include? dates which are ((the first day of the 
month OR the 21st to 28th of the month) AND in January through to July).  But 
RecurringEvent goes further than that. Thanks to the hands-off fashion in 
which all this is achieved, we can mix in dates and date ranges with the 
RecurringEvent expressions:

    include RecurringEvent

    expr = Day.in_week(3) | Date.new(2006, 07, 04) 
    expr |= Date.new(2006,10,01)..Date.new(2006,10,15)

That expression will match every Wednesday, as well as Independence Day and 
the 1st to 15th of August in 2006.
