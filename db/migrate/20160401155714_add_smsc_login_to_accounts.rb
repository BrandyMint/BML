class AddSmscLoginToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :smsc_login, :string
    add_column :accounts, :smsc_password, :string
    add_column :accounts, :smsc_sender, :string
    add_column :accounts, :smsc_active, :boolean, default: false
  end
end
