class Client < CollectionItem
  has_many :leads, foreign_key: :client_id

  before_save :clear

  def fields
    data_fields
  end

  def to_s
    collection.get_client_name + ': ' + name
  end

  def title
    to_s
  end

  private

  def clear
    self.client_id = nil
  end
end
