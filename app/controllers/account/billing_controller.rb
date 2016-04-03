class Account::BillingController < Account::BaseController
  layout 'account'

  def show
    render locals: {
      account: current_account,
      transactions: transactions
    }
  end

  private

  def transactions
    current_account.billing_transactions.reverse_order(:id).map do |t|
      AccountTransaction.new current_account.billing_account, t
    end
  end
end
