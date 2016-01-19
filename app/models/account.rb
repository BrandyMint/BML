class Account < ActiveRecord::Base
  has_many :landings
  has_many :collections

  def to_s
    "Аккаунт #{id}"
  end

  def subdomain
    id.to_s
  end
end
