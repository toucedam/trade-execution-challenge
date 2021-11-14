class LiquidityProviderFactory
    def initialize(httpRequestService, queueService, configService, currencyService)
        @httpRequestService = httpRequestService
        @queueService = queueService
        @configService = configService
        @currencyService = currencyService
    end

    def get_liquidity_provider(size, currency)
        amount = @currencyService.amount_in_usd(size, currency)

        if amount < @currencyService.amount_in_usd(10_000)
            lp = LiquidityProviderC.new(@httpRequestService, @configService)
        elsif (amount >= @currencyService.amount_in_usd(10_000) && amount < @currencyService.amount_in_usd(100_000))
            lp = LiquidityProviderB.new(@queueService)
        else
            lp = LiquidityProviderA.new(@queueService)
        end

        lp
    end
end