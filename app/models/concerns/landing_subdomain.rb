module LandingSubdomain
  extend ActiveSupport::Concern

  included do
    has_one :subdomain, dependent: :destroy
    accepts_nested_attributes_for :subdomain

    after_create :create_subdomain!

    delegate :current_domain, to: :subdomain
  end

  def host
    current_domain
  end
end
