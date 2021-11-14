require "./src/clean_code/trade_execution_service.rb"

RSpec.describe TradeExecutionService, "#routing" do
    context "Less than 10k USD" do
        it "routes to LIQUIDITY_PROVIDER_C" do
            execution_service = TradeExecutionService.new
            execution_service.execute_order(
                'buy', 9_999, 'USD', 'EUR',
                '11/12/2018', '1.1345', 'X-A213FFL'
            );

            expect(execution_service.lp).to eq execution_service.LIQUIDITY_PROVIDER_C
        end
    end

    context "Equal or bigger than 10k USD but less than 100k USD" do
        it "routes to LIQUIDITY_PROVIDER_B if equal to 10k USD" do
            execution_service = TradeExecutionService.new
            execution_service.execute_order(
                'buy', 10_000, 'USD', 'EUR',
                '11/12/2018', '1.1345', 'X-A213FFL'
            );

            expect(execution_service.lp).to eq execution_service.LIQUIDITY_PROVIDER_B
        end        
        
        it "routes to LIQUIDITY_PROVIDER_B if bigger than 10k USD but less than 100k USD" do
            execution_service = TradeExecutionService.new
            execution_service.execute_order(
                'buy', 99_999, 'USD', 'EUR',
                '11/12/2018', '1.1345', 'X-A213FFL'
            );

            expect(execution_service.lp).to eq execution_service.LIQUIDITY_PROVIDER_B
        end
    end

    context "Bigger than 100k USD" do
        it "routes to LIQUIDITY_PROVIDER_A if equal to 100k USD" do
            execution_service = TradeExecutionService.new
            execution_service.execute_order(
                'buy', 10_0000, 'USD', 'EUR',
                '11/12/2018', '1.1345', 'X-A213FFL'
            );

            expect(execution_service.lp).to eq execution_service.LIQUIDITY_PROVIDER_A
        end        
        
        it "routes to LIQUIDITY_PROVIDER_A if bigger than 100k USD" do
            execution_service = TradeExecutionService.new
            execution_service.execute_order(
                'buy', 5000_000, 'USD', 'EUR',
                '11/12/2018', '1.1345', 'X-A213FFL'
            );

            expect(execution_service.lp).to eq execution_service.LIQUIDITY_PROVIDER_A
        end
    end
end