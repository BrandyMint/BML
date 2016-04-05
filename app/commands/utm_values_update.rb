# Сохраняет уникальные значения utm-меток в рамках одного лендинга для вывода в подсказках фильтра
class UtmValuesUpdate
  include Virtus.model

  attribute :lead, Lead

  def call
    upsert
  end

  private

  def upsert
    # TODO: Проверить что правильно делать если нет utm меток или они есть не все.
    return unless values.present?
    ActiveRecord::Base.connection.execute "INSERT INTO #{UtmValue.table_name} (#{payload.join(', ')}) VALUES #{values.join(', ')} ON CONFLICT DO NOTHING"
  end

  def payload
    [
      :account_id,
      :landing_id,
      :key_type,
      :value,
      :created_at,
      :updated_at
    ]
  end

  def values
    utm_fields.map do |f|
      v = get_field_values(f).join(', ')
      "(#{v})"
    end
  end

  def get_field_values(field)
    time = Time.zone.now
    [
      lead.landing.account_id,
      lead.landing_id,
      field.key,
      lead.send(field.item_key),
      time.to_s(:db),
      time.to_s(:db)
    ].map { |v| "'#{v}'" }
  end

  def utm_fields
    TrackingSupport::UTM_FIELD_DEFINITIONS.select { |f| lead.send(f.item_key).present? }
  end
end
