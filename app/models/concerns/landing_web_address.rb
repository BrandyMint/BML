module LandingWebAddress
  extend ActiveSupport::Concern

  included do
    has_one :web_address, dependent: :destroy
    accepts_nested_attributes_for :web_address

    after_create :create_web_address!

    delegate :current_domain, to: :web_address
  end

  def host
    current_domain
  end
end
