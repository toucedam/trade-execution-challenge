require "./src/clean_code/trade_execution/liquidity_provider/liquidity_provider_a.rb"
require "./spec/mocks/redis_queue_service_mock.rb"

RSpec.describe LiquidityProviderA, "#market trade" do
    context "Issuig market trade" do
        it "pushes to the proper queue" do
            queue_service = RedisQueueServiceMock.new
            liquidity_provider = LiquidityProviderA.new(queue_service)
            liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)

            expect(queue_service.queue).to eq :lp_wall_street_provider_queue
        end  
        
        it "pushes to the queue with the proper command" do
            queue_service = RedisQueueServiceMock.new
            liquidity_provider = LiquidityProviderA.new(queue_service)
            liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)

            expect(queue_service.command).to eq "fix:executetrade"
        end
    end
end