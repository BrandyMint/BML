class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.references :landing, index: true, foreign_key: true
      t.string :title, null: false

      t.timestamps null: false
    end

    add_column :landings, :segments_count, :integer, null: false, default: 0
  end
end
