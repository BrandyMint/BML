class CollectionItem < ActiveRecord::Base
  extend Enumerize
  include FieldsSupport
  include NumberSupport
  include LeadStates

  CLIENT_FIELDS = %i(firstname lastname middlename phone email).freeze

  if PgSearch::Document.table_exists?
    include PgSearch
    pg_search_scope :search_by_data, against: :data_string
    multisearchable against: [:data_string]
  end

  belongs_to :collection, counter_cache: :items_count, touch: true
  belongs_to :variant, counter_cache: :items_count
  belongs_to :landing

  scope :ordered, -> { order 'id desc' }
  scope :search_by_word, -> (word) { where '? ILIKE ANY(avals(data))', word }
  scope :by_data, lambda { |data|
    scope = all
    data.each { |k, v| scope = scope.where 'data->? = ?', k, v.to_s }
    scope
  }
  scope :by_email_or_phone, lambda { |email, phone|
    if email.present? && phone.present?
      where "data->'email' = ? or data->'phone' = ?", email, phone
    elsif email.present?
      where "data->'email' = ?", email
    elsif phone.present?
      where "data->'phone' = ?", phone
    else
      none
    end
  }

  validates :collection, :data, presence: true

  before_create :set_landing

  delegate(*CLIENT_FIELDS, to: :data)

  def data
    Hashie::Mash.new super || {}
  end

  def name
    [firstname, middlename, lastname].map(&:to_s).map(&:strip).join ' '
  end

  def title
    "Заявка N#{number}"
  end

  def delete_data_key!(key)
    hash = self[:data]
    data_will_change!
    hash.delete key.to_s
    update_attribute :data, hash
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
