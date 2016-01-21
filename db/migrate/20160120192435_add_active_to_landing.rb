class AddActiveToLanding < ActiveRecord::Migration
  def change
    add_column :landings, :is_active, :boolean, null: false, default: true
    add_column :landing_versions, :is_active, :boolean, null: false, default: true
  end
end
