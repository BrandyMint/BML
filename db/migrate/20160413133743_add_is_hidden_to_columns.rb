class AddIsHiddenToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :is_hidden, :boolean, null: false, default: false
  end
end
