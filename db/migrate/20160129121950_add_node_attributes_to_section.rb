class AddNodeAttributesToSection < ActiveRecord::Migration
  def change
    add_column :sections, :node_attributes, :hstore, default: {}
    rename_column :sections, :data_serialized, :content
    add_column :sections, :background_attributes, :hstore

    add_column :asset_files, :digest, :string, null: false

    add_index :asset_files, [:account_id, :digest], unique: true
  end
end
