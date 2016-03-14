class RequestProxy < SimpleDelegator
  attr_reader :tld_length

  APP_DOMAIN = 'app'.freeze
  API_DOMAIN = 'api'.freeze

  def initialize(request)
    @tld_length = find_tld_length request.host
    super request
  end

  def domain
    # ActionDispatch::Http::URL.extract_domain(host, tld_length)
    super tld_length
  end

  def subdomain
    super(tld_length).to_s
  end

  def app?
    (subdomain == APP_DOMAIN || subdomain.blank?)
  end

  def api?
    domain_zone? && subdomain == API_DOMAIN
  end

  def domain_zone?
    domain_zones.include? domain
  end

  private

  delegate :host, to: :request

  delegate :domain_zones, to: Settings

  def request
    __getobj__
  end

  def find_tld_length(host)
    domain_zones.each do |d|
      return d.split('.').length - 1 if host == d || (host.ends_with? '.' + d)
    end

    ActionDispatch::Http::URL.tld_length
  end
end
