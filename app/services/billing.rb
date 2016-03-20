module Billing
  PAYMENTS_SOURCE_ACCOUNT_URI = Openbill.generate_uri :system, :payments

  class << self
    def payments_source
      Openbill.get_account_by_uri(PAYMENTS_SOURCE_ACCOUNT_URI) || Openbill.create_account(
        PAYMENTS_SOURCE_ACCOUNT_URI,
        details: 'Счет с которого поступает оплата'
      )
    end
  end
end
