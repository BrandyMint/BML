class RenameCollectionFieldsToColumns < ActiveRecord::Migration
  def change
    rename_table :collection_fields, :columns
  end
end
