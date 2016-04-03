class Entities::CollectionEntity < Grape::Entity
  expose :uuid
  expose :title

  expose :created_at, :updated_at
  expose :leads_count, as: :items_count
end
