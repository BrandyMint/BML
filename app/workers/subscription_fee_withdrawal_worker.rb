class SubscriptionFeeWithdrawalWorker
  include Sidekiq::Worker

  def perform(account_id)
    account = Account.find account_id
    date = Date.current.prev_month

    Billing::WithdrawSubscriptionFee.new(
      account: account,
      tariff: account.current_tariff,
      month: date
    ).call

    return unless account.needs_recurrent_charge?

    CloudPaymentsBalanceChargeWorker.perform_async account_id, date.year, date.month
  end
end
