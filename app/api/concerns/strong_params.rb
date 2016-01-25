module StrongParams
  extend ActiveSupport::Concern

  included do
    helpers do
      def strong_params
        ActionController::Parameters.new params
      end
    end
  end
end
