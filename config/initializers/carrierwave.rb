CarrierWave.configure do |config|
  config.storage = :file
  puts config.asset_host = Settings.app.asset_host # ActionController::Base.asset_host
end
