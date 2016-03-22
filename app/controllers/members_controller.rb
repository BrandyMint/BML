class MembersController < ApplicationController
  layout 'account_settings'

  before_action :require_login

  # authorize_actions_for Member

  def index
    render locals: {
      members: current_account.memberships.ordered,
      invites: current_account.invites.ordered,
      invite:  build_invite
    }
  end

  def edit
    # authorize_action_for member

    render locals: { member: member }
  end

  def update
    # authorize_action_for member, update_params

    member.update! update_params
    success_redirect
  rescue ActiveRecord::RecordInvalid => _err
    render 'edit'
  end

  def destroy
    member.destroy!
    redirect_to :back
  end

  def send_email_confirmation
    member.user.deliver_email_confirmation!
    redirect_to :back, flash: { success: I18n.t('flashes.user.confirmation_sent') }
  end

  private

  def success_redirect
    redirect_to profile_memberships_path
  end

  def member
    if params[:id].present?
      current_account.memberships.find params[:id]
    else
      current_account.memberships.build
    end
  end

  def build_invite
    Invite.new role: :guest
  end

  def permitted_params
    params.require(:invite).permit(:email)
  end

  def update_params
    params.require(:membership).permit(:role, :sms_notification, :email_notification)
  end
end
