require "./src/clean_code/trade_execution/liquidity_provider/fix_liquidity_provider_base.rb"

class LiquidityProviderA < FixLiquidityProviderBase
    def initialize(queueService)
        @queueService = queueService
      end

    def issue_market_trade(side, size, currency, counter_currency, date, price, order_id)
        check_fix_service_status()
        
        @queueService.push_to_queue(
            :lp_wall_street_provider_queue, 
            'fix:executetrade',
            ordType: 'D',
            clOrdID: order_id, 
            side: side,
            orderQty: size,
            currency_1: currency,
            currency_2: counter_currency,
            futSettDate: date,
            price: price
        )

        response = wait_for_response(order_id)
        handle_trade_confirmation(response)
    end
end