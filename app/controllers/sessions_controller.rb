class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  layout 'auth'

  def new
    render locals: { session_form: SessionForm.new }
  end

  def create
    session_form = SessionForm.new permitted_params
    user = login session_form.email, session_form.password, session_form.remember_me

    if user
      redirect_to account_dashboard_url(current_user.accounts.first)
    else
      flash[:now] = { error: t('flash.session_failed') }
      render :new, locals: { session_form: session_form }
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def permitted_params
    params.require(:session_form).permit(:email, :password, :remember_me)
  end
end
