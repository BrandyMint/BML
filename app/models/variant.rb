class Variant < ActiveRecord::Base
  include Activity

  belongs_to :landing, counter_cache: :variants_count
  has_many :sections, dependent: :destroy
  has_many :leads

  has_one :account, through: :landing

  scope :ordered, -> { order :id }

  def full_title
    "#{landing} / #{self}"
  end

  def usable_title
    title.presence || landing.head_title.presence || landing.title
  end

  def to_s
    title.presence || I18n.l(updated_at, format: :short)
  end
end
