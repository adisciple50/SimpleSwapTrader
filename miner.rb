# require 'faraday'
#
# connection = Faraday.new(
#   url:'https://api.simpleswap.io/v1/',
#   params: {api_key: ENV['simpleswap_api']}
# )
#
# rates = JSON.parse connection.get('get_market_info').body
# puts rates
#


require_relative 'exchange'

def generate_pairs
  exchange = Exchange.new
  exchange.get_currencies.permutation(2).to_a
end

puts generate_pairs.to_s