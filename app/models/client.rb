class Client < ActiveRecord::Base
  belongs_to :landing, counter_cache: true
  belongs_to :account, counter_cache: true

  before_create do
    self.account = landing.account
  end
end
