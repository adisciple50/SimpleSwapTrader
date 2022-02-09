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
  def get_rate(currency_one,currency_two)
    find_pair(currency_one,currency_two)[0]['rate']
  end
  def get_max(currency_one,currency_two)
    find_pair(currency_one,currency_two)[0]['max']
  end
  def get_min(currency_one,currency_two)
    find_pair(currency_one,currency_two)[0]['min']
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