class User < ActiveRecord::Base
  authenticates_with_sorcery!
  include UserConfirmation
  include UserPasswordReset
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :phone_confirmations, autosave: true, dependent: :delete_all

  validates :name, :email, presence: true
  validates :phone, phone: true, uniqueness: true, allow_blank: true
  validates :email, email: true, uniqueness: true
  validates :password, confirmation: true

  def default_account
    accounts.first || raise("User #{id} has no accounts")
  end

  def to_s
    name
  end

  def phone=(value)
    if value.present?
      super PhoneUtils.clean_phone value
    else
      super nil
    end
  end

  def email=(value)
    if value.present?
      super EmailUtils.clean_email value
    else
      super value
    end
  end
end
