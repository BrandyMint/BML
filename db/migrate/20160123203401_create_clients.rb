class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :landing, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :phone
      t.string :email

      t.timestamps null: false
    end

    add_column :landings, :clients_count, :integer, null: false, default: 0
  end
end
