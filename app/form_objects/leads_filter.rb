# Фильтр заявок
class LeadsFilter
  include Virtus.model

  STATE_ANY = 'any'.freeze

  STATES_OPTIONS = [
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
  attribute :state, String, default: LeadStates::STATE_NEW
  attribute :search, String

  delegate :to_param, to: :params

  def params(args = {})
    attributes
      .except(:limit, :variant, :collection, :account)
      .merge!(collection_id: collection.id)
      .merge!(args)
      .compact
  end

  def csv_params
    attributes
      .except(:limit, :variant, :collection, :account)
      .compact
  end

  def present?
    PRESENCE_FIELDS.any? { |f| send(f).present? }
  end

  def state_for_query
    self.class.state_for_query state
  end

  def variant_id
    variant.try :id
  end

  def self.state_for_query(state)
    case state
    when STATE_ANY
      nil
    else
      state
    end
  end
end
