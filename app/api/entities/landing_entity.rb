class Entities::LandingEntity < Grape::Entity
  expose :uuid, :title

  expose :created_at, :updated_at

  expose :versions_count
end
