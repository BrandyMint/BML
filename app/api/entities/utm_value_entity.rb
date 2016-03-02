class Entities::UtmValueEntity < Grape::Entity
  expose :id
  expose :value, as: :text
end
