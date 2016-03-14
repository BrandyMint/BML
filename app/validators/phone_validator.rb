class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if Phoner::Phone.valid? value

    msg = options[:message] || I18n.t('errors.phone_validator.invalid_phone')
    record.errors.add attribute, msg
  end
end
