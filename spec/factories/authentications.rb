FactoryGirl.define do
  factory :authentication do
    account nil
    provider 'MyString'
    uid 'MyString'
    auth_hash 'MyText'
  end
end
