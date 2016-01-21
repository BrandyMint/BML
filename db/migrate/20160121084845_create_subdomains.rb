class CreateSubdomains < ActiveRecord::Migration
  def change
    create_table :subdomains do |t|
      t.string :subdomain, null: false
      t.string :zone, null: false
      t.references :account, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :subdomains, [:zone, :subdomain], unique: true
  end
end
