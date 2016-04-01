class CreateAccountSmsLogEntities < ActiveRecord::Migration
  def change
    create_table :account_sms_log_entities do |t|
      t.references :account, index: true, foreign_key: true
      t.string :smsc_login
      t.string :smsc_sender
      t.string :message
      t.string :phones, array: true
      t.string :result, null: false

      t.timestamps null: false
    end

    add_column :accounts, :sms_log_entities_count, :integer, null: false, default: 0
  end
end
