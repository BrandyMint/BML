class Lead < ActiveRecord::Base
  extend Enumerize
  include LeadStates
  include FieldsSupport
  include TrackingSupport
  include NumberSupport

  belongs_to :collection, counter_cache: :leads_count, touch: true
  belongs_to :variant, counter_cache: :leads_count
  belongs_to :landing
  belongs_to :client

  scope :ordered, -> { order 'id desc' }
  scope :search_by_word, -> (word) { where '? ILIKE ANY(avals(data))', word }

  validates :collection, :variant, :data, presence: true

  before_create :set_landing

  def name
    data['name']
  end

  def data
    Hashie::Mash.new super || {}
  end

  def delete_data_key!(key)
    hash = self[:data]
    data_will_change!
    hash.delete key.to_s
    update_attribute :data, hash
  end

  def phone
    data['phone']
  end

  def email
    data['email']
  end

  def to_s
    "Заявка N#{public_number}"
  end

  def viewer
    @_viewer ||= Viewer.find_by(landing_id: landing_id, uid: viewer_uid)
  end

  private

  def fields_holder
    collection
  end

  def set_landing
    self.landing_id = variant.landing_id if variant.present?
  end
end
