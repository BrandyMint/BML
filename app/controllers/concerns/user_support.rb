module UserSupport
  def current_member
    @current_member ||= find_current_member
  end

  private

  def find_current_member
    return nil unless current_user.present?
    member = current_account.memberships.by_user(current_user).first

    return member if member.present?
  end
end
