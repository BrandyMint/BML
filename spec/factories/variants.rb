FactoryGirl.define do
  factory :variant do
    landing
    uuid { SecureRandom.uuid }
  end
end
