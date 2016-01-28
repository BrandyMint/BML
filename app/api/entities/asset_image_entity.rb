class Entities::AssetImageEntity < Grape::Entity
  expose :uuid
  expose :width
  expose :height
  expose :url
end
