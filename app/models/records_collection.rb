class RecordsCollection < Collection
  has_many :leads, dependent: :delete_all

  def self.model_name
    superclass.model_name
  end
end
