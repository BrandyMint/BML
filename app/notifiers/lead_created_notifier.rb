class LeadCreatedNotifier
  include Virtus.model strict: true
  include NotifierHelpers
  include LeadUrlHelper

  attribute :lead, Lead
  attribute :account, Account

  def call
    safe do
      send_sms notification_phones, :lead_created, sms_payload
      send_emails
    end
  end

  private

  def notification_phones
    NotificationPhonesQuery.new(account_id: account.id).call
  end

  def notification_memberships
    account.memberships.with_email_notification.includes(:user)
  end

  def send_emails
    notification_memberships.each do |member|
      send_email member.user.email, LeadMailer, :new_lead_email, email_payload(member)
    end
  end

  def email_payload(member)
    {
      membership_id: member.id,
      lead_id: lead.id
    }
  end

  def sms_payload
    {
      site:        lead.landing.short_name,
      lead_url:    admin_lead_url,
      number:      lead.number,
      description: lead.description
    }
  end
end
