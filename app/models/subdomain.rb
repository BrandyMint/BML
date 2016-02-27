class Subdomain < ActiveRecord::Base
  ALL_ZONES       = '*'
  AVAILABLE_ZONES = Settings.subdomain_zones + [ALL_ZONES]
  DEFAULT_ZONE    = Settings.app.default_domain
  DEFAULT_CURRENT_ZONE = Settings.app.default_domain

  belongs_to :account, autosave: true

  before_validation :default_zone
  before_validation :generate_subdomain
  validates :zone, presence: true, inclusion: AVAILABLE_ZONES
  validates :subdomain, presence: true, uniqueness: { scope: :zone }

  # TODO DISABLE subdomains with AccountConstraint::DOMAIN_PREFIX
  #
  before_save :cache_current_domain

  private

  def generate_subdomain
    self.subdomain ||= SecureRandom.hex(4)
  end

  def default_zone
    self.zone ||= DEFAULT_ZONE
  end

  # TODO удалить, чтобы можно было определять зону в базе
  def zone
    Settings.app.default_domain
  end

  def cache_current_domain
    if use_domain? && confirmed_domain.present?
      self.current_domain = confirmed_domain
    else
      self.current_domain = subdomain + '.' + current_zone
    end
  end

  def current_zone
    if zone == ALL_ZONES
      DEFAULT_CURRENT_ZONE
    else
      zone
    end
  end
end
