class RenameLandingVersionsToVariants < ActiveRecord::Migration
  def change
    rename_table :landing_versions, :variants
    rename_column :asset_files, :landing_version_id, :variant_id

    rename_column :collection_items, :landing_version_id, :variant_id
    rename_column :sections, :landing_version_id, :variant_id

    rename_column :landings, :versions_count, :variants_count
  end
end
