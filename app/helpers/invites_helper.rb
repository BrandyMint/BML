module InvitesHelper
  def invite_key
    params[:invite_key]
  end

  def invite
    @invite ||= Invite.find_by_key invite_key if invite_key.present?
  end

  def available_roles
    Invite.role.options only: Invite::INVITATION_ROLES
  end

  def invitation_roles
    Invite.role.options only: Invite::INVITATION_ROLES
  end
end
