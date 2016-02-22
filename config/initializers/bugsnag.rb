Bugsnag.configure do |config|
  config.api_key = '3c84a1f04e9cbf78f6ee4499a5fffec7'
  config.app_version = AppVersion.format('%M.%m.%p')

  config.notify_release_stages = %w(production staging reproduction)
  config.send_code = true
  config.send_environment = true
end
