class Settings < Settingslogic
  source "#{Rails.root}/config/settings.yml"

  suppress_errors false

  def root
    Pathname.new(super.presence || Rails.root)
  end

  def domains
    @_domains ||= Settings::Applications.apps.map(&:domain_zones).flatten
  end
end

class Settings::Elasticsearch < Settingslogic
  source "#{Rails.root}/config/settings/elasticsearch.yml"
end

class Settings::Applications < Settingslogic
  source "#{Rails.root}/config/applications.#{Rails.env}.yml"
  suppress_errors false

  def self.default
    apps.first
  end
end
