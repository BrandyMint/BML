class SessionForm < FormBase
  attribute :email
  attribute :password
  attribute :remember_me

  validates :email, presence: true, email: true
  validates :password, presence: true
end
