require "money"
require "monetize"

I18n.config.available_locales = :en
Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_CEILING

class CurrencyService
    USD = "USD"

    # it would return a Money object representing a USD amount
    def amount_in_usd(size, currency = nil)
        amount = size

        if (currency != nil)
            amount = size.to_money(currency)
        end

        amount.to_money(USD)
    end
end