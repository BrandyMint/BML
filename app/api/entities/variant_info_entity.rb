class Entities::VariantInfoEntity < Grape::Entity
  expose :uuid
  expose :usable_title, as: :title

  expose :created_at, :updated_at

  expose :sections_count
end
