module PhoneAndEmail
  extend ActiveSupport::Concern

  included do
    strip_attributes

    scope :by_email, ->(email) { where email: EmailUtils.clean_email(email) }
    scope :by_phone, ->(phone) { where phone: PhoneUtils.clean_phone(phone) }
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
