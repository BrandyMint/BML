module AccountTariff
  extend ActiveSupport::Concern

  included do
    belongs_to :tariff
  end

  def current_tariff
    tariff || Tariff.default
  end

  def features
    AccountFeatures.new(account: self, tariff: current_tariff)
  end
end
