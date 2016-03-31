module AccountIdent
  extend ActiveSupport::Concern

  included do
    before_update :restrict_ident_changes
    before_create :generate_ident
  end

  private

  def restrict_ident_changes
    raise "Can't change ident" if ident_changed?
  end

  def generate_ident
    self.ident ||= SecureRandom.hex(4)
  end
end
