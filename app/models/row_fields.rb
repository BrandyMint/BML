# Это кусо модели завяки или любой другой записи
# в коллекции, который содержит динамичеснкие поля (значения и тип)
#

class RowFields < Set
  def initialize(data)
    @data = data
    super data.map do |k, v|
      LeadField.new key: k, value: v
    end
  end

  def [](key)
    find do |field|
      field.key == key
    end
  end

  private

  attr_reader :data
end
