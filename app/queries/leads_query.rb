class LeadsQuery
  include Virtus.model

  attribute :filter, LeadsFilter

  def call
    s = basic_scope

    Lead.utm_fields.each do |f|
      filter_value = filter.send(f.key)
      s = s.where(f.item_key => filter_value) if filter_value.present?
    end

    s = s.where(variant: filter.variant) if filter.variant.present?
    s = s.with_state(*state) if filter.state.present? && state.present?

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
      Lead::UTM_FIELDS.include?(filter.sort_field)
  end

  def state
    case filter.state
    when LeadsFilter::STATE_ANY
      nil
    when LeadsFilter::STATE_NOT_DECLINED
      [Lead::STATE_NEW, Lead::STATE_ACCEPTED]
    else
      filter.state
    end
  end
end
