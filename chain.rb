require_relative 'cryptocurrency'
class Chain
  attr_reader :currency_one,:currency_two,:currency_three,:currency_four,:amount
  def initialize(*chain_array,start_amount)
    @chain = chain_array
    @start_amount = start_amount
    # swap one
    @currency_one = Cryptocurrency.new(@chain[0][0],@start_amount)
    @currency_two = Cryptocurrency.new(@chain[0][1],0.0)
    @swap_one = Pair.new(@currency_one,@currency_two).quote_swap start_amount
    # swap two
    @currency_two = Cryptocurrency.new(@chain[0][1],@swap_one.to_f)
    @currency_three = Cryptocurrency.new(@chain[0][2],0.0)
    if not @swap_one.is_a? Float
      raise TypeError
    end
    @swap_two = Pair.new(@currency_two,@currency_three).quote_swap @swap_one
    # swap three
    @currency_three = Cryptocurrency.new(@chain[0][2],@swap_two)
    @currency_four = Cryptocurrency.new(@chain[0][3],0.0)
    if not @swap_two.is_a? Float
      raise TypeError
    end
    @swap_three = Pair.new(@currency_three,@currency_four).quote_swap @swap_two
    # result
    if not @swap_three.is_a? Float # i could use unless but i think this is simpler
      raise TypeError
    end
    @currency_four = Cryptocurrency.new(@chain[0][3],@swap_three)
    @amount = @currency_four.amount
  end
  def to_f
    @amount
  end

  def to_s
    "Winner: #{@chain.to_s} - Swap One: #{@swap_one} - Swap Two: #{@swap_two} - Swap Three: #{@swap_three} - Amount: #{@amount}"
  end
end