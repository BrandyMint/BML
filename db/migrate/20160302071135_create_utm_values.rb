class CreateUtmValues < ActiveRecord::Migration
  def change
    create_table :utm_values do |t|
      t.belongs_to :account, index: true, foreign_key: true, null: false
      t.belongs_to :landing, index: true, foreign_key: true, null: false
      t.belongs_to :variant, null: false
      t.string :key_type, index: true, null: false
      t.string :value, index: true, null: false

      t.timestamps null: false
    end

    add_index :utm_values, [:variant_id, :key_type, :value], unique: true
    add_foreign_key :utm_values, :variants
  end
end
