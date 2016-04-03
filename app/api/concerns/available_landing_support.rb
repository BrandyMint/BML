module AvailableLandingSupport
  extend ActiveSupport::Concern
  include CurrentUserSupport

  included do
    helpers do
      def available_landing
        landing = Landing.find_by_uuid(params[:landing_uuid]) || raise(ParentNotFound)

        raise NotAuthorized unless authorize(landing).read?

        landing
      end
    end
  end
end
