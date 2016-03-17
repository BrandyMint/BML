FactoryGirl.define do
  sequence :invite_phone do |n|
    "+790000000#{n}"
  end

  sequence :invite_email do |n|
    "email#{n}@email.com"
  end

  factory :invite do
    user_inviter { create :user, :with_account }
    account { user_inviter.accounts.first }
    email { generate :invite_email }
  end
end
