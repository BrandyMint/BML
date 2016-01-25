module AccountIdent
  extend ActiveSupport::Concern

  included do
    before_create :generate_ident
  end

  private

  def generate_ident
    self.ident ||= SecureRandom.hex(4)
  end
end
