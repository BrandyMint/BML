class CreateTariffMonths < ActiveRecord::Migration
  def change
    create_table :tariff_months do |t|
      t.references :account, index: true, foreign_key: true, null: false
      t.references :tariff, index: true, foreign_key: true, null: false
      t.date :beginning_of_month, null: false
      t.date :end_of_month, null: false

      t.timestamps null: false
    end

    execute 'alter table tariff_months add constraint month check(end_of_month > beginning_of_month)'

    add_index :tariff_months, [:account_id, :tariff_id, :beginning_of_month], unique: true, name: :tariff_months_unique
  end
end
