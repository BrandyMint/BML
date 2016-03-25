class AddIsBoxedToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :is_boxed, :boolean, null: false, default: true
    add_column :variants, :theme_name, :string
  end
end
