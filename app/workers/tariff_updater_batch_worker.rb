class TariffUpdaterBatchWorker
  include Sidekiq::Worker

  def perform
    TariffChange.for_change.pluck(:account_id).each do |account_id|
      TariffUpdaterWorker.perform_async account_id
    end
  end
end
