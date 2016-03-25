class Tariff < ActiveRecord::Base
  BASE_SLUG = 'base'.freeze
  ROOT_SLUG = 'root'.freeze
  PROFI_SLUG = 'profi'.freeze

  scope :published, -> { where hidden: false }

  monetize :price_per_month_cents,
           with_model_currency: :price_per_month_currency,
           as: :price_per_month,
           allow_nil: false,
           numericality: { greater_than_or_equal: 0, less_than: Settings.maximal_money }

  monetize :price_per_site_cents,
           with_model_currency: :price_per_site_currency,
           as: :price_per_site,
           allow_nil: false,
           numericality: { greater_than_or_equal: 0, less_than: Settings.maximal_money }

  monetize :price_per_lead_cents,
           with_model_currency: :price_per_lead_currency,
           as: :price_per_lead,
           allow_nil: false,
           numericality: { greater_than_or_equal: 0, less_than: Settings.maximal_money }

  def self.base
    find_by_slug! BASE_SLUG
  end
end
