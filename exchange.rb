require 'faraday'
class Exchange
  attr_reader :data
  def initialize
    @connection = Faraday.new(
      url:'https://api.simpleswap.io/v1/',
      params: {api_key: ENV['simpleswap_api']}
    )
    @data = refresh_data
  end
  def refresh_data
    @data = JSON.parse @connection.get('get_market_info').body
  end
  def find_pair(currency_one,currency_two)
    @data.select {|currency| currency['currency_from'] == currency_one.to_s && currency['currency_to'] == currency_two.to_s}
  end
  def get_attribute(currency_one,currency_two,attribute)
    result = find_pair(currency_one,currency_two)
    # puts result.to_s
    if result[0].nil?
      puts "returning 0.0"
      return 0.0
    else
      puts "result attr is:#{result[0][attribute]}"
      result[0][attribute]
    end
  end

  # todo list all pairs to check against
  #

  def list_pairs
    @data.map {|currency| [currency['currency_from'] , currency['currency_to'] ]}
  end


  def get_rate(currency_one,currency_two)
    get_attribute(currency_one,currency_two,'rate').to_f
  end
  def get_max(currency_one,currency_two)
    get_attribute(currency_one,currency_two,'max').to_f
  end
  def get_min(currency_one,currency_two)
    get_attribute(currency_one,currency_two,'min').to_f
  end

  def get_currencies
    currencies_one = @data.map do |data_pair|
      data_pair['currency_from']
    end
    currencies_two = @data.map do |data_pair|
      data_pair['currency_to']
    end
    results = currencies_one + currencies_two
    results.uniq
  end
end