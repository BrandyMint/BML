module CloudPayments
  # Рекуррентный платеж с сохраненной карты для пополнения баланса аккаунта через CloudPayments
  # Вызывается из воркеров
  class RecurrentChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    attribute :account, Account
    attribute :amount, Money

    MAX_SUBTRACT_SUM = Money.new(10_000_00, :rub)

    def call
      raise LargeAmountError if amount > MAX_SUBTRACT_SUM
      resp = make_transaction
      charge_balance resp

    rescue CloudPayments::Client::ReasonedGatewayError => err
      key = err.class.name.demodulize.to_sym
      raise CloudPaymentsError, key

    rescue LargeAmountError => err
      Bugsnag.notify err, metaData: { account: account, amount: amount }
      raise err
    end

    private

    def make_transaction
      CloudPayments.client.payments.tokens.charge(
        amount: amount.to_f,
        currency: amount.currency.iso_code.upcase,
        account_id: account.ident,
        token: token
      )
    end

    def charge_balance(resp)
      Billing::PaymentChargeBalance.new(
        account: account,
        amount: amount,
        gateway: gateway,
        transaction_id: resp.id
      ).call
    end

    def token
      account.payment_accounts.where(gateway: gateway).first.token
    end

    def gateway
      Payments::CLOUDPAYMENTS_GATEWAY_KEY
    end
  end
  LargeAmountError = Class.new StandardError
end
