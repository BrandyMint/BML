FactoryGirl.define do
  factory :landing_version do
    landing
    uuid { SecureRandom.uuid }
  end
end
