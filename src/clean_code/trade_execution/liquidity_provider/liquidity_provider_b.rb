require "./src/clean_code/trade_execution/liquidity_provider/fix_liquidity_provider_base.rb"

class LiquidityProviderB < FixLiquidityProviderBase
    def initialize(queueService)
        @queueService = queueService
      end

    def issue_market_trade(side, size, currency, counter_currency, date, price, order_id)
        check_fix_service_status()
        
        @queueService.push_to_queue(
            :lp_acme_provider_queue, 
            'fix:order:execute',
            clOrdID: order_id, 
            side: side, 
            orderQty: size, 
            ccy1: currency, 
            ccy2: counter_currency,
            value_date: date, 
            price: price
        )

        response = wait_for_response(order_id)
        handle_trade_confirmation(response)
    end
end