require 'pair'
class Cryptocurrency
  include Pair
  attr_reader :symbol
  attr_accessor :rate
  def initialize(symbol)
    @symbol = symbol
    @amount = 0.0
  end
  def convert_to(currency)

  end
end