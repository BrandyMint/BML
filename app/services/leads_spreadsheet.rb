class LeadsSpreadsheet < AbstractBaseSpreadsheet
  def initialize(source, items)
    raise unless source.is_a? Collection
    @source = source
    @collection = items
    @columns = source.columns.map(&:to_s) + FieldsSupport::INTERNAL_FIELDABLE_ATTRIBUTES.map(&:to_s)
  end

  private

  attr_reader :source, :columns

  STATIC_COLUMNS = [:id, :number, :public_number, :variant, :state].freeze

  def header_row
    STATIC_COLUMNS + columns.map(&:to_s)
  end

  def row(item)
    static_row(item) +
      fields_row(item)
  end

  def fields_row(item)
    columns.map do |c|
      field = item.fields[c]
      field.try :value
    end
  end

  def static_row(item)
    STATIC_COLUMNS.map do |s|
      item.send(s)
    end
  end
end
