FactoryGirl.define do
  sequence :path do |n|
    "/path#{n}"
  end

  factory :landing do
    account
    path { generate :path }
    title 'some'

    trait :with_variant do
      after :create do |landing|
        landing.variants.create!
      end
    end
  end
end
