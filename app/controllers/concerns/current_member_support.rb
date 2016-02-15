module CurrentMemberSupport
  extend ActiveSupport::Concern

  included do
    helper_method :current_member
  end
end
