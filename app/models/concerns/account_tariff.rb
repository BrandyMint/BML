module AccountTariff
  extend ActiveSupport::Concern

  included do
    belongs_to :tariff
    has_many :tariff_changes
  end

  def current_tariff_change
    tariff_changes.for_change.first
  end

  def next_tariff_change
    tariff_changes.pending.first
  end

  def current_tariff
    tariff || Tariff.default
  end

  def features
    AccountFeatures.new(account: self, tariff: current_tariff)
  end
end
