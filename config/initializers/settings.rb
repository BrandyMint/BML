Rails.configuration.action_mailer.merge!(Settings.action_mailer.try(:symbolize_keys) || {})
ActionDispatch::Http::URL.tld_length = Settings.tld_length
