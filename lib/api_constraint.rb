class ApiConstraint
  SUBDOMAIN = 'api'
  def self.matches?(request)
    request.subdomain == SUBDOMAIN
  end
end
