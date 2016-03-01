class Variant < ActiveRecord::Base
  include Activity

  belongs_to :landing, counter_cache: :variants_count
  has_many :sections, dependent: :destroy
  has_many :leads
  has_many :utm_values

  has_one :account, through: :landing

  scope :ordered, -> { order :id }

  def full_title
    "#{landing} / #{to_s}"
  end

  def to_s
    title.presence || I18n.l(updated_at, format: :short)
  end
end
