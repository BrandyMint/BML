class CreatePaymentAccounts < ActiveRecord::Migration
  def change
    create_table :payment_accounts do |t|
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.string :card_first_six, null: false
      t.string :card_last_four, null: false
      t.string :card_type, null: false
      t.string :issuer_bank_country
      t.text :token, null: false
      t.string :card_exp_date, null: false

      t.timestamps null: false
    end

    add_index :payment_accounts, :token, unique: true
  end
end
