class Account::BillingController < Account::BaseController
  include AccountTariffsHelper
  layout 'account_settings'

  def show
    render locals: { account: current_account,
                     tariff_change: current_account.next_tariff_change,
                     tariffs_options: tariffs_options }
  end

  def update
    tariff = Tariff.find permitted_params[:tariff_id]
    UpsertTariffChange.new(tariff: tariff, account: current_account).call
    redirect_to :back, flash: { success: I18n.t('flashes.tariffs.changed') }

  rescue ActiveRecord::RecordInvalid => _err
    render :show, locals: { account: current_account,
                            tariff_change: current_account.next_tariff_change,
                            tariffs_options: tariffs_options }
  end

  def destroy
    current_account.next_tariff_change.destroy!
    redirect_to :back
  end

  private

  def tariffs_options
    next_tariff_options current_account
  end

  def permitted_params
    params.require(:account).permit(:tariff_id)
  end
end
