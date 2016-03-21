module UserConfirmation
  extend ActiveSupport::Concern

  included do
    before_save :clear_is_delivery_email

    before_save :require_email_confirmation, if: :email_changed?
    before_save :require_phone_confirmation, if: :phone_changed?

    after_commit :deliver_email_confirmation!, on: [:create, :update], if: :delivery_email?
  end

  def one_of_confirmed_phones?(phone)
    phone_confirmations.by_phone(phone).confirmed.exists?
  end

  def phone_confirmed?
    phone_confirmed_at.present?
  end

  def phone_confirmation_for_phone(some_phone = nil)
    phone_confirmations.find_or_create_by! phone: (some_phone.presence || phone)
  end

  def confirm_some_phone!(phone, pin_code)
    phone_confirmations.by_phone(phone).not_confirmed.each do |pc|
      pc.confirm pin_code
    end
  end

  def email_confirmed?
    email_confirmed_at.present?
  end

  def confirm_phone_if_need!(confirm_phone)
    confirm_phone! if confirm_phone == phone
  end

  def confirm_phone!
    return if phone_confirmed?
    update_column :phone_confirmed_at, Time.zone.now
  end

  def confirm_email!
    return if email_confirmed?
    update_columns email_confirmed_at: Time.zone.now
  end

  def email_confirmation_url
    Rails.application.routes.url_helpers
         .email_confirmation_url token: email_confirm_token, host: AppSettings.host
  end

  def deliver_email_confirmation!
    clear_is_delivery_email
    UserMailer.delay.email_confirmation id
  end

  private

  def require_phone_confirmation
    pc = phone_confirmations.by_phone(phone).first

    if pc.present?
      self.phone_confirmed_at = pc.confirmed_at
    else
      phone_confirmations.build phone: phone
      self.phone_confirmed_at = nil
    end
  end

  def require_email_confirmation
    self.email_confirmed_at = nil
    return unless email.present?
    self.email_confirm_token = Sorcery::Model::TemporaryToken.generate_random_token
    set_delivery_email
  end

  def set_delivery_email
    @_delivery_email = true
  end

  def delivery_email?
    @_delivery_email
  end

  def clear_is_delivery_email
    @_delivery_email = false
    true
  end
end
