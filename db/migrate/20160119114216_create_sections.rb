class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :landing, index: true, foreign_key: true, null: false

      t.string :block_type, null: false
      t.string :block_view, null: false

      t.uuid :uuid, null: false

      t.hstore :data, null: false, default: {}

      t.timestamps null: false
    end

    add_column :landings, :sections_count, :integer, null: false, default: 0
  end
end
