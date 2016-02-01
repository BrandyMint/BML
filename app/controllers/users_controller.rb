class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    # ???
    if current_user.present?
      redirect_to account_dashboard_url(current_user.accounts.first)
    else
      render locals: { user: User.new }
    end
  end

  def create
    user = User.new permitted_params
    if user.save
      # TODO invite activation
      redirect_to login_url
    else
      render :new, locals: { user: user }
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
