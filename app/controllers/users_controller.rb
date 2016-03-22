# Контроллер для регистрации
# пользователя без аккаунта
#
class UsersController < ApplicationController
  include InvitesHelper
  layout 'auth'

  def new
    if invite.present?
      render :invite, locals: { user: build_user }
    else
      redirect_to login_url, flash: { error: I18n.t('invites.no_invite') }
    end
  end

  def create
    user = build_user

    if user.save
      auto_login user
      redirect_to account_root_url
    elsif invite.present?
      render :invite, locals: { user: user }
    else
      redirect_to login_url, flash: { error: I18n.t('invites.no_invite') }
    end
  end

  private

  def build_user
    user = if invite.present?
             User.build_from_invite invite
           else
             User.new
           end

    user.assign_attributes permitted_params
    user.validate_invitation

    user
  end

  def permitted_params
    return {} unless params[:user].is_a?(Hash)
    params
      .require(:user)
      .permit(:name, :email, :phone,
              :password, :password_confirmation)
  end
end
