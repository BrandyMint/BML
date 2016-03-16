class Landing < ActiveRecord::Base
  include Activity
  include LandingPath

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy
  has_many :variants, dependent: :destroy
  has_many :segments, dependent: :destroy
  has_many :clients, dependent: :nullify
  has_many :utm_values, dependent: :delete_all
  has_many :leads

  validates :title, presence: true

  after_create :create_default_variant

  scope :ordered, -> { order 'id desc' }
  scope :active, -> { all }

  def used?
    leads.any? && variants.select(&:used?).any?
  end

  def url
    'http://' + account.host + host_port.to_s + path
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

  def host_port
    ':' + Settings.app.default_url_options.port.to_s unless Settings.app.default_url_options.port == 80
  end

  def create_default_variant
    variants.create!
  end
end
