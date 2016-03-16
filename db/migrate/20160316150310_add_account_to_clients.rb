class AddAccountToClients < ActiveRecord::Migration
  def change
    add_reference :clients, :account, index: true, foreign_key: true, null: false
    add_reference :leads, :client, index: true, foreign_key: true

    add_column :accounts, :clients_count, :integer, null: false, default: 0

    add_index :clients, [:landing_id, :phone], unique: true
    add_index :clients, [:landing_id, :email], unique: true

    Lead.find_each do |lead|
      AttachClient.new(lead: lead).call
    end
  end
end
