module LeadUrlHelper
  def admin_lead_url
    Rails.application.routes.url_helpers.account_landing_lead_url(lead.landing, lead, host: lead.landing.account.url)
  end
end
