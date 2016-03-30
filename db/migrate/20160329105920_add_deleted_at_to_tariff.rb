class AddDeletedAtToTariff < ActiveRecord::Migration
  def change
    add_column :tariffs, :deleted_at, :datetime
  end
end
