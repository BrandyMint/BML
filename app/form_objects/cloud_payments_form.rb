# Форма единоразового пополнения баланса аккаунта через CloudPayments
class CloudPaymentsForm < FormBase
  attribute :amount_cents, String
  attribute :amount_currency, String
  attribute :name, String
  attribute :recurrent, Boolean, default: false
  attribute :cryptogram_packet, String

  # эти атрибуты никогда не должны приходить от пользователя
  # нужны только для вывода формы
  attribute :cardNumber, String
  attribute :expDateMonth, String
  attribute :expDateYear, String
  attribute :cvv, String

  validates :amount_cents, :amount_currency, :name, :cryptogram_packet, presence: true
  validates :amount, numericality: { greater_than: 0 }

  def amount
    @_amount ||= amount_cents.to_money(amount_currency)
  end
end
