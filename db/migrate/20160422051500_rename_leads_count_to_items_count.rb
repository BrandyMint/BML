class RenameLeadsCountToItemsCount < ActiveRecord::Migration
  def change
    rename_column :collections, :leads_count, :items_count
    rename_column :variants, :leads_count, :items_count
  end
end
