class ApiConstraint
  SUBDOMAIN = 'api'

  def self.matches?(request)
    Settings.domain_zones.include?(request.domain) && request.subdomain == SUBDOMAIN
  end
end
