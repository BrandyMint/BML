
# Неймспейс биллинга
module Billing
  SYSTEM_CATEGORY_ID  = '12832d8d-43f5-499b-82a1-3466cadcd809'.freeze
  CLIENTS_CATEGORY_ID = '12832d8d-43f5-499b-82a1-3466cadcd801'.freeze

  SYSTEM_ACCOUNTS = {
    subscriptions: '12832d8d-43f5-499b-82a1-3466cadcd701',
    cloudpayments: '12832d8d-43f5-499b-82a1-3466cadcd702',
    gift:          '12832d8d-43f5-499b-82a1-3466cadcd703'
  }.freeze

  SYSTEM_ACCOUNTS_DETAILS = {
    subscriptions: 'Списание абонентской платы',
    cloudpayments: 'Зачисление оплаты через шлюз Cloudpayments на клиентский счет',
    gift:          'Бонусное зачисление'
  }.freeze

  def self.get_account_id(key)
    SYSTEM_ACCOUNTS[key.to_sym] || raise("No such account #{key}")
  end

  def self.recreate_system_accounts
    Openbill.service.create_category 'System', id: SYSTEM_CATEGORY_ID
    Openbill.service.create_category 'Клиенты', id: CLIENTS_CATEGORY_ID

    # Создаем системные аккаунты
    SYSTEM_ACCOUNTS.keys.each do |key|
      Openbill.service.create_account key, id: SYSTEM_ACCOUNTS[key], category_id: SYSTEM_CATEGORY_ID, details: SYSTEM_ACCOUNTS_DETAILS[key]
    end

    # Создаем правила перечисления
    db = Openbill.service.db
    db.execute 'DELETE FROM OPENBILL_POLICIES'

    # Списания
    [:subscriptions].each do |key|
      Rails.logger.info key
      db.execute "INSERT INTO OPENBILL_POLICIES (name, from_category_id, to_account_id) VALUES ('#{SYSTEM_ACCOUNTS_DETAILS[key]}', '#{CLIENTS_CATEGORY_ID}', '#{SYSTEM_ACCOUNTS[key]}')"
    end

    # Зачисления
    [:gift, :cloudpayments].each do |key|
      Rails.logger.info key
      db.execute "INSERT INTO OPENBILL_POLICIES (name, to_category_id, from_account_id) VALUES ('#{SYSTEM_ACCOUNTS_DETAILS[key]}', '#{CLIENTS_CATEGORY_ID}', '#{SYSTEM_ACCOUNTS[key]}')"
    end
  end
end
