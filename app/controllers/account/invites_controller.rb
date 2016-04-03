class Account::InvitesController < Account::BaseController
  layout 'account'

  def create
    authorize invite

    if invite.valid?
      users = invite.find_and_bind_users
      if users.any?
        return redirect_to account_memberships_path,
                           flash: { info: I18n.t('flashes.invites.members_added', users: users.join(', ')) }
      end
    end

    invite.save!
    redirect_to account_memberships_path,
                flash: { info: I18n.t('flashes.invites.created') }

  rescue ActiveRecord::RecordInvalid => err
    if err.record.errors[:user_id].present?
      flash.now[:error] = err.record.errors[:user_id].join('; ')
    end
    render :new, locals: { invite: invite }
  end

  def destroy
    authorize invite

    invite.destroy!
    redirect_to account_memberships_path,
                flash: { error: I18n.t('flashes.invites.deleted') }
  end

  private

  def invite
    @invite ||= build_invite
  end

  def build_invite
    if action_name == 'destroy'
      current_account.invites.find params[:id]
    else
      i = current_account.invites.build permitted_params
      i.user_inviter = current_user
      i
    end
  end

  def permitted_params
    params.require(:invite).permit :email, :phone, :role
  end
end
