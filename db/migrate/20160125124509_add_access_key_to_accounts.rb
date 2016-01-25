class AddAccessKeyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :access_key, :string

    Account.find_each do |a|
      a.send :generate_access_key
      a.save!
    end

    change_column :accounts, :access_key, :string, null: false

    add_index :accounts, :access_key, unique: true
  end
end
