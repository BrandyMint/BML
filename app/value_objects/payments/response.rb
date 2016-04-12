module Payments
  # Шлюзонезависимый ответ об успешной оплате
  # Используется для пополнения баланса и сохранения карты
  class Response
    include Virtus.value_object

    attribute :transaction, TransactionEntity
    attribute :card, CardEntity

    def self.build_from_gateway_response(response, gateway, save_card)
      new(
        transaction: transaction(response, gateway),
        card: card(response, gateway, save_card)
      )
    end

    def self.transaction(response, gateway)
      TransactionEntity.new(
        gateway: gateway,
        id: response.id,
        amount: response.amount.to_money(response.currency)
      )
    end

    def self.card(response, gateway, save_card)
      return unless save_card
      CardEntity.new(**response, gateway: gateway)
    end
  end
end
