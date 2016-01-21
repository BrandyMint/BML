class Subdomain < ActiveRecord::Base
  ALL_ZONES       = '*'
  AVAILABLE_ZONES = Settings.subdomain_zones + [ALL_ZONES]
  DEFAULT_ZONE    = ALL_ZONES
  DEFAULT_CURRENT_ZONE = AVAILABLE_ZONES.first

  belongs_to :landing, autosave: true
  has_one :account, through: :landing

  before_validation :default_zone
  validates :zone, presence: true, inclusion: AVAILABLE_ZONES
  validates :subdomain, presence: true, uniqueness: { scope: :zone }

  # TODO DISABLE subdomains with AccountConstraint::DOMAIN_PREFIX
  #
  before_save :cache_current_domain

  private

  def default_zone
    self.zone ||= DEFAULT_ZONE
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
