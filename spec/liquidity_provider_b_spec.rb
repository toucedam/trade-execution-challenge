require "./src/clean_code/trade_execution/liquidity_provider/liquidity_provider_b.rb"
require "./spec/mocks/redis_queue_service_mock.rb"

RSpec.describe LiquidityProviderB, "#market trade" do
    context "Issuig market trade" do
        it "pushes to the proper queue" do
            queue_service = RedisQueueServiceMock.new
            liquidity_provider = LiquidityProviderB.new(queue_service)
            liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)

            expect(queue_service.queue).to eq :lp_acme_provider_queue
        end  
        
        it "pushes to the queue with the proper command" do
            queue_service = RedisQueueServiceMock.new
            liquidity_provider = LiquidityProviderB.new(queue_service)
            liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)

            expect(queue_service.command).to eq "fix:order:execute"
        end
    end
end