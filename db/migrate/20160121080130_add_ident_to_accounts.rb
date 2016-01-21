class AddIdentToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :ident, :string

    Account.find_each do |a|
      a.send :generate_ident
      a.save!
    end

    change_column :accounts, :ident, :string, null: false

    add_index :accounts, [:ident], unique: true
  end
end
