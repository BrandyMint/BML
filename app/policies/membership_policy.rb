class MembershipPolicy < AccountPolicy
  def update?
    member.owner? || master?
  end

  def destroy?
    member.owner? || master?
  end

  private

  def master?
    !resource.owner? && member.master?
  end
end
