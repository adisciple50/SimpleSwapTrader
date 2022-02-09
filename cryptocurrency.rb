require_relative 'pair'
class Cryptocurrency
  attr_reader :symbol
  attr_accessor :amount
  def initialize(symbol,amount=0.0)
    @symbol = symbol
    @amount = amount
  end
  def convert_to(currency)
    Pair.new(@symbol,currency)
  end
  def to_s
    @symbol
  end
end