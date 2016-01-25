module AccountAccessKey
  extend ActiveSupport::Concern

  included do
    before_create :generate_access_key
  end

  private

  def generate_access_key
    self.access_key ||= SecureRandom.hex 16
  end
end
