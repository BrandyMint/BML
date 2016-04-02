module LeadsHelper
  def lead_field_content(lead, column)
    if lead.attributes.include? column.key.to_s
      lead_attribute_value lead, column
    else
      lead_field_value lead, column
    end
  end

  def lead_attribute_value(lead, column)
    value = lead.send(column.key)

    value = truncate_url(value) if column.key.to_s == 'referer'
    value.presence || empty_value_html
  end

  def lead_field_value(lead, column)
    value = lead.data[column.key].presence

    return empty_value_html unless value.present?

    case column.key.to_sym
    when :email
      mail_to value, value
    when :phone
      tel_to value
    else
      value
    end
  end
end
