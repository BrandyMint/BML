class DeleteVariantIdFromUtmValues < ActiveRecord::Migration
  def up
    if UtmValue.columns.map(&:name).include?('variant_id')
      remove_column :utm_values, :variant_id
    end
  end

  def down
    # do nothing
  end
end
