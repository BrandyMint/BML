class ChangeCurrentTariff
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :tariff_change, TariffChange

  delegate :account, :to_tariff, to: :tariff_change

  def call
    return unless tariff_change.present?
    return tariff_change.destroy! if to_tariff.archived?

    change_tariff
  end

  private

  def change_tariff
    Account.transaction do
      account.update! tariff: to_tariff
      tariff_change.archive!
    end
  end
end
