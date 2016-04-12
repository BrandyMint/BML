class Landing < ActiveRecord::Base
  include Activity
  include LandingPath
  include UrlHelper

  # Якорь формы
  #
  FORM_FRAGMENT = 'form'.freeze

  belongs_to :account, counter_cache: true

  has_many :collections, dependent: :destroy

  # TODO: перенести на belongs_to
  #
  has_one :leads_collection, class_name: 'LeadsCollection'
  has_one :records_collection, class_name: 'RecordsCollection'

  has_many :segments, dependent: :delete_all
  has_many :clients, dependent: :delete_all
  has_many :utm_values, dependent: :delete_all
  has_many :leads, dependent: :delete_all
  has_many :landing_views, dependent: :delete_all

  has_many :variants, dependent: :destroy
  validates :title, presence: true

  scope :ordered, -> { order 'id desc' }
  scope :active, -> { all }

  delegate :count, to: :viewers, prefix: true

  def used?
    leads.any? && variants.select(&:used?).any?
  end

  def url
    account.url + path
  end

  def short_name
    # TODO: если в домене bmland, aydamaster то показывать только поддомен
    title.presence || url_without_protocol(url)
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

  def default_leads_collection
    leads_collection || create_leads_collection
  end

  # Collections for LeaderBoard
  def default_records_collection
    records_collection | create_records_collection
  end

  def default_variant
    @_default_variant ||= variants.active.ordered.first || variants.ordered.first
  end
end
