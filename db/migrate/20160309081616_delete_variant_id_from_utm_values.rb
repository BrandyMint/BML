class DeleteVariantIdFromUtmValues < ActiveRecord::Migration
  def change
    remove_column :utm_values, :variant_id
  end
end
