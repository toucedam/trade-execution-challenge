class LiquidityProviderC
    def initialize(httpRequestService, configService)
        @httpRequestService = httpRequestService
        @configService = configService
    end

    def issue_market_trade(side, size, currency, counter_currency, date, price, order_id)
        payload = {        
            order_type: 'market',
            order_id: order_id, 
            side: side, 
            order_qty: size, 
            ccy1: currency,
            ccy2: counter_currency,
            value_date: date, 
            price: price
        }
      
        lpUrl = @configService.liquidity_provider_base_url + '/trade'
        response = @httpRequestService.post(lpUrl, payload)
      
        if @httpRequestService.is_successful_response(response)
            handle_trade_confirmation(response)
        else
            raise 'REST order execution failed.'
        end
    end

    def handle_trade_confirmation(rest_trade_confirmation)
      # trade confirmation will be persisted in db
    end
end