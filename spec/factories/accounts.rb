FactoryGirl.define do
  factory :account do
    after :build do |account|
      account.class.skip_callback(:commit, :after, :billing_account)
    end

    trait :with_billing do
      after :build do |account|
        account.class.set_callback(:commit, :after, :billing_account)
      end
    end

    trait :root do
      ident { Account::ROOT_IDENT }
      after :create do |account|
        create :landing, account: account, path: '/'
      end
    end
  end
end
