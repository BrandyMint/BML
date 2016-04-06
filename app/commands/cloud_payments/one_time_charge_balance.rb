module CloudPayments
  # Единоразовый платеж для пополнения баланса аккаунта через CloudPayments
  # Опционально сохраняет токен карты для рекуррентных платежей
  class OneTimeChargeBalance
    include Virtus.model(strict: true, nullify_blank: true)

    CLOUDPAYMENTS_ERRORS_NAMESPACE = 'CloudPayments::Client::GatewayErrors::'.freeze

    InvalidForm = Class.new StandardError
    NS = :cloudpayments

    attribute :account, Account
    attribute :form, BalancePaymentForm
    attribute :ip, String

    def call
      raise InvalidForm unless form.valid?

      resp = make_transaction
      charge_balance resp
      store_card_if_needed resp

    rescue => err
      if err.class.name.start_with? CLOUDPAYMENTS_ERRORS_NAMESPACE
        key = err.class.name.gsub(CLOUDPAYMENTS_ERRORS_NAMESPACE, '').to_sym
        raise CloudPaymentsError, key
      end
      raise err
    end

    private

    def make_transaction
      CloudPayments.client.payments.cards.charge(
        amount: form.amount_money.to_f,
        currency: form.amount_money.currency.iso_code,
        account_id: account.ident,
        ip_address: ip,
        name: form.name,
        card_cryptogram_packet: form.cryptogram_packet
      )
    end

    def charge_balance(resp)
      Billing::PaymentChargeBalance.new(
        account: account,
        amount: form.amount_money,
        gateway: :cloudpayments,
        transaction_id: resp.id
      ).call
    end

    def store_card_if_needed(resp)
      return unless form.recurrent?
      return if account.payment_accounts.by_token(resp.token).any?

      attrs = resp.to_hash.slice(:token, :card_first_six, :card_last_four, :card_type, :issuer_bank_country, :card_exp_date)
      account.payment_accounts.create! attrs
    end
  end
end
