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
    @data = JSON.parse connection.get('get_market_info').body
  end
  def get_rate

  end
  def get_max

  end
  def get_min

  end
  def find_exchange

  end
end