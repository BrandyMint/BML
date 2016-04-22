module LeadsHelper
  def field_value(field)
    return unknown_value_html unless field.is_a? LeadField
    field.value_html || empty_value_html
  end

  def lead_additinal_info(lead)
    if lead.is_a? Client
      link_to I18n.t(:items_count, count: lead.leads.count), landing_leads_url(current_landing, state: :any, client_id: lead.id)
    elsif lead.client.present?
      link_to lead.client, landing_lead_url(current_landing, lead.client)
    else
      empty_value_html
    end
  end
end
