module CloudPayments
  # Единоразовый платеж
  # Вызывается при пополнении баланса через Account::CloudPaymentsController
  class OneTimePayment
    include Virtus.model(strict: true, nullify_blank: true)

    attribute :session
    attribute :account, Account
    attribute :form, CloudPaymentsForm
    attribute :ip, String

    def call
      raise Payments::InvalidForm unless form.valid?

      handle_response make_transaction

    rescue CloudPayments::Client::ReasonedGatewayError => err
      key = err.class.name.demodulize.to_sym
      raise CloudPaymentsError, key
    end

    private

    def make_transaction
      CloudPayments.client.payments.cards.charge(
        amount: form.amount.to_f,
        currency: form.amount.currency.iso_code,
        account_id: account.ident,
        ip_address: ip,
        name: form.name,
        card_cryptogram_packet: form.cryptogram_packet
      )
    end

    def handle_response(resp)
      return handle_3ds(resp) if resp.required_secure3d?
      resp
    end

    def handle_3ds(resp)
      # Сохраняем в сессию флаг рекуррентности, потому что дальше следует редирект
      session[Payments::CLOUDPAYMENTS_SAVE_CARD_KEY] = form.recurrent?
      raise Payments::Secure3dRedirect, resp
    end
  end
end
