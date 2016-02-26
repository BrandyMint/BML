class LeadsQuery
  include Virtus.model

  attribute :filter, LeadsFilter

  def call
    s = basic_scope

    CollectionItem.utm_fields.each do |f|
      filter_value = filter.send(f.key)
      s = s.where(f.item_key => filter_value) if filter_value.present?
    end

    s.order order
  end

  private

  def basic_scope
    filter.collection.items
  end

  def order
    { id: :asc } unless sort_field_present?
    { filter.sort_field => sort_order }
  end

  def sort_order
    filter.sort_order == :desc ? filter.sort_order : :asc
  end

  def sort_field_present?
    filter.sort_field.present? &&
      CollectionItem::UTM_FIELDS.include?(filter.sort_field)
  end
end
