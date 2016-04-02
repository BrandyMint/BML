class LeadsFilter
  include Virtus.model

  STATE_ANY = 'any'.freeze

  STATE_NOT_DECLINED = 'not_declined'.freeze

  STATES_OPTIONS = [
    STATE_NOT_DECLINED,
    LeadStates::STATE_NEW,
    LeadStates::STATE_ACCEPTED,
    LeadStates::STATE_DECLINED,
    STATE_ANY
  ].freeze

  PRESENCE_FIELDS = TrackingSupport::UTM_FIELDS + [:state]

  TrackingSupport::UTM_FIELDS.each do |f|
    attribute f, String
  end

  attribute :account, Account
  attribute :collection, Collection
  attribute :variant, Variant
  attribute :sort_field, Symbol, default: :id
  attribute :sort_order, Symbol, default: :asc
  attribute :limit, Integer
  attribute :state, String, default: STATE_NOT_DECLINED

  attr_accessor :popular_utm_options

  def present?
    PRESENCE_FIELDS.any? { |f| send(f).present? }
  end
end
