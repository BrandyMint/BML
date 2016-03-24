module AccountTariff
  extend ActiveSupport::Concern

  included do
    belongs_to :tariff
    after_create :set_tariff
  end

  private

  def set_tariff
    update_column :tariff_id, Tariff.base.id
  end
end
