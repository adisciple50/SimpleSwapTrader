require_relative 'pair'
class Cryptocurrency
  attr_reader :symbol
  attr_accessor :amount
  def initialize(symbol ,amount=0.0)
    @symbol = symbol
    unless @symbol.is_a? String
      raise TypeError
    end
    @amount = amount
  end
  def convert_to(currency)
    Pair.new(@symbol,currency)
  end
  def to_s
    @symbol
  end
end