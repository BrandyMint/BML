module LeadUrlHelper
  def admin_lead_url
    Rails.application.routes.url_helpers.landing_lead_url(lead.landing, lead, host: lead.landing.account.url)
  end
end
