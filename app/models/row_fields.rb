# Это кусо модели завяки или любой другой записи
# в коллекции, который содержит динамичеснкие поля (значения и тип)
#

class RowFields < Set
  NotFound = Class.new StandardError

  def initialize(data)
    @data = data
    super data.map do |k, v|
      LeadField.new key: k, value: v
    end
  end

  def [](key)
    key = key.key if key.is_a? CollectionField
    find do |field|
      field.key == key
    end
  end

  def get(key)
    self[key] || raise(NotFound, key)
  end

  private

  attr_reader :data
end
