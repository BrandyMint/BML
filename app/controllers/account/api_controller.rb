class Account::ApiController < Account::BaseController
  layout 'account_settings'

  def show
    render locals: { account: current_account }
  end
end
