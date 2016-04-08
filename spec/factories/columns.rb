FactoryGirl.define do
  sequence :column_key do |n|
    "column#{n}"
  end

  sequence :column_title do |n|
    "column#{n}"
  end

  factory :column do
    collection
    key { generate :column_key }
    title { generate :column_title }
  end
end
