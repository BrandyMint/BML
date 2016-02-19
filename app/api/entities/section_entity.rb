class Entities::SectionEntity < Grape::Entity
  expose :uuid
  expose :created_at, :updated_at

  expose :content
  expose :form
  expose :background_image, as: :backgroundImage, using: API::Entities::AssetImageEntity
  expose :background_attributes, as: :background
  expose :node_attributes, as: :nodeAttributes
  expose :meta
  expose :block_view, as: :view
end
