module AccountBilling
  extend ActiveSupport::Concern
  BILLING_CATEGORY = :accounts

  included do
    after_commit :billing_account, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    Openbill.current.account billing_account_ident
  end

  def billing_transactions
    Openbill.current.account_transactions billing_account
  end

  private

  def billing_account_ident
    [BILLING_CATEGORY, id]
  end
end
