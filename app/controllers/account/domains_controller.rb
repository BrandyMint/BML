class Account::DomainsController < Account::BaseController
  layout 'account_settings'

  def show
    render locals: { account: current_account }
  end

  def update
    current_account.update! permitted_params
    redirect_to :back, flash: { success: I18n.t('flashes.settings.saved') }

  rescue ActiveRecord::RecordInvalid => err
    redirect_to :back, flash: { error: err.message }
  end

  private

  def permitted_params
    params.require(:account).permit(
      web_addresses_attributes: [
        :id, :subdomain, :suggested_domain, :_destroy
      ]
    )
  end
end
