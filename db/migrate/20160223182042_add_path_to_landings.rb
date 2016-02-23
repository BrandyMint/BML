class AddPathToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :path, :string

    Landing.find_each do |l|
      l.update_column :path, SecureRandom.hex(4)
    end

    change_column :landings, :path, :string, null: false

    add_index :landings, [:account_id, :path], unique: true
  end
end
