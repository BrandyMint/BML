class RegistrationController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout 'auth'

  def new
    # ???
    if current_member.present?
      redirect_to account_dashboard_url(current_member.accounts.first)
    else
      render locals: { registration_form: RegistrationForm.new }
    end
  end

  def create
    registration_form = RegistrationForm.new permitted_params
    RegistrationService.new(form: registration_form).call

    # TODO invite activation
    redirect_to login_url, flash: { success: I18n.t('flash.signed_up') }

  rescue ActiveRecord::RecordInvalid => err
    registration_form.errors = err.record.errors
    render :new, locals: { registration_form: registration_form }
  end

  private

  def permitted_params
    params.require(:registration_form).permit(:name, :email, :phone, :password)
  end
end
