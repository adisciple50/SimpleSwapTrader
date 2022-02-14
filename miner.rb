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
  Exchange.new.list_pairs
end
# puts Exchange.new.find_pair("eos","xlm")[0].to_s
# puts generate_pairs.to_s

def generate_chains(pairs = Exchange.new.list_pairs.uniq)
  results = generate_pairs.map do |pair|
    if pairs.include?([IN_OUT_CURRENCY,pair[0]]) && pairs.include?([pair[0],IN_OUT_CURRENCY])
      [IN_OUT_CURRENCY] + pair + [IN_OUT_CURRENCY]
    else
      nil
    end
  end
  results.compact
end

# puts generate_chains.to_s
#
def map_chains_array_to_chain_classes(chains_array=generate_chains)
  chains_array.map do |chain_array|
    Chain.new(chain_array,START_AMOUNT)
  end
end

# chains = map_chains_array_to_chain_classes
# chains.reject! {|chain| chain.amount == 0.0}
#
def rank_amounts(chain_classes = map_chains_array_to_chain_classes)
  chain_classes.sort_by { | chain | chain.amount  }
end

sorted_chains = rank_amounts

puts sorted_chains[0].to_s
puts sorted_chains[-1].to_s
