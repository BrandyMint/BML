class LandingSettings < FormBase
  include ActiveModel::Conversion
  attribute :domain, String
  attribute :title, String
end
