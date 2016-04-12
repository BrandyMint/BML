class AddIsRequiredToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :is_required, :boolean, null: false, default: false
  end
end
