class Account::MembersController < Account::BaseController
  layout 'account_settings'

  def index
    authorize Membership

    render locals: {
      members: current_account.memberships.ordered,
      invites: current_account.invites.ordered,
      invite:  build_invite
    }
  end

  def edit
    authorize member

    render locals: { member: member }
  end

  def update
    authorize member

    member.update! permitted_params
    success_redirect
  rescue ActiveRecord::RecordInvalid => _err
    render 'edit'
  end

  def destroy
    authorize member

    member.destroy!
    redirect_to :back
  end

  def send_email_confirmation
    authorize member, :update?

    member.user.deliver_email_confirmation!
    redirect_to :back, flash: { success: I18n.t('flashes.user.confirmation_sent') }
  end

  private

  def success_redirect
    redirect_to account_memberships_path
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
    params.require(:membership).permit(:role, :sms_notification, :email_notification)
  end
end
