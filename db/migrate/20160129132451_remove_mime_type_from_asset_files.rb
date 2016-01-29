class RemoveMimeTypeFromAssetFiles < ActiveRecord::Migration
  def change
    remove_column :asset_files, :mime_type
  end
end
