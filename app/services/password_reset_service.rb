class PasswordResetService
  include Virtus.model

  attribute :login, String

  def call
    if phone?
      send_sms
    else
      send_email
    end
  end

  private

  def send_sms
    user_by_phone.change_password! pin_code
    SmsWorker.perform_async user_by_phone.phone, I18n.t('notifications.sms.new_pin_code', pin_code: pin_code)
  end

  def send_email
    user_by_email.deliver_reset_password_instructions!
  end

  def phone?
    Phoner::Phone.valid? login
  end

  def user_by_email
    @_user ||= User.where(email: EmailUtils.clean_email(login)).first!
  end

  def user_by_phone
    @_user ||= User.where(phone: PhoneUtils.clean_phone(login)).first!
  end

  def pin_code
    @_pin_code ||= PinCode.generate
  end
end
