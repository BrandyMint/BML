# Запускает списание абонплаты для всех аккаунтов
# Запускается 1-го числа каждого месяца по расписанию config/crontab.yml
class SubscriptionFeeWithdrawalBatchWorker
  include Sidekiq::Worker

  def perform
    Account.pluck(:id).each do |account_id|
      SubscriptionFeeWithdrawalWorker.perform_async account_id
    end
  end
end
