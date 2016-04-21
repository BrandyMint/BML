# Команда смены/установки тарифа для аккаунта на конкретный месяц
#
class ChangeTariff
  include Virtus.model strict: true

  attribute :account, Account
  attribute :tariff, Tariff
  attribute :date, Date

  def perform!
    tm = account.tariff_month_for_date(date)

    if tm.present?
      tm.update! tariff: tariff
      return tm
    end

    account.tariff_months.create! month: date, tariff: tariff
  end
end
