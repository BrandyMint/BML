class LeadsFilter
  include Virtus.model

  Lead::UTM_FIELDS.each do |f|
    attribute f, String
  end

  attribute :account, Account
  attribute :collection, Collection
  attribute :variant, Variant
  attribute :sort_field, Symbol, default: :id
  attribute :sort_order, Symbol, default: :asc
  attribute :limit, Integer

  attr_accessor :popular_utm_options
end
