FactoryGirl.define do
  sequence :user_phone do |n|
    "+790000000#{n}"
  end

  sequence :user_email do |n|
    "email#{n}@email.com"
  end

  factory :user do
    name "MyString"
email { generate :user_email }
phone { generate :user_phone }
password '123'
  end

end
