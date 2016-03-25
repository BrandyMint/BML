class MembershipPolicy < AccountPolicy
  def update?
    member.owner? || master?
  end

  def destroy?
    member.admin? && !resource.owner? && not_self?
  end

  private

  def not_self?
    member != resource
  end

  def master?
    !resource.owner? && member.master?
  end
end
