class AddMetasToLandings < ActiveRecord::Migration
  def change
    add_column :landings, :head_title, :string
    add_column :landings, :meta_description, :text
    add_column :landings, :meta_keywords, :text
  end
end
