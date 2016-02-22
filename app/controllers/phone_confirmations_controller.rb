class PhoneConfirmationsController < ApplicationController
  PhoneBlank            = Class.new StandardError
  PhoneAlreadyConfirmed = Class.new StandardError

  before_action :require_login
  before_action :validate_phone,             only: [:edit, :update, :create]
  before_action :validate_already_confirmed, only: [:edit, :update, :create]

  rescue_from PhoneBlank,            with: :blank_phone_new
  rescue_from PhoneAlreadyConfirmed, with: :phone_already_confirmed

  layout 'system'

  def new
    if phone.present?
      if phone_confirmation.is_confirmed?
        flash[:notice] = "Телефон #{form.phone} уже подтвержден"

        success_redirect
      else
        phone_confirmation.deliver_pin_code if phone_confirmation.can_resend?
        render :edit, locals: { form: form, timeout: phone_confirmation.request_timeout }
      end
    else
      render :new, locals: { form: form, timeout: nil }
    end
  rescue PhoneConfirmation::RequestTimeout => err
    render :new, locals: { form: form, timeout: err.timeout }
  end

  # Повторный запрос кода
  def edit
    render :edit, locals: { form: form, timeout: phone_confirmation.request_timeout }
  rescue PhoneConfirmation::RequestTimeout => err
    render :edit, locals: { form: form, timeout: err.timeout }
  end

  # Подтвердить pin
  #
  def update
    if phone_confirmation.confirm form.pin_code

      flash[:notice] = "Телефон #{form.phone} подтвержден"

      success_redirect
    else
      form.pin_code = ''
      form.errors[:pin_code] = 'Неверный код, посмотрите внимательнее'
      render :new, locals: { form: form, timeout: phone_confirmation.request_timeout }
    end
  end

  # Запросить код
  def create
    phone_confirmation.deliver_pin_code
    edit
  rescue PhoneConfirmation::RequestTimeout => err
    render :edit, locals: { form: form, timeout: err.timeout }
  end

  private

  def blank_phone_new
    form.errors[:phone] = 'Введите номер телефона в международном формате'
    render :new, locals: { form: form, timeout: nil }
  end

  def phone_already_confirmed
    flash[:notice] = "Телефон #{form.phone} уже подтвержден"
    success_redirect
  end

  def validate_already_confirmed
    fail PhoneAlreadyConfirmed if phone_confirmation.phone == phone && phone_confirmation.is_confirmed?
  end

  def success_redirect
    redirect_to confirmed_back_url || root_url unless response.redirection?
  end

  def confirmed_back_url
    return nil unless form.backurl.present?

    a = Addressable::URI.parse form.backurl
    a.query_values = (a.query_values || {}).merge confirmed_phone: phone
    a.to_s
  end

  def validate_phone
    fail PhoneBlank if phone.blank?
  end

  def phone_confirmation
    @pc ||= current_user.phone_confirmation_for_phone(phone)
  end

  def form
    @form ||= PhoneConfirmationForm.new form_params
  end

  def form_params
    (params[:phone_confirmation_form] || {})
      .reverse_merge(phone: phone, backurl: params[:backurl])
  end

  def default_phone
    current_user.phone
  end

  def phone
    PhoneUtils.clean_phone(params[:phone] || params[:phone_confirmation_form].try(:fetch, :phone)) || default_phone
  end
end
