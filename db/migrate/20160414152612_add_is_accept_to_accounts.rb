class AddIsAcceptToAccounts < ActiveRecord::Migration
  def change
    add_column :users, :is_accept, :boolean, null: false, default: false
    add_column :users, :is_subscribe, :boolean, null: false, default: false
  end
end
