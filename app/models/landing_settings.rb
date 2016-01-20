class LandingSettings < FormBase
  include ActiveModel::Conversion
  attribute :domain, String
end
