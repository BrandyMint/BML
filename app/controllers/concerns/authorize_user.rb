module AuthorizeUser
  extend ActiveSupport::Concern

  included do
    before_action :authorize_user
  end

  def authorize_user
    raise NotAuthenticated unless current_user.present?
  end
end
