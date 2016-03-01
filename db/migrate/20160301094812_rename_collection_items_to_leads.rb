class RenameCollectionItemsToLeads < ActiveRecord::Migration
  def change
    rename_table :collection_items, :leads
  end
end
