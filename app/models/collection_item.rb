class CollectionItem < ActiveRecord::Base
  belongs_to :collection, counter_cache: :leads_count
  belongs_to :landing_version, counter_cache: :leads_count
  has_one :landing, through: :landing_version

  scope :ordered, -> { order 'id desc' }

  validates :collection, :landing_version, :data, presence: true

  after_create :create_collection_fields

  private

  def create_collection_fields
    data.keys.each do |key|
      collection.fields.upsert key: key, title: key
    end
  end
end
