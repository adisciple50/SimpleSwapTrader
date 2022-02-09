require_relative 'cryptocurrency'
class Chain
  attr_reader :currency_one,:currency_two,:currency_three,:currency_four,:amount
  def initialize(*chain_array,start_amount)
    @chain = chain_array
    @start_amount = start_amount
    # swap one
    @currency_one = Cryptocurrency.new(@chain[0],@start_amount)
    @currency_two = Cryptocurrency.new(@chain[0],0.0)
    @swap_one = Pair.new(@currency_one,@currency_two).quote_swap start_amount
    # swap two
    @currency_two = Cryptocurrency.new(@chain[1],@swap_one)
    @currency_three = Cryptocurrency.new(@chain[2],0.0)
    @swap_two = Pair.new(@currency_two,@currency_three).quote_swap @swap_two
    # swap three
    @currency_three = Cryptocurrency.new(@chain[2],@swap_two)
    @currency_four = Cryptocurrency.new(@chain[3],0.0)
    @swap_three = Pair.new(@currency_three,@currency_four).quote_swap @swap_three
    # result
    @currency_four = Cryptocurrency.new(@chain[3],@swap_three)
    @amount = @currency_four.amount
  end
  def to_f
    @amount
  end

  def to_s
    "Winner: #{@chain.to_s} - Swap One: #{@swap_one} - Swap Two: #{@swap_two} - Swap Three: #{@swap_three} - Amount: #{@amount}"
  end
end