# Запрос заявок по фильтру
class LeadsQuery
  include Virtus.model

  attribute :filter, LeadsFilter

  def call
    s = basic_scope

    TrackingSupport::UTM_FIELD_DEFINITIONS.each do |f|
      filter_value = filter.send(f.key)
      s = s.where(f.item_key => filter_value) if filter_value.present?
    end

    s = s.where(variant: filter.variant) if filter.variant.present?
    s = s.with_state(*filter.state_for_query) if filter.state_for_query.present?
    s = s.search_by_word filter.search if filter.search.present?

    s = s.order order
    s = limit s
    s
  end

  private

  def basic_scope
    filter.collection.leads
  end

  def order
    return { id: :desc } unless sort_field_present?
    { filter.sort_field => sort_order }
  end

  def limit(s)
    s = s.limit filter.limit if filter.limit.present?
    s
  end

  def sort_order
    filter.sort_order == :asc ? filter.sort_order : :desc
  end

  def sort_field_present?
    filter.sort_field.present? &&
      TrackingSupport::UTM_FIELDS.include?(filter.sort_field)
  end
end
