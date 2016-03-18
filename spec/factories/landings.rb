FactoryGirl.define do
  sequence :path do |n|
    "/path#{n}"
  end

  factory :landing do
    account
    path { generate :path }
    title 'some'
  end
end
