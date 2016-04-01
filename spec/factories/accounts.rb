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

    trait :with_smsc do
      smsc_login 'login'
      smsc_password 'password'
      smsc_active { true }
    end

    trait :root do
      ident { Account::ROOT_IDENT }
      after :create do |account|
        landing = create :landing, account: account, path: '/'
        landing.variants.create!
      end
    end
  end
end
