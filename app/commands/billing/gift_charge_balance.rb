module Billing
  # Ручное зачисление (админом) средств на баланс аккаунта
  class GiftChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    NS = :gift

    attribute :account, Account
    attribute :amount, Money
    attribute :description, String
    attribute :user, User

    def call
      Openbill.service.make_transaction(
        from: Billing.get_account_id(:gift),
        to: account.billing_account,
        key: [NS, account.ident, Time.current.beginning_of_hour.to_i].join(':'),
        amount: amount,
        details: description,
        meta: {
          user_id: user.try(:id)
        }
      )
    rescue => err
      Bugsnag.notify err, metaData: { account: account, amount: amount }
      raise err
    end
  end
end
