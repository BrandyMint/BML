class LeadCreatedNotifier
  include Virtus.model
  include NotifierHelpers

  attribute :phones
  attribute :email_members
  attribute :lead

  def call
    safe do
      send_sms phones, :lead_created, sms_payload
      send_emails
    end
  end

  private

  def send_emails
    email_members.each do |member|
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
      number: lead.number
    }
  end
end
