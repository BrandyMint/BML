class Entities::VariantEntity < Grape::Entity
  expose :uuid
  expose :title do |lv, _0|
    lv.title.presence || lv.landing.head_title.presence || lv.landing.title
  end

  expose :created_at, :updated_at

  expose :sections, using: Entities::SectionEntity do |lv, _o|
    lv.sections.ordered
  end
end
