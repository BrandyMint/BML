class AccountsController < ApplicationController
  include AuthorizeUser

  layout 'account_settings'

  def index
    render locals: { accounts: current_user.accounts.ordered }
  end

  def edit
    redirect_to account_name_url
  end

  def select
    account = current_user.accounts.find params[:id]
    flash[:info] = "Переключили на аккаунт #{account}"
    self.current_account = account
    redirect_to account_root_url
  end
end
