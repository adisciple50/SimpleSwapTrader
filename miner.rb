require 'faraday'

connection = Faraday.new(
  url:'https://api.simpleswap.io/v1/',
  params: {api_key: ENV['simpleswap_api']}
)

rates = JSON.parse connection.get('get_market_info').body