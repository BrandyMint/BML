class RemoveLandingIdFromSubdomains < ActiveRecord::Migration
  def change
    remove_column :subdomains, :landing_id
  end
end
