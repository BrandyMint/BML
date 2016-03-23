module AccountAccessKey
  extend ActiveSupport::Concern

  TEST_ACCESS_KEY = 'test';
  TEST_ACCOUNT_ID = 2;

  included do
    before_create :generate_access_key

    def self.find_by_access_key(access_key)
      if Rails.env.development? && access_key == TEST_ACCESS_KEY
        Account.find TEST_ACCOUNT_ID
      else
        super access_key
      end
    end
  end


  private

  def generate_access_key
    self.access_key ||= SecureRandom.hex 16
  end
end
