class Membership < ActiveRecord::Base
  extend Enumerize
  include MemberRoles

  belongs_to :account
  belongs_to :user

  validates :user_id, uniqueness: { scope: :account_id }

  scope :with_sms_notification, -> { joins(:user).where.not(users: { phone_confirmed_at: nil }).where(sms_notification: true) }
  scope :with_email_notification, -> { joins(:user).where.not(users: { email_confirmed_at: nil }).where(email_notification: true) }

  scope :by_user, ->(user) { where user_id: user.id }
end
