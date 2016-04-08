FactoryGirl.define do
  factory :collection do
    landing
    uuid { SecureRandom.uuid }
  end

  trait :with_columns do
    after :build do |collection|
      collection.columns << build_list(:column, 1)
    end
  end
end
