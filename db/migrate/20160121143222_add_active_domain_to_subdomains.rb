class AddActiveDomainToSubdomains < ActiveRecord::Migration
  def change
    add_column :subdomains, :active_domain, :string, null: false
    add_column :subdomains, :use_domain, :boolean, null: false, default: false
    add_column :subdomains, :confirmed_domain, :string
    add_column :subdomains, :suggested_domain, :string

    add_column :subdomains, :current_domain, :string, null: false

    change_table :subdomains do |t|
      t.references :landing, :refernces, foreign_key: true, unique: true, null: false
    end
    remove_column :subdomains, :account_id
  end
end
