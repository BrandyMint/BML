module AccountBilling
  extend ActiveSupport::Concern

  included do
    after_commit :billing_account, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    Openbill.current.account([:accounts, id])
  end
end
