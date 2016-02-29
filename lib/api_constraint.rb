class ApiConstraint
  SUBDOMAIN = 'api'

  def self.matches?(request)
    Rails.logger.warn("ApiConstraint (#{request.tld_length}) '#{request.domain}' / #{request.subdomain},#{SUBDOMAIN}, #{request.subdomain == SUBDOMAIN}")
    Settings.domain_zones.include?(request.domain) && request.subdomain == SUBDOMAIN
  end
end
