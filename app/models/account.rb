class Account < ActiveRecord::Base
  include AccountAccessKey
  include AccountIdent
  include AccountWebAddresses
  include AccountBilling
  include AccountTariff
  include AccountSmsc

  ROOT_IDENT = 'root'.freeze

  scope :ordered, -> { order 'id desc' }

  has_many :landings,    dependent: :destroy, class_name: '::Landing'
  has_many :collections, through: :landings, dependent: :destroy, source: :collections

  has_many :collection_items, through: :collections, source: :items
  has_many :leads, through: :collections, source: :items
  has_many :clients, through: :collections, source: :items

  has_many :variants, through: :landings

  has_many :asset_files, dependent: :destroy
  has_many :asset_images, dependent: :delete_all
  has_many :tariff_months, dependent: :delete_all

  has_many :authentications, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :invites, dependent: :destroy

  has_many :sms_log_entities, dependent: :delete_all, class_name: 'AccountSmsLogEntity'
  has_many :utm_values, dependent: :delete_all
  has_many :payment_accounts

  def default_landing
    landings.ordered.first
  end

  def to_s
    name.presence || title
  end

  def to_label
    to_s
  end

  def title
    current_domain
  end

  def api_key
    access_key
  end

  def self.root
    find_by_ident ROOT_IDENT
  end
end
