module AccountBilling
  extend ActiveSupport::Concern

  included do
    after_commit :attach_billing, on: :create
  end

  delegate :amount, to: :billing_account

  def billing_account
    find_billing || attach_billing
  end

  private

  def account_uri
    Openbill.generate_uri :accounts, id
  end

  def find_billing
    Openbill.current.get_account_by_uri account_uri
  end

  def attach_billing
    Openbill.current.create_account account_uri
  end
end
