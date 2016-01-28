class Entities::SectionEntity < Grape::Entity
  expose :uuid
  expose :created_at, :updated_at

  expose :data
  expose :block_type, as: :type
  expose :block_view, as: :view
end
