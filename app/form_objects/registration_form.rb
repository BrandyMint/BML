# Форма регистрации нового аккаунта
class RegistrationForm < FormBase
  attr_accessor :errors

  attribute :name
  attribute :email
  attribute :phone
  attribute :password
  attribute :is_accept, Boolean, default: false
  attribute :is_subscribe, Boolean, default: false

  validates :is_accept, acceptance: true

  def errors
    @errors ||= User.new.errors
  end
end
