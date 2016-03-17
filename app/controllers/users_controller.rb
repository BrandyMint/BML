# Контроллер для регистрации
# пользователя без аккаунта
#
class UsersController < ApplicationController
  # include InvitesHelper
  layout 'auth'

  def new
    if invite.present?
      render :invite, locals: { user: build_user }
    else
      render :new, locals: { user: build_user }
    end
  end

  def create
    user = build_user

    if user.save
      auto_login user
      redirect_success
    else
      if invite.present?
        render :invite, locals: { user: user }
      else
        render :new, locals: { user: user }
      end
    end
  end

  private

  def redirect_success
    account = current_user.invited_account || current_user.accounts.first
    if account.present?
      redirect_to account.user_url
    else
      redirect_to profile_url
    end
  end

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
