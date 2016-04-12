class Entities::SectionEntity < Grape::Entity
  expose :uuid
  expose :created_at, :updated_at

  expose :content
  expose :form, if: -> (s, o) { s.form.present? || o[:clear].blank? }
  expose :background_image, as: :backgroundImage, using: Entities::AssetImageEntity, if: -> (s, o) { s.background_image.present? || o[:clear].blank? }
  expose :background_attributes, as: :background, if: -> (s, o) { s.background_attributes.present? || o[:clear].blank? }
  expose :node_attributes, as: :nodeAttributes, if: -> (s, o) { s.node_attributes.present? || o[:clear].blank? }
  expose :meta, if: -> (s, o) { s.meta.present? || o[:clear].blank? }
  expose :block_view, as: :viewName

  # Данные в разном формате для разных блоков
  expose :data
end
