class Lead < ActiveRecord::Base
  extend Enumerize
  include LeadStates

  UTM_FIELDS = [
    :utm_source,
    :utm_campaign,
    :utm_medium,
    :utm_term,
    :utm_content,
    :referer
  ].freeze

  Lead::ATTRIBUTES = UTM_FIELDS + UTM_FIELDS.map { |a| "last_#{a}" } + UTM_FIELDS.map { |a| "first_#{a}" }

  belongs_to :collection, counter_cache: :leads_count
  belongs_to :variant, counter_cache: :leads_count
  belongs_to :landing
  belongs_to :client

  scope :ordered, -> { order 'id desc' }

  validates :collection, :variant, :data, presence: true

  before_create :generate_public_number
  before_create :set_number
  before_create :set_landing
  before_create :fill_current_utms
  after_create :create_collection_fields

  # TODO: вынести в хелперы
  #
  def self.utm_fields
    UTM_FIELDS.map do |f|
      OpenStruct.new(
        key: f,
        item_key: f,
        title: I18n.t("utm_fields.#{f}")
      )
    end
  end

  def fields
    data.map do |k, v|
      LeadField.new key: k, value: v
    end
  end

  def name
    data['name']
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

  def description
    [name, phone, email].compact.join ' '
  end

  private

  def fill_current_utms
    # TODO: думать какие устанвить first/last
    self.utm_source = last_utm_source
    self.utm_campaign = last_utm_campaign
    self.utm_medium = last_utm_medium
    self.utm_term = last_utm_term
    self.utm_content = last_utm_content

    self.referer = last_referer.presence || first_referer
  end

  def set_landing
    self.landing_id = variant.landing_id
  end

  def generate_public_number
    self.public_number = SecureRandom.hex(4).upcase
  end

  def set_number
    self.number ||= variant.leads.count + 1
  end

  def create_collection_fields
    data.keys.reject { |k| k == 'cookie' }.each do |key|
      collection.fields.upsert key: key, title: key
    end
  end
end
