class Account::PaymentsController < Account::BaseController
  layout 'account'

  def new
    redirect_to new_account_cloud_payment_path
  end
end
