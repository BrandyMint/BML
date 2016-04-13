# Уведомитель сотрудников аккаунта о получении нового лида (записи в таблицы)
class LeadCreatedNotifier
  include Virtus.model strict: true
  include LeadUrlHelper

  attribute :lead, Lead
  attribute :account, Account

  Notify = NotifierHelpers.new

  def call
    safe do
      if sender.sms.present?
        Notify.send_sms sender, notification_phones, :lead_created, sms_payload
      else
        Rails.logger.warn "SMS is not active for #{account}"
      end
      send_emails
    end
  end

  private

  def sender
    NotifierHelpers::Sender.new sms: account.sms_credentials
  end

  def notification_phones
    NotificationPhonesQuery.new(account_id: account.id).call
  end

  def notification_memberships
    account.memberships.with_email_notification.includes(:user)
  end

  def send_emails
    notification_memberships.each do |member|
      Notify.send_email sender, member.user.email, LeadMailer, :new_lead_email, email_payload(member)
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
      lead_url:    ShortUrl.short_url(admin_lead_url),
      number:      lead.number,
      description: description
    }
  end

  def description
    [lead.name, lead.phone, lead.email].compact.join ' '
  end

  def safe
    yield
  rescue => error
    Notify.log_error "error #{error}"
    raise error if Rails.env.test? || Rails.env.development?
    Bugsnag.notify error
  end
end
