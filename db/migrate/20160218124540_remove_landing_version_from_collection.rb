class RemoveLandingVersionFromCollection < ActiveRecord::Migration
  def change
    remove_column :collections, :landing_version_id, :integer
  end
end
