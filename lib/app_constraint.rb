require 'request_proxy'

class AppConstraint
  def self.matches?(request)
    # Если заходят по IP, до домена нет, значит это домашняя страница
    # return true if request.domain.blank?

    Settings.domain_zones.include?(request.domain) && request.subdomain.blank?
  end
end
