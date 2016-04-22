class LeadsCollection < Collection
  has_many :leads, dependent: :delete_all, foreign_key: :collection_id

  def self.model_name
    superclass.model_name
  end
end
