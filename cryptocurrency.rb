require_relative 'pair'
class Cryptocurrency
  attr_reader :symbol
  attr_accessor :rate
  def initialize(symbol)
    @symbol = symbol
    @amount = 0.0
  end
  def convert_to(currency)
    Pair.new
  end

  def to_s
    @symbol
  end
end