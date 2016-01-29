class ChangeAccountIdInAssetFiles < ActiveRecord::Migration
  def change
    change_column :asset_files, :account_id, :integer, null: true
  end
end
