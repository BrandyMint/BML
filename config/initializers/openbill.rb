begin

  Openbill.configure do |config|
    config.default_currency = 'RUB'
    config.database = ActiveRecord::Base.connection.instance_variable_get('@config')
  end

  SystemRegistry = Openbill::Registry.new Openbill.current do |registry|
    registry.define :payments,      'Счет с которого поступает оплата'
    registry.define :subscriptions, 'Абонентская плата'
  end

  # Когда база еще не готова, не расстраиваемся
rescue Sequel::DatabaseError => err
  Rails.logger.error err
end
