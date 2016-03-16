class AddUniqueIndexToUtmvalues < ActiveRecord::Migration
  def change
    UtmValue.delete_all
    add_index :utm_values, [:landing_id, :key_type, :value], unique: true
  end
end
