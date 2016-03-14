class DomainValidator < ActiveModel::Validator
  def validate(record)
    fields = options[:attributes]
    fields.each do |field|
      validate_field(record, field)
    end
  end

  private

  def validate_field(record, field_name)
    value = record.send field_name

    return if value.blank?

    record.errors[field_name] << I18n.t('errors.messages.no_www') if value.start_with? 'www.'

    return if PublicSuffix.valid? SimpleIDN.to_unicode value
    record.errors[field_name] << I18n.t('errors.messages.invalid_domain')
  end
end
