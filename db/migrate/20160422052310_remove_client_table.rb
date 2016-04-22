class RemoveClientTable < ActiveRecord::Migration
  def up
    remove_column :leads, :client_id
    add_column :leads, :type, :string, default: 'Lead', null: false
    drop_table :clients
    add_column :leads, :client_id, :integer
    rename_table :leads, :collection_items
    Lead.find_each { |lead| AttachClient.new(lead: lead).call }
  end

  def down
    create_table :clients
    remove_column :leads, :type
  end
end
