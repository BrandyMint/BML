module AuthorizeMember
  extend ActiveSupport::Concern

  included do
    before_action :authorize_member
  end

  private

  def authorize_member
    raise NotAuthorized unless current_member.present?
  end
end
