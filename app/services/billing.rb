module Billing
  CLOUDPAYMENTS_ACCOUNT_URI = Openbill.generate_uri :system, :payments
  SUBSCRIPTION_ACCOUNT_URI  = Openbill.generate_uri :system, :subscription

  class << self
    def cloudpayments_account
      Openbill.get_account_by_uri(CLOUDPAYMENTS_ACCOUNT_URI) || Openbill.create_account(
        CLOUDPAYMENTS_ACCOUNT_URI,
        details: 'Счет с которого поступает оплата'
      )
    end

    def subscription_account
      Openbill.get_account_by_uri(SUBSCRIPTION_ACCOUNT_URI) || Openbill.create_account(
        SUBSCRIPTION_ACCOUNT_URI,
        details: 'Счет абонентской платы'
      )
    end
  end
end
