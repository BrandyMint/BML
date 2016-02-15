class RegistrationForm < FormBase
  attr_accessor :errors

  attribute :name
  attribute :email
  attribute :phone
  attribute :password

  def errors
    @errors ||= User.new.errors
  end
end
