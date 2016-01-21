class Subdomain < ActiveRecord::Base
  belongs_to :account

  validates :zone, presence: true, inclusion: Settings.subdomain_zones
  validates :subdomain, presence: true, uniqueness: { scope: :zone }
end
