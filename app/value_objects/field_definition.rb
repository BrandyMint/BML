# Определение колонки в таблицы.
# TODO: Добавить тип колонки
class FieldDefinition
  include Virtus.value_object

  values do
    # TODO: Не понятно чем отличается key и item_key?
    attribute :key, Symbol
    attribute :item_key, String

    attribute :title, String
  end

  def persisted?
    false
  end

  def to_s
    title
  end
end
