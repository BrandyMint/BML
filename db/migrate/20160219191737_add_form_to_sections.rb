class AddFormToSections < ActiveRecord::Migration
  def change
    add_column :sections, :form, :text
  end
end
