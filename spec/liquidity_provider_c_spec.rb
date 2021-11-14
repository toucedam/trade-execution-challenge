require_relative "../src/clean_code/trade_execution/liquidity_provider/liquidity_provider_c.rb"
require_relative "./mocks/redis_queue_service_mock.rb"

RSpec.describe LiquidityProviderC, "#market trade" do
    context "Issuig market trade" do
        it "doesn't raise error on successful REST request" do         
            http_request_service = HttpRequestServiceMock.new(true)
            config_service = ConfigServiceMock.new
            liquidity_provider = LiquidityProviderC.new(http_request_service, config_service)
            liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)
        end  
        
        it "raises error on unsuccessful REST request" do
            http_request_service = HttpRequestServiceMock.new(false)
            config_service = ConfigServiceMock.new
            liquidity_provider = LiquidityProviderC.new(http_request_service, config_service)

            expect { 
                liquidity_provider.issue_market_trade(nil, nil, nil, nil, nil, nil, nil)
            }.to raise_error 'REST order execution failed.'
        end
    end
end