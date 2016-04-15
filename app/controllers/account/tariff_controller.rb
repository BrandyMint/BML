class Account::TariffController < Account::BaseController
  layout 'account'

  def show
    render locals: { tariff_months: current_account.tariff_months.ordered }
  end

  def update
    tm = command.perform!

    redirect_to :back, flash: {
      success: I18n.t('flashes.tariff.changed', tariff: tariff.title, beginning_of_month: tm.beginning_of_month)
    }
  end

  private

  def command
    ChangeTariff
      .new(account: current_account, tariff: tariff, date: date)
  end

  def tariff
    Tariff.find params[:id]
  end

  def date
    params[:date] || Time.zone.today
  end
end
