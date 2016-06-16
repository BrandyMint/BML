class RemigrateOpenbillAccounts < ActiveRecord::Migration
  def change
    Billing.recreate_system_accounts

    Account.find_each(&:billing_account)
  end
end
