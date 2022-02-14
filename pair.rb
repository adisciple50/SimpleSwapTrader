require_relative 'exchange'
class Pair
  attr_reader :currency_one,:currency_two
  attr_accessor :rate,:min,:max

  def initialize(currency_one,currency_two)
    @exchange = Exchange.new
    @currency_one = currency_one
    @currency_two = currency_two
    @rate = @exchange.get_rate(@currency_one.symbol,@currency_two.symbol)
    @max = @exchange.get_max(@currency_one.symbol,@currency_two.symbol)
    @min = @exchange.get_min(@currency_one.symbol,@currency_two.symbol)
  end

  def quote_swap(amount)
    if not @rate.is_a? Float
      raise TypeError
    end
    @rate.to_f * amount.to_f
  end

  def to_s
    "#{currency_one.to_s}_#{currency_two.to_s}"
  end
end