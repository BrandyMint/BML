class PhoneConfirmation < ActiveRecord::Base
  REQUEST_TIMEOUT = if Rails.env.development?
                      20.seconds
                    else
                      60.seconds
                    end

  PIN_CODE_LENGTH = 6

  belongs_to :user

  scope :confirmed,     -> { where is_confirmed: true }
  scope :not_confirmed, -> { where is_confirmed: false }
  scope :by_phone,      ->(phone) { where phone: PhoneUtils.clean_phone(phone) }

  before_save :clean_phone
  before_validation :clean_phone
  validates :phone, presence: true, phone: true, uniqueness: true

  before_create :generate_pin_code!
  after_commit :deliver_pin_code!, on: [:create]

  def self.confirm_phone(user, phone, pin_code)
    phone = PhoneUtils.clean_phone phone
    user.phone_confirmation_for_phone(phone).confirm pin_code
  rescue NotPersisted
    false
  end

  def confirm(confirm_pin_code)
    test_persisted!
    if confirm_pin_code == pin_code
      confirm!
    else
      false
    end
  end

  def deliver_pin_code
    raise RequestTimeout, request_timeout unless can_resend?
    deliver_pin_code!
  end

  def deliver_pin_code!
    test_persisted!
    generate_pin_code!
    SmsWorker.perform_async phone, I18n.t('services.pin_sender.sms_text', pin: pin_code)
    @request_timeout = nil
    update_column :pin_requested_at, Time.zone.now
  end

  def can_resend?
    request_timeout == 0
  end

  # Сколько осталось ждать до повторной попытки отправить SMS
  #
  def request_timeout
    return nil unless persisted?
    @request_timeout ||= build_timeout
  end

  private

  def build_timeout
    return 0 if pin_requested_at.blank?
    rt = (Time.zone.now - pin_requested_at).to_i
    return 0 if rt >= REQUEST_TIMEOUT
    REQUEST_TIMEOUT - rt
  end

  def generate_pin_code!
    self.pin_code ||= PinCode.generate PIN_CODE_LENGTH
  end

  def confirm!
    test_persisted!
    update is_confirmed: true, confirmed_at: Time.zone.now unless is_confirmed
    user.confirm_phone! if user.phone == phone && !user.phone_confirmed?
    true
  end

  def test_persisted!
    raise NotPersisted unless persisted?
  end

  def clean_phone
    self.phone = PhoneUtils.clean_phone phone
  end

  NotPersisted = Class.new StandardError

  class RequestTimeout < StandardError
    attr_reader :timeout

    def initialize(timeout)
      @timeout = timeout
    end

    def message
      "Только что отправили SMS с кодом, дождитесь ее. Запросить код повторно сможете через #{I18n.t('user.seconds_count', count: timeout)}."
    end
  end
end
