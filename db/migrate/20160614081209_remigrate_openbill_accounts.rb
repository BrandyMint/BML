class RemigrateOpenbillAccounts < ActiveRecord::Migration
  def change
    Billing.recreate_system_accounts

    pb = ProgressBar.create total: Account.count

    Account.find_each do |v|
      pb.increment
      v.billing_account
    end
  end
end
