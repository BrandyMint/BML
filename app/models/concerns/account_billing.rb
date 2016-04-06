module AccountBilling
  extend ActiveSupport::Concern
  BILLING_CATEGORY = :accounts

  included do
    after_commit :billing_account, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    binding.pry
    Openbill.current.account billing_account_ident
  end

  def billing_transactions
    binding.pry
    Openbill.current.account_transactions billing_account
  end

  def needs_recurrent_charge?
    has_debt? && payment_accounts.any?
  end

  # rubocop:disable Style/PredicateName
  def has_debt?
    amount.to_i < 0
  end

  private

  def billing_account_ident
    [BILLING_CATEGORY, id]
  end
end
