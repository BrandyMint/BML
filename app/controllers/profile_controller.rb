class ProfileController < ApplicationController
  include PhoneConfirmationHelper
  before_action :require_login
  skip_before_action :require_login, only: [:confirm_email]

  layout 'account'

  def show
    render locals: { user: current_user }
  end

  def update
    current_user.update! permitted_params
    redirect_to profile_url
  rescue ActiveRecord::RecordInvalid => e
    render :show, locals: { user: e.record }
  end

  def send_email_confirmation
    current_user.deliver_email_confirmation!
    redirect_to :back, flash: { success: I18n.t('flashes.user.confirmation_sent') }
  end

  def confirm_email
    user = User.where(email_confirm_token: params[:token]).first!
    user.confirm_email!
    if current_user.present?
      redirect_to profile_url, flash: { success: I18n.t('flashes.user.confirmed') }
    else
      redirect_to login_url, flash: { success: I18n.t('flashes.user.confirmed') }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to login_url, flash: { error: I18n.t('flashes.user.not_confirmed') }
  end

  private

  def permitted_params
    params.require(:user).permit(:name,
                                 :email,
                                 :phone,
                                 :password,
                                 :password_confirmation)
  end
end
