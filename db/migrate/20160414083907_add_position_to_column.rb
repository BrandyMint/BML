class AddPositionToColumn < ActiveRecord::Migration
  def change
    add_column :columns, :position, :integer, null: false, default: 0
  end
end
