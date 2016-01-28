class Account < ActiveRecord::Base
  include AccountAccessKey
  include AccountIdent

  has_many :landings,    dependent: :destroy
  has_many :collections, dependent: :destroy

  has_many :versions, through: :landings

  has_many :authentications, dependent: :destroy

  def to_s
    "Аккаунт #{id}"
  end

  def subdomain
    AccountConstraint::DOMAIN_PREFIX + ident
  end

  def api_key
    access_key
  end
end
