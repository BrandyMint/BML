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

    trait :with_collection do
      after :create do |landing|
        landing.collections << build_list(:collection, 1, :with_columns)
      end
    end
  end
end
