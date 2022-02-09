# require 'faraday'
#
# connection = Faraday.new(
#   url:'https://api.simpleswap.io/v1/',
#   params: {api_key: ENV['simpleswap_api']}
# )
#
# rates = JSON.parse connection.get('get_market_info').body
# puts rates



require_relative 'exchange'
require_relative 'chain'

IN_OUT_CURRENCY = "btc"
START_AMOUNT = 0.003

def generate_pairs
  exchange = Exchange.new
  exchange.get_currencies.permutation(2).to_a
end

# puts generate_pairs.to_s

def generate_chains
  generate_pairs.map do |pair|
    [IN_OUT_CURRENCY] + pair + [IN_OUT_CURRENCY]
  end
end

# puts generate_chains.to_s

def map_chains_array_to_chain_classes(chains_array=generate_chains)
  chains_array.map do |chain_array|
    Chain.new(chain_array,START_AMOUNT)
  end
end

def rank_amounts(chain_classes = map_chains_array_to_chain_classes)
  chain_classes.sort_by { | chain | chain.amount  }
end

sorted_chains = rank_amounts

puts sorted_chains[0].to_s
puts sorted_chains[-1].to_s