# Результат расчета платы за период пользования аккаунтом с описанием
class FeeResult
  include Virtus.value_object

  values do
    attribute :total, Money
    attribute :description, String
  end
end
