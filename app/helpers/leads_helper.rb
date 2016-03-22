module LeadsHelper
  def lead_field_content(lead, field)
    buffer = lead.data[field.key].presence

    return empty_value_html unless buffer.present?

    case field.key.to_sym
    when :email
      mail_to buffer, buffer
    when :phone
      tel_to buffer
    else
      buffer
    end
  end
end
