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
  has_one :leads_collection, class_name: 'LeadsCollection', dependent: :delete
  has_one :records_collection, class_name: 'RecordsCollection', dependent: :delete
  has_one :clients_collection, class_name: 'ClientsCollection', dependent: :delete

  has_many :segments, dependent: :delete_all
  has_many :clients, through: :clients_collection
  has_many :utm_values, dependent: :delete_all
  has_many :leads, dependent: :delete_all
  has_many :collection_items, dependent: :delete_all
  has_many :landing_views, dependent: :delete_all
  has_many :variants, dependent: :destroy

  has_many :wizard_answers, dependent: :destroy
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
    collections.where(type: LeadsCollection.name).sum(:items_count)
  end

  def default_clients_collection
    clients_collection || create_clients_collection(title: 'Клиенты')
  end

  # Collections for LeaderBoard
  def default_leads_collection
    leads_collection || create_leads_collection(title: 'Заявки')
  end

  # Collections for LeaderBoard
  def default_records_collection
    records_collection || create_records_collection(title: 'Рекорды')
  end

  def default_variant
    @_default_variant ||= variants.active.ordered.first || variants.ordered.first
  end
end
