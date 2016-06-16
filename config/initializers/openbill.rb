begin
  Openbill.configure do |config|
    config.default_currency = 'RUB'
    config.database = ActiveRecord::Base.connection.instance_variable_get('@config')
  end
rescue Sequel::DatabaseError => err
  Rails.logger.error err
end
