class Membership < ActiveRecord::Base
  extend Enumerize

  ROLES = %I(owner manager)
  DEFAULT_ROLE = :manager

  belongs_to :account
  belongs_to :user

  enumerize :role, in: ROLES, default: DEFAULT_ROLE, predicates: true
  validates :role, presence: true
end
