class FixLiquidityProviderBase
    def initialize(queueService)
        @queueService = queueService
    end

    def check_service_status()
    end
    
    def wait_for_response(order_id)
      # blocking read waiting for a redis key where trade confirmation is stored
    end

    def handle_trade_confirmation(rest_trade_confirmation)
      # trade confirmation will be persisted in db
    end
end