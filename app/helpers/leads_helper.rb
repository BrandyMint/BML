module LeadsHelper
  def field_value(field)
    return unknown_value_html unless field.is_a? LeadField
    field.value_html || empty_value_html
  end
end
