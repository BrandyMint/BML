module CurrentMember
  extend ActiveSupport::Concern

  included do
    helper_method :current_member
  end

  private

  def current_member
    @current_member ||= find_current_member
  end

  def find_current_member
    return nil unless current_user.present?
    member = current_account.memberships.by_user(current_user).first

    return member if member.present?
  rescue NoCurrentAccount
    nil
  end
end
