module Billing
  class PaymentChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    NS = :payments

    attribute :account, Account
    attribute :amount, Money
    attribute :gateway, String
    attribute :transaction_id, String

    def call
      Openbill.current.make_transaction(
        from: SystemRegistry[:payments],
        to: account.billing_account,
        key: [NS, gateway, account.ident, transaction_id].join(':'),
        amount: amount,
        details: 'Пополнение баланса',
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
