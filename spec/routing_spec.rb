require_relative "../src/clean_code/trade_execution/liquidity_provider/liquidity_provider_factory.rb"
require_relative "../src/clean_code/trade_execution/liquidity_provider/liquidity_provider_a.rb"
require_relative "../src/clean_code/trade_execution/liquidity_provider/liquidity_provider_b.rb"
require_relative "../src/clean_code/trade_execution/liquidity_provider/liquidity_provider_c.rb"
require_relative "./mocks/http_request_service_mock.rb"
require_relative "./mocks/redis_queue_service_mock.rb"
require_relative "./mocks/config_service_mock.rb"
require_relative "./mocks/currency_service_mock.rb"

RSpec.describe LiquidityProviderFactory, "#routing" do
    context "Less than 10k USD" do
        it "routes to LIQUIDITY_PROVIDER_C" do
            http_request_service = HttpRequestServiceMock.new
            queue_service = RedisQueueServiceMock.new
            config_service = ConfigServiceMock.new
            currency_service = CurrencyServiceMock.new
            liquidity_provider_factory = LiquidityProviderFactory.new(http_request_service, queue_service, config_service, currency_service)
            liquidity_provider = liquidity_provider_factory.get_liquidity_provider(9_999, 'USD');

            expect(liquidity_provider).to be_an_instance_of LiquidityProviderC
        end
    end

    context "Equal or bigger than 10k USD but less than 100k USD" do
        it "routes to LIQUIDITY_PROVIDER_B if equal to 10k USD" do        
            http_request_service = HttpRequestServiceMock.new
            queue_service = RedisQueueServiceMock.new
            config_service = ConfigServiceMock.new
            currency_service = CurrencyServiceMock.new
            liquidity_provider_factory = LiquidityProviderFactory.new(http_request_service, queue_service, config_service, currency_service)
            liquidity_provider = liquidity_provider_factory.get_liquidity_provider(10_000, 'USD');

            expect(liquidity_provider).to be_an_instance_of LiquidityProviderB
        end        
        
        it "routes to LIQUIDITY_PROVIDER_B if bigger than 10k USD but less than 100k USD" do      
            http_request_service = HttpRequestServiceMock.new
            queue_service = RedisQueueServiceMock.new
            config_service = ConfigServiceMock.new
            currency_service = CurrencyServiceMock.new
            liquidity_provider_factory = LiquidityProviderFactory.new(http_request_service, queue_service, config_service, currency_service)
            liquidity_provider = liquidity_provider_factory.get_liquidity_provider(99_999, 'USD');

            expect(liquidity_provider).to be_an_instance_of LiquidityProviderB
        end
    end

    context "Bigger than 100k USD" do
        it "routes to LIQUIDITY_PROVIDER_A if equal to 100k USD" do
            http_request_service = HttpRequestServiceMock.new
            queue_service = RedisQueueServiceMock.new
            config_service = ConfigServiceMock.new
            currency_service = CurrencyServiceMock.new
            liquidity_provider_factory = LiquidityProviderFactory.new(http_request_service, queue_service, config_service, currency_service)
            liquidity_provider = liquidity_provider_factory.get_liquidity_provider(10_0000, 'USD');

            expect(liquidity_provider).to be_an_instance_of LiquidityProviderA
        end        
        
        it "routes to LIQUIDITY_PROVIDER_A if bigger than 100k USD" do
            http_request_service = HttpRequestServiceMock.new
            queue_service = RedisQueueServiceMock.new
            config_service = ConfigServiceMock.new
            currency_service = CurrencyServiceMock.new
            liquidity_provider_factory = LiquidityProviderFactory.new(http_request_service, queue_service, config_service, currency_service)
            liquidity_provider = liquidity_provider_factory.get_liquidity_provider(5000_000, 'USD');

            expect(liquidity_provider).to be_an_instance_of LiquidityProviderA
        end
    end
end