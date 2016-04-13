# Это кусо модели завяки или любой другой записи
# в таблицы, который содержит динамичеснкие поля (значения и тип)
#

class RowFields < Set
  NotFound = Class.new StandardError

  def initialize(columns, data)
    @data = data
    super data.map do |k, v|
      LeadField.new key: k, value: v, column: columns.find_by_key(k)
    end
  end

  def [](key)
    key = key.key if key.is_a? Column
    find do |field|
      field.key == key.to_sym
    end
  end

  def get(key)
    self[key] || raise(NotFound, key)
  end

  private

  attr_reader :data
end
