class SubscriptionFeeWithdrawalBatchWorker
  include Sidekiq::Worker

  def perform
    Account.pluck(:id).each do |account_id|
      SubscriptionFeeWithdrawalWorker.perform_async account_id
    end
  end
end
