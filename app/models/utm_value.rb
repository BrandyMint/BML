class UtmValue < ActiveRecord::Base
  belongs_to :account
  belongs_to :landing
  belongs_to :variant

  scope :by_key_value, ->(key, value) { where('key_type = ? AND value ilike ?', key, "%#{value}%") }
end
