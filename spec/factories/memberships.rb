FactoryGirl.define do
  factory :membership do
    account
    user

    trait :confirmed do
      user do
        create :user, :confirmed
      end
    end
  end
end
