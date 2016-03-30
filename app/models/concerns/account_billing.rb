module AccountBilling
  extend ActiveSupport::Concern
  BILLING_CATEGORY = :accounts

  included do
    after_commit :billing_account, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    Openbill.current.account [BILLING_CATEGORY, id]
  end
end
