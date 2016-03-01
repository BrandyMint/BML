class LeadsFilter
  include Virtus.model

  CollectionItem::UTM_FIELDS.each do |f|
    attribute f, String
  end

  attribute :collection, Collection
  attribute :sort_field, Symbol, default: :id
  attribute :sort_order, Symbol, default: :asc
end
