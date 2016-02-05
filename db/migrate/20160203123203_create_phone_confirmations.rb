class CreatePhoneConfirmations < ActiveRecord::Migration
  def change
    create_table :phone_confirmations do |t|
      t.string :phone, null: false
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.boolean :is_confirmed, null: false, default: false
      t.string :pin_code, null: false
      t.datetime :pin_requested_at
      t.datetime :confirmed_at

      t.timestamps null: false
    end
  end
end
