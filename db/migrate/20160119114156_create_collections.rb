class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :landing, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
