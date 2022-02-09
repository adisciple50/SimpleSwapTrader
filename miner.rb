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

IN_OUT_CURRENCY = "btc"

def generate_pairs
  exchange = Exchange.new
  exchange.get_currencies.permutation(2).to_a
end

puts generate_pairs.to_s

def generate_chains
  generate_pairs.map do |pair|
    [IN_OUT_CURRENCY] + pair + [IN_OUT_CURRENCY]
  end
end

puts generate_chains.to_s
