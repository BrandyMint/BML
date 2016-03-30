class LeadField
  include Virtus.value_object
  values do
    attribute :key
    attribute :value
  end

  delegate :empty?, to: :value

  def to_s
    "#{key}: #{value}"
  end
end
