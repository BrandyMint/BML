class UsedPeriodResult
  include Virtus.value_object

  values do
    attribute :ratio, Float
    attribute :used_days, Integer
    attribute :period_days, Integer
  end
end
