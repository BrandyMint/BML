# rubocop:disable Style/ModuleFunction
# Функции для извлечения доменов и субдоменов из строки
module DomainExtractor
  extend self

  def extract_domain(host)
    host.split('.').last(1 + tld_length).join('.')
  end

  def extract_subdomain_from_host(host)
    return nil unless named_host? host
    host.split('.')[0..-(tld_length + 2)].first
  end

  def extract_subdomain_from_domain(domain)
    domain.sub '.' + AppSettings.default_url_options.host, ''
  end

  def tld_length
    ActionDispatch::Http::URL.tld_length
  end

  def named_host?(host)
    AppSettings.domain_zones.include? extract_domain(host)
  end
end
