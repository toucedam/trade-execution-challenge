require "money"
require "monetize"

I18n.config.available_locales = :en
Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_CEILING

class LiquidityProviderFactory
    USD = "USD"
    
    def initialize(httpRequestService, queueService, configService)
        @httpRequestService = httpRequestService
        @queueService = queueService
        @configService = configService
    end

    def get_liquidity_provider(size, currency)
        amount = amount_in_usd(size, currency)

        if amount < 10_000.to_money(USD) 
            lp = LiquidityProviderC.new(@httpRequestService, @configService)
        elsif (amount >= 10_000.to_money(USD) && amount < 100_000.to_money(USD))
            lp = LiquidityProviderB.new(@queueService)
        else
            lp = LiquidityProviderA.new(@queueService)
        end

        lp
    end

    def amount_in_usd(size, currency)
      # it would return a Money object representing a USD amount
      size.to_money(currency).to_money(USD)
    end
end