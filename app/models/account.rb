class Account < ActiveRecord::Base
  def to_s
    "Аккаунт #{id}"
  end

  def subdomain
    id.to_s
  end
end
