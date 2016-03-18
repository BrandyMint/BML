FactoryGirl.define do
  sequence :user_name do |n|
    "User#{n}"
  end

  sequence :user_phone do |n|
    "+790000000#{n}"
  end

  sequence :user_email do |n|
    "email#{n}@email.com"
  end

  factory :user do
    name  { generate :user_name }
    email { generate :user_email }
    phone { generate :user_phone }
    password 'password'
    email_confirm_token 'confirm_token'

    trait :confirmed do
      after :create do |user|
        user.update_columns phone_confirmed_at: Time.zone.now, email_confirmed_at: Time.zone.now
      end
    end

    trait :with_account do
      after(:create) do |user|
        account = create :account
        user.memberships.create! account_id: account.id, role: :owner
      end
    end
  end
end
