module AccountTariffsHelper
  def next_tariff_options(account)
    Tariff.published.where.not(id: account.current_tariff.id)
  end
end
