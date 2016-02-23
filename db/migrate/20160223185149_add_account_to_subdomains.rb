class AddAccountToSubdomains < ActiveRecord::Migration
  def change
    add_reference :subdomains, :account, index: true, foreign_key: true
  end
end
