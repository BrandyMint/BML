# Результат расчета периода пользования аккаунтом
# ratio - коэффициент от 0.0 до 1.0 для списания абонплаты за неполный период
# (отношение использованных дней к общему кол-ву дней периода)
class UsedPeriodResult
  include Virtus.value_object

  values do
    attribute :ratio, Float
    attribute :used_days, Integer
    attribute :period_days, Integer
  end
end
