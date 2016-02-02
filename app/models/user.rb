class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships

  validates :name, :email, presence: true
  validates :phone, phone: true, uniqueness: true, allow_blank: true
  validates :email, email: true, uniqueness: true

  def email_confirm
    update_column :email_confirmed_at, Time.zone.now
  end

  def phone_confirm
    update_column :phone_confirmed_at, Time.zone.now
  end

  def email_confirmed?
    email_confirmed_at.present?
  end

  def phone_confirmed?
    phone_confirmed_at.present?
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
      super value.downcase.strip.chomp
    else
      super value
    end
  end
end
