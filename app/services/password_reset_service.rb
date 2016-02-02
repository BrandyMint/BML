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
    # user_by_phone
  end

  def send_email
    user_by_email.deliver_reset_password_instructions!
  end

  def phone?
    Phoner::Phone.parse(login).present?
  end

  def user_by_email
    User.where(email: login.to_s.downcase.chomp.strip).first!
  end

  def user_by_phone
    User.where(phone: PhoneUtils.clean_phone(login)).first!
  end
end
