class CreateCollectionFields < ActiveRecord::Migration
  def change
    create_table :collection_fields do |t|
      t.belongs_to :collection, null: false
      t.string :key, null: false
      t.string :title

      t.timestamps null: false
    end

    add_index :collection_fields, [:collection_id, :key], unique: true
    add_foreign_key :collection_fields, :collections
  end
end
