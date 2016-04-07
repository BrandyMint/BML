FactoryGirl.define do
  factory :collection do
    landing
    uuid { SecureRandom.uuid }
  end
end
