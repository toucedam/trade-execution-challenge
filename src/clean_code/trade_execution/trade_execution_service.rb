#
# This service provides an interface for order routing AND trade execution  
# using different avaiable Liquidity Providers (aka "LPs") using two different
# protocols: REST (http) and FIX (Financial Information eXchange) 
#
# execution_service = TradeExecutionService.new
# execution_service.execute_order(
#   'buy', 10000, 'USD', 'EUR',
#   '11/12/2018', '1.1345', 'X-A213FFL'
#   )
#

class TradeExecutionService
  def initialize(liquidityProviderFactory)
    @liquidityProviderFactory = liquidityProviderFactory
  end

  def execute_order(side, size, currency, counter_currency, date, price, order_id)
    liquidity_provider = @liquidityProviderFactory.get_liquidity_provider(size, currency)

    liquidity_provider.issue_market_trade(side, size, currency, counter_currency, date, price, order_id)
  rescue
    File.open('path_to_log_file/errors.log', 'a') do |f|
      f.puts "Execution of #{order_id} failed."
    end
  end
end