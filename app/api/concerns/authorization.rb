module Authorization
  extend ActiveSupport::Concern

  included do
    helpers do
      def current_account
        @_current_account ||= Account.find_by_access_key api_key
      end

      def api_key
        params[:api_key]  || headers['X-Api-Key']
      end
    end

    before do
      error!({ message: '401 Unknown account', code: 401 }, 401) unless current_account.present?
    end
  end
end
