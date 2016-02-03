class User < ActiveRecord::Base
  include UserConfirmation

  authenticates_with_sorcery!
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :phone_confirmations, autosave: true

  validates :name, :email, presence: true
  validates :phone, phone: true, uniqueness: true, allow_blank: true
  validates :email, email: true, uniqueness: true
  validates :password, confirmation: true

  def phone=(value)
    if value.present?
      super PhoneUtils.clean_phone value
    else
      super nil
    end
  end

  def email=(value)
    if value.present?
      super value.downcase.strip.chomp
    else
      super value
    end
  end
end
