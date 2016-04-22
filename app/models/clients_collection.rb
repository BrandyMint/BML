class ClientsCollection < Collection
  has_many :clients, dependent: :delete_all, foreign_key: :collection_id

  def self.model_name
    superclass.model_name
  end

  def client_name
    title
  end
end
