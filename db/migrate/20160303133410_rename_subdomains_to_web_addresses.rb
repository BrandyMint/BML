class RenameSubdomainsToWebAddresses < ActiveRecord::Migration
  def change
    rename_table :subdomains, :web_addresses
  end
end
