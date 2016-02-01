class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships

  validates :name, :email, presence: true
  validates :phone, phone: true, allow_blank: true
  validates :email, email: true, uniqueness: true

  before_save :prepare_email

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

  private

  def prepare_email
    self.email = email.downcase.strip.chomp
  end
end
