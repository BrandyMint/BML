class Settings < Settingslogic
  source "#{Rails.root}/config/application.local.yml" if File.exist? "#{Rails.root}/config/application.local.yml"
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  suppress_errors Rails.env.production?

  Rails.configuration.action_mailer.merge!(action_mailer.try(:symbolize_keys) || {})
  ActionDispatch::Http::URL.tld_length = Settings.tld_length

  def root
    Pathname.new(super.presence || Rails.root)
  end
end

class Settings::Elasticsearch < Settingslogic
  source "#{Rails.root}/config/settings/elasticsearch.yml"
end
