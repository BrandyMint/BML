class Invite < ActiveRecord::Base
  include PhoneAndEmail
  include InviteActivation
  include InviteSends
  include DisableUpdate
  include MemberRoles

  INVITATION_ROLES = %w(master analyst guest).freeze

  belongs_to :user_inviter, class_name: 'User'
  belongs_to :account

  validates :role, inclusion: { in: INVITATION_ROLES }

  validates :email, presence: true, unless: :phone?
  validates :phone, uniqueness: { scope: :account_id }, allow_blank: true
  validates :phone, presence: true, unless: :email?
  validates :email, uniqueness: { scope: :account_id }, allow_blank: true

  scope :by_user, lambda { |user|
    case
    when user.phone.present? && user.email.present?
      where 'phone=? or email=? or key=?', user.phone, user.email, user.invite_key
    when user.phone.present?
      where 'phone=? or key=?', user.phone, user.invite_key
    when user.email.present?
      where 'email=? or key=?', user.email, user.invite_key
    else
      raise 'User without phone and email'
    end
  }

  scope :ordered, -> { order :id }

  before_create do
    self.key = SecureRandom.hex(5)
  end

  def url
    Rails.application.routes.url_helpers.new_user_url invite_key: key, host: AppSettings.host
  end
end
