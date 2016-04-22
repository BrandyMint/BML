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

  TrackingSupport::UTM_FIELDS.each do |f|
    attribute f, String
  end

  attribute :account, Account
  attribute :collection_id, Integer
  attribute :variant_id, Integer
  attribute :sort_field, Symbol, default: :id
  attribute :sort_order, Symbol, default: :asc
  attribute :limit, Integer
  attribute :state, String, default: LeadStates::STATE_NEW
  attribute :client_id, Integer
  attribute :search, String

  delegate :to_param, to: :params

  HIDDEN_FIELDS = %i(limit sort_order sort_field state account)
  OPEN_FIELDS = LeadsFilter.attribute_set.map(&:name).reject { |f| HIDDEN_FIELDS.include? f }
  PRESENCE_FIELDS = OPEN_FIELDS + [:state]

  # Отдаем только те параметры, которые достаточно для сброса фильтра
  def reset_params
    {}
  end

  def merge(args)
    LeadsFilter.new to_h.merge(args)
  end

  def params(args = {})
    attributes
      .except(:limit, :variant, :account)
      .merge!(args)
      .compact
  end

  def collection
    return nil unless collection_id.present?
    @collection ||= account.collections.find collection_id
  end

  def csv_params
    attributes
      .except(:limit, :variant, :collection, :account)
      .compact
  end

  def open?
    OPEN_FIELDS.any? { |f| send(f).present? }
  end

  def present?
    PRESENCE_FIELDS.any? { |f| send(f).present? }
  end

  def state_for_query
    self.class.state_for_query state
  end

  def variant
    return nil unless variant_id.present?
    @variant ||= account.variants.find_by_id variant_id
  end

  def client
    return nil unless client_id.present?
    @client ||= account.clients.find_by_id client_id
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
