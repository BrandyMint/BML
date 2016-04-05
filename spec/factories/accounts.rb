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

    trait :with_payment_account do
      transient do
        payment_token '123'
      end
      after :create do |account, opts|
        account.payment_accounts.create! token: opts.payment_token,
                                         card_first_six: '123456',
                                         card_last_four: '9999',
                                         card_type: 'visa',
                                         card_exp_date: '01/30'
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
