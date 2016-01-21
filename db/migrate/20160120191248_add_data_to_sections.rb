class AddDataToSections < ActiveRecord::Migration
  def change
    remove_column :sections, :data
    add_column :sections, :data_serialized, :text
    add_column :sections, :row_order, :integer, null: false, default: 0

    add_index :sections, [:landing_version_id, :row_order]
  end
end
