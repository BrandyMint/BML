class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :account, index: true, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.text :auth_hash, null: false

      t.timestamps null: false
    end

    add_index :authentications, [:provider, :uid, :account_id], unique: true
  end
end
