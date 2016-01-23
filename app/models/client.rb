class Client < ActiveRecord::Base
  belongs_to :landing, counter_cache: true
end
