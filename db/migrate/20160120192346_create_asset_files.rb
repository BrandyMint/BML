class CreateAssetFiles < ActiveRecord::Migration
  def change
    create_table :asset_files do |t|
      t.references :account, index: true, foreign_key: true, null: false
      t.references :landing, index: true, foreign_key: true, null: false
      t.references :landing_version, index: true, foreign_key: true, null: false
      t.string :file, null: false
      t.string :mime_type, null: false
      t.integer :width
      t.integer :height
      t.bigint :file_size, null: false

      t.timestamps null: false
    end
  end
end
