FactoryGirl.define do
  factory :viewer do
    uid { SecureRandom.uuid }
  end
end
