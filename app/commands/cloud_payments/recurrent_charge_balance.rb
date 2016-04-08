module CloudPayments
  # Рекуррентный платеж с сохраненной карты для пополнения баланса аккаунта через CloudPayments
  # Вызывается из воркеров
  class RecurrentChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    NS = :cloudpayments

    attribute :account, Account
    attribute :amount, Money

    def call
      resp = make_transaction
      charge_balance resp

    rescue CloudPayments::Client::ReasonedGatewayError => err
      key = err.class.name.demodulize.to_sym
      raise CloudPaymentsError, key
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
        gateway: :cloudpayments,
        transaction_id: resp.id
      ).call
    end

    def token
      account.payment_accounts.first.token
    end
  end
end
