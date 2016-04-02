module Authorization
  extend ActiveSupport::Concern

  TEST_ACCESS_KEY = 'test'.freeze
  TEST_ACCOUNT_ID = 2

  included do
    helpers do
      def test?
        Rails.env.development? && api_key == TEST_ACCESS_KEY
      end

      def find_test_account
        Variant.find_by_uuid(params[:uuid]).try(:account) ||
          Account.find(TEST_ACCOUNT_ID)
      end

      def current_account
        return find_test_account if test?
        @_current_account ||= Account.find_by_access_key api_key
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
