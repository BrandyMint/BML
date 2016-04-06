module Billing
  # Списание абонентской платы с баланса аккаунта по тарифу за указанный месяц
  class WithdrawSubscriptionFee
    include Virtus.model(strict: true, nullify_blank: true)

    NS = :subscription

    attribute :account, Account
    attribute :tariff, Tariff
    attribute :month, Date

    def call
      Openbill.current.make_transaction(
        from: account.billing_account,
        to: SystemRegistry[:subscriptions],
        key: [NS, account.ident, month].join(':'),
        amount: fee.total,
        details: fee.description,
        meta: {
          gateway: :cloudpayments,
          month: month,
          tariff_id: tariff.id
        }
      )
    rescue => err
      Bugsnag.notify err, metaData: { fee: fee, account: account, tariff: tariff, month: month }
      raise err
    end

    private

    def fee
      @_fee ||= fee_strategy.new(account: account, tariff: tariff, month: month).call
    end

    def fee_strategy
      case tariff.slug
      when Tariff::BASE_SLUG
        PerLandingFeeStrategy
      end
    end
  end
end
