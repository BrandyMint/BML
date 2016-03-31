class GiftTopUpBalance
  include Virtus.model(strict: true, nullify_blank: true)

  attribute :account, Account
  attribute :amount, Money

  def call
    Openbill.current.make_transaction(
      from: SystemRegistry[:gift],
      to: account.billing_account,
      key: "gift-#{account.id}-#{Time.current.beginning_of_hour.to_i}",
      amount: amount,
      details: 'Ручное зачисление',
      meta: {}
    )
  rescue => err
    Bugsnag.notify err, metaData: { account: account, amount: amount }
    raise err
  end
end
