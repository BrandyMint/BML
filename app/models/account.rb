class Account < ActiveRecord::Base
  has_many :landings
  has_many :collections

  before_create :generate_ident

  def to_s
    "Аккаунт #{id}"
  end

  def subdomain
    id.to_s
  end

  private

  def generate_ident
    self.ident ||= SecureRandom.hex(4)
  end
end
