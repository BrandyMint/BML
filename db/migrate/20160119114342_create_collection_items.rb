class CreateCollectionItems < ActiveRecord::Migration
  def change
    enable_extension "hstore"
    create_table :collection_items do |t|
      t.references :collection, index: true, foreign_key: true
      t.hstore :data

      t.timestamps null: false
    end

    add_column :collections, :items_count, :integer, null: false, default: 0
  end
end
