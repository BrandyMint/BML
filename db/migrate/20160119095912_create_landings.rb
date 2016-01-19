class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.references :account, index: true, foreign_key: true, null: false
      t.string :title, null: false
      t.timestamp :version

      t.timestamps null: false
    end

    add_column :accounts, :landings_count, :integer, null: false, default: 0
  end
end
