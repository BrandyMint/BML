class Account::SmsController < Account::BaseController
  layout 'account_settings'

  def show
    render locals: {
      account: current_account,
      log_entities: log_entities
    }
  end

  def update
    current_account.update! permitted_params
    redirect_to :back, flash: { success: I18n.t('flashes.settings.saved') }

  rescue ActiveRecord::RecordInvalid => err
    redirect_to :back, flash: { error: err.message }
  end

  private

  def log_entities
    current_account.sms_log_entities.order('id desc')
  end

  def permitted_params
    params.require(:account).permit(:smsc_login, :smsc_password, :smsc_sender)
  end
end
