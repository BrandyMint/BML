class AddViewerUidToLead < ActiveRecord::Migration
  def change
    add_column :leads, :viewer_uid, :string, index: true
    add_foreign_key :leads, :viewers, column: :viewer_uid, primary_key: :uid
  end
end
