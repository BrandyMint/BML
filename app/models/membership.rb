class Membership < ActiveRecord::Base
  extend Enumerize

  ROLES = %I(owner manager).freeze
  DEFAULT_ROLE = :manager

  belongs_to :account
  belongs_to :user

  enumerize :role, in: ROLES, default: DEFAULT_ROLE, predicates: true
  validates :role, presence: true

  validates :user_id, uniqueness: { scope: :account_id }

  scope :by_user, ->(user) { where user_id: user.id }
end
