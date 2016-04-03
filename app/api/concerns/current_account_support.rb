module CurrentAccountSupport
  extend ActiveSupport::Concern
  include ApiSession

  TEST_ACCESS_KEY = 'test'.freeze
  TEST_ACCOUNT_ID = 2

  included do
    helpers do
      def test?
        Rails.env.development? && api_key == TEST_ACCESS_KEY
      end

      def find_test_account
        Account.find(TEST_ACCOUNT_ID)
      end

      def current_account
        @_current_account ||= find_account
      end

      def find_account
        if api_key.present?
          return find_test_account if test?
          Account.find_by_access_key api_key
        elsif session[:account_id].present?
          Account.find session[:account_id]
        end
      end

      def api_key
        params[:api_key] || headers['X-Api-Key']
      end
    end

    before do
      error!({ message: '401 Unknown account', code: 401 }, 401) unless current_account.present?
    end
  end
end
