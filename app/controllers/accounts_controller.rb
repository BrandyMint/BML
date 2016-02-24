class AccountsController < ApplicationController
  include AuthorizeUser

  layout 'system'

  def index
    render locals: { accounts: current_user.accounts.ordered }
  end

  def show
    account = current_user.accounts.find params[:id]
    set_current_account account
    redirect_to account_root_url
  end
end
