module AccountWebAddresses
  extend ActiveSupport::Concern

  included do
    extend WebAddressFinders
    has_many :web_addresses, dependent: :destroy
    accepts_nested_attributes_for :web_addresses, reject_if: :all_blank, allow_destroy: true

    after_create :create_web_address!

    delegate :current_domain, to: :default_web_address

    scope :by_domain,           ->(domain) { joins(:web_addresses).where(web_addresses: { current_domain: domain }) }
    scope :by_subdomain,        ->(subdomain) { joins(:web_addresses).where(web_addresses: { subdomain: subdomain }) }
    scope :by_suggested_domain, ->(domain) { joins(:web_addresses).where(web_addresses: { suggested_domain: domain }) }
  end

  def attach_domain(domain)
    domain = DomainCleaner.search_prepare domain
    web_address = web_addresses.find_by_suggested_domain domain
    web_address.try :confirm
  end

  def host
    current_domain
  end

  def default_web_address
    web_addresses.first
  end

  private

  def create_web_address!
    web_addresses.create!
  end
end
