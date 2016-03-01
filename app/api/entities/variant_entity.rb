class Entities::VariantEntity < Grape::Entity
  expose :uuid, :title
  expose :created_at, :updated_at

  expose :sections, using: Entities::SectionEntity do |lv, _o|
    lv.sections.ordered
  end
end
