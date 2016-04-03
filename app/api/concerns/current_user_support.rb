module CurrentUserSupport
  extend ActiveSupport::Concern
  include ApiSession

  included do
    helpers do
      def current_user
        User.find_by_id session[:user_id]
      end

      def authorize(resource)
        member = find_member resource.account
        Pundit.policy(member, resource) || raise("No policy for #{resource.class}")
      end

      def find_member(account)
        member = account.memberships.by_user(current_user).first
        raise NotAuthorized unless member.present?

        member
      end
    end

    before do
      error!({ message: "#{NotAuthenticated::HTTP_STATE} User is not authenticated", code: NotAuthenticated::HTTP_STATE }, NotAuthenticated::HTTP_STATE) unless current_user.present?
    end
  end
end
