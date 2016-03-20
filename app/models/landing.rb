class Landing < ActiveRecord::Base
  include Activity
  include LandingPath
  include UrlHelper

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy
  has_many :leads, dependent: :delete
  has_many :landing_views, dependent: :delete
  has_many :variants, dependent: :destroy
  has_many :segments, dependent: :delete
  has_many :clients, dependent: :delete
  has_many :utm_values, dependent: :delete_all

  validates :title, presence: true

  after_create :create_default_variant

  scope :ordered, -> { order 'id desc' }
  scope :active, -> { all }

  def used?
    leads.any? && variants.select(&:used?).any?
  end

  def url
    account.url + path
  end

  def short_name
    url_without_protocol url
  end

  def viewers
    Viewer.where(landing_id: id)
  end

  def to_s
    title
  end

  def total_leads_count
    collections
      .sum(:leads_count)
  end

  def default_collection
    collections
      .first_or_create!
  end

  def default_variant
    @_default_variant ||= variants.active.ordered.first || variants.ordered.first
  end

  private

  def create_default_variant
    variants.create!
  end
end
