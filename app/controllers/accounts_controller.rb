class AccountsController < ApplicationController
  include AuthorizeUser
  include CurrentAccount

  layout 'auth'

  def edit
    render locals: { account: current_account }, layout: 'account'
  end

  def index
    render locals: { accounts: current_user.accounts.ordered }
  end

  def select
    account = current_user.accounts.find params[:id]
    flash[:info] = "Переключили на аккаунт #{account}"
    set_current_account account
    redirect_to account_root_url
  end
end
