class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :phone
      t.string :crypted_password
      t.string :salt
      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at
      t.datetime :email_confirmed_at
      t.datetime :phone_confirmed_at

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
    add_index :users, :remember_me_token
  end
end
