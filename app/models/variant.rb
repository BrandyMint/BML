class Variant < ActiveRecord::Base
  include Activity

  belongs_to :landing, counter_cache: :variants_count
  has_many :sections, dependent: :destroy
  has_many :leads, dependent: :nullify
  has_many :landing_views, dependent: :delete_all

  has_one :account, through: :landing

  scope :ordered, -> { order :id }

  before_create :set_account

  def full_title
    "#{landing} / #{self}"
  end

  def used?
    # TODO: Проверять что секии не дефолтные
    sections.any?
  end

  def usable_title
    title.presence || landing.head_title.presence || landing.title
  end

  def to_s
    title.presence || I18n.l(updated_at, format: :short)
  end

  def data=(raw)
    SectionsUpdater.new(self).update JSON.parse raw
  end

  def data
    JSON.pretty_generate Entities::VariantEntity.represent(self, clear: true).as_json
  end

  private

  def set_account
    self.account_id = landing.account_id
  end
end
