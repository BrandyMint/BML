class RegistrationController < ApplicationController
  include CurrentAccount

  skip_before_action :verify_authenticity_token

  layout 'system'

  def new
    if current_member.present?
      redirect_to account_dashboard_url(current_member.accounts.first)
    else
      render locals: { registration_form: RegistrationForm.new }
    end
  end

  def create
    registration_form = RegistrationForm.new permitted_params
    account = RegistrationService.new(form: registration_form).call
    set_current_account account

    redirect_to account_root_url, flash: { success: I18n.t('flashes.registration.signed_up') }
  rescue ActiveRecord::RecordInvalid => err
    registration_form.errors = err.record.errors
    render :new, locals: { registration_form: registration_form }
  end

  private

  def permitted_params
    params.require(:registration_form).permit(:name, :email, :phone, :password)
  end
end
