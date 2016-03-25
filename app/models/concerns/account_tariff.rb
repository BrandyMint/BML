module AccountTariff
  extend ActiveSupport::Concern

  included do
    belongs_to :tariff
  end

  def current_tariff
    tariff || Tariff.default
  end
end
