module AccountSmsc
  extend ActiveSupport::Concern

  included do
    before_update :reactivate_smsc
  end

  def sms_credentials
    return unless smsc_active?

    SmsWorker::Credentials.new(
      account_id: id,
      login:      smsc_login,
      password:   smsc_password,
      sender:     smsc_sender.presence
    )
  end

  private

  def reactivate_smsc
    self.smsc_active = (smsc_login_changed? || smsc_password_changed? || smsc_sender_changed?) && smsc_login.present? && smsc_password.present?
    true
  end
end
