class AccountsController < ApplicationController
  include AuthorizeUser

  layout 'auth'

  def edit
    render locals: { account: current_account }, layout: 'account'
  end

  def index
    render locals: { accounts: current_user.accounts.ordered }
  end

  def update
    current_account.update! permitted_params
    redirect_to :back, flash: { success: 'Настройки сохранены' }

  rescue ActiveRecord::RecordInvalid => err
    redirect_to :back, flash: { error: err.message }
  end

  def select
    account = current_user.accounts.find params[:id]
    flash[:info] = "Переключили на аккаунт #{account}"
    self.current_account = account
    redirect_to account_root_url
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
