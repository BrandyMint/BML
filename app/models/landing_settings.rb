class LandingSettings < FormBase
  include ActiveModel::Convariant
  attribute :domain, String
  attribute :title, String
end
