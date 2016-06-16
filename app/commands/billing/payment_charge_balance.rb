module Billing
  # Зачисление средств на баланс аккаунта с помощью платежа
  class PaymentChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    DETAILS = 'Пополнение баланса'.freeze

    attribute :account, Account
    attribute :amount, Money
    attribute :gateway, Symbol
    attribute :transaction_id, String

    def call
      Openbill.service.make_transaction(
        from: Billing.get_account_id(gateway),
        to: account.billing_account,
        key: [:payments, gateway, transaction_id].join(':'),
        amount: amount,
        details: "#{DETAILS} #{transaction_id} gateway: #{gateway}",
        meta: {
          gateway: gateway,
          transaction_id: transaction_id
        }
      )
    rescue => err
      Bugsnag.notify err, metaData: { account: account, amount: amount, gateway: gateway, transaction_id: transaction_id }
      raise err
    end
  end
end
