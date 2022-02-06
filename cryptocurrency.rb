class Cryptocurrency
  attr_reader :symbol
  attr_accessor :amount
  def initialize(symbol)
    @symbol = symbol
    @amount = 0.0
  end
end