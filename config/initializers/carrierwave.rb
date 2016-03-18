CarrierWave.configure do |config|
  config.storage = :file
  config.asset_host = proc do |_file|
    AppSettings.asset_host
  end
end
