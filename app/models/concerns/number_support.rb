module NumberSupport
  extend ActiveSupport::Concern

  included do
    before_create :generate_public_number
    before_create :set_number
  end

  private

  def generate_public_number
    self.public_number = SecureRandom.hex(4).upcase
  end

  def set_number
    self.number ||= collection.next_number
  end
end
