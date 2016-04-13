class AddGatewayToPaymentAccount < ActiveRecord::Migration
  def change
    add_column :payment_accounts, :gateway, :string
    execute("UPDATE payment_accounts SET gateway = 'cloudpayments'")
    change_column :payment_accounts, :gateway, :string, null: false
  end
end
