Openbill.config.database =
  ActiveRecord::Base.connection.instance_variable_get('@config')

SystemRegistry = Openbill::Registry.new Openbill.current do |registry|
  registry.define :payments,      'Счет с которого поступает оплата'
  registry.define :subscriptions, 'Абонентская плата'
end
