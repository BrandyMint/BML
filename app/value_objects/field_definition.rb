class FieldDefinition
  include Virtus.value_object

  values do
    attribute :key, Symbol
    attribute :item_key, String
    attribute :title, String
  end

  def to_s
    title
  end
end
