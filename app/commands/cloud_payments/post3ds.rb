module CloudPayments
  # Обработка 3D Secure:
  # Отправляет полученные после редиректа ключи транзакции
  # и получает ответ о проведенной операции
  class Post3ds
    include Virtus.model(strict: true, nullify_blank: true)

    attribute :md, String
    attribute :pa_res, String

    def call
      CloudPayments.client.payments.post3ds(md, pa_res)

    rescue CloudPayments::Client::ReasonedGatewayError => err
      key = err.class.name.demodulize.to_sym
      raise CloudPaymentsError, key
    end
  end
end
