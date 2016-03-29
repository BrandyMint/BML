class CreateTariffChanges < ActiveRecord::Migration
  def change
    create_table :tariff_changes do |t|
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.integer :from_tariff_id, null: false
      t.integer :to_tariff_id, null: false
      t.datetime :activates_at, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_foreign_key :tariff_changes, :tariffs, column: :from_tariff_id
    add_foreign_key :tariff_changes, :tariffs, column: :to_tariff_id
    add_index :tariff_changes, [:activates_at, :account_id], unique: true
  end
end
