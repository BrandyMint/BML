class TariffUpdaterWorker
  include Sidekiq::Worker

  def perform(account_id)
    account = Account.find account_id
    ChangeCurrentTariff.new(tariff_change: account.current_tariff_change).call
  rescue => err
    Bugsnag.notify err, metaData: { account_id: account_id }
  end
end
