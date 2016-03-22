class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_inviter_id, null: false
      t.belongs_to :account, null: false
      t.string :key, null: false, index: true
      t.string :role, null: false, default: 'master'
      t.string :phone
      t.string :email

      t.timestamps null: false
    end

    add_foreign_key :invites, :users, column: :user_inviter_id
    add_foreign_key :invites, :accounts
    add_index :invites, [:email, :account_id], unique: true
    add_index :invites, [:account_id, :phone], unique: true
  end
end
