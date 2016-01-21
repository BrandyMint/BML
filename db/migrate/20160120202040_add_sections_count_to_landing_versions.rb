class AddSectionsCountToLandingVersions < ActiveRecord::Migration
  def change
    add_column :landing_versions, :sections_count, :integer, null: false, default: 0
  end
end
