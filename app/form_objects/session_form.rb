class SessionForm < FormBase
  attribute :login,     String
  attribute :password,  String
  attribute :remember_me

  validates :login, :password, presence: true

  def login
    format_login super
  end

  private

  def format_login(value)
    return value if value.blank?
    if value.include? '@'
      EmailUtils.clean_email value
    else
      PhoneUtils.clean_phone value
    end
  end
end
