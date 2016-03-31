class Tariff < ActiveRecord::Base
  BASE_SLUG = 'base'.freeze
  FREE_SLUG = 'free'.freeze
  PROFI_SLUG = 'profi'.freeze

  BLOCKED_LEADS_COUNT = 5

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

  def self.default
    base
  end

  def self.base
    find_by_slug! BASE_SLUG
  end

  def self.free
    find_by_slug! FREE_SLUG
  end

  def to_s
    title
  end

  def blocked_leads_count
    BLOCKED_LEADS_COUNT
  end
end
