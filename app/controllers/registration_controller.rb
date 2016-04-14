class RegistrationController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout 'auth'

  def new
    if current_member.present?
      redirect_to accounts_url
    else
      render locals: { registration_form: RegistrationForm.new }
    end
  end

  def create
    registration_form = RegistrationForm.new permitted_params
    user = RegistrationService.new(form: registration_form).call
    authenticate user
    redirect_to account_root_url, flash: { success: I18n.t('flashes.registration.signed_up') }

  rescue RegistrationService::UserDuplicate
    flash.now[:info] = I18n.t('flashes.registration.user_exists_html')
    render 'sessions/new',
      locals: { session_form: SessionForm.new(remember_me: true, login: registration_form.email) }

  rescue ActiveRecord::RecordInvalid => err
    registration_form.errors = err.record.errors
    render :new, locals: { registration_form: registration_form }
  end

  private

  def authenticate(user)
    auto_login user
    self.current_account = user.default_account
  end

  def permitted_params
    params.require(:registration_form).permit(RegistrationForm.attributes.map(&:name))
  end
end
