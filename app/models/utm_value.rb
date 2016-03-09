class UtmValue < ActiveRecord::Base
  belongs_to :account
  belongs_to :landing
  belongs_to :variant
end
