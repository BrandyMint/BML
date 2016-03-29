module AccountBilling
  extend ActiveSupport::Concern

  included do
    after_commit :attach_billing, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    Openbill.current.account([:accounts, id])
  end
end
