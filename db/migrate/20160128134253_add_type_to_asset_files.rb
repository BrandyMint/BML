class AddTypeToAssetFiles < ActiveRecord::Migration
  def change
    add_column :asset_files, :type, :string, null: false

    change_column :asset_files, :landing_id, :integer, null: true
    change_column :asset_files, :landing_version_id, :integer, null: true

    execute('alter table asset_files add column uuid uuid not null default uuid_generate_v4()');
  end
end
