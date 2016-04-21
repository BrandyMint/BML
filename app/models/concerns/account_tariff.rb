module AccountTariff
  extend ActiveSupport::Concern

  included do
    belongs_to :tariff
  end

  def current_tariff
    tariff_for_date(Time.zone.today) || tariff || Tariff.default
  end

  def tariff_for_date(date)
    tariff_month_for_date(date).try(:tariff)
  end

  def features
    AccountFeatures.new(account: self, tariff: current_tariff)
  end

  def tariff_month_for_date(date)
    tariff_months.for_date(date).first || tariff_months.nearest_to(date).first
  end
end
