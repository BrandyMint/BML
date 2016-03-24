class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.string :title, null: false
      t.string :description
      t.string :slug, null: false, unique: true
      t.integer :price_per_month_cents, null: false, default: 0
      t.string :price_per_month_currency, null: false, default: 'RUB'
      t.integer :price_per_site_cents, null: false, default: 0
      t.string :price_per_site_currency, null: false, default: 'RUB'
      t.integer :price_per_lead_cents, null: false, default: 0
      t.string :price_per_lead_currency, null: false, default: 'RUB'
      t.integer :free_days_count, null: false, default: 0
      t.integer :free_leads_count, null: false, default: 0
      t.boolean :hidden, null: false, default: false

      t.timestamps null: false
    end
  end
end
