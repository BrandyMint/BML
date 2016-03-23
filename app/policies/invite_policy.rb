class InvitePolicy < AccountPolicy
  def destroy?
    resource.user_inviter_id == member.user.id || super
  end
end
