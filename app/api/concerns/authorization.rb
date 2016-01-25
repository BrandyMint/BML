module Authorization
  extend ActiveSupport::Concern

  included do
    helpers do
      def current_account
        @_current_account ||= Account.find_by_access_key params[:access_key]
      end
    end

    before do
      error!({ message: '401 Unknown account', code: 401 }, 401) unless current_account.present?
    end
  end
end
