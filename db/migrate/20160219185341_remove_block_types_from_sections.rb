class RemoveBlockTypesFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :block_type
  end
end
