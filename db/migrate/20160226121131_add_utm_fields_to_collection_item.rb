class AddUtmFieldsToCollectionItem < ActiveRecord::Migration
  def change
    add_column :collection_items, :first_utm_source, :string
    add_column :collection_items, :first_utm_campaign, :string
    add_column :collection_items, :first_utm_medium, :string
    add_column :collection_items, :first_utm_term, :string
    add_column :collection_items, :first_utm_content, :string
    add_column :collection_items, :first_referer, :string
    add_column :collection_items, :last_utm_source, :string
    add_column :collection_items, :last_utm_campaign, :string
    add_column :collection_items, :last_utm_medium, :string
    add_column :collection_items, :last_utm_term, :string
    add_column :collection_items, :last_utm_content, :string
    add_column :collection_items, :last_referer, :string
  end
end
