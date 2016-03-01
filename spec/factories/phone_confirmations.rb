FactoryGirl.define do
  sequence :phone_confirmation_phone do |n|
    "+790000000#{n}"
  end

  factory :phone_confirmation do
    phone { generate :phone_confirmation_phone }
    user

    trait :confirmed do
      is_confirmed true
      confirmed_at { Time.zone.now }
    end
  end
end
