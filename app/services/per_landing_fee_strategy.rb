class PerLandingFeeStrategy
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :account, Account
  attribute :tariff, Tariff
  attribute :month, Date

  def call
    total = Money.new(0, :rub)
    description = ''

    account.landings.find_each do |landing|
      landing_fee = landing_fee(landing)

      total += landing_fee.total
      description += "#{landing_fee.description}\n"
    end

    FeeResult.new total: total, description: description
  end

  def landing_fee(landing)
    LandingPeriodFee.new(landing: landing, price: tariff.price_per_site, month: month).call
  end
end
