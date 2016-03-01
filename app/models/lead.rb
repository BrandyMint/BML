class Lead < ActiveRecord::Base
  UTM_FIELDS = [
    :utm_source,
    :utm_campaign,
    :utm_medium,
    :utm_term,
    :utm_content,
    :referer
  ]

  belongs_to :collection, counter_cache: :leads_count
  belongs_to :variant, counter_cache: :leads_count
  has_one :landing, through: :variant

  scope :ordered, -> { order 'id desc' }

  validates :collection, :variant, :data, presence: true

  after_create :create_collection_fields

  def self.utm_fields
    UTM_FIELDS.map do |f|
      OpenStruct.new(
        key: f,
        item_key: "last_#{f}",
        title: I18n.t("utm_fields.#{f}")
      )
    end
  end

  private

  def create_collection_fields
    data.keys.each do |key|
      collection.fields.upsert key: key, title: key
    end
  end
end
