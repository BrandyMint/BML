module InviteSends
  extend ActiveSupport::Concern

  included do
    after_commit :send_invite, on: :create
  end

  private

  def send_invite
    send_email if email.present?
    send_sms if phone.present?
  end

  def send_sms
    SmsWorker.perform_async phone, sms_text
  end

  def send_email
    InviteMailer.delay.new_invite(id)
  end

  def sms_text
    I18n.t('notifications.sms.invite_created', url: url, account: account.current_domain)
  end
end
