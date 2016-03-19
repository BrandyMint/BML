class AppSettings
  include Singleton

  ATTRIBUTES = %i(tld_length title host domain_zones asset_host default_domain from default_url_options).freeze

  class << self
    delegate(*ATTRIBUTES, to: :instance)

    def current_app
      Thread.current[:app] || Settings::Applications.default
    end

    def current_app=(app)
      Thread.current[:app] = app
    end
  end

  delegate(*ATTRIBUTES, to: :current_app)

  def default_domain
    current_app.domain_zones.first
  end

  def host
    'http://' + default_url_options.host
  end

  def tld_length
    default_url_options.host.split('.').size - 1
  end

  private

  delegate :current_app, to: AppSettings
end
