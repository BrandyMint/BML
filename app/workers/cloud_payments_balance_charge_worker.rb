class CloudPaymentsBalanceChargeWorker
  include Sidekiq::Worker
  # sidekiq_options retry: 3, queue: :critical
  # sidekiq_retry_in do |count|
  #   1.day.seconds.to_i
  # end

  # sidekiq_retries_exhausted do |msg|
  #   account_id, year, month = msg['args']
  #   account = Account.find account_id
  #   BalanceMailer.delay.charge_error_email account.id, year, month
  #   Sidekiq.logger.info "#{msg['class']}: retries exhausted, mail sent to account #{msg['args']}: #{msg['error_message']}"
  # end

  def perform(account_id, _year, _month)
    account = Account.find account_id
    return unless account.needs_recurrent_charge?

    amount = Money.new(0, :rub) - account.billing_account.amount

    CloudPayments::RecurrentChargeBalance.new(
      account: account,
      amount: amount
    ).call
  end
end
