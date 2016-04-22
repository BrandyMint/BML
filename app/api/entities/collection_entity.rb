class Entities::CollectionEntity < Grape::Entity
  expose :uuid
  expose :title

  expose :created_at, :updated_at
  expose :items_count
end
