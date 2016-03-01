class Entities::LandingEntity < Grape::Entity
  expose :uuid, :title

  expose :created_at, :updated_at

  expose :variants_count
end
