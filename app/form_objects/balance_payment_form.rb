class BalancePaymentForm < FormBase
  attribute :amount, VirtusMoney
  attribute :name, String
  attribute :recurrent, Boolean, default: false
  attribute :cryptogram_packet, String

  # эти атрибуты никогда не должны приходить от пользователя
  # нужны только для вывода формы
  attribute :cardNumber, String
  attribute :expDateMonth, String
  attribute :expDateYear, String
  attribute :cvv, String

  validates :amount, :name, :cryptogram_packet, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
