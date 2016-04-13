module Payments
  # Сущность транзакции для шлюзонезависимого ответа об успешной оплате
  class TransactionEntity
    include Virtus.value_object

    values do
      attribute :gateway, String
      attribute :id, String
      attribute :amount, Money
    end
  end
end
