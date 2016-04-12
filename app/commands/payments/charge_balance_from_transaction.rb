module Payments
  # Пополнение баланса аккаунта по ответу об успешной оплате
  # Опционально сохраняет токен карты для рекуррентных платежей
  class ChargeBalanceFromTransaction
    include Virtus.model

    attribute :account, Account
    attribute :transaction, TransactionEntity
    attribute :card, CardEntity

    def call
      charge_balance
      save_card
    end

    private

    def charge_balance
      Billing::PaymentChargeBalance.new(
        account: account,
        amount: transaction.amount,
        gateway: transaction.gateway,
        transaction_id: transaction.id
      ).call
    end

    def save_card
      return unless card.present?
      return if account.payment_accounts.by_token(card.token).any?

      account.payment_accounts.create! card.to_hash
    end
  end
end
