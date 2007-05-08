require 'date'

class Date
  alias_method :include?, :==
  def mweek
    ((mday - 1) / 7) + 1
  end
  alias_method :yweek, :cweek
  alias_method :ymonth, :month
end
