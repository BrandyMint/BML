module DomainHelper
  def find_app(request)
    Settings::Applications.apps.find do |app|
      request.tld_length = app.tld_length

      match = app.domain_zones.include?(request.domain) && (!block_given? || yield(request))

      match ? app : nil
    end
  end
end
