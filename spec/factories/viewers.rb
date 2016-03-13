FactoryGirl.define do
  factory :viewer do
    uid { SecureRandom.uuid }
    landing
  end
end
