class Entities::VariantEntity < Grape::Entity
  expose :uuid
  expose :usable_title, as: :title

  expose :created_at, :updated_at

  expose :sections, using: Entities::SectionEntity do |lv, _o|
    lv.sections.ordered
  end
end
