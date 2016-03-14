class WebAddress < ActiveRecord::Base
  ALL_ZONES       = '*'.freeze
  AVAILABLE_ZONES = Settings.domain_zones + [ALL_ZONES]
  DEFAULT_ZONE    = AppSettings.default_domain
  DEFAULT_CURRENT_ZONE = AppSettings.default_domain
  DOMAIN_PATTERN = Regexp.union(*Settings.domain_zones)

  # http://tools.ietf.org/html/rfc2181#section-11
  SUBDOMAIN_MAX_LENGTH = 63
  DOMAIN_MAX_LENGTH = 253

  belongs_to :account, autosave: true

  before_validation :default_zone
  before_validation :generate_subdomain
  before_validation :prepare_domains

  validates :zone, presence: true, inclusion: AVAILABLE_ZONES

  validates :subdomain,
            presence: true,
            subdomain: true,
            uniqueness: { scope: :zone },
            length: { maximum: SUBDOMAIN_MAX_LENGTH },
            format: { without: DOMAIN_PATTERN },
            exclusion: { in: Settings.reserved_subdomains }

  validates :suggested_domain,
            domain: true,
            length: { maximum: DOMAIN_MAX_LENGTH },
            uniqueness: { allow_blank: true },
            format: { without: DOMAIN_PATTERN }

  validates :confirmed_domain,
            domain: true,
            length: { maximum: DOMAIN_MAX_LENGTH },
            uniqueness: { allow_blank: true },
            format: { without: DOMAIN_PATTERN }

  # TODO: DISABLE subdomains with AccountConstraint::DOMAIN_PREFIX
  #

  before_save :prepare_domains
  before_save :cache_current_domain

  def confirm
    return unless suggested_domain?
    update use_domain: true, confirmed_domain: suggested_domain, suggested_domain: ''
  end

  private

  def generate_subdomain
    self.subdomain ||= SecureRandom.hex(4)
  end

  def default_zone
    self.zone ||= DEFAULT_ZONE
  end

  def cache_current_domain
    self.current_domain = if use_domain? && confirmed_domain.present?
                            confirmed_domain
                          else
                            subdomain + '.' + current_zone
                          end
  end

  def prepare_domains
    self.subdomain        = DomainCleaner.prepare_subdomain(subdomain) if subdomain?
    self.suggested_domain = DomainCleaner.save_prepare(suggested_domain) if suggested_domain?
    self.confirmed_domain = DomainCleaner.save_prepare(confirmed_domain) if confirmed_domain?
  end

  def current_zone
    if zone == ALL_ZONES
      DEFAULT_CURRENT_ZONE
    else
      zone
    end
  end
end
