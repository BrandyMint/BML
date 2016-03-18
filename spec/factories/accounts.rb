FactoryGirl.define do
  factory :account do
    trait :root do
      ident { Account::ROOT_IDENT }
      after :create do |account|
        create :landing, account: account, path: '/'
      end
    end
  end
end
