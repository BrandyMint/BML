class AddLeadsCountToLandingVersions < ActiveRecord::Migration
  def change
    add_column :landing_versions, :leads_count, :integer, null: false, default: 0
    rename_column :collections, :items_count, :leads_count

    Collection.find_each do |c|
      Collection.reset_counters c.id, :items
    end

    Variant.table_name = :landing_versions
    Variant.find_each do |v|
      Variant.reset_counters v.id, :leads
    end
    Variant.table_name = :variants
  end
end
