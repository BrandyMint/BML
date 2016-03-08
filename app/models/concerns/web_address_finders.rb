module WebAddressFinders
  def find_by_domain(domain)
    find_by_domain_scope domain, &method(:by_domain)
  end

  def find_by_suggested_domain(domain)
    find_by_domain_scope domain, &method(:by_suggested_domain)
  end

  def find_by_request(request)
    model = nil
    if Settings.domain_zones.include?(request.domain)
      model = by_subdomain(request.subdomain).first
    end
    model || find_by_domain(request.host)
  end

  def find_by_host(host)
    return nil unless host.present?
    subdomain = DomainExtractor.extract_subdomain_from_host host

    by_subdomain(subdomain).first ||
      find_by_domain(host)
  end

  private

  def find_by_domain_scope(domain)
    domain = DomainCleaner.search_prepare domain
    model = yield(domain).first

    return model if model.present?
    redomain domain, &proc { |d| yield(d).first }
  rescue PG::Error => err
    Bugsnag.notify err
    nil
  end

  def redomain(domain)
    # landing.ru.bmland.ru => landing.ru
    extracted = DomainExtractor.extract_subdomain_from_domain domain
    return nil if extracted == domain
    yield extracted
  end
end
