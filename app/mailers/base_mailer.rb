class BaseMailer < ActionMailer::Base
  helper :application

  default Settings.mailer_defaults.symbolize_keys

  self.default_url_options = Settings.action_mailer.default_url_options.symbolize_keys
end
