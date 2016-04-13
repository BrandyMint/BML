module Payments
  # Сущность карты для шлюзонезависимого ответа об успешной оплате
  class CardEntity
    include Virtus.value_object

    values do
      attribute :token, String
      attribute :card_first_six, String
      attribute :card_last_four, String
      attribute :card_type, String
      attribute :issuer_bank_country, String
      attribute :card_exp_date, String
      attribute :gateway, String
    end
  end
end
