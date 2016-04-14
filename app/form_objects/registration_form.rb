# Форма регистрации нового аккаунта
class RegistrationForm < FormBase
  attr_accessor :errors

  attribute :name
  attribute :email
  attribute :phone
  attribute :password
  attribute :is_accept, Boolean
  attribute :is_subscribe, Boolean

  def errors
    @errors ||= User.new.errors
  end
end
