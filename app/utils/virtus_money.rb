# Virtus-атрибут для нормализации денег из параметра
# Например: '50,53' -> #<Money fractional:5053 currency:RUB>
class VirtusMoney < Virtus::Attribute
  def coerce(value)
    return unless value.present?
    Money.new (value.to_s.tr(',', '.').to_f * 100).to_i, :rub
  end
end
