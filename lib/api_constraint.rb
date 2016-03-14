class ApiConstraint
  SUBDOMAIN = 'api'.freeze

  def self.matches?(request)
    Settings.domain_zones.include?(request.domain) && request.subdomain == SUBDOMAIN
  end
end
