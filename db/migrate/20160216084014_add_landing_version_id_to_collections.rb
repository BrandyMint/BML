class AddLandingVersionIdToCollections < ActiveRecord::Migration
  def change
    add_reference :collections, :landing_version, index: true, foreign_key: true
    add_reference :collection_items, :landing_version, index: true, foreign_key: true
  end
end
