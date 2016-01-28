class AddBackgroundImageToSections < ActiveRecord::Migration
  def change
    add_column :sections, :background_image_id, :integer, index: true
    add_foreign_key :sections, :asset_files, column: :background_image_id
  end
end
