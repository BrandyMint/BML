# SmsWorker
class SmsWorker
  # Веритальная грамотя для отправки сообщения через SMSC
  class Credentials
    include Virtus.model

    # Аккаунт в рамках которого отправляется уведомление, может не указываться
    # если это системное сообщение
    attribute :account_id, Integer, default: nil

    # Логин для авторизации в SMSC
    attribute :login, String

    # Пароль для авторизации в SMSC
    attribute :password, String

    # Подставляется в качестве отправителя
    attribute :sender, String, default: nil

    def to_json_without_active_support_encoder(_options)
      to_json
    end
  end
end
