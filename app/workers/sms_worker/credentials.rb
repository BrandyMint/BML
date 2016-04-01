class SmsWorker
  class Credentials
    include Virtus.model
    attribute :account_id, Integer

    attribute :login, String
    attribute :password, String
    attribute :sender, String

    def to_json_without_active_support_encoder(_options)
      to_json
    end
  end
end
