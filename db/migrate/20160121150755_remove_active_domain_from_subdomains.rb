class RemoveActiveDomainFromSubdomains < ActiveRecord::Migration
  def up
    remove_column :subdomains, :active_domain
    remove_column :subdomains, :refernces_id
  end

  def down
    add_column :subdomains, :active_domain, :string
     add_column :subdomains, :refernces_id, :integer
  end
end
